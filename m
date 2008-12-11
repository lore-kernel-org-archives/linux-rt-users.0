From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] [RT] preempt_disable_rt for CONFIG_PREEMPT_RT
Date: Thu, 11 Dec 2008 20:05:48 +0100
Message-ID: <1229022348-32311-1-git-send-email-tim@klingt.org>
References: <alpine.DEB.1.10.0812081218471.26257@gandalf.stny.rr.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	mingo@elte.hu, tglx@linutronix.de, Tim Blechmann <tim@klingt.org>
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.klingt.org ([86.59.21.178]:33912 "EHLO klingt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756623AbYLKTGJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Dec 2008 14:06:09 -0500
In-Reply-To: <alpine.DEB.1.10.0812081218471.26257@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

in some cases, spinlocks are used to avoid preemption. does not work
correctly, when CONFIG_PREEMPT_RT is enabled.

therefore two new macros are introduced:
preempt_disable_rt/preempt_disable_rt behave like their equivalents, if
CONFIG_PREEMPT_RT is enabled, and as noops otherwise.

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 include/linux/preempt.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 72b1a10..2526170 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -93,6 +93,16 @@ do { \
 
 #endif
 
+#ifdef CONFIG_PREEMPT_RT
+#define preempt_disable_rt	preempt_disable
+#define preempt_enable_rt	preempt_enable
+#else
+#define
+#define preempt_disable_rt	do { } while (0)
+#define preempt_enable_rt	do { } while (0)
+#endif
+
+
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 
 struct preempt_notifier;
-- 
1.5.6.3

