From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [4.1.2-rt1 PATCH] include/linux/pid.h: fix build error
Date: Tue, 21 Jul 2015 19:43:56 +0300
Message-ID: <1437497036-26111-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sekhar Nori <nsekhar@ti.com>,
	Grygorii Strashko <Grygorii.Strashko@linaro.org>
To: <bigeasy@linutronix.de>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56292 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755501AbbGUQoU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 21 Jul 2015 12:44:20 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Grygorii Strashko <Grygorii.Strashko@linaro.org>

This patch fixes build error:
  CC      kernel/pid_namespace.o
In file included from kernel/pid_namespace.c:11:0:
include/linux/pid.h: In function 'get_pid':
include/linux/pid.h:78:3: error: implicit declaration of function 'atomic_inc' [-Werror=implicit-function-declaration]
   atomic_inc(&pid->count);
   ^
which happens when
 CONFIG_PROVE_LOCKING=n
 CONFIG_DEBUG_SPINLOCK=n
 CONFIG_DEBUG_MUTEXES=n
 CONFIG_DEBUG_LOCK_ALLOC=n

Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
---
 include/linux/pid.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 23705a53..2cc64b7 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -2,6 +2,7 @@
 #define _LINUX_PID_H
 
 #include <linux/rcupdate.h>
+#include <linux/atomic.h>
 
 enum pid_type
 {
-- 
2.4.6

