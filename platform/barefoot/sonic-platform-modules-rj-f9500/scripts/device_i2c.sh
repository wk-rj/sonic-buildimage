#!/bin/bash

sleep 1

/sbin/modprobe i2c_dev
if [ ! -e "/dev/i2c-0" ]; then
    echo "i2c-0 no ready!"
    /sbin/modprobe i2c_i801
else 
    echo "SMBUS exist, continue......"
fi

/sbin/modprobe i2c-algo-bit
/sbin/modprobe i2c_gpio
/sbin/modprobe rg-gpio-xeon
/sbin/modprobe i2c_mux
/sbin/modprobe i2c-mux-pca9641
/sbin/modprobe i2c-mux-pca954x
/sbin/modprobe ruijie_f9500_platform
/sbin/modprobe rg_fan
/sbin/modprobe rg_psu
/sbin/modprobe ipmi_msghandler
/sbin/modprobe ipmi_devintf
/sbin/modprobe ipmi_si

##add pca9641 first i2c-2
echo pca9641 0x10 > /sys/bus/i2c/devices/i2c-0/new_device
sleep 1
if [ ! -e "/dev/i2c-2" ]; then
    echo -e "\033[31m pca9641 no ready \033[0m"
    exit;
fi

echo pca9548 0x70 > /sys/bus/i2c/devices/i2c-2/new_device

#GPIO-I2C dev
echo pca9548 0x70 > /sys/bus/i2c/devices/i2c-1/new_device
echo pca9548 0x71 > /sys/bus/i2c/devices/i2c-1/new_device
echo pca9548 0x72 > /sys/bus/i2c/devices/i2c-1/new_device
echo pca9548 0x73 > /sys/bus/i2c/devices/i2c-1/new_device
echo pca9548 0x74 > /sys/bus/i2c/devices/i2c-1/new_device

/sbin/modprobe lm75
/sbin/modprobe tmp401
/sbin/modprobe eeprom
/sbin/modprobe rg_cpld

# cpld
echo rg_cpld 0x37 > /sys/bus/i2c/devices/i2c-2/new_device

# tmp
echo lm75 0x48 > /sys/bus/i2c/devices/i2c-2/new_device
echo lm75 0x49 > /sys/bus/i2c/devices/i2c-2/new_device
echo lm75 0x4a > /sys/bus/i2c/devices/i2c-2/new_device
echo tmp401 0x4c > /sys/bus/i2c/devices/i2c-2/new_device

# eeprom
echo eeprom 0x57 > /sys/bus/i2c/devices/i2c-2/new_device

# fan
echo rg_fan 0x53 > /sys/bus/i2c/devices/i2c-3/new_device
echo rg_fan 0x53 > /sys/bus/i2c/devices/i2c-4/new_device
echo rg_fan 0x53 > /sys/bus/i2c/devices/i2c-5/new_device
echo rg_fan 0x53 > /sys/bus/i2c/devices/i2c-6/new_device

# psu
echo rg_psu 0x50 > /sys/bus/i2c/devices/i2c-7/new_device
echo rg_psu 0x58 > /sys/bus/i2c/devices/i2c-7/new_device
echo rg_psu 0x53 > /sys/bus/i2c/devices/i2c-8/new_device
echo rg_psu 0x5b > /sys/bus/i2c/devices/i2c-8/new_device

# qsfp
for i in $(seq 11 44)
do
    echo eeprom 0x50 > /sys/bus/i2c/devices/i2c-$i/new_device
done

/usr/local/bin/health_monitor.py start &