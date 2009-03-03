From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Preempt RT on ARM (some simple compile patches attached)
Date: Tue, 3 Mar 2009 01:15:25 +0100
Message-ID: <20090303001525.GA16807@pengutronix.de>
References: <200903021824.43495.tim01@vlsi.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59128 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396AbZCCAP2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Mar 2009 19:15:28 -0500
Content-Disposition: inline
In-Reply-To: <200903021824.43495.tim01@vlsi.informatik.tu-darmstadt.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On Mon, Mar 02, 2009 at 06:24:43PM +0100, Tim Sander wrote:
> I just tried to get ftrace running for the i.Mx31 and 2.6.29-rc6-rt3.=
 The=20
> patches i posted still work to get preempt-rt running. But it seems a=
s if=20
> some parts for ARM are missing.=20
You should check the warnings you get.  There are several telling you:

	warning: unsupported argument to '__builtin_return_address

you need to fix them.  (Or wait until I find the time to post my fix.
:-) The first part is already in tip/master.)

To fix compilation I did nearly the same things.  Find my patches as a
reply to this mail.  They base on v2.6.29-rc6-rt3 and don't need to add
the #include for asm/memory.h.  Haven't checked why.

You can find the patches in my git repo, too.  Either at

	git://git.pengutronix.de/git/ukl/linux-2.6.git rt-master

or in the topgit controlled patches in the same repo with t/rt-master
being the topmost patch.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
