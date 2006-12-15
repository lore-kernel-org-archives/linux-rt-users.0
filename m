From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Fix of problem in cyclictest-v0.11
Date: Fri, 15 Dec 2006 21:24:53 +0100
Message-ID: <200612152124.54387.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from av4.karneval.cz ([81.27.192.11]:45511 "EHLO av2.karneval.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964825AbWLOUwI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Dec 2006 15:52:08 -0500
To: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Thomas and others,

there is bug in cyclictest-v0.11 which prevents it to corectly
wait for finishing of all threads.
The allstopped is signaled even if only one thread reaches
maximal count. The result is different loops count
for lower priority threads.

Best wishes

                Pavel Pisa
        e-mail: pisa@cmp.felk.cvut.cz
        www:    http://cmp.felk.cvut.cz/~pisa
        work:   http://www.pikron.com


--- cyclictest.c.orig	2006-12-15 21:04:16.000000000 +0100
+++ cyclictest.c	2006-12-15 21:23:19.000000000 +0100
@@ -480,7 +480,7 @@
 
 	while (!shutdown) {
 		char lavg[256];
-		int fd, len, allstopped = 0;
+		int fd, len, allstopped;
 
 		if (!verbose && !quiet) {
 			fd = open("/proc/loadavg", O_RDONLY, 0666);
@@ -490,11 +490,13 @@
 			printf("%s          \n\n", lavg);
 		}
 
+		allstopped = max_cycles ? 1 : 0;
+
 		for (i = 0; i < num_threads; i++) {
 
 			print_stat(&par[i], i, verbose);
-			if(max_cycles && stat[i].cycles >= max_cycles)
-				allstopped++;
+			if(stat[i].cycles < max_cycles)
+				allstopped = 0;
 		}
 		usleep(10000);
 		if (shutdown || allstopped)
