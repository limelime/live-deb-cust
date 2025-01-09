---
title: Developer manual
---

# Create hybrid ISO

1. Clone the git repository(e.g. `git clone https://github.com/limelime/cust-live-deb.git`)
1. Import the wiki to `./scripts/settings/doc/`.
1. Download binary files as described in `./scripts/settings/binary/to-download.sh`.
1. `./cld.sh <SYSTEM> <DEB_REPO_URL>`. 
    * **SYSTEM** can be:
        * min: Strict minimum system with JWM light-weight window manager. From there, you can add your desired applications.
        * std: Standard system includes minimum system + common applications.
        * all: Will execute all scripts in `./scripts/repository/`.
    * **DEB_REPO_URL** is the URL to the Debian repository(e.g. http://ftp.debian.org/debian/).
1. `cust-live-deb-64-<SYSTEM>_YYYY-MM-DD_HH.MM.SS.iso` will be created.

# Add / Remove applications
Installation scripts are residing in `./scripts/repository/` directory.

## Script name nomenclature
*  Script name must starts with `inst-` and end with `.sh`.
    * `inst-`: Install.
    * `-min-`: Minimum system.
    * `-min-con-`: Minimum console.
    * `-min-win-`: Require X window.
    * `-xtra-`: Extra, not required for the system to work properly.
    * `-std-`: Standard system.
    * `-zclean-`: Clean up scripts that will run at the end.
*  Suffix `-bpo` if your script is using the backports repository(e.g. `deb http://http.debian.net/debian jessie-backports main`).


## Add new script
- `cd scripts/repository`
- Add your package in `create-script-repo.txt`.
- `./create-script-repo.sh` will create the corresponding directory and *.sh file.
- Scripts are executed in alphabetically order.
- Before any script is run, the whole `./scripts/` directory is copied to `/root/` of the chroot environment.
- Write your script as if you are located at `/root/scripts/`.

## Scripts to exclude
To exclude a specific script from the installation, add its name in `./scripts/scripts-ex.lst`, 1 per line.

## Sources.list
    # cat sources-PACKAGE_NAME.list >> "${GV_SOURCES_LIST}"
    cat sources-aptly.list >> "${GV_SOURCES_LIST}"

## Application association with file extension
Source: https://wiki.debian.org/MIME#Application_association

The system-wide association between MIME types and applications is generated from the `*.desktop` files provided by the packages. The `.desktop` files are stored in the `/usr/share/applications/` directory and subdirectories, and the `update-desktop-database` parses their information and generates the `/usr/share/applications/mimeinfo.cache` file, that specifies for each MIME type the valid `.desktop` files (hence applications).

The `mimeinfo.cache` is basically a raw reverse cache for the `.desktop` information. There is no way to define priorities in it. To be able to specify default applications, a `mimeapps.list` file (previously named `defaults.list` up to debian 5) must be created. It can be system-wide (in `/usr/share/applications` or a subdirectory) or user-specific (in `$HOME/.local/share/applications`). A heuristic is used by glib (FIXME: what about KDE?) to use the appropriate `mimeapps.list` file according to the user environment (Gnome evince vs. KDE Okular for PDF files for instance). The `mimeapps.list` file follows the same syntax as `mimeinfo.cache`, i.e:

    [Default Applications]
    application/pdf=evince.desktop
    image/png=eog.desktop

1. Find your application's `*.desktop` in `/usr/share/applications/` and copy the **MimeType** value.
1. Ensure that your application mine type is the same as your file mine type.(`file --mime-type YOUR_FILE`).
1. In `$HOME/.local/share/applications/mimeapps.list`, paste **MimeType** value under **[Default Applications]** section.

        [Default Applications]
        text/plain=SciTE.desktop


Register your own extension: http://stackoverflow.com/questions/30931/register-file-extensions-mime-types-in-linux

## Preseed configuration values

1. Manually configure interactively first.
1. Get the configuration values: `debconf-get-selections | grep "zfs" > zfs-dkms.seed`
1. Remove unused 'select' from zfs-dkms.seed.
1. Feed the configuration values in your install script, before the install line: `export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true; debconf-set-selections -v zfs-dkms.seed`

## Debug installation script

    ./in-chroot /media/imdb/chroot
    yes | cp -a /etc/apt/sources.list.tmp /etc/apt/sources.list
    apt-get update
    cd ~/scripts 
    source load-global-vars-funcs.sh
    RUN YOUR SCRIPT.

# Clean rebuild

    chmod +x ../cust-live-deb.wiki/*.sh
    chmod +x init-chmod-script.sh
    ./init-chmod-script.sh
    cd ./scripts/repository/inst-xtra-vboxguest-additions-iso/
      chmod +x VBoxGuestAdditions.sh 
      ./VBoxGuestAdditions.sh
      cd -
      
    cd scripts/repository/inst-std-xtra-opw-drush8-phar
      # Download drush-8.1.17.phar from https://github.com/drush-ops/drush/releases
      chmod +x drush.phar
      mv drush.phar drush-8.1.17.phar
                                                                          
    ./build-cld.sh work_no_proxy

# Cust-Live-Deb specific
Put all Cust-Live-Deb specific codes in `/usr/local/cld/` so that all users can use it.
The idea is to mirror the same structure of `/usr/local/cld/` within your install script folder, put your specialized files and then copy over `/usr/local/cld/`. This will make the process self-contain within the install script folder.
    
    >cld-dirs-create.sh 
    Error: Action:  is unknown. Aborted!
        where-used      => N/A                                      [Show where paths below are used]
        bin             => ./cld/bin                                [Your executable scripts]
        doc             => ./cld/doc                                [Documentation]
        home            => ./cld/home                               [$HOME directory]
        app             => ./cld/app                                []
        jwmrc           => ./cld/app/jwm/jwmrc                      [JWM configuration files]
        jwm-bootstrap   => ./cld/app/jwm/bootstrap                  [Scripts executed after JWM started]
        bashrc          => ./cld/bashrc.d                           [*.sh will be sourced]
        after-boot      => ./cld/systemd/runlevel/after-boot        [*.sh will be executed after boot]
        before-shutdown => ./cld/systemd/runlevel/before-shutdown   [*.sh will be executed before shutdown/reboot/restart]


# CLD scripts execution order
All scripts put in the directories below will be executed in the following order:
    
    /usr/local/cld/systemd/runlevel/after-boot/
    /usr/local/cld/app/jwm/bootstrap/
    /usr/local/cld/systemd/runlevel/before-shutdown/
       

# How to upgrade kernel

1. Ensure `./cld-mkiso.sh "${SYSTEM}" "${CHROOT_DIR}" ignore` is in `cld.sh`. To forgo the following error:

        libkmod: ERROR ../libkmod/libkmod.c:557 kmod_search_moddep: could not open moddep file '/lib/modules/4.6.0-0.bpo.1-amd64/modules.dep.bin'
        modinfo: ERROR: Module alias vboxguest not found.
            
1. Run `./cld.sh work http://localhost/aptly-repo/jessie-main`. The log for zfs and virtualbox will show error when trying to fetch for the version but that is fine.
1. Load the new ISO.
1. Re-run `./cld.sh work http://localhost/aptly-repo/jessie-main`. The log for zfs and virtualbox should not show any error. The versions should be displayed.



==========================

update-initramfs -u
dpkg-reconfigure linux-image-3.2.0-2-686-pae  =>https://kernel-team.pages.debian.net/kernel-handbook/ch-initramfs.html


* When using `update-initramfs`, specify the kernel version because the script use `uname -r` which is wrong if you upgrade from old to new kernel.
* Use `update-initramfs` instead of `mkinitramfs`. `update-initramfs` does distro house keep for you.

# Distribution upgrade

1. Update scripts at `/aptly/mirrors.d`
1. Update `./inst-min-con-00-apt-custom-repository/sourceslist-live.sh`
1. Update `./inst-min-con-00-apt-custom-repository/sourceslist-temporary.sh`
1. Update `build-cld.sh`
1. Update line `debootstrap --no-check-gpg ...` from `cust-live-deb/cld-debootstrap.sh`.
1. Find `'jessie-backports'` and replace with next distro name.
  

# Debug Debian package dependency
Lower priority of packages from other repositories. Add the following in `.../scripts/repository/inst-min-con-01-apt/preferences-local-repository`

    # https://unix.stackexchange.com/a/118610
    Package: *
    Pin: origin www.deb-multimedia.org
    Pin-Priority: 1
    
    # https://unix.stackexchange.com/a/329843
    Package: *
    Pin: release a=stretch-backports
    Pin-Priority: 1  

# JWM menu
Check https://specifications.freedesktop.org/menu-spec/latest/apa.html

    Terminal
    --------
    Miscellaneous applications
    --------
    Administration applications
    --------
    Debian: Debian generated menu
    --------
    Shutdown


Icon per application can found in it menu definition file located at `/usr/share/menu`.

## Add icon in JWM menu

* Main menu: ./cust-live-deb/scripts/repository/inst-std-00-jwm-menu/jwmrc-menus-standard.xml
* Set up icons at /usr/local/cld/app/jwm/jwmrc/jwmrc-menus.xml
* Find JWM menu files: find ./scripts/repository/ -type f -name "jwmrc-*.xml" | sort
* Put all custom icons in: /usr/local/cld/app/jwm/jwmrc/icons/

* Size of icons should be 32x32.
* https://github.com/toss/tossface/releases/tag/v1.1
* https://openmoji.org/
* https://unicode.org/emoji/charts-13.1/full-emoji-list.html
* Icons repository: https://icons8.com/


Use `inst-std-accessories-scite` as reference.

1. Find menu file in `/usr/share/menu/`
1. Copy `jwmrc-menus-acc-scite.xml` to `jwmrc-menus-<category>-<packagename>.xml`
1. Edit `jwmrc-menus-<category>-<packagename>.xml` with info found in menu file.
1. Edit install script. E.g.:

        # Insert Blender 3D menu in Graphics
        sed -i "/Graphics\">/ r jwmrc-menus-graphics-blender.xml" "${GV_CLD_ROOT_DIR}/jwmrc-menus.xml"


Paths where you can find more icons:
    
    /usr/share/icons/
    /usr/share/pixmaps/
    

# Systemd
https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units
    
    systemctl list-unit-files --no-page | grep swap
    systemctl cat swap.target

Unit files located at /etc/systemd/system.

# Virtual packages
* https://www.debian.org/doc/packaging-manuals/virtual-package-names-list.txt

# Useful commands

    dpkg --print-architecture
    dpkg --print-foreign-architectures
    apt list --upgradable

# X Server
https://wiki.archlinux.org/index.php/Display_Power_Management_Signaling

* `xset s off`: Disable screen saver blanking
* `xset s 3600 3600`: Change blank time to 1 hour
* `xset -dpms`: Turn off DPMS
* `xset s off -dpms`:Disable DPMS and prevent screen from blanking
* `xset dpms force off`: Turn off screen immediately
* `xset dpms force standby`: Standby screen
* `xset dpms force suspend`: Suspend screen
* `xset q`: Display current settings.
    
# Help
## List of fonts
https://wiki.debian.org/Fonts

    # List all fonts available.
    fc-list
    
    
    
## Get version of zfs
    dkms status
    # OR
    ZFS_VERSION=$(modinfo zfs | grep ^version | tr -s ' ')
    echo ${ZFS_VERSION}
    
## Manually test the installation script within chroot environment

    ./in-chroot.sh
    apt-get update
    cd /root/scripts/
    cp repository/YOUR_SCRIPT.sh .
    source load-global-vars-funcs.sh
    ./YOUR_SCRIPT.sh
    
## Find keyboard key you can map in .jwmrc

    ~>xmodmap -pke | grep -iE 'escape|return'
    keycode   9 = Escape NoSymbol Escape
    keycode  36 = Return NoSymbol Return
    
Example in .jwmrc
    
    ...
    <Key key="Return">select</Key>
    <Key key="Escape">escape</Key>
    ...
    
## Debian default JWM menu
The default Debian JWM menu is located at `/etc/jwm/debian-menu`. It is auto-generated when you add a new application. You can copy the execution command line and add it in your installation script.

## Preseed Debian package answers
1. Install the package and answer all the question manually.
1. Get the answers by running `debconf-get-selections | grep "YOUR_PACKAGE_NAME > YOUR_ANSWERS.seed"`. Note: Answers are not always good.
1. Seed the answers before installing the package: `debconf-set-selections -v YOUR_ANSWERS.seed`.
1. Install your package.

https://wiki.debian.org/Multistrap/Environment



## hostname: Name or service not known

    hostname --fqdn

## Disable debconf user interface
Don't use the following command line to disable debconf user interface:

    export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true

If your preseed file answer all questions, then the user interface shouldn't pop up.

## Debug debconf user interface
    
    # List all questions and debug information on the command prompt.
    export DEBCONF_DEBUG=developer
    
    # Press Alt-F4 to switch from the debconf user interface to the command prompt. 

## Debian APT
    
    # Check available package versions
    apt-cache policy <package>

## Dump
    
    # Set root password to empty string.
    echo "
    USE mysql;
    UPDATE user SET Password = PASSWORD('') where User = 'root';
    FLUSH PRIVILEGES;
    " | mysql -u root -prootpasswd