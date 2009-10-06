From: Jose Angel Martinez Conde <joseangel@taller-id.com>
Subject: Re: Problem with network on kernel 2.6.29.6-rt23 (Debian)
Date: Tue, 6 Oct 2009 11:18:51 +0200 (CEST)
Message-ID: <1949111338.301254820731590.JavaMail.root@groupware>
References: <1609492146.281254820627823.JavaMail.root@groupware>
Reply-To: Jose Angel Martinez Conde <joseangel@taller-id.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: Hans-Peter Bock <Hans-Peter.Bock@isw.uni-stuttgart.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 43.pool85-52-160.static.orange.es ([85.52.160.43]:60644 "EHLO
	groupware.taller-id.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756341AbZJFJSG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Oct 2009 05:18:06 -0400
In-Reply-To: <1609492146.281254820627823.JavaMail.root@groupware>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi Hans-Peter,

No. My chipset is nForce 650i.

I will try with nForce 780i.

[1] > lspci
00:00.0 Host bridge: nVidia Corporation C55 Host Bridge (rev a2)
00:00.1 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:00.2 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:00.3 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:00.4 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:00.5 RAM memory: nVidia Corporation C55 Memory Controller (rev a2)
00:00.6 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:00.7 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:01.0 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:01.1 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:01.2 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:01.3 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:01.4 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:01.5 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:01.6 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:02.0 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:02.1 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:02.2 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:03.0 PCI bridge: nVidia Corporation C55 PCI Express bridge (rev a1)
00:05.0 PCI bridge: nVidia Corporation C55 PCI Express bridge (rev a1)
00:07.0 PCI bridge: nVidia Corporation C55 PCI Express bridge (rev a1)
00:09.0 RAM memory: nVidia Corporation MCP51 Host Bridge (rev a2)
00:0a.0 ISA bridge: nVidia Corporation MCP51 LPC Bridge (rev a3)
00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a3)
00:0a.2 RAM memory: nVidia Corporation MCP51 Memory Controller 0 (rev a=
3)
00:0b.0 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3=
)
00:0b.1 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3=
)
00:0d.0 IDE interface: nVidia Corporation MCP51 IDE (rev a1)
00:0e.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller (=
rev a1)
00:10.0 PCI bridge: nVidia Corporation MCP51 PCI Bridge (rev a2)
00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio (r=
ev a2)
00:14.0 Bridge: nVidia Corporation MCP51 Ethernet Controller (rev a3)
01:00.0 VGA compatible controller: nVidia Corporation Device 05e1 (rev =
a1)
02:00.0 VGA compatible controller: nVidia Corporation Device 0614 (rev =
a2)
03:00.0 SATA controller: JMicron Technologies, Inc. JMicron 20360/20363=
 AHCI Controller (rev 02)
04:07.0 Ethernet controller: Intel Corporation 82541PI Gigabit Ethernet=
 Controller (rev 05)
04:08.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6306 Fire II IEE=
E 1394 OHCI Link Layer Controller (rev c0)

--
jose angel

----- "Hans-Peter Bock" <Hans-Peter.Bock@isw.uni-stuttgart.de> wrote:

> Hello Jose,
>=20
> hmm, i have a similar issue with my network interfaces on one special
> computer. At first I thought it is a bug in some pci card driver. But
> since the same setup works on a mainboard with different chipset and
> CPU, I do not assume that any longer.
>=20
> My computer with the similar issue has an nVidia chipset, see lspci
> beneath. Does your computer have the same chipset?
>=20
> $ lspci=20
> 00:00.0 Host bridge: nVidia Corporation MCP73 Host Bridge (rev a2)
> 00:00.1 RAM memory: nVidia Corporation nForce 630i memory controller
> (rev a2)
> 00:01.0 RAM memory: nVidia Corporation nForce 630i memory controller
> (rev a1)
> 00:01.1 RAM memory: nVidia Corporation nForce 630i memory controller
> (rev a1)
> 00:01.2 RAM memory: nVidia Corporation nForce 630i memory controller
> (rev a1)
> 00:01.3 RAM memory: nVidia Corporation nForce 630i memory controller
> (rev a1)
> 00:01.4 RAM memory: nVidia Corporation nForce 630i memory controller
> (rev a1)
> 00:01.5 RAM memory: nVidia Corporation nForce 630i memory controller
> (rev a1)
> 00:01.6 RAM memory: nVidia Corporation nForce 630i memory controller
> (rev a1)
> 00:02.0 RAM memory: nVidia Corporation nForce 630i memory controller
> (rev a1)
> 00:03.0 ISA bridge: nVidia Corporation MCP73 LPC Bridge (rev a2)
> 00:03.1 SMBus: nVidia Corporation MCP73 SMBus (rev a1)
> 00:03.2 RAM memory: nVidia Corporation MCP73 Memory Controller (rev
> a1)
> 00:03.4 RAM memory: nVidia Corporation MCP73 Memory Controller (rev
> a1)
> 00:04.0 USB Controller: nVidia Corporation GeForce 7100/nForce 630i
> (rev a1)
> 00:04.1 USB Controller: nVidia Corporation GeForce 7100/nForce 630i
> (rev a1)
> 00:08.0 IDE interface: nVidia Corporation MCP73 IDE (rev a1)
> 00:09.0 Audio device: nVidia Corporation MCP73 High Definition Audio
> (rev a1)
> 00:0a.0 PCI bridge: nVidia Corporation MCP73 PCI Express bridge (rev
> a1)
> 00:0b.0 PCI bridge: nVidia Corporation MCP73 PCI Express bridge (rev
> a1)
> 00:0c.0 PCI bridge: nVidia Corporation MCP73 PCI Express bridge (rev
> a1)
> 00:0d.0 PCI bridge: nVidia Corporation MCP73 PCI Express bridge (rev
> a1)
> 00:0e.0 IDE interface: nVidia Corporation Device 07f0 (rev a2)
> 00:0f.0 Ethernet controller: nVidia Corporation MCP73 Ethernet (rev
> a2)
> 00:10.0 VGA compatible controller: nVidia Corporation GeForce
> 7100/nForce 630i (rev a2)
> 01:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+ (rev 10)
>=20
>=20
> Best regards, Hans-Peter Bock
> --=20
> (=C2=B0< Hans-Peter Bock, Dipl.-Ing., http://www.isw.uni-stuttgart.de=
/ >=C2=B0)
> (/) ISW - Universit=C3=A4t Stuttgart, Seidenstra=C3=9Fe 36, 70174 Stu=
ttgart (\)
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
