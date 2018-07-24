From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Date: Tue, 24 Jul 2018 09:46:23 -0400
Message-ID: <20180724094623.37430032@gandalf.local.home>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
        <20180522131004.3012953c@gandalf.local.home>
        <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
        <20180522132429.6f1dcf92@gandalf.local.home>
        <20180522173333.aawadhkcekzvrswp@linutronix.de>
        <20180711092555.268adf7f@gandalf.local.home>
        <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
        <20180711093346.782af07a@gandalf.local.home>
        <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
        <20180716151737.GO9486@e103592.cambridge.arm.com>
        <20180718091209.u76gzacanj5avhdl@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Dave Martin <Dave.Martin@arm.com>, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Galbraith <efault@gmx.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718091209.u76gzacanj5avhdl@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 18 Jul 2018 11:12:10 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > > @@ -1115,7 +1116,7 @@ void kernel_neon_begin(void)
> > >  
> > >  	BUG_ON(!may_use_simd());
> > >  
> > > -	local_bh_disable();
> > > +	local_lock_bh(fpsimd_lock);
> > >  
> > >  	__this_cpu_write(kernel_neon_busy, true);
> > >  
> > > @@ -1129,8 +1130,14 @@ void kernel_neon_begin(void)
> > >  	fpsimd_flush_cpu_state();
> > >  
> > >  	preempt_disable();
> > > -
> > > -	local_bh_enable();
> > > +	/*
> > > +	 * ballance atomic vs !atomic context of migrate_disable().
> > > +	 * local_lock_bh = get_local_var() + spin_lock_bh (2x migrate_disable)
> > > +	 */
> > > +	migrate_disable();
> > > +	migrate_disable();
> > > +	migrate_disable();
> > > +	local_unlock_bh(fpsimd_lock);  
> > 
> > This looks fragile.
> > 
> > Do we really need to do it 3 times?  
> 
> Unfortunately yes.

Then we need to find another solution, because this is way too ugly and
as Dave said, fragile to keep.


> 
> > Showing my ignorance here, but I'd naively expect that the migrate-
> > disableness changes as follows:
> > 
> > 	/* 0 */
> > 	local_lock_bh(); /* +3 */
> > 
> > 	...
> > 
> > 	preempt_disable(); /* +3 */
> > 
> > 	migrate_disable(); /* +4 */
> > 	migrate_disable(); /* +5 */
> > 	migrate_disable(); /* +6 */
> > 
> > 	local_unlock_bh(); /* +3 */
> > 
> > 
> > If so, I don't understand why it's not OK to call migrate_disable()
> > just once, leaving the count at +1  (?)
> > 
> > I'm making assumptions about the relationship between preempt_disable()
> > and migrate_disable() here.  
> 
> Exactly. So local_lock_bh() does +3 which I try to explain why it is 3.

How does local_lock_bh() do a +3 (not seeing it in the code). And
leaking internal implementation of local_lock_bh() into other parts of
the kernel is a no no.

> Now migrate_disable() has two counters: One for atomic context (irq or
> preemption disabled) and on for non-atomic context. The difference is
> that in atomic context migrate_disable() does nothing and in !atomic
> context it does other things which can't be done in atomic context
> anyway (I can explain this in full detail but you may lose interest so I
> keep it short). To update your example:
> 
> 	/* ATOMIC COUNTER | non-ATOMIC COUNTER  | change */
> 			 /* 0 | 0 | - */
> 	local_lock_bh(); /* 0 | 3 | N+3 */
>  
>  	...
>  
> 	preempt_disable(); /* atomic context */
>  
> 	migrate_disable(); /* 1 | 3 | A+1 */
> 	migrate_disable(); /* 2 | 3 | A+1 */
> 	migrate_disable(); /* 3 | 3 | A+1 */
>  
> 	local_unlock_bh(); /* 0 | 3 | A-3 */
> 
> /* later */
> 	preempt_enable();  /* non-atomic context */
> 	migrate_enable();  /* 0 | 2 | N-1 */
> 	migrate_enable();  /* 0 | 1 | N-1 */
> 	migrate_enable();  /* 0 | 0 | N-1 */

If anything, this needs a wrapper. local_lock_preempt_fixup() ?

-- Steve

> 
> > >  }
> > >  EXPORT_SYMBOL(kernel_neon_begin);
> > >  
> > > @@ -1154,6 +1161,10 @@ void kernel_neon_end(void)
> > >  	WARN_ON(!busy);	/* No matching kernel_neon_begin()? */
> > >  
> > >  	preempt_enable();
> > > +	/* balance migrate_disable(). See kernel_neon_begin() */
> > > +	migrate_enable();
> > > +	migrate_enable();
> > > +	migrate_enable();
> > >  }
> > >  EXPORT_SYMBOL(kernel_neon_end);
> > >  
> > > @@ -1185,9 +1196,7 @@ void __efi_fpsimd_begin(void)
> > >  	if (!system_supports_fpsimd())
> > >  		return;
> > >  
> > > -	WARN_ON(preemptible());
> > > -
> > > -	if (may_use_simd()) {
> > > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT_BASE) && may_use_simd()) {  
> > 
> > I suspect this is wrong -- see comments on the commit message.
> >   
> > >  		kernel_neon_begin();
> > >  	} else {  
> > 
> > [...]
> > 
> > Cheers
> > ---Dave  
