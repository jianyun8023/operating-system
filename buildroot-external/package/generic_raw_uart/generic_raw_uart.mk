################################################################################
#
# Generic raw uart kernel module for low-latency uart
# communication with a RPI-RF-MOD/HM-MOD-RPI-PCB/HmIP-RFUSB
#
# Copyright (c) 2021-2022 Alexander Reinert
# https://github.com/alexreinert/piVCCU/tree/master/kernel
#
# Uses parts of bcm2835_raw_uart.c
# Copyright (c) 2015 eQ-3 Entwicklung GmbH
# https://github.com/eq-3/occu/tree/master/KernelDrivers
# https://github.com/jens-maus/RaspberryMatic/tree/master/buildroot-external/package/bcm2835_raw_uart
#
################################################################################

GENERIC_RAW_UART_VERSION = 1fc8bcc306e509bb32950b6f8d9e3bc64a6ad674
GENERIC_RAW_UART_SITE = $(call github,alexreinert,piVCCU,$(GENERIC_RAW_UART_VERSION))
GENERIC_RAW_UART_LICENSE = GPL2
GENERIC_RAW_UART_LICENSE_FILES = LICENSE
GENERIC_RAW_UART_MODULE_SUBDIRS = kernel

define GENERIC_RAW_UART_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_DISABLE_OPT,CONFIG_WERROR)
endef

$(eval $(kernel-module))
$(eval $(generic-package))
