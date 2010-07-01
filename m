From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] modernize backfire's Makefile
Date: Thu,  1 Jul 2010 07:25:15 +0200
Message-ID: <1277961916-2538-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100701052430.GB28535@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37117 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab0GAFZU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Jul 2010 01:25:20 -0400
In-Reply-To: <20100701052430.GB28535@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

- don't rely on non-standard envvar PWD, use make's CURDIR instead
- allow overwriting KERNELDIR
- less repetition by conflating targets
- explicitly differentiate between kbuild and ordinary make part

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 src/backfire/Makefile |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/src/backfire/Makefile b/src/backfire/Makefile
index b5d2b3e..bbad91a 100644
--- a/src/backfire/Makefile
+++ b/src/backfire/Makefile
@@ -1,14 +1,17 @@
+# If KERNELRELEASE is defined, we've been invoked from the
+# kernel build system and can use its language
+ifneq ($(KERNELRELEASE),)
 obj-m :=3D backfire.o
=20
-all:	modules modules_install
-	@echo Done
+# otherwise we were called directly from the command
+# line; invoke the kernel build system.
+else
+KERNELDIR ?=3D /lib/modules/$(shell uname -r)/build
=20
-modules:
-	make -C /lib/modules/$(shell uname -r)/build M=3D$(PWD) modules
+modules modules_install clean::
+	make -C $(KERNELDIR) M=3D$(CURDIR) $@
=20
-modules_install:
-	make -C /lib/modules/$(shell uname -r)/build M=3D$(PWD) modules_insta=
ll
+clean::
+	rm -f *.o Module.markers modules.order
=20
-clean:
-	make -C /lib/modules/$(shell uname -r)/build M=3D$(PWD) clean
-	@rm -f *.o Module.markers modules.order
+endif
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
