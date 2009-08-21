From: Mark Knecht <markknecht@gmail.com>
Subject: Re: [ANNOUNCE] 2.6.31-rc6-rt6
Date: Fri, 21 Aug 2009 15:57:47 -0700
Message-ID: <5bdc1c8b0908211557q74eefag6cccb5ab321e3997@mail.gmail.com>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.0906151117440.2800@localhost.localdomain>
	 <alpine.LFD.2.00.0906170903370.2800@localhost.localdomain>
	 <alpine.LFD.2.00.0906231418500.2767@localhost.localdomain>
	 <alpine.LFD.2.00.0907092020410.2768@localhost.localdomain>
	 <alpine.LFD.2.00.0907300006250.2936@localhost.localdomain>
	 <alpine.LFD.2.00.0908162207370.2782@localhost.localdomain>
	 <alpine.LFD.2.00.0908182140340.3361@localhost.localdomain>
	 <alpine.LFD.2.00.0908192344500.3361@localhost.localdomain>
	 <alpine.LFD.2.00.0908212319370.1769@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f175.google.com ([209.85.210.175]:50959 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932617AbZHUW5q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Aug 2009 18:57:46 -0400
Received: by yxe5 with SMTP id 5so529174yxe.33
        for <linux-rt-users@vger.kernel.org>; Fri, 21 Aug 2009 15:57:47 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0908212319370.1769@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Aug 21, 2009 at 2:26 PM, Thomas Gleixner<tglx@linutronix.de> wr=
ote:
> We are pleased to announce the next update to our new preempt-rt
> series.
>
<SNIP>
>
> Information on the RT patch can be found at:
>
> =C2=A0 =C2=A0http://rt.wiki.kernel.org/index.php/Main_Page
>
> to build the 2.6.31-rc6-rt6 tree, the following patches should be
> applied:
>
> =C2=A0 =C2=A0http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.30=
=2Etar.bz2
> =C2=A0 =C2=A0http://www.kernel.org/pub/linux/kernel/v2.6/testing/patc=
h-2.6.31-rc6.bz2
> =C2=A0 =C2=A0http://www.kernel.org/pub/linux/kernel/projects/rt/patch=
-2.6.31-rc6-rt6.bz2
>
> Enjoy !
>
> =C2=A0 =C2=A0 =C2=A0 tglx

Hi Thomas,
   Been awhile since I updated my kernel. Our Gentoo pro-audio overlay
seems to be dieing and the maintainers haven't been giving us many
update options so I've been running 2.6.29.2-rt11 for quite a long
time. I saw your announcement and thought I'd give this kernel a try
by hand.

   I had no problems downloading the code above and patching it as per
the rtWiki instructions. I grabbed a copy of my 2.6.29-rt11 .config
file, did make oldconfig, then make menuconfig to check that things
looked good. The build went fine and I installed the kernel. No
problems so far.

   Unfortunately when I tried to boot it the kernel is getting stuck
VERY early in the boot process looking for my hard drives. It waits
for maybe 30-60 seconds looking for the drive and then says something
like 'interrupt lost' or some other such thing.

   If it continues I'll get the exact text but I'm wondering if there
are any places in the kernel config I should be looking for changes in
how the basic kernel would handle finding drives? Did the driver
config change at all? It is acting almost like the machine doesn't
have any hard drives or CDs.

   This is an AMD64 processor running on a 5 year old nVidia chipset.

   I'm back in 2.6.29-rt11 for now.

   I'll see about building just the 2.6.31 kernel as a test also.

Cheers,
Mark

lightning ~ # lspci
00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (=
rev a3)
00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2=
)
00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3=
)
00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97
Audio Controller (rev a2)
00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (=
rev f3)
00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (=
rev f3)
00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
01:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60
[Radeon X300 (PCIE)]
01:00.1 Display controller: ATI Technologies Inc RV370 [Radeon X300SE]
05:06.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall
DSP (rev 68)
05:08.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b
Link Layer Controller (rev 01)
lightning ~ #
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
