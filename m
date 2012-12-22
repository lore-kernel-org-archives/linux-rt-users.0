From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/4] sched: Adjust sched_reset_on_fork when nothing else changes
Date: Sat, 22 Dec 2012 12:12:02 -0500
Message-ID: <20121222171217.147373707@goodmis.org>
References: <20121222171201.588460638@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, <stable@vger.kernel.org>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:32190 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab2LVRMS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 22 Dec 2012 12:12:18 -0500
Content-Disposition: inline; filename=0001-sched-Adjust-sched_reset_on_fork-when-nothing-else-c.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

If the policy and priority remain unchanged a possible modification of
sched_reset_on_fork gets lost in the early exit path.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: stable-rt@vger.kernel.org
---
 kernel/sched.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index 2cf4c4b..945009e 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -5339,11 +5339,13 @@ recheck:
 	}
 
 	/*
-	 * If not changing anything there's no need to proceed further:
+	 * If not changing anything there's no need to proceed
+	 * further, but store a possible modification of
+	 * reset_on_fork.
 	 */
 	if (unlikely(policy == p->policy && (!rt_policy(policy) ||
 			param->sched_priority == p->rt_priority))) {
