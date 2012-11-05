From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: scheduler clock for MXS [Was: Re: Wakeup latency measured with
 SCHED_TRACER depends on HZ]
Date: Mon, 5 Nov 2012 21:46:56 +0800
Message-ID: <20121105134655.GB27260@S2100-06.ap.freescale.net>
References: <50919AFF.3060602@meduna.org>
 <5093D8DE.70505@meduna.org>
 <20121105025753.GA26528@S2100-06.ap.freescale.net>
 <50978370.9060001@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	<linux@arm.linux.org.uk>, <linux-arm-kernel@lists.infradead.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:18611
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752643Ab2KENV3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Nov 2012 08:21:29 -0500
Content-Disposition: inline
In-Reply-To: <50978370.9060001@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Nov 05, 2012 at 10:14:24AM +0100, Stanislav Meduna wrote:
> On 05.11.2012 03:57, Shawn Guo wrote:
> 
> >> The patch in attach fixes this. I can only test the MX28 part -
> >> I don't have any timrot_is_v1() (MX23) hardware and I don't
> >> know whether a source that wraps after ~2 seconds is OK at all.
> > 
> > From my quick testing on imx23 with printk timestamp, it's not OK,
> > so we may need to leave imx23 out there.
> 
I should say it's practically not OK since it wraps in such a short
period.  But it actually works as expected.

> Hmm, does it wrap after 2 seconds?

Yes, it does wrap after ~2 seconds.

> From my grepping and googling
> the code should now adapt itself, the hardcoded limit is gone...
> What does the dmesg line such as
> 
>   sched_clock: 32 bits at 32kHz, resolution 31250ns,
>     wraps every 134217727ms
> 
> output on that hardware?
> 
Yes, something like:

  sched_clock: 16 bits at 32kHz, resolution 31250ns, wraps every 2047ms

Shawn

