Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC09C63699
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Nov 2020 21:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 785E922258
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Nov 2020 21:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgKMVJW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:09:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:39826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgKMVJV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Nov 2020 16:09:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE304B018;
        Fri, 13 Nov 2020 21:09:19 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 4/6] rt-numa: Introduce NUMA helpers
Date:   Fri, 13 Nov 2020 22:09:08 +0100
Message-Id: <20201113210910.21807-5-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113210910.21807-1-dwagner@suse.de>
References: <20201113210910.21807-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

A common task is to parse the provided cpumask from the command
line. Add a helper which uses libnuma. Since we don't want to add
unnecessary dependencies for tests which don't need this helper create
a new library containing the NUMA bits.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Makefile              | 18 +++++++-------
 src/include/rt-numa.h |  9 +++++++
 src/lib/rt-numa.c     | 56 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 9 deletions(-)
 create mode 100644 src/include/rt-numa.h
 create mode 100644 src/lib/rt-numa.c

diff --git a/Makefile b/Makefile
index 24895b7f9697..3afdfd4d53a7 100644
--- a/Makefile
+++ b/Makefile
@@ -24,6 +24,7 @@ TARGETS = $(sources:.c=)
 LIBS	= -lrt -lpthread
 RTTESTLIB = -lrttest -L$(OBJDIR)
 EXTRA_LIBS ?= -ldl	# for get_cpu
+RTTESTNUMA = -lrttestnuma -lnuma
 DESTDIR	?=
 prefix  ?= /usr/local
 bindir  ?= $(prefix)/bin
@@ -84,11 +85,6 @@ ostype := $(lastword $(subst -, ,$(dumpmachine)))
 machinetype := $(shell echo $(dumpmachine)| \
     sed -e 's/-.*//' -e 's/i.86/i386/' -e 's/mips.*/mips/' -e 's/ppc.*/powerpc/')
 
-# You have to have libnuma installed, which is fine to do even if you are
-# running on non-numa machines
-CFLAGS += -DNUMA
-NUMA_LIBS = -lnuma
-
 include src/arch/android/Makefile
 
 VPATH	= src/cyclictest:
@@ -122,8 +118,8 @@ all: $(TARGETS) hwlatdetect get_cyclictest_snapshot | $(OBJDIR)
 # Include dependency files, automatically generate them if needed.
 -include $(addprefix $(OBJDIR)/,$(sources:.c=.d))
 
-cyclictest: $(OBJDIR)/cyclictest.o $(OBJDIR)/librttest.a
-	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(NUMA_LIBS)
+cyclictest: $(OBJDIR)/cyclictest.o $(OBJDIR)/librttest.a $(OBJDIR)/librttestnuma.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(RTTESTNUMA)
 
 cyclicdeadline: $(OBJDIR)/cyclicdeadline.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
@@ -172,8 +168,8 @@ queuelat: $(OBJDIR)/queuelat.o $(OBJDIR)/librttest.a
 ssdd: $(OBJDIR)/ssdd.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
 
-oslat: $(OBJDIR)/oslat.o $(OBJDIR)/librttest.a
-	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(NUMA_LIBS)
+oslat: $(OBJDIR)/oslat.o $(OBJDIR)/librttest.a $(OBJDIR)/librttestnuma.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(RTTESTNUMA)
 
 %.8.gz: %.8
 	gzip -nc $< > $@
@@ -185,6 +181,10 @@ LIBOBJS =$(addprefix $(OBJDIR)/,error.o rt-get_cpu.o rt-sched.o rt-utils.o)
 $(OBJDIR)/librttest.a: $(LIBOBJS)
 	$(AR) rcs $@ $^
 
+LIBNUMAOBJS =$(addprefix $(OBJDIR)/,rt-numa.o)
+$(OBJDIR)/librttestnuma.a: $(LIBNUMAOBJS)
+	$(AR) rcs $@ $^
+
 CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej *.d *.a *.8.gz *.8.bz2
 CLEANUP += $(if $(wildcard .git), ChangeLog)
 
diff --git a/src/include/rt-numa.h b/src/include/rt-numa.h
new file mode 100644
index 000000000000..047c8b6257cc
--- /dev/null
+++ b/src/include/rt-numa.h
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#ifndef __RT_NUMA_H
+#define __RT_NUMA_H
+
+#include <numa.h>
+
+int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask);
+
+#endif
diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
new file mode 100644
index 000000000000..a52a56e8aadd
--- /dev/null
+++ b/src/lib/rt-numa.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2020 Daniel Wagner <dwagner@suse.de>
+ */
+
+#include <sys/types.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include "rt-numa.h"
+
+/*
+ * After this function is called, affinity_mask is the intersection of
+ * the user supplied affinity mask and the affinity mask from the run
+ * time environment
+ */
+static void use_current_cpuset(int max_cpus, struct bitmask *cpumask)
+{
+	struct bitmask *curmask;
+	int i;
+
+	curmask = numa_allocate_cpumask();
+	numa_sched_getaffinity(getpid(), curmask);
+
+	/*
+	 * Clear bits that are not set in both the cpuset from the
+	 * environment, and in the user specified affinity.
+	 */
+	for (i = 0; i < max_cpus; i++) {
+		if ((!numa_bitmask_isbitset(cpumask, i)) ||
+		    (!numa_bitmask_isbitset(curmask, i)))
+			numa_bitmask_clearbit(cpumask, i);
+	}
+
+	numa_bitmask_free(curmask);
+}
+
+int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask)
+{
+	struct bitmask *mask;
+
+	mask = numa_parse_cpustring_all(str);
+	if (!mask)
+		return -ENOMEM;
+
+	if (numa_bitmask_weight(mask) == 0) {
+		numa_bitmask_free(mask);
+		*cpumask = NULL;
+		return 0;
+	}
+
+	use_current_cpuset(max_cpus, mask);
+	*cpumask = mask;
+
+	return 0;
+}
-- 
2.29.2

