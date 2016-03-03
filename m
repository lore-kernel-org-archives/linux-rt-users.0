From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 07/17] arm64: replace read_lock to rcu lock in
 call_step_hook
Date: Thu, 3 Mar 2016 09:12:50 -0500
Message-ID: <20160303091250.09034e47@gandalf.local.home>
References: <20160302154433.638594715@goodmis.org>
	<20160302154500.885242090@goodmis.org>
	<20160303042300.GA32034@dhcppc3>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	stable-rt@vger.kernel.org, Yang Shi <yang.shi@linaro.org>
To: Pratyush Anand <panand@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160303042300.GA32034@dhcppc3>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 3 Mar 2016 09:53:00 +0530
Pratyush Anand <panand@redhat.com> wrote:

> > diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> > index 636ba8b6240b..f66d668ffce9 100644
> > --- a/arch/arm64/kernel/debug-monitors.c
> > +++ b/arch/arm64/kernel/debug-monitors.c
> > @@ -190,19 +190,22 @@ static void clear_regs_spsr_ss(struct pt_regs *regs)
> >  /* EL1 Single Step Handler hooks */
> >  static LIST_HEAD(step_hook);
> >  DEFINE_RWLOCK(step_hook_lock);
> > +static DEFINE_RWLOCK(step_hook_lock);  
> 
> I think, this got wrong during backporting, no?
> Should have been
> -DEFINE_RWLOCK(step_hook_lock);
> 

Crap! Yep you are right. I screwed this up. I'll go fix it. Luckily,
that patch ended there. It didn't affect 3.12 or earlier.

Thanks for catching that.

-- Steve

> > +static DEFINE_SPINLOCK(step_hook_lock);  
> 
> ~Pratyush
