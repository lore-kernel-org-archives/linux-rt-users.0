From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: 2.6.33-rt6 on Beagle
Date: Mon, 15 Mar 2010 10:20:43 +0100
Message-ID: <20100315092043.GC31275@pengutronix.de>
References: <alpine.LFD.2.00.1002241740410.4245@localhost.localdomain> <alpine.LFD.2.00.1002262041020.4245@localhost.localdomain> <alpine.LFD.2.00.1003121124120.22855@localhost.localdomain> <2A3DCF3DA181AD40BDE86A3150B27B6B030D084301@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: "Chatterjee, Amit" <amit.chatterjee@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34211 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935930Ab0COJUo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Mar 2010 05:20:44 -0400
Content-Disposition: inline
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030D084301@dbde02.ent.ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Amit,

On Fri, Mar 12, 2010 at 05:47:56PM +0530, Chatterjee, Amit wrote:
> Hi,
> 	I am unable to boot the kernel (as available in this link - http://g=
it.kernel.org/?p=3Dlinux/kernel/git/tip/linux-2.6-tip.git;a=3Dshortlog;=
h=3Drefs/heads/rt/2.6.33) on Beagle board. Kernel is unable to uncompre=
ss itself & crashing. Tool chain used is - gcc version 4.4.1 (Sourcery =
G++ Lite 2009q3-67). I will check with older toolchain & keep it posted=
=2E

Can you try to cherry-pick 5de813b6cd06460b337f9da9afe316823cf3ef45
currently sitting in Russell Kings devel branch[1]?

The decompressor has a known bug in .33 on ARM.

Best regards
Uwe

[1]
http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.=
git/

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
