From: Remy Bohmer <linux@bohmer.net>
Subject: [PATCH 3.0.4-rt13] Fix build on UP ARM core
Date: Sun, 11 Sep 2011 11:12:57 +0200
Message-ID: <1315732377-30568-1-git-send-email-linux@bohmer.net>
Cc: Remy Bohmer <linux@bohmer.net>
To: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37553 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319Ab1IKJNN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 11 Sep 2011 05:13:13 -0400
Received: by eyx24 with SMTP id 24so1980757eyx.19
        for <linux-rt-users@vger.kernel.org>; Sun, 11 Sep 2011 02:13:11 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

It fixes this error:
In file included from kernel/sched.c:2041:0:
kernel/sched_debug.c: In function 'print_rt_rq':
kernel/sched_debug.c:238:83: error: 'struct rt_rq' has no member named 'rt_nr_migratory'
kernel/sched_debug.c:238:171: error: 'struct rt_rq' has no member named 'rt_nr_migratory'
make[2]: *** [kernel/sched.o] Error 1

Signed-off-by: Remy Bohmer <linux@bohmer.net>
---
 kernel/sched_debug.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kernel/sched_debug.c b/kernel/sched_debug.c
index e68cf7f..528032b 100644
--- a/kernel/sched_debug.c
+++ b/kernel/sched_debug.c
@@ -235,7 +235,9 @@ void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq)
 	P(rt_throttled);
 	PN(rt_time);
 	PN(rt_runtime);
+#ifdef CONFIG_SMP
 	P(rt_nr_migratory);
+#endif
 
 #undef PN
 #undef P
-- 
1.7.4.1

