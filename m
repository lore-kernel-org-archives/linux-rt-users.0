Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AEE306B02
	for <linux-rt-users@vger.kernel.org>; Fri, 16 Jan 2026 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768552688; cv=none; b=sgXe2cpoelYYMqMhRPBSfGnL7rfcAm50+8iSQfl0IX2Kck7lvdtg+kDlO8N31rDGnJL3w/YSdhkoVXenFrNAvE3lgbrCrcgkLow2qdln0iU7slEW4f8Qd5gX2Hc42DdWRKzxWDP7aDD3Wj6GvDtGTrSNO+ewxbP4sW/IQXd0R94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768552688; c=relaxed/simple;
	bh=lvIHXFFHUhdKTg8BHp62azwSjGzwhVeI1ynv3yGuVy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VR9SZ4gSbrvwxhLslVQy8PbxfynwC1DyHQAq+FC9qw2DTTfYYJqs85JyiyYpUhTXSAlBdRAjorzcThl4mE9Ymg9McvZJ2q/N1FN0X3aTubj5C8c8n6K+lID8mKWWVmBd1x/sMB7h+e9BKSoseNP9759kZEMghYp+7LKnWjalk+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gmIecQrK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmIecQrK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768552685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gMnGjFts1uIsAxKxKvee17RL2ecdmw+veG5wHjh1ua8=;
	b=gmIecQrKPfN64xvaYAG24EBcq2WkVskB+hYcy+c4ITem41SGtl0qLr7lbbGVDZXX4bbqdf
	M4ViZntDGIbydkiqJI/BZtKo0Vcfc+kMMLBW9wosJqgaZQb8CJvMHPUdh3YWe4C8iX8O4/
	72AbnL0FKWm7OeSQKXYx2FzUdJtyqZc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-sIuva9ljOaaE1EVx9Tr7uQ-1; Fri,
 16 Jan 2026 03:38:04 -0500
X-MC-Unique: sIuva9ljOaaE1EVx9Tr7uQ-1
X-Mimecast-MFC-AGG-ID: sIuva9ljOaaE1EVx9Tr7uQ_1768552683
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FE4B1956088
	for <linux-rt-users@vger.kernel.org>; Fri, 16 Jan 2026 08:38:03 +0000 (UTC)
Received: from intrepid (unknown [10.43.3.0])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E7CBA30002D6;
	Fri, 16 Jan 2026 08:38:01 +0000 (UTC)
From: Attila Fazekas <afazekas@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	debarbos@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Attila Fazekas <afazekas@redhat.com>
Subject: [PATCH] [ssdd] add ptrace tierdown for the tests
Date: Fri, 16 Jan 2026 03:37:36 -0500
Message-ID: <20260116083736.27032-1-afazekas@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Without tierdown the tracee can receive SIGTRAP
leading to multiple core dumps being created.
At higher concurrency you may also see

coredump: 11747(ssdd): over core_pipe_limit, skipping core dump

in the dmesg with
kernel.core_pattern = |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h %d %F
kernel.core_pipe_limit = 16

Signed-off-by: Attila Fazekas <afazekas@redhat.com>
---
 src/ssdd/ssdd.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
index 63130cd..61aab84 100644
--- a/src/ssdd/ssdd.c
+++ b/src/ssdd/ssdd.c
@@ -312,9 +312,23 @@ static int forktests(int testid)
 		got_sigchld = 0;
 	}
 
-	/* There is no need for the tracer to kill the tracee. It will
-	 * automatically exit when its owner, ie, us, exits.
+	/* The tracee can receive SIGTRAP(dump) without detaching.
 	 */
+	pstatus = ptrace(PTRACE_DETACH, child, NULL, NULL);
+	if (pstatus == ~0l) {
+		printf("forktest#%d/%d: EXITING, ERROR: "
+		       "detach failed.  errno %d\n",
+		       testid, getpid(), errno);
+		exit(1);
+	}
+	pstatus = kill(child, SIGKILL);
+	if (pstatus != 0) {
+		printf("forktest#%d/%d: EXITING, ERROR: "
+		       "kill failed.  errno %d\n",
+                       testid, getpid(), errno);
+		exit(1);
+	}
+
 	if (!quiet)
 		printf("forktest#%d/%d: EXITING, no error\n", testid, parent);
 	exit(0);
-- 
2.52.0

