From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [patch] sched, rt: fix migrate_enable() thinko
Date: Wed, 7 Sep 2011 19:11:08 -0700
Message-ID: <4E68243C.7000404@am.sony.com>
References: <1313232790.25267.7.camel@twins> <1314108763.6689.4.camel@marge.simson.net>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>,
	Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314108763.6689.4.camel@marge.simson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 08/23/11 07:12, Mike Galbraith wrote:
> 
> Assigning mask = tsk_cpus_allowed(p) after p->migrate_disable = 0 ensures
> that we won't see a mask change.. no push/pull, we stack tasks on one CPU.
> 
> Also add a couple fields to sched_debug for the next guy.
> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> 
> ---

< snip >

> Index: linux-2.6/kernel/sched_debug.c
> ===================================================================
> --- linux-2.6.orig/kernel/sched_debug.c
> +++ linux-2.6/kernel/sched_debug.c
> @@ -235,6 +235,7 @@ void print_rt_rq(struct seq_file *m, int
>  	P(rt_throttled);
>  	PN(rt_time);
>  	PN(rt_runtime);
> +	P(rt_nr_migratory);
>  
>  #undef PN
>  #undef P
> @@ -484,6 +485,8 @@ void proc_sched_show_task(struct task_st
>  	P(se.load.weight);
>  	P(policy);
>  	P(prio);
> +	P(migrate_disable);
> +	P(rt.nr_cpus_allowed);
>  #undef PN
>  #undef __PN
>  #undef P



Fix compile error for CONFIG_SMP=n

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 kernel/sched_debug.c |    2 	2 +	0 -	0 !
 1 file changed, 2 insertions(+)

Index: b/kernel/sched_debug.c
===================================================================
--- a/kernel/sched_debug.c
+++ b/kernel/sched_debug.c
@@ -235,7 +235,9 @@ void print_rt_rq(struct seq_file *m, int
 	P(rt_throttled);
 	PN(rt_time);
 	PN(rt_runtime);
+#ifdef CONFIG_SMP
 	P(rt_nr_migratory);
+#endif
 
 #undef PN
 #undef P
