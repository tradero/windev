windev
======

Because we don't like cygwin and manual installation ;-)

----

Licenses files for all binaries will be kept inside of '_licenses' folder (or not, we will see how it goes with binary files mixing, almost all of these files got information about the author attached).

Installation
=====

1. Download: https://github.com/tradero/windev/blob/master/windev.EXE
2. Run
3. Select installation directory (in my case D:\_software)
4. Select user home directory (in my case D:\_projects)
5. ...drink some coffee, watch TV or whatever, depending on your internet connection speed You'll have to wait for downloads (https://github.com/tradero/windev-env and nodejs, python, ruby, php, console2 and sublime)
6. Go thru installation step by step with each installation wizard
7. that's it...

Console2 will be available from your user home directory, inside of ~/install/Console2/ directory.

Building
=====

Customization of windev should be as simple as changing things You're interested of and running build.sh script to generate your new .exe file.

Note: remember that stage1 directory should be as small as it is possible.

TODO
=====

- uninstaller
- update manager (simple git pull should be enough)
- fixing missing git pull ;-D
- pre installation script support (for example if user will create c:\pre.sh on his local machine, installer will execute it before installation)
- post installation script support (for example if user will create c:\post.sh on his local machine, installer will execute it after installation - for example, sublimetext full configuration with plugins and modules downloaded from some external git repository )
