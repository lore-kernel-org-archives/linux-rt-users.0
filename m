From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 04/16] rcu: rcutiny: Prevent RCU stall
Date: Mon, 18 Feb 2013 10:02:01 -0500
Message-ID: <1361199721.23152.145.camel@gandalf.local.home>
References: <1360771932-27150-1-git-send-email-bigeasy@linutronix.de>
	 <1360771932-27150-5-git-send-email-bigeasy@linutronix.de>
	 <20130216205909.GB3094@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Carsten Emde <C.Emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130216205909.GB3094@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2013-02-16 at 12:59 -0800, Paul E. McKenney wrote:
>  
> > diff --git a/kernel/rcutiny_plugin.h b/kernel/rcutiny_plugin.h
> > index 2b0484a..bac1906 100644
> > --- a/kernel/rcutiny_plugin.h
> > +++ b/kernel/rcutiny_plugin.h
> > @@ -552,7 +552,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
> >  		rcu_preempt_cpu_qs();
> > 
> >  	/* Hardware IRQ handlers cannot block. */
> > -	if (in_irq()) {
> > +	if (preempt_count() & (HARDIRQ_MASK | SOFTIRQ_OFFSET)) {
> 
> For whatever it is worth, in mainline this is:
> 
> 	if (in_irq() || in_serving_softirq()) {
> 
> The definition of in_serving_softirq() is a bit different:
> 
> #define in_serving_softirq()    (softirq_count() & SOFTIRQ_OFFSET)
> 
> This might be due to differences between mainline and -rt, but thought
> it worth calling attention to.
> 

Right, and we should avoid open coding HARDIRQ_MASK and SOFTIRQ_OFFSET. 
And note, -rt is slowly creeping into mainline. It's better to have
things like this nicely tidied up.

-- Steve
