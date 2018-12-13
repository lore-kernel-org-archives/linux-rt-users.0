From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] x86/mm/pat: disable preemption __split_large_page()
 after spin_lock()
Date: Thu, 13 Dec 2018 19:27:13 +0100
Message-ID: <20181213182712.gmxuixlcjepr2hfg@linutronix.de>
References: <20181213164430.mggilzfjgr5retz6@linutronix.de>
 <20181213125907.48e75b89@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, stable-rt@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181213125907.48e75b89@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-12-13 12:59:07 [-0500], Steven Rostedt wrote:
> On Thu, 13 Dec 2018 17:44:31 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > Disable preemption to avoid the warning in __flush_tlb_all().
> 
> I'm guessing the reason for the warn on is that we don't want a task to
> be scheduled in where we expected the TLB to have been flushed.
during the cr3 read + write, correct.

> > --- a/arch/x86/mm/pageattr.c
> > +++ b/arch/x86/mm/pageattr.c
> > @@ -687,6 +687,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
> >  	pgprot_t ref_prot;
> >  
> >  	spin_lock(&pgd_lock);
> 
> We probably should have comment explaining why we have a
> preempt_disable here.
okay.

> > +	preempt_disable();
> >  	/*
> >  	 * Check for races, another CPU might have split this page
> >  	 * up for us already:
> > @@ -694,6 +695,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
> >  	tmp = _lookup_address_cpa(cpa, address, &level);
> >  	if (tmp != kpte) {
> >  		spin_unlock(&pgd_lock);
> > +		preempt_enable();
> 
> Shouldn't the preempt_enable() be before the unlock?

Yeah, I noticed it once I saw the patch on the list. Will flip it before
I apply it.

> >  		return 1;
> >  	}
> >  

Sebastian
