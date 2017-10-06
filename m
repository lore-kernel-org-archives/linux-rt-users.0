From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.11.12-rt13
Date: Fri, 06 Oct 2017 19:38:08 +0200
Message-ID: <1507311488.5480.20.camel@gmx.de>
References: <20170905145244.jro4jywfxugmn7eh@linutronix.de>
         <1507133279.6934.66.camel@gmx.de>
         <20171005155441.72mjaac5c42rjilf@linutronix.de>
         <1507256431.6597.16.camel@gmx.de>
         <20171006102820.ou4wpm56ed6m3ewr@linutronix.de>
         <1507296802.6364.14.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507296802.6364.14.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2017-10-06 at 15:33 +0200, Mike Galbraith wrote:
> 
> I'll run full ltp again, make sure there are no new failure deltas.

Haven't done that yet, but I have checked all of the reported failures.

time-hrtimer:-Use-softirq-based-wakeups-for-non-RT-threads.patch fixes
clock_settime_8-1.run-test, hrtimer:-Update-offset-for-soft-bases.patch 
fixes the rest.

However...

homer:..debug/tracing # /usr/local/ltp/conformance/interfaces/clock_settime/clock_settime_8-1.run-test
Test PASSED
homer:..debug/tracing # chrt -f 1 /usr/local/ltp/conformance/interfaces/clock_settime/clock_settime_8-1.run-test
Ended too late.  1507308976 >> 1507308974
Test FAILED

That's a bit troubling.  No earlier kernel, rt or not, cares about
policy.  Either now getting a NAK is less than wonderful, but
SCHED_FIFO gets a NAK while SCHED_OTHER walks away with an ACK?

	-Mike
