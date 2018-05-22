From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Date: Tue, 22 May 2018 19:21:16 +0200
Message-ID: <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
 <20180522131004.3012953c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180522131004.3012953c@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-05-22 13:10:04 [-0400], Steven Rostedt wrote:
> On Thu, 17 May 2018 14:40:06 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > +static DEFINE_LOCAL_IRQ_LOCK(fpsimd_lock);
> >  /*
> >   * Update current's FPSIMD/SVE registers from thread_struct.
> >   *
> > @@ -594,6 +595,7 @@ int sve_set_vector_length(struct task_struct *task,
> >  	 * non-SVE thread.
> >  	 */
> >  	if (task == current) {
> > +		local_lock(fpsimd_lock);
> >  		local_bh_disable();
> 
> I'm surprised that we don't have a "local_lock_bh()"?

right. Like the last time when we introduced a global lock with no
locking context? 

> -- Steve
> 
> >  
> >  		task_fpsimd_save();

Sebastian
