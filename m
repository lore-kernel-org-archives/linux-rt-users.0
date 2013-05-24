From: Gratian Crisan <gratian.crisan@ni.com>
Subject: spike in latency when calling popen() in the same process that runs a high
 priority RT thread
Date: Fri, 24 May 2013 11:14:49 -0500
Message-ID: <OF23979777.B356D29C-ON86257B75.0059025F-86257B75.00593F88@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailserver5.natinst.com ([130.164.80.5]:57705 "EHLO
	spamkiller05.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791Ab3EXQOs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 May 2013 12:14:48 -0400
Received: from mailserv59-us.natinst.com (nb-chan1-1338.natinst.com [130.164.19.134])
	by spamkiller05.natinst.com (8.14.5/8.14.5) with ESMTP id r4OGEmd4023186
	for <linux-rt-users@vger.kernel.org>; Fri, 24 May 2013 11:14:48 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are seeing a fairly big spike in latency for an RT thread when another 
regular thread in the same process calls popen().
I have modified cyclictest (see the patch below) to spawn another thread 
that just does popen() in a loop and run cyclictest with the following 
options:

./cyclictest -m -S --policy=fifo -p 98

Normally the max latency on our system is ~50uS. This is a dual core ARM 
Cortex-A9 running a 3.2.35-rt52 kernel. With this change it spikes over 
500uS.
This doesn't happen if the popen() test is run in a separate process 

We are looking for ideas on the root cause for this.

Thanks,
        Gratian

>From c673b5be21686c92a4c94a60f465fe889d0978e3 Mon Sep 17 00:00:00 2001
From: Gratian Crisan <gratian.crisan@ni.com>
Date: Thu, 23 May 2013 17:22:05 -0500
Subject: [PATCH] Test for tracing popen() latency

This test adds a regular priority thread to cyclic test in order
to track down a latency exibited when using popen() in the same
process that runs a high priority RT thread (cyclic test in this
case)

Signed-off-by: Gratian Crisan <gratian.crisan@ni.com>
---
 src/cyclictest/cyclictest.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index abf3e8b..423b0d5 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -930,6 +930,25 @@ out:
        return NULL;
 }
 
+void *popen_test(void *param)
+{
+       struct sched_param schedp;
+       FILE *fp = NULL;
+
+       schedp.sched_priority = 0;
+       sched_setscheduler(0, SCHED_OTHER, &schedp);
+
+       while (!shutdown) {
+               fp = popen("echo hello > /tmp/test", "r");
+               if (!fp) {
+                       perror("popen failed");
+                       break;
+               }
+               pclose(fp);
+       }
+       printf("# popen() test thread: %ld\n", gettid());
+       return NULL;
+}
 
 /* Print usage information */
 static void display_help(int error)
@@ -1511,6 +1530,8 @@ int main(int argc, char **argv)
        int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
        int i, ret = -1;
        int status;
+       pthread_t popen_thread;
+       pthread_attr_t popen_attr;
 
        process_options(argc, argv);
 
@@ -1759,6 +1780,14 @@ int main(int argc, char **argv)
 
        }
 
+       status = pthread_attr_init(&popen_attr);
+       if (status != 0)
+               fatal("error from pthread_attr_init for popen test thread 
%s\n", strerror(status));
+
+       status = pthread_create(&popen_thread, &popen_attr, popen_test, 
NULL);
+       if (status)
+               fatal("failed to create popen test thread %s\n", 
strerror(status));
+
        while (!shutdown) {
                char lavg[256];
                int fd, len, allstopped = 0;
-- 
1.7.10.4

