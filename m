Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10271A2392
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305501; cv=none; b=lyi12co9s6M1TPVMa0RM33cDmMmqFu+Mi/YjJocvB3NIxFOVCbFOnOw6oS1RnuY4CvWKDxdbqvpNF0p9xnVJGBeY+PV6KmvOpIpqq7JjQRpFnp8DV8GLwWkZrhPOiRSYSw9IMOXCde38SSFPby8Ne1gbV1kP15FFf2fNbO3CQpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305501; c=relaxed/simple;
	bh=bJZqmAlsI/StIp/8wi9a5bDxqGXE3/4WQl2WzEAu8kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dQ89dpiY8i5C34cdINxcB4ucTKeINsMqVv1O2osLCkHSnTz5d1/au+7EQR9JXkpRHChlIHK9UKkzdAKfToos2R2i6H2GrbjJqX8mPaIymq6XWQ4DATRO39IiOkNYFCtGirIC7b7XmKyQ1nO8XmmRLv+WmJnaMnk/VkWV/Spg9tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cb9S1BAk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cb9S1BAk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758305498;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=N2io90qPz0nGEXOrBKtARSAk/zIPp9ZbwbkBCC9exLw=;
	b=cb9S1BAkSU9kd/lLLMlGPM7yCx4HjoTtvWKMQz4zwZze1SHerhem61bkbq2b+pQn4yunwZ
	h8BxNrBEV87GTKo67w1rxdGgT+JATshqQQtN4GEg1yEarQbaGJdH16ZC/Tju5dq7Y8/pk3
	n3PRt0AqwR6JfjlJr0sATE/zYSZWqh4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-Hn6ukKiMO02ZGi9WCYNEXg-1; Fri,
 19 Sep 2025 14:11:37 -0400
X-MC-Unique: Hn6ukKiMO02ZGi9WCYNEXg-1
X-Mimecast-MFC-AGG-ID: Hn6ukKiMO02ZGi9WCYNEXg_1758305496
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FF861800562
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 18:11:36 +0000 (UTC)
Received: from localhost (unknown [10.22.89.8])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9646319541B0;
	Fri, 19 Sep 2025 18:11:35 +0000 (UTC)
Date: Fri, 19 Sep 2025 14:11:34 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: williams@redhat.com, jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org, crwood@redhat.com, oleg@redhat.com, 
	shichen@redhat.com
Subject: [PATCH v3] ssdd: mitigate tracee starvation
Message-ID: <3yq34kwrfmwvhy5la5wutnmbdd6pf4rwnvnvnapegvx7acq7xu@pghcpahcvndz>
Reply-To: debarbos@redhat.com
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When ssdd is invoked with nforks > 100 && niters == 10000 on a tuned,
realtime kernel, the following error messages can be seen:

EXITING, ERROR: wait on PTRACE_SINGLESTEP #385: no SIGCHLD seen (signal count == 0), signo 5
EXITING, ERROR: wait on PTRACE_SINGLESTEP #398: no SIGCHLD seen (signal count == 0), signo 5
EXITING, ERROR: wait on PTRACE_SINGLESTEP #385: no SIGCHLD seen (signal count == 0), signo 5
...

This behavior is caused by ptrace_stop() being unable to sleep after
taking tasklist_lock().

As forktest() generates "niter" PTRACE_SINGLESTEP's for nforks, in the
rare event where nforks exceeds the defaults by a large order of
magnitude, the sporadic test failures caused by missing SIGCHLDs
indicates that the tracees are unable to effectively wait for their
asynchronous signals to arrive --as denoted in the previous sleeps for
check_sigchld().

Therefore, by performing an sigtimedwait() in check_sigchld(), we
give the tracee enough CPU time to call
do_notify_parent_cldstop()->send_signal_locked().

The observed behavior after appling this patch mitigates the
aforementioned issue in scenarios with a high number of nforks.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Derek Barbosa <debarbos@redhat.com>
---
V1 -> V2: Addressed review comments, removed usleep() in favor of
sigtimedwait().
V2 -> V3: Addressed checkpatch.pl complaints.

 src/ssdd/ssdd.c | 65 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 17 deletions(-)

diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
index 50f7424..63130cd 100644
--- a/src/ssdd/ssdd.c
+++ b/src/ssdd/ssdd.c
@@ -30,6 +30,7 @@
 #include <getopt.h>
 #include <string.h>
 #include <signal.h>
+#include <time.h>
 #include <errno.h>
 
 #include <sys/types.h>
@@ -67,7 +68,7 @@ static const char *get_state_name(int state)
 static int quiet;
 static char jsonfile[MAX_PATH];
 
-static int got_sigchld;
+volatile int got_sigchld;
 
 enum option_value { OPT_NFORKS=1, OPT_NITERS, OPT_HELP, OPT_JSON, OPT_QUIET };
 
@@ -127,23 +128,33 @@ static int do_wait(pid_t *wait_pid, int *ret_sig)
 	return STATE_UNKNOWN;
 }
 
-static int check_sigchld(void)
+static int check_sigchld(sigset_t *set)
 {
-	int i;
+
+	struct timespec timeout;
+
+	timeout.tv_sec = 10;
+	timeout.tv_nsec = 0;
+	int recv_sig = 0;
+
 	/*
-	 * The signal is asynchronous so give it some
-	 * time to arrive.
+	 * Check the handler flag, then if need be, wait for the signal to
+	 * arrive
 	 */
-	for (i = 0; i < 10 && !got_sigchld; i++)
-		usleep(1000); /* 10 msecs */
-	for (i = 0; i < 10 && !got_sigchld; i++)
-		usleep(2000); /* 20 + 10 = 30 msecs */
-	for (i = 0; i < 10 && !got_sigchld; i++)
-		usleep(4000); /* 40 + 30 = 70 msecs */
-	for (i = 0; i < 10 && !got_sigchld; i++)
-		usleep(8000); /* 80 + 70 = 150 msecs */
-	for (i = 0; i < 10 && !got_sigchld; i++)
-		usleep(16000); /* 160 + 150 = 310 msecs */
+	if (!got_sigchld)
+		recv_sig = sigtimedwait(set, NULL, &timeout);
+
+	if (sigprocmask(SIG_UNBLOCK, set, NULL) == -1) {
+		printf("EXITING, ERROR: unable to mask signal set\n");
+		exit(1);
+	}
+
+	if (recv_sig == -1) {
+		printf("EXITING, ERROR: Timeout: no signal received in 10 seconds\n");
+		exit(1);
+	} else if (recv_sig == SIGCHLD) {
+		got_sigchld = 1;
+	}
 
 	return got_sigchld;
 }
@@ -195,6 +206,20 @@ static int forktests(int testid)
 		exit(1);
 	}
 
+	/*
+	 * Block the signal before it is generated
+	 * Ensures we can synchronously wait for it.
+	 */
+	sigset_t set;
+
+	sigemptyset(&set);
+	sigaddset(&set, SIGCHLD);
+
+	if (sigprocmask(SIG_BLOCK, &set, NULL) == -1) {
+		printf("EXITING, ERROR: unable to mask signal set\n");
+		exit(1);
+	}
+
 	/*
 	 * Attach to the child.
 	 */
@@ -224,7 +249,7 @@ static int forktests(int testid)
 		       ret_sig);
 		exit(1);
 	}
-	if (!check_sigchld()) {
+	if (!check_sigchld(&set)) {
 		printf("forktest#%d/%d: EXITING, ERROR: "
 		       "wait on PTRACE_ATTACH saw a SIGCHLD count of %d, should be 1\n",
 		       testid, getpid(), got_sigchld);
@@ -238,6 +263,12 @@ static int forktests(int testid)
 	 * step the tracee.
 	 */
 	for (i = 0; i < nsteps; i++) {
+
+		if (sigprocmask(SIG_BLOCK, &set, NULL) == -1) {
+			printf("EXITING, ERROR: unable to mask signal set\n");
+			exit(1);
+		}
+
 		pstatus = ptrace(PTRACE_SINGLESTEP, child, NULL, NULL);
 
 		if (pstatus) {
@@ -271,7 +302,7 @@ static int forktests(int testid)
 			       testid, getpid(), i, ret_sig);
 			exit(1);
 		}
-		if (!check_sigchld()) {
+		if (!check_sigchld(&set)) {
 			printf("forktest#%d/%d: EXITING, ERROR: "
 			       "wait on PTRACE_SINGLESTEP #%d: no SIGCHLD seen "
 			       "(signal count == 0), signo %d\n",
-- 
2.50.0

