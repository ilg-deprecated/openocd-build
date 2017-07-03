
This package was build on an OS X machine, using the script provided 
in the GNU MCU Eclipse [openocd.git](https://github.com/gnu-mcu-eclipse/openocd)
project.

To build the latest version of the binaries please use the script from:

```bash
$ git clone https://github.com/gnu-mcu-eclipse/openocd.git \
~/Downloads/openocd.git
```

To run it, first be sure that the packages required in the Prerequisites 
section are installed, then download the script and execute it with bash:

```bash
$ bash ~/Downloads/openocd.git/scripts/build.sh --osx
```

The output of the build script is a a `*.tgz` archive and a `.pkg` install
in the `${WORK_FOLDER}/deploy` folder.

The script was developed on OS X 10.12 with Homebrew. Running it on other 
versions is possible, but might require some adjustments.

Up-to-date build information is available in the GNU MCU Eclipse project web:

  http://gnu-mcu-eclipse.github.io/openocd/

Many thanks to my friend Dan Maiorescu for his major contributions 
to this project.


Liviu Ionescu
