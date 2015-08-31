From: Josh Cartwright <joshc@ni.com>
Subject: [PATCH rt-tests 8/9] error: mark fatal, err_exit, err_quit as being noreturn
Date: Mon, 31 Aug 2015 11:35:35 -0500
Message-ID: <0e671c826ca8281e8ad005a9dbc4f553cc816e8d.1441038216.git.joshc@ni.com>
References: <cover.1441038216.git.joshc@ni.com>
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:44390 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753585AbbHaQfj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Aug 2015 12:35:39 -0400
In-Reply-To: <cover.1441038216.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

These functions never return to their caller.  Mark them as such to aide
in code generation and help out static analysis.

Signed-off-by: Josh Cartwright <joshc@ni.com>
---
 src/include/error.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/include/error.h b/src/include/error.h
index ae05a2e..4acff49 100644
--- a/src/include/error.h
+++ b/src/include/error.h
@@ -6,14 +6,14 @@
 #include <stdarg.h>
 #include <string.h>
 
-void err_exit(int err, char *fmt, ...);
+void err_exit(int err, char *fmt, ...) __attribute__((noreturn));
 void err_msg(char *fmt, ...);
 void err_msg_n(int err, char *fmt, ...);
-void err_quit(char *fmt, ...);
+void err_quit(char *fmt, ...) __attribute__((noreturn));
 void debug(char *fmt, ...);
 void info(char *fmt, ...);
 void warn(char *fmt, ...);
-void fatal(char *fmt, ...);
+void fatal(char *fmt, ...) __attribute__((noreturn));
 void err_doit(int err, const char *fmt, va_list ap);
 
 #endif	/* __ERROR_H */
-- 
2.5.0

