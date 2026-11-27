{ self, lib, ... }:
let
  inherit (lib)
    attrByPath
    concatMap
    findFirst
    hasPrefix
    mapAttrs
    mapAttrsToList
    removeSuffix
    splitString
    unique
    ;

  repo = toString self;

  # Resolve mkIf / mkMerge / mkOverride / mkOrder wrappers in a raw definition.
  unwrap =
    v:
    let
      t = v._type or null;
    in
    if t == "if" then
      (if v.condition then unwrap v.content else [ ])
    else if t == "merge" then
      concatMap unwrap v.contents
    else if t == "override" || t == "order" then
      unwrap v.content
    else
      [ v ];
  valuesOf =
    def: concatMap (x: if builtins.isList x then concatMap unwrap x else [ x ]) (unwrap def.value);

  fromRepo = file: hasPrefix repo file;

  # "…/features/shell/environment.nix, via option flake.modules.nixos.environment" -> "environment"
  featureOf =
    file:
    let
      m = builtins.match ".*, via option flake\\.modules\\.[^.]+\\.\"?([^\"]+)\"?" file;
    in
    if m != null then builtins.head m else removeSuffix ".nix" (lib.removePrefix "${repo}/" file);

  # Upstream module file -> candidate option paths that may have turned it on.
  # e.g. ".../modules/services/networking/firewall.nix" -> [ [services networking] [services firewall] ]
  candidatesOf =
    file:
    let
      m = builtins.match ".*/modules/(programs|services|hardware|virtualisation)/(.+)" file;
      kind = builtins.elemAt m 0;
      parts = map (removeSuffix ".nix") (splitString "/" (builtins.elemAt m 1));
    in
    if m == null then
      [ ]
    else
      map (p: [
        kind
        p
      ]) (lib.filter (p: p != "default") parts);

  # Feature name in this repo that enabled the upstream module defining `file`, or null.
  enablerOf =
    options: file:
    let
      repoDefs =
        path:
        let
          opt = attrByPath (path ++ [ "enable" ]) null options;
        in
        if opt ? definitionsWithLocations then
          lib.filter (d: fromRepo d.file && builtins.elem true (unwrap d.value)) opt.definitionsWithLocations
        else
          [ ];
      hit = findFirst (path: repoDefs path != [ ]) null (candidatesOf file);
    in
    if hit == null then null else featureOf (builtins.head (repoDefs hit)).file;

  safe =
    default: v:
    let
      r = builtins.tryEval v;
    in
    if r.success then r.value else default;

  pkgName = p: safe "?" (if lib.isDerivation p then lib.getName p else toString p);
  pkgVersion = p: safe "" (p.version or "");

  # Rows for one list option (`opt`), resolving "enabled" against `options`.
  rowsOf =
    scope: options: opt:
    concatMap (
      def:
      let
        enabler = if fromRepo def.file then null else enablerOf options def.file;
        tier =
          if fromRepo def.file then
            "explicit"
          else if enabler != null then
            "enabled"
          else
            "implicit";
        from =
          if fromRepo def.file then
            featureOf def.file
          else if enabler != null then
            enabler
          else
            lib.last (splitString "-source/" def.file);
      in
      map (p: {
        inherit scope tier from;
        name = pkgName p;
        version = pkgVersion p;
      }) (valuesOf def)
    ) opt.definitionsWithLocations;

  rank = {
    explicit = 0;
    enabled = 1;
    implicit = 2;
  };

  # Merge duplicate (scope, name) rows: keep the strongest tier, join sources.
  dedupe =
    rows:
    mapAttrsToList (
      _: group:
      let
        best = lib.foldl' (
          a: b: if rank.${b.tier} < rank.${a.tier} then b else a
        ) (builtins.head group) group;
      in
      best
      // {
        from = lib.concatStringsSep ", " (
          unique (map (r: r.from) (lib.filter (r: r.tier == best.tier) group))
        );
      }
    ) (lib.groupBy (r: "${r.scope}/${r.name}") rows);

  packageReport =
    cfg:
    let
      inherit (cfg) options;
      users =
        if options ? home-manager then
          mapAttrsToList (user: meta: {
            inherit user;
            inherit (meta.configuration) options;
          }) options.home-manager.users.valueMeta.attrs
        else
          [ ];
    in
    dedupe (
      rowsOf "system" options options.environment.systemPackages
      ++ rowsOf "system-fonts" options options.fonts.packages
      ++ concatMap (u: rowsOf "home:${u.user}" u.options u.options.home.packages) users
    );
in
{
  # `nix eval --json .#lib.packageReports.<host>` -> [ { name version scope tier from } ]
  # tier: explicit (listed in this repo) | enabled (upstream module enabled by this repo) | implicit
  flake.lib = {
    inherit packageReport;
    packageReports = mapAttrs (_: packageReport) self.nixosConfigurations;
  };
}
