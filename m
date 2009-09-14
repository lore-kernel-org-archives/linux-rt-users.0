From: Bo Hansen <bh@newtec.dk>
Subject: Re: hrtimer problem on AT91RM9200
Date: Mon, 14 Sep 2009 11:09:04 +0200
Message-ID: <4AAE0830.4080209@newtec.dk>
References: <4A8BEF09.2080300@newtec.dk> <20090820195200.GA3331@pengutronix.de> <4A8E99C7.6080106@newtec.dk> <20090903141217.GB22289@pengutronix.de> <4AA8A03B.2050804@newtec.dk> <20090910095128.GA1967@pengutronix.de> <20090911152044.GA5872@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	john stultz <johnstul@us.ibm.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:59035 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755290AbZINJJD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Sep 2009 05:09:03 -0400
In-Reply-To: <20090911152044.GA5872@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Uwe,

I use cyclictest -p95 -n -i2000 -t40 and 3x ping -s65000. In the=20
beginning I had hackbench 4 running also, but
actually the cyclictest was enough to trigger the panic.
Also I'm running from NFS rootfs and running cyclictest from an ssh=20
connection.

Best regards
Bo


Uwe Kleine-K=F6nig wrote:
> Hello Bo,
>
> In the meantime I got access to an at91rm9200, too.  To help me
> reproducing the problem:
>
>  - which options do you use for cyclictest?
>  - Is the system idle or do you run hackbench or similar in parallel?
>  - anything else?
>
> Best regards
> Uwe
>
>  =20
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
