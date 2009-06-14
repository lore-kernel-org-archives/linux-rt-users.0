From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH -rt] include linux/delay.h in hwlat_detector
Date: Sun, 14 Jun 2009 23:31:42 +0200
Message-ID: <1245015102-22057-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>, Jon Masters <jcm@redhat.com>
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55149 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757600AbZFNVbx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 14 Jun 2009 17:31:53 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This broke when compiling on i386 without X86_LOCAL_APIC because then
arch/x86/include/asm/smp.h doesn't include asm/apic.h which in turn inc=
ludes
linux/delay.h.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jon Masters <jcm@redhat.com>
---

diff --git a/drivers/misc/hwlat_detector.c b/drivers/misc/hwlat_detecto=
r.c
index dbd9661..e02d8e1 100644
--- a/drivers/misc/hwlat_detector.c
+++ b/drivers/misc/hwlat_detector.c
@@ -49,6 +49,7 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 #include <linux/version.h>
+#include <linux/delay.h>
=20
 #define BUF_SIZE_DEFAULT	262144UL		/* 8K*(sizeof(entry)) */
 #define BUF_FLAGS		(RB_FL_OVERWRITE)	/* no block on full */
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
