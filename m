From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Preempt RT on ARM (some simple compile patches attached)
Date: Tue, 3 Mar 2009 01:22:51 +0100
Message-ID: <20090303002251.GB16807@pengutronix.de>
References: <200903021824.43495.tim01@vlsi.informatik.tu-darmstadt.de> <20090303001525.GA16807@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41980 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbZCCAWx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Mar 2009 19:22:53 -0500
Content-Disposition: inline
In-Reply-To: <20090303001525.GA16807@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi again,

>                      They base on v2.6.29-rc6-rt3 and don't need to a=
dd
> the #include for asm/memory.h.
As you can see in the patches I just sent the second part isn't correct=
=2E
I just didn't notice I had this in my patch stack, because I fixed it i=
n
a different way.

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
