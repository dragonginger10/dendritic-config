set quiet := true
alias s := switch
host := `hostname`

default: check

fmt:
    nix fmt .

flake:
    nix run ".#write-flake"

check: flake fmt
    nix flake check

up:
    nix flake update

gc:
    sudo nh clean all > /dev/null 2>&1

test target=host: check
    nh os test -n .#{{target}}
    just gc

switch target=host: check
    exit 1
    nh os switch .#{{target}}

back:
    nh os rollback
