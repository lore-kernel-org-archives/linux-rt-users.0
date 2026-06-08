Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BC23E51E7
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943670; cv=none; b=Ez4u27ddTH9MLHzjJl8IIBOEN+t4nIcPt2DKK8FyPkl8TLlej5lfc6tQe5wie2wPKJiVyLMbK2O7EDnwj4Cc74Zh8d2aGd08st9fWNdCyFfUVVLrKtAmTIRnrmk0dA5VoqeLVbsbXy0/3/EkQdxfuX/cSv/+6HjFvZ2l5ET0Qyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943670; c=relaxed/simple;
	bh=u7M/azybyigGbq53zfhq6WlgMfQnZc1gIT6ziQ7+/ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIARxu72D6LXS0kVc9xncLXyDNjk+O7xpEwbvZEpBkQaynLeJjMMBQEE6p+e1jFyflu6VWSWF3suJvcPpLlBx+1431OP0VA0zv477pBMkXV/vIXH5ssqu50tQRCp1mb5UDSkemNh4KuBbSuMpn5IByI6kzJcs5eb6Z8o8GK1ezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Su7+08wV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Su7+08wV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pDmgIfbRhBb49vFlPJg9WvEMR2YtWfxkrPTBHObIyWY=;
	b=Su7+08wVQTASutIhDGlu4cV73kf1uMpsQoIqM/OPsyi8JHlIEdYq+U93ozHLaMj+fQ24NW
	DJc0w0SntdVHvaQTkYPsWBpXTk0exGT3bPjKej+y/wsEerktWhKNXyQy/JFxGSfuGFAAGI
	aMcQefiPxIhR+Qf90vLgxvecwREkNHg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-dCBdgassN6WJ8K3b7nz2Vg-1; Mon,
 08 Jun 2026 14:34:24 -0400
X-MC-Unique: dCBdgassN6WJ8K3b7nz2Vg-1
X-Mimecast-MFC-AGG-ID: dCBdgassN6WJ8K3b7nz2Vg_1780943663
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD2C41831357;
	Mon,  8 Jun 2026 18:34:23 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B5B3836927;
	Mon,  8 Jun 2026 18:34:21 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 48/52] stalld: guard nextline() returns in sched_debug parsing
Date: Mon,  8 Jun 2026 15:31:58 -0300
Message-ID: <20260608183206.140526-49-wander@redhat.com>
In-Reply-To: <20260608183206.140526-1-wander@redhat.com>
References: <20260608183206.140526-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

nextline() returns NULL when the input lacks a trailing newline,
which happens if sched_debug output is truncated. Both
detect_task_format() and parse_task_lines() pass the result directly
to string helpers that dereference it, causing a NULL pointer fault.

Add NULL checks after every nextline() call. In detect_task_format()
the daemon cannot function without a valid format, so it calls die().
In parse_task_lines() a truncated buffer simply means no more tasks
to parse, so the function returns the count collected so far. Also
remove the unreachable exit() after die() in the TASK_MARKER check.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/sched_debug.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/src/sched_debug.c b/src/sched_debug.c
index f481bb2..7d79255 100644
--- a/src/sched_debug.c
+++ b/src/sched_debug.c
@@ -233,13 +233,13 @@ static int detect_task_format(void)
 
 	/* find the delimiter for task information */
 	ptr = strstr(buffer, TASK_MARKER);
-	if (ptr == NULL) {
+	if (ptr == NULL)
 		die("unable to find 'runnable tasks' in buffer, invalid input\n");
-		exit(-1);
-	}
 
 	/* move to the column header line */
 	ptr = nextline(ptr);
+	if (!ptr)
+		die("invalid file format: %s\n", config_sched_debug_path);
 	i = 0;
 
 	/*
@@ -386,13 +386,20 @@ static int parse_task_lines(char *buffer, struct task_info *task_info, int nr_en
 	line = ptr;
 
 	/* skip "runnable tasks:" */
- 	line = nextline(line);
+	line = nextline(line);
+	if (!line)
+		return 0;
 
 	/* skip header lines */
 	line = nextline(line);
+	if (!line)
+		return 0;
 
 	/* skip divider line */
 	line = nextline(line);
+	if (!line)
+		return 0;
+
 	/* at this point, line should point to the start of a task line */
 
 	/* now loop over the task info
@@ -415,6 +422,8 @@ static int parse_task_lines(char *buffer, struct task_info *task_info, int nr_en
 			(*ptr == 'R')) {
 			/* Go to the end of the line and ignore this task. */
 			line = nextline(line);
+			if (!line)
+				return 0;
 			continue;
 		}
 
@@ -429,6 +438,8 @@ static int parse_task_lines(char *buffer, struct task_info *task_info, int nr_en
 		if (config_task_format == NEW_TASK_FORMAT) {
 			if (*ptr == '>' || (*ptr != 'R' && *ptr != 'X')) {
 				line = nextline(line);
+				if (!line)
+					return 0;
 				continue;
 			}
 		}
@@ -436,7 +447,7 @@ static int parse_task_lines(char *buffer, struct task_info *task_info, int nr_en
 		/*
 		 * At this point we have a task line to record
 		 */
-		
+
 		/* get the task field */
 		ptr = skip2word(line, config_task_format_offsets.task);
 
@@ -485,6 +496,8 @@ static int parse_task_lines(char *buffer, struct task_info *task_info, int nr_en
 
 		/* move our line pointer to the next availble line */
 		line = nextline(line);
+		if (!line)
+			return 0;
 	}
 	return tasks;
 }
-- 
2.54.0

