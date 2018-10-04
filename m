From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 1/2] x86/kconfig: Use ticket spinlocks for -rt
Date: Thu, 4 Oct 2018 16:08:46 +0200
Message-ID: <20181004140846.uerpx7txvx7pj6yc@linutronix.de>
References: <20181004134622.23181-1-daniel.wagner@siemens.com>
 <20181004134622.23181-2-daniel.wagner@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>,
        Peter Zijlstra <peterz@infradead.org>
To: Daniel Wagner <daniel.wagner@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181004134622.23181-2-daniel.wagner@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-10-04 15:46:21 [+0200], Daniel Wagner wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 6df130a37d41..21f9418d850f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -42,7 +42,7 @@ config X86
>  	select ARCH_USE_BUILTIN_BSWAP
>  	select ARCH_USE_CMPXCHG_LOCKREF		if X86_64
>  	select ARCH_USE_QUEUED_RWLOCKS
> -	select ARCH_USE_QUEUED_SPINLOCKS
> +	select ARCH_USE_QUEUED_SPINLOCKS	if !PREEMPT_RT_FULL
>  	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>  	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
>  	select ARCH_WANT_FRAME_POINTERS

I would argue, that RT exposes a problem and we should not limit it to
RT only. Anyone?

Sebastian
