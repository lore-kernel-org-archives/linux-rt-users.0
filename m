From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: rcu: make RCU_BOOST default on RT
Date: Thu, 1 Nov 2018 16:25:18 -0700
Message-ID: <20181101232518.GA12385@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: bigeasy@linutronix.de
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> Since it is no longer invoked from the softirq people run into OOM more
> often if the priority of the RCU thread is too low. Making boosting
> default on RT should help in those case and it can be switched off if
> someone knows better.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 644264be90f0..0be2c96fb640 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -36,7 +36,7 @@ config TINY_RCU
>  
>  config RCU_EXPERT
>  	bool "Make expert-level adjustments to RCU configuration"
> -	default n
> +	default y if PREEMPT_RT_FULL

Would it work to leave this as is, and ...

>  	help
>  	  This option needs to be enabled if you wish to make
>  	  expert-level adjustments to RCU configuration.  By default,
> @@ -191,7 +191,7 @@ config RCU_FAST_NO_HZ
>  config RCU_BOOST
>  	bool "Enable RCU priority boosting"
>  	depends on RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT

... make the above line instead be:

  	depends on (RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT) || PREEMPT_RT_FULL

Or am I missing something?

I agree that the risk might currently seem small, but if Linus ever
starts building PREEMPT_RT_FULL kernels, I really really do not want
RCU_EXPERT to be set.  ;-)

								Thanx, Paul

> -	default n
> +	default y if PREEMPT_RT_FULL
>  	help
>  	  This option boosts the priority of preempted RCU readers that
>  	  block the current preemptible RCU grace period for too long.
