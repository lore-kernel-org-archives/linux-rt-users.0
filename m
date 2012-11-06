From: Stanislav Meduna <stano@meduna.org>
Subject: Re: scheduler clock for MXS
Date: Tue, 06 Nov 2012 09:34:39 +0100
Message-ID: <5098CB9F.9030401@meduna.org>
References: <50919AFF.3060602@meduna.org> <5093D8DE.70505@meduna.org> <20121105025753.GA26528@S2100-06.ap.freescale.net> <50978370.9060001@meduna.org> <20121105134655.GB27260@S2100-06.ap.freescale.net> <5097E4A9.3090008@meduna.org> <20121105222859.GI28327@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Shawn Guo <shawn.guo@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:38510 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043Ab2KFIez (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Nov 2012 03:34:55 -0500
In-Reply-To: <20121105222859.GI28327@n2100.arm.linux.org.uk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05.11.2012 23:28, Russell King - ARM Linux wrote:

> It most certainly does handle the wrapping correctly - it was designed
> to from the very start.

I'm not an expert on Linux kernel and its core infrastructure,
but how is the sched_clock_timer armed for the first time
after calling setup_sched_clock?

The explicitely called update_sched_clock() does _not_ arm it.

Shawn: could you try change the
  update_sched_clock();
to
  sched_clock_poll(sched_clock_timer.data);
right after update_sched_clock call in setup_sched_clock?

Regards
-- 
                                    Stano

