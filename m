From: Andrea Tassi <andrea.tassi@gmail.com>
Subject: Port PREEMPT_RT on AR71xx
Date: Mon, 25 Jan 2010 11:03:32 +0100
Message-ID: <cac06ad61001250203j3244bcabma771f23eb7a475ad@mail.gmail.com>
References: <cac06ad61001250125r351aae92l92e1d0fc6b31909c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f215.google.com ([209.85.220.215]:50212 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971Ab0AYKDe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jan 2010 05:03:34 -0500
Received: by fxm7 with SMTP id 7so1826806fxm.28
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2010 02:03:33 -0800 (PST)
In-Reply-To: <cac06ad61001250125r351aae92l92e1d0fc6b31909c@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
I'm tying to port the PREEMPT_RT patch to AR71xx CPU family; this kind
of CPU are MIPS. I'm using the last revision of OpenWrt Linux distro.
The platform can be added into the kernel using the files that you can
download form=A0https://dev.openwrt.org/browser/trunk/target/linux/ar71=
xx/files.
These are the steps done:
0) I to build the Kernel with the OpenWrt patches delete (only to
perform some tests...) the patch 110-netfilter_match_speedup.patch and
the=A0200-sched_esfq.patch from
=2E/trunk/target/linux/generic-2.6/patches-2.6.31/ folder. I used the
kernel 2.6.31.12.

1) copy into the=A0./trunk/target/linux/generic-2.6/patches-2.6.31/ the
http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.31.12-rt20=
=2Egz
patch (RT20)

2) when you build the kernel you will have a problem at line 1852 of
the file ./fs/yaffs2/yaffs_fs.c (that you will find in the kernel of
OpenWrt distro): I replaced the init_MUTEX(&dev->grossLock) with
semaphore_init(&dev->grossLock). Now you can build the kernel.

3) I also changed the specific drivers as reported in
http://www.celinuxforum.org/CelfPubWiki/JapanTechnicalJamboree14?action=
=3DAttachFile&do=3Dget&target=3Dpreempt070427celfjambo14.pdf:
spin_lock, etc...

4) when you boot the kernel in a device (I tested it with an Ubiquiti
RouterStation) you will have a kernel panic. Look at
arch/mips/ar71xx/irq.c, you have a kernel panic when you call
setup_irq(....) with struct irqaction with ".handler =3D=A0no_action". =
=46or
this reasons if you comment out the lines 98, 175, 261 and 359 the
kernel boots.
=A0=A0 =A0 =A0 =A0 =A0 =A0Q1) Is this fix correct?

5) the problem now is the filesystem; I can use: jffs2, yaffs or
squashfs. I'd link to use the jffs2, it can be mounted without kernel
panics but I=A0have a lot pf problems:
=A0=A0 =A0 =A0 =A0 =A0 5.1) the fs operations (the OpenWrt first boot
initialisation performed by the kernel) are very slow.
=A0=A0 =A0 =A0 =A0 =A0 5.2) the init script are not called propriety: o=
nly some
services starts.

I know that I have many problems with this device but if you want
cooperate in the porting or guide me in this experiment are wellcome.

Regards
Andrea
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
