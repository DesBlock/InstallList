#!/bin/bash

#Color variables
BLUE='\033[1;34m'
NC='\033[0m'
#Create and run update script
if [ ! -f ./UpdateScript.sh ]; then
        echo -e "${BLUE}Update script not found: Creating and Running."
        echo "#!/bin/bash" >> UpdateScript.sh
        echo "apt update && apt full-upgrade -y && apt autoremove -y" >> UpdateScript.sh
        chmod +x ./UpdateScript.sh
else
        echo -e "${BLUE}Update script found: Running"
fi
./UpdateScript.sh

#Apt install packages
echo -e "${BLUE}Installing Apt packages${NC}"

: <<'Comment'
Tools installed:
Git
Python 3.6
Shellcheck - Tool to check syntax of bashscripts
Comment

apt install git python3.6 shellcheck


#Git files
echo -e "${BLUE}Cloning Git files to /opt/ directory.${NC}"
#Unicorn
git clone https://github.com/trustedsec/unicorn.git /opt/unicorn
#PowerSploit
git clone https://github.com/PowerShellMafia/PowerSploit.git /opt/powersploit
#Empire
git clone https://github.com/EmpireProject/Empire.git /opt/empire
/opt/empire/setup/install.sh
#Empyre
#git clone https://github.com/EmpireProject/EmPyre.git /opt/empyre
#/opt/empyre/setup/install.sh
#PSInject
#git clone https://github.com/EmpireProject/PSInject.git /opt/psinject

#Find statement to locate git file and pull updates.
if [ ! -f ./GitUpdater.sh ];then
        echo -e "${BLUE}Git update script not found: Creating and Running${NC}"
        echo "#!/bin/bash">>GitUpdater.sh
        echo 'find /opt/ -name .git -printf "%h:\t\t\t" -execdir git pull \;'>>GitUpdater.sh
        chmod +x ./GitUpdater.sh
else
        echo -e "${BLUE}Git update script found:Running${NC}"
fi
./GitUpdater.sh
