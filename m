From: John Kacur <jkacur@redhat.com>
Subject: [PATCH rt-tests] pi_stress: Check the status of sched_getaffinity
Date: Wed, 21 Mar 2012 23:17:53 +0100
Message-ID: <1332368273-6343-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
To: Darren Hart <dvhltc@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	=rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:47954 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964935Ab2CUWSw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 18:18:52 -0400
Received: by wibhj6 with SMTP id hj6so12668wib.1
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Mar 2012 15:18:51 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Check the status of sched_getaffinity and exit upon error.

CPU_ISSET only checks whether a cpu is in a mask, and not whether the
mask is valid. Checking the status ensures we aren't working with garbage
values.

This also removes the warning from gcc about the status variable being unused
as reported by Darren Hart.

Reported-by: Darren Hart <dvhart@linux.intel.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 0940567..e273d62 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -597,9 +597,17 @@ void *reporter(void *arg)
 int verify_cpu(int cpu)
 {
 	int status;
+	int err;
 	cpu_set_t mask;
 
+	CPU_ZERO(&mask);
+
 	status = sched_getaffinity(0, sizeof(cpu_set_t), &mask);
+	if (status == -1) {
+		err = errno;
+		fprintf(stderr, "sched_getaffinity %s\n", strerror(err));
+		exit(-1);
+	}
 
 	if (CPU_ISSET(cpu, &mask))
 		return SUCCESS;
-- 
1.7.7.6

