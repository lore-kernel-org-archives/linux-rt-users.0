From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC v0 6/9] rt-sched: Add sched_setattr/sched_getattr API
Date: Wed,  5 Nov 2014 10:09:42 +0100
Message-ID: <1415178585-3192-7-git-send-email-daniel.wagner@bmw-carit.de>
References: <1415178585-3192-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: linux-rt-users@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>,
	Dario Faggioli <raistlin@linux.it>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:52826 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753381AbaKEJJw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Nov 2014 04:09:52 -0500
In-Reply-To: <1415178585-3192-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Until we have a proper libc implementation we maintain a simple
version of it. We this new API we are able to use SCHED_DEADLINE.

This is shamelessly stolen from Dario Faggioli's libdl.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Cc: Dario Faggioli <raistlin@linux.it>
---
 Makefile               |  4 +--
 src/include/rt-sched.h | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/lib/rt-sched.c     | 43 ++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+), 2 deletions(-)
 create mode 100644 src/include/rt-sched.h
 create mode 100644 src/lib/rt-sched.c

diff --git a/Makefile b/Makefile
index 318a5c6..87e2326 100644
--- a/Makefile
+++ b/Makefile
@@ -99,8 +99,8 @@ pip_stress: pip_stress.o librttest.a
 hackbench: hackbench.o
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
 
-librttest.a: rt-utils.o error.o rt-get_cpu.o
-	$(AR) rcs librttest.a rt-utils.o error.o rt-get_cpu.o
+librttest.a: rt-utils.o error.o rt-get_cpu.o rt-sched.o
+	$(AR) rcs librttest.a $^
 
 CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.spec *.d *.a
 CLEANUP += $(if $(wildcard .git), ChangeLog)
diff --git a/src/include/rt-sched.h b/src/include/rt-sched.h
new file mode 100644
index 0000000..6c45f7a
--- /dev/null
+++ b/src/include/rt-sched.h
@@ -0,0 +1,76 @@
+/*
+   rt-sched.h - sched_setattr() and sched_getattr() API
+
+   (C) Dario Faggioli <raistlin@linux.it>, 2009, 2010
+   Copyright (C) 2014 BMW Car IT GmbH, Daniel Wagner <daniel.wagner@bmw-carit.de
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
+   USA */
+
+/* This file is based on Dario Faggioli's libdl. Eventually it will be
+   replaced by a proper implemenation of this API. */
+
+#ifndef __RT_SCHED_H__
+#define __RT_SCHED_H__
+
+#include <stdint.h>
+#include <sys/types.h>
+
+#ifndef SCHED_DEADLINE
+#define SCHED_DEADLINE 6
+#endif
+
+#ifdef __x86_64__
+#define __NR_sched_setattr		314
+#define __NR_sched_getattr		315
+#endif
+
+#ifdef __i386__
+#define __NR_sched_setattr		351
+#define __NR_sched_getattr		352
+#endif
+
+#ifdef __arm__
+#define __NR_sched_setattr		380
+#define __NR_sched_getattr		381
+#endif
+
+struct sched_attr {
+	uint32_t size;
+	uint32_t sched_policy;
+	uint64_t sched_flags;
+
+	/* SCHED_NORMAL, SCHED_BATCH */
+	int32_t sched_nice;
+
+	/* SCHED_FIFO, SCHED_RR */
+	uint32_t sched_priority;
+
+	/* SCHED_DEADLINE */
+	uint64_t sched_runtime;
+	uint64_t sched_deadline;
+	uint64_t sched_period;
+};
+
+int sched_setattr(pid_t pid,
+		  const struct sched_attr *attr,
+		  unsigned int flags);
+
+int sched_getattr(pid_t pid,
+		  struct sched_attr *attr,
+		  unsigned int size,
+		  unsigned int flags);
+
+#endif /* __RT_SCHED_H__ */
diff --git a/src/lib/rt-sched.c b/src/lib/rt-sched.c
new file mode 100644
index 0000000..4a8e3c4
--- /dev/null
+++ b/src/lib/rt-sched.c
@@ -0,0 +1,43 @@
+/*
+   rt-sched.h - sched_setattr() and sched_getattr() API
+
+   (C) Dario Faggioli <raistlin@linux.it>, 2009, 2010
+   Copyright (C) 2014 BMW Car IT GmbH, Daniel Wagner <daniel.wagner@bmw-carit.de
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
+   USA */
+
+/* This file is based on Dario Faggioli's libdl. Eventually it will be
+   replaced by a proper implemenation of this API. */
+
+#include <unistd.h>
+#include <sys/syscall.h>
+
+#include "rt-sched.h"
+
+int sched_setattr(pid_t pid,
+		  const struct sched_attr *attr,
+		  unsigned int flags)
+{
+	return syscall(__NR_sched_setattr, pid, attr, flags);
+}
+
+int sched_getattr(pid_t pid,
+		  struct sched_attr *attr,
+		  unsigned int size,
+		  unsigned int flags)
+{
+        return syscall(__NR_sched_getattr, pid, attr, size, flags);
+}
-- 
1.9.3

