# initramfs-tools package

IGB_DRIVER_VERSION = 5.3.5.4
export IGB_DRIVER_VERSION

IGB_DRIVER = igb.ko
$(IGB_DRIVER)_SRC_PATH = $(SRC_PATH)/igb
SONIC_MAKE_DEBS += $(IGB_DRIVER)