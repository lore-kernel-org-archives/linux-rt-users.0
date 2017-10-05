From: Julia Cartwright <julia@ni.com>
Subject: Re: [PATCH rt-v4.11] sched/clock: fix early boot splat on clock
 transition to unstable
Date: Thu, 5 Oct 2017 09:59:14 -0500
Message-ID: <20171005145914.GF21185@jcartwri.amer.corp.natinst.com>
References: <1507003039-16583-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <bigeasy@linutronix.de>, <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:54142 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750965AbdJEO7U (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Oct 2017 10:59:20 -0400
Content-Disposition: inline
In-Reply-To: <1507003039-16583-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Oct 02, 2017 at 11:57:19PM -0400, Paul Gortmaker wrote:
> On an older machine with a Pentium(R) Dual-Core E5300 I see the
> the following early (see time stamps) boot splat on clock transition
> due to TSC unstable (indicated in the last line):
> 
>   [  2.487904] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
>   [  2.487909] caller is debug_smp_processor_id+0x17/0x20
>   [  2.487911] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.12-rt14-00451
>   [  2.487911] Hardware name: Dell Inc. OptiPlex 760                 /0M858N, BIOS A16 08/06/2013
>   [  2.487912] Call Trace:
>   [  2.487918]  dump_stack+0x4f/0x6a
>   [  2.487919]  check_preemption_disabled+0xda/0xe0
>   [  2.487921]  debug_smp_processor_id+0x17/0x20
>   [  2.487924]  clear_sched_clock_stable+0x28/0x80
>   [  2.487927]  mark_tsc_unstable+0x22/0x70
>   [  2.487930]  acpi_processor_get_power_info+0x3e3/0x6a0
>   [  2.487932]  acpi_processor_power_init+0x3a/0x1d0
>   [  2.487933]  __acpi_processor_start+0x162/0x1b0
>                ....
>   [  2.487950]  acpi_processor_driver_init+0x20/0x96
>   [  2.487951]  do_one_initcall+0x3f/0x170
>   [  2.487954]  kernel_init_freeable+0x18e/0x216
>   [  2.487955]  ? rest_init+0xd0/0xd0
>   [  2.487956]  kernel_init+0x9/0x100
>   [  2.487958]  ret_from_fork+0x22/0x30
>   [  2.487960] sched_clock: Marking unstable (2488005383, -223143)<-(2590866395, -103084155)
>   [  2.488004] tsc: Marking TSC unstable due to TSC halts in idle
> 
> (gdb) list *clear_sched_clock_stable+0x28
> 0xffffffff8108bbb8 is in clear_sched_clock_stable (kernel/sched/clock.c:114).
> 
> [...]
> 
> 112     static inline struct sched_clock_data *this_scd(void)
> 113     {
> 114             return this_cpu_ptr(&sched_clock_data);
> 115     }
> 
> We now get this_scd with preemption disabled.  I also decided to pass
> in the scd to __clear_sched_clock_stable in the hope it made it more
> clear that the caller (currently only one) needs to get this_scd with
> preemption disabled, even though that wasn't strictly required.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> index 11ad4bd995e2..32dcda23c616 100644
> --- a/kernel/sched/clock.c
> +++ b/kernel/sched/clock.c
> @@ -155,9 +155,8 @@ static void __sched_clock_work(struct work_struct *work)
>  
>  static DECLARE_WORK(sched_clock_work, __sched_clock_work);
>  
> -static void __clear_sched_clock_stable(void)
> +static void __clear_sched_clock_stable(struct sched_clock_data *scd)
>  {
> -	struct sched_clock_data *scd = this_scd();
>  
>  	/*
>  	 * Attempt to make the stable->unstable transition continuous.
> @@ -186,8 +185,14 @@ void clear_sched_clock_stable(void)
>  
>  	smp_mb(); /* matches sched_clock_init_late() */
>  
> -	if (sched_clock_running == 2)
> -		__clear_sched_clock_stable();
> +	if (sched_clock_running == 2) {
> +		struct sched_clock_data *scd;
> +
> +		preempt_disable();
> +		scd = this_scd();
> +		preempt_enable();

It would seem to me that this doesn't move it out far enough.

Should it not be the callers responsibility to ensure that we're in a
non-migratable context?  Otherwise it's possible that we end up
adjusting the percpu sched_clock_data for a CPU other than what was
intended (because we could be migrated between
clear_sched_clock_stable() entry and this preempt_disable()).  Maybe
this is not a problem, I don't know.

It does make we wonder whether or not we should reduce the this_cpu_*
access preemption checks to migration-disabled checks.  Or,
alternatively, go the route of get_cpu()/get_cpu_light() and add new
accessors with the reduced check.

   Julia
