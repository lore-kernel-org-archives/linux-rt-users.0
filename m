From: Stanislav Meduna <stano@meduna.org>
Subject: scheduler clock for MXS [Was: Re: Wakeup latency measured with SCHED_TRACER
 depends on HZ]
Date: Mon, 05 Nov 2012 10:14:24 +0100
Message-ID: <50978370.9060001@meduna.org>
References: <50919AFF.3060602@meduna.org> <5093D8DE.70505@meduna.org> <20121105025753.GA26528@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:32977 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753617Ab2KEJOl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Nov 2012 04:14:41 -0500
In-Reply-To: <20121105025753.GA26528@S2100-06.ap.freescale.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05.11.2012 03:57, Shawn Guo wrote:

>> The patch in attach fixes this. I can only test the MX28 part -
>> I don't have any timrot_is_v1() (MX23) hardware and I don't
>> know whether a source that wraps after ~2 seconds is OK at all.
> 
> From my quick testing on imx23 with printk timestamp, it's not OK,
> so we may need to leave imx23 out there.

Hmm, does it wrap after 2 seconds? From my grepping and googling
the code should now adapt itself, the hardcoded limit is gone...
What does the dmesg line such as

  sched_clock: 32 bits at 32kHz, resolution 31250ns,
    wraps every 134217727ms

output on that hardware?

Thanks for the comments, I will resubmit the corrected patch after
waiting ~1,5 days to verify correct wrapping with MX28.

Regards
-- 
                                         Stano

