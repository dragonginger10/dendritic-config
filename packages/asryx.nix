# package.nix
{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  ninja,
  pkg-config,
  makeWrapper,
  git,
  # Runtime dependencies
  pipewire,
  alsa-utils,
  wl-clipboard,
  xclip,
  libnotify,
  # Optional: choose audio/clipboard backend
  withPipewire ? true,
  withAlsa ? true,
  withWayland ? true,
  withX11 ? true,
}:

let
  # Pin whisper.cpp version - update this hash to match the pinned commit
  # used by asryx's install script (check scripts/install for WHISPER_CPP_SHA)
  whisper-cpp-src = fetchFromGitHub {
    owner = "ggml-org";
    repo = "whisper.cpp";
    # TODO: Replace with the exact pinned commit from asryx's install script
    # Check: grep -i 'sha\|commit\|pin' scripts/install
    rev = "v1.8.6";
    hash = "sha256-gwf1wQM4tgW/qfSZzV1tJ0cB7kONeLN/5g3mSfyvbCo=";
  };
  pname = "asryx";
  version = "1.8.6"; # Update to match actual version/tag
in
stdenv.mkDerivation rec {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "rccyx";
    repo = "asryx";
    # TODO: Pin to a specific commit or tag
    rev = "v${version}";
    hash = "sha256-XbIoAHcYidoihPQlc0FOR6URB4hm0HnOColPhXp+M2c=";
  };

  nativeBuildInputs = [
    cmake
    ninja
    pkg-config
    makeWrapper
    git
  ];

  # whisper.cpp needs to be available at build time
  # The project builds whisper.cpp as an embedded library
  postUnpack = ''
    # Place whisper.cpp source where the build system expects it
    cp -r ${whisper-cpp-src} $sourceRoot/whisper.cpp
    chmod -R a+rw $sourceRoot/whisper.cpp
  '';

  #If the project uses a Makefile instead of CMake at the top level,
  #override the build phase:
  buildPhase = ''
    runHook preBuild

    # Build whisper.cpp as a static library first
    cmake -S whisper.cpp -B whisper.cpp/build \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=OFF \
      -DWHISPER_BUILD_EXAMPLES=OFF \
      -DWHISPER_BUILD_TESTS=OFF

    # Build asryx linking against whisper.cpp
    cmake -S ${src} -B build  \
      -DASRYX_WHISPER_SOURCE_DIR=whisper.cpp

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    install -Dm755 build/asryx $out/bin/asryx
    runHook postInstall
  '';

  cmakeFlags = [
    "-GNinja"
    # If the project has a CMakeLists.txt that references whisper.cpp path:
    "-DWHISPER_CPP_DIR=whisper.cpp"
  ];

  # # Wrap the binary to ensure runtime tools are available in PATH
  # postFixup = let
  #   runtimePath = lib.makeBinPath (
  #     lib.optionals withPipewire [ pipewire ]
  #     ++ lib.optionals withAlsa [ alsa-utils ]
  #     ++ lib.optionals withWayland [ wl-clipboard ]
  #     ++ lib.optionals withX11 [ xclip ]
  #     ++ [ libnotify ]
  #   );
  # in ''
  #   wrapProgram $out/bin/asryx \
  #     --prefix PATH : "${runtimePath}"
  # '';

  meta = with lib; {
    description = "Native C++ ASR binary for Linux using whisper.cpp";
    longDescription = ''
      asryx is a native C++ ASR binary for Linux. It builds locally against a
      pinned whisper.cpp source tree, records audio through the active Linux
      audio stack, runs recognition in-process, writes the transcript to the
      active clipboard backend, emits desktop notifications, and removes
      runtime artifacts after completion.

      The program is a simple toggle: first invocation starts recording,
      second invocation stops, transcribes, and copies to clipboard.
    '';
    homepage = "https://github.com/rccyx/asryx";
    license = licenses.asl20;
    platforms = platforms.linux;
    maintainers = with lib.maintainers; [ dragonginger ];
    mainProgram = "asryx";
  };
}
