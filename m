From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: [RFC v0 0/3] Simple wait queue support
Date: Fri, 7 Aug 2015 14:00:48 +0200
Message-ID: <55C49DF0.4000007@bmw-carit.de>
References: <1438781448-10760-1-git-send-email-daniel.wagner@bmw-carit.de>
 <55C4534F.9040409@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <paul.gortmaker@windriver.com>, <peterz@infradead.org>,
	<bigeasy@linutronix.de>, <tglx@linutronix.de>,
	<paulmck@linux.vnet.ibm.com>, <rostedt@goodmis.org>
To: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C4534F.9040409@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 08/07/2015 08:42 AM, Daniel Wagner wrote:
> On 08/05/2015 03:30 PM, Daniel Wagner wrote:
>> My test system didn't crash or showed any obvious defects, so I
>> decided to apply some benchmarks utilizing mmtests. I have picked some
> 
> As it turns out, this is not really true. I forgot to enable lockdep:

[...]

> If I decoded this correctly the call to rcu_future_gp_cleanup() is
> supposed to run with IRQs disabled. swake_up_all() though will reenable the
> IRQs:
> 
> rcu_gp_cleanup() 
> 	rcu_for_each_node_breadth_first(rsp, rnp) {
> 		raw_spin_lock_irq(&rnp->lock);
> 
> 		nocb += rcu_future_gp_cleanup(rsp, rnp);
> 		raw_spin_unlock_irq(&rnp->lock);
> 	}
> 
> rcu_future_gp_cleanup()
> 	rcu_nocb_gp_cleanup()
> 		swake_up_all()
> 
> 
> With IRQs enabled again and we end up in rcu_process_callbacks
> under SOFTIRQ. rcu_process_callbacks aquires the RCU lock again.
> 
> Not sure what to do here.

Not really knowing if this is okay but I think the call to
rcu_nocb_gp_cleanup() inside rcu_future_gp_cleanup() doesn't need to be
protected by rnp->lock. At least lockdep and rcutorture is still happy.


diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d424378..9411fc3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1569,7 +1569,6 @@ static int rcu_future_gp_cleanup(struct rcu_state
*rsp, struct rcu_node *rnp)
 	int needmore;
 	struct rcu_data *rdp = this_cpu_ptr(rsp->rda);

-	rcu_nocb_gp_cleanup(rsp, rnp);
 	rnp->need_future_gp[c & 0x1] = 0;
 	needmore = rnp->need_future_gp[(c + 1) & 0x1];
 	trace_rcu_future_gp(rnp, rdp, c,
@@ -1992,6 +1991,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 		/* smp_mb() provided by prior unlock-lock pair. */
 		nocb += rcu_future_gp_cleanup(rsp, rnp);
 		raw_spin_unlock_irq(&rnp->lock);
+		rcu_nocb_gp_cleanup(rsp, rnp);
 		cond_resched_rcu_qs();
 		WRITE_ONCE(rsp->gp_activity, jiffies);
 		rcu_gp_slow(rsp, gp_cleanup_delay);
