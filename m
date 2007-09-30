From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: Cyclictest expected results
Date: Sun, 30 Sep 2007 20:32:53 +0200
Message-ID: <20070930183253.GW23573@pengutronix.de>
References: <1985e0f60709300837l1b16deedgb15575bc73a729ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: Jaswinder Singh <jaswinderlinuxrt@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:33610 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750817AbXI3Sc7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 30 Sep 2007 14:32:59 -0400
Content-Disposition: inline
In-Reply-To: <1985e0f60709300837l1b16deedgb15575bc73a729ad@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, Sep 30, 2007 at 09:07:19PM +0530, Jaswinder Singh wrote:
> Here are my results on Intel Pentium 4 :
>
> Command line :  ./cyclictest -t 1 -p 80 -i 10000 -l 10000 -q

Can you post the output of /proc/timer_list?

> 2.6.23-rc8-rt1 :
> WARNING: High resolution timers not available
> T: 0 ( 2003) P:80 I:10000 C:  10000 Min:   1500 Act: 6129 Avg: 4502 Max:    7832

That one should give you sane results.

> From where I can get Linux-2.6.16-hrt5 and Linux-2.6.16-rt12 patches.

I don't think it makes much sense to play with such an old kernel any more.

> CONFIG_HIGH_RES_TIMERS=y are defined in .config then why I am getting
> "WARNING: High resolution timers not available".
>
> Why my results are not so impressive in realtime even though I defined:
> CONFIG_PREEMPT_RT=y
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_SOFTIRQS=y
> CONFIG_PREEMPT_HARDIRQS=y
> CONFIG_PREEMPT_BKL=y

Doesn't look too bad. Are you sure you actually _bootet_ that kernel? :)

> Min, Avg and Max are showing cyclic latencies. Ideally It should be
> ZERO. Am I right ?

You won't get zero. On x86 these latencies should be well below 100 us
maximum time, with an average in the lower 10 us range.

Robert
-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de
