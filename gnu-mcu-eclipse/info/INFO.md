# GNU MCU Eclipse OpenOCD

This is the **GNU MCU Eclipse** (formerly GNU ARM Eclipse) version of **OpenOCD**.

## Compliance

GNU MCU Eclipse OpenOCD generally follows the official [OpenOCD](http://openocd.org) releases and the [RISC-V distribution](https://github.com/riscv/riscv-openocd) 
maintained by [SiFive](https://www.sifive.com).

The current version is based on 

- OpenOCD version 0.10.0-development, commit [1025be](http://repo.or.cz/openocd.git/commit/1025be363e2bf42f1613083223a2322cc3a9bd4c) from May 31, 2017
- RISC-V release v20170621, commit [d77c4a](https://github.com/riscv/riscv-openocd/commit/d77c4a953c1f2a6e1f84c28e64bf9296a4bb398a) from June 21, 2017

## Changes

The changes are minimal, and mainly consist in the additional files 
required by the packing procedure used to generate the binary packages 
(for more details please see `gnu-mcu-eclipse/CHANGES.txt`).

The main addition is **support for RISC-V devices**.

## More info

For more info and support, please see the GNU MCU Eclipe project pages from:

  http://gnu-mcu-eclipse.github.io

Thank you for using **GNU MCU Eclipse**,

Liviu Ionescu

