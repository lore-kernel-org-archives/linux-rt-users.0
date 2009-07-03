From: Pedro R <eusou15@yahoo.com>
Subject: Strange spikes using linux-rt kernel
Date: Fri, 3 Jul 2009 07:04:35 -0700 (PDT)
Message-ID: <175121.57868.qm@web112506.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from web112506.mail.gq1.yahoo.com ([98.137.26.142]:35626 "HELO
	web112506.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751208AbZGCOLM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Jul 2009 10:11:12 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi!

I'll resume my problem: in CyclicTest I have an average of about 20-30us and peaks of 5000-6000us. These peaks are really annoying, since i'm using this system for firewire audio and each time there is a peak, an underrun in jackd causes a drop in sound. I have confirmed that these peaks are the direct cause of the underruns.
The peaks appear to occur randomly, most of the time in less than a minute of using CyclicTest and continue every minute or twice a minute (hard to say, since when CyclicTest hits a max value like 6000us, i'm not quick enough to read the actual peaks which achieve less than that - but the peaks continue).

I left my system running the hwlat_detector module for 8 hours and all i got in the sample file was a bunch of 1's along with their timestamps, so the problem must not be the SMI.

This problem also happens without the rt patch. I have tried using 2.6.26.2 (non-rt) kernel and I have the same problem. I also tried using 2.6.23-rt and 2.6.26-rt and it also happens.

In Windows everything is OK with this firewire device, I can get 10ms latency without any problem. However, in JACK i can't even get an 100ms latency because of these spikes.

I am convinced that this is a hardware quirk, it might be a motherboard or cpu fault. The two Pentium-M systems which are posted as working on the http://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch webpage are different from mine. I have contacted the people who posted this information and they have confirmed me. One is a Pentium-4-M with the Intel 845MP Mobile Chipset and the other is a Pentium-M with the 915 chipset.

Here are my specs directly from the manufacturer:
BIOS CORE Version ................  Insyde BIOS

CPUs Supported    ................  Dothan / Banias / Celeron-M

Chipset		  ................  Intel 855GME+

Bridge		  ................  ICH4-M

Super I/O	  ................  SMC217

PCMCIA		  ................  ENE CB-1420 Cardbus controller

Video		  ................  ATI M11 (FL322) Intel 855GME+(FL324)

On-board Audio    ................  RealTek ALC202A AC'97 Audio

On-board LAN      ................  Broadcom BCM4401/BCM5788

KBC		  ................  ENE 910

1394 controller	  ................  TI TSB43AB22

lspci -vv output is at the bottom of this mail, together with dmesg output.

The ICH4 chipset has a buggy HPET, which is disabled in the BIOS because Windows XP crashes it with. I tried forcing it by using the hpet=force boot option, but the problem is still there.

I spent the last few days in #linux-rt where I got the help of some good folks such as clark|w, jonmasters, rostedt and jkacur. I decided to send this to the mailing list so it can reach a broader audience and perhaps find someone who has / had a similar problem.

Next is the output of some ftrace tests which rostedt asked me to try.

All the following tests are with acpi disabled. After booting with it disabled, cyclictest reports this error
WARNING: High resolution timers not available
the latencies seem to go much higher, now the average is around 500 and the spikes go to 15000. But the behaviour is pretty much the same as with acpi enabled, except for the increase in magnitude.
I decided to disable acpi because I was getting very strange readings in ftrace with it enabled - up to 500000us.

First try with irqsoff:

# tracer: irqsoff
#
# irqsoff latency trace v1.1.5 on 2.6.29.5-rt22
# --------------------------------------------------------------------
# latency: 20 us, #3/3, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
#    -----------------
#    | task: cyclictest-3308 (uid:0 nice:0 policy:1 rt_prio:80)
#    -----------------
#
#                  _------=> CPU#            
#                 / _-----=> irqs-off        
#                | / _----=> need-resched    
#                || / _---=> hardirq/softirq 
#                ||| / _--=> preempt-depth   
#                |||| /                      
#                |||||     delay             
#  cmd     pid   ||||| time  |   caller      
#     \   /      |||||   \   |   /           
   <...>-3643    0d...    0us+: trace_hardirqs_off_thunk <-apic_timer_interrupt
cyclicte-3308    0d...   20us : schedule <-do_nanosleep
cyclicte-3308    0d...   21us : trace_hardirqs_on <-do_nanosleep

Everything seems OK? But the spike occurred... at it still has 20us as maximum latency.

I repeated the test:

# tracer: irqsoff
#
# irqsoff latency trace v1.1.5 on 2.6.29.5-rt22
# --------------------------------------------------------------------
# latency: 21 us, #3/3, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
#    -----------------
#    | task: cyclictest-14393 (uid:0 nice:0 policy:1 rt_prio:79)
#    -----------------
#
#                  _------=> CPU#            
#                 / _-----=> irqs-off        
#                | / _----=> need-resched    
#                || / _---=> hardirq/softirq 
#                ||| / _--=> preempt-depth   
#                |||| /                      
#                |||||     delay             
#  cmd     pid   ||||| time  |   caller      
#     \   /      |||||   \   |   /           
   <...>-9940    0d...    1us+: trace_hardirqs_off_thunk <-apic_timer_interrupt
cyclicte-14393   0d...   21us : schedule <-do_nanosleep
cyclicte-14393   0d...   22us : trace_hardirqs_on <-do_nanosleep

So even AFTER the spike it remains as 21us maximum latency...


Next try with preemptoff:

# tracer: preemptoff
#
# preemptoff latency trace v1.1.5 on 2.6.29.5-rt22
# --------------------------------------------------------------------
# latency: 15678 us, #3/3, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
#    -----------------
#    | task: cyclictest-14170 (uid:0 nice:0 policy:0 rt_prio:0)
#    -----------------
#
#                  _------=> CPU#            
#                 / _-----=> irqs-off        
#                | / _----=> need-resched    
#                || / _---=> hardirq/softirq 
#                ||| / _--=> preempt-depth   
#                |||| /                      
#                |||||     delay             
#  cmd     pid   ||||| time  |   caller      
#     \   /      |||||   \   |   /           
cyclicte-14170   0d..1    0us!: rt_spin_lock_slowlock <-rt_spin_lock
cyclicte-14170   0.N.1 15678us : rt_spin_lock_slowlock <-rt_spin_lock
cyclicte-14170   0.N.1 15679us : trace_preempt_on <-rt_spin_lock

Are we getting somewhere? 


Next with preemptirqsoff:

# tracer: preemptirqsoff
#
# preemptirqsoff latency trace v1.1.5 on 2.6.29.5-rt22
# --------------------------------------------------------------------
# latency: 16253 us, #3/3, CPU#0 | (M:preempt VP:0, KP:0, SP:0 HP:0)
#    -----------------
#    | task: cyclictest-15837 (uid:0 nice:0 policy:0 rt_prio:0)
#    -----------------
#
#                  _------=> CPU#            
#                 / _-----=> irqs-off        
#                | / _----=> need-resched    
#                || / _---=> hardirq/softirq 
#                ||| / _--=> preempt-depth   
#                |||| /                      
#                |||||     delay             
#  cmd     pid   ||||| time  |   caller      
#     \   /      |||||   \   |   /           
cyclicte-15837   0d...    0us!: rt_mutex_slowunlock <-rt_mutex_unlock
cyclicte-15837   0.N.1 16254us : rt_mutex_slowunlock <-rt_mutex_unlock
cyclicte-15837   0.N.1 16254us : trace_preempt_on <-rt_mutex_unlock


I don't understand much of the output, if someone can help me I would appreciate it!


--------------------------------------------------------------------------------------------------------------------
LSPCI output:
00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
	Subsystem: Acer Incorporated [ALI] Device 0061
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at b0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [40] Vendor Specific Information <?>
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
	Kernel driver in use: agpgart-intel

00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
	Subsystem: Acer Incorporated [ALI] Device 0061
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
	Subsystem: Acer Incorporated [ALI] Device 0061
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:01.0 PCI bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to AGP Controller (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000dfff
	Memory behind bridge: e0000000-efffffff
	Prefetchable memory behind bridge: a0000000-afffffff
	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI] Device 0061
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at 1200 [size=32]
	Kernel driver in use: uhci_hcd

00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI] Device 0061
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at 1600 [size=32]
	Kernel driver in use: uhci_hcd

00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI] Device 0061
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at 1700 [size=32]
	Kernel driver in use: uhci_hcd

00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: Acer Incorporated [ALI] Device 0061
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=0080
	Kernel driver in use: ehci_hcd

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 83) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+ INTx-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=06, sec-latency=32
	I/O behind bridge: 0000a000-0000bfff
	Memory behind bridge: d0000000-dfffffff
	Prefetchable memory behind bridge: 90000000-9fffffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface Bridge (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Acer Incorporated [ALI] Device 0061
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4 [size=1]
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374 [size=1]
	Region 4: I/O ports at 1100 [size=16]
	Region 5: Memory at 88000000 (32-bit, non-prefetchable) [size=1K]
	Kernel driver in use: PIIX_IDE

00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 03)
	Subsystem: Acer Incorporated [ALI] Device 0061
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 1400 [size=32]
	Kernel driver in use: i801_smbus

00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
	Subsystem: Acer Incorporated [ALI] Device 0061
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at e000 [size=256]
	Region 1: I/O ports at e100 [size=64]
	Region 2: Memory at f0000400 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at f0000600 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: Intel ICH

00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: Acer Incorporated [ALI] Device 0061
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at e200 [size=256]
	Region 1: I/O ports at e300 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: Intel ICH Modem

01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10] (prog-if 00 [VGA controller])
	Subsystem: Acer Incorporated [ALI] Device 0061
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 128 (2000ns min), Cache Line Size: 16 bytes
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at a8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at c100 [size=256]
	Region 2: Memory at e0010000 (32-bit, non-prefetchable) [size=64K]
	[virtual] Expansion ROM at a0000000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=80 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x1
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: radeonfb

02:00.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI] Device 0061
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 128 (500ns min, 1000ns max), Cache Line Size: 16 bytesI spent the last few days in #linux-rt where I got the help of some good folks such as clark|w, jonmasters, rostedt and jkacur
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0020000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at d0024000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+
	Kernel driver in use: ohci1394

02:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5788 Gigabit Ethernet (rev 03)
	Subsystem: Acer Incorporated [ALI] Device 0061
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 128 (16000ns min), Cache Line Size: 16 bytes
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0010000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <ignored> [disabled]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
		Not readable
	Capabilities: [58] MSI: Mask- 64bit+ Count=1/8 Enable-
		Address: e6fd7ffffffffffc  Data: 7fff
	Kernel driver in use: tg3

02:02.0 Network controller: Intel Corporation PRO/Wireless 2200BG [Calexico2] Network Connection (rev 05)
	Subsystem: Intel Corporation Device 2701
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 128 (750ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Kernel driver in use: ipw2200

02:04.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller (rev 01)
	Subsystem: Acer Incorporated [ALI] Device 0061
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 168, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d0001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: 90000000-93fff000 (prefetchable)
	Memory window 1: d4000000-d7fff000
	I/O window 0: 0000a000-0000a0ff
	I/O window 1: 0000a400-0000a4ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
	Kernel driver in use: yenta_cardbus
	
----------------------------------------------------------------------------------------------------------------------
DMESG output:
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.29.5-rt22 (root@portatel) (gcc version 4.3.3 (Debian 4.3.3-10) ) #1 PREEMPT RT Fri Jul 3 12:14:58 WEST 2009
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   NSC Geode by NSC
[    0.000000]   Cyrix CyrixInstead
[    0.000000]   Centaur CentaurHauls
[    0.000000]   Transmeta GenuineTMx86
[    0.000000]   Transmeta TransmetaCPU
[    0.000000]   UMC UMC UMC UMC
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
[    0.000000]  BIOS-e820: 000000007fff0000 - 000000007fffffc0 (ACPI data)
[    0.000000]  BIOS-e820: 000000007fffffc0 - 0000000080000000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] DMI 2.3 present.
[    0.000000] last_pfn = 0x7fff0 max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-DFFFF uncachable
[    0.000000]   E0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F80000000 write-back
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] PAT not supported by CPU.
[    0.000000]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[    0.000000] init_memory_mapping: 0000000000000000-00000000377fe000
[    0.000000]  0000000000 - 0000400000 page 4k
[    0.000000]  0000400000 - 0037400000 page 2M
[    0.000000]  0037400000 - 00377fe000 page 4k
[    0.000000] kernel direct mapping tables up to 377fe000 @ 7000-c000
[    0.000000] 1159MB HIGHMEM available.
[    0.000000] 887MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 377fe000
[    0.000000]   low ram: 0 - 377fe000
[    0.000000]   node 0 low ram: 00000000 - 377fe000
[    0.000000]   node 0 bootmap 00008000 - 0000ef00
[    0.000000] (6 early reservations) ==> bootmem [0000000000 - 00377fe000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000100000 - 00006f1858]    TEXT DATA BSS ==> [0000100000 - 00006f1858]
[    0.000000]   #2 [000009fc00 - 0000100000]    BIOS reserved ==> [000009fc00 - 0000100000]
[    0.000000]   #3 [00006f2000 - 00006f50d8]              BRK ==> [00006f2000 - 00006f50d8]
[    0.000000]   #4 [0000007000 - 0000008000]          PGTABLE ==> [0000007000 - 0000008000]
[    0.000000]   #5 [0000008000 - 000000f000]          BOOTMAP ==> [0000008000 - 000000f000]
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x000377fe
[    0.000000]   HighMem  0x000377fe -> 0x0007fff0
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x0007fff0
[    0.000000] On node 0 totalpages: 524175
[    0.000000] free_area_init_node: node 0, pgdat c06056b0, node_mem_map c1000000
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3967 pages, LIFO batch:0
[    0.000000]   Normal zone: 1744 pages used for memmap
[    0.000000]   Normal zone: 221486 pages, LIFO batch:31
[    0.000000]   HighMem zone: 2320 pages used for memmap
[    0.000000]   HighMem zone: 294626 pages, LIFO batch:31
[    0.000000] Using APIC driver default
[    0.000000] Found and enabled local APIC!
[    0.000000] nr_irqs_gsi: 16
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:7fb80000)
[    0.000000] Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 520079
[    0.000000] Kernel command line: root=/dev/hda6 ro no_console_suspend video=radeonfb:1280x800-32@60
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] Preemptible RCU implementation.
[    0.000000] NR_IRQS:288
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1998.471 MHz processor.
[    0.000999] Console: colour VGA+ 80x25
[    0.000999] console [tty0] enabled
[    0.000999] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000999] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000999] Initializing HighMem for node 0 (000377fe:0007fff0)
[    0.000999] Memory: 2072324k/2097088k available (3446k kernel code, 23456k reserved, 1731k data, 328k init, 1187784k highmem)
[    0.000999] virtual kernel memory layout:
[    0.000999]     fixmap  : 0xfffab000 - 0xfffff000   ( 336 kB)
[    0.000999]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000999]     vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
[    0.000999]     lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
[    0.000999]       .init : 0xc0612000 - 0xc0664000   ( 328 kB)
[    0.000999]       .data : 0xc045db8a - 0xc060e880   (1731 kB)
[    0.000999]       .text : 0xc0100000 - 0xc045db8a   (3446 kB)
[    0.000999] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.001016] Calibrating delay loop (skipped), value calculated using timer frequency.. 3996.94 BogoMIPS (lpj=1998471)
[    0.001184] Security Framework initialized
[    0.001241] SELinux:  Disabled at boot.
[    0.001308] Mount-cache hash table entries: 512
[    0.001626] Initializing cgroup subsys ns
[    0.001680] Initializing cgroup subsys cpuacct
[    0.001728] Initializing cgroup subsys devices
[    0.001807] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.001885] CPU: L2 cache: 2048K
[    0.001931] [ds] using Pentium M configuration
[    0.002005] [ds] pebs not available
[    0.002055] Intel machine check architecture supported.
[    0.002106] Intel machine check reporting enabled on CPU#0.
[    0.002167] CPU: Intel(R) Pentium(R) M processor 2.00GHz stepping 06
[    0.002285] Checking 'hlt' instruction... OK.
[    0.108983] net_namespace: 1184 bytes
[    0.108983] NET: Registered protocol family 16
[    0.109790] EISA bus registered
[    0.110111] PCI: PCI BIOS revision 2.10 entry at 0xe97e4, last bus=2
[    0.110163] PCI: Using configuration type 1 for base access
[    0.120322] bio: create slab <bio-0> at 0
[    0.121483] SCSI subsystem initialized
[    0.121593] libata version 3.00 loaded.
[    0.121888] usbcore: registered new interface driver usbfs
[    0.122099] usbcore: registered new interface driver hub
[    0.122252] usbcore: registered new device driver usb
[    0.122752] PCI: Probing PCI hardware
[    0.122801] PCI: Probing PCI hardware (bus 00)
[    0.122914] pci 0000:00:00.0: reg 10 32bit mmio: [0xb0000000-0xbfffffff]
[    0.123082] pci 0000:00:1d.0: reg 20 io port: [0x1200-0x121f]
[    0.123129] pci 0000:00:1d.1: reg 20 io port: [0x1600-0x161f]
[    0.123176] pci 0000:00:1d.2: reg 20 io port: [0x1700-0x171f]
[    0.123221] pci 0000:00:1d.7: reg 10 32bit mmio: [0xf0000000-0xf00003ff]
[    0.123287] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.123344] pci 0000:00:1d.7: PME# disabled
[    0.123463] HPET not enabled in BIOS. You might try hpet=force boot option
[    0.123521] pci 0000:00:1f.0: quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
[    0.123584] pci 0000:00:1f.0: quirk: region 1300-133f claimed by ICH4 GPIO
[    0.123653] pci 0000:00:1f.1: reg 10 io port: [0x00-0x07]
[    0.123660] pci 0000:00:1f.1: reg 14 io port: [0x00-0x03]
[    0.123667] pci 0000:00:1f.1: reg 18 io port: [0x00-0x07]
[    0.123674] pci 0000:00:1f.1: reg 1c io port: [0x00-0x03]
[    0.123681] pci 0000:00:1f.1: reg 20 io port: [0x1100-0x110f]
[    0.123688] pci 0000:00:1f.1: reg 24 32bit mmio: [0x000000-0x0003ff]
[    0.123736] pci 0000:00:1f.3: reg 20 io port: [0x1400-0x141f]
[    0.123769] pci 0000:00:1f.5: reg 10 io port: [0xe000-0xe0ff]
[    0.123776] pci 0000:00:1f.5: reg 14 io port: [0xe100-0xe13f]
[    0.123782] pci 0000:00:1f.5: reg 18 32bit mmio: [0xf0000400-0xf00005ff]
[    0.123789] pci 0000:00:1f.5: reg 1c 32bit mmio: [0xf0000600-0xf00006ff]
[    0.123822] pci 0000:00:1f.5: PME# supported from D0 D3hot D3cold
[    0.123876] pci 0000:00:1f.5: PME# disabled
[    0.123942] pci 0000:00:1f.6: reg 10 io port: [0xe200-0xe2ff]
[    0.123948] pci 0000:00:1f.6: reg 14 io port: [0xe300-0xe37f]
[    0.123998] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    0.124053] pci 0000:00:1f.6: PME# disabled
[    0.124127] pci 0000:01:00.0: reg 10 32bit mmio: [0xa8000000-0xafffffff]
[    0.124133] pci 0000:01:00.0: reg 14 io port: [0xc100-0xc1ff]
[    0.124139] pci 0000:01:00.0: reg 18 32bit mmio: [0xe0010000-0xe001ffff]
[    0.124153] pci 0000:01:00.0: reg 30 32bit mmio: [0x000000-0x01ffff]
[    0.124178] pci 0000:01:00.0: supports D1 D2
[    0.124208] pci 0000:00:01.0: bridge io port: [0xc000-0xdfff]
[    0.124212] pci 0000:00:01.0: bridge 32bit mmio: [0xe0000000-0xefffffff]
[    0.124216] pci 0000:00:01.0: bridge 32bit mmio pref: [0xa0000000-0xafffffff]
[    0.124240] pci 0000:02:00.0: reg 10 32bit mmio: [0xd0020000-0xd00207ff]
[    0.124247] pci 0000:02:00.0: reg 14 32bit mmio: [0xd0024000-0xd0027fff]
[    0.124290] pci 0000:02:00.0: supports D1 D2
[    0.124292] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot
[    0.124345] pci 0000:02:00.0: PME# disabled
[    0.124417] pci 0000:02:01.0: reg 10 32bit mmio: [0xd0010000-0xd001ffff]
[    0.124484] pci 0000:02:01.0: PME# supported from D3hot D3cold
[    0.124537] pci 0000:02:01.0: PME# disabled
[    0.124607] pci 0000:02:02.0: reg 10 32bit mmio: [0xd0000000-0xd0000fff]
[    0.124654] pci 0000:02:02.0: PME# supported from D0 D3hot D3cold
[    0.124707] pci 0000:02:02.0: PME# disabled
[    0.124774] pci 0000:02:04.0: reg 10 32bit mmio: [0x000000-0x000fff]
[    0.124798] pci 0000:02:04.0: supports D1 D2
[    0.124801] pci 0000:02:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.124855] pci 0000:02:04.0: PME# disabled
[    0.124931] pci 0000:00:1e.0: transparent bridge
[    0.125146] pci 0000:00:1e.0: bridge io port: [0xa000-0xbfff]
[    0.125151] pci 0000:00:1e.0: bridge 32bit mmio: [0xd0000000-0xdfffffff]
[    0.125156] pci 0000:00:1e.0: bridge 32bit mmio pref: [0x90000000-0x9fffffff]
[    0.127375] pci 0000:00:1f.0: PIIX/ICH IRQ router [8086:24cc]
[    0.127488] PCI: setting IRQ 11 as level-triggered
[    0.127492] pci 0000:00:1d.0: found PCI INT A -> IRQ 11
[    0.127586] pci 0000:00:1d.0: sharing IRQ 11 with 0000:01:00.0
[    0.127650] pci 0000:00:1d.0: sharing IRQ 11 with 0000:02:04.0
[    0.127732] PCI: setting IRQ 5 as level-triggered
[    0.127735] pci 0000:00:1f.3: found PCI INT B -> IRQ 5
[    0.127823] pci 0000:00:1f.3: sharing IRQ 5 with 0000:00:1f.5
[    0.127876] pci 0000:00:1f.3: sharing IRQ 5 with 0000:00:1f.6
[    0.137250] Bluetooth: Core ver 2.14
[    0.137424] NET: Registered protocol family 31
[    0.137472] Bluetooth: HCI device and connection manager initialized
[    0.137526] Bluetooth: HCI socket layer initialized
[    0.137853] PnPBIOS: Scanning system for PnP BIOS support...
[    0.137938] PnPBIOS: Found PnP BIOS installation structure at 0xc00ff020
[    0.137990] PnPBIOS: PnP BIOS version 1.0, entry 0xeb000:0x35fa, dseg 0xeb000
[    0.138046] PNPBIOS fault.. attempting recovery.
[    0.138095] PnPBIOS: Warning! Your PnP BIOS caused a fatal error. Attempting to continue
[    0.138157] PnPBIOS: You may need to reboot with the "pnpbios=off" option to operate stably
[    0.138220] PnPBIOS: Check with your vendor for an updated BIOS
[    0.138271] PnPBIOS: dev_node_info: unexpected status 0x37
[    0.138321] PnPBIOS: Unable to get node info.  Aborting.
[    0.139718] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[    0.139771] pci 0000:00:01.0:   IO window: 0xc000-0xdfff
[    0.139823] pci 0000:00:01.0:   MEM window: 0xe0000000-0xefffffff
[    0.139876] pci 0000:00:01.0:   PREFETCH window: 0x000000a0000000-0x000000afffffff
[    0.139949] pci 0000:02:04.0: CardBus bridge, secondary bus 0000:03
[    0.140009] pci 0000:02:04.0:   IO window: 0x00a000-0x00a0ff
[    0.140062] pci 0000:02:04.0:   IO window: 0x00a400-0x00a4ff
[    0.140115] pci 0000:02:04.0:   PREFETCH window: 0x90000000-0x93ffffff
[    0.140169] pci 0000:02:04.0:   MEM window: 0xd4000000-0xd7ffffff
[    0.140222] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:02
[    0.140274] pci 0000:00:1e.0:   IO window: 0xa000-0xbfff
[    0.140327] pci 0000:00:1e.0:   MEM window: 0xd0000000-0xdfffffff
[    0.140380] pci 0000:00:1e.0:   PREFETCH window: 0x00000090000000-0x0000009fffffff
[    0.140456] pci 0000:00:1e.0: setting latency timer to 64
[    0.140467] pci 0000:02:04.0: found PCI INT A -> IRQ 11
[    0.140532] pci 0000:02:04.0: sharing IRQ 11 with 0000:00:1d.0
[    0.140613] pci 0000:02:04.0: sharing IRQ 11 with 0000:01:00.0
[    0.140682] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.140685] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffff]
[    0.140688] pci_bus 0000:01: resource 0 io:  [0xc000-0xdfff]
[    0.140691] pci_bus 0000:01: resource 1 mem: [0xe0000000-0xefffffff]
[    0.140694] pci_bus 0000:01: resource 2 mem: [0xa0000000-0xafffffff]
[    0.140697] pci_bus 0000:01: resource 3 mem: [0x0-0x0]
[    0.140700] pci_bus 0000:02: resource 0 io:  [0xa000-0xbfff]
[    0.140703] pci_bus 0000:02: resource 1 mem: [0xd0000000-0xdfffffff]
[    0.140706] pci_bus 0000:02: resource 2 mem: [0x90000000-0x9fffffff]
[    0.140709] pci_bus 0000:02: resource 3 io:  [0x00-0xffff]
[    0.140712] pci_bus 0000:02: resource 4 mem: [0x000000-0xffffffff]
[    0.140715] pci_bus 0000:03: resource 0 io:  [0xa000-0xa0ff]
[    0.140718] pci_bus 0000:03: resource 1 io:  [0xa400-0xa4ff]
[    0.140721] pci_bus 0000:03: resource 2 mem: [0x90000000-0x93ffffff]
[    0.140724] pci_bus 0000:03: resource 3 mem: [0xd4000000-0xd7ffffff]
[    0.140799] NET: Registered protocol family 2
[    0.173097] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.173799] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.175269] TCP bind hash table entries: 65536 (order: 9, 3407872 bytes)
[    0.181140] TCP: Hash tables configured (established 131072 bind 65536)
[    0.181202] TCP reno registered
[    0.193150] NET: Registered protocol family 1
[    0.193736] platform rtc_cmos: registered platform RTC device (no PNP device found)
[    0.194117] Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    0.195465] Initializing RT-Tester: OK
[    0.195571] audit: initializing netlink socket (disabled)
[    0.195643] type=2000 audit(1246625546.194:1): initialized
[    0.196097] highmem bounce pool size: 64 pages
[    0.196152] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.196321] VFS: Disk quotas dquot_6.5.2
[    0.196459] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.196665] fuse init (API version 7.11)
[    0.197437] SGI XFS with ACLs, security attributes, realtime, large block/inode numbers, no debug enabled
[    0.197857] SGI XFS Quota Management subsystem
[    0.197921] msgmni has been set to 1729
[    0.198463] alg: No test for stdrng (krng)
[    0.198635] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.198698] io scheduler noop registered
[    0.198745] io scheduler anticipatory registered
[    0.198793] io scheduler deadline registered
[    0.198857] io scheduler cfq registered (default)
[    0.199130] pci 0000:01:00.0: Boot video device
[    0.199469] radeonfb 0000:01:00.0: found PCI INT A -> IRQ 11
[    0.199536] radeonfb 0000:01:00.0: sharing IRQ 11 with 0000:00:1d.0
[    0.199630] radeonfb 0000:01:00.0: sharing IRQ 11 with 0000:02:04.0
[    0.201312] radeonfb: Retrieved PLL infos from BIOS
[    0.201363] radeonfb: Reference=27.00 MHz (RefDiv=6) Memory=390.00 Mhz, System=200.00 MHz
[    0.201426] radeonfb: PLL min 20000 max 35000
[    0.201477] Non-DDC laptop panel detected
[    0.202530] radeonfb: Monitor 1 type LCD found
[    0.202577] radeonfb: Monitor 2 type no found
[    0.202626] radeonfb: panel ID string: SEC                     
[    0.202677] radeonfb: detected LVDS panel size from BIOS: 1280x800
[    0.202728] radeondb: BIOS provided dividers will be used
[    0.202812] radeonfb: Dynamic Clock Power Management enabled
[    0.281802] Console: switching to colour frame buffer device 160x50
[    0.360455]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[    0.360460]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[    0.361862] radeonfb (0000:01:00.0): ATI Radeon 4e50 "NP"
[    0.367434] lp: driver loaded but no devices found
[    0.367718] ppdev: user-space parallel port driver
[    0.367866] Linux agpgart interface v0.103
[    0.368041] agpgart-intel 0000:00:00.0: Intel 855GM Chipset
[    0.389389] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xb0000000
[    0.389764] [drm] Initialized drm 1.1.0 20060810
[    0.390519]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[    0.390522]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[    0.390527]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[    0.390530]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[    0.391042] [drm] Initialized radeon 1.29.0 20080528 on minor 0
[    0.392698] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.393567] serial 0000:00:1f.6: found PCI INT B -> IRQ 5
[    0.393759] serial 0000:00:1f.6: sharing IRQ 5 with 0000:00:1f.3
[    0.393956] serial 0000:00:1f.6: sharing IRQ 5 with 0000:00:1f.5
[    0.394984] parport0: PC-style at 0x378 [PCSPP,EPP]
[    0.477190] lp0: using parport0 (polling).
[    0.480462] brd: module loaded
[    0.481989] loop: module loaded
[    0.482116] tg3.c:v3.97 (December 10, 2008)
[    0.482248] tg3 0000:02:01.0: found PCI INT A -> IRQ 11
[    0.483877] tg3 0000:02:01.0: PME# disabled
[    0.518764] eth0: Tigon3 [partno(BCM95788A50) rev 3003] (PCI:33MHz:32-bit) MAC address 00:02:3f:1b:4c:3c
[    0.519039] eth0: attached PHY is 5705 (10/100/1000Base-T Ethernet) (WireSpeed[0])
[    0.519256] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    0.519441] eth0: dma_rwctrl[763f0000] dma_mask[32-bit]
[    0.519662] Uniform Multi-Platform E-IDE driver
[    0.519991] piix 0000:00:1f.1: IDE controller (0x8086:0x24ca rev 0x03)
[    0.524096] PIIX_IDE 0000:00:1f.1: enabling device (0005 -> 0007)
[    0.528394] PCI: setting IRQ 10 as level-triggered
[    0.528398] PIIX_IDE 0000:00:1f.1: assigned PCI INT A -> IRQ 10
[    0.532836] PIIX_IDE 0000:00:1f.1: sharing IRQ 10 with 0000:00:1d.2
[    0.537385] piix 0000:00:1f.1: not 100% native mode: will probe irqs later
[    0.542111]     ide0: BM-DMA at 0x1100-0x1107
[    0.546957]     ide1: BM-DMA at 0x1108-0x110f
[    0.551855] Probing IDE interface ide0...
[    0.815854] hda: HTS721010G9AT00, ATA DISK drive
[    1.432602] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    1.432831] hda: UDMA/100 mode selected
[    1.438218] Probing IDE interface ide1...
[    2.109393] hdc: Optiarc DVD RW AD-7630A, ATAPI CD/DVD-ROM drive
[    2.726135] hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    2.754742] hdc: UDMA/33 mode selected
[    2.760682] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    2.766384] ide1 at 0x170-0x177,0x376 on irq 15
[    2.772455] ide-gd driver 1.18
[    2.778307] hda: max request size: 512KiB
[    2.810328] hda: 195371568 sectors (100030 MB) w/7539KiB Cache, CHS=16383/255/63
[    2.816989] hda: cache flushes supported
[    2.823394]  hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
[    2.872763] ide-cd driver 5.00
[    2.883982] ide-cd: hdc: ATAPI 24X DVD-ROM DVD-R/RAM CD-R/RW drive, 2048kB Cache
[    2.891132] Uniform CD-ROM driver Revision: 3.20
[    5.211325] Driver 'sd' needs updating - please use bus_type methods
[    5.218917] ohci1394 0000:02:00.0: found PCI INT A -> IRQ 11
[    5.277194] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[d0020000-d00207ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[    5.285327] yenta_cardbus 0000:02:04.0: CardBus bridge found [1025:0061]
[    5.293256] yenta_cardbus 0000:02:04.0: Using CSCINT to route CSC interrupts to PCI
[    5.301169] yenta_cardbus 0000:02:04.0: Routing CardBus interrupts to PCI
[    5.309038] yenta_cardbus 0000:02:04.0: TI: mfunc 0x00111c12, devctl 0x46
[    5.539814] yenta_cardbus 0000:02:04.0: ISA IRQ mask 0x02c8, PCI irq 11
[    5.547681] yenta_cardbus 0000:02:04.0: Socket status: 30000006
[    5.555488] pci_bus 0000:02: Raising subordinate bus# of parent bus (#02) from #02 to #06
[    5.563502] yenta_cardbus 0000:02:04.0: pcmcia: parent PCI bridge I/O window: 0xa000 - 0xbfff
[    5.571522] pcmcia_socket pcmcia_socket0: cs: IO port probe 0xa000-0xbfff: clean.
[    5.581849] yenta_cardbus 0000:02:04.0: pcmcia: parent PCI bridge Memory window: 0xd0000000 - 0xdfffffff
[    5.590104] yenta_cardbus 0000:02:04.0: pcmcia: parent PCI bridge Memory window: 0x90000000 - 0x9fffffff
[    5.849192] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.857463] ehci_hcd 0000:00:1d.7: found PCI INT D -> IRQ 10
[    5.865849] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    5.865853] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    5.874329] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[    5.886564] ehci_hcd 0000:00:1d.7: Enabling legacy PCI PM
[    5.894888] ehci_hcd 0000:00:1d.7: debug port 1
[    5.903240] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    5.903273] ehci_hcd 0000:00:1d.7: irq 10, io mem 0xf0000000
[    5.920915] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    5.929285] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    5.937659] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.945889] usb usb1: Product: EHCI Host Controller
[    5.954004] usb usb1: Manufacturer: Linux 2.6.29.5-rt22 ehci_hcd
[    5.962099] usb usb1: SerialNumber: 0000:00:1d.7
[    5.970309] usb usb1: configuration #1 chosen from 1 choice
[    5.978487] hub 1-0:1.0: USB hub found
[    5.986537] hub 1-0:1.0: 6 ports detected
[    5.994948] uhci_hcd: USB Universal Host Controller Interface driver
[    6.003034] uhci_hcd 0000:00:1d.0: found PCI INT A -> IRQ 11
[    6.011149] uhci_hcd 0000:00:1d.0: sharing IRQ 11 with 0000:01:00.0
[    6.019153] uhci_hcd 0000:00:1d.0: sharing IRQ 11 with 0000:02:04.0
[    6.026960] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    6.026964] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    6.034977] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    6.042925] uhci_hcd 0000:00:1d.0: irq 11, io base 0x00001200
[    6.050907] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    6.058852] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    6.066755] usb usb2: Product: UHCI Host Controller
[    6.074628] usb usb2: Manufacturer: Linux 2.6.29.5-rt22 uhci_hcd
[    6.082593] usb usb2: SerialNumber: 0000:00:1d.0
[    6.090679] usb usb2: configuration #1 chosen from 1 choice
[    6.098815] hub 2-0:1.0: USB hub found
[    6.106724] hub 2-0:1.0: 2 ports detected
[    6.114847] uhci_hcd 0000:00:1d.1: assigned PCI INT B -> IRQ 10
[    6.122797] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    6.122801] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    6.130838] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[    6.138661] uhci_hcd 0000:00:1d.1: irq 10, io base 0x00001600
[    6.146453] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    6.154202] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    6.161865] usb usb3: Product: UHCI Host Controller
[    6.169331] usb usb3: Manufacturer: Linux 2.6.29.5-rt22 uhci_hcd
[    6.176647] usb usb3: SerialNumber: 0000:00:1d.1
[    6.184080] usb usb3: configuration #1 chosen from 1 choice
[    6.191461] hub 3-0:1.0: USB hub found
[    6.198831] hub 3-0:1.0: 2 ports detected
[    6.206395] uhci_hcd 0000:00:1d.2: found PCI INT C -> IRQ 10
[    6.213770] uhci_hcd 0000:00:1d.2: sharing IRQ 10 with 0000:00:1f.1
[    6.221076] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    6.221079] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    6.228332] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[    6.235398] uhci_hcd 0000:00:1d.2: irq 10, io base 0x00001700
[    6.242387] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    6.249504] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    6.256418] usb usb4: Product: UHCI Host Controller
[    6.263305] usb usb4: Manufacturer: Linux 2.6.29.5-rt22 uhci_hcd
[    6.270242] usb usb4: SerialNumber: 0000:00:1d.2
[    6.277289] usb usb4: configuration #1 chosen from 1 choice
[    6.284304] hub 4-0:1.0: USB hub found
[    6.291421] hub 4-0:1.0: 2 ports detected
[    6.298982] PNP: No PS/2 controller found. Probing ports directly.
[    6.306457] i8042.c: Detected active multiplexing controller, rev 1.1.
[    6.313633] serio: i8042 KBD port at 0x60,0x64 irq 1
[    6.320871] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    6.328024] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    6.335117] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    6.342049] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    6.349092] mice: PS/2 mouse device common for all mice
[    6.356199] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[    6.363364] input: AT Translated Set 2 keyboard as /class/input/input0
[    6.370258] rtc0: alarms up to one day, 114 bytes nvram
[    6.377168] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.05
[    6.384219] iTCO_wdt: Found a ICH4-M TCO device (Version=1, TCOBASE=0x1060)
[    6.391310] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    6.398693] device-mapper: uevent: version 1.0.3
[    6.406038] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
[    6.413467] EISA: Probing bus 0 at eisa.0
[    6.415744] usb 2-1: new low speed USB device using uhci_hcd and address 2
[    6.429834] usbcore: registered new interface driver hiddev
[    6.437232] usbcore: registered new interface driver usbhid
[    6.444484] usbhid: v2.6:USB HID core driver
[    6.451788] Advanced Linux Sound Architecture Driver Version 1.0.18a.
[    6.459769] Intel ICH 0000:00:1f.5: found PCI INT B -> IRQ 5
[    6.467097] Intel ICH 0000:00:1f.5: sharing IRQ 5 with 0000:00:1f.3
[    6.474496] Intel ICH 0000:00:1f.5: sharing IRQ 5 with 0000:00:1f.6
[    6.481758] Intel ICH 0000:00:1f.5: setting latency timer to 64
[    6.540975] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023f4853000249]
[    6.578859] usb 2-1: New USB device found, idVendor=046d, idProduct=c01d
[    6.586095] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    6.593276] usb 2-1: Product: USB-PS/2 Optical Mouse
[    6.600381] usb 2-1: Manufacturer: Logitech
[    6.607542] usb 2-1: configuration #1 chosen from 1 choice
[    6.633424] input: Logitech USB-PS/2 Optical Mouse as /class/input/input1
[    6.662819] generic-usb 0003:046D:C01D.0001: input,hidraw0: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.0-1/input0
[    6.998124] Synaptics Touchpad, model: 1, fw: 5.9, id: 0x126eb1, caps: 0xa04713/0x4000
[    7.036505] input: SynPS/2 Synaptics TouchPad as /class/input/input2
[    7.294423] intel8x0_measure_ac97_clock: measured 50229 usecs
[    7.302051] intel8x0: clocking to 48000
[    7.311228] Intel ICH Modem 0000:00:1f.6: found PCI INT B -> IRQ 5
[    7.319025] Intel ICH Modem 0000:00:1f.6: sharing IRQ 5 with 0000:00:1f.3
[    7.326845] Intel ICH Modem 0000:00:1f.6: sharing IRQ 5 with 0000:00:1f.5
[    7.334668] Intel ICH Modem 0000:00:1f.6: setting latency timer to 64
[    7.337620] ALSA device list:
[    7.345271]   #0: Intel 82801DB-ICH4 with ALC250 at irq 5
[    7.353032]   #1: Intel 82801DB-ICH4 Modem at irq 5
[    7.361639] TCP cubic registered
[    7.369269] NET: Registered protocol family 17
[    7.376904] Bluetooth: L2CAP ver 2.11
[    7.384476] Bluetooth: L2CAP socket layer initialized
[    7.392072] Bluetooth: RFCOMM socket layer initialized
[    7.399627] Bluetooth: RFCOMM TTY layer initialized
[    7.407080] Bluetooth: RFCOMM ver 1.10
[    7.414524] Using IPI Shortcut mode
[    7.422093] registered taskstats version 1
[    7.429602] rtc_cmos rtc_cmos: setting system clock to 2009-07-03 12:52:34 UTC (1246625554)
[    7.505150] XFS mounting filesystem hda6
[    7.765213] Ending clean XFS mount for filesystem: hda6
[    7.765300] VFS: Mounted root (xfs filesystem) readonly on device 3:6.
[    7.773076] *****************************************************************************
[    7.780999] *                                                                           *
[    7.789074] *  REMINDER, the following debugging options are turned on in your .config: *
[    7.797284] *                                                                           *
[    7.805549] *        CONFIG_DEBUG_RT_MUTEXES                                            *
[    7.813728] *        CONFIG_IRQSOFF_TRACER                                              *
[    7.821819] *        CONFIG_PREEMPT_TRACER                                              *
[    7.829794] *                                                                           *
[    7.837701] *  they may increase runtime overhead and latencies.                        *
[    7.845660] *                                                                           *
[    7.853650] *****************************************************************************
[    7.861632] Freeing unused kernel memory: 328k freed
[    7.869989] Write protecting the kernel text: 3448k
[    7.877859] Write protecting the kernel read-only data: 1452k
[   10.447747] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x100-0x3af: clean.
[   10.464271] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
[   10.473496] pcmcia_socket pcmcia_socket0: cs: IO port probe 0x820-0x8ff: clean.
[   10.493166] pcmcia_socket pcmcia_socket0: cs: IO port probe 0xc00-0xcf7: clean.
[   10.512657] pcmcia_socket pcmcia_socket0: cs: IO port probe 0xa00-0xaff: clean.
[   11.075264] lib80211: common routines for IEEE802.11 drivers
[   11.083335] lib80211_crypt: registered algorithm 'NULL'
[   11.148882] i801_smbus 0000:00:1f.3: found PCI INT B -> IRQ 5
[   11.158238] i801_smbus 0000:00:1f.3: sharing IRQ 5 with 0000:00:1f.5
[   11.166573] i801_smbus 0000:00:1f.3: sharing IRQ 5 with 0000:00:1f.6
[   11.377467] ieee80211: 802.11 data/management/control stack, git-1.1.13
[   11.385296] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[   11.420159] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.2.2kdmprq
[   11.427736] ipw2200: Copyright(c) 2003-2006 Intel Corporation
[   11.436603] ipw2200 0000:02:02.0: found PCI INT A -> IRQ 11
[   11.444355] ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
[   11.451954] eth1 (ipw2200): not using net_device_ops yet
[   11.459615] ipw2200 0000:02:02.0: firmware: requesting ipw2200-bss.fw
[   11.669329] ipw2200: Detected geography ZZM (11 802.11bg channels, 0 802.11a channels)
[   13.939542] Adding 2249060k swap on /dev/hda5.  Priority:-1 extents:1 across:2249060k 
[   20.335821] Filesystem "dm-0": Disabling barriers, trial barrier write failed
[   20.343666] XFS mounting filesystem dm-0
[   20.652689] Ending clean XFS mount for filesystem: dm-0
[   23.608258] microcode: CPU0 updated from revision 0x17 to 0x18, date = 2004-10-17 
[   31.278115] NET: Registered protocol family 10
[   31.280657] lo: Disabled Privacy Extensions
[   40.662387]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[   40.662393]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[   40.662397]   get_mtrr: cpu0 reg02 base=00000b0000 size=0000010000 write-combining
[   40.663717]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[   40.663722]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[   40.663726]   get_mtrr: cpu0 reg02 base=00000b0000 size=0000010000 write-combining
[   40.663779]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[   40.663783]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[   40.663787]   get_mtrr: cpu0 reg02 base=00000b0000 size=0000010000 write-combining
[   40.664313]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[   40.664317]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[   40.664322]   get_mtrr: cpu0 reg02 base=00000b0000 size=0000010000 write-combining
[   40.681878]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[   40.681882]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[   40.681931]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[   40.681990]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[   40.681994]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[   40.682086]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[   42.625596] tg3 0000:02:01.0: firmware: using built-in firmware tigon/tg3_tso5.bin
[   42.625632] tg3 0000:02:01.0: PME# disabled
[   42.899285] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   42.901849]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[   42.901854]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[   42.901858]   get_mtrr: cpu0 reg02 base=00000b0000 size=0000010000 write-combining
[   42.903486]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[   42.903490]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[   42.903495]   get_mtrr: cpu0 reg02 base=00000b0000 size=0000010000 write-combining
[   42.903800]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[   42.903804]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[   42.903808]   get_mtrr: cpu0 reg02 base=00000b0000 size=0000010000 write-combining
[   42.903826]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[   42.903829]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[   42.903966]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[   42.903970]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[   42.903975]   get_mtrr: cpu0 reg02 base=00000b0000 size=0000010000 write-combining
[   42.961789]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[   42.961794]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[   42.961833]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[   42.961892]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[   42.961896]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[   42.961925]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[   42.961980]   get_mtrr: cpu0 reg00 base=0000000000 size=0000080000 write-back
[   42.961984]   get_mtrr: cpu0 reg01 base=00000a8000 size=0000008000 write-combining
[   42.962252] agpgart-intel 0000:00:00.0: AGP 2.0 bridge
[   42.962276] agpgart-intel 0000:00:00.0: putting AGP V2 device into 1x mode
[   42.962334] radeonfb 0000:01:00.0: putting AGP V2 device into 1x mode
[   49.044082] [drm] Setting GART location based on new memory map
[   49.044094] [drm] Loading R300 Microcode
[   49.044142] [drm] Num pipes: 1
[   49.044149] [drm] writeback test succeeded in 1 usecs
[   66.147672] lib80211_crypt: registered algorithm 'TKIP'
[   72.438218] eth1: no IPv6 routers present
[   82.431455] UDF-fs: No VRS found
[   82.820762] ISO 9660 Extensions: Microsoft Joliet Level 3
[   82.845692] ISO 9660 Extensions: RRIP_1991A



      
