# Boards

## Overview

The following boards/devices are supported:

- Raspberry Pi
  - Pi 4 Model B ([1 GB](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/?variant=raspberry-pi-4-model-b-1gb), [2 GB](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/?variant=raspberry-pi-4-model-b-2gb), [4 GB](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/?variant=raspberry-pi-4-model-b-4gb) and [8 GB](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/?variant=raspberry-pi-4-model-b-8gb) model) 32-bit or 64-bit (recommended)
  - [Pi 3 Model B](https://www.raspberrypi.com/products/raspberry-pi-3-model-b/) and [B+](https://www.raspberrypi.com/products/raspberry-pi-3-model-b-plus/) 32-bit or 64-bit (recommended)
  - [Pi 2](https://www.raspberrypi.com/products/raspberry-pi-2-model-b/) (not recommended)
  - [Pi Zero-W](https://www.raspberrypi.com/products/raspberry-pi-zero-w/) (not recommended)
  - [Pi](https://www.raspberrypi.com/products/raspberry-pi-1-model-b-plus/) (not recommended)
- Hardkernel
  - [ODROID-C2](https://www.hardkernel.com/shop/odroid-c2/) (discontinued)
  - [ODROID-C4](https://www.hardkernel.com/shop/odroid-c4/)
  - [ODROID-M1](https://www.hardkernel.com/shop/odroid-m1/)
  - [ODROID-N2](https://www.hardkernel.com/shop/odroid-n2/) (discontinued)
  - ODROID-N2+ [2 GB](https://www.hardkernel.com/shop/odroid-n2-with-2gbyte-ram-2/) or [4 GB](https://www.hardkernel.com/shop/odroid-n2-with-4gbyte-ram-2/)
  - [ODROID-XU4](https://www.hardkernel.com/shop/odroid-xu4-special-price/)
- Asus
  - [Tinker Board](https://tinker-board.asus.com/product/tinker-board.html)
- Generic x86-64 (UEFI, not suited for virtualization)
  - [Intel NUC5CPYH](https://www.intel.com/content/www/us/en/products/sku/85254/intel-nuc-kit-nuc5cpyh/specifications.html)
  - [Intel NUC6CAYH](https://www.intel.com/content/www/us/en/products/sku/95062/intel-nuc-kit-nuc6cayh/specifications.html)
  - [Intel NUC10I3FNK2](https://www.intel.com/content/www/us/en/products/sku/195503/intel-nuc-10-performance-kit-nuc10i3fnk/specifications.html)
  - [Gigabyte GB-BPCE-3455](https://www.gigabyte.com/Mini-PcBarebone/GB-BPCE-3455-rev-10/sp#sp)
  - Computers supporting x86-64 architecture and UEFI boot should generally work
- Virtual appliance (x86_64/UEFI):
  - VMDK
  - OVA ?
  - VHDX ?
  - VDI ?
  - QCOW2 ?

Notes:
  - see ? above: are these currently supported? see ova documentation which explains issues with previous OVA distribution)

## Board specifics

|Board|Build|Config|Docs|
|-----|----|------|----|
|Pi4B 64-bit   |`make rpi4_64`       |[rpi4_64](../../buildroot-external/configs/rpi4_64_defconfig)|[raspberrypi](./raspberrypi/)|
|Pi4B 32-bit   |`make rpi4`          |[rpi4](../../buildroot-external/configs/rpi4_defconfig)|[raspberrypi](./raspberrypi/)|
|Pi3B 64-bit   |`make rpi3_64`       |[rpi3_64](../../buildroot-external/configs/rpi3_64_defconfig)|[raspberrypi](./raspberrypi/)|
|Pi3B 32-bit   |`make rpi3`          |[rpi3](../../buildroot-external/configs/rpi3_defconfig)|[raspberrypi](./raspberrypi/)|
|Pi2           |`make rpi2`          |[rpi2](../../buildroot-external/configs/rpi2_defconfig)|[raspberrypi](./raspberrypi/)|
|ODROID-C2     |`make odroid_c2`     |[odroid_c2](../../buildroot-external/configs/odroid_c2_defconfig)|[hardkernel](./hardkernel/)|
|ODROID-C4     |`make odroid_c4`     |[odroid_c4](../../buildroot-external/configs/odroid_c4_defconfig)|[hardkernel](./hardkernel/)|
|ODROID-M1     |`make odroid_m1`     |[odroid_m1](../../buildroot-external/configs/odroid_m1_defconfig)|[hardkernel](./hardkernel/)|
|ODROID-N2/N2+ |`make odroid_n2`     |[odroid_n2](../../buildroot-external/configs/odroid_n2_defconfig)|[hardkernel](./hardkernel/)|
|ODROID-XU4    |`make odroid_xu4`    |[odroid_xu4](../../buildroot-external/configs/odroid_xu4_defconfig)|[hardkernel](./hardkernel/)|
|Tinker Board  |`make tinker`        |[tinker](../../buildroot-external/configs/tinker_defconfig)|[asus](./asus/)|
|Generic x86-64|`make generic_x86_64`|[generic_x86_64](../../buildroot-external/configs/generic_x86_64_defconfig)|[generic-x86-64](./generic-x86-64/)|
|OVA           |`make ova`           |[ova](../../buildroot-external/configs/ova_defconfig)|[ova](./ova/)|
