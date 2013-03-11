INSTALL=$1;
HOME=$2;

# Temporary PATH to get access into windev stage1 binary files
PATH="$(pwd)/bin";

warning() { echo "$@" 1>&2; }
error() { warning "$@"; exit 1; }

echo "";
echo "Installation directory: $INSTALL";
echo "User home directory: $HOME";
echo "Current PATH: $PATH";
echo "";

# "Normalized" path for user home directory
NP=$(echo "/$HOME" | sed -e "s/\\\/\//g" -e "s/://");
SNP=$(echo "\\$HOME" | sed -e "s/\\\/\\\\\//g" -e "s/://");

# "Normalized" path for unix binaries
# BP=$(echo "/$INSTALL" | sed -e "s/\\\/\//g" -e "s/://");

if [ ! -d "$INSTALL/windev" ]; then
    # Installing github ssh key, to get rid of ssh prompt - it's temporary, it will be removed when installator will clone windev-homedir
    mkdir $NP/.ssh/
    echo "github.com,207.97.227.239 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==" > ~/.ssh/known_hosts

    git clone https://github.com/tradero/windev-env.git "$INSTALL/windev"

    cat $INSTALL/windev/userdir/.bashrc | sed -e "s/%HOMEDIR%/$SNP/g" > bashrctmp; mv bashrctmp $INSTALL/windev/userdir/.bashrc;
else
    echo -n "Do you like to try to update your windev instance (yes/no)? "
    read answer

    if [ "$answer" == "yes" ]; then
        echo "One second...";
        cd "$INSTALL/windev";
        git pull origin master;
        echo "Thanks ;-)";
    else
        echo "Ok, bye.";
    fi

    exit;
fi

# installing exe files for: nodejs, python, ruby, php

echo "";
echo "I think you should grab some coffee now, or something ;-)";
echo "";

mkdir $NP/install;
echo "Downloading NodeJS...";
curl http://nodejs.org/dist/v0.9.8/node-v0.9.8-x86.msi > ~/install/node-v0.9.8-x86.msi;
echo "Downloading Python...";
curl http://www.python.org/ftp/python/3.3.0/python-3.3.0.msi > ~/install/python-3.3.0.msi;
echo "Downloading PHP...";
curl http://windows.php.net/downloads/releases/php-5.3.22-nts-Win32-VC9-x86.msi > ~/install/php-5.3.22-nts-Win32-VC9-x86.msi;
echo "Downloading Ruby...";
curl http://rubyforge.org/frs/download.php/76804/rubyinstaller-2.0.0-p0.exe > ~/install/rubyinstaller-2.0.0-p0.exe;
echo "Downloading Sublimetext2";
curl http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1%20Setup.exe > ~/install/sublime2.exe;
echo "Downloading Console2";
curl http://kent.dl.sourceforge.net/project/console/console-devel/2.00/Console-2.00b148-Beta_32bit.zip > ~/install/console2.zip;

CURRENT=$(pwd);
cd ~/install/;

$SystemRoot/system32/msiexec -i node-v0.9.8-x86.msi;
$SystemRoot/system32/msiexec -i python-3.3.0.msi;
$SystemRoot/system32/msiexec -i php-5.3.22-nts-Win32-VC9-x86.msi;
./rubyinstaller-2.0.0-p0.exe;
./sublime2.exe;
unzip console2.zip -d .;

cp $CURRENT/console.xml Console2/console.xml;

# ugly and lame, ugh... no time for looking for a better way for now, but need to be fixed ;-/
SHOME=$(echo $HOME | sed "s/\\\/\\\\\\\\\\\\/g");
SComSpec=$(echo $ComSpec | sed "s/\\\/\\\\\\\\\\\\/g");
SINSTALL=$(echo $INSTALL | sed "s/\\\/\\\\\\\\\\\\/g");

cat Console2/console.xml | sed -e "s/%HOMEDIR%/$SHOME/g" > consoletmp; mv consoletmp Console2/console.xml;
cat Console2/console.xml | sed -e "s/%CMDPATH%/$SComSpec/g" > consoletmp; mv consoletmp Console2/console.xml;
cat Console2/console.xml | sed -e "s/%WINDEVPATH%/$SINSTALL\/windev/g" > consoletmp; mv consoletmp Console2/console.xml;

cd $CURRENT;

# /install

# Path reset to windev installation directory
PATH="$INSTALL/windev/bin";

echo "source /userdir/.zshrc" > ~/.zshrc
echo "source /userdir/.bashrc" > ~/.bashrc

# bash
~/install/Console2/console.exe
exit;
