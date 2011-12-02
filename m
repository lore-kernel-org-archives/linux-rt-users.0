From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH-RT] Fix for sleeping function called from invalid context when running gdb
Date: Fri, 2 Dec 2011 19:20:08 +0100
Message-ID: <20111202182008.GT24062@one.firstfloor.org>
References: <1322833159-3846-1-git-send-email-jkacur@redhat.com> <1322840763.30977.39.camel@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Kacur <jkacur@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Andi Kleen <andi@firstfloor.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1322840763.30977.39.camel@frodo>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> > -static inline void preempt_conditional_sti(struct pt_regs *regs)
> > +static inline void preempt_conditional_sti(struct pt_regs *regs, int stack)
> >  {
> > -	inc_preempt_count();
> > +	if (stack)
> > +		inc_preempt_count();

All callers now pass in true I think, so you could eliminate the stack argument.

-Andi

> >  	if (regs->flags & X86_EFLAGS_IF)
> >  		local_irq_enable();
