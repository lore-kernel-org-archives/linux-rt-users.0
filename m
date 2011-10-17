From: Michael Thalmeier <michael.thalmeier@hale.at>
Subject: [PATCH] rt18: fix warnings in ftrace.h
Date: Mon, 17 Oct 2011 09:01:07 +0200
Message-ID: <1318834867-14031-1-git-send-email-michael.thalmeier@hale.at>
References: <alpine.LFD.2.02.1110131146370.3240@ionos>
Mime-Version: 1.0
Cc: rt <linux-rt-users@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>, michael@thalmeier.at
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1110131146370.3240@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

When CONFIG_FUNCTION_TRACER is not set usage of unknown struct ftrace_hash in
ftrace_func_command results in a lot of warnings.


Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
---
 include/linux/ftrace.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index ed0eb52..f0c0e8a 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -19,6 +19,8 @@
 
 #include <asm/ftrace.h>
 
+struct ftrace_hash;
+
 #ifdef CONFIG_FUNCTION_TRACER
 
 extern int ftrace_enabled;
@@ -29,8 +31,6 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
 
 typedef void (*ftrace_func_t)(unsigned long ip, unsigned long parent_ip);
 
-struct ftrace_hash;
-
 enum {
 	FTRACE_OPS_FL_ENABLED		= 1 << 0,
 	FTRACE_OPS_FL_GLOBAL		= 1 << 1,
-- 
1.7.6.4



--
Scanned by MailScanner.
