From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 05/12] locking: locktorture: Do NOT include rwlock.h directly
Date: Fri, 26 Feb 2016 16:32:40 -0500
Message-ID: <20160226213340.790021589@goodmis.org>
References: <20160226213235.253312067@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>,
	"Wolfgang M. Reimer" <linuxball@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48250 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755244AbcBZVdr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2016 16:33:47 -0500
Content-Disposition: inline; filename=0005-locking-locktorture-Do-NOT-include-rwlock.h-directly.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.18.27-rt26-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Wolfgang M. Reimer" <linuxball@gmail.com>

Including rwlock.h directly will cause kernel builds to fail
if CONFIG_PREEMPT_RT_FULL is defined. The correct header file
(rwlock_rt.h OR rwlock.h) will be included by spinlock.h which
is included by locktorture.c anyway.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Wolfgang M. Reimer <linuxball@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/locking/locktorture.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index ec8cce259779..aa60d919e336 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -24,7 +24,6 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/spinlock.h>
-#include <linux/rwlock.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/smp.h>
-- 
2.7.0


