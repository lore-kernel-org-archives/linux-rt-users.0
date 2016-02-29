From: Jean-Denis Girard <jd.girard@sysnux.pf>
Subject: Re: acmesystems Arietta (AT91SAM9G25)
Date: Mon, 29 Feb 2016 06:08:47 -1000
Message-ID: <nb1qeg$9mm$1@ger.gmane.org>
References: <nat4ql$41m$1@ger.gmane.org>
 <20160229081039.GC2613@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40139 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbcB2QJG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Feb 2016 11:09:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1aaQNZ-0006Bw-Fd
	for linux-rt-users@vger.kernel.org; Mon, 29 Feb 2016 17:09:01 +0100
Received: from 252.90.50.123.dsl.dyn.mana.pf ([123.50.90.252])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Feb 2016 17:09:01 +0100
Received: from jd.girard by 252.90.50.123.dsl.dyn.mana.pf with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Feb 2016 17:09:01 +0100
In-Reply-To: <20160229081039.GC2613@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Uwe,

Thanks for the reply!

Le 28/02/2016 22:10, Uwe Kleine-K=F6nig a =E9crit :
> Alexandre Belloni wrote something about rt and at91 that might be wor=
th
> to look into. I don't know how much of it is obsolete with 4.4.2-rt7,
> though.
>=20
> http://article.gmane.org/gmane.linux.rt.user/14728

I have read (and replied to) that article, and even tried to apply some
of the patches mentioned, but could never get kernel to boot.

As I said, I'm a newbie on Linux RT: is there anything I should check i=
n
my kernel config? I mean, are there any configuration parameters none t=
o
be a problem with PREEMPT_RT_FULL, but working fine with PREEMPT__LL?


Thanks,
--
Jean-Denis Girard

SysNux                Syst=E8mes   Linux   en   Polyn=E9sie   fran=E7ai=
se
http://www.sysnux.pf/ T=E9l: +689 40.50.10.40 / GSM: +689 87.79.75.27

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
