From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: rcu: make RCU_BOOST default on RT
Date: Thu, 8 Nov 2018 17:05:17 +0100
Message-ID: <20181108160517.qnibb5yve7nlpzdq@linutronix.de>
References: <20181101232518.GA12385@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181101232518.GA12385@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-11-01 16:25:18 [-0700], Paul E. McKenney wrote:
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -36,7 +36,7 @@ config TINY_RCU
> >  
> >  config RCU_EXPERT
> >  	bool "Make expert-level adjustments to RCU configuration"
> > -	default n
> > +	default y if PREEMPT_RT_FULL
> 
> Would it work to leave this as is, and ...
> 
> >  	help
> >  	  This option needs to be enabled if you wish to make
> >  	  expert-level adjustments to RCU configuration.  By default,
> > @@ -191,7 +191,7 @@ config RCU_FAST_NO_HZ
> >  config RCU_BOOST
> >  	bool "Enable RCU priority boosting"
> >  	depends on RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT
> 
> ... make the above line instead be:
> 
>   	depends on (RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT) || PREEMPT_RT_FULL
> 
> Or am I missing something?
> 
> I agree that the risk might currently seem small, but if Linus ever
> starts building PREEMPT_RT_FULL kernels, I really really do not want
> RCU_EXPERT to be set.  ;-)

okay, this would work. Let me teak this in my current tree.

> 								Thanx, Paul

Sebastian
