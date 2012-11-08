From: Stanislav Meduna <stano@meduna.org>
Subject: Re: scheduler clock for MXS
Date: Thu, 08 Nov 2012 22:27:59 +0100
Message-ID: <509C23DF.1020106@meduna.org>
References: <5093D8DE.70505@meduna.org> <20121105025753.GA26528@S2100-06.ap.freescale.net> <50978370.9060001@meduna.org> <20121105134655.GB27260@S2100-06.ap.freescale.net> <5097E4A9.3090008@meduna.org> <20121105222859.GI28327@n2100.arm.linux.org.uk> <5098CB9F.9030401@meduna.org> <20121106134630.GD27643@S2100-06.ap.freescale.net> <20121106202038.GB32398@n2100.arm.linux.org.uk> <50998F94.8000908@meduna.org> <20121106224624.GR28327@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Shawn Guo <shawn.guo@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:41919 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752787Ab2KHV20 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Nov 2012 16:28:26 -0500
In-Reply-To: <20121106224624.GR28327@n2100.arm.linux.org.uk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06.11.2012 23:46, Russell King - ARM Linux wrote:

>  * round_jiffies - function to round jiffies to a full second
> 
> This is probably it.  With mine, it's a 32.768kHz clock, so limiting
> it to 16-bit gives a wrap period of 2 seconds exactly.  We take 10%
> off, so the timer would be asked to fire every 1.8s, which would be
> rounded up to 2 seconds.  That's a little too close for comfort...

Confirmed.

- if I artificially change my timer code to act as a 16-bit one,
  I get wrap-arounds. Not always, but there are definitely some
  during the bootup (where maybe the tick is sometimes delayed
  a tad more)

- if I then remove the round_jiffies and only leave jiffies +
  wrap_ticks, the wrap-arounds go away

> I think in this case, we need a version of round_jiffies() which _always_
> rounds down.  Unfortunately, it doesn't exist.  Thomas?  What are the
> options here?

What is actually the reason of round_jiffies there? The
http://kernel.org/doc/htmldocs/device-drivers/API-round-jiffies.html
mentions saving power, is it the only one?

I'd probably just leave the round_jiffies out at least for
wrap_ticks < around 16*HZ. Above that the error by possibly
rounding up can be ignored.

There is also a round_jiffies_up - unless I am too tired, as long as
we tick no faster than once per second, subtracting (HZ-1) and rounding
up should be the same as rounding down.

But: is the round_jiffies* safe at all for sub-second precision
at jiffies around 0xffffffff? From quick looking it does a modulo,
0xffffffff % say 250 is 45, the next jiffy is at 0...

Regards
-- 
                                       Stano

