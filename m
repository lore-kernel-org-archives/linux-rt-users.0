From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH 09/13] RT: Only dirty a cacheline if the priority is actually
	changing
Date: Tue, 23 Oct 2007 12:51:09 -0400
Message-ID: <20071023165109.5536.40755.stgit@novell1.haskins.net>
References: <20071023164156.5536.95573.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	Gregory Haskins <ghaskins@novell.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dmitry Adamushko <dmitry.adamushko@gmail.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:35091
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754732AbXJWRFp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Oct 2007 13:05:45 -0400
In-Reply-To: <20071023164156.5536.95573.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

We can avoid dirtying a rq related cacheline with a simple check, so why not.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index e536142..1058a1f 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -376,7 +376,8 @@ static inline void update_rq_prio(struct rq *rq)
 	struct rt_prio_array *array = &rq->rt.active;
 	int                   prio  = sched_find_first_bit(array->bitmap);
 
-	set_rq_prio(rq, prio);
+	if (rq->highest_prio != prio)
+		set_rq_prio(rq, prio);
 }
 
 #else
