From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.11.12-rt13
Date: Fri, 06 Oct 2017 04:20:31 +0200
Message-ID: <1507256431.6597.16.camel@gmx.de>
References: <20170905145244.jro4jywfxugmn7eh@linutronix.de>
         <1507133279.6934.66.camel@gmx.de>
         <20171005155441.72mjaac5c42rjilf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171005155441.72mjaac5c42rjilf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2017-10-05 at 17:54 +0200, Sebastian Andrzej Siewior wrote:
> On 2017-10-04 18:07:59 [+0200], Mike Galbraith wrote:
> > Seems combo-patch induced some ltp posix conformance test grumbling.
> > 
> > +clock_settime_8_1 ... ... FAILED 
> > +clock_settime_4_2 ... ... FAILED 
> > +clock_settime_speculative_4_3 ... ... FAILED 
> > +timer_settime_5_2 ... ... FAILED 
> > +timer_settime_5_1 ... ... FAILED 
> > +timer_settime_5_3 ... ... FAILED 
> > 
> > rtbox:/root # /usr/local/ltp/conformance/interfaces/clock_settime/clock_settime_8-1.run-test
> > Ended too late.  1507131910 >> 1507131908
> > Test FAILED
> > rtbox:/root # /usr/local/ltp/conformance/interfaces/clock_settime/clock_settime_4-2.run-test
> > timer should have expired _immediately_
> > rtbox:/root # /usr/local/ltp/conformance/interfaces/clock_settime/speculative/clock_settime_speculative_4-3.run-test
> > Overrun count =0, not # of repeating timer expirys
> > FAIL:  Caught 0 signals, not 1
> > Test FAILED
> > rtbox:/root # /opt/ltp/conformance/interfaces/timer_settime/timer_settime_5-2.run-test
> > signal was not sent
> 
> So the last triggers here, too and I have an idea.

I ran a trace of clock_settime_4-2.run-test, which arms a timer for
now+9 seconds, then clock_settime to advance 4 seconds past timer
expiration, which should cause the timer to fire.  Going through
SyS_clock_settime..retrigger_next_event..lapic_next_deadline does not
trigger interrupt, but does without the culprit patch applied.

 clock_settime_4-6453  [003] .......   384.288883: SyS_clock_settime <-entry_SYSCALL_64_fastpath
 clock_settime_4-6453  [003] .......   384.288883: __might_fault <-SyS_clock_settime
 clock_settime_4-6453  [003] .......   384.288883: __might_sleep <-__might_fault
 clock_settime_4-6453  [003] .......   384.288883: ___might_sleep <-__might_fault
 clock_settime_4-6453  [003] .......   384.288883: _copy_from_user <-SyS_clock_settime
 clock_settime_4-6453  [003] .......   384.288884: __might_fault <-_copy_from_user
 clock_settime_4-6453  [003] .......   384.288884: __might_sleep <-__might_fault
 clock_settime_4-6453  [003] .......   384.288884: ___might_sleep <-__might_fault
 clock_settime_4-6453  [003] .......   384.288884: posix_clock_realtime_set <-SyS_clock_settime
 clock_settime_4-6453  [003] .......   384.288884: do_sys_settimeofday64 <-posix_clock_realtime_set
 clock_settime_4-6453  [003] .......   384.288884: security_settime64 <-do_sys_settimeofday64
 clock_settime_4-6453  [003] .......   384.288884: cap_settime <-security_settime64
 clock_settime_4-6453  [003] .......   384.288885: capable <-cap_settime
 clock_settime_4-6453  [003] .......   384.288885: ns_capable_common <-cap_settime
 clock_settime_4-6453  [003] .......   384.288885: security_capable <-ns_capable_common
 clock_settime_4-6453  [003] .......   384.288885: cap_capable <-security_capable
 clock_settime_4-6453  [003] .......   384.288885: apparmor_capable <-security_capable
 clock_settime_4-6453  [003] .......   384.288885: do_settimeofday64 <-do_sys_settimeofday64
 clock_settime_4-6453  [003] .......   384.288886: _raw_spin_lock_irqsave <-do_settimeofday64
 clock_settime_4-6453  [003] d......   384.288886: preempt_count_add <-_raw_spin_lock_irqsave
 clock_settime_4-6453  [003] d...1..   384.288886: preempt_count_add <-do_settimeofday64
 clock_settime_4-6453  [003] d...2..   384.288886: timekeeping_forward_now.constprop.12 <-do_settimeofday64
 clock_settime_4-6453  [003] d...2..   384.288886: set_normalized_timespec <-do_settimeofday64
 clock_settime_4-6453  [003] d...2..   384.288886: tk_set_wall_to_mono <-do_settimeofday64
 clock_settime_4-6453  [003] d...2..   384.288886: set_normalized_timespec <-tk_set_wall_to_mono
 clock_settime_4-6453  [003] d...2..   384.288886: set_normalized_timespec <-tk_set_wall_to_mono
 clock_settime_4-6453  [003] d...2..   384.288886: timekeeping_update <-do_settimeofday64
 clock_settime_4-6453  [003] d...2..   384.288887: ntp_clear <-timekeeping_update
 clock_settime_4-6453  [003] d...2..   384.288887: ntp_update_frequency <-ntp_clear
 clock_settime_4-6453  [003] d...2..   384.288887: ntp_get_next_leap <-timekeeping_update
 clock_settime_4-6453  [003] d...2..   384.288887: update_vsyscall <-timekeeping_update
 clock_settime_4-6453  [003] d...2..   384.288887: raw_notifier_call_chain <-timekeeping_update
 clock_settime_4-6453  [003] d...2..   384.288887: notifier_call_chain <-timekeeping_update
 clock_settime_4-6453  [003] d...2..   384.288887: pvclock_gtod_notify <-notifier_call_chain
 clock_settime_4-6453  [003] d...2..   384.288888: preempt_count_add <-pvclock_gtod_notify
 clock_settime_4-6453  [003] d...3..   384.288888: preempt_count_sub <-pvclock_gtod_notify
 clock_settime_4-6453  [003] d...2..   384.288888: update_fast_timekeeper <-timekeeping_update
 clock_settime_4-6453  [003] d...2..   384.288888: update_fast_timekeeper <-timekeeping_update
 clock_settime_4-6453  [003] d...2..   384.288888: preempt_count_sub <-do_settimeofday64
 clock_settime_4-6453  [003] d...1..   384.288888: _raw_spin_unlock_irqrestore <-do_settimeofday64
 clock_settime_4-6453  [003] ....1..   384.288888: preempt_count_sub <-_raw_spin_unlock_irqrestore
 clock_settime_4-6453  [003] .......   384.288888: clock_was_set <-do_settimeofday64
 clock_settime_4-6453  [003] .......   384.288888: on_each_cpu <-clock_was_set
 clock_settime_4-6453  [003] .......   384.288889: preempt_count_add <-on_each_cpu
 clock_settime_4-6453  [003] ....1..   384.288889: smp_call_function <-on_each_cpu
 clock_settime_4-6453  [003] ....1..   384.288889: preempt_count_add <-smp_call_function
 clock_settime_4-6453  [003] ....2..   384.288889: smp_call_function_many <-smp_call_function
 clock_settime_4-6453  [003] ....2..   384.288890: native_send_call_func_ipi <-smp_call_function_many
 clock_settime_4-6453  [003] ....2..   384.288890: x2apic_send_IPI_allbutself <-native_send_call_func_ipi
 clock_settime_4-6453  [003] ....2..   384.288890: __x2apic_send_IPI_mask <-native_send_call_func_ipi
 clock_settime_4-6453  [003] ....2..   384.288914: preempt_count_sub <-smp_call_function
 clock_settime_4-6453  [003] d...1..   384.288914: retrigger_next_event <-on_each_cpu
 clock_settime_4-6453  [003] d...1..   384.288915: _raw_spin_lock <-retrigger_next_event
 clock_settime_4-6453  [003] d...1..   384.288915: preempt_count_add <-_raw_spin_lock
 clock_settime_4-6453  [003] d...2..   384.288915: ktime_get_update_offsets_now <-retrigger_next_event
 clock_settime_4-6453  [003] d...2..   384.288915: __hrtimer_get_next_event <-retrigger_next_event
 clock_settime_4-6453  [003] d...2..   384.288915: __hrtimer_next_event_base <-__hrtimer_get_next_event
 clock_settime_4-6453  [003] d...2..   384.288915: __hrtimer_next_event_base <-retrigger_next_event
 clock_settime_4-6453  [003] d...2..   384.288915: tick_program_event <-retrigger_next_event
 clock_settime_4-6453  [003] d...2..   384.288915: clockevents_program_event <-retrigger_next_event
 clock_settime_4-6453  [003] d...2..   384.288915: ktime_get <-clockevents_program_event
 clock_settime_4-6453  [003] d...2..   384.288916: lapic_next_deadline <-clockevents_program_event
 clock_settime_4-6453  [003] d...2..   384.288916: preempt_count_sub <-retrigger_next_event
