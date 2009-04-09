From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: About "error mounting as ext3" when using 2.6.29-rt2 on Fedora.
Date: Thu, 9 Apr 2009 16:36:17 +0900
Message-ID: <49b7c2350904090036h7182d547u952c52b94c2e18c0@mail.gmail.com>
References: <49b7c2350904021920o1fbffeffn22b9fa7ea1365db1@mail.gmail.com>
	 <49b7c2350904031904w7fd63cc9o2c0f700a879e217@mail.gmail.com>
	 <alpine.LFD.2.00.0904040637480.12916@localhost.localdomain>
	 <49b7c2350904041951i2d984221qca33229dff6f0df4@mail.gmail.com>
	 <alpine.LFD.2.00.0904051606170.747@localhost.localdomain>
	 <49b7c2350904080611s35947c65q87baa8183c69ec7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:10587 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbZDIHgT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Apr 2009 03:36:19 -0400
Received: by yx-out-2324.google.com with SMTP id 31so540669yxl.1
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Apr 2009 00:36:17 -0700 (PDT)
In-Reply-To: <49b7c2350904080611s35947c65q87baa8183c69ec7c@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Below is test result about Quad CPU Q8200.
When I boot with linux-2.6.29-rt2 on Intel Core2 Quad CPU Q8200, I
still meet below error.
(http://leemgs1.googlecode.com/files/kernel-error-2.6.29-rt2-core2quad-=
q8200.PNG)
--------------------------------------------------
Process IRQ-25 (pid: 309, ti=3Df73d6000 task=3Df73d4530 task.ti=3Df73d6=
000)
Stack:
=4673d6f68 c016fa99 00000001 c016fa7c f7af97c0 00000019 f73d6f74 c0125a=
b1
00000000 f73d6f9c c017f17f 00000019 00000000 00000000 00000000 00000000
00000000 c0a25740 00000019 f73d6fd0 c017fc9d c0a257b0 c0a2579c 00000246
Call Trace:
[<c016fa99>] ? tick_handle_periodic+0x1d/0x98
[<c016fa7c>] ? tick_handle_peroidic+0x0/0x98
[<c0125ab1>] ? hpet_interrupt_handler+0x3d/0x47
[<c017f17f>] ? handle_IRQ_event+0x136/0x2bb
[<c017fc9d>] ? do_irqd+0x247/0x3ee
[<c017fa56>] ? do_irqd+0x0/0x3ee
[<c017fa56>] ? do_irqd+0x0/0x3ee
[<c01620a4>] ? kthread+0x56/0x92
[<c016204e>] ? kthread+0x0/0x92
[<c010434f>] ? kthread_thread_helper+0x7/0x10
Code: 01 00 00 00 8b 15 d0 d9 b0 c0 11 15 c8 d9 b0 c0 e8 99 50 fe ff b8=
 44 42 a2
c0 ff 05 40 42 a2 c0 e8 b5 25 47 00 64 a1 0c 40 ab c0 <8b> 40 34 83 e0 =
03 83 f8
03 0f 94 c0 0f b6 c0 e8 aa 50 fe ff 5d
EIP: [<c016fa66>] tick_perioidic+0x6d/0x83 SS:ESP 0068:f73d6f50
CR2: 0000000000000034
---[ end trace 4eaa2a86a8e2da22 ]---
IRQ-25 used greates stack depth: 2376 bytes left
---[ end trace 4eaa2a86a8e2da23 ]---
--------------------------------------------------


So, I rebooted Q8200 Desktop with  default kernel of fedora9
(2.6.27.19-78.2.30.fc9 i686).

leemgs@fedora9#>  cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:        129          1          0          0   IO-APIC-edge      ti=
mer
  1:          8          7         38         38   IO-APIC-edge      i8=
042
  3:          1          1          0          0   IO-APIC-edge
  4:          0          0          1          1   IO-APIC-edge
  8:          5          6          3          2   IO-APIC-edge      rt=
c0
  9:          0          0          0          0   IO-APIC-fasteoi   ac=
pi
 12:       3428       3373       1268       1170   IO-APIC-edge      i8=
042
 16:        598        188        190        118   IO-APIC-fasteoi
ehci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb6, HDA Intel, nvidia, eth0
 17:       1628       1560       4013       3736   IO-APIC-fasteoi
uhci_hcd:usb4, uhci_hcd:usb7, ahci
 18:          0          0          0          0   IO-APIC-fasteoi
ehci_hcd:usb1, uhci_hcd:usb5, uhci_hcd:usb8
 22:          5          6          6          7   IO-APIC-fasteoi   et=
h1
NMI:          0          0          0          0   Non-maskable interru=
pts
LOC:      31544      19058      15874      23095   Local timer interrup=
ts
RES:       5041       5753       3876       4028   Rescheduling interru=
pts
CAL:        572        537        564        382   function call interr=
upts
TLB:        570        741        560        680   TLB shootdowns
TRM:          0          0          0          0   Thermal event interr=
upts
SPU:          0          0          0          0   Spurious interrupts
ERR:          0
MIS:          0
leemgs@fedora9#>
leemgs@fedora9#>
leemgs@fedora9#>  uname -a
Linux jplee 2.6.27.19-78.2.30.fc9.i686 #1 SMP Tue Feb 24 20:09:23 EST
2009 i686 i686 i386 GNU/Linux [jupyung@jplee ~]$ cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 23
model name	: Intel(R) Core(TM)2 Quad  CPU   Q8200  @ 2.33GHz
stepping	: 7
cpu MHz		: 2327.448
cache size	: 2048 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm constant_tsc
arch_perfmon pebs bts pni monitor ds_cpl est tm2 ssse3 cx16 xtpr
sse4_1 lahf_lm
bogomips	: 4654.89
clflush size	: 64
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 23
model name	: Intel(R) Core(TM)2 Quad  CPU   Q8200  @ 2.33GHz
stepping	: 7
cpu MHz		: 2327.448
cache size	: 2048 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 4
apicid		: 1
initial apicid	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm constant_tsc
arch_perfmon pebs bts pni monitor ds_cpl est tm2 ssse3 cx16 xtpr
sse4_1 lahf_lm
bogomips	: 4654.75
clflush size	: 64
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 23
model name	: Intel(R) Core(TM)2 Quad  CPU   Q8200  @ 2.33GHz
stepping	: 7
cpu MHz		: 2327.448
cache size	: 2048 KB
physical id	: 0
siblings	: 4
core id		: 2
cpu cores	: 4
apicid		: 2
initial apicid	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm constant_tsc
arch_perfmon pebs bts pni monitor ds_cpl est tm2 ssse3 cx16 xtpr
sse4_1 lahf_lm
bogomips	: 4654.76
clflush size	: 64
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 23
model name	: Intel(R) Core(TM)2 Quad  CPU   Q8200  @ 2.33GHz
stepping	: 7
cpu MHz		: 2327.448
cache size	: 2048 KB
physical id	: 0
siblings	: 4
core id		: 3
cpu cores	: 4
apicid		: 3
initial apicid	: 3
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm constant_tsc
arch_perfmon pebs bts pni monitor ds_cpl est tm2 ssse3 cx16 xtpr
sse4_1 lahf_lm
bogomips	: 4654.76
clflush size	: 64
power management:
leemgs@fedora9#>
leemgs@fedora9#>
leemgs@fedora9#>  lspci
bash: lspci: command not found
[jupyung@jplee ~]$ /sbin/lspci
00:00.0 Host bridge: Intel Corporation 4 Series Chipset DRAM
Controller (rev 03) 00:01.0 PCI bridge: Intel Corporation 4 Series
Chipset PCI Express Root Port (rev 03) 00:03.0 Communication
controller: Intel Corporation 4 Series Chipset HECI Controller (rev
03)
00:03.2 IDE interface: Intel Corporation 4 Series Chipset PT IDER
Controller (rev 03)
00:03.3 Serial controller: Intel Corporation 4 Series Chipset Serial
KT Controller (rev 03) 00:19.0 Ethernet controller: Intel Corporation
82567LF-3 Gigabit Network Connection (rev 02) 00:1a.0 USB Controller:
Intel Corporation 82801JD/DO (ICH10 Family) USB UHCI Controller #4
(rev 02)
00:1a.1 USB Controller: Intel Corporation 82801JD/DO (ICH10 Family)
USB UHCI Controller #5 (rev 02)
00:1a.2 USB Controller: Intel Corporation 82801JD/DO (ICH10 Family)
USB UHCI Controller #6 (rev 02)
00:1a.7 USB Controller: Intel Corporation 82801JD/DO (ICH10 Family)
USB2 EHCI Controller #2 (rev 02) 00:1b.0 Audio device: Intel
Corporation 82801JD/DO (ICH10 Family) HD Audio Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801JD/DO (ICH10 Family) PCI
Express Port 1 (rev 02)
00:1c.1 PCI bridge: Intel Corporation 82801JD/DO (ICH10 Family) PCI
Express Port 2 (rev 02)
00:1c.2 PCI bridge: Intel Corporation 82801JD/DO (ICH10 Family) PCI
Express Port 3 (rev 02)
00:1c.3 PCI bridge: Intel Corporation 82801JD/DO (ICH10 Family) PCI
Express Port 4 (rev 02)
00:1c.4 PCI bridge: Intel Corporation 82801JD/DO (ICH10 Family) PCI
Express Port 5 (rev 02)
00:1c.5 PCI bridge: Intel Corporation 82801JD/DO (ICH10 Family) PCI
Express Port 6 (rev 02) 00:1d.0 USB Controller: Intel Corporation
82801JD/DO (ICH10 Family) USB UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801JD/DO (ICH10 Family)
USB UHCI Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801JD/DO (ICH10 Family)
USB UHCI Controller #3 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801JD/DO (ICH10 Family)
USB2 EHCI Controller #1 (rev 02) 00:1e.0 PCI bridge: Intel Corporation
82801 PCI Bridge (rev a2) 00:1f.0 ISA bridge: Intel Corporation
82801JD (ICH10D) LPC Interface Controller (rev 02)
00:1f.2 SATA controller: Intel Corporation 82801JD/DO (ICH10 Family)
SATA AHCI Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801JD/DO (ICH10 Family) SMBus
Controller (rev 02) 01:00.0 VGA compatible controller: nVidia
Corporation Unknown device 0644 (rev a1) 09:01.0 Ethernet controller:
3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
leemgs@fedora9#>
leemgs@fedora9#>
leemgs@fedora9#>
leemgs@fedora9#>


On all of the tests, I seems that error case of linux-2.6.29-rt2 is
depenend on Desktop H/W Spec.




2009/4/8 GeunSik Lim <leemgs1@gmail.com>:
> I tested with howto that you explained.
> Sorry for my late response about your advice.
> Specially, Thank you for presentation about CFS scheduler
> at the 3rd korea technical jamboree last year.
>
> 2009/4/5 Thomas Gleixner <tglx@linutronix.de>:
>> On Sun, 5 Apr 2009, GeunSik Lim wrote:
>>> > Hmm. You said the same kernel works fine on other distros, right =
? Do
>>> > you use the same .config for the different distros. If not you co=
uld
>>> > try to build the kernel on fedora with the other-distro config.
>>> Yes.
>>> I used the same kernel on various distros as I said previously.
>>> ( config file :
>>> http://leemgs1.googlecode.com/files/i386.2.6.29-rt2.ftrace.config-i=
nvain-invain.20090402)
>>> for example,
>>> At first,I built linux-2.6.29.rt2 kernel source.
>>> And then, =C2=A0I tested
>>> kernel booting with this same kernel
>>> binary(ex:vmlinuz,Systemmap,initrd , /lib/modules/2.6.29.rt2) on ot=
her
>>> distros.
>>
>> Ok, can you try the following ? Boot into fedora, copy the fedora
>> config file into your -rt build directory and enable preempt-rt on
>> it. Now build the kernel and install it with "make modules_install
>> install". Does this work ?
> .
> I compiled -rt kernel source with gcc 4 on fedora 9 distribution
> directly as you said.
> I =C2=A0boot -rt kernel binary on fedora 9 distribution successfully =
about
> Q9300 target.
>
> But, I still can't boot -rt kernel binary on fedora 9 about Q8200 tar=
get.
> I will report tomorrow that I capture kernel error display with my
> digital camera.
>
> This is a summary report until now.
> ---------------------------------------------------------------------=
----------------------------------------------------------------
> CPU Info of Desktop/Netbook =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Kernel
> =C2=A0 =C2=A0 =C2=A0rootFS =C2=A0 =C2=A0 =C2=A0 =C2=A0Booting
> ---------------------------------------------------------------------=
----------------------------------------------------------------
> Intel Atom(TM) =C2=A0CPU N270 =C2=A0@ 1.60GHz / =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Linux-2.6.29-rt2
> Fedora 9 =C2=A0 =C2=A0 =C2=A0Success
> Intel Core(TM)2 Quad CPU Q6600 @2.40GHz =C2=A0 same as above =C2=A0 =C2=
=A0CentOS5.2 =C2=A0 Success
> Intel Core(TM)2 Quad CPU Q6600 @2.40GHz =C2=A0 same as above =C2=A0 =C2=
=A0Ubuntu8.04 =C2=A0Success
> Intel Core(TM)2 Quad CPU Q9300 @2.50GHz =C2=A0 same as above =C2=A0 =C2=
=A0Fedora9 =C2=A0 =C2=A0 =C2=A0 Success
> Intel Core(TM)2 Quad CPU Q8200 @2.33GHz =C2=A0 same as above =C2=A0 =C2=
=A0Fedora9
> =C2=A0Fail(still)
> ---------------------------------------------------------------------=
----------------------------------------------------------------
> * ref) I compiled -rt kernel source with gcc on each target board dir=
ectly.
>
> Thanks you for your help.
>>
>> Thanks,
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0tglx
>>
>
>
>
> --
> Regards,
> GeunSik Lim
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>



--=20
Regards,
GeunSik Lim
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
