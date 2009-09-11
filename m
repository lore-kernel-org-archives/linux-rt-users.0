From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: hrtimer problem on AT91RM9200
Date: Fri, 11 Sep 2009 17:20:44 +0200
Message-ID: <20090911152044.GA5872@pengutronix.de>
References: <4A8BEF09.2080300@newtec.dk> <20090820195200.GA3331@pengutronix.de> <4A8E99C7.6080106@newtec.dk> <20090903141217.GB22289@pengutronix.de> <4AA8A03B.2050804@newtec.dk> <20090910095128.GA1967@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Bo Hansen <bh@newtec.dk>, Thomas Gleixner <tglx@linutronix.de>,
	john stultz <johnstul@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44773 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524AbZIKPUq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Sep 2009 11:20:46 -0400
Content-Disposition: inline
In-Reply-To: <20090910095128.GA1967@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Bo,

In the meantime I got access to an at91rm9200, too.  To help me
reproducing the problem:

 - which options do you use for cyclictest?
 - Is the system idle or do you run hackbench or similar in parallel?
 - anything else?

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
