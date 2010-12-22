From: Belisko Marek <marek.belisko@gmail.com>
Subject: RT 2.6.33.7.2-rt30 on s3c2440
Date: Wed, 22 Dec 2010 20:17:43 +0100
Message-ID: <AANLkTikge-9=xDViktq4TyL58PLc-_8MafB9p0rQsVmU@mail.gmail.com>
References: <AANLkTima1je6B2T4MqMiAHv+n88ubgRaz1mEadP0=+tV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:64758 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab0LVTRn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Dec 2010 14:17:43 -0500
Received: by qyj19 with SMTP id 19so6828068qyj.19
        for <linux-rt-users@vger.kernel.org>; Wed, 22 Dec 2010 11:17:43 -0800 (PST)
In-Reply-To: <AANLkTima1je6B2T4MqMiAHv+n88ubgRaz1mEadP0=+tV@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I'm completely new to RT problematics and try to run rt kernel on mini2=
440
board (s3c2440). First I apply rt patch to 2.6.33.7 kernel then fix
some compilation issues. Main issue is add support for HR timers to
(as I understand without HR realtime makes no sense). I made some
hacking =C2=A0and system seems boot correctly but
hang on:
sched: RT throttling activated.

It is related to schedule_clock function() which is missing in my
implementation?
s3c2440 have only 3 16 bit timers.Any ideas what to check?

Complete log:
Uncompressing Linux... done, booting the kernel.
Linux version 2.6.33.7.2-rt30 (open-nandra@linux) (gcc version 4.3.5
(Buildroot 2010.08-rc1) ) #14 PREEMPT RT Wed Dec 22 15:20:19 CET 2010
CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=3Dc0007177
CPU: VIVT data cache, VIVT instruction cache
Machine: MINI2440
Memory policy: ECC disabled, Data cache writeback
CPU S3C2440A (id 0x32440001)
S3C24XX Clocks, Copyright 2004 Simtec Electronics
S3C244X: core 405.000 MHz, memory 101.250 MHz, peripheral 50.625 MHz
CLOCK: Slow mode (1.500 MHz), fast, MPLL on, UPLL on
Built 1 zonelists in Zone order, mobility grouping on. =C2=A0Total page=
s: 16256
Kernel command line: root=3D/dev/mtdblock3 rootfstype=3Djffs2 console=3D=
ttySAC0,115200
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB =3D 64MB total
Memory: 59348KB available (4124K code, 1151K data, 156K init, 0K highme=
m)
Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
Experimental preemptable hierarchical RCU implementation.
NR_IRQS:85
irq: clearing pending status 02000000
irq: clearing subpending status 00000002
tcon=3D600000
Console: colour dummy device 80x30
console [ttySAC0] enabled
Calibrating delay loop... 201.93 BogoMIPS (lpj=3D504832)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
MINI2440: Option string mini2440=3D0tb
MINI2440: 't' ignored, touchscreen not compiled in
MINI2440: LCD [0:240x320] 1:800x480 2:1024x768
S3C2440: Initialising architecture
S3C2440: IRQ Support
S3C24XX DMA Driver, Copyright 2003-2006 Simtec Electronics
DMA channel 0 at c4808000, irq 33
DMA channel 1 at c4808040, irq 34
DMA channel 2 at c4808080, irq 35
DMA channel 3 at c48080c0, irq 36
S3C244X: Clock Support, DVS off
bio: create slab <bio-0> at 0
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
s3c-i2c s3c2440-i2c: slave address 0x10
s3c-i2c s3c2440-i2c: bus frequency set to 98 KHz
s3c-i2c s3c2440-i2c: i2c-0: S3C I2C adapter
Advanced Linux Sound Architecture Driver Version 1.0.21.
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 3, 57344 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
UDP hash table entries: 64 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 64 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
JFFS2 version 2.2. (NAND) =EF=BF=BD=C2=A9 2001-2006 Red Hat, Inc.
ROMFS MTD (C) 2007 Red Hat, Inc.
msgmni has been set to 116
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Console: switching to colour frame buffer device 60x53
fb0: s3c2410fb frame buffer device
s3c2440-uart.0: s3c2410_serial0 at MMIO 0x50000000 (irq =3D 70) is a S3=
C2440
s3c2440-uart.1: s3c2410_serial1 at MMIO 0x50004000 (irq =3D 73) is a S3=
C2440
s3c2440-uart.2: s3c2410_serial2 at MMIO 0x50008000 (irq =3D 76) is a S3=
C2440
brd: module loaded
at24 0-0050: 1024 byte 24c08 EEPROM (writable)
S3C24XX NAND Driver, (c) 2004 Simtec Electronics
s3c24xx-nand s3c2440-nand: Tacls=3D1, 9ns Twrph0=3D3 29ns, Twrph1=3D2 1=
9ns
s3c24xx-nand s3c2440-nand: NAND soft ECC
NAND device: Manufacturer ID: 0xec, Chip ID: 0xda (Samsung NAND 256MiB
3,3V 8-bit)
Creating 4 MTD partitions on "NAND 256MiB 3,3V 8-bit":
0x000000000000-0x000000040000 : "u-boot"
ftl_cs: FTL header not found.
0x000000040000-0x000000060000 : "u-boot-env"
ftl_cs: FTL header not found.
0x000000060000-0x000000560000 : "kernel"
ftl_cs: FTL header not found.
0x000000560000-0x000010000000 : "root"
ftl_cs: FTL header not found.
dm9000 Ethernet Driver, V1.31
eth0: dm9000e at c486e300,c4872304 IRQ 51 MAC: 08:08:11:18:12:27 (chip)
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
s3c2410-ohci s3c2410-ohci: S3C24XX OHCI
s3c2410-ohci s3c2410-ohci: new USB bus registered, assigned bus number =
1
s3c2410-ohci s3c2410-ohci: irq 42, io mem 0x49000000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usbcore: registered new interface driver libusual
s3c2440-usbgadget s3c2440-usbgadget: S3C2440: increasing FIFO to 128 by=
tes
mice: PS/2 mouse device common for all mice
input: gpio-keys as /devices/platform/gpio-keys/input/input0
S3C24XX RTC, (c) 2004,2006 Simtec Electronics
s3c2410-rtc s3c2410-rtc: rtc disabled, re-enabling
s3c2410-rtc s3c2410-rtc: rtc core: registered s3c as rtc0
i2c /dev entries driver
sched: RT throttling activated

thanks,

marek

--
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
=46reelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
icq: 290551086
web: http://open-nandra.com



--=20
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
=46reelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
icq: 290551086
web: http://open-nandra.com
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
