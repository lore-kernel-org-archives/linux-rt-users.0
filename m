From: Yuanbin Zhou <hduffddybz@gmail.com>
Subject: [PATCH v2] Makefile: Add CROSS_COMPILE for Makefile
Date: Mon, 28 Sep 2015 17:58:11 -0800
Message-ID: <20150929015811.GA1519@debian.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: williams@redhat.com, jkacur@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from m50-111.126.com ([123.125.50.111]:42115 "EHLO m50-111.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755159AbbI2CCJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Sep 2015 22:02:09 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Yuanbin Zhou <hduffddybz@gmail.com>
---
 Makefile | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 87946fb..35a7d5a 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,15 @@
 VERSION = 0.94
-CC=$(CROSS_COMPILE)gcc
-AR=$(CROSS_COMPILE)ar
+
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
 
 OBJDIR = bld
 
-- 
2.1.4


