Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FE021FF55
	for <linux-rt-users@vger.kernel.org>; Wed, 27 Aug 2025 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756316019; cv=none; b=Bbqs2SI+5Ycuytf4uA2yonNK8SIUJqqcVitupW2TPHuflGDhI3w+FWL6J6pFls3V13s2RZ0lfARbf9f9UyDlvqY+ModHadfzreuiF7YoQaOBriAzTiW0JvsYW94jiCRMFphiru2OvF2TFnNTKT3uU3PMD/8DYxyBo7EmdGBxsPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756316019; c=relaxed/simple;
	bh=PVs+IM1MVAKRZqPyhiUxEfM9XGRZ3VlretXDrboqkkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DFDYu9bTkFInn7qAHcQkOOwfDG7OCY6gVsy4WyfGr3Z1gP2110xtFRLLu39t6g+qa0gMQioNlix1Uabt5ukIIzpXm8r1a1Q6ovZC3BdF9hbHZ4krUZjRTWv75A3hXejFGvl1V9WeFQ1ZvMqyhOd4OdSz/dc4rEPVpBxIFJDVn70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQ4EjwuS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQ4EjwuS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756316015;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=bHGqlPEaLullJ119D4tGDm9KbXfTUxZY+l3ci4JRAiQ=;
	b=aQ4EjwuSpsK1Y94U+WX0ko2VW0M8XjACyfBAHMq1GNpzva6UwjnvvALnZrLfL/NzN5J1A2
	MUQ2bRaGwWIbEYTMEf4yQEjyJu7kmNg+vXXfzxRXGviP/I5l/jwORUEyb8q7QiKWFa1hVY
	vaErppINwJf8a6SjAR8jpbVzQLwAaIQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-L-6hpLrvOjCrCAp-T-tB5g-1; Wed,
 27 Aug 2025 13:33:34 -0400
X-MC-Unique: L-6hpLrvOjCrCAp-T-tB5g-1
X-Mimecast-MFC-AGG-ID: L-6hpLrvOjCrCAp-T-tB5g_1756316013
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CAAA19560A2
	for <linux-rt-users@vger.kernel.org>; Wed, 27 Aug 2025 17:33:33 +0000 (UTC)
Received: from localhost (unknown [10.22.81.106])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 657E1180028B;
	Wed, 27 Aug 2025 17:33:32 +0000 (UTC)
Date: Wed, 27 Aug 2025 13:33:31 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: williams@redhat.com, jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org, crwood@redhat.com, oleg@redhat.com, 
	shichen@redhat.com
Subject: [PATCH V2] ssdd: mitigate tracee starvation
Message-ID: <io62jswvggk4khvbknhvo5wisdpccyn3vjppbauwesvmt7kks3@gdffjm3gnuku>
Reply-To: debarbos@redhat.com
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When ssdd is invoked with nforks > 100 && niters == 10000 on a tuned,
realtime kernel, the following error messages can be seen:

forktest#4/8719: EXITING, ERROR: wait on PTRACE_SINGLESTEP #385: no SIGCHLD seen (signal count == 0), signo 5
forktest#1/8716: EXITING, ERROR: wait on PTRACE_SINGLESTEP #398: no SIGCHLD seen (signal count == 0), signo 5
forktest#6/8721: EXITING, ERROR: wait on PTRACE_SINGLESTEP #385: no SIGCHLD seen (signal count == 0), signo 5
forktest#10/8725: EXITING, ERROR: wait on PTRACE_SINGLESTEP #388: no SIGCHLD seen (signal count == 0), signo 5
forktest#11/8726: EXITING, ERROR: wait on PTRACE_SINGLESTEP #388: no SIGCHLD seen (signal count == 0), signo 5
forktest#12/8727: EXITING, ERROR: wait on PTRACE_SINGLESTEP #389: no SIGCHLD seen (signal count == 0), signo 5
forktest#14/8729: EXITING, ERROR: wait on PTRACE_SINGLESTEP #389: no SIGCHLD seen (signal count == 0), signo 5
forktest#15/8730: EXITING, ERROR: wait on PTRACE_SINGLESTEP #389: no SIGCHLD seen (signal count == 0), signo 5

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

 src/ssdd/ssdd.c | 72 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 19 deletions(-)

diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
index 50f7424..0089678 100644
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
 
@@ -127,24 +128,36 @@ static int do_wait(pid_t *wait_pid, int *ret_sig)
 	return STATE_UNKNOWN;
 }
 
-static int check_sigchld(void)
+static int check_sigchld(sigset_t* set)
 {
-	int i;
-	/*
-	 * The signal is asynchronous so give it some
-	 * time to arrive.
-	 */
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
 
+	struct timespec timeout;
+	timeout.tv_sec = 10;
+	timeout.tv_nsec = 0;
+	int recv_sig = 0;
+
+        /*
+         * Check the handler flag, then if need be, wait for the signal to
+         * arrive
+         */
+        if(!got_sigchld) {
+		recv_sig = sigtimedwait(set, NULL, &timeout);
+	}
+
+	if(sigprocmask(SIG_UNBLOCK, set, NULL) == -1){
+		printf("EXITING, ERROR: "
+		       "unable to mask signal set\n");
+		exit(1);
+	}
+
+	if (recv_sig == -1){
+		printf("EXITING, ERROR: "
+		       "Timeout: no signal recieved in 10 seconds\n");
+		exit(1);
+	} else if (recv_sig == SIGCHLD){
+		got_sigchld = 1;
+	}
+	
 	return got_sigchld;
 }
 
@@ -195,6 +208,20 @@ static int forktests(int testid)
 		exit(1);
 	}
 
+	/*
+	 * Block the signal before it is generated
+	 * Ensures we can synchronously wait for it.
+	 */
+	sigset_t set;
+	sigemptyset(&set);
+	sigaddset(&set, SIGCHLD);
+
+	if (sigprocmask(SIG_BLOCK, &set, NULL) == -1){
+		printf("EXITING, ERROR: "
+		       "unable to mask signal set\n");
+		exit(1);
+	}
+
 	/*
 	 * Attach to the child.
 	 */
@@ -224,7 +251,7 @@ static int forktests(int testid)
 		       ret_sig);
 		exit(1);
 	}
-	if (!check_sigchld()) {
+	if (!check_sigchld(&set)) {
 		printf("forktest#%d/%d: EXITING, ERROR: "
 		       "wait on PTRACE_ATTACH saw a SIGCHLD count of %d, should be 1\n",
 		       testid, getpid(), got_sigchld);
@@ -238,6 +265,13 @@ static int forktests(int testid)
 	 * step the tracee.
 	 */
 	for (i = 0; i < nsteps; i++) {
+
+		if (sigprocmask(SIG_BLOCK, &set, NULL) == -1){
+			printf("EXITING, ERROR: "
+			       "unable to mask signal set\n");
+			exit(1);
+		}
+
 		pstatus = ptrace(PTRACE_SINGLESTEP, child, NULL, NULL);
 
 		if (pstatus) {
@@ -271,7 +305,7 @@ static int forktests(int testid)
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

