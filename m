From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Hung task for proc_cgroup_show
Date: Mon, 21 Dec 2015 18:59:51 +0100
Message-ID: <20151221175951.GA6714@linutronix.de>
References: <CALqGcGoMqJuvzQpGb84LzyxQCJADB73YEreND0HgOFK5DOQ6ig@mail.gmail.com>
 <20150714150016.GC21820@linutronix.de>
 <CALqGcGqzWsNacBHRUgFOrtJB6MSoqR+kDJteA8mgi9E4_o8vxw@mail.gmail.com>
 <20151211161450.GA6720@linutronix.de>
 <CALqGcGob5_qWeK1ndErqN9Z3DkGTPciTojjkEOkvauZyNd59Bg@mail.gmail.com>
 <CALqGcGpRQ5nO00qfHEBksuKV5ND3zMCwDK2zprXAPfVg3Lc59Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Christoph Mathys <eraserix@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50476 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbbLUR7x (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2015 12:59:53 -0500
Content-Disposition: inline
In-Reply-To: <CALqGcGpRQ5nO00qfHEBksuKV5ND3zMCwDK2zprXAPfVg3Lc59Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Christoph Mathys | 2015-12-21 10:49:41 [+0100]:

>When testing on another computer I got a BUG from the same general area:

If you can reproduce this then the following patch should fix it:

---
Subject: [PATCH] kernel/rcu: use swait for sync_rcu_preempt_exp_wq

__schedule() invokes rcu_note_context_switch() with preemption disabled:

|BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:917
|in_atomic(): 1, irqs_disabled(): 0, pid: 3329, name: init
|2 locks held by init/3329:
| #0:  (&mm->mmap_sem){++++++}, at: [<ffffffff8103f17e>] __do_page_fault+0x12e/0x5f0
| #1:  (ptlock_ptr(page)#2){+.+...}, at: [<ffffffff8117235f>] do_read_fault.isra.66+0xaf/0x2d0
|CPU: 1 PID: 3329 Comm: init Tainted: G            E 3.18.24-realtime-1-rt22 #1
|Call Trace:
| [<ffffffff81751b44>] rt_spin_lock+0x24/0x60
| [<ffffffff81093349>] __wake_up+0x29/0x60
| [<ffffffff810bcd04>] rcu_report_exp_rnp.isra.64+0xb4/0xc0
| [<ffffffff810c0a9b>] rcu_read_unlock_special+0x1fb/0x250
| [<ffffffff810c0cd4>] rcu_note_context_switch+0x1e4/0x420
| [<ffffffff8174d7c6>] __schedule+0x56/0x8a0
| [<ffffffff8174e4b4>] preempt_schedule_irq+0x44/0x80
| [<ffffffff81753883>] check_int_off+0x11/0x1e
| [<ffffffff81143848>] filemap_map_pages+0x188/0x270
| [<ffffffff8117246a>] do_read_fault.isra.66+0x1ba/0x2d0
| [<ffffffff81173abf>] handle_mm_fault+0x5ef/0xec0
| [<ffffffff8103f1e2>] __do_page_fault+0x192/0x5f0
| [<ffffffff8103f64c>] do_page_fault+0xc/0x10
| [<ffffffff81754752>] page_fault+0x22/0x30
| [<ffffffff811c7a75>] getname_flags+0xb5/0x1a0
| [<ffffffff811c7b72>] getname+0x12/0x20
| [<ffffffff811b594d>] do_sys_open+0xfd/0x220
| [<ffffffff8109e44d>] ? trace_hardirqs_on_caller+0xfd/0x1c0
| [<ffffffff811b5a8e>] SyS_open+0x1e/0x20
| [<ffffffff81752976>] system_call_fastpath+0x16/0x1b

Reported-by: Christoph Mathys <eraserix@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/rcu/tree_plugin.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 54da8f44d586..1cbeb0aa79e2 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -527,7 +527,7 @@ void synchronize_rcu(void)
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 
-static DECLARE_WAIT_QUEUE_HEAD(sync_rcu_preempt_exp_wq);
+static DEFINE_SWAIT_HEAD(sync_rcu_preempt_exp_wq);
 static unsigned long sync_rcu_preempt_exp_count;
 static DEFINE_MUTEX(sync_rcu_preempt_exp_mutex);
 
@@ -584,7 +584,7 @@ static void rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
 			raw_spin_unlock_irqrestore(&rnp->lock, flags);
 			if (wake) {
 				smp_mb(); /* EGP done before wake_up(). */
-				wake_up(&sync_rcu_preempt_exp_wq);
+				swait_wake(&sync_rcu_preempt_exp_wq);
 			}
 			break;
 		}
@@ -759,7 +759,7 @@ void synchronize_rcu_expedited(void)
 
 	/* Wait for snapshotted ->blkd_tasks lists to drain. */
 	rnp = rcu_get_root(rsp);
-	wait_event(sync_rcu_preempt_exp_wq,
+	swait_event(sync_rcu_preempt_exp_wq,
 		   sync_rcu_preempt_exp_done(rnp));
 
 	/* Clean up and exit. */
-- 
2.6.4


Sebastian
