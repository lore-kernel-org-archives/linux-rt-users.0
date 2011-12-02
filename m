From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH-RT] Fix for sleeping function called from invalid
 context when running gdb
Date: Fri, 02 Dec 2011 14:41:37 -0500
Message-ID: <1322854897.30977.55.camel@frodo>
References: <1322833159-3846-1-git-send-email-jkacur@redhat.com>
	 <1322840763.30977.39.camel@frodo>
	 <20111202182008.GT24062@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:56695 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399Ab1LBTlj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Dec 2011 14:41:39 -0500
In-Reply-To: <20111202182008.GT24062@one.firstfloor.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2011-12-02 at 19:20 +0100, Andi Kleen wrote:
> > > -static inline void preempt_conditional_sti(struct pt_regs *regs)
> > > +static inline void preempt_conditional_sti(struct pt_regs *regs, int stack)
> > >  {
> > > -	inc_preempt_count();
> > > +	if (stack)
> > > +		inc_preempt_count();
> 
> All callers now pass in true I think, so you could eliminate the stack argument.

Not in RT:

#ifdef CONFIG_PREEMPT_RT_FULL
# define STACKFAULT_STACK 0
# define DOUBLEFAULT_STACK 1
# define NMI_STACK 2
# define DEBUG_STACK 0
# define MCE_STACK 3
# define N_EXCEPTION_STACKS 3  /* hw limit: 7 */
#else
# define STACKFAULT_STACK 1
# define DOUBLEFAULT_STACK 2
# define NMI_STACK 3
# define DEBUG_STACK 4
# define MCE_STACK 5
# define N_EXCEPTION_STACKS 5  /* hw limit: 7 */
#endif


-- Steve


