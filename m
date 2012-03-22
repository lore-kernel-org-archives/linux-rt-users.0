From: John Kacur <jkacur@redhat.com>
Subject: [PATCH rt-tests RFC 3/6] pi_stress: Check the status of sched_getaffinity
Date: Thu, 22 Mar 2012 02:14:03 +0100
Message-ID: <1332378846-18104-4-git-send-email-jkacur@redhat.com>
References: <1332378846-18104-1-git-send-email-jkacur@redhat.com>
Cc: Carsten Emde <C.Emde@osadl.org>,
	Darren Hart <dvhart@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nicholas McGuire <der.herr@hofr.at>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57769 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030510Ab2CVBPr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 21:15:47 -0400
Received: by wgbdr13 with SMTP id dr13so1014845wgb.1
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Mar 2012 18:15:46 -0700 (PDT)
In-Reply-To: <1332378846-18104-1-git-send-email-jkacur@redhat.com>
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

