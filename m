From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] cyclictest: fix #ifdef broken by NO_PTHREAD_SETAFFINITY
Date: Wed, 21 Oct 2015 18:34:48 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510211833500.6297@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	Henrik Austad <haustad@cisco.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33611 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbbJUQe7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Oct 2015 12:34:59 -0400
Received: by wijp11 with SMTP id p11so103635117wij.0
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Oct 2015 09:34:57 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 73bc7345eebb2244efc527928fdac7b8e29193cd Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Wed, 21 Oct 2015 18:25:37 +0200
Subject: [PATCH] cyclictest: fix #ifdef broken by NO_PTHREAD_SETAFFINITY

Unfortunately c869f3cdcd023eec2f767eb4094caa88178717a4 wasn't sufficient
to fix #ifdef #else functionality for uclib, broken by the changes for
bionic.

In practice this probably didn't break anyone though, except possibly
for the new bionic code which probaly doesn't have too many adapters
(yet).

This should also help Henrik move the NO_PTHREAD_SETAFFINITY functionality to
the bionic file.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 00168e22fc7f..975e7858fb8e 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -83,6 +83,10 @@ int sched_setaffinity (__pid_t __pid, size_t __cpusetsize,
 #define CPU_SET(cpu, cpusetp)
 #define CPU_ZERO(cpusetp)
 
+#else
+extern int clock_nanosleep(clockid_t __clock_id, int __flags,
+			   __const struct timespec *__req,
+			   struct timespec *__rem);
 #endif
 
 #ifdef NO_PTHREAD_SETAFFINITY
@@ -91,11 +95,6 @@ static inline int pthread_setaffinity_np(pthread_t thread, size_t cpusetsize,
 {
     return sched_setaffinity(0, cpusetsize, cpuset);
 }
