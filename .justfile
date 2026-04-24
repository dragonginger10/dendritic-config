set quiet := true
alias s := switch
export NH_FLAKE := justfile_dir()
host := `hostname`
user := `whoami`

default: check

fmt:
    nix fmt .

flake:
    nix run ".#write-flake"

check: fmt flake
    nix flake check

up:
    nix flake update

gc:
    echo "Cleaning ..."
    sudo nh clean all > /dev/null 2>&1

test target=host: 
    nh os build --show-trace --dry --hostname {{target}}
    just gc

switch target=host: 
    #!/usr/bin/env bash
    echo "Formatting & Checking..."
    just check > /dev/null 2>&1 
    if [ $? -ne 0 ]; then
        echo -e "\e[31mCheck has failed\e[0m"
        exit 1
    fi
    echo "Nixos is building..."
    nh os switch --hostname {{target}} > /dev/null 2>&1

back:
    nh os rollback

home:
    nh home switch --configuration {{user}} --offline 

vm target=host:
    nh os build-vm --hostname {{target}} 
    ./result/bin/run-{{target}}-vm

[env("NIX_CONFIG", "experimental-features = nix-command flakes")]
bootstrap target:
    #!/usr/bin/env nix-shell 
    #! nix-shell -i bash --pure
    #! nix-shell -p nh 
    nh os boot --hostname {{target}}

image target: 
    nh os build-image --image-variant sdImage --hostname {{target}}
