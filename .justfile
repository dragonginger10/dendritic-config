set quiet := true
alias s := switch
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
    sudo nh clean all > /dev/null 2>&1

test target=host: check
    nh os build -n .#{{target}}
    just gc

switch target=host: check
    nh os switch .#{{target}}

back:
    nh os rollback

home:
    nh home switch -c {{user}} --offline .
