From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH] RT: Only dirty a cacheline if the priority is actually
	changing
Date: Wed, 17 Oct 2007 14:54:25 -0400
Message-ID: <20071017185356.11365.49920.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:51832
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1762132AbXJQTIT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Oct 2007 15:08:19 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Oops...forgot to refresh this patch before mailing it.  Heres the actual
patch.


----


We can avoid dirtying a rq related cacheline with a simple check, so why not.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index 8c916de..d5dfe21 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -368,7 +368,8 @@ static DEFINE_MUTEX(sched_hotcpu_mutex);
 #if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
 static inline void set_rq_prio(struct rq *rq, int prio)
 {
-	rq->highest_prio = prio;
+	if (rq->highest_prio != prio)
+		rq->highest_prio = prio;
 }
 
 static inline void update_rq_prio(struct rq *rq)
