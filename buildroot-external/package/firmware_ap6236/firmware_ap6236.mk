
FIRMWARE_AP6236_VERSION = 1.0.1
FIRMWARE_AP6236_LICENSE = Redistributable
FIRMWARE_AP6236_LICENSE_FILES = LICENSE
FIRMWARE_AP6236_SITE = $(call github,ophub,firmware,"7aa9141ff97a01a2eff1a16f7d6bc4bb71f7d08d")

define FIRMWARE_AP6236_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 644 $(@D)/firmware/brcm/brcmfmac43430-sdio.txt \
		$(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43430-sdio.txt
	ln -f -s firmware/brcm/brcmfmac43430-sdio.txt \
		$(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43430b0-sdio.txt
	$(INSTALL) -D -m 644 $(@D)/brcmfmac43430-sdio.bin \
		$(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43430-sdio.bin
	ln -f -s firmware/brcm/brcmfmac43430-sdio.bin \
		$(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43430b0-sdio.bin
	$(INSTALL) -D -m 644 $(@D)/firmware/brcm/brcmfmac43430-sdio.panther,x2.bin \
		$(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43430-sdio.panther,x2.bin
	ln -f -s firmware/brcm/brcmfmac43430-sdio.panther,x2.bin \
		$(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43430-sdio.panther,x2.bin
	$(INSTALL) -D -m 644 $(@D)/firmware/brcm/brcmfmac43430-sdio.panther,x2.txt \
		$(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43430-sdio.panther,x2.txt
	ln -f -s firmware/brcm/brcmfmac43430-sdio.panther,x2.txt \
		$(TARGET_DIR)/usr/lib/firmware/brcm/brcmfmac43430-sdio.panther,x2.txt
	$(INSTALL) -D -m 644 $(@D)/firmware/brcm/BCM43430B0.hcd \
		$(TARGET_DIR)/usr/lib/firmware/brcm/BCM43430B0.hcd
endef

$(eval $(generic-package))