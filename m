Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.kernel.org ([198.145.29.99]:54012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbeHNVnh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Aug 2018 17:43:37 -0400
From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 12/15] powerpc: ps3/device-init.c - adapt to completions using swait vs wait
Date: Tue, 14 Aug 2018 13:54:05 -0500
Message-Id: <9ae5bcd04c27d27993be9b29794367ea2e0b1082.1534263273.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1534263273.git.tom.zanussi@linux.intel.com>
References: <cover.1534263273.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1534263273.git.tom.zanussi@linux.intel.com>
References: <cover.1534263273.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org, jkacur@redhat.com, bigeasy@linutronix.de, daniel.wagner@siemens.com, julia@ni.com

v3.18.117-rt105 rt-stable review patch.  If anyone has any objections,
please let me know.

------------------

From: Paul Gortmaker <paul.gortmaker@windriver.com>

[ Upstream rt-devel commit 360395995f05ef133534d7ae74e01aea233623a6 ]

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
