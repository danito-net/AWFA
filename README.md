# AWFA - Attaché for Work From Anywhere

The **AWFA** prototype device is using these materials:

1. [Google Coral Dev Board](https://coral.ai/docs/dev-board/get-started) as a main processing / computing unit and for audio input using microphone, also for audio output directly to the speakers
2. [Google Coral Camera Module](https://coral.ai/products/camera) for imaging (as a vision sensor)
3. [Raspberry Pi 4G HAT](https://wiki.52pi.com/index.php?title=EP-0128) ; this HAT not using the GPIO but the USB connection. We don't need the fan for more compact size and less energy consumption
4. Huawei ME909s-821 mini PCIe module 4G LTE Cat4 GSM GPS FDD/TDD 150Mbps for 4G internet connection
5. [UPS-18650 Lite](https://www.tindie.com/products/rachel/ups-18650-lite-a-power-platform-for-raspberry-pi/) ; We can use this Raspberry Pi's HAT power platform, because of Google Coral Dev Board is using the same GPIO pinout mapping as Raspberry Pi. Also we need two 18650 batteries with .
6. [E108-GN02D](https://www.ebyte.com/en/product-view-news.html?id=1125) GPS Module (using serial connection to GPIO)
7. USB Wireless Micro Router [GL-USB150](https://www.gl-inet.com/products/gl-usb150/)
8. Stereo speakers (@ 1 Watt 8 Ohm) ; for this project I use these [speakers](https://www.waveshare.com/wm8960-audio-hat.htm) without the module


#### 1.1. Flash the Google Coral Dev Board ####

* Download and unzip the SD card image: [enterprise-eagle-flashcard-20211117215217.zip](https://mendel-linux.org/images/enterprise/eagle/enterprise-eagle-flashcard-20211117215217.zip); The ZIP contains one file named `flashcard_arm64.img`
* Use a program such as [balenaEtcher](https://www.balena.io/etcher/) to flash the `flashcard_arm64.img` file to your microSD card; but I prefer use [Raspberry Pi Imager](https://downloads.raspberrypi.org/imager/) for smaller download size. 

![](https://awfa.danito.id/images/balena-etcher-vs-raspberry-pi-imager-480px.jpg)

* This will takes about 5-10 minutes, depending on the speed of your microSD card and adapter (I suggest to use a Class-10 U3 microSD or faster).

![](https://awfa.danito.id/images/awfa-microsd-card-class10-u3-640px.jpg)

* While the card is being flashed, make sure the Google Coral Dev Board is completely unplugged, and change the boot mode switches to boot from SD card, as shown here:

![](https://awfa.danito.id/images/awfa-google-coral-sdcard-boot-mode-switch-640px.jpg)

* Once the card is flashed, safely remove it from your computer and insert it into the Dev Board (the card's pins face toward the board). The board should **NOT** be powered on yet.
* Power up the board by connecting your 2-3 A power cable to the USB-C port labeled "PWR". The board's red LED should turn on. **Caution:** Do not attempt to power the board by connecting it to your computer.
* When the board boots up, it loads the SD card image and begins flashing the board's eMMC memory.  It should finish in 5-10 minutes, depending on the speed of your microSD card.  You'll know it's done when the board shuts down and the red LED turns off.
* When the red LED turns off, unplug the power and remove the microSD card.
* Change the boot mode switches to eMMC mode, as shown here:

![](https://awfa.danito.id/images/awfa-google-coral-emmc-boot-mode-switch-640px.jpg)

* Connect the board to power and it should now boot up Mendel Linux. Booting up for the first time after flashing takes about 3 minutes (subsequent boot times are much faster). 


#### 1.2. Connecting SSH via Serial MicroUSB using macOS ####

* Download the [CP210x driver](https://www.silabs.com/documents/public/software/Mac_OSX_VCP_Driver.zip) for macOS; then unzip the ZIP file and install the driver
* Connect your computer to the board with the micro-B USB cable, and connect the board to power, as shown here:

![](https://awfa.danito.id/images/awfa-ssh-via-serial-microusb-640px.jpg)

* Verify the CP210x driver is working by running this command:

    `ls /dev/cu*`

![](https://awfa.danito.id/images/awfa-ssh-via-serial-microusb-640px-1.jpg)

You should see `/dev/cu.SLAB_USBtoUART` listed. If not, either there's a problem with your USB cable or the driver is not loaded. You can load the driver with `sudo kextload /Library/Extensions/SiLabsUSBDriver.kext` and then go to the system Security & Privacy preferences and click Allow. Also try unplugging the micro-USB cable on the Dev Board, then replug it and try again. Or, you also might need reboot your computer.

![](https://awfa.danito.id/images/awfa-ssh-via-serial-microusb-640px-2.jpg)


#### 1.19. Setting Virtual Environment, Install PIP and Install DataStax Python Driver ####

    sudo apt install python3-venv
    python3 -m venv awfa-env
    source awfa-env/bin/activate
    wget https://bootstrap.pypa.io/get-pip.py
    sudo python3 get-pip.py
    pip install cassandra-driver
    python -c 'import cassandra; print (cassandra.__version__)'
    


#### 1.20. Make an Automatic Script Running on Boot ####

* Placed the main script for AWFA device on Google Coral default user home directory (`/home/mendel/awfa.sh`).
* Make that script executable: `chmod +x /home/mendel/awfa.sh`
* Add that script to the cron table on Mendel Linux: `crontab -e`
* Add this line into the cron table on Mendel Linux, and then save it:


`    @reboot bash /home/mendel/awfa.sh `

    
    
