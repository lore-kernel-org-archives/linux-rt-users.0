From: Yuanbin Zhou <hduffddybz@gmail.com>
Subject: [PATCH] Makefile:add cross_compiler for Makefile
Date: Sun, 27 Sep 2015 22:12:05 -0800
Message-ID: <20150928061205.GA6382@debian.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: williams@redhat.com, jkacur@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from m50-112.126.com ([123.125.50.112]:42097 "EHLO m50-112.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbbI1GQP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Sep 2015 02:16:15 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

In this site(https://rt.wiki.kernel.org/index.php/Cyclictest), It has been shown that you can use "make CROSS_COPILE=<your-compiler-prefix>" to build software ran in other platform like arm & mips, but in fact it does not work, this patch is used to solve this problem.

Signed-off-by: Yuanbin Zhou <hduffddybz@gmail.com>
---
 Makefile | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Makefile b/Makefile
index a48e759..9b31ce4 100644
--- a/Makefile
+++ b/Makefile
@@ -11,6 +11,17 @@ sources += signaltest.c ptsematest.c sigwaittest.c svsematest.c sendme.c \
 
 TARGETS = $(sources:.c=)
 
+CROSS_COMPILE ?= $(CONFIG_CROSS_COMPILE:"%"=%)
+AS = $(CROSS_COMPILE)as
+LD = $(CROSS_COMPILE)ld
+CC = $(CROSS_COMPILE)gcc
+CPP = $(CC) -E
+AR = $(CROSS_COMPILE)ar
+NM = $(CROSS_COMPILE)nm
+STRIP = $(CROSS_COMPILE)strip
+OBJCOPY = $(CROSS_COMPILE)objcopy
+OBJDUMP = $(CROSS_COMPILE)objdump
+
 LIBS	= -lrt -lpthread
 RTTESTLIB = -lrttest -L.
 EXTRA_LIBS ?= -ldl	# for get_cpu
-- 
2.1.4


