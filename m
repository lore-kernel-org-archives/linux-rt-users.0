From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH v2 3/4] Android: Expand match for android in ostype
Date: Wed, 21 Oct 2015 21:00:10 +0200
Message-ID: <1445454011-18839-4-git-send-email-haustad@cisco.com>
References: <1445454011-18839-1-git-send-email-haustad@cisco.com>
Cc: John Kacur <jkacur@redhat.com>, Henrik Austad <henrik@austad.us>,
	Henrik Austad <haustad@cisco.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from aer-iport-3.cisco.com ([173.38.203.53]:57073 "EHLO
	aer-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532AbbJUTEZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Oct 2015 15:04:25 -0400
In-Reply-To: <1445454011-18839-1-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Henrik Austad <henrik@austad.us>

Some buildsystems use androidabe, so an exact match will break in those
circumstances.

Cc: John Kacur <jkacur@redhat.com>
Signed-off-by: Henrik Austad <haustad@cisco.com>
---
 src/arch/android/Makefile | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/src/arch/android/Makefile b/src/arch/android/Makefile
index e25f67203e5a..2c4b4b7ef9ae 100644
--- a/src/arch/android/Makefile
+++ b/src/arch/android/Makefile
@@ -1,10 +1,14 @@
 
-# Bionic (android) does not have:
+# Android use Bionic for libc, and this does not have
 # - pthread barriers
 # - pthread_[gs]etaffinity
 #
-# Typically see something like "aarch64-linux-android"
-ifeq (android,$(ostype))
+# This is all handled by bionic.h based on flags we set here.
+
+# Typically see something like "aarch64-linux-android". However, in some
+# buildsystems, it will be a variation of -androidabe.
+ost=$(findstring android, $(ostype))
+ifeq (android,$(ost))
 	USE_BIONIC := 1
 	CFLAGS += -DPTHREAD_BIONIC
 
@@ -13,9 +17,7 @@ ifeq (android,$(ostype))
 	LIBS := $(filter-out -lrt,$(LIBS))
 	LIBS := $(filter-out -lpthread,$(LIBS))
 
-# BIONIC does not support PI, barriers and has different files in
-# include/. This means that currently, only these binaries will compile
-# and link properly:
+# Currently, only these binaries will compile and link properly for android
 # - cyclictest
 # - hackbench
 	sources := cyclictest.c hackbench.c
-- 
1.9.1

