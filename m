From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] x86/mm/pat: disable preemption __split_large_page()
 after spin_lock()
Date: Thu, 13 Dec 2018 12:59:07 -0500
Message-ID: <20181213125907.48e75b89@gandalf.local.home>
References: <20181213164430.mggilzfjgr5retz6@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, stable-rt@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213164430.mggilzfjgr5retz6@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 13 Dec 2018 17:44:31 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Commit "x86/mm/pat: Disable preemption around __flush_tlb_all()" added a
> warning if __flush_tlb_all() is invoked in preemptible context. On !RT
> the warning does not trigger because a spin lock is acquired which
> disables preemption. On RT the spin lock does not disable preemption and
> so the warning is seen.
> 
> Disable preemption to avoid the warning in __flush_tlb_all().

I'm guessing the reason for the warn on is that we don't want a task to
be scheduled in where we expected the TLB to have been flushed.


> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/mm/pageattr.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> index e2d4b25c7aa44..abbe3e93ec266 100644
> --- a/arch/x86/mm/pageattr.c
> +++ b/arch/x86/mm/pageattr.c
> @@ -687,6 +687,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
>  	pgprot_t ref_prot;
>  
>  	spin_lock(&pgd_lock);

We probably should have comment explaining why we have a
preempt_disable here.

> +	preempt_disable();
>  	/*
>  	 * Check for races, another CPU might have split this page
>  	 * up for us already:
> @@ -694,6 +695,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
>  	tmp = _lookup_address_cpa(cpa, address, &level);
>  	if (tmp != kpte) {
>  		spin_unlock(&pgd_lock);
> +		preempt_enable();

Shouldn't the preempt_enable() be before the unlock?

>  		return 1;
>  	}
>  
> @@ -727,6 +729,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
>  
>  	default:
>  		spin_unlock(&pgd_lock);
> +		preempt_enable();

Here too.

-- Steve

>  		return 1;
>  	}
>  
> @@ -764,6 +767,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
>  	 * going on.
>  	 */
>  	__flush_tlb_all();
> +	preempt_enable();
>  	spin_unlock(&pgd_lock);
>  
>  	return 0;
