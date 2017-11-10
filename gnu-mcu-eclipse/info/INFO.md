# GNU MCU Eclipse OpenOCD

This is the **GNU MCU Eclipse** (formerly GNU ARM Eclipse) version of **OpenOCD**.

## Compliance

GNU MCU Eclipse OpenOCD generally follows the official [OpenOCD](http://openocd.org) releases and the [RISC-V distribution](https://github.com/riscv/riscv-openocd) 
maintained by [SiFive](https://www.sifive.com).

The current version is based on 

- OpenOCD version 0.10.0-development, commit [7719e96](http://repo.or.cz/openocd.git/commit/7719e9618e753ac41a46a2488dfba549ac578891) from Aug 10th, 2017
- RISC-V commit [055a70f](https://github.com/riscv/riscv-openocd/commit/055a70f66f8c27e52798197e11505688b994a241) from Nov 3rd, 2017

## Changes

Compared to the RISC_V version, the changes are:

* the `monitor reg` command no longer shows the 4096 CSRs
* the following board files are added for the SiFive boards
  * `sifive-hifive1.cfg`
  * `sifive-e31arty.cfg`
  * `sifive-e51arty.cfg`
* some of the GDB error processing patches added by RISC-V in `server/gdb_server.c` were reversed, since they interfered with other targets

## More info

For more info and support, please see the GNU MCU Eclipe project pages from:

  http://gnu-mcu-eclipse.github.io

Thank you for using **GNU MCU Eclipse**,

Liviu Ionescu

