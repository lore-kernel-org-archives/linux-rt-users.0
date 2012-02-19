From: Lukasz Majewski <majess1982@gmail.com>
Subject: [Vortex86] External SPI
Date: Sun, 19 Feb 2012 23:17:47 +0100
Message-ID: <20120219231747.12c66365@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Andy O'Brien <aobrien@greenseainc.com>,
	platform-driver-x86@vger.kernel.org, linux-8086@vger.kernel.org,
	linux-iio@vger.kernel.org, Lukasz Majewski <majess1982@gmail.com>,
	linux-embedded@vger.kernel.org, soc@dmp.com.tw
To: linux-rt-users@vger.kernel.org
Return-path: <linux-8086-owner@vger.kernel.org>
Sender: linux-8086-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi all,

I posses a Vortex86DX SoC based computer.

According to the spec it has two SPI interfaces - namely: internal -
access to BIOS and external, which is connected to serial memory
(MX25L3205 [1])

My application requires reading data from SPI sensor. I've given a shot
for a bitbang SPI driver. It worked, but slow access to
GPIOs caused a very slow transmission. 

For speed up I've decided to unsolder the memory [1] and solder the
sensor (via 8cm cables).

Unfortunately, documents provided from DM&P[2]:  [3] , [4] give some
hints on setting up a base address to get access to the SPI memory
region, and proper GPIO configuration.

What they DO NOT tell is how to perform the SPI transmission.

SPI controller address map:
BA is the Base Address

BA + 08h External SPI Output Data Register (8 bit transfer)
BA + 09h External SPI Input Register
BA + 0Ah External SPI Control Register
BA + 0Bh External SPI Status Register
BA + 0Ch External SPI Chip Select Register
BA + 0Dh External SPI Error Status Register

I've discovered that:
 - Access (read/write) to control register (CS) is not causing the clock
   generation
 - The Chip Select line is directly controlled by bit 0 (1 << 0) in the
   "Chip Select Regsiter". It must be explicitly changed (by writing
   data to the register) to toggle CS line state. After that the WCTE
   bit at "Error Status Register" is set to 1 (which means "controller
   busy")
 - To send data via SPI, one needs to write the data to the 8 bit
   "Output Data Register". It seems, that writing data starts clock
   generation. For correct transmission one needs to wait until the ODC
   bit at "Status Register" is set to 1.

The _problem_ is with reading data (with full or half duplex):

Inserting:
rx = inb(addr + 0x09); // "SPI Input Register" is not causing
reading data.

However:
Writing data to the "SPI Input Register":
   outb(0x00, addr + 0x09) // the CLK generation starts
   and waiting for IDR bit at "Status Register" set to 1, causes
   operation:
   rx = inb(addr + 0x09); 
   to read correct data.


The above only works when FIFO is enabled (bit FIEN - 4 at "Control
Register")

The problem is, that the sent data seems to be
somewhat random (e.g. the first/last send data) and
I don't have a feeling that I'm fully controlling the operation of SPI.

Conclusion:
 - outb is needed to force SPI block to start generating SCLK (also
   when one wants to read data).
 - FIFO is involved in reading data from SPI - I don't know how to
   control it.
 - It seems, that the controller is half-duplex.

I suspect, that this simple type of controller has been also used at
other SoC's. Maybe it is an FPGA based design, or some standard Intel's
chip (like 8255). I was asking "uncle google" but with no satisfactory
results.


Has someone dealt with a similar controller? Any advice? Hint?


links:
[1] MX25L3205 - SPI flash memory
http://www.mxic.com.tw/QuickPlace/hq/Main.nsf/h_Toc/5c179475fbb1d010482574440028bdf4/?OpenDocument
[2] http://www.dmp.com.tw/tech/vortex86dx/
[3] "DM&P Vortex86 Series (SX/DX/MX) Software Programming Reference"
[4] "Vortex86DX Fact Sheet 32-BIT x86 SoC"


Best regards,
Lukasz Majewski

