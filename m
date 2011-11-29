From: Chris Edwards <cedwards@ripples.dyndns.org>
Subject: Re: IRQ "nobody cared...Disabling" errors on linux-3.0.10-rt27 on
 SMP AMD64 system
Date: Tue, 29 Nov 2011 15:25:05 +1300
Message-ID: <4ED44281.6010500@ripples.dyndns.org>
References: <4ECCE979.5080109@cedwards.geek.nz> <1322056363.20742.45.camel@frodo> <4ECD7DCC.3000505@ripples.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.kinect.co.nz ([202.74.33.69]:52675 "EHLO kinect.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751150Ab1K2CZ0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Nov 2011 21:25:26 -0500
Received: from mail01.kinect.co.nz (mail01.kinect.co.nz [202.74.33.70])
	by mx1.kinect.co.nz  with ESMTP id pAT2PLs7027827-pAT2PLs9027827
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=CAFAIL)
	for <linux-rt-users@vger.kernel.org>; Tue, 29 Nov 2011 15:25:22 +1300
Received: from [116.251.188.53] (helo=[192.168.5.64])
	by mail01.kinect.co.nz with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <cedwards@ripples.dyndns.org>)
	id 1RVDNp-0002Kk-HH
	for linux-rt-users@vger.kernel.org; Tue, 29 Nov 2011 15:25:21 +1300
In-Reply-To: <4ECD7DCC.3000505@ripples.dyndns.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Further to my previous posts...

I don't know much about ACPI and how interrupt routing is supposed to 
work (especially on more complex systems such as this).  AFAICT, this 
board has three PCI expansion buses (not including the AGP port), 
arranged like so (ASCII art at left is supposed to be the physical 
layout of the slots on the board):

   ====|==|==    AGP
=======|==      PCI 32-bit 33 MHz, PCI bus 01 (on nForce3),  BIOS slot # 1
==|=======|===  PCI-X,             PCI bus 04 (on AMD 8131), BIOS slot # 4
==|=======|===  PCI-X,             PCI bus 04 (on AMD 8131), BIOS slot # 5
==|=======|===  PCI 64-bit 66 MHz, PCI bus 05 (on AMD 8131), BIOS slot # 2
==|=======|===  PCI 64-bit 66 MHz, PCI bus 05 (on AMD 8131), BIOS slot # 3

Onboard Firewire/IEEE 1394 controller is also on PCI bus 01.
Onboard SiI 3114 SATA controller is also on PCI bus 06.

(This is based on what `biosdecode` and `lspci` report.  Actually, the 
bus numbering changes depending on what cards are installed: I have a 
RAID card with a PCI bridge on it that bumps the higher bus numbers around.)


# biosdecode
# biosdecode 2.9
BIOS32 Service Directory present.
     Revision: 0
     Calling Interface Address: 0x000F0010
PCI Interrupt Routing 1.0 present.
     Router ID: 00:01.0
     Exclusive IRQs: None
     Compatible Router: 10de:00e0
     Slot Entry 1: ID 00:01, on-board
     Slot Entry 2: ID 00:02, on-board
     Slot Entry 3: ID 00:05, on-board
     Slot Entry 4: ID 00:06, on-board
     Slot Entry 5: ID 00:0b, on-board
     Slot Entry 6: ID 00:09, on-board
     Slot Entry 7: ID 00:0a, on-board
     Slot Entry 8: ID 01:07, slot number 1
     Slot Entry 9: ID 01:06, on-board
     Slot Entry 10: ID 05:01, slot number 2
     Slot Entry 11: ID 05:02, slot number 3
     Slot Entry 12: ID 04:01, slot number 4
     Slot Entry 13: ID 04:02, slot number 5
     Slot Entry 14: ID 05:03, on-board
PNP BIOS 1.0 present.
     Event Notification: Not Supported
     Real Mode 16-bit Code Address: F000:57D2
     Real Mode 16-bit Data Address: F000:0000
     16-bit Protected Mode Code Address: 0x000F57FA
     16-bit Protected Mode Data Address: 0x000F0000
ACPI 2.0 present.
     OEM Identifier: ACPIAM
     RSD Table 32-bit Address: 0xBFF40000
     XSD Table 64-bit Address: 0x00000000BFF40100
SMBIOS 2.3 present.
     Structure Table Length: 1933 bytes
     Structure Table Address: 0x000FA2F0
     Number Of Structures: 47
     Maximum Structure Size: 182 bytes


# lspci
00:00.0 Host bridge: nVidia Corporation nForce3 250Gb Host Bridge (rev a1)
00:01.0 ISA bridge: nVidia Corporation nForce3 250Gb LPC Bridge (rev a2)
00:01.1 SMBus: nVidia Corporation nForce 250Gb PCI System Management 
(rev a1)
00:02.0 USB Controller: nVidia Corporation CK8S USB Controller (rev a1)
00:02.1 USB Controller: nVidia Corporation CK8S USB Controller (rev a1)
00:02.2 USB Controller: nVidia Corporation nForce3 EHCI USB 2.0 
Controller (rev a2)
00:05.0 Ethernet controller: nVidia Corporation CK8S Ethernet Controller 
(rev a2)
00:08.0 IDE interface: nVidia Corporation CK8S Parallel ATA Controller 
(v2.5) (rev a2)
00:0a.0 IDE interface: nVidia Corporation nForce3 Serial ATA Controller 
(rev a2)
00:0b.0 PCI bridge: nVidia Corporation nForce3 250Gb AGP Host to PCI 
Bridge (rev a2)
00:0e.0 PCI bridge: nVidia Corporation nForce3 250Gb PCI-to-PCI Bridge 
(rev a2)
00:17.0 Communication controller: nVidia Corporation Device 00ec (rev a1)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
DRAM Controller
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
01:06.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A 
IEEE-1394a-2000 Controller (PHY/Link)
01:07.0 Multimedia controller: Motorola DSP56361 Digital Signal Processor
02:00.0 VGA compatible controller: ATI Technologies Inc R420 JP [Radeon 
X800XT]
02:00.1 Display controller: ATI Technologies Inc R420 [X800XT-PE] 
(Secondary)
03:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge 
(rev 12)
03:01.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
03:02.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge 
(rev 12)
03:02.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
05:02.0 Ethernet controller: Intel Corporation 82545GM Gigabit Ethernet 
Controller (rev 04)
05:03.0 Mass storage controller: Silicon Image, Inc. SiI 3114 
[SATALink/SATARaid] Serial ATA Controller (rev 02)


There seem to be 3 IOAPICs: one on the nForce3, I presume, and two on 
the AMD 8131.

# dmesg | grep -i ioapic
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 
0-23
[    0.000000] ACPI: IOAPIC (id[0x03] address[0xfebfe000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 3, version 17, address 0xfebfe000, GSI 
24-27
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfebff000] gsi_base[28])
[    0.000000] IOAPIC[2]: apic_id 4, version 17, address 0xfebff000, GSI 
28-31
[    0.143685] ACPI: Using IOAPIC for interrupt routing

So it seems the problematic IRQs are both on the nForce3: the onboard 
Firewire controller and the Gina24 sound card (IRQs 17 and 18) are both 
on the nForce3's 32-bit 33 MHz PCI bus, and both experience those "irq 
... nobody cared" errors.  I can't move the Gina24 sound card, as the 
other slots are keyed for a different voltage, and moving the on-board 
Firewire controller is obviously not an option either. :)

I also noticed the following groups of kernel messages, which might be 
of use to someone:

[    0.165850] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.166337] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.184280] ACPI: PCI Interrupt Routing Table [\_SB_.PCIB.GOLA._PRT]
[    0.184550] ACPI: PCI Interrupt Routing Table [\_SB_.PCIB.GOLB._PRT]

[    0.185842] ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *0, 
disabled.
[    0.186111] ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *0, 
disabled.
[    0.186366] ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *11
[    0.186621] ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *9
[    0.186876] ACPI: PCI Interrupt Link [LNKE] (IRQs 16 17 18 19) *11
[    0.187127] ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22) *11
[    0.187364] ACPI: PCI Interrupt Link [LUS1] (IRQs 20 21 22) *7
[    0.187601] ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22) *5
[    0.187844] ACPI: PCI Interrupt Link [LKLN] (IRQs 20 21 22) *9
[    0.188099] ACPI: PCI Interrupt Link [LAUI] (IRQs 20 21 22) *0, disabled.
[    0.188338] ACPI: PCI Interrupt Link [LKMO] (IRQs 20 21 22) *0, disabled.
[    0.188578] ACPI: PCI Interrupt Link [LKSM] (IRQs 20 21 22) *9
[    0.188819] ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22) *0
[    0.189084] ACPI: PCI Interrupt Link [LTIE] (IRQs 20 21 22) *0, disabled.
[    0.189385] ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22) *14

[    3.076267] ACPI: PCI Interrupt Link [LTID] BIOS reported IRQ 0, 
using IRQ 22
[    3.076270] ACPI: PCI Interrupt Link [LTID] enabled at IRQ 22
[    3.087843] ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 21
[    3.095754] ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 20
[    3.149622] ACPI: PCI Interrupt Link [LUS1] enabled at IRQ 22
[    5.116414] ACPI: PCI Interrupt Link [LKLN] enabled at IRQ 21
[    6.803745] ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 19
[    7.073385] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 18
[    7.433420] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 17

[    3.076289] sata_nv 0000:00:0a.0: PCI INT A -> Link[LTID] -> GSI 22 
(level, low) -> IRQ 22
[    3.078327] sata_sil 0000:05:03.0: PCI INT A -> GSI 27 (level, low) 
-> IRQ 27
[    3.087859] ehci_hcd 0000:00:02.2: PCI INT C -> Link[LUS2] -> GSI 21 
(level, low) -> IRQ 21
[    3.095766] ohci_hcd 0000:00:02.0: PCI INT A -> Link[LUS0] -> GSI 20 
(level, low) -> IRQ 20
[    3.149626] ohci_hcd 0000:00:02.1: PCI INT B -> Link[LUS1] -> GSI 22 
(level, low) -> IRQ 22
[    5.116423] forcedeth 0000:00:05.0: PCI INT A -> Link[LKLN] -> GSI 21 
(level, low) -> IRQ 21
[    5.167149] e1000 0000:05:02.0: PCI INT A -> GSI 26 (level, low) -> 
IRQ 26
[    6.803787] pci 0000:02:00.0: PCI INT A -> Link[LNKE] -> GSI 19 
(level, low) -> IRQ 19
[    7.073410] Echoaudio Gina24 0000:01:07.0: PCI INT A -> Link[LNKD] -> 
GSI 18 (level, low) -> IRQ 18
[    7.433444] firewire_ohci 0000:01:06.0: PCI INT A -> Link[LNKC] -> 
GSI 17 (level, low) -> IRQ 17


Is the kernel "pirq" command-line parameter worth trying?  I'm not 
exactly sure how it works - it seems you specify sequences of numbers in 
groups of 4 corresponding to the IRQs that you want the kernel to use 
for each PCI IRQ (PIRQ).  Does the ordering of these quads correspond to 
the PCI bus numbering?  (In my case, I have PCI buses 00, 01, 02, 03, 04 
and 05, but would bus 00 (nForce3 host bridge), 02 (AGP) and 03 (AMD 
8131 bridges) be excluded?)  And how would I know what system IRQ number 
to specify at each position?  Should they be chosen to match the BIOS 
IRQ numbers reported at POST?

Also, are there any disadvantages to running with "noapic" as a 
permanent fix?  Performance? Increased IRQ sharing?

Thanks again,
Chris

