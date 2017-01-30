From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip:x86/mm] x86/mm/cpa: Avoid wbinvd() for PREEMPT
Date: Mon, 30 Jan 2017 17:13:54 +0100
Message-ID: <20170130161354.GB3647@gmail.com>
References: <tip-459fbe00693449fade2d1bc802791b081c94edcf@git.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-tip-commits@vger.kernel.org
To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, john.ogness@linutronix.de,
        peterz@infradead.org, bigeasy@linutronix.de, hpa@zytor.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <tip-459fbe00693449fade2d1bc802791b081c94edcf@git.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* tip-bot for John Ogness <tipbot@zytor.com> wrote:

> Commit-ID:  459fbe00693449fade2d1bc802791b081c94edcf
> Gitweb:     http://git.kernel.org/tip/459fbe00693449fade2d1bc802791b081c94edcf
> Author:     John Ogness <john.ogness@linutronix.de>
> AuthorDate: Mon, 30 Jan 2017 09:41:21 +0100
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Mon, 30 Jan 2017 15:33:52 +0100
> 
> x86/mm/cpa: Avoid wbinvd() for PREEMPT
> 
> Although wbinvd() is faster than flushing many individual pages, it blocks
> the memory bus for "long" periods of time (>100us), thus directly causing
> unusually large latencies on all CPUs, regardless of any CPU isolation
> features that may be active. This is an unpriviledged operatation as it is
> exposed to user space via the graphics subsystem.

s/unpriviledged
 /unprivileged

> 
> For 1024 pages, flushing those pages individually can take up to 2200us,
> but the task remains fully preemptible during that time.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Sebastian Siewior <bigeasy@linutronix.de>
> Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  arch/x86/mm/pageattr.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> index 5a287e5..28d4213 100644
> --- a/arch/x86/mm/pageattr.c
> +++ b/arch/x86/mm/pageattr.c
> @@ -214,7 +214,20 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
>  			    int in_flags, struct page **pages)
>  {
>  	unsigned int i, level;
> +#ifdef CONFIG_PREEMPT
> +	/*
> +	 * Avoid wbinvd() because it causes latencies on all CPUs,
> +	 * regardless of any CPU isolation that may be in effect.
> +	 *
> +	 * This should be extended for CAT enabled systems independent of
> +	 * PREEMPT because wbinvd() does not respect the CAT partitions and
> +	 * this is exposed to unpriviledged users through the graphics
> +	 * subsystem.

s/unpriviledged
 /unprivileged

> +#else
>  	unsigned long do_wbinvd = cache && numpages >= 1024; /* 4M threshold */
> +#endif

... and while at it:

  s/4M/4MB?

Thanks,

	Ingo
