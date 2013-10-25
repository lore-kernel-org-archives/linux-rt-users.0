From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: All 3.10.x rt patched kernels are unusable on my machine
Date: Fri, 25 Oct 2013 20:51:22 +0200
Message-ID: <1382727082.656.24.camel@archlinux>
References: <1381746965.3978.27.camel@archlinux>
	 <20131025174537.GA21841@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail50c50.megamailservers.eu ([91.136.10.60]:59015 "EHLO
	mail50c50.megamailservers.eu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751321Ab3JYSvi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Oct 2013 14:51:38 -0400
In-Reply-To: <20131025174537.GA21841@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,

On Fri, 2013-10-25 at 19:45 +0200, Sebastian Andrzej Siewior wrote:
> * Ralf Mardorf | 2013-10-14 12:36:05 [+0200]:
> >non of the 3.10.x rt patched kernels does work on my machine.
> >
> >$ ls /usr/src/pkg-linux-rt/linux-rt-3*
> >/usr/src/pkg-linux-rt/linux-rt-3.10.10_rt7-1-x86_64.pkg.tar.xz
> >/usr/src/pkg-linux-rt/linux-rt-3.10.14_rt9-1-x86_64.pkg.tar.xz
> >/usr/src/pkg-linux-rt/linux-rt-3.10.15_rt11-1-x86_64.pkg.tar.xz
> >/usr/src/pkg-linux-rt/linux-rt-3.10.6_rt3-1-x86_64.pkg.tar.xz
> >/usr/src/pkg-linux-rt/linux-rt-3.10.9_rt5-01-x86_64.pkg.tar.xz
> >/usr/src/pkg-linux-rt/linux-rt-3.8.11_rt8-1-x86_64.pkg.tar.xz
> >/usr/src/pkg-linux-rt/linux-rt-3.8.13_rt10-1-x86_64.pkg.tar.xz
> >/usr/src/pkg-linux-rt/linux-rt-3.8.13_rt11-1-x86_64.pkg.tar.xz
> >/usr/src/pkg-linux-rt/linux-rt-3.8.13_rt12-1-x86_64.pkg.tar.xz
> >/usr/src/pkg-linux-rt/linux-rt-3.8.13_rt13-1-x86_64.pkg.tar.xz
> >/usr/src/pkg-linux-rt/linux-rt-3.8.13_rt14-1-x86_64.pkg.tar.xz
> >/usr/src/pkg-linux-rt/linux-rt-3.8.13_rt9-1-x86_64.pkg.tar.xz
> 
> so 3.8 works then?

Yes.

$ uname -rm
3.8.13-rt14-1-rt x86_64

> >It's not only on my main install, Arch Linux 64-bit architecture, I
> >verified the issue by building a 3.10.x rt patched kernel for Ubuntu
> >64-bit architecture too.
> 
> Interresting. The Debian people got it work
>   http://packages.debian.org/wheezy-backports/linux-image-3.10-0.bpo.2-rt-amd64
> 
> so I guess the problem is with you hardware.
> 
> >$ ls /mnt/q/boot/vmlinuz*
> >/mnt/q/boot/vmlinuz-3.10.9-rt5  /mnt/q/boot/vmlinuz-3.5.0-18-lowlatency  /mnt/q/boot/vmlinuz-3.6.5-rt14
> >
> >There were no issues without the rt patch for 3.10 kernels and no issues
> >with kernel versions < 3.10.x with and without rt patch.
> 
> that means you take the .config from the non-RT test, enable PREEMPT RT
> and after the recompile you don't get into X?

Yesno, for Ubuntu I use the .config from earlier linux-rts I build and
then run make oldconfig and for Arch I use a .config from a user
repository. Sure, there was a day, when I used a non-rt config for
Ubuntu and even nowadays I sometimes edit the config not only by make
oldconfig.

> >Usually login doesn't work from lightdm, sometimes it does work, but
> >after a short while terminals hang and the prompt gets lost, switching
> >to tty by Ctrl + Alt + F-keys then doesn't work.
> 
> This could be driver issue. But it is hard to guess :)
> 
> >Last time I could login, I got
> >
> >$ cat .xsession-errors.rt11
> >find: `/home/rocketmouse/.Xauthority.??????': No such file or directory
> >weather-Message: getting
> >http://api.yr.no/weatherapi/locationforecastlts/1.1/?lat=51.466702;lon=6.850000;msl=38
> >PolicyKit daemon disconnected from the bus.
> >We are no longer a registered authentication agent.
> >xfce4-appfinder: Fatal IO error 11 (Resource temporarily unavailable) on
> >X server :0.0.
> 
> I can't even say if this is good or bad. Maybe your X just crashed or
> not started at all.
> 
> >Any info needed about my hardware, from journalctl the kernel's config
> >or something else?
> 
> You try to connect an uart cable to year serial port and capture the
> kernel's output.

I don't know how to do this, but I suspect I at least need a second
computer?! So this is not an option, at least not on the fly.

>  Maybe it shows what is wrong. Information about the
> platform is probably usefull, too. Do you use only kernel modules from
> kernel.org or do you have any out of tree patches / driver like graphics
> driver, etc?

For Ubuntu, where I do everything myself, I only use the patches from
kernel.org. For Arch there sometimes are additional patches.

E.g. https://aur.archlinux.org/packages/li/linux-rt/linux-rt.tar.gz ,
for linux-rt 3.10.15_rt11-1 it's only this one:

diff -upr linux-3.0.orig/kernel/printk.c linux-3.0/kernel/printk.c
--- linux-3.0.orig/kernel/printk.c	2011-07-22 05:17:23.000000000 +0300
+++ linux-3.0/kernel/printk.c	2011-07-27 14:43:07.000000000 +0300
@@ -58,7 +58,7 @@ void asmlinkage __attribute__((weak)) ea
 
 /* We show everything that is MORE important than this.. */
 #define MINIMUM_CONSOLE_LOGLEVEL 1 /* Minimum loglevel we let people use */
-#define DEFAULT_CONSOLE_LOGLEVEL 7 /* anything MORE serious than KERN_DEBUG */
+#define DEFAULT_CONSOLE_LOGLEVEL 4 /* anything MORE serious than KERN_WARNING */
 
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 

#### audio cards
$ ls -l /proc/asound/ | grep lr
lrwxrwxrwx 1 root root 5 Oct 25 20:25 EWX2496 -> card1
lrwxrwxrwx 1 root root 5 Oct 25 20:25 EWX2496_1 -> card2
lrwxrwxrwx 1 root root 5 Oct 25 20:25 HDSPMx579bcc -> card0
lrwxrwxrwx 1 root root 5 Oct 25 20:25 nanoKONTROL -> card3
lrwxrwxrwx 1 root root 5 Oct 25 20:25 U0x170b0x11 -> card4

#### graphics
$ hwinfo --gfxcard
27: PCI 105.0: 0300 VGA compatible controller (VGA)             
  [Created at pci.319]
  Unique ID: ul7N.A_MYUPeZ6pD
  Parent ID: vSkL.Objt6VSItgC
  SysFS ID: /devices/pci0000:00/0000:00:01.0/0000:01:05.0
  SysFS BusID: 0000:01:05.0
  Hardware Class: graphics card
  Model: "ATI RS690 [Radeon X1200 Series]"
  Vendor: pci 0x1002 "ATI Technologies Inc"
  Device: pci 0x791e "RS690 [Radeon X1200 Series]"
  SubVendor: pci 0x1043 "ASUSTeK Computer Inc."
  SubDevice: pci 0x826d 
  Driver: "radeon"
  Driver Modules: "drm"
  Memory Range: 0xd0000000-0xdfffffff (ro,non-prefetchable)
  Memory Range: 0xfdff0000-0xfdffffff (rw,non-prefetchable)
  I/O Ports: 0xce00-0xceff (rw)
  Memory Range: 0xfde00000-0xfdefffff (rw,non-prefetchable)
  IRQ: 42 (6497 events)
  I/O Ports: 0x3c0-0x3df (rw)
  Module Alias: "pci:v00001002d0000791Esv00001043sd0000826Dbc03sc00i00"
  Driver Info #0:
    Driver Status: radeon is active
    Driver Activation Cmd: "modprobe radeon"
  Config Status: cfg=new, avail=yes, need=no, active=unknown
  Attached to: #9 (PCI bridge)

Primary display adapter: #27

#### RAM
$ hwinfo --memory
01: None 00.0: 10102 Main Memory                                
  [Created at memory.66]
  Unique ID: rdCR.CxwsZFjVASF
  Hardware Class: memory
  Model: "Main Memory"
  Memory Range: 0x00000000-0xe78c6fff (rw)
  Memory Size: 3 GB + 512 MB
  Config Status: cfg=new, avail=yes, need=no, active=unknown

#### CPU
#### Now it's running ondemand, but it's a 2.1 GHz CPU, 2 cores.
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 107
model name	: AMD Athlon(tm) X2 Dual Core Processor BE-2350
stepping	: 2
cpu MHz		: 1000.000
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt rdtscp
lm 3dnowext 3dnow rep_good nopl extd_apicid pni cx16 lahf_lm cmp_legacy
svm extapic cr8_legacy 3dnowprefetch lbrv
bogomips	: 1999.69
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc 100mhzsteps

processor	: 1
[snip]

#### Mobo ASUS M2A-VM HDMI
#### The RME isn't a MADI, it's a HDSPe AIO [1]
$ lspci
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI] RS690 Host Bridge
00:01.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RS690 PCI to PCI Bridge (Internal gfx)
00:06.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RS690 PCI to PCI Bridge (PCI Express Port 2)
00:07.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RS690 PCI to PCI Bridge (PCI Express Port 3)
00:12.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI] SB600 Non-Raid-5 SATA
00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB600 USB (OHCI0)
00:13.1 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB600 USB (OHCI1)
00:13.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB600 USB (OHCI2)
00:13.3 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB600 USB (OHCI3)
00:13.4 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB600 USB (OHCI4)
00:13.5 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB600 USB Controller (EHCI)
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus Controller (rev 14)
00:14.1 IDE interface: Advanced Micro Devices, Inc. [AMD/ATI] SB600 IDE
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD/ATI] SB600 PCI to LPC Bridge
00:14.4 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 PCI to PCI Bridge
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
01:05.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] RS690 [Radeon X1200]
02:00.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall DSP MADI (rev d4)
03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168 PCI Express Gigabit Ethernet controller (rev 01)
04:05.0 Multimedia audio controller: VIA Technologies Inc. ICE1712 [Envy24] PCI Multi-Channel I/O Controller (rev 02)
04:06.0 Multimedia audio controller: VIA Technologies Inc. ICE1712 [Envy24] PCI Multi-Channel I/O Controller (rev 02)
04:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6306/7/8 [Fire II(M)] IEEE 1394 OHCI Controller (rev c0)

[1] $ hdspmixer
Card 0: RME AIO S/N 0x579bcc at 0xfddf0000, irq 18
RME AIO found!
Card 1: TerraTec EWX24/96 at 0xbf00, irq 20
Card 2: TerraTec EWX24/96 at 0xbb00, irq 21
Card 3: KORG INC. nanoKONTROL at usb-0000:00:13.3-1, full speed
Card 4: USB Device 0x170b:0x11 at usb-0000:00:13.0-2, full speed

Regards,
Ralf

