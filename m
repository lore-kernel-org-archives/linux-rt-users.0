Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D8C3563D4
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943672; cv=none; b=hHb0NO52eIFzOoVJ9x+HAlYOWXRHuhPyWmlwPEIc97cGbckDfoQmXxyP5NaF3Ke53RPAxxfpHpztSyOSG9E8+DCqGYNDGiKoYSAib4h35rKKaToaVJDCe++2oHce+SpQFZtRzEc/Z2JzLPaJiOaRh0wzU9uVbHyhzYrV81dNDsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943672; c=relaxed/simple;
	bh=SyQPcVoqDqzF69jJkSyWkAjrVvBq2A8lMDVLy1BP4zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTWT/+kpVi6vLs51fDxN0aiBmrNhAs2XBIHlDQJNgpoVfUNt4Hgm5xLOchfrr7NHx4fhNn7cDWokyK8/exBQ+KRJSHz9cZILYCNyh0WGq9Rf95Aw8S60D/TmnFaUk2QEa1RvzTHhDk0vsl16VefpqBtL3E9aAtGxTyZ63b7SK3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVslGmze; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVslGmze"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qNO5psd77lUGs7v3PWRLXNxUcClGdNIurtd4Soqtl28=;
	b=aVslGmzeNbN3/mc4mrBIquRCZbd7q0xd6Ogn3ucNgj2/M1/aHgjHPvcoJCoOR1G+6ZR7r7
	UOfpecuqWPEV1aeOWdYYkwHq92Hj2zQzaJkpgHWGXOadfJsCPFsma0k87LQVNtuel7cLL2
	RwmvBd8WgSsEvQf+npfOcc2fiFGmAso=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-FCnEZfINMzGdP1n4baouxw-1; Mon,
 08 Jun 2026 14:34:27 -0400
X-MC-Unique: FCnEZfINMzGdP1n4baouxw-1
X-Mimecast-MFC-AGG-ID: FCnEZfINMzGdP1n4baouxw_1780943666
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59EBC18417D3;
	Mon,  8 Jun 2026 18:34:26 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3366A36927;
	Mon,  8 Jun 2026 18:34:23 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 49/52] stalld: fix missing null-termination in is_runnable
Date: Mon,  8 Jun 2026 15:31:59 -0300
Message-ID: <20260608183206.140526-50-wander@redhat.com>
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

is_runnable() reads /proc/PID/stat into a fixed-size buffer using the
full buffer length. If read() returns exactly sizeof(stat) bytes the
conditional null-termination is skipped, leaving the buffer without a
terminator. The subsequent skipchars() and skipspaces() calls then
read past the array bounds.

Reduce the read length by one byte to guarantee space for the
terminator and null-terminate unconditionally.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/sched_debug.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/sched_debug.c b/src/sched_debug.c
index 7d79255..d5fbf6d 100644
--- a/src/sched_debug.c
+++ b/src/sched_debug.c
@@ -319,13 +319,12 @@ static int is_runnable(int pid)
 		goto out_error;
 	}
 	flock(fd, LOCK_SH);
-	retval = read(fd, &stat, sizeof(stat));
+	retval = read(fd, &stat, sizeof(stat) - sizeof(*stat));
 	if (retval < 0) {
 		warn("error reading stat for task %d\n", pid);
 		goto out_close_fd;
 	}
-	if (retval < sizeof(stat))
-		stat[retval] = '\0';
+	stat[retval] = '\0';
 
 	/*
 	 * The process state is the third white-space delimited field
-- 
2.54.0

