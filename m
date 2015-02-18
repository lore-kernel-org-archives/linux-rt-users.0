From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH] pi_stress: Clear affinity for DEADLINE tasks
Date: Wed, 18 Feb 2015 09:55:13 +0100
Message-ID: <1424249713-2615-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: linux-rt-users@vger.kernel.org, jkacur@redhat.com,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: williams@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:53377 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751010AbbBRJEf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Feb 2015 04:04:35 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Deadline tasks are not allowed to set smp affinity.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---

Hi Clark,

I missed that one because I tested it only on a UP. Sorry about that.

cheers,
daniel

src/pi_tests/pi_stress.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index cf55712..aaa36c3 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -882,8 +882,21 @@ void *high_priority(void *arg)
 	pthread_barrier_t *loop_barr = &p->loop_barr;
 	pthread_mutex_t *loop_mtx = &p->loop_mtx;
 	int *loop = &p->loop;
+	cpu_set_t cpu_mask;
+	int i;
 
 	if (high_sa.sched_policy == SCHED_DEADLINE) {
+		CPU_ZERO(&cpu_mask);
+		for (i = 0; i < num_processors; i++)
+			CPU_SET(i, &cpu_mask);
+		status = sched_setaffinity(0, sizeof(cpu_set_t), &cpu_mask);
+		if (status < 0) {
+			pi_error
+			    ("high_priority[%d]: set cpu affinity*dl): %x\n",
+			    p->id, status);
+			return NULL;
+		}
+
 		status = sched_setattr(gettid(), &high_sa, 0);
 		if (status < 0) {
 			pi_error
-- 
2.1.0

