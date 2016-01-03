From: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] Makefile: Set CC/AR variable only if it doesn't have a value
Date: Sun,  3 Jan 2016 10:54:31 -0800
Message-ID: <1451847271-31571-1-git-send-email-raj.khem@gmail.com>
Cc: linux-rt-users@vger.kernel.org, Khem Raj <raj.khem@gmail.com>
To: williams@redhat.com, jkacur@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36767 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbcACSyn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 3 Jan 2016 13:54:43 -0500
Received: by mail-pf0-f180.google.com with SMTP id 65so145494384pff.3
        for <linux-rt-users@vger.kernel.org>; Sun, 03 Jan 2016 10:54:42 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This helps it compile with clang or any other compilers besides gcc

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 1e4b7d1..2c2d396 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION = 0.96
-CC=$(CROSS_COMPILE)gcc
-AR=$(CROSS_COMPILE)ar
+CC?=$(CROSS_COMPILE)gcc
+AR?=$(CROSS_COMPILE)ar
 
 OBJDIR = bld
 
-- 
2.6.4

