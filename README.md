# AWFA - Attaché for Work From Anywhere

The **AWFA** prototype device is using [Google Coral Dev Board](https://coral.ai/docs/dev-board/get-started) as a main processing / computing unit. Please follow these steps to prepare the working **AWFA** prototype device (these steps are for macOS operating system):

#### 1.1. Flash the Google Coral Dev Board ####

* Download and unzip the SD card image: [enterprise-eagle-flashcard-20211117215217.zip](https://mendel-linux.org/images/enterprise/eagle/enterprise-eagle-flashcard-20211117215217.zip); The ZIP contains one file named `flashcard_arm64.img`
* Use a program such as [balenaEtcher](https://www.balena.io/etcher/) to flash the `flashcard_arm64.img` file to your microSD card; but I prefer use [Raspberry Pi Imager](https://downloads.raspberrypi.org/imager/) for smaller download size. This takes 5-10 minutes, depending on the speed of your microSD card and adapter (I suggest to use a Class-10 U3 microSD or faster).
* While the card is being flashed, make sure the Google Coral Dev Board is completely unplugged, and change the boot mode switches to boot from SD card, as shown in figure 1.
* Once the card is flashed, safely remove it from your computer and insert it into the Dev Board (the card's pins face toward the board). The board should **NOT** be powered on yet.
* Power up the board by connecting your 2-3 A power cable to the USB-C port labeled "PWR" (see figure 3). The board's red LED should turn on.
