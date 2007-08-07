From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 1/4 RFC] RCU: Fix barriers
Date: Tue, 7 Aug 2007 11:43:14 -0700
Message-ID: <20070807184314.GB10068@linux.vnet.ibm.com>
References: <20070807183946.GA32110@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, mingo@elte.hu,
	akpm@linux-foundation.org, dipankar@in.ibm.com,
	josht@linux.vnet.ibm.com, tytso@us.ibm.com, dvhltc@us.ibm.com,
	tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:53636 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558AbXHGSnQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Aug 2007 14:43:16 -0400
Content-Disposition: inline
In-Reply-To: <20070807183946.GA32110@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Fix rcu_barrier() to work properly in preemptive kernel environment.
Also, the ordering of callback must be preserved while moving
callbacks to another CPU during CPU hotplug.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---

 rcuclassic.c |    2 +-
 rcupdate.c   |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff -urpNa -X dontdiff linux-2.6.22-a-splitclassic/kernel/rcuclassic.c linux-2.6.22-b-fixbarriers/kernel/rcuclassic.c
--- linux-2.6.22-a-splitclassic/kernel/rcuclassic.c	2007-07-19 15:03:51.000000000 -0700
+++ linux-2.6.22-b-fixbarriers/kernel/rcuclassic.c	2007-07-19 17:10:46.000000000 -0700
@@ -349,9 +349,9 @@ static void __rcu_offline_cpu(struct rcu
 	if (rcp->cur != rcp->completed)
 		cpu_quiet(rdp->cpu, rcp);
 	spin_unlock_bh(&rcp->lock);
+	rcu_move_batch(this_rdp, rdp->donelist, rdp->donetail);
 	rcu_move_batch(this_rdp, rdp->curlist, rdp->curtail);
 	rcu_move_batch(this_rdp, rdp->nxtlist, rdp->nxttail);
-	rcu_move_batch(this_rdp, rdp->donelist, rdp->donetail);
 }
 
 static void rcu_offline_cpu(int cpu)
diff -urpNa -X dontdiff linux-2.6.22-a-splitclassic/kernel/rcupdate.c linux-2.6.22-b-fixbarriers/kernel/rcupdate.c
--- linux-2.6.22-a-splitclassic/kernel/rcupdate.c	2007-07-19 14:19:03.000000000 -0700
+++ linux-2.6.22-b-fixbarriers/kernel/rcupdate.c	2007-07-19 17:13:31.000000000 -0700
@@ -115,7 +115,17 @@ void rcu_barrier(void)
 	mutex_lock(&rcu_barrier_mutex);
 	init_completion(&rcu_barrier_completion);
 	atomic_set(&rcu_barrier_cpu_count, 0);
+	/*
+	 * The queueing of callbacks in all CPUs must be atomic with
+	 * respect to RCU, otherwise one CPU may queue a callback,
+	 * wait for a grace period, decrement barrier count and call
+	 * complete(), while other CPUs have not yet queued anything.
+	 * So, we need to make sure that grace periods cannot complete
+	 * until all the callbacks are queued.
+	 */
+	rcu_read_lock();
 	on_each_cpu(rcu_barrier_func, NULL, 0, 1);
+	rcu_read_unlock();
 	wait_for_completion(&rcu_barrier_completion);
 	mutex_unlock(&rcu_barrier_mutex);
 }
