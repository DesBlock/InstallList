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

#Git files
echo -e "${BLUE}Cloning Git files to /opt/ directory.${NC}"
#Unicorn
git clone https://github.com/trustedsec/unicorn.git /opt/unicorn
#PowerSploit
git clone https://github.com/PowerShellMafia/PowerSploit.git /opt/powersploit
#Empire
git clone https://github.com/EmpireProject/Empire.git /opt/empire
#Empyre
git clone https://github.com/EmpireProject/EmPyre.git /opt/empyre
#PSInject
git clone https://github.com/EmpireProject/PSInject.git /opt/psinject

echo -e "${BLUE}Installing Apt packages${NC}"

#Shellcheck tool
apt install shellcheck

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
