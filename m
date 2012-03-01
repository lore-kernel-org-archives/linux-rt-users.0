From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 5/9][RFC] [PATCH 5/9] ring-buffer/rt: Check for irqs disabled before grabbing reader lock
Date: Thu, 01 Mar 2012 13:55:32 -0500
Message-ID: <20120301190345.786365803@goodmis.org>
References: <20120301185527.064629423@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:20848 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756387Ab2CATDr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Mar 2012 14:03:47 -0500
Content-Disposition: inline; filename=0005-ring-buffer-rt-Check-for-irqs-disabled-before-grabbi.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

In RT the reader lock is a mutex and we can not grab it when preemption is
disabled. The in_atomic() check that is there does not check if irqs are
disabled. Add that check as well.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 354017f..c060f04 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1054,7 +1054,7 @@ static inline int ok_to_lock(void)
 	if (in_nmi())
 		return 0;
 #ifdef CONFIG_PREEMPT_RT_FULL
-	if (in_atomic())
+	if (in_atomic() || irqs_disabled())
 		return 0;
 #endif
 	return 1;
-- 
1.7.3.4


