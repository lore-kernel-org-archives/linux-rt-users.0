From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/5] rt-tests: Move header files from src/lib to src/include
Date: Wed, 23 Dec 2009 17:02:58 +0100
Message-ID: <1261584180-13922-4-git-send-email-jkacur@redhat.com>
References: <1261584180-13922-1-git-send-email-jkacur@redhat.com>
 <1261584180-13922-2-git-send-email-jkacur@redhat.com>
 <1261584180-13922-3-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:53385 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213AbZLWQDL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Dec 2009 11:03:11 -0500
Received: by mail-fx0-f213.google.com with SMTP id 5so7112407fxm.28
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Dec 2009 08:03:10 -0800 (PST)
In-Reply-To: <1261584180-13922-3-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Move header files from src/lib to src/include and adjust the Makefile to
reflect this change.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                 |    2 +-
 src/include/rt-get_cpu.h |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 src/include/rt-utils.h   |   11 +++++++++++
 src/lib/rt-get_cpu.h     |   46 ----------------------------------------------
 src/lib/rt-utils.h       |   11 -----------
 5 files changed, 58 insertions(+), 58 deletions(-)
 create mode 100644 src/include/rt-get_cpu.h
 create mode 100644 src/include/rt-utils.h
 delete mode 100644 src/lib/rt-get_cpu.h
 delete mode 100644 src/lib/rt-utils.h

diff --git a/Makefile b/Makefile
index df5a2f4..b30a139 100644
--- a/Makefile
+++ b/Makefile
@@ -11,7 +11,7 @@ bindir  ?= $(prefix)/bin
 mandir	?= $(prefix)/share/man
 srcdir	?= $(prefix)/src
 
-CFLAGS = -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/lib -Isrc/include
+CFLAGS = -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include
 
 ifndef DEBUG
 	CFLAGS	+= -O2
diff --git a/src/include/rt-get_cpu.h b/src/include/rt-get_cpu.h
new file mode 100644
index 0000000..15d05fc
--- /dev/null
+++ b/src/include/rt-get_cpu.h
@@ -0,0 +1,46 @@
+#ifndef __RT_GET_CPU_H
+#define __RT_GET_CPU_H
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
+#include <sys/syscall.h>   /* For SYS_xxx definitions */
+#include <sched.h>
+#include <dlfcn.h>
+#ifdef __NR_getcpu
+static inline int get_cpu_setup(void) { return 0; }
+static inline int get_cpu(void)
+{
+        int c,s;
+	/* Show the source of get_cpu */
+#ifdef DEBUG
+	fprintf(stderr, "__NR_getcpu\n");
+#endif
+        s = syscall(__NR_getcpu, &c, NULL, NULL);
+        return (s == -1) ? s : c;
+}
+#elif defined(__GLIBC__) && defined(__GLIBC_MINOR__)	\
+	&& __GLIBC__>=2 && __GLIBC_MINOR__>=6
+#include <utmpx.h>
+static inline int get_cpu_setup(void) { return 0; }
+static inline int get_cpu(void) { return sched_getcpu(); }
+#else
+extern int get_cpu_setup(void);
+extern int (*get_cpu)(void);
+extern int (*get_cpu_vdsop)(unsigned int *, unsigned int *, void *);
+
+static inline int getcpu_vdso(void)
+{
+	unsigned int c,s;
+	/* Show the source of get_cpu */
+#ifdef DEBUG
+	fprintf(stderr, "getcpu_vdso\n");
+#endif
+	s = get_cpu_vdsop(&c, NULL, NULL);
+        return (s == -1) ? s : c;
+}
+
+#endif
+
+#endif	/* __RT_GET_CPU_H */
+
diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
new file mode 100644
index 0000000..cc23c33
--- /dev/null
+++ b/src/include/rt-utils.h
@@ -0,0 +1,11 @@
+#ifndef __RT_UTILS_H
+#define __RT_UTILS_H
+
+#define _STR(x) #x
+#define STR(x) _STR(x)
+#define MAX_PATH 256
+
+int check_privs(void);
+char *get_debugfileprefix(void);
+
+#endif	/* __RT_UTILS.H */
diff --git a/src/lib/rt-get_cpu.h b/src/lib/rt-get_cpu.h
deleted file mode 100644
index 15d05fc..0000000
--- a/src/lib/rt-get_cpu.h
+++ /dev/null
@@ -1,46 +0,0 @@
-#ifndef __RT_GET_CPU_H
-#define __RT_GET_CPU_H
-#include <stdio.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <unistd.h>
-#include <sys/syscall.h>   /* For SYS_xxx definitions */
-#include <sched.h>
-#include <dlfcn.h>
-#ifdef __NR_getcpu
-static inline int get_cpu_setup(void) { return 0; }
-static inline int get_cpu(void)
-{
-        int c,s;
-	/* Show the source of get_cpu */
-#ifdef DEBUG
-	fprintf(stderr, "__NR_getcpu\n");
-#endif
-        s = syscall(__NR_getcpu, &c, NULL, NULL);
-        return (s == -1) ? s : c;
-}
-#elif defined(__GLIBC__) && defined(__GLIBC_MINOR__)	\
-	&& __GLIBC__>=2 && __GLIBC_MINOR__>=6
-#include <utmpx.h>
-static inline int get_cpu_setup(void) { return 0; }
-static inline int get_cpu(void) { return sched_getcpu(); }
-#else
-extern int get_cpu_setup(void);
-extern int (*get_cpu)(void);
-extern int (*get_cpu_vdsop)(unsigned int *, unsigned int *, void *);
-
-static inline int getcpu_vdso(void)
-{
-	unsigned int c,s;
-	/* Show the source of get_cpu */
-#ifdef DEBUG
-	fprintf(stderr, "getcpu_vdso\n");
-#endif
-	s = get_cpu_vdsop(&c, NULL, NULL);
-        return (s == -1) ? s : c;
-}
-
-#endif
-
-#endif	/* __RT_GET_CPU_H */
-
diff --git a/src/lib/rt-utils.h b/src/lib/rt-utils.h
deleted file mode 100644
index cc23c33..0000000
--- a/src/lib/rt-utils.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef __RT_UTILS_H
-#define __RT_UTILS_H
-
-#define _STR(x) #x
-#define STR(x) _STR(x)
-#define MAX_PATH 256
-
-int check_privs(void);
-char *get_debugfileprefix(void);
