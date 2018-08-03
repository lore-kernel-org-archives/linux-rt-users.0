Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.kernel.org ([198.145.29.99]:38902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731364AbeHCPXF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Aug 2018 11:23:05 -0400
From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 12/15] powerpc: ps3/device-init.c - adapt to completions using swait vs wait
Date: Fri,  3 Aug 2018 08:25:31 -0500
Message-Id: <4b32bce95f47905a9a3a8f94dc453974bd975545.1533242791.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1533242791.git.tom.zanussi@linux.intel.com>
References: <cover.1533242791.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1533242791.git.tom.zanussi@linux.intel.com>
References: <cover.1533242791.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org, jkacur@redhat.com, bigeasy@linutronix.de, daniel.wagner@siemens.com, julia@ni.com, tom.zanussi@linux.intel.com

From: Paul Gortmaker <paul.gortmaker@windriver.com>

To fix:

  cc1: warnings being treated as errors
  arch/powerpc/platforms/ps3/device-init.c: In function 'ps3_notification_read_write':
  arch/powerpc/platforms/ps3/device-init.c:755:2: error: passing argument 1 of 'prepare_to_wait_event' from incompatible pointer type
  arch/powerpc/platforms/ps3/device-init.c:755:2: error: passing argument 1 of 'abort_exclusive_wait' from incompatible pointer type
  arch/powerpc/platforms/ps3/device-init.c:755:2: error: passing argument 1 of 'finish_wait' from incompatible pointer type
  arch/powerpc/platforms/ps3/device-init.o] Error 1
  make[3]: *** Waiting for unfinished jobs....

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit 360395995f05ef133534d7ae74e01aea233623a6)
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 arch/powerpc/platforms/ps3/device-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
index 3f175e8aedb4..c4c02f91904c 100644
--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -752,7 +752,7 @@ static int ps3_notification_read_write(struct ps3_notification_device *dev,
 	}
 	pr_debug("%s:%u: notification %s issued\n", __func__, __LINE__, op);
 
-	res = wait_event_interruptible(dev->done.wait,
+	res = swait_event_interruptible(dev->done.wait,
 				       dev->done.done || kthread_should_stop());
 	if (kthread_should_stop())
 		res = -EINTR;
-- 
2.14.1

