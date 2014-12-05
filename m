From: "Brad Mouring" <bmouring@ni.com>
Subject: [PATCH] rtmutex.c: Fix incorrect waiter check
Date: Fri, 5 Dec 2014 13:35:00 -0600
Message-ID: <1417808100-21626-1-git-send-email-brad.mouring@ni.com>
Cc: "Paul McKenney" <paulmck@linux.vnet.ibm.com>,
	linux-rt-users@vger.kernel.org, Brad Mouring <brad.mouring@ni.com>
To: "Thomas Gleixner" <tglx@linutronix.de>,
	"Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:34805 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751190AbaLEUST (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 5 Dec 2014 15:18:19 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

In task_blocks_on_lock, there's a null check on pi_blocked_on
of the task_struct. This pointer can encode the fact that the
task that contains the pointer is waking (preventing requeuing)
and therefore is non-null. Use the inline function to avoid
dereferencing an invalid "pointer"

Signed-off-by: Brad Mouring <brad.mouring@ni.com>
Reported-by: Ben Shelton <ben.shelton@ni.com>
---
 kernel/locking/rtmutex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 6c40660..535321e 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -335,7 +335,8 @@ int max_lock_depth = 1024;
 
 static inline struct rt_mutex *task_blocked_on_lock(struct task_struct *p)
 {
-	return p->pi_blocked_on ? p->pi_blocked_on->lock : NULL;
+	return rt_mutex_real_waiter(p->pi_blocked_on) ?
+		p->pi_blocked_on->lock : NULL;
 }
 
 /*
-- 
1.8.3-rc3

