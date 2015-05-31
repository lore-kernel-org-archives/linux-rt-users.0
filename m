From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 4.0-rt] powerpc: ps3/device-init.c - adapt to completions using swait vs wait
Date: Sun, 31 May 2015 14:44:42 -0400
Message-ID: <1433097882-1556-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:63586 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433AbbEaSq4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 31 May 2015 14:46:56 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

To fix:

  cc1: warnings being treated as errors
  arch/powerpc/platforms/ps3/device-init.c: In function 'ps3_notification_read_write':
  arch/powerpc/platforms/ps3/device-init.c:755:2: error: passing argument 1 of 'prepare_to_wait_event' from incompatible pointer type
  arch/powerpc/platforms/ps3/device-init.c:755:2: error: passing argument 1 of 'abort_exclusive_wait' from incompatible pointer type
  arch/powerpc/platforms/ps3/device-init.c:755:2: error: passing argument 1 of 'finish_wait' from incompatible pointer type
  arch/powerpc/platforms/ps3/device-init.o] Error 1
  make[3]: *** Waiting for unfinished jobs....

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[probably best squished to fixup_opencoded_completions.patch ? ]

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
2.2.1

