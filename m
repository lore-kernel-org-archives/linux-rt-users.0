From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [4.1.2-rt1] build failure
Date: Fri, 17 Jul 2015 19:47:30 +0300
Message-ID: <55A931A2.9040807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Sekhar Nori <nsekhar@ti.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45703 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360AbbGQQrd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Jul 2015 12:47:33 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id t6HGlWKd012067
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Jul 2015 11:47:32 -0500
Received: from DLEE71.ent.ti.com (dlee71.ent.ti.com [157.170.170.114])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id t6HGlW8X004786
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Jul 2015 11:47:32 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

I've just tried v4.1.2-rt1 RT-patch set and got below build
failure:

  CC      kernel/pid_namespace.o
In file included from kernel/pid_namespace.c:11:0:
include/linux/pid.h: In function 'get_pid':
include/linux/pid.h:78:3: error: implicit declaration of function 'atomic_inc' [-Werror=implicit-function-declaration]
   atomic_inc(&pid->count);
   ^
  CC      drivers/base/regmap/regcache-flat.o
  CC      fs/lockd/xdr4.o
cc1: some warnings being treated as errors
  CC      drivers/base/regmap/regmap-debugfs.o
make[1]: *** [kernel/pid_namespace.o] Error 1
make: *** [kernel] Error 2
make: *** Waiting for unfinished jobs....


I identified that it's reproduced in case 
CONFIG_PROVE_LOCKING=n
CONFIG_DEBUG_SPINLOCK=n
CONFIG_DEBUG_MUTEXES=n
CONFIG_DEBUG_LOCK_ALLOC=n

The same is not reproduced without RT-patch set.

The below diff fixes an issue for me:
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


[1] https://lkml.org/lkml/2015/7/14/389
-- 
regards,
-grygorii
