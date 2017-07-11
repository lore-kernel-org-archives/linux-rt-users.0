From: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Subject: [PATCH] backfire: fix build failure for 4.11+ kernels
Date: Tue, 11 Jul 2017 14:44:59 -0300
Message-ID: <1499795099-29710-1-git-send-email-marcelo.cerri@canonical.com>
Cc: rt-users <linux-rt-users@vger.kernel.org>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36408 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932462AbdGKRpF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Jul 2017 13:45:05 -0400
Received: by mail-qt0-f171.google.com with SMTP id i2so87432qta.3
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Jul 2017 10:45:05 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Since v4.11-rc1~18^2~76, kill_pid() is declared in
"linux/sched/signal.h" instead of in "linux/sched.h".

Include the correct header file based on the kernel version to keep
it compatible with older kernels.

Signed-off-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
---
 src/backfire/backfire.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/backfire/backfire.c b/src/backfire/backfire.c
index aaf9c4af8e00..7b3b5faf7a11 100644
--- a/src/backfire/backfire.c
+++ b/src/backfire/backfire.c
@@ -20,8 +20,13 @@
  */
 
 #include <linux/module.h>
+#include <linux/version.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,11,0)
 #include <linux/sched.h>
+#else
+#include <linux/sched/signal.h>
+#endif
 #include <linux/cpumask.h>
 #include <linux/time.h>
 #include <linux/smp_lock.h>
-- 
2.7.4

