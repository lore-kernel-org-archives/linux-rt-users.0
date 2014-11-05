From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC v0 4/9] error: Add debug() function
Date: Wed,  5 Nov 2014 10:09:40 +0100
Message-ID: <1415178585-3192-5-git-send-email-daniel.wagner@bmw-carit.de>
References: <1415178585-3192-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: linux-rt-users@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:52818 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751396AbaKEJJt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Nov 2014 04:09:49 -0500
In-Reply-To: <1415178585-3192-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 src/include/error.h |  1 +
 src/lib/error.c     | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/src/include/error.h b/src/include/error.h
index 1e33f6c..ae05a2e 100644
--- a/src/include/error.h
+++ b/src/include/error.h
@@ -10,6 +10,7 @@ void err_exit(int err, char *fmt, ...);
 void err_msg(char *fmt, ...);
 void err_msg_n(int err, char *fmt, ...);
 void err_quit(char *fmt, ...);
+void debug(char *fmt, ...);
 void info(char *fmt, ...);
 void warn(char *fmt, ...);
 void fatal(char *fmt, ...);
diff --git a/src/lib/error.c b/src/lib/error.c
index 1b5de5d..0cef245 100644
--- a/src/lib/error.c
+++ b/src/lib/error.c
@@ -46,6 +46,16 @@ void err_quit(char *fmt, ...)
 	exit(1);
 }
 
+void debug(char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	fputs("DEBUG: ", stderr);
+	err_doit(0, fmt, ap);
+	va_end(ap);
+}
+
 void info(char *fmt, ...)
 {
 	va_list ap;
-- 
1.9.3

