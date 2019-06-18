Return-Path: <SRS0=oonB=UR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45080C31E51
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Jun 2019 10:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCD620873
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Jun 2019 10:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfFRKjx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:39:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47091 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfFRKjx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Jun 2019 06:39:53 -0400
Received: from [5.158.153.52] (helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1hdBWh-0005SS-1s; Tue, 18 Jun 2019 12:39:43 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 1/6] rt-tests: deadline: Remove duplicated code for sched_{set,get}_attr
Date:   Tue, 18 Jun 2019 12:38:36 +0200
Message-Id: <20190618103841.27249-2-kurt@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190618103841.27249-1-kurt@linutronix.de>
References: <20190618103841.27249-1-kurt@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The system calls for sched_get_attr() and sched_set_attr() are already
implemented. Get rid of the code and use the existing libary.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 src/sched_deadline/cyclicdeadline.c | 36 +------------------
 src/sched_deadline/deadline_test.c  | 72 ++-----------------------------------
 2 files changed, 3 insertions(+), 105 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 47892daf747b..754670c4e7d4 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -22,31 +22,17 @@
 #include <linux/magic.h>
 
 #include <rt-utils.h>
+#include <rt-sched.h>
 
 #ifdef __i386__
-#ifndef __NR_sched_setattr
-#define __NR_sched_setattr		351
-#endif
-#ifndef __NR_sched_getattr
-#define __NR_sched_getattr		352
-#endif
 #ifndef __NR_getcpu
 #define __NR_getcpu			309
 #endif
 #else /* x86_64 */
-#ifndef __NR_sched_setattr
-#define __NR_sched_setattr		314
-#endif
-#ifndef __NR_sched_getattr
-#define __NR_sched_getattr		315
-#endif
 #ifndef __NR_getcpu
 #define __NR_getcpu			309
 #endif
 #endif /* i386 or x86_64 */
-#ifndef SCHED_DEADLINE
-#define SCHED_DEADLINE		6
-#endif
 
 #define _STR(x) #x
 #define STR(x) _STR(x)
@@ -58,8 +44,6 @@
 #define CPUSET_LOCAL	"my_cpuset"
 
 #define gettid() syscall(__NR_gettid)
-#define sched_setattr(pid, attr, flags) syscall(__NR_sched_setattr, pid, attr, flags)
-#define sched_getattr(pid, attr, size, flags) syscall(__NR_sched_getattr, pid, attr, size, flags)
 #define getcpu(cpup, nodep, unused) syscall(__NR_getcpu, cpup, nodep, unused)
 
 typedef unsigned long long u64;
@@ -115,24 +99,6 @@ struct sched_data {
 	char buff[BUFSIZ+1];
 };
 
-struct sched_attr {
-	u32 size;
-
-	u32 sched_policy;
-	u64 sched_flags;
-
-	/* SCHED_NORMAL, SCHED_BATCH */
-	s32 sched_nice;
-
-	/* SCHED_FIFO, SCHED_RR */
-	u32 sched_priority;
-
-	/* SCHED_DEADLINE */
-	u64 sched_runtime;
-	u64 sched_deadline;
-	u64 sched_period;
-};
-
 static int shutdown;
 
 static pthread_barrier_t barrier;
diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
index b01e3f27e00f..c3b9dceb5209 100644
--- a/src/sched_deadline/deadline_test.c
+++ b/src/sched_deadline/deadline_test.c
@@ -51,6 +51,8 @@
 #include <linux/unistd.h>
 #include <linux/magic.h>
 
+#include <rt-sched.h>
+
 /**
  * usage - show the usage of the program and exit.
  * @argv: The program passed in args
@@ -82,43 +84,6 @@ static void usage(char **argv)
 	exit(-1);
 }
 
-/*
- * sched_setattr() and sched_getattr() are new system calls. We need to
- * hardcode it here.
- */
-#if defined(__i386__)
-
-#ifndef __NR_sched_setattr
-#define __NR_sched_setattr		351
-#endif
-#ifndef __NR_sched_getattr
-#define __NR_sched_getattr		352
-#endif
-
-#elif defined(__x86_64__)
-
-#ifndef __NR_sched_setattr
-#define __NR_sched_setattr		314
-#endif
-#ifndef __NR_sched_getattr
-#define __NR_sched_getattr		315
-#endif
-
-#endif /* i386 or x86_64 */
-
-#if !defined(__NR_sched_setattr)
-# error "Your arch does not support sched_setattr()"
-#endif
-
-#if !defined(__NR_sched_getattr)
-# error "Your arch does not support sched_getattr()"
-#endif
-
-/* If not included in the headers, define sched deadline policy numbe */
-#ifndef SCHED_DEADLINE
-#define SCHED_DEADLINE		6
-#endif
-
 #define _STR(x) #x
 #define STR(x) _STR(x)
 
@@ -140,45 +105,12 @@ static void usage(char **argv)
 
 /* Define the system call interfaces */
 #define gettid() syscall(__NR_gettid)
-#define sched_setattr(pid, attr, flags) syscall(__NR_sched_setattr, pid, attr, flags)
-#define sched_getattr(pid, attr, size, flags) syscall(__NR_sched_getattr, pid, attr, size, flags)
 
 typedef unsigned long long u64;
 typedef unsigned int u32;
 typedef int s32;
 
 /**
- * struct sched_attr - get/set attr system call descriptor.
- *
- * This is the descriptor defined for setting SCHED_DEADLINE tasks.
- * It will someday be in a header file.
- *
- * The fields specific for deadline:
- *
- *  @sched_policy: 6 is for deadline
- *  @sched_runtime: The runtime in nanoseconds
- *  @sched_deadline: The deadline in nanoseconds.
- *  @sched_period: The period, if different than deadline (not used here)
- */
-struct sched_attr {
-	u32 size;
-
-	u32 sched_policy;
-	u64 sched_flags;
-
-	/* SCHED_NORMAL, SCHED_BATCH */
-	s32 sched_nice;
-
-	/* SCHED_FIFO, SCHED_RR */
-	u32 sched_priority;
-
-	/* SCHED_DEADLINE */
-	u64 sched_runtime;
-	u64 sched_deadline;
-	u64 sched_period;
-};
-
-/**
  * struct sched_data - the descriptor for the threads.
  *
  * This is the descriptor that will be passed as the thread data.
-- 
2.11.0

