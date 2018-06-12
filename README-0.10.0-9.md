# GNU MCU Eclipse OpenOCD

This is the **GNU MCU Eclipse** (formerly GNU ARM Eclipse) version of **OpenOCD**.

## Compliance

GNU MCU Eclipse OpenOCD generally follows the official 
[OpenOCD](http://openocd.org) releases and the 
[RISC-V distribution](https://github.com/riscv/riscv-openocd) 
maintained by [SiFive](https://www.sifive.com).

The current version is based on 

- OpenOCD version 0.10.0-development, commit 
[0612315](https://github.com/gnu-mcu-eclipse/openocd/commit/06123153f38280608b1e92dcb766b31ade7e4668) 
from June 6th, 2018
- RISC-V commit 
[32f6d6a](https://github.com/gnu-mcu-eclipse/openocd/commit/32f6d6a857ed9548428dd095e51a646e7fbab9de) 
from June 12th, 2018

## Changes

Compared to the master OpenOCD, the changes are:

- ARM semihosting uses the new separate implementation; there should be no functional differences.

Compared to the RISC-V version, the changes are:

- none functionally relevant

## Documentation

The original documentation is available in the `share/doc` folder.

## More info

For more info and support, please see the GNU MCU Eclipse project pages from:

  http://gnu-mcu-eclipse.github.io

Thank you for using **GNU MCU Eclipse**,

Liviu Ionescu
