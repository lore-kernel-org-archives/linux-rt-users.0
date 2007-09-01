From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: jitter bursts
Date: Sat, 1 Sep 2007 11:13:12 +0200
Message-ID: <20070901091312.GV23573@pengutronix.de>
References: <20070831151727.GT23573@pengutronix.de> <46D83A99.3080707@l1nuxh4ck3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org,
	Michael Olbrich <m.olbrich@pengutronix.de>,
	kiszka@rts.uni-hannover.de
To: Bernhard Kuhn <kuhn@l1nuxh4ck3r.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:59264 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754216AbXIAJNU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 1 Sep 2007 05:13:20 -0400
Content-Disposition: inline
In-Reply-To: <46D83A99.3080707@l1nuxh4ck3r.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Aug 31, 2007 at 05:58:17PM +0200, Bernhard Kuhn wrote:
> I guess these latencies didn't show up at the system you are porting
> from?  Is the HW setup from the system you are porting from the same
> as you are using with -rt?

Both boxes are x86 (one normal PC - Celeron 2.4 GHz / ICH5 chipset, and
one ETX PIII mobile, 1 GHz) with 2.6.22.1-rt9; we also tried several
versions, without changes in the behaviour.

> Are both, sender and receiver are using -rt?

Yup.

> What happens if you are using the old system as sender and -rt for the
> receiver?  What happens if you are using -rt as sender and -rt as
> receiver?

That's the scenario.

> Are you using an onboard nvidia SATA controller?

Nope; the box is currently off, but it's the same hardware as this one:

rsc@metis:~> lspci
00:00.0 Host bridge: Intel Corporation 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
00:01.0 PCI bridge: Intel Corporation 82865G/PE/P PCI to AGP Controller (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #3 (rev 02)
00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #4 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
02:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
02:09.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 05)
02:0b.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01)

We'll make a release of the test program on monday, I think it should be
possible to easily reproduce the scenario if you have two boxes and a 100 MBit
hub.

Robert
-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de
