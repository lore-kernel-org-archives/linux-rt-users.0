From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 6/8] rt: Drop the removal of _GPL from rt_mutex_destroy()s EXPORT_SYMBOL
Date: Wed, 08 Mar 2017 15:21:01 -0500
Message-ID: <20170308202117.860278216@goodmis.org>
References: <20170308202055.192561119@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751699AbdCHUYc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Mar 2017 15:24:32 -0500
Content-Disposition: inline; filename=0006-rt-Drop-the-removal-of-_GPL-from-rt_mutex_destroy-s-.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.18.48-rt54-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

What we have now should be enough, the EXPORT_SYMBOL statement for
rt_mutex_destroy() is not required.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/locking/rtmutex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 89651b3e7700..8d950b4521fc 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2018,7 +2018,8 @@ void rt_mutex_destroy(struct rt_mutex *lock)
 	lock->magic = NULL;
 #endif
 }
-EXPORT_SYMBOL(rt_mutex_destroy);
+
+EXPORT_SYMBOL_GPL(rt_mutex_destroy);
 
 /**
  * __rt_mutex_init - initialize the rt lock
-- 
2.10.2


