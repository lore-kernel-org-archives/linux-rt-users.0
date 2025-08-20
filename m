Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3457322A30
	for <linux-rt-users@vger.kernel.org>; Wed, 20 Aug 2025 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706707; cv=none; b=KzzIhUID3MjhIN6FfE6MUKNq+PK0tRavFsWhKLngUtzWYS8MNPnC5oQuF2kGnPnZx+gfCK2f7/yGNZNrFCnuKgfCWFRZd9+4A2mxp8xXZu/T8hLWhjYoBB1E9bSzwWY/sIHAMiu+QzKIw15m4G3wlsqy33Gm831sVKAOB9wuxYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706707; c=relaxed/simple;
	bh=2M3GBFaRe0biSGosasF1XQPuuB0Su0l5FwhdDCOyY6o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XgCZlx7u7Tx74g+TK1xYVqIb9myptmf4HQk5UXmOP3MirlMuIQzrpBZEw7R++PVzxyLNBXNej8JkRow3uSR1UJRlf3PWr34sq0sYwp7TAuJAzGzNErhAlEW68CVRoKZXHD/7/6ZU4UGIwGzowtiz5ZskdS1JBzz8EObhKWZkD4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZ/6BY1i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZ/6BY1i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755706704;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=+lbz0YupMVvrNrX/YcsMAFjqYwsJBBXdb5v0klucEoY=;
	b=JZ/6BY1iTYBrS+Qyn7mGUzULFCcJxszV2mLJhUJRANteaVyxJKlJyPWXTNWUPU3QnBJGTJ
	4jPzSvkUno/82M9FcLzPHo2g3WFS7b1YYYs57RLaUNso6Mrx4gMIqDHhu/VlOSvIwJz5RQ
	zWHGJ5YWsEjsVwy6pWRTCuT1pkPeuIw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-ngOhNavlPuG33hUFAiEn8A-1; Wed,
 20 Aug 2025 12:18:23 -0400
X-MC-Unique: ngOhNavlPuG33hUFAiEn8A-1
X-Mimecast-MFC-AGG-ID: ngOhNavlPuG33hUFAiEn8A_1755706702
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B8DD1955D69
	for <linux-rt-users@vger.kernel.org>; Wed, 20 Aug 2025 16:18:22 +0000 (UTC)
Received: from localhost (unknown [10.22.88.234])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A16171800447;
	Wed, 20 Aug 2025 16:18:21 +0000 (UTC)
Date: Wed, 20 Aug 2025 12:18:20 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: williams@redhat.com, jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org, oleg@redhat.com, shichen@redhat.com
Subject: [PATCH] ssdd: mitigate tracee starvation
Message-ID: <wljofbc7n4h6pav3tnvjgl6if7mdkkwep3uvja3etew2dyptbx@tyxiungtvg4r>
Reply-To: debarbos@redhat.com
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

This behavior is caused by ptrace_stop() being unable to sleep after taking
tasklist_lock().

As forktest() generates "niter" PTRACE_SINGLESTEP's for nforks, in the event
where nforks >= 100, the sporadic test failures caused by missing SIGCHLDs
indicates that the tracees are unable to effectively wait for their asynchronous
signals to arrive --as denoted in the previous sleeps for check_sigchld().

Therefore, by performing an addtional sleep() in check_sigchld(), we give the
tracee enough CPU time to call do_notify_parent_cldstop()->send_signal_locked().

The observed behavior after appling this patch mitigates the aforementioned
issue in scenarios with a high number of nforks.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Derek Barbosa <debarbos@redhat.com>
---
 src/ssdd/ssdd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
index 50f7424..7fdb039 100644
--- a/src/ssdd/ssdd.c
+++ b/src/ssdd/ssdd.c
@@ -145,6 +145,15 @@ static int check_sigchld(void)
 	for (i = 0; i < 10 && !got_sigchld; i++)
 		usleep(16000); /* 160 + 150 = 310 msecs */
 
+        /*
+         * In the _worst case scenario_ where the signal still
+         * has not arrived: the tracee is starved or
+	 * preempted, and needs more CPU time.
+         */
+        if(!got_sigchld){
+		sleep(1);
+	}
+
 	return got_sigchld;
 }
 
-- 
2.50.0

