From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 7/9] rt: Drop the removal of _GPL from rt_mutex_destroy()'s
Date: Tue, 7 Mar 2017 16:32:57 -0600
Message-ID: <7863a0dfe9e36907740d19c57e43b49368527564.1488919535.git.julia@ni.com>
References: <cover.1488919535.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Steven Rostedt" <rostedt@goodmis.org>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:40297 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751935AbdCHABx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Mar 2017 19:01:53 -0500
In-Reply-To: <cover.1488919535.git.julia@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

4.1.38-rt46-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

What we have now should be enough, the EXPORT_SYMBOL statement for
rt_mutex_destroy() is not required.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit 5dbe8fd80a2ccfc8c24874e19259df51d91e02a2)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 kernel/locking/rtmutex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 469075e06cde..e0b0d9b419b5 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2015,7 +2015,8 @@ void rt_mutex_destroy(struct rt_mutex *lock)
 	lock->magic = NULL;
 #endif
 }
-EXPORT_SYMBOL(rt_mutex_destroy);
+
+EXPORT_SYMBOL_GPL(rt_mutex_destroy);
 
 /**
  * __rt_mutex_init - initialize the rt lock
-- 
2.11.1

