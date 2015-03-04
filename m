From: mikhail.avkhimenia@emlid.com
Subject: 3.18 RT freezes on Raspberry Pi 2
Date: Wed, 04 Mar 2015 17:21:18 +0300
Message-ID: <3671201425478878@web10j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from forward12.mail.yandex.net ([95.108.130.94]:38380 "EHLO
	forward12.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150AbbCDObD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Mar 2015 09:31:03 -0500
Received: from web10j.yandex.ru (web10j.yandex.ru [5.45.198.51])
	by forward12.mail.yandex.net (Yandex) with ESMTP id AFCE6C221B1
	for <linux-rt-users@vger.kernel.org>; Wed,  4 Mar 2015 17:21:19 +0300 (MSK)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Recently, Raspberry Pi Foundation presented and started selling new Ras=
pberry Pi 2 SBC. It=E2=80=99s based on BCM2709 processor, which is an u=
pgraded version of BCM2708. The main difference is that old BCM2708 has=
 one core and its architecture is ARMv6, while the new BCM2709 has 4 co=
res and ARMv7 architecture. Most of the peripheral blocks are the same =
- DMA, I2C, UART, etc.=20

RT patch has been working very well (after fixing the sd driver a coupl=
e of years ago) with Raspberry Pi 1 and kernel 3.12.=20
With the release of the new board Raspberry Pi Foundation also switched=
 to the new kernel version - 3.18, support for Raspberry Pi 2 has been =
introduced in that version.
I applied patch-3.18.7-rt2 on RPi=E2=80=99s kernel fork and built two k=
ernels - one for Raspberry Pi 1 and another one for Raspberry Pi 2.
On older Raspberry Pi 1 3.18.7-rt2 seems to work without any problems, =
I ran cyclictest and stress and it performed well.=20
But on new Raspberry Pi 2 I=E2=80=99m experiencing frequent freezes.=20

Steps to reproduce:=20
1. Clone https://github.com/raspberrypi/linux , checkout 3.18.7 - 0be82=
f722c097340632a59b879fbfee9c6148f53
2. Apply patch-3.18.7-rt2
3. (optionally) apply =E2=80=9C[RT PATCH] mmc: sdhci: don't provide har=
d irq handler=E2=80=9D
4. Make menuconfig bcm2709_defconfig
5 Configure: full rt preemption, periodic ticks, performance governor a=
s default and optionally preemption debugging
6. Compile kernel & modules
7. Copy Image to /boot/kernel7.img and arch/arm/boot/dts/bcm2709-rpi-2-=
b.dtb to /boot/bcm2709-rpi-2-b.dtb, copy modules.
Boot and run: sudo cyclictest --smp -p51 -m

The bad thing is that it freezes without any message, even with preempt=
ion debug information and lockup detection enabled.

Here=E2=80=99s how it happens:
1. I connect to Raspberry Pi 2 over serial
2. I connect to Raspberry Pi 2 over Ethernet or WiFi
3. In the ssh terminal I run =E2=80=9Csudo cyclictest --smp -p51 -m=E2=80=
=9D, it works for 30 seconds and the terminal hangs. LEDs on WiFi or Et=
hernet connection stop blinking.
4. Serial terminal is still working, but after running a couple of comm=
ands it also freezes. If I try to run cyclictest on serial in that case=
 it mostly freezes immediately, but a couple of times it ran and displa=
yed that a couple of kernel are unavailable and after some time also fr=
oze.

If I run cyclictest on serial connection it also freezes regardless if =
WiFi or Ethernet are connected.

If I run =E2=80=9Csudo cyclictest --smp -p49 -m=E2=80=9D it does not fr=
eeze. So seems like it=E2=80=99s only affected when you run something w=
ith priority equal or higher than the priority of peripheral interrupt =
handlers.

Even though affinity mask for peripheral interrupts shows =E2=80=9Cf=E2=
=80=9D it seems that they all run on cpu0 by checking /proc/interrupts.=
 I tried adding =E2=80=9Cisolcpus=3D0=E2=80=9D to /boot/cmdline.txt and=
 with it the kernel does not freeze on =E2=80=9Csudo cyclictest --smp -=
p51 -m=E2=80=9D anymore. But it still freezes occasionally while workin=
g, it just takes much longer now to catch the freeze (30-60 minutes).

I=E2=80=99m trying to understand what causes such behaviour, as most of=
 the drivers for Raspberry Pi 1 and 2 are the same. I=E2=80=99ve ruled =
out mmc by completely disabling it in the kernel and running from USB f=
lash.=20

Any ideas what can be done to understand what is causing this?
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
