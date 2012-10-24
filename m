From: Uwaysi Bin Kareem <uwaysi.bin.kareem@paradoxuncreated.com>
Subject: Re: [ANNOUNCE] 3.6.2-rt4
Date: Wed, 24 Oct 2012 21:57:10 +0200
Message-ID: <op.wmo8dkvt6426ze@localhost.localdomain>
References: <alpine.LFD.2.02.1210202133470.2719@ionos>
 <op.wmk8f6m96426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210222029480.2756@ionos>
 <op.wmnlvqm76426ze@localhost.localdomain>
 <1B7B1319-351B-4E55-9BC7-DC8659605594@thebigcorporation.com>
 <op.wmobxtv66426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210241156380.2756@ionos>
 <op.wmoiyqew6426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210241621060.2756@ionos>
 <op.wmo0g1qc6426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210242037440.2756@ionos>
 <op.wmo45bu46426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210242123570.2756@ionos>
 <op.wmo67vqb6426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210242147550.2756@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7BIT
Cc: sven@thebigcorporation.com, linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp.getmail.no ([84.208.15.66]:40344 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754798Ab2JXT5Q (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2012 15:57:16 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0MCE00F8PY3EXF90@get-mta-out01.get.basefarm.net> for
 linux-rt-users@vger.kernel.org; Wed, 24 Oct 2012 21:57:14 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 0B2AC1F1A20B_88481AB	for <linux-rt-users@vger.kernel.org>; Wed,
 24 Oct 2012 19:57:14 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id A2DCB1F1A223_884819F	for <linux-rt-users@vger.kernel.org>; Wed,
 24 Oct 2012 19:57:13 +0000 (GMT)
Received: from localhost.localdomain ([84.211.57.6])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0MCE00AJTY3AWF40@get-mta-in03.get.basefarm.net> for
 linux-rt-users@vger.kernel.org; Wed, 24 Oct 2012 21:57:13 +0200 (MEST)
In-reply-to: <alpine.LFD.2.02.1210242147550.2756@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 24 Oct 2012 21:49:30 +0200, Thomas Gleixner <tglx@linutronix.de>  
wrote:

> On Wed, 24 Oct 2012, Uwaysi Bin Kareem wrote:
>> On Wed, 24 Oct 2012 21:24:23 +0200, Thomas Gleixner <tglx@linutronix.de>
>> wrote:
>> > Ok. Can you please provide dmesg from a working kernel ?
>>
>> uwaysi@Millennium:~$ dmesg
>> input: HDA NVidia Line Out Front as
>> /devices/pci0000:00/0000:00:10.1/sound/card0/input11
>
> That's just the tail of dmesg. I really need the whole thing from
> boot.
>
> The output of "lscpi -vvv" and "cat /proc/interrupts" might be helpful
> as well.
>
> Thanks,
>
> 	tglx

Here they are. I think there are no nude images of me in here.

uwaysi@Millennium:~$ lspci -vvv
00:00.0 Host bridge: NVIDIA Corporation C55 Host Bridge (rev a2)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: <access denied>

00:00.1 RAM memory: NVIDIA Corporation C55 Memory Controller (rev a1)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-

00:00.2 RAM memory: NVIDIA Corporation C55 Memory Controller (rev a1)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-

00:00.3 RAM memory: NVIDIA Corporation C55 Memory Controller (rev a1)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:00.4 RAM memory: NVIDIA Corporation C55 Memory Controller (rev a1)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:00.5 RAM memory: NVIDIA Corporation C55 Memory Controller (rev a2)
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:00.6 RAM memory: NVIDIA Corporation C55 Memory Controller (rev a1)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-

00:00.7 RAM memory: NVIDIA Corporation C55 Memory Controller (rev a1)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-

00:01.0 RAM memory: NVIDIA Corporation C55 Memory Controller (rev a1)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-

00:01.1 RAM memory: NVIDIA Corporation C55 Memory Controller (rev a1)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-

00:01.2 RAM memory: NVIDIA Corporation C55 Memory Controller (rev a1)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-

00:01.3 RAM memory: NVIDIA Corporation C55 Memory Controller (rev a1)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-

00:01.4 RAM memory: NVIDIA Corporation C55 Memory Controller (rev a1)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-

00:01.5 RAM memory: NVIDIA Corporation C55 Memory Controller (rev a1)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-

00:01.6 RAM memory: NVIDIA Corporation C55 Memory Controller (rev a1)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-

00:02.0 RAM memory: NVIDIA Corporation C55 Memory Controller (rev a1)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-

00:02.1 RAM memory: NVIDIA Corporation C55 Memory Controller (rev a1)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:02.2 RAM memory: NVIDIA Corporation C55 Memory Controller (rev a1)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-

00:03.0 PCI bridge: NVIDIA Corporation C55 PCI Express bridge (rev a1)  
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=05, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fa000000-febfffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:06.0 PCI bridge: NVIDIA Corporation C55 PCI Express bridge (rev a1)  
(prog-if 00 [Normal decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:07.0 PCI bridge: NVIDIA Corporation C55 PCI Express bridge (rev a1)  
(prog-if 00 [Normal decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=07, subordinate=07, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

00:09.0 RAM memory: NVIDIA Corporation MCP51 Host Bridge (rev a2)
	Subsystem: Micro-Star International Co., Ltd. Device 7380
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: <access denied>

00:0a.0 ISA bridge: NVIDIA Corporation MCP51 LPC Bridge (rev a3)
	Subsystem: Micro-Star International Co., Ltd. Device 7380
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: I/O ports at 4f00 [size=128]

00:0a.1 SMBus: NVIDIA Corporation MCP51 SMBus (rev a3)
	Subsystem: Micro-Star International Co., Ltd. Device 7380
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at 5000 [size=64]
	Region 5: I/O ports at 6000 [size=64]
	Capabilities: <access denied>
	Kernel driver in use: nForce2_smbus
	Kernel modules: i2c-nforce2

00:0a.2 RAM memory: NVIDIA Corporation MCP51 Memory Controller 0 (rev a3)
	Subsystem: Micro-Star International Co., Ltd. Device 7380
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-

00:0b.0 USB controller: NVIDIA Corporation MCP51 USB Controller (rev a3)  
(prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd. Device 7380
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at f9fff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: ohci_hcd

00:0b.1 USB controller: NVIDIA Corporation MCP51 USB Controller (rev a3)  
(prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd. Device 7380
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 22
	Region 0: Memory at f9ffec00 (32-bit, non-prefetchable) [size=256]
	Capabilities: <access denied>
	Kernel driver in use: ehci_hcd

00:0d.0 IDE interface: NVIDIA Corporation MCP51 IDE (rev a1) (prog-if 8a  
[Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd. Device 7380
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0 (750ns min, 250ns max)
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [size=1]
	Region 4: I/O ports at ffa0 [size=16]
	Capabilities: <access denied>
	Kernel driver in use: pata_amd
	Kernel modules: pata_amd

00:0e.0 IDE interface: NVIDIA Corporation MCP51 Serial ATA Controller (rev  
a1) (prog-if 85 [Master SecO PriO])
	Subsystem: Micro-Star International Co., Ltd. Device 7380
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 21
	Region 0: I/O ports at d800 [size=8]
	Region 1: I/O ports at d480 [size=4]
	Region 2: I/O ports at d400 [size=8]
	Region 3: I/O ports at d080 [size=4]
	Region 4: I/O ports at d000 [size=16]
	Region 5: Memory at f9ffd000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: sata_nv
	Kernel modules: sata_nv

00:0f.0 IDE interface: NVIDIA Corporation MCP51 Serial ATA Controller (rev  
a1) (prog-if 85 [Master SecO PriO])
	Subsystem: Micro-Star International Co., Ltd. Device 7380
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at cc00 [size=8]
	Region 1: I/O ports at c880 [size=4]
	Region 2: I/O ports at c800 [size=8]
	Region 3: I/O ports at c480 [size=4]
	Region 4: I/O ports at c400 [size=16]
	Region 5: Memory at f9ffc000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <access denied>
	Kernel driver in use: sata_nv
	Kernel modules: sata_nv

00:10.0 PCI bridge: NVIDIA Corporation MCP51 PCI Bridge (rev a2) (prog-if  
01 [Subtractive decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=08, subordinate=08, sec-latency=224
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-  
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr+ DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>

00:10.1 Audio device: NVIDIA Corporation MCP51 High Definition Audio (rev  
a2)
	Subsystem: Micro-Star International Co., Ltd. Device 7380
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin B routed to IRQ 22
	Region 0: Memory at f9ff8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd-hda-intel

00:14.0 Bridge: NVIDIA Corporation MCP51 Ethernet Controller (rev a3)
	Subsystem: Micro-Star International Co., Ltd. Device 380c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at f9ff7000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at c080 [size=8]
	Capabilities: <access denied>
	Kernel driver in use: forcedeth
	Kernel modules: forcedeth

01:00.0 PCI bridge: NVIDIA Corporation NF200 PCIe 2.0 switch (rev a2)  
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=01, secondary=02, subordinate=05, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fa000000-febfffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

02:00.0 PCI bridge: NVIDIA Corporation NF200 PCIe 2.0 switch (rev a2)  
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fa000000-febfffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

02:02.0 PCI bridge: NVIDIA Corporation NF200 PCIe 2.0 switch (rev a2)  
(prog-if 00 [Normal decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

02:03.0 PCI bridge: NVIDIA Corporation NF200 PCIe 2.0 switch (rev a2)  
(prog-if 00 [Normal decode])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=02, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: <access denied>
	Kernel driver in use: pcieport

03:00.0 VGA compatible controller: NVIDIA Corporation GT200 [GeForce GTX  
280] (rev a1) (prog-if 00 [VGA controller])
	Subsystem: eVga.com. Corp. Device 1280
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-  
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 40
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at fa000000 (64-bit, non-prefetchable) [size=32M]
	Region 5: I/O ports at ec00 [size=128]
	[virtual] Expansion ROM at feb80000 [disabled] [size=512K]
	Capabilities: <access denied>
	Kernel driver in use: nvidia
	Kernel modules: nvidia, nvidiafb

uwaysi@Millennium:~$ cat /proc/interrupts
            CPU0       CPU1
   0:         23          0   IO-APIC-edge      timer
   1:          3          0   IO-APIC-edge      i8042
   7:          1          0   IO-APIC-edge
   8:          0          0   IO-APIC-edge      rtc0
   9:          0          0   IO-APIC-fasteoi   acpi
  12:          4          0   IO-APIC-edge      i8042
  14:          0          0   IO-APIC-edge      pata_amd
  15:          0          0   IO-APIC-edge      pata_amd
  20:      34041     112015   IO-APIC-fasteoi   sata_nv
  21:       6517          0   IO-APIC-fasteoi   sata_nv
  22:      12209          0   IO-APIC-fasteoi   ehci_hcd:usb1, snd_hda_intel
  23:     153853          0   IO-APIC-fasteoi   ohci_hcd:usb2, eth0
  40:       7492          0   PCI-MSI-edge      nvidia
NMI:          0          0   Non-maskable interrupts
LOC:     477340     507192   Local timer interrupts
SPU:          0          0   Spurious interrupts
PMI:          0          0   Performance monitoring interrupts
IWI:          0          0   IRQ work interrupts
RTR:          0          0   APIC ICR read retries
RES:       5898      14787   Rescheduling interrupts
CAL:      14552      25779   Function call interrupts
TLB:          0          0   TLB shootdowns
MCE:          0          0   Machine check exceptions
MCP:      13780      13779   Machine check polls
ERR:          1
MIS:          0

I`ll have full dmesg in a minute.
