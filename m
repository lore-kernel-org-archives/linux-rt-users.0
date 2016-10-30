From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/3] work-simple: Add missing #include <linux/export.h>
Date: Sun, 30 Oct 2016 12:51:11 -0400
Message-ID: <20161030165121.921645255@goodmis.org>
References: <20161030165109.200928387@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932589AbcJ3Qv0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 30 Oct 2016 12:51:26 -0400
Content-Disposition: inline; filename=0002-work-simple-Add-missing-include-linux-export.h.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.2.83-rt121-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

work-simple.c uses EXPORT_SYMBOL_GPL(), defined in <linux/export.h>.

Link: http://lkml.kernel.org/r/20160930090504.GX10601@decadent.org.uk

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/work-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/work-simple.c b/kernel/work-simple.c
index c996f755dba6..e57a0522573f 100644
--- a/kernel/work-simple.c
+++ b/kernel/work-simple.c
@@ -10,6 +10,7 @@
 #include <linux/kthread.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/export.h>
 
 #define SWORK_EVENT_PENDING     (1 << 0)
 
-- 
2.9.3


