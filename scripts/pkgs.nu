# List the packages a host installs, according to this flake.
#
# Tiers:
#   explicit  listed in this repo
#   enabled   added by an upstream module this repo enabled (programs.*.enable, services.*.enable, ...)
#   implicit  NixOS / Home-Manager defaults (hidden unless --all)
#
# In nushell, `use scripts/pkgs.nu` to get a `pkgs` command that returns a table.

const flake = path self ..

export def main [
  host: string = "" # nixosConfiguration name (default: current hostname)
  --all (-a) # include implicit packages
  --scope (-s): string # only show one scope: system, system-fonts, home:<user>
  --count (-c) # Get count of pkgs
  --json # print raw JSON instead of a table
] {
    let host = if ($host | is-empty) {
        sys host | get hostname
    } else {
        $host
    }
    let rows = (
    ^nix eval --json $"($flake)#lib.packageReports.($host)" --quiet
    | from json
    | where {|r| ($scope == null) or ($r.scope == $scope) }
  )
    let shown = $rows | where {|r| $all or $r.tier != "implicit" }

    if $json {
        $shown | to json
    } else if $count {
        let counts = $rows | group-by tier | transpose tier rows | each {|g| { tier: $g.tier count: ($g.rows | length) } }
        let count = {|t|
            $counts | where tier == $t | get count.0? | default 0
        }
        let hidden = if $all { "" } else { " (hidden, use --all)" }

        print $"(do $count explicit) explicit · (do $count enabled) enabled · (do $count implicit) implicit($hidden)"
    } else {
        $shown
        | sort-by scope from name
        | select scope from name version tier
    }
}
