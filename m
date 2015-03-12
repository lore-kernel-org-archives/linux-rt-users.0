From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 17/39] rtmutex.c: Fix incorrect waiter check
Date: Thu, 12 Mar 2015 15:13:24 -0400
Message-ID: <20150312191409.880520048@goodmis.org>
References: <20150312191307.081068717@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Brad Mouring <brad.mouring@ni.com>,
	Ben Shelton <ben.shelton@ni.com>,
	T Makphaibulchoke <tmac@hp.com>, <stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:54317 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755343AbbCLTP1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Mar 2015 15:15:27 -0400
Content-Disposition: inline; filename=0017-rtmutex.c-Fix-incorrect-waiter-check.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.14.34-rt32-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Brad Mouring <bmouring@ni.com>

In task_blocks_on_lock, there's a null check on pi_blocked_on
of the task_struct. This pointer can encode the fact that the
task that contains the pointer is waking (preventing requeuing)
and therefore is non-null. Use the inline function to avoid
dereferencing an invalid "pointer"

Signed-off-by: Brad Mouring <brad.mouring@ni.com>
Reported-by: Ben Shelton <ben.shelton@ni.com>
Reviewed-by: T Makphaibulchoke <tmac@hp.com>
Tested-by: T Makphaibulchoke <tmac@hp.com>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/locking/rtmutex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index ec72272ab73a..74a824523d3a 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -361,7 +361,8 @@ int max_lock_depth = 1024;
 
 static inline struct rt_mutex *task_blocked_on_lock(struct task_struct *p)
 {
-	return p->pi_blocked_on ? p->pi_blocked_on->lock : NULL;
+	return rt_mutex_real_waiter(p->pi_blocked_on) ?
+		p->pi_blocked_on->lock : NULL;
 }
 
 /*
-- 
2.1.4


