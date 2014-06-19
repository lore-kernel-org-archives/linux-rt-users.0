From: Rolf Peukert <rolf.peukert@imms.de>
Subject: 3.2.60-rt87: arm: Doesn't boot in certain case
Date: Thu, 19 Jun 2014 21:04:06 +0200
Message-ID: <53A33426.6080505@imms.de>
References: <20140618201355.3f8baecb@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from infosrv.imms.de ([194.95.250.51]:37709 "EHLO infosrv.imms.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757780AbaFSTdn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Jun 2014 15:33:43 -0400
In-Reply-To: <20140618201355.3f8baecb@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Steven,

I just tried the new kernel version 3.2.60-rt87 on our ARM-Cortex-A8
board and while it works fine with the standard configuration, it won't
boot if the option CONFIG_MISSED_TIMER_OFFSETS_HIST is set.

The kernel error message reports a NULL pointer dereference at
__hrtimer_start_range_ns+0xf4, which probably is line 1038 in file
kernel/hrtimer.c, where new_base->get_time() is called before new_base
is set.
(actually there was a compiler warning too, but I didn't pay enough
attention to the compiler output...)


#ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
        {
                ktime_t now = new_base->get_time();

                if (ktime_to_ns(tim) < ktime_to_ns(now))
                        timer->praecox = now;
                else
                        timer->praecox = ktime_set(0, 0);
        }
#endif
        hrtimer_set_expires_range_ns(timer, tim, delta_ns);

        /* Switch the timer base, if necessary: */
        new_base = switch_hrtimer_base(timer, base, mode &
HRTIMER_MODE_PINNED);


Since I moved the #ifdef...#endif block down below the
new_base=switch_hrtimer... statement, the kernel boots and works so far,
but I'm not sure if this is what was originally intended here.

Best regards
Rolf

