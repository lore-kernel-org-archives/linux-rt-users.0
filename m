From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 32/34] printf format attributes and format string constness in error helpers
Date: Mon, 22 May 2017 12:04:22 +0300
Message-ID: <20170522090424.16086-3-tommi.t.rantala@nokia.com>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
 <20170522090424.16086-1-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-db5eur01on0090.outbound.protection.outlook.com ([104.47.2.90]:12271
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751678AbdEVJEv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 05:04:51 -0400
In-Reply-To: <20170522090424.16086-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/include/error.h | 16 ++++++++--------
 src/lib/error.c     | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/src/include/error.h b/src/include/error.h
index 4acff49..29999fe 100644
--- a/src/include/error.h
+++ b/src/include/error.h
@@ -6,14 +6,14 @@
 #include <stdarg.h>
 #include <string.h>
 
-void err_exit(int err, char *fmt, ...) __attribute__((noreturn));
-void err_msg(char *fmt, ...);
-void err_msg_n(int err, char *fmt, ...);
-void err_quit(char *fmt, ...) __attribute__((noreturn));
-void debug(char *fmt, ...);
-void info(char *fmt, ...);
-void warn(char *fmt, ...);
-void fatal(char *fmt, ...) __attribute__((noreturn));
+void err_exit(int err, const char *fmt, ...) __attribute__((noreturn)) __attribute__((format (printf, 2, 3)));
+void err_msg(const char *fmt, ...)__attribute__((format (printf, 1, 2)));
+void err_msg_n(int err, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+void err_quit(const char *fmt, ...) __attribute__((noreturn)) __attribute__((format (printf, 1, 2)));
+void debug(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+void info(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+void warn(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
+void fatal(const char *fmt, ...) __attribute__((noreturn)) __attribute__((format (printf, 1, 2)));
 void err_doit(int err, const char *fmt, va_list ap);
 
 #endif	/* __ERROR_H */
diff --git a/src/lib/error.c b/src/lib/error.c
index b32aa02..d10bbce 100644
--- a/src/lib/error.c
+++ b/src/lib/error.c
@@ -7,7 +7,7 @@
 #include "error.h"
 
 /* Print an error message, plus a message for err and exit with error err */
-void err_exit(int err, char *fmt, ...)
+void err_exit(int err, const char *fmt, ...)
 {
 	va_list ap;
 	va_start(ap, fmt);
@@ -17,7 +17,7 @@ void err_exit(int err, char *fmt, ...)
 }
 
 /* print an error message and return */
-void err_msg(char *fmt, ...)
+void err_msg(const char *fmt, ...)
 {
 	va_list ap;
 	va_start(ap, fmt);
@@ -27,7 +27,7 @@ void err_msg(char *fmt, ...)
 }
 
 /* Print an error message, plus a message for err, and return */
-void err_msg_n(int err, char *fmt, ...)
+void err_msg_n(int err, const char *fmt, ...)
 {
 	va_list ap;
 	va_start(ap, fmt);
@@ -37,7 +37,7 @@ void err_msg_n(int err, char *fmt, ...)
 }
 
 /* print an error message and quit */
-void err_quit(char *fmt, ...)
+void err_quit(const char *fmt, ...)
 {
 	va_list ap;
 	va_start(ap, fmt);
@@ -46,7 +46,7 @@ void err_quit(char *fmt, ...)
 	exit(1);
 }
 
-void debug(char *fmt, ...)
+void debug(const char *fmt, ...)
 {
 	va_list ap;
 
@@ -56,7 +56,7 @@ void debug(char *fmt, ...)
 	va_end(ap);
 }
 
-void info(char *fmt, ...)
+void info(const char *fmt, ...)
 {
 	va_list ap;
 
@@ -66,7 +66,7 @@ void info(char *fmt, ...)
 	va_end(ap);
 }
 
-void warn(char *fmt, ...)
+void warn(const char *fmt, ...)
 {
 	va_list ap;
 
@@ -76,7 +76,7 @@ void warn(char *fmt, ...)
 	va_end(ap);
 }
 
-void fatal(char *fmt, ...)
+void fatal(const char *fmt, ...)
 {
 	va_list ap;
 
-- 
2.9.3

