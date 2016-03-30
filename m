From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Eliminating Packet Latency
Date: Wed, 30 Mar 2016 15:08:10 +0200
Message-ID: <20160330130810.GC21849@linutronix.de>
Reply-To: 12C1B74BDFD05D40B2356A9B12DFA3396C365B9764@KEBMXSPMB01.keba.co.at
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Rolenc <drolenc@rtlogic.com>,
	Michael Hewitt <mhewitt@aha.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: eg Engleder Gerhard <eg@keba.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42149 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbcC3NIP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Mar 2016 09:08:15 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* eg Engleder Gerhard | 2016-03-16 08:34:10 [+0100]:

>> I found that sometimes when sending network packets, the kernel would hijack the
>> thread of the sender when the queue was empty. This would cause issues, since I
>> had no control over the priority of that thread, since it could be anything. My fix
>> was to never allow the kernel to send in the context of the sending userspace
>
>We had a similar problem and solved it with changed locking:

So the following patch should do the job. Can someone confirm?

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Wed, 30 Mar 2016 13:36:29 +0200
Subject: [PATCH] net: dev: always take qdisc's busylock in __dev_xmit_skb()

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
---
 net/core/dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index cc364be3587b..0e17592adbff 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2891,7 +2891,11 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 	 * This permits __QDISC___STATE_RUNNING owner to get the lock more
 	 * often and dequeue packets faster.
 	 */
+#ifdef CONFIG_PREEMPT_RT_FULL
+	contended = true;
+#else
 	contended = qdisc_is_running(q);
+#endif
 	if (unlikely(contended))
 		spin_lock(&q->busylock);
 
-- 
2.8.0.rc3

Sebastian
