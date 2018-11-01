From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: rcu: enable rcu_normal_after_boot by default for RT
Date: Thu, 1 Nov 2018 16:02:35 -0700
Message-ID: <20181101230235.GA8757@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: lcapitulino@redhat.com, julia@ni.com, bigeasy@linutronix.de
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> The forcing of an expedited grace period is an expensive and very
> RT-application unfriendly operation, as it forcibly preempts all running
> tasks on CPUs which are preventing the gp from expiring.
> 
> By default, as a policy decision, disable the expediting of grace
> periods (after boot) on configurations which enable PREEMPT_RT_FULL.
> 
> Suggested-by: Luiz Capitulino <lcapitulino@redhat.com>
> Signed-off-by: Julia Cartwright <julia@ni.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

In case it matters:

Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>

Alternatively, any reason that I should not pull this into -rcu?

							Thanx, Paul

> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index f56c0fbdf22e..12027723abaf 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -67,7 +67,7 @@ extern int rcu_expedited; /* from sysctl */
>  module_param(rcu_expedited, int, 0);
>  extern int rcu_normal; /* from sysctl */
>  module_param(rcu_normal, int, 0);
> -static int rcu_normal_after_boot;
> +static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
>  module_param(rcu_normal_after_boot, int, 0);
>  #endif /* #ifndef CONFIG_TINY_RCU */
>  
