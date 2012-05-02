From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH 2/4] rt-tests: cyclictest segfault with '-a'
Date: Tue, 1 May 2012 19:44:17 -0700
Message-ID: <4FA09F81.3000506@am.sony.com>
References: <4FA09D6A.2050101@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "jkacur@redhat.com" <jkacur@redhat.com>,
	"dvhart@linux.intel.com" <dvhart@linux.intel.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"williams@redhat.com" <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:33673
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757388Ab2EBCol (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 May 2012 22:44:41 -0400
In-Reply-To: <4FA09D6A.2050101@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This fixes a segfault on ARM when the '-a' option is used.

man sched_setaffinity says to use pthread_setaffinity_np() when using the
POSIX threads API.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 src/cyclictest/cyclictest.c |    4 	3 +	1 -	0 !
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: b/src/cyclictest/cyclictest.c
===================================================================
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -612,6 +612,7 @@ void *timerthread(void *param)
 	struct thread_stat *stat = par->stats;
 	int stopped = 0;
 	cpu_set_t mask;
+	pthread_t thread;
 
 	/* if we're running in numa mode, set our memory node */
 	if (par->node != -1)
@@ -620,7 +621,8 @@ void *timerthread(void *param)
 	if (par->cpu != -1) {
 		CPU_ZERO(&mask);
 		CPU_SET(par->cpu, &mask);
-		if(sched_setaffinity(0, sizeof(mask), &mask) == -1)
+		thread = pthread_self();
+		if(pthread_setaffinity_np(thread, sizeof(mask), &mask) == -1)
 			warn("Could not set CPU affinity to CPU #%d\n", par->cpu);
 	}
 

