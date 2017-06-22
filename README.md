# The GNU MCU Eclipse OpenOCD build project

This project includes the additional files required to build [GNU MCU Eclipse OpenOCD](https://github.com/gnu-mcu-eclipse/openocd).

## How to build

```bash
$ git clone https://github.com/gnu-mcu-eclipse/openocd-build.git ~/Downloads/openocd-build.git
$ bash ~/Downloads/openocd-build.git/scripts/build.sh --all
```

For more details, please see the dedicated [GNU MCU Eclipse OpenOCD build](http://gnu-mcu-eclipse.github.io/openocd/) page.

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
