From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.11.12-rt13
Date: Wed, 04 Oct 2017 18:07:59 +0200
Message-ID: <1507133279.6934.66.camel@gmx.de>
References: <20170905145244.jro4jywfxugmn7eh@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170905145244.jro4jywfxugmn7eh@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2017-09-05 at 16:52 +0200, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v4.11.12-rt13 patch set. 
> 
> Changes since v4.11.12-rt12:
> 
>   - Merging Anna-Maria's "hrtimer: Provide softirq context hrtimers"
>     series. Merging this series enables the removal of almost all
>     hrtimer related patches in the queue. What is left is the "force
>     switch" of all timers to the softirq context (except a few special
>     ones) and a wait-queue to wait until a timer is completed.
>     The overall diffstat compared to -rt12 is
>       21 files changed, 573 insertions(+), 651 deletions(-)
>     amazing. We have RT wise the same functionality with 78 lines less
>     of code.

(post lazy sod mode [vacation] testing...) 

Seems combo-patch induced some ltp posix conformance test grumbling.

+clock_settime_8_1 ... ... FAILED 
+clock_settime_4_2 ... ... FAILED 
+clock_settime_speculative_4_3 ... ... FAILED 
+timer_settime_5_2 ... ... FAILED 
+timer_settime_5_1 ... ... FAILED 
+timer_settime_5_3 ... ... FAILED 

rtbox:/root # /usr/local/ltp/conformance/interfaces/clock_settime/clock_settime_8-1.run-test
Ended too late.  1507131910 >> 1507131908
Test FAILED
rtbox:/root # /usr/local/ltp/conformance/interfaces/clock_settime/clock_settime_4-2.run-test
timer should have expired _immediately_
rtbox:/root # /usr/local/ltp/conformance/interfaces/clock_settime/speculative/clock_settime_speculative_4-3.run-test
Overrun count =0, not # of repeating timer expirys
FAIL:  Caught 0 signals, not 1
Test FAILED
rtbox:/root # /opt/ltp/conformance/interfaces/timer_settime/timer_settime_5-2.run-test
signal was not sent
