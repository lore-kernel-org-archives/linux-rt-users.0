From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests-1.0.1: Remove _GNU_SOURCE from source files
Date: Fri, 24 Jun 2016 13:46:28 +0200
Message-ID: <1466768788-6961-1-git-send-email-jkacur@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33484 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbcFXLqr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Jun 2016 07:46:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id r201so4329493wme.0
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jun 2016 04:46:46 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Remove _GNU_SOURCE from source files since it is already defined in via
the Makefile

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/rt-migrate-test/rt-migrate-test.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index d7b68ddac3e5..0a0bb77ab661 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -20,9 +20,6 @@
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif
 #include <stdio.h>
 #ifndef __USE_XOPEN2K
 # define __USE_XOPEN2K
-- 
2.4.11

