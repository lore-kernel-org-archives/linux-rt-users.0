From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/3] rt-tests: Makefile - Add a DEBUG option to the Makefile
Date: Mon, 16 Nov 2009 19:40:14 +0100
Message-ID: <1258396814-12929-4-git-send-email-jkacur@redhat.com>
References: <1258396814-12929-1-git-send-email-jkacur@redhat.com>
 <1258396814-12929-2-git-send-email-jkacur@redhat.com>
 <1258396814-12929-3-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:50379 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbZKPSkO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Nov 2009 13:40:14 -0500
Received: by bwz27 with SMTP id 27so5972352bwz.21
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Nov 2009 10:40:19 -0800 (PST)
In-Reply-To: <1258396814-12929-3-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This allows you to do
make DEBUG=0
which changes CFLAGS from -Wall -Wno-nonnull -O2
to -Wall -Wno-nonnull -O0 -g

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 96c7bca..7414a68 100644
--- a/Makefile
+++ b/Makefile
@@ -2,13 +2,19 @@ VERSION_STRING = 0.53
 
 TARGETS	= cyclictest signaltest classic_pi pi_stress \
 	  hwlatdetect rt-migrate-test
-CFLAGS	= -Wall -Wno-nonnull -O2
 LIBS 	= -lpthread -lrt
 DESTDIR	?=
 prefix  ?= /usr/local
 bindir  ?= $(prefix)/bin
 mandir	?= $(prefix)/share/man/man8
 
+CFLAGS = -Wall -Wno-nonnull
+ifndef DEBUG
+	CFLAGS	+= -O2
+else
+	CFLAGS	+= -O0 -g
+endif
+
 .PHONY: all
 all: $(TARGETS)
 
-- 
1.6.2.5

