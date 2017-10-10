From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.11.12-rt13
Date: Tue, 10 Oct 2017 19:27:00 +0200
Message-ID: <1507656420.15259.6.camel@gmx.de>
References: <20170905145244.jro4jywfxugmn7eh@linutronix.de>
         <1507133279.6934.66.camel@gmx.de>
         <20171005155441.72mjaac5c42rjilf@linutronix.de>
         <1507256431.6597.16.camel@gmx.de>
         <20171006102820.ou4wpm56ed6m3ewr@linutronix.de>
         <1507296802.6364.14.camel@gmx.de> <1507311488.5480.20.camel@gmx.de>
         <1507351853.12111.5.camel@gmx.de>
         <20171010162455.qmvgr476j36nqev7@linutronix.de>
         <20171010164749.apnxbh5kkvkgrmwe@linutronix.de>
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
In-Reply-To: <20171010164749.apnxbh5kkvkgrmwe@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2017-10-10 at 18:47 +0200, Sebastian Andrzej Siewior wrote:
> On 2017-10-10 18:24:55 [+0200], To Mike Galbraith wrote:
> > > homer:..debug/tracing # time chrt -f 1 /usr/local/ltp/conformance/interfaces/clock_settime/clock_settime_8-1.run-test
> > > Ended too late.  1507351636 >> 1507351634
> > > Test FAILED
> > > 
> > > real    0m7.002s
> > > user    0m0.000s
> > > sys     0m0.002s
> > 
> > As per POSIX we should sleep only 5 secs despite the CLOCK_REALTIME
> > change. In RT case however we sleep 7 so we somehow account it which is
> > wrong.
> 
> This should cure it:

Yup, nailed it.  I hadn't gotten around to chasing this one (4 weeks
vacation === baaaackloooog), but did do the promised full ltp run with
fixes applied, and there were no shiny new failures.  So tree should
now be perfect.. modulo the pile of bugs nobody has as yet noticed :)

> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1258,6 +1258,8 @@ static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
>  			clock_id = CLOCK_MONOTONIC;
>  		else if (clock_id == CLOCK_REALTIME_SOFT)
>  			clock_id = CLOCK_MONOTONIC_SOFT;
> +		else if (clock_id == CLOCK_REALTIME_HARD)
> +			clock_id = CLOCK_MONOTONIC;
>  	}
>  
>  	base = hrtimer_clockid_to_base(clock_id);
>  
> Sebastian
