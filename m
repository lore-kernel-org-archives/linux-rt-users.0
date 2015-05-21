From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arch/arm64 :Cyclic Test fix in ARM64 fpsimd
Date: Thu, 21 May 2015 17:23:43 +0200
Message-ID: <CAKv+Gu_u+iYL4niHip9nzUd9p7tEt6XEvhZ4fQLJK_gVaw+FSA@mail.gmail.com>
References: <CAPyr0yJSGqvxkUWLtNKe0q5mNanBczAfAVx0tPKuzYeDG+eJ=Q@mail.gmail.com>
	<20150521135007.GC3983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ayyappa Ch <ayyappa.ch.linux@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	Kevin Hilman <kevin.hilman@linaro.org>, arnd@linaro.org
To: Anders Roxell <anders.roxell@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35439 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385AbbEUPXo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 May 2015 11:23:44 -0400
Received: by igbyr2 with SMTP id yr2so12701734igb.0
        for <linux-rt-users@vger.kernel.org>; Thu, 21 May 2015 08:23:44 -0700 (PDT)
In-Reply-To: <20150521135007.GC3983@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 21 May 2015 at 15:50, Anders Roxell <anders.roxell@gmail.com> wrote:
> On 2015-05-01 20:59, Ayyappa Ch wrote:
>> Floating point operations in arm64 should not disable preempt .
>> Activating realtime features with below code.
>
> I've talked with an engineer who worked on fpsimd and I was told that
> replacing preempt_disable with migrate_disable would leave fpsimd open
> to corruption.
>
> The kernel won't save the state of the simd registers when it is
> preempted so if another task runs on the same CPU and also uses simd, it
> clobbers the registers of the first task, and migrate_disable() does not
> prevent that.
>
> If we want to use SIMD with preemption enabled, we need to update the
> context switch code to do a full SIMD register state save&restore if
> necessary. However, this can have a noticeable cost in all task switch
> latencies.
>

I noticed somewhere in this thread that the culprit was ultimately a
call to virt_efi_set_time(), which is the UEFI Runtime Service that
programs the RTC. If this is a hot spot, then there is something very
wrong with the system which is entirely unrelated to preempt_rt.

But let's assume this is a valid UEFI Runtime Services call: since
UEFI Runtime Services are allowed to use the FP/SIMD register file, we
need the kernel_neon_begin()/kernel_neon_end() pair even though it is
highly unlikely that such a runtime service call would actually need
to use the NEON or floating point. It is simply imposed by the
kernel<->firmware ABI. Also, on this particular code path, preemption
will be disabled regardless, since the UEFI Runtime Services are
invoked with a UEFI specific TTBR0 mapping, which rules out preemption
for reasons unrelated to the FP/SIMD register file.

-- 
Ard.


>>
>> From e6a5fce9b3b55f48656240036a9354a0997c2907 Mon Sep 17 00:00:00 2001
>> From: Ayyappa Ch <ayyappa.chandolu@amd.com>
>> Date: Tue, 28 Apr 2015 11:53:00 +0530
>> Subject: [PATCH ] floating point realtime fix
>>
>> ---
>>  arch/arm64/kernel/fpsimd.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> index 2438497..3dca156 100644
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -166,10 +166,10 @@ void fpsimd_flush_thread(void)
>>   */
>>  void fpsimd_preserve_current_state(void)
>>  {
>> - preempt_disable();
>> + migrate_disable();
>>   if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
>>   fpsimd_save_state(&current->thread.fpsimd_state);
>> - preempt_enable();
>> + migrate_enable();
>>  }
>>
>>  /*
>> @@ -179,7 +179,7 @@ void fpsimd_preserve_current_state(void)
>>   */
>>  void fpsimd_restore_current_state(void)
>>  {
>> - preempt_disable();
>> + migrate_disable();
>>   if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
>>   struct fpsimd_state *st = &current->thread.fpsimd_state;
>>
>> @@ -187,7 +187,7 @@ void fpsimd_restore_current_state(void)
>>   this_cpu_write(fpsimd_last_state, st);
>>   st->cpu = smp_processor_id();
>>   }
>> - preempt_enable();
>> + migrate_enable();
>>  }
>>
>>  /*
>> @@ -197,7 +197,7 @@ void fpsimd_restore_current_state(void)
>>   */
>>  void fpsimd_update_current_state(struct fpsimd_state *state)
>>  {
>> - preempt_disable();
>> + migrate_disable();
>>   fpsimd_load_state(state);
>>   if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
>>   struct fpsimd_state *st = &current->thread.fpsimd_state;
>> @@ -205,7 +205,7 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
>>   this_cpu_write(fpsimd_last_state, st);
>>   st->cpu = smp_processor_id();
>>   }
>> - preempt_enable();
>> + migrate_enable();
>>  }
>>
>>  /*
>> @@ -239,7 +239,7 @@ void kernel_neon_begin_partial(u32 num_regs)
>>   * that there is no longer userland FPSIMD state in the
>>   * registers.
>>   */
>> - preempt_disable();
>> + migrate_disable();
>>   if (current->mm &&
>>      !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
>>   fpsimd_save_state(&current->thread.fpsimd_state);
>> @@ -255,7 +255,7 @@ void kernel_neon_end(void)
>>   in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
>>   fpsimd_load_partial_state(s);
>>   } else {
>> - preempt_enable();
>> + migrate_enable();
>>   }
>>  }
>>  EXPORT_SYMBOL(kernel_neon_end);
>>
>> On Fri, May 1, 2015 at 1:03 PM, Ayyappa Ch <ayyappa.ch.linux@gmail.com> wrote:
>> > Following Anders Roxell  patch on "Enable PREEMPT_RT_FULL" , observed
>> > one issue with Cyclic test while running floating point operations. So
>> > , modified below changes for that.
>> >
>> > From e6a5fce9b3b55f48656240036a9354a0997c2907 Mon Sep 17 00:00:00 2001
>> > From: Ayyappa Ch <ayyappa.chandolu@amd.com>
>> > Date: Tue, 28 Apr 2015 11:53:00 +0530
>> > Subject: [PATCH ] floating point realtime fix
>> >
>> > ---
>> >  arch/arm64/kernel/fpsimd.c | 16 ++++++++--------
>> >  1 file changed, 8 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> > index 2438497..3dca156 100644
>> > --- a/arch/arm64/kernel/fpsimd.c
>> > +++ b/arch/arm64/kernel/fpsimd.c
>> > @@ -166,10 +166,10 @@ void fpsimd_flush_thread(void)
>> >   */
>> >  void fpsimd_preserve_current_state(void)
>> >  {
>> > - preempt_disable();
>> > + migrate_disable();
>> >   if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
>> >   fpsimd_save_state(&current->thread.fpsimd_state);
>> > - preempt_enable();
>> > + migrate_enable();
>> >  }
>> >
>> >  /*
>> > @@ -179,7 +179,7 @@ void fpsimd_preserve_current_state(void)
>> >   */
>> >  void fpsimd_restore_current_state(void)
>> >  {
>> > - preempt_disable();
>> > + migrate_disable();
>> >   if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
>> >   struct fpsimd_state *st = &current->thread.fpsimd_state;
>> >
>> > @@ -187,7 +187,7 @@ void fpsimd_restore_current_state(void)
>> >   this_cpu_write(fpsimd_last_state, st);
>> >   st->cpu = smp_processor_id();
>> >   }
>> > - preempt_enable();
>> > + migrate_enable();
>> >  }
>> >
>> >  /*
>> > @@ -197,7 +197,7 @@ void fpsimd_restore_current_state(void)
>> >   */
>> >  void fpsimd_update_current_state(struct fpsimd_state *state)
>> >  {
>> > - preempt_disable();
>> > + migrate_disable();
>> >   fpsimd_load_state(state);
>> >   if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
>> >   struct fpsimd_state *st = &current->thread.fpsimd_state;
>> > @@ -205,7 +205,7 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
>> >   this_cpu_write(fpsimd_last_state, st);
>> >   st->cpu = smp_processor_id();
>> >   }
>> > - preempt_enable();
>> > + migrate_enable();
>> >  }
>> >
>> >  /*
>> > @@ -239,7 +239,7 @@ void kernel_neon_begin_partial(u32 num_regs)
>> >   * that there is no longer userland FPSIMD state in the
>> >   * registers.
>> >   */
>> > - preempt_disable();
>> > + migrate_disable();
>> >   if (current->mm &&
>> >      !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
>> >   fpsimd_save_state(&current->thread.fpsimd_state);
>> > @@ -255,7 +255,7 @@ void kernel_neon_end(void)
>> >   in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
>> >   fpsimd_load_partial_state(s);
>> >   } else {
>> > - preempt_enable();
>> > + migrate_enable();
>> >   }
>> >  }
>> >  EXPORT_SYMBOL(kernel_neon_end);
>> > --
>> > 1.9.1
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Anders Roxell
> 0708 22 71 05
