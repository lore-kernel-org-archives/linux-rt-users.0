From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 2/4] signaltest: properly test return value from system()
Date: Tue,  6 Oct 2015 11:08:21 +0200
Message-ID: <1444122503-8112-2-git-send-email-haustad@cisco.com>
References: <1444122503-8112-1-git-send-email-haustad@cisco.com>
Cc: Henrik Austad <haustad@cisco.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alln-iport-3.cisco.com ([173.37.142.90]:20562 "EHLO
	alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbbJFJLa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Oct 2015 05:11:30 -0400
In-Reply-To: <1444122503-8112-1-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

signaltest writes to several /proc/sys/kernel attributes without testing
if the system() call succeeds or not. We expect the writes from echo to
suceed (i.e. yield '0' in return), so we test explicitly for that.

Signed-off-by: Henrik Austad <haustad@cisco.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
---
 src/signaltest/signaltest.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index b80969b..8074b68 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -65,6 +65,11 @@ struct thread_stat {
 	int threadstarted;
 	int tid;
 };
+#define SYSTEM_W(x)				\
+	if (system((x)) != 0) {			\
+		fprintf(stderr, "Trouble running %s\n", (x));	\
+		return NULL;					\
+	}							\
 
 static int shutdown;
 static int tracelimit = 0;
@@ -102,16 +107,16 @@ void *signalthread(void *param)
 	int first = 1;
 
 	if (tracelimit) {
-		system("echo 1 > /proc/sys/kernel/trace_all_cpus");
-		system("echo 1 > /proc/sys/kernel/trace_enabled");
-		system("echo 1 > /proc/sys/kernel/trace_freerunning");
-		system("echo 0 > /proc/sys/kernel/trace_print_at_crash");
-		system("echo 1 > /proc/sys/kernel/trace_user_triggered");
-		system("echo -1 > /proc/sys/kernel/trace_user_trigger_irq");
-		system("echo 0 > /proc/sys/kernel/trace_verbose");
-		system("echo 0 > /proc/sys/kernel/preempt_thresh");
-		system("echo 0 > /proc/sys/kernel/wakeup_timing");
-		system("echo 0 > /proc/sys/kernel/preempt_max_latency");
+		SYSTEM_W("echo 1 > /proc/sys/kernel/trace_all_cpus");
+		SYSTEM_W("echo 1 > /proc/sys/kernel/trace_enabled");
+		SYSTEM_W("echo 1 > /proc/sys/kernel/trace_freerunning");
+		SYSTEM_W("echo 0 > /proc/sys/kernel/trace_print_at_crash");
+		SYSTEM_W("echo 1 > /proc/sys/kernel/trace_user_triggered");
+		SYSTEM_W("echo -1 > /proc/sys/kernel/trace_user_trigger_irq");
+		SYSTEM_W("echo 0 > /proc/sys/kernel/trace_verbose");
+		SYSTEM_W("echo 0 > /proc/sys/kernel/preempt_thresh");
+		SYSTEM_W("echo 0 > /proc/sys/kernel/wakeup_timing");
+		SYSTEM_W("echo 0 > /proc/sys/kernel/preempt_max_latency");
 	}
 
 	stat->tid = gettid();
-- 
1.9.1

