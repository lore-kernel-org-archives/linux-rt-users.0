From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: scheduler clock for MXS [Was: Re: Wakeup latency measured with
 SCHED_TRACER depends on HZ]
Date: Tue, 6 Nov 2012 21:49:50 +0800
Message-ID: <20121106134944.GE27643@S2100-06.ap.freescale.net>
References: <50919AFF.3060602@meduna.org>
 <5093D8DE.70505@meduna.org>
 <20121105025753.GA26528@S2100-06.ap.freescale.net>
 <50978370.9060001@meduna.org>
 <20121105134655.GB27260@S2100-06.ap.freescale.net>
 <5097E4A9.3090008@meduna.org>
 <20121105222859.GI28327@n2100.arm.linux.org.uk>
 <20121106024052.GA27643@S2100-06.ap.freescale.net>
 <20121106101229.GN28327@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Stanislav Meduna <stano@meduna.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:33093 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751903Ab2KFNYQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Nov 2012 08:24:16 -0500
Content-Disposition: inline
In-Reply-To: <20121106101229.GN28327@n2100.arm.linux.org.uk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Nov 06, 2012 at 10:12:29AM +0000, Russell King - ARM Linux wrote:
> > [    0.000000] sched_clock: 16 bits at 32kHz, resolution 31250ns, wraps every 20
> > 47ms
> 
> So where are you setting this up?  My guess is it's after time_init()
> has done its stuff.

It gets set up in machine_desc->timer->init() which is called right
in time_init() just before sched_clock_postinit().

Shawn

