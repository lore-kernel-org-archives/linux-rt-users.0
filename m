From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] Add copyright statements to files in src/lib
Date: Mon, 25 Jan 2010 21:22:54 +0100
Message-ID: <1264450974-6923-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1264191496-11663-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Kacur <jkacur@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>,
	Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44505 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470Ab0AYUWy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jan 2010 15:22:54 -0500
In-Reply-To: <1264191496-11663-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: John Kacur <jkacur@redhat.com>
Cc: Carsten Emde <carsten.emde@osadl.org>
Cc: Clark Williams <williams@redhat.com>
---
Hello,

compared to the previous patch I modified the comment in src/lib/error.=
c as
requested by John via irc.

Best regards
Uwe

 src/lib/error.c      |    6 ++++++
 src/lib/rt-get_cpu.c |    4 +++-
 src/lib/rt-utils.c   |    8 ++++++++
 3 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/src/lib/error.c b/src/lib/error.c
index d5ad2aa..e9fe58f 100644
--- a/src/lib/error.c
+++ b/src/lib/error.c
@@ -1,3 +1,9 @@
+/*
+ * Copyright (C) 2009 John Kacur <jkacur@redhat.com>
+ *
+ * error routines, similar to those found in
+ * Advanced Programming in the UNIX Environment 2nd ed.
+ */
 #include "error.h"
=20
 /* Print an error message, plus a message for err and exit with error =
err */
diff --git a/src/lib/rt-get_cpu.c b/src/lib/rt-get_cpu.c
index 6ebda90..83430dd 100644
--- a/src/lib/rt-get_cpu.c
+++ b/src/lib/rt-get_cpu.c
@@ -1,3 +1,6 @@
+/*
+ * Copyright (C) 2009 John Kacur <jkacur@redhat.com>
+ */
 #include "rt-get_cpu.h"
 #ifdef __NR_getcpu
 #elif defined(__GLIBC__) && defined(__GLIBC_MINOR__)	\
@@ -22,4 +25,3 @@ int get_cpu_setup(void)
 }
=20
 #endif
