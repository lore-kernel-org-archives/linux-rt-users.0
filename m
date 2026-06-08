Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948203E00BC
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943666; cv=none; b=XYVN9Kc/fPyI+HgQxlt/npC2h8I6HDu3iALuWB7eWO+z79HzQHTqzfGWT3ii5g1tElsTvmFXIRlasOSDolqC3o6o3fXJfIdRRuz+Ro085+653f/TyAmz9ohCjmQ+wstnp+yO6a97emxrtrM5bBhaCuAw/ulm8ZlHdGFBGkJDrOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943666; c=relaxed/simple;
	bh=I6XWjBf9hRqYDjrFwVFy07Y8cSawhc/El7TrW91OPpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVVxZ9oXRm4fTSLku2kBg9MASGWX9Zw2DpfiEYGURoUEh9xRuTRhNbgv7q0NB191702Lz7fJV0cmB+QujNI7koqm44H7ykj2PjHe7vjCnDdHpjYfEYYFF93g+7Hu5tbzfGZSulZ9EjjhA2Lk33nzSlDSnJ+c81oiM7V6VXul6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RJc475oZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJc475oZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NV3rB2auYGAM6htGNJQ2jwVmwmuxU7GH0cHKYTxonpQ=;
	b=RJc475oZBhwclT8kAt33jC2O0FNcq3OvOs6mFGJzzBFywmHh7BzE1flrvHJy8TEbdQPB7i
	e/0PBylCOa2rY7i0UcZKtKPTEVQACrY+8KwNL4K1G8wHnqhKUMG3lcav9jaoR4teD9Gl6G
	NsnDcL8FMGqiZQtteFfPWtmPXr14XwI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-oPvV9lcCP7qfVSMoP29yWQ-1; Mon,
 08 Jun 2026 14:34:19 -0400
X-MC-Unique: oPvV9lcCP7qfVSMoP29yWQ-1
X-Mimecast-MFC-AGG-ID: oPvV9lcCP7qfVSMoP29yWQ_1780943659
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C42F71977032;
	Mon,  8 Jun 2026 18:34:18 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B799E36929;
	Mon,  8 Jun 2026 18:34:16 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 46/52] stalld: fix type mismatches in detect_task_format
Date: Mon,  8 Jun 2026 15:31:56 -0300
Message-ID: <20260608183206.140526-47-wander@redhat.com>
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

detect_task_format() uses int for variables that hold byte counts and
read() return values. bufincrement and size should be size_t since they
accumulate memory sizes derived from page_size, and status should be
ssize_t to match the return type of read(). The die() call for
allocation failure uses %d with no matching argument, causing undefined
behavior on the error path.

Switch the variables to their correct types, replace malloc() with
calloc() for overflow-safe multiplication, and supply the missing
format argument with the proper %zu specifier.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/sched_debug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/sched_debug.c b/src/sched_debug.c
index 25a11ce..5ddc331 100644
--- a/src/sched_debug.c
+++ b/src/sched_debug.c
@@ -193,22 +193,22 @@ static inline char *skip2word(char *ptr, int nwords)
  */
 static int detect_task_format(void)
 {
-	int bufincrement;
+	size_t bufincrement;
 	int retval = -1;
 	size_t bufsiz;
 	char *buffer;
-	int size = 0;
+	size_t size = 0;
 	char *ptr;
-	int status;
+	ssize_t status;
 	int fd;
 	int i, count=0;
 
 	bufsiz = bufincrement = BUFFER_PAGES * page_size;
 
-	buffer = malloc(bufsiz);
+	buffer = calloc(BUFFER_PAGES, page_size);
 
 	if (buffer == NULL)
-		die("unable to allocate %d bytes to read sched_debug");
+		die("unable to allocate %zu bytes to read sched_debug", bufsiz);
 
 	if ((fd = open(config_sched_debug_path, O_RDONLY)) < 0)
 		die("error opening sched_debug for reading: %s\n", strerror(errno));
-- 
2.54.0

