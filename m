From: Ralf Mardorf <ralf.mardorf@rocketmail.com>
Subject: 3.18.9-rt4
Date: Fri, 13 Mar 2015 22:30:41 +0100
Message-ID: <20150313223041.0a8bf390@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nm1-vm6.bullet.mail.ir2.yahoo.com ([212.82.96.77]:56836 "EHLO
	nm1-vm6.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757104AbbCMVhC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Mar 2015 17:37:02 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

all kernels >=3D 3.14.34-rt31 I tested, don't finish startup on my mach=
ine [1].
This are the last messages of startups for 4 different startups for 3.1=
8.9-rt4.

Picture URLs:
http://picpaste.com/3.18.9-rt4.x86_64.end_of_startup_2.jpg
http://picpaste.com/3.18.9-rt4.x86_64.end_of_startup_3.jpg
http://picpaste.com/3.18.9-rt4.x86_64.end_of_startup_4.jpg
http://picpaste.com/3.18.9-rt4.x86_64.end_of_startup_5.jpg

The last kernel I tested that does work is 3.14.28-rt25.

Regards,
Ralf

[1]

$ arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: HDSPMx579bcc [RME AIO_579bcc], device 0: RME AIO [RME AIO]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: EWX2496 [TerraTec EWX24/96], device 0: ICE1712 multi [ICE1712 m=
ulti]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: EWX2496_1 [TerraTec EWX24/96], device 0: ICE1712 multi [ICE1712=
 multi]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

AMD BE-2350 Athlon X2 Dual-Core Processor
ASUS M2A-VM HDMI motherboard, but the HDMI card isn't connected
Integrated ATI Radeon X1250-based graphics

http://www.asus.com/Motherboards/M2AVM_HDMI/specifications/

# dmidecode 2.12
SMBIOS 2.4 present.
60 structures occupying 1782 bytes.
Table at 0x000F0000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
        Vendor: Phoenix Technologies, LTD
        Version: ASUS M2A-VM HDMI ACPI BIOS Revision 2302
        Release Date: 02/05/2009
[snip]
Handle 0x0005, DMI type 4, 35 bytes
Processor Information
        Socket Designation: Socket AM2=20
        Type: Central Processor
        Family: Athlon 64
        Manufacturer: AMD
        ID: B2 0F 06 00 FF FB 8B 17
        Signature: Family 15, Model 107, Stepping 2
        Flags:
                FPU (Floating-point unit on-chip)
                VME (Virtual mode extension)
                DE (Debugging extension)
                PSE (Page size extension)
                TSC (Time stamp counter)
                MSR (Model specific registers)
                PAE (Physical address extension)
                MCE (Machine check exception)
                CX8 (CMPXCHG8 instruction supported)
                APIC (On-chip APIC hardware supported)
                SEP (Fast system call)
                MTRR (Memory type range registers)
                PGE (Page global enable)
                MCA (Machine check architecture)
                CMOV (Conditional move instruction supported)
                PAT (Page attribute table)
                PSE-36 (36-bit page size extension)
                CLFSH (CLFLUSH instruction supported)
                MMX (MMX technology supported)
                FXSR (FXSAVE and FXSTOR instructions supported)
                SSE (Streaming SIMD extensions)
                SSE2 (Streaming SIMD extensions 2)
                HTT (Multi-threading)
        Version: AMD Athlon(tm) X2 Dual Core Processor BE-2350
        Voltage: 1.2 V
        External Clock: 200 MHz
        Max Speed: 3800 MHz
        Current Speed: 2100 MHz
        Status: Populated, Enabled
        Upgrade: Socket 940
        L1 Cache Handle: 0x000B
        L2 Cache Handle: 0x000C
        L3 Cache Handle: Not Provided
        Serial Number: =20
        Asset Tag: =20
        Part Number:
[snip]


There's no newer BIOS version, excepted of a beta version available.


Beta Version  5001
=09
Description 	M2A-VM BIOS 5001
1=EF=BC=8E Beta Bios for Supporting AM3 CPUs.
2=EF=BC=8E System still able to POST when set CPU Multiplier to 35X, bu=
t
 actual frequency will not change.
3=EF=BC=8E Due to chipset limitation, Max
 HT Link is 1000MHz only.
4=EF=BC=8E It will no display if downgrade Bios to
 lower version. File Size =09
550,51 (KBytes) 	2010.04.14  update
Download from =09
Global (DLM) Global =09
Version  2302
=09
Description 	M2A-VM HDMI BIOS 2302
=46ix the problem that system may hang on post when use AM2 cpu.
=46ile Size =09
540,14 (KBytes) 	2009.02.13  update
Download from =09
Global (DLM) Global

http://support.asus.com/Download.aspx?SLanguage=3Den&m=3DM2A-VM+HDMI&p=3D=
1&s=3D24
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
