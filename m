From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Date: Tue, 22 May 2018 13:24:29 -0400
Message-ID: <20180522132429.6f1dcf92@gandalf.local.home>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
        <20180522131004.3012953c@gandalf.local.home>
        <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 22 May 2018 19:21:16 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2018-05-22 13:10:04 [-0400], Steven Rostedt wrote:
> > On Thu, 17 May 2018 14:40:06 +0200
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >   
> > > +static DEFINE_LOCAL_IRQ_LOCK(fpsimd_lock);
> > >  /*
> > >   * Update current's FPSIMD/SVE registers from thread_struct.
> > >   *
> > > @@ -594,6 +595,7 @@ int sve_set_vector_length(struct task_struct *task,
> > >  	 * non-SVE thread.
> > >  	 */
> > >  	if (task == current) {
> > > +		local_lock(fpsimd_lock);
> > >  		local_bh_disable();  
> > 
> > I'm surprised that we don't have a "local_lock_bh()"?  
> 
> right. Like the last time when we introduced a global lock with no
> locking context? 
> 

I meant, we could have local_lock_bh(fpsimd_lock); that would turn into
a local_bh_disable() when !PREEMPT_RT.

-- Steve
