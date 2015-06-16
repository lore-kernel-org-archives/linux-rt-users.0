From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: kernel 3.2.0 with rt patch-3.2-rt10.patch.gz hangs up Ethernet
 module
Date: Tue, 16 Jun 2015 18:32:33 +0200
Message-ID: <20150616163233.GA15524@linutronix.de>
References: <loom.20150616T094748-860@post.gmane.org>
 <20150616081158.GI19996@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marcus lu <marcus.lu@delta.com.tw>, linux-rt-users@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45883 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbbFPQch convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jun 2015 12:32:37 -0400
Content-Disposition: inline
In-Reply-To: <20150616081158.GI19996@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Uwe Kleine-K=C3=B6nig | 2015-06-16 10:11:58 [+0200]:

>Hello,
>
>On Tue, Jun 16, 2015 at 07:58:06AM +0000, Marcus lu wrote:
>> I try kernel version 3.2.0 and RT patch patch-3.2-rt10.patch.gz on T=
I=20
>> AM335x EVM(Cortex A8), I find out a problem.=20
>Is there a reason you're not using the latest and greatest 3.2-stable
>plust the matching lates -rt patch? Also 3.2 is already old and the
>am335x support in mainline is good, so better use a more recent releas=
e.

exactly. I remember fixing the driver for v3.8-RT. And v3.2 should have
no support for am335x so there is no way to backport that stuff. Use
something more recent.

>Best regards
>Uwe

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
