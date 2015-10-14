From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 7/7] Makefile: Move TARGETS back to a more logical place in the Makefile
Date: Wed, 14 Oct 2015 15:32:18 +0200
Message-ID: <1444829538-18465-8-git-send-email-jkacur@redhat.com>
References: <1444829538-18465-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38566 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbbJNNcr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Oct 2015 09:32:47 -0400
Received: by wieq12 with SMTP id q12so83613881wie.1
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Oct 2015 06:32:46 -0700 (PDT)
In-Reply-To: <1444829538-18465-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Place TARGETS after sources. The evaluation of it doesn't depend on it's
position in the file, so remove the incorrect comment

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 563911d5f6da..703333fe1b42 100644
--- a/Makefile
+++ b/Makefile
@@ -16,6 +16,7 @@ sources = cyclictest.c \
 	  sigwaittest.c \
 	  svsematest.c
 
+TARGETS = $(sources:.c=)
 LIBS	= -lrt -lpthread
 RTTESTLIB = -lrttest -L$(OBJDIR)
 EXTRA_LIBS ?= -ldl	# for get_cpu
@@ -68,10 +69,8 @@ ifdef HAVE_PARSE_CPUSTRING_ALL
 endif
 endif
 
-# Include any arch specific makefiles here. Make sure that TARGETS aren't
-# evaluated until AFTER this include
+# Include any arch specific makefiles here.
 include src/arch/bionic/Makefile
-TARGETS = $(sources:.c=)
 
 VPATH	= src/cyclictest:
 VPATH	+= src/signaltest:
-- 
2.4.3

