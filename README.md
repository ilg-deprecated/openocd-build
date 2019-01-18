# GNU MCU Eclipse OpenOCD - the build scripts

These are the scripts and additional files required to build the
[GNU MCU Eclipse OpenOCD](https://github.com/gnu-mcu-eclipse/openocd).

This release follows the official [OpenOCD](http://openocd.org).

The build scripts use the 
[xPack Build Box (XBB)](https://github.com/xpack/xpack-build-box), 
a set of elaborate build environments based on GCC 7.2 (Docker containers
for GNU/Linux and Windows or a custom HomeBrew for MacOS).

## Repository URLs

- the [GNU MCU Eclipse OpenOCD](https://github.com/gnu-mcu-eclipse/openocd) 
Git remote URL to clone from is https://github.com/gnu-mcu-eclipse/openocd.git
- the [OpenOCD](https://sourceforge.net/p/openocd/code/) Git remote URL is
https://git.code.sf.net/p/openocd/code

Add a remote named `openocd`, and pull the OpenOCD master → master.

## Changes

Compared to the original OpenOCD distribution, there should be no 
functional changes.

## How to build

### Prerequisites

The prerequisites are common to all binary builds. Please follow the 
instructions in the separate 
[Prerequisites for building binaries](https://gnu-mcu-eclipse.github.io/developer/build-binaries-prerequisites-xbb/) 
page and return when ready.

### Download the build scripts repo

The build script is available from GitHub and can be 
[viewed online](https://github.com/gnu-mcu-eclipse/openocd-build/blob/master/scripts/build.sh).

To download it, clone the 
[gnu-mcu-eclipse/openocd-build](https://github.com/gnu-mcu-eclipse/openocd-build) 
Git repo, including submodules. 

```console
$ rm -rf ~/Downloads/openocd-build.git
$ git clone --recurse-submodules https://github.com/gnu-mcu-eclipse/openocd-build.git \
  ~/Downloads/openocd-build.git
```

### Check the script

The script creates a temporary build `Work/openocd-${version}` folder in 
the user home. Although not recommended, if for any reasons you need to 
change this, you can redefine `WORK_FOLDER_PATH` variable before invoking 
the script.

### Preload the Docker images

Docker does not require to explicitly download new images, but does this 
automatically at first use.

However, since the images used for this build are relatively large, it 
is recommended to load them explicitly before starting the build:

```console
$ bash ~/Downloads/openocd-build.git/scripts/build.sh preload-images
```

The result should look similar to:

```console
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ilegeul/centos32    6-xbb-v1            f695dd6cb46e        2 weeks ago         2.92GB
ilegeul/centos      6-xbb-v1            294dd5ee82f3        2 weeks ago         3.09GB
hello-world         latest              f2a91732366c        2 months ago        1.85kB
```

### Update git repos

To keep the development repository in sync with the original OpenOCD 
repository and the RISC-V repository:

- checkout `master`
- pull from `openocd/master`
- checkout `gnu-mcu-eclipse-dev`
- merge `master`
- add a tag like `v0.10.0-8-20180512` after each public release (mind the 
inner version `-8-`)

### Prepare release

To prepare a new release, first determine the OpenOCD version 
(like `0.10.0`) and update the `scripts/VERSION` file. The format is 
`0.10.0-8`. The fourth digit is the GNU MCU Eclipse release number 
of this version.

Add a new set of definitions in the `scripts/container-build.sh`, with 
the versions of various components.

### Update README.md

If necessary, update the main README.md with informations related to the
build. Information related to the content should be updated in 
the README-<version>.md.

### Create README-<version>.md

Create a copy of the previous one and update.

### Update CHANGELOG.txt

Check `openocd-build.git/CHANGELOG.txt` and add the new release.

### Build

Although it is perfectly possible to build all binaries in a single step 
on a macOS system, due to Docker specifics, it is faster to build the 
GNU/Linux and Windows binaries on a GNU/Linux system and the macOS binary 
separately.

#### Build the GNU/Linux and Windows binaries

The current platform for GNU/Linux and Windows production builds is an 
Ubuntu 17.10 VirtualBox image running on a macMini with 16 GB of RAM 
and a fast SSD.

Before starting a multi-platform build, check if Docker is started:

```console
$ docker info
```

To build both the 32/64-bit Windows and GNU/Linux versions, use `--all`; 
to build selectively, use `--linux64 --win64` or `--linux32 --win32` 
(GNU/Linux can be built alone; Windows also requires the GNU/Linux build).

```console
$ rm -rf ${HOME}/Work/openocd-*
$ bash ~/Downloads/openocd-build.git/scripts/build.sh --all
```

To build one of the previous versions:

```console
$ RELEASE_VERSION=0.10.0-8 bash ~/Downloads/openocd-build.git/scripts/build.sh --all
```

Several hours later, the output of the build script is a set of 4 files 
and their SHA signatures, created in the `deploy` folder:

```console
$ ls -l deploy
total 10940
-rw-r--r-- 1 ilg ilg 2655896 May 12 22:39 gnu-mcu-eclipse-openocd-0.10.0-8-20180512-1921-centos32.tgz
-rw-r--r-- 1 ilg ilg     126 May 12 22:39 gnu-mcu-eclipse-openocd-0.10.0-8-20180512-1921-centos32.tgz.sha
-rw-r--r-- 1 ilg ilg 2590467 May 12 22:27 gnu-mcu-eclipse-openocd-0.10.0-8-20180512-1921-centos64.tgz
-rw-r--r-- 1 ilg ilg     126 May 12 22:27 gnu-mcu-eclipse-openocd-0.10.0-8-20180512-1921-centos64.tgz.sha
-rw-r--r-- 1 ilg ilg 2910732 May 12 22:45 gnu-mcu-eclipse-openocd-0.10.0-8-20180512-1921-win32.zip
-rw-r--r-- 1 ilg ilg     123 May 12 22:45 gnu-mcu-eclipse-openocd-0.10.0-8-20180512-1921-win32.zip.sha
-rw-r--r-- 1 ilg ilg 2957245 May 12 22:34 gnu-mcu-eclipse-openocd-0.10.0-8-20180512-1921-win64.zip
-rw-r--r-- 1 ilg ilg     123 May 12 22:34 gnu-mcu-eclipse-openocd-0.10.0-8-20180512-1921-win64.zip.sha
```

To copy the files from the build machine to the current development 
machine, open the `deploy` folder in a terminal and use `scp`:

```console
$ cd ${HOME}/Work/openocd-0.10.0-8/deploy
$ scp * ilg@ilg-mbp.local:Downloads
```

#### Build the macOS binary

The current platform for macOS production builds is a macOS 10.10.5 
VirtualBox image running on the same macMini with 16 GB of RAM and a 
fast SSD.

To build the latest macOS version, with the same timestamp as the 
previous build:

```console
$ rm -rf ${HOME}/Work/openocd-*
$ caffeinate bash ~/Downloads/openocd-build.git/scripts/build.sh --osx --date YYYYMMDD-HHMM
```

To build one of the previous macOS versions:

```console
$ RELEASE_VERSION=0.10.0-8 caffeinate bash ~/Downloads/openocd-build.git/scripts/build.sh --osx --date YYYYMMDD-HHMM
```

For consistency reasons, the date should be the same as the GNU/Linux 
and Windows builds.

Several hours later, the output of the build script is a compressed 
archive and its SHA signature, created in the `deploy` folder:

```console
$ ls -l deploy
total 4944
-rw-r--r--  1 ilg  staff  2524910 May 12 23:19 gnu-mcu-eclipse-openocd-0.10.0-8-20180512-1921-macos.tgz
-rw-r--r--  1 ilg  staff      123 May 12 23:19 gnu-mcu-eclipse-openocd-0.10.0-8-20180512-1921-macos.tgz.sha
```

To copy the files from the build machine to the current development 
machine, open the `deploy` folder in a terminal and use `scp`:

```console
$ cd ${HOME}/Work/openocd-0.10.0-8/deploy
$ scp * ilg@ilg-mbp.local:Downloads
```

### Subsequent runs

#### Separate platform specific builds

Instead of `--all`, you can use any combination of:

```
--win32 --win64 --linux32 --linux64
```

Please note that, due to the specifics of the GCC build process, the 
Windows build requires the corresponding GNU/Linux build, so `--win32` 
alone is equivalent to `--linux32 --win32` and `--win64` alone is 
equivalent to `--linux64 --win64`.

#### clean

To remove most build files, use:

```console
$ bash ~/Downloads/openocd-build.git/scripts/build.sh clean
```

To also remove the repository and the output files, use:

```console
$ bash ~/Downloads/openocd-build.git/scripts/build.sh cleanall
```

For production builds it is recommended to completely remove the build folder.

#### --develop

For performance reasons, the actual build folders are internal to each 
Docker run, and are not persistent. This gives the best speed, but has 
the disadvantage that interrupted builds cannot be resumed.

For development builds, it is possible to define the build folders in 
the host file system, and resume an interrupted build.

#### --debug

For development builds, it is also possible to create everything with 
`-g -O0` and be able to run debug sessions.

#### Interrupted builds

The Docker scripts run with root privileges. This is generally not a 
problem, since at the end of the script the output files are reassigned 
to the actual user.

However, for an interrupted build, this step is skipped, and files in 
the install folder will remain owned by root. Thus, before removing 
the build folder, it might be necessary to run a recursive `chown`.

## Install

The procedure to install GNU MCU Eclipse OpenOCD is platform specific, 
but relatively straight forward (a .zip archive on Windows, a compressed 
tar archive on macOS and GNU/Linux).

A portable method is to use [`xpm`](https://www.npmjs.com/package/xpm):

```console
$ xpm install --global @gnu-mcu-eclipse/openocd
```

More details are available on the [How to install the OpenOCD binaries?](https://gnu-mcu-eclipse.github.io/openocd/install/) page.

After install, the package should create a structure like this (only the 
first two depth levels are shown):

```console
$ tree -L 2 /Users/ilg/Library/xPacks/\@gnu-mcu-eclipse/openocd/0.10.0-8.1/.content/
/Users/ilg/Library/xPacks/\@gnu-mcu-eclipse/openocd/0.10.0-8.1/.content/
├── OpenULINK
│   └── ulink_firmware.hex
├── README.md
├── bin
│   └── openocd
├── contrib
│   ├── 60-openocd.rules
│   └── libdcc
├── gnu-mcu-eclipse
│   ├── CHANGELOG.txt
│   ├── licenses
│   ├── patches
│   └── scripts
├── scripts
│   ├── bitsbytes.tcl
│   ├── board
│   ├── chip
│   ├── cpld
│   ├── cpu
│   ├── fpga
│   ├── interface
│   ├── mem_helper.tcl
│   ├── memory.tcl
│   ├── mmr_helpers.tcl
│   ├── target
│   ├── test
│   └── tools
└── share
    └── doc
```

No other files are installed in any system folders or other locations.

## Uninstall

The binaries are distributed as portable archives; thus they do not need 
to run a setup and do not require an uninstall.


## Test

A simple test is performed by the script at the end, by launching the 
executable to check if all shared/dynamic libraries are correctly used.

For a true test you need to first install the package and then run the 
program from the final location. For example on macOS the output should 
look like:

```console
$ /Users/ilg/Library/xPacks/\@gnu-mcu-eclipse/openocd/0.10.0-8.1/.content/bin/openocd --version
GNU MCU Eclipse 64-bit Open On-Chip Debugger 0.10.0+dev-00487-gaf359c18 (2018-05-12-23:16)
```

## More build details

The build process is split into several scripts. The build starts on 
the host, with `build.sh`, which runs `container-build.sh` several 
times, once for each target, in one of the two docker containers. 
Both scripts include several other helper scripts. The entire process 
is quite complex, and an attempt to explain its functionality in a few 
words would not be realistic. Thus, the authoritative source of details 
remains the source code.
