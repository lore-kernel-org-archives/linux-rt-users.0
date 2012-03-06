From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 21/25][RFC 3.0.23-rt39-rc1] ring-buffer/rt: Check for irqs disabled before grabbing reader lock
Date: Tue, 06 Mar 2012 11:16:57 -0500
Message-ID: <20120306161951.365969726@goodmis.org>
References: <20120306161636.491172179@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:27025 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757122Ab2CFQ61 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Mar 2012 11:58:27 -0500
Content-Disposition: inline; filename=0021-ring-buffer-rt-Check-for-irqs-disabled-before-grabbi.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Steven Rostedt <rostedt@goodmis.org>

In RT the reader lock is a mutex and we can not grab it when preemption is
disabled. The in_atomic() check that is there does not check if irqs are
disabled. Add that check as well.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Carsten Emde <C.Emde@osadl.org>
Cc: John Kacur <jkacur@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Clark Williams <clark.williams@gmail.com>
Cc: stable-rt@vger.kernel.org
Link: http://lkml.kernel.org/r/20120301190345.786365803@goodmis.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/trace/ring_buffer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2467714..2ffbb9d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1045,7 +1045,7 @@ static inline int ok_to_lock(void)
 	if (in_nmi())
 		return 0;
 #ifdef CONFIG_PREEMPT_RT_FULL
-	if (in_atomic())
+	if (in_atomic() || irqs_disabled())
 		return 0;
 #endif
 	return 1;
-- 
1.7.8.3


