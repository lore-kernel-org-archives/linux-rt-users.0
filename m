From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.11.12-rt13
Date: Fri, 06 Oct 2017 15:33:22 +0200
Message-ID: <1507296802.6364.14.camel@gmx.de>
References: <20170905145244.jro4jywfxugmn7eh@linutronix.de>
         <1507133279.6934.66.camel@gmx.de>
         <20171005155441.72mjaac5c42rjilf@linutronix.de>
         <1507256431.6597.16.camel@gmx.de>
         <20171006102820.ou4wpm56ed6m3ewr@linutronix.de>
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
In-Reply-To: <20171006102820.ou4wpm56ed6m3ewr@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2017-10-06 at 12:28 +0200, Sebastian Andrzej Siewior wrote:
> On 2017-10-06 04:20:31 [+0200], Mike Galbraith wrote:
> > On Thu, 2017-10-05 at 17:54 +0200, Sebastian Andrzej Siewior wrote:
> > > On 2017-10-04 18:07:59 [+0200], Mike Galbraith wrote:
> > > > Seems combo-patch induced some ltp posix conformance test grumbling.
> > > > 
> > > > +clock_settime_8_1 ... ... FAILED 
> > > > +clock_settime_4_2 ... ... FAILED 
> > > > +clock_settime_speculative_4_3 ... ... FAILED 
> > > > +timer_settime_5_2 ... ... FAILED 
> > > > +timer_settime_5_1 ... ... FAILED 
> > > > +timer_settime_5_3 ... ... FAILED 
> > > > 
> > > > rtbox:/root # /usr/local/ltp/conformance/interfaces/clock_settime/clock_settime_8-1.run-test
> > > > Ended too late.  1507131910 >> 1507131908
> > > > Test FAILED
> > > > rtbox:/root # /usr/local/ltp/conformance/interfaces/clock_settime/clock_settime_4-2.run-test
> > > > timer should have expired _immediately_
> > > > rtbox:/root # /usr/local/ltp/conformance/interfaces/clock_settime/speculative/clock_settime_speculative_4-3.run-test
> > > > Overrun count =0, not # of repeating timer expirys
> > > > FAIL:  Caught 0 signals, not 1
> > > > Test FAILED
> > > > rtbox:/root # /opt/ltp/conformance/interfaces/timer_settime/timer_settime_5-2.run-test
> > > > signal was not sent
> > > 
> > > So the last triggers here, too and I have an idea.
> > 
> > I ran a trace of clock_settime_4-2.run-test, which arms a timer for
> > now+9 seconds, then clock_settime to advance 4 seconds past timer
> > expiration, which should cause the timer to fire.  Going through
> > SyS_clock_settime..retrigger_next_event..lapic_next_deadline does not
> > trigger interrupt, but does without the culprit patch applied.
> 
> This seems to fix this.

Yup, with this, when we get to clockevents_program_event(), we take the
proper if (delta <= 0) path again, and are rewarded with an interrupt.

I'll run full ltp again, make sure there are no new failure deltas.

> Subject: hrtimer: Update offset for soft bases
> From: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Date: Fri, 06 Oct 2017 11:28:38 +0200
> 
> The offset of the clock bases is done via timekeeping mechanisms. The
> offsets of the soft bases has to be considered as well.
> 
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> ---
>  kernel/time/hrtimer.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -551,8 +551,14 @@ static inline ktime_t hrtimer_update_bas
>  	ktime_t *offs_boot = &base->clock_base[HRTIMER_BASE_BOOTTIME].offset;
>  	ktime_t *offs_tai = &base->clock_base[HRTIMER_BASE_TAI].offset;
>  
> -	return ktime_get_update_offsets_now(&base->clock_was_set_seq,
> +	ktime_t now = ktime_get_update_offsets_now(&base->clock_was_set_seq,
>  					    offs_real, offs_boot, offs_tai);
> +
> +	base->clock_base[HRTIMER_BASE_REALTIME_SOFT].offset = *offs_real;
> +	base->clock_base[HRTIMER_BASE_BOOTTIME_SOFT].offset = *offs_boot;
> +	base->clock_base[HRTIMER_BASE_TAI_SOFT].offset = *offs_tai;
> +
> +	return now;
>  }
>  
>  /*
> 
> Sebastian
