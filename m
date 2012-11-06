From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: scheduler clock for MXS
Date: Tue, 6 Nov 2012 21:46:31 +0800
Message-ID: <20121106134630.GD27643@S2100-06.ap.freescale.net>
References: <50919AFF.3060602@meduna.org>
 <5093D8DE.70505@meduna.org>
 <20121105025753.GA26528@S2100-06.ap.freescale.net>
 <50978370.9060001@meduna.org>
 <20121105134655.GB27260@S2100-06.ap.freescale.net>
 <5097E4A9.3090008@meduna.org>
 <20121105222859.GI28327@n2100.arm.linux.org.uk>
 <5098CB9F.9030401@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:1061
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751410Ab2KFNVD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Nov 2012 08:21:03 -0500
Content-Disposition: inline
In-Reply-To: <5098CB9F.9030401@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Nov 06, 2012 at 09:34:39AM +0100, Stanislav Meduna wrote:
> Shawn: could you try change the
>   update_sched_clock();
> to
>   sched_clock_poll(sched_clock_timer.data);
> right after update_sched_clock call in setup_sched_clock?
> 
With the change, it still wraps at 2 seconds.

Shawn

