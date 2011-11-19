From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/3] sysctl-include-fix.patch
Date: Sat, 19 Nov 2011 13:50:27 +0100
Message-ID: <1321707028-12487-3-git-send-email-jkacur@redhat.com>
References: <1321707028-12487-1-git-send-email-jkacur@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1321707028-12487-1-git-send-email-jkacur@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cherry-picked for v3.0-rt and fixed minor merge conflict
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 include/linux/sysctl.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 11684d9..92b99dd 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -931,6 +931,7 @@ enum
 #ifdef __KERNEL__
 #include <linux/list.h>
 #include <linux/rcupdate.h>
+#include <linux/atomic.h>
 
 /* For the /proc/sys support */
 struct ctl_table;
-- 
1.7.2.3
