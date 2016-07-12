From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 03/14] net: dev: always take qdiscs busylock in __dev_xmit_skb()
Date: Tue, 12 Jul 2016 12:48:02 -0400
Message-ID: <20160712164818.047041436@goodmis.org>
References: <20160712164759.154249453@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-net-dev-always-take-qdisc-s-busylock-in-__dev_xmit_s.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.14.72-rt76-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The root-lock is dropped before dev_hard_start_xmit() is invoked and after
setting the __QDISC___STATE_RUNNING bit. If this task is now pushed away
by a task with a higher priority then the task with the higher priority
won't be able to submit packets to the NIC directly instead they will be
enqueued into the Qdisc. The NIC will remain idle until the task(s) with
higher priority leave the CPU and the task with lower priority gets back
and finishes the job.

If we take always the busylock we ensure that the RT task can boost the
low-prio task and submit the packet.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 net/core/dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4259edb6d29b..0a680b4adf35 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2720,7 +2720,11 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 	 * This permits __QDISC_STATE_RUNNING owner to get the lock more often
 	 * and dequeue packets faster.
 	 */
+#ifdef CONFIG_PREEMPT_RT_FULL
+	contended = true;
+#else
 	contended = qdisc_is_running(q);
+#endif
 	if (unlikely(contended))
 		spin_lock(&q->busylock);
 
-- 
2.8.1
