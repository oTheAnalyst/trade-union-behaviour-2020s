ls
cd trade-union-behaviour-2020s/
git branch 
git branch -r
git switch flake-test 
ls -a
git status 
rm .bash_history 
git status 
git switch flake-test 
git add .
git commit -m "commiting data"
git switch flake-test 
clear
ls
nix develop .#
vflake flake.nix
nix develop .#
clear
git switch main 
git stash
git switch main
clear
ls
nix-shell 
