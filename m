From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] backfire: fix build failure for modern kernels
Date: Sat, 20 Aug 2011 14:54:03 +0200
Message-ID: <1313844843-6405-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49727 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab1HTMyM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 20 Aug 2011 08:54:12 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

SPIN_LOCK_UNLOCKED doesn't work any more since v2.6.39-rc1~511^2~11
(locking: Remove deprecated lock initializers). DEFINE_SPINLOCK is
available since v2.6.14-rc1~223, so it should be ok to depend on that.
<linux/smp_lock.h> is gone since v2.6.39-rc1~467^2.

The module builds fine for Debian's 2.6.32 kernel with this change.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 src/backfire/backfire.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/backfire/backfire.c b/src/backfire/backfire.c
index aaf9c4a..0e9a0df 100644
--- a/src/backfire/backfire.c
+++ b/src/backfire/backfire.c
@@ -24,7 +24,6 @@
 #include <linux/sched.h>
 #include <linux/cpumask.h>
 #include <linux/time.h>
-#include <linux/smp_lock.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/miscdevice.h>
@@ -36,7 +35,7 @@
=20
 #define BACKFIRE_MINOR MISC_DYNAMIC_MINOR
=20
-static spinlock_t backfire_state_lock =3D SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(backfire_state_lock);
 static int backfire_open_cnt; /* #times opened */
 static int backfire_open_mode; /* special open modes */
 static struct timeval sendtime; /* when the most recent signal was sen=
t */
--=20
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
