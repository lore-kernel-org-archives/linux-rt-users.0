From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 1/2] x86/kconfig: Fall back to ticket spinlocks
Date: Tue, 30 Oct 2018 00:12:45 +0100
Message-ID: <20181029231244.xfj42ucddp7xnoae@linutronix.de>
References: <20181029201617.24733-1-wagi@monom.org>
 <20181029201617.24733-2-wagi@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>,
        Peter Zijlstra <peterz@infradead.org>
To: Daniel Wagner <wagi@monom.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181029201617.24733-2-wagi@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-10-29 21:16:16 [+0100], Daniel Wagner wrote:
> From: Daniel Wagner <daniel.wagner@siemens.com>
> 
> v4.4.162-rt176-rc1 stable review patch.
> If anyone has any objections, please let me know.

I though that we are going to route this via Greg/stable for v4.4?

> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -42,7 +42,6 @@ config X86
>  	select ARCH_USE_BUILTIN_BSWAP
>  	select ARCH_USE_CMPXCHG_LOCKREF		if X86_64
>  	select ARCH_USE_QUEUED_RWLOCKS
> -	select ARCH_USE_QUEUED_SPINLOCKS
>  	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>  	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
>  	select ARCH_WANT_FRAME_POINTERS
> -- 
> 2.14.4
