From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] Explicity separate VPATH paths with a colon
Date: Thu, 24 Sep 2015 00:33:03 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509240032260.29601@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33015 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728AbbIWWdM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Sep 2015 18:33:12 -0400
Received: by wiclk2 with SMTP id lk2so4469574wic.0
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Sep 2015 15:33:11 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 4bfefcd2299f73682b4e00151b184cf657ec3b59 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Wed, 23 Sep 2015 16:02:34 +0200
Subject: [PATCH 1/2] Explicity separate VPATH paths with a colon

VPATH paths can be separated by either a space or a colon.
Explicitly insert a colon instead of relying on a space being inserted
due to the spacing of our Makefile

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9f7de2fb5813..4c0c096eb919 100644
--- a/Makefile
+++ b/Makefile
@@ -84,8 +84,8 @@ VPATH	+= src/sigwaittest:
 VPATH	+= src/svsematest:
 VPATH	+= src/pmqtest:
 VPATH	+= src/backfire:
-VPATH	+= src/lib
-VPATH	+= src/hackbench
+VPATH	+= src/lib:
+VPATH	+= src/hackbench:
 
 %.o: %.c
 	$(CC) -D VERSION=$(VERSION) -c $< $(CFLAGS) $(CPPFLAGS)
-- 
2.4.3

