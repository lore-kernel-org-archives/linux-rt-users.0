From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: [PATCH RT 1/2 v2] x86: Do not disable preemption in int3 on
 32bit
Date: Thu, 26 Jan 2012 17:39:02 +0900
Message-ID: <4F211126.1090204@hitachi.com>
References: <20120125143231.196670014@goodmis.org> <20120125143520.086175333@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander van Heukelum <heukelum@fastmail.fm>,
	Andi Kleen <ak@linux.intel.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120125143520.086175333@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

(2012/01/25 23:32), Steven Rostedt wrote:
> Preemption must be disabled before enabling interrupts in do_trap
> on x86_64 because the stack in use for int3 and debug is a per CPU
> stack set by th IST. But in 32bit, the stack still belongs to the
> current task and there is no problem in scheduling out the task.
> 
> Keep preemption enabled on X86_32 when enabling interrupts for
> do_trap().
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Hmm, I think you'd better change caller side, because the
function itself has "preempt" in its name. I think it can
easily mislead other people.

Thank you,

> 
> Index: linux-rt.git/arch/x86/kernel/traps.c
> ===================================================================
> --- linux-rt.git.orig/arch/x86/kernel/traps.c
> +++ linux-rt.git/arch/x86/kernel/traps.c
> @@ -89,7 +89,14 @@ static inline void conditional_sti(struc
>  
>  static inline void preempt_conditional_sti(struct pt_regs *regs)
>  {
> +#ifdef CONFIG_X86_64
> +	/*
> +	 * X86_64 uses a per CPU stack for certain traps like int3.
> +	 * We must disable preemption, otherwise we can corrupt the
> +	 * stack if the task is scheduled out with this stack.
> +	 */
>  	inc_preempt_count();
> +#endif
>  	if (regs->flags & X86_EFLAGS_IF)
>  		local_irq_enable();
>  }
> @@ -104,7 +111,9 @@ static inline void preempt_conditional_c
>  {
>  	if (regs->flags & X86_EFLAGS_IF)
>  		local_irq_disable();
> +#ifdef CONFIG_X86_64
>  	dec_preempt_count();
> +#endif
>  }
>  
>  static void __kprobes
> 

-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
