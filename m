From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 03/12] Disable RT_GROUP_SCHED in PREEMPT_RT_FULL
Date: Wed, 18 Jul 2012 18:39:13 -0400
Message-ID: <20120718223957.370352037@goodmis.org>
References: <20120718223910.898476857@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:32693 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab2GRWj6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Jul 2012 18:39:58 -0400
Content-Disposition: inline; filename=0003-Disable-RT_GROUP_SCHED-in-PREEMPT_RT_FULL.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Carsten Emde <C.Emde@osadl.org>

Strange CPU stalls have been observed in RT when RT_GROUP_SCHED
was configured.

Disable it for now.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 init/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index 89e40a4..5ed453f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -719,6 +719,7 @@ config RT_GROUP_SCHED
 	bool "Group scheduling for SCHED_RR/FIFO"
 	depends on EXPERIMENTAL
 	depends on CGROUP_SCHED
+	depends on !PREEMPT_RT_FULL
 	default n
 	help
 	  This feature lets you explicitly allocate real CPU bandwidth
-- 
1.7.10.4


