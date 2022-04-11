#!/usr/bin/env python

# AWFA by danito
# (c) 2022 - Danny Ismarianto Ruhiyat

# Astra DB's Build-A-Thon by DataStax and AngelHack

import struct
import smbus
import sys
import time

def readVoltage(bus):
    address = 0x36
    read = bus.read_word_data(address, 0X02)
    swapped = struct.unpack("<H", struct.pack(">H", read))[0]
    voltage = swapped * 1.25 /1000/16
    return voltage

def QuickStart(bus):
    address = 0x36
    bus.write_word_data(address, 0x06,0x4000)

def PowerOnReset(bus):
    address = 0x36
    bus.write_word_data(address, 0xfe,0x0054)

bus = smbus.SMBus(1)
PowerOnReset(bus)
QuickStart(bus)
time.sleep(1)

print "Voltage:%5.2fV" % readVoltage(bus)
