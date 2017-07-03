# The GNU MCU Eclipse OpenOCD build project

These are the additional files required by the [GNU MCU Eclipse OpenOCD](https://github.com/gnu-mcu-eclipse/openocd) build procedures.

## How to build

```bash
$ git clone https://github.com/gnu-mcu-eclipse/openocd-build.git ~/Downloads/openocd-build.git
$ bash ~/Downloads/openocd-build.git/scripts/build.sh --all
```

For more details, please see the dedicated [GNU MCU Eclipse OpenOCD build](http://gnu-mcu-eclipse.github.io/openocd/) page.

## Folders

For consistency with other projects, all files are grouped under `gnu-mcu-eclipse`.

* `info` - informative files copied to the distributed `info` folder;
* `nsis` - files required by [NSIS (Nullsoft Scriptable Install System)](http://nsis.sourceforge.net/Main_Page);
* `patches` - small patches to correct some problems identified in the official packages;
* `pkgconfig` - configuration files missing in some of the official packages;
* `scripts` - build support scripts.

## Files

* `VERSION` - the current build version file. Its content looks like `0.10.0-2`, where `0.10.0` is the official OpenOCD version, and `2` is the GNU MCU Eclipse OpenOCD release number.

## Repository URLs

- the [GNU MCU Eclipse OpenOCD](https://github.com/gnu-mcu-eclipse/openocd.git) Git remote URL to clone from is https://github.com/gnu-mcu-eclipse/openocd https://github.com/gnu-mcu-eclipse/openocd.git
- the [OpenOCD](https://sourceforge.net/p/openocd/code/) Git remote URL is https://git.code.sf.net/p/openocd/code
- the [RISC-V OpenOCD](https://github.com/riscv/riscv-openocd) Git remote URL is https://github.com/riscv/riscv-openocd.git

Add a remote named `openocd`, and pull itsthe OpenOCD master → master.
Add a remote named `riscv`, and pull the RISC_V riscv → riscv.

## Update procedures

### The gnu-mcu-eclipse-dev branch

To keep the development repository in sync with the original OpenOCD repository and the RISC-V repository:

- checkout `master`
- pull from `openocd/master`
- checkout `gnu-mcu-eclipse-dev`
- merge `master`
- checkout `riscv/riscv`
- merge `riscv` (and resolve conflicts)
- add a tag like `gme-0.10.0-20150511-1122-dev` after each public release

### The gnu-mcu-eclipse branch

To keep the stable development in sync with the development branch:

- checkout `gnu-mcu-eclipse`
- merge `gnu-mcu-eclipse-dev`
- add a tag like `gme-0.8.0-20150511-1122` after each public release
