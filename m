From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Interrupt Latency 2.6.33.7 rt30
Date: Thu, 1 Sep 2011 21:11:10 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1109012109590.2723@ionos>
References: <4E56B8A5.6080306@gmx.de> <20110826074836.GO16557@pengutronix.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-413182136-1314904271=:2723"
Cc: Christian Kraus <chk.dax@gmx.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51236 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404Ab1IATLO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Sep 2011 15:11:14 -0400
In-Reply-To: <20110826074836.GO16557@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-413182136-1314904271=:2723
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 26 Aug 2011, Uwe Kleine-König wrote:

> On Thu, Aug 25, 2011 at 11:03:33PM +0200, Christian Kraus wrote:
> > Hello
> > I have wrote a GPIO-driver, that toggle the value of a GPIO when a
> > interrupt is comming from an another GPIO.
> > When I measure the latency between the interrupt and the toggled Pin
> > it's about ten times higher than without the rt-patch.
> > (without Patch = 8-11 us
> >  with Patch = 30-110 us)
> It's expected and known that an rt kernel has a worse average latency.

Nonsense.

> Having said that I cannot say if the increase you see is "too much".
> 
> The best option you have is asking ftrace what happens in these 30-110
> us after making sure you have a decent sched_clock implementation.

The problem is simply that the interrupt is forced threaded, so it
depends on the scheduler when it goes on the CPU, while on !RT the
code runs in hard interrupt context.

Thanks,

	tglx
--8323328-413182136-1314904271=:2723--
