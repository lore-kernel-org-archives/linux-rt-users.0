From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests / cyclictest: Make cyclictest fail if it cannot run with requested priority.
Date: Wed,  9 May 2012 16:03:03 +0200
Message-ID: <1336572183-6889-1-git-send-email-jkacur@redhat.com>
Cc: Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Nicholas Mc Guire <der.herr@hofr.at>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56652 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727Ab2EIODf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 May 2012 10:03:35 -0400
Received: by bkcji2 with SMTP id ji2so308555bkc.19
        for <linux-rt-users@vger.kernel.org>; Wed, 09 May 2012 07:03:34 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Currently if a non-root user requests a priority higher than the soft limit in
/etc/security/limits.conf
the call to sched_setscheduler will silently fail and the user will be running
with priority of 0. Cyclictest will not complain, and display the
requested priority resulting in seemingly poor results.

The following patch fixes this by doing two things.

1. If the requested priority is higher than the soft limit but lower than the
hard limit, it will raise the soft limit to the requested priority.

2. If the requested priority is higher than the hard limit, it will fail with a
warning.

The patch should not affect privileged users.

Reported-by: Nicholas Mc Guire <der.herr@hofr.at>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c |   80 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 79 insertions(+), 1 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index e8649c7..c44df6a 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -12,6 +12,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+
 #include <stdint.h>
 #include <stdarg.h>
 #include <unistd.h>
@@ -31,6 +32,7 @@
 #include <sys/sysinfo.h>
 #include <sys/types.h>
 #include <sys/time.h>
+#include <sys/resource.h>
 #include <sys/utsname.h>
 #include <sys/mman.h>
 #include "rt_numa.h"
@@ -586,6 +588,79 @@ parse_time_string(char *val)
 }
 
 /*
+ * Raise the soft priority limit up to prio, if that is less than or equal
+ * to the hard limit
+ * if a call fails, return the error
+ * if successful return 0
+ * if fails, return -1
+*/
+static int raise_soft_prio(int policy, const struct sched_param *param)
+{
+	int err;
+	int policy_max;	/* max for scheduling policy such as SCHED_FIFO */
+	int soft_max;
+	int hard_max;
+	int prio;
+	struct rlimit rlim;
+
+	prio = param->sched_priority;
+
+	policy_max = sched_get_priority_max(policy);
+	if (policy_max == -1) {
+		err = errno;
+		err_msg("WARN: no such policy\n");
+		return err;
+	}
+
+	err = getrlimit(RLIMIT_RTPRIO, &rlim);
+	if (err) {
+		err = errno;
+		err_msg_n(err, "WARN: getrlimit failed\n");
+		return err;
+	}
+
+	soft_max = (rlim.rlim_cur == RLIM_INFINITY) ? policy_max : rlim.rlim_cur;
+	hard_max = (rlim.rlim_max == RLIM_INFINITY) ? policy_max : rlim.rlim_max;
+
+	if (prio > soft_max && prio <= hard_max) {
+		rlim.rlim_cur = prio;
+		err = setrlimit(RLIMIT_RTPRIO, &rlim);
+		if (err) {
+			err = errno;
+			err_msg_n(err, "WARN: setrlimit failed\n");
+			/* return err; */
+		}
+	} else {
+		err = -1;
+	}
+
+	return err;
+}
+
+/*
+ * Check the error status of sched_setscheduler
+ * If an error can be corrected by raising the soft limit priority to
+ * a priority less than or equal to the hard limit, then do so.
+ */
+static int setscheduler(pid_t pid, int policy, const struct sched_param *param)
+{
+	int err = 0;
+
+try_again:
+	err = sched_setscheduler(pid, policy, param);
+	if (err) {
+		err = errno;
+		if (err == EPERM) {
+			int err1;
+			err1 = raise_soft_prio(policy, param);
+			if (!err1) goto try_again;
+		}
+	}
+
+	return err;
+}
+
+/*
  * timer thread
  *
  * Modes:
@@ -599,6 +674,7 @@ parse_time_string(char *val)
  */
 void *timerthread(void *param)
 {
+	int err;
 	struct thread_param *par = param;
 	struct sched_param schedp;
 	struct sigevent sigev;
@@ -643,7 +719,9 @@ void *timerthread(void *param)
 
 	memset(&schedp, 0, sizeof(schedp));
 	schedp.sched_priority = par->prio;
-	sched_setscheduler(0, par->policy, &schedp);
+	err = setscheduler(0, par->policy, &schedp);
+	if (err)
+		fatal("Couldn't raise priority to %d\n", schedp.sched_priority);
 
 	/* Get current time */
 	clock_gettime(par->clock, &now);
-- 
1.7.7.6

