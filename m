Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75413E0C7E
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943645; cv=none; b=CWb/BqBKp8NrPMXFD5YZcaqAXLQv7+OXgaXWMI7vUGXNI9aU3Mzmr8xPTdzkoUOvVRUwqF/tZSVv3blblrD6BhEw0fBJXNsGIRugo+QYNbCdSZ0FETXTTYqegRiOogOGiDJAxL3AbMmVgRsJIo/WDEu/5t2uClidoH94eLnYkM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943645; c=relaxed/simple;
	bh=XrHeNSQY6g8naoTSQcTFA4VVY8PefUKReOxHppT/pNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A//sOEwL7np05Ulk18cQhL1uYMpl01a0gHbEYym7kiolgOToHow1xZD+k/6j0uK9n5YdQmctae7yNjWyR93/m7TQouXpmQMzwc+dXFvx1VGKwgOrPVFU4xR6FAiX3U0qK1ik1R7N9cHx2jZdzi/k8moNSJiNBJPl2M1oNet1cX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hj+jTAID; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hj+jTAID"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mnj2V+tOcth9m/CMbwHZ/NTqbIBAz8UuW2y4llKoxNc=;
	b=Hj+jTAIDMpVNuKzLbon5IbVDlIveS7amKLwEM2jzcD4ca1G4GkBWHwSkA5naZHHfZdhBpw
	7r2YRtulBq28fH9+w5RRyRkpzC9RGS7yngBcVgcozuZj5It9aexryp7pdSyDetC/zug0QA
	sqxrZ1tBSaeMzIPzXvhkjoU6mHx5br4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-cUkCoLZ_O1ypO0YcrCM2YQ-1; Mon,
 08 Jun 2026 14:33:59 -0400
X-MC-Unique: cUkCoLZ_O1ypO0YcrCM2YQ-1
X-Mimecast-MFC-AGG-ID: cUkCoLZ_O1ypO0YcrCM2YQ_1780943638
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 998C7185FC4E;
	Mon,  8 Jun 2026 18:33:58 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8530036927;
	Mon,  8 Jun 2026 18:33:56 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 38/52] stalld: fix buffer underflow in sched_debug_get
Date: Mon,  8 Jun 2026 15:31:48 -0300
Message-ID: <20260608183206.140526-39-wander@redhat.com>
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

The null termination after the read loop writes to buffer[position-1]
without checking that position is non-zero. If the read returns no
data, position remains zero and the write underflows the heap-allocated
buffer, corrupting allocator metadata.

Add the same position guard already applied to read_proc_stat.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/sched_debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/sched_debug.c b/src/sched_debug.c
index 3754b56..5e9a9e8 100644
--- a/src/sched_debug.c
+++ b/src/sched_debug.c
@@ -50,7 +50,8 @@ static int sched_debug_get(char *buffer, int size)
 
 	} while (retval > 0 && position < size);
 
-	buffer[position-1] = '\0';
+	if (position > 0)
+		buffer[position-1] = '\0';
 
 	if (position + 100 > config_buffer_size) {
 		config_buffer_size = config_buffer_size * 2;
-- 
2.54.0

