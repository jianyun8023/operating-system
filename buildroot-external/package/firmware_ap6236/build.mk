
FIRMWARE_AP6236_VERSION = 1.0.0
FIRMWARE_AP6236_LICENSE = Redistributable
FIRMWARE_AP6236_LICENSE_FILES = LICENSE
FIRMWARE_AP6236_SITE = $(call github,OtterCast,broadcom-firmware,v$(FIRMWARE_AP6236_VERSION))

define FIRMWARE_AP6236_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 644 $(@D)/brcmfmac43430-sdio.txt \
		$(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43430-sdio.txt
	ln -f -s brcmfmac43430-sdio.txt \
		$(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43430b0-sdio.txt
	$(INSTALL) -D -m 644 $(@D)/brcmfmac43430-sdio.bin \
		$(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43430-sdio.bin
	ln -f -s brcmfmac43430-sdio.bin \
		$(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43430b0-sdio.bin
	$(INSTALL) -D -m 644 $(@D)/BCM4343B0.hcd \
		$(TARGET_DIR)/usr/lib/firmware/brcm/BCM.hcd
endef

$(eval $(generic-package))