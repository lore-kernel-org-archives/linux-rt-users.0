From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH RT v3] arm64: fpsimd: use preemp_disable in addition to
 local_bh_disable()
Date: Fri, 27 Jul 2018 16:35:59 +0100
Message-ID: <20180727153559.GA4240@e103592.cambridge.arm.com>
References: <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <20180716151737.GO9486@e103592.cambridge.arm.com>
 <20180718091209.u76gzacanj5avhdl@linutronix.de>
 <20180724094623.37430032@gandalf.local.home>
 <20180726150634.cl3wccqur6qhle6p@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Galbraith <efault@gmx.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180726150634.cl3wccqur6qhle6p@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Jul 26, 2018 at 05:06:34PM +0200, Sebastian Andrzej Siewior wrote:
> In v4.16-RT I noticed a number of warnings from task_fpsimd_load(). The
> code disables BH and expects that it is not preemptible. On -RT the
> task remains preemptible but remains the same CPU. This may corrupt the
> content of the SIMD registers if the task is preempted during
> saving/restoring those registers.
> 
> Add preempt_disable()/enable() to enfore the required semantic on -RT.

Does this supersede the local_lock based approach?

That would have been nice to have, but if there are open questions about
how to do it then I guess something like this patch makes sense as a
stopgap solution.

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> This should work. Compiling currently gcc-6 on the box to see what
> happens. Since the crypto disables preemption "frequently" and I don't
> expect or see anything to worry about.
> 
>  arch/arm64/kernel/fpsimd.c |   30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -157,6 +157,15 @@ static void sve_free(struct task_struct
>  	__sve_free(task);
>  }
>  
> +static void *sve_free_atomic(struct task_struct *task)
> +{
> +	void *sve_state = task->thread.sve_state;
> +
> +	WARN_ON(test_tsk_thread_flag(task, TIF_SVE));
> +
> +	task->thread.sve_state = NULL;
> +	return sve_state;
> +}

This feels a bit excessive.  Since there's only one call site, I'd
prefer if the necessary code were simply inlined.  We wouldn't need the
WARN either in that case, since (IIUC) it's only there to check for
accidental misuse of this helper.

>  /* Offset of FFR in the SVE register dump */
>  static size_t sve_ffr_offset(int vl)
> @@ -594,6 +603,7 @@ int sve_set_vector_length(struct task_st
>  	 * non-SVE thread.
>  	 */
>  	if (task == current) {
> +		preempt_disable();
>  		local_bh_disable();
>  
>  		task_fpsimd_save();
> @@ -604,8 +614,10 @@ int sve_set_vector_length(struct task_st
>  	if (test_and_clear_tsk_thread_flag(task, TIF_SVE))
>  		sve_to_fpsimd(task);
>  
> -	if (task == current)
> +	if (task == current) {
>  		local_bh_enable();
> +		preempt_enable();
> +	}
>  
>  	/*
>  	 * Force reallocation of task SVE state to the correct size
> @@ -837,6 +849,7 @@ asmlinkage void do_sve_acc(unsigned int
>  
>  	sve_alloc(current);
>  
> +	preempt_disable();
>  	local_bh_disable();

I think we should have local helpers for the preempt+local_bh
maintenance, since they're needed all over the place in this
file.

[...]

Cheers
---Dave
