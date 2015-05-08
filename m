From: Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH] arch/arm64 :Cyclic Test fix in ARM64 fpsimd
Date: Fri, 8 May 2015 02:09:29 +0200
Message-ID: <20150508000929.GE31914@8074w.roxell.se>
References: <CAPyr0yJSGqvxkUWLtNKe0q5mNanBczAfAVx0tPKuzYeDG+eJ=Q@mail.gmail.com>
 <20150506193803.GC32577@8074w.roxell.se>
 <CAPyr0y+OYikc2Euh++2nTWnVb-aZ4i-tifLLk3XUiRahtHKjCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-arm-kernel@lists.infradead.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	Kevin Hilman <kevin.hilman@linaro.org>
To: Ayyappa Ch <ayyappa.ch.linux@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:34519 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbbEHAJe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 May 2015 20:09:34 -0400
Received: by laat2 with SMTP id t2so42111680laa.1
        for <linux-rt-users@vger.kernel.org>; Thu, 07 May 2015 17:09:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPyr0y+OYikc2Euh++2nTWnVb-aZ4i-tifLLk3XUiRahtHKjCA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2015-05-07 16:39, Ayyappa Ch wrote:
> ./cyclictest -p 80 -t5 -n  => Cyclic test is failing after 6Lack iterations
> T: 0 ( 1364) P:99 I:1000 C: 668664 Min:      3 Act:    5 Avg:   11 Max:  100116
> 
> After analyzing the trace log , we observed the sudden change in
> latency due to calling of fpsimd_preserve_current_state function.

I'm still unable to reproduce your problem scenario and from the log
snippet below I'm not convinced that fpsimd_preserve_current_state is
the bad guy.

> 
> Line 149766:     ntpd-925     1....1.. 512046976us :
> fpsimd_preserve_current_state <-do_signal
> Line 149768:     ntpd-925     1....1.. 512046977us : preempt_count_add
> <-fpsimd_preserve_current_state
> Line 149770:     ntpd-925     1....2.. 512046978us : preempt_count_sub
> <-fpsimd_preserve_current_state

fpsimd_preserve_current_state seams to return within 2us

> 
> .......
> Line 163170: cyclicte-964     0.....11 512065181us :

The latency appears to be happening somewhere between the
fpsimd_preserve_current_state return and the resumption of the cyclictest.
Whatever cased the latency may have happened in the omitted portion of
the trace log?
It may not even have been traceable thread of execution, depending on
the trace tool that have been used.
If the part of the trace log that you didn't show doesn't seam to have
any interesting events then maybe the offending code runs outside of
scheduler control or never touches any defined trace points.

Cheers,
Anders

> tracing_mark_write: hit latency threshold (98383 > 500)
> 
> 
> Thanks and regards,
> Ayyappa.Ch
> 
> ...
> 
> On Thu, May 7, 2015 at 1:08 AM, Anders Roxell <anders.roxell@linaro.org> wrote:
> > On 2015-05-01 20:59, Ayyappa Ch wrote:
> >> Floating point operations in arm64 should not disable preempt .
> >
> > I thought that I would see a problem if I ran a floating point
> > workload and cyclictest at the same time but I don't.
> >
> > Can you please provide me some more details on how I can reproduce the
> > problem?
> >
> > Cheers,
> > Anders
> >
> >> Activating realtime features with below code.
> >>
> >> From e6a5fce9b3b55f48656240036a9354a0997c2907 Mon Sep 17 00:00:00 2001
> >> From: Ayyappa Ch <ayyappa.chandolu@amd.com>
> >> Date: Tue, 28 Apr 2015 11:53:00 +0530
> >> Subject: [PATCH ] floating point realtime fix
> >>
> >> ---
> >>  arch/arm64/kernel/fpsimd.c | 16 ++++++++--------
> >>  1 file changed, 8 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> >> index 2438497..3dca156 100644
> >> --- a/arch/arm64/kernel/fpsimd.c
> >> +++ b/arch/arm64/kernel/fpsimd.c
> >> @@ -166,10 +166,10 @@ void fpsimd_flush_thread(void)
> >>   */
> >>  void fpsimd_preserve_current_state(void)
> >>  {
> >> - preempt_disable();
> >> + migrate_disable();
> >>   if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
> >>   fpsimd_save_state(&current->thread.fpsimd_state);
> >> - preempt_enable();
> >> + migrate_enable();
> >>  }
> >>
> >>  /*
> >> @@ -179,7 +179,7 @@ void fpsimd_preserve_current_state(void)
> >>   */
> >>  void fpsimd_restore_current_state(void)
> >>  {
> >> - preempt_disable();
> >> + migrate_disable();
> >>   if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
> >>   struct fpsimd_state *st = &current->thread.fpsimd_state;
> >>
> >> @@ -187,7 +187,7 @@ void fpsimd_restore_current_state(void)
> >>   this_cpu_write(fpsimd_last_state, st);
> >>   st->cpu = smp_processor_id();
> >>   }
> >> - preempt_enable();
> >> + migrate_enable();
> >>  }
> >>
> >>  /*
> >> @@ -197,7 +197,7 @@ void fpsimd_restore_current_state(void)
> >>   */
> >>  void fpsimd_update_current_state(struct fpsimd_state *state)
> >>  {
> >> - preempt_disable();
> >> + migrate_disable();
> >>   fpsimd_load_state(state);
> >>   if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
> >>   struct fpsimd_state *st = &current->thread.fpsimd_state;
> >> @@ -205,7 +205,7 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
> >>   this_cpu_write(fpsimd_last_state, st);
> >>   st->cpu = smp_processor_id();
> >>   }
> >> - preempt_enable();
> >> + migrate_enable();
> >>  }
> >>
> >>  /*
> >> @@ -239,7 +239,7 @@ void kernel_neon_begin_partial(u32 num_regs)
> >>   * that there is no longer userland FPSIMD state in the
> >>   * registers.
> >>   */
> >> - preempt_disable();
> >> + migrate_disable();
> >>   if (current->mm &&
> >>      !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
> >>   fpsimd_save_state(&current->thread.fpsimd_state);
> >> @@ -255,7 +255,7 @@ void kernel_neon_end(void)
> >>   in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
> >>   fpsimd_load_partial_state(s);
> >>   } else {
> >> - preempt_enable();
> >> + migrate_enable();
> >>   }
> >>  }
> >>  EXPORT_SYMBOL(kernel_neon_end);
> >>
> >> On Fri, May 1, 2015 at 1:03 PM, Ayyappa Ch <ayyappa.ch.linux@gmail.com> wrote:
> >> > Following Anders Roxell  patch on "Enable PREEMPT_RT_FULL" , observed
> >> > one issue with Cyclic test while running floating point operations. So
> >> > , modified below changes for that.
> >> >
> >> > From e6a5fce9b3b55f48656240036a9354a0997c2907 Mon Sep 17 00:00:00 2001
> >> > From: Ayyappa Ch <ayyappa.chandolu@amd.com>
> >> > Date: Tue, 28 Apr 2015 11:53:00 +0530
> >> > Subject: [PATCH ] floating point realtime fix
> >> >
> >> > ---
> >> >  arch/arm64/kernel/fpsimd.c | 16 ++++++++--------
> >> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >> >
> >> > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> >> > index 2438497..3dca156 100644
> >> > --- a/arch/arm64/kernel/fpsimd.c
> >> > +++ b/arch/arm64/kernel/fpsimd.c
> >> > @@ -166,10 +166,10 @@ void fpsimd_flush_thread(void)
> >> >   */
> >> >  void fpsimd_preserve_current_state(void)
> >> >  {
> >> > - preempt_disable();
> >> > + migrate_disable();
> >> >   if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
> >> >   fpsimd_save_state(&current->thread.fpsimd_state);
> >> > - preempt_enable();
> >> > + migrate_enable();
> >> >  }
> >> >
> >> >  /*
> >> > @@ -179,7 +179,7 @@ void fpsimd_preserve_current_state(void)
> >> >   */
> >> >  void fpsimd_restore_current_state(void)
> >> >  {
> >> > - preempt_disable();
> >> > + migrate_disable();
> >> >   if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
> >> >   struct fpsimd_state *st = &current->thread.fpsimd_state;
> >> >
> >> > @@ -187,7 +187,7 @@ void fpsimd_restore_current_state(void)
> >> >   this_cpu_write(fpsimd_last_state, st);
> >> >   st->cpu = smp_processor_id();
> >> >   }
> >> > - preempt_enable();
> >> > + migrate_enable();
> >> >  }
> >> >
> >> >  /*
> >> > @@ -197,7 +197,7 @@ void fpsimd_restore_current_state(void)
> >> >   */
> >> >  void fpsimd_update_current_state(struct fpsimd_state *state)
> >> >  {
> >> > - preempt_disable();
> >> > + migrate_disable();
> >> >   fpsimd_load_state(state);
> >> >   if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
> >> >   struct fpsimd_state *st = &current->thread.fpsimd_state;
> >> > @@ -205,7 +205,7 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
> >> >   this_cpu_write(fpsimd_last_state, st);
> >> >   st->cpu = smp_processor_id();
> >> >   }
> >> > - preempt_enable();
> >> > + migrate_enable();
> >> >  }
> >> >
> >> >  /*
> >> > @@ -239,7 +239,7 @@ void kernel_neon_begin_partial(u32 num_regs)
> >> >   * that there is no longer userland FPSIMD state in the
> >> >   * registers.
> >> >   */
> >> > - preempt_disable();
> >> > + migrate_disable();
> >> >   if (current->mm &&
> >> >      !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
> >> >   fpsimd_save_state(&current->thread.fpsimd_state);
> >> > @@ -255,7 +255,7 @@ void kernel_neon_end(void)
> >> >   in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
> >> >   fpsimd_load_partial_state(s);
> >> >   } else {
> >> > - preempt_enable();
> >> > + migrate_enable();
> >> >   }
> >> >  }
> >> >  EXPORT_SYMBOL(kernel_neon_end);
> >> > --
> >> > 1.9.1

-- 
Anders Roxell
anders.roxell@linaro.org
M: +46 709 71 42 85 | IRC: roxell
