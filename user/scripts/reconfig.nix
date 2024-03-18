{ config, pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "reconfig" ''
           function showProgress() {
             local command="$1"
             local commonName="$2"
             local FRAMES="/ | \\ -"
             local status=0
             local pid=0

             if [ $commonName == "System" ]; then
               #read -s -p "Enter sudo password: " sudo_password
               #echo "$sudo_password" | 
               sudo -A $command &> nixos-switch.log || (cat nixos-switch.log | grep --color error && false) & pid=$!
             else
               $command &> nixos-switch.log || (cat nixos-switch.log | grep --color error && false) & pid=$!
             fi

             while ps -p $pid > /dev/null; do
                   for frame in $FRAMES; do
                       printf "\r$frame Syncing $commonName configuration..."
                       sleep 0.2
                   done
                   if ! kill -0 $pid 2>/dev/null; then
                       wait $pid
                       status=$?
                       break
                   fi
               done

               if [ $status -eq 0 ]; then
                   printf "\r$GREEN✓$NC Syncing $commonName configuration...$GREEN [Success!]$NC\n"
               else
                   printf "\r$RED×$NC Syncing $commonName configuration...$RED [Failed!]$NC\n"
               fi
               printf "\n"
           }

           pushd ~/nixos-dotfiles &> /dev/null
           nvim .
           git diff -U0
           showProgress "home-manager switch --flake .#meatball" "Home-Manager"
           showProgress "nixos-rebuild switch --flake .#nixos-laptop" "System"
           rm nixos-switch.log
           gen=$(nixos-rebuild list-generations | grep current);
           git commit -am "$gen"
           popd &> /dev/null
    '')
  ];
}
