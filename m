From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH] Workaround for rq->lock deadlock
Date: Tue, 07 Aug 2007 11:43:55 -0600
Message-ID: <20070807173827.3210.85330.stgit@lsg>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com, mingo@elte.hu,
	ghaskins@novell.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nds154-200.nds.lab.novell.com ([151.155.154.200]:6913 "EHLO
	lsg.lab.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755174AbXHGSIW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Aug 2007 14:08:22 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The following patch converts double_lock_balance to a full DP alogorithm to
work around a deadlock in the scheduler when running on an 8-way SMP system.

I think the original algorithm in this function is technically correct.  So
really this patch is plastering over another lurking issue.  However, it does
fix the observed deadlock on our systems here so I thought I would at least
share the discovery.

The actual problem is probably related to a code path which takes
task_rq_locks without using the balancer code.  It might also be a race
between an rq_lock and something else. TBD

Signed-off-by: Gregory Haskins <ghaskins@novell.com>

---

 kernel/sched.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index 6f2cf6a..e946e3f 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -2507,14 +2507,19 @@ static int double_lock_balance(struct rq *this_rq, struct rq *busiest)
 		BUG_ON(1);
 	}
 	if (unlikely(!spin_trylock(&busiest->lock))) {
-		if (busiest < this_rq) {
-			spin_unlock(&this_rq->lock);
-			spin_lock(&busiest->lock);
-			spin_lock(&this_rq->lock);
+		struct rq *rq_l =  busiest < this_rq ? busiest : this_rq;
+		struct rq *rq_h =  busiest > this_rq ? busiest : this_rq;
 
-			return 1;
-		} else
-			spin_lock(&busiest->lock);
+		spin_unlock(&this_rq->lock);
+
+		while (1) {
+			if (spin_trylock(&rq_l->lock)) {
+				if (spin_trylock(&rq_h->lock))
+					return 1;
+				else
+					spin_unlock(&rq_l->lock);
+			}
+		}
 	}
 	return 0;
 }
