From: Stanislav Meduna <stano@meduna.org>
Subject: Re: scheduler clock for MXS [Was: Re: Wakeup latency measured with
 SCHED_TRACER depends on HZ]
Date: Mon, 05 Nov 2012 17:09:13 +0100
Message-ID: <5097E4A9.3090008@meduna.org>
References: <50919AFF.3060602@meduna.org> <5093D8DE.70505@meduna.org> <20121105025753.GA26528@S2100-06.ap.freescale.net> <50978370.9060001@meduna.org> <20121105134655.GB27260@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:43112 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753118Ab2KEQJ2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Nov 2012 11:09:28 -0500
In-Reply-To: <20121105134655.GB27260@S2100-06.ap.freescale.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05.11.2012 14:46, Shawn Guo wrote:

>>> From my quick testing on imx23 with printk timestamp, it's not OK,
>>> so we may need to leave imx23 out there.
>>
> I should say it's practically not OK since it wraps in such a short
> period.  But it actually works as expected.
> 
>> Hmm, does it wrap after 2 seconds?
> 
> Yes, it does wrap after ~2 seconds.

This is weird. AFAIK the printk should be using sched_clock(),
which is a weak symbol overridden in arch/arm/kernel/sched_clock.c
and it should take care of the extension to never-ever-wrapping
64-bit timestamp. Looks that it does not and if it does not,
I think there is more to be worried of than just printk timestamps.

I don't see anything wrong with the code; bumping the 64-bit
part so that it is no more than wrap time away should take
place in sched_clock_timer which is called at 90% of the
time interval.

BTW this patch deserves IMHO looking at
  https://patchwork.kernel.org/patch/1193631/
but it is probably not the problem here.

In case it matters I'm working with the current 3.4 with
RT patches (none of them touches arch/arm/mach-mxs) - sorry
not to mention it earlier, I forgot to write it again after
I included additional mailing lists to the discussion.


Regards
-- 
                                            Stano

