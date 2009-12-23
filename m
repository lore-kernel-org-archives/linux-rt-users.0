From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/5] rt-tests: Add error routines to the library
Date: Wed, 23 Dec 2009 17:02:56 +0100
Message-ID: <1261584180-13922-2-git-send-email-jkacur@redhat.com>
References: <1261584180-13922-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:43180 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbZLWQDL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Dec 2009 11:03:11 -0500
Received: by fg-out-1718.google.com with SMTP id 22so2965318fge.1
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Dec 2009 08:03:09 -0800 (PST)
In-Reply-To: <1261584180-13922-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Add error routines, similar to those found in Advanced Programming in the
UNIX Environment 2nd ed. for use by all rt test programs

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/lib/error.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/lib/error.h |   14 ++++++++++++++
 2 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100644 src/lib/error.c
 create mode 100644 src/lib/error.h

diff --git a/src/lib/error.c b/src/lib/error.c
new file mode 100644
index 0000000..d5ad2aa
--- /dev/null
+++ b/src/lib/error.c
@@ -0,0 +1,49 @@
+#include "error.h"
+
+/* Print an error message, plus a message for err and exit with error err */
+void err_exit(int err, char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	err_doit(err, fmt, ap);
+	va_end(ap);
+	exit(err);
+}
+
+/* print an error message and return */
+void err_msg(char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	err_doit(0, fmt, ap);
+	va_end(ap);
+	return;
+}
+
+/* Print an error message, plus a message for err, and return */
+void err_msg_n(int err, char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	err_doit(err, fmt, ap);
+	va_end(ap);
+	return;
+}
+
+/* print an error message and quit */
+void err_quit(char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	err_doit(0, fmt, ap);
+	va_end(ap);
+	exit(1);
+}
+
+void err_doit(int err, const char *fmt, va_list ap)
+{
+	if (err)
+		fprintf(stderr, "%s\n", strerror(err));
+	vfprintf(stderr, fmt, ap);
+	return;
+}
diff --git a/src/lib/error.h b/src/lib/error.h
new file mode 100644
index 0000000..90d6e94
--- /dev/null
+++ b/src/lib/error.h
@@ -0,0 +1,14 @@
+#ifndef __ERROR_H
+#define __ERROR_H
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+
+void err_exit(int err, char *fmt, ...);
+void err_msg(char *fmt, ...);
+void err_msg_n(int err, char *fmt, ...);
+void err_quit(char *fmt, ...);
+void err_doit(int err, const char *fmt, va_list ap);
+
+#endif	/* __ERROR_H */
-- 
1.6.5.2

