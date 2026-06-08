Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193EF3563D4
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943676; cv=none; b=EpU92yzcB/K0ShFl2T66P/kfnQGiXTVr52rbao6gZLJCiTejYQge8vbvnp54BhhZtmDXaTMuj7ygQVI7zjI6je2Jg9+wSvkU1LOmg7uYfBg8X8HXhs0Bp2fxCP97ECkL8GsItc2eUi+yNX+184DyYlGDIoPYuL+EbTx65t+IOC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943676; c=relaxed/simple;
	bh=nZzoDIeP0ti/woNzQ+gquiAcBemGNmGfdUbhw7y08ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOcrj2lIv9VxdlNxzx2Molks+cy/R1S5mRwHtxhwkPSbGhZcnlmJZ9+laANFrgiANNXHFbyGYaq2lkLBSxDbN2S5Gd2TBwu27xJIVC85H1sxF/JSjK2XyRkZc3gn/0uYtbQjgqcfgV03u6qd0EjvVta63/cG0C1fYGOPXH4rf+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFS9M81j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFS9M81j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jl4kQKOs5jiz/7HH+8JAqPzSvlUx4bcUxHFX8YhT0S4=;
	b=ZFS9M81jrrM5ErxhAaPgHcaLi530RIveukj/TeSMZFz/TAgqXTCKcSOcMkisRYGvJRvesw
	KgwsfTIyNN/VzNtDLFupCP6HHxIMYBluOJo6of+A5Jdygrv3jBbrinkqEoG+y/olESAxIm
	pBWq1NU6u1iky8MuuUFWB2VDGmczDdM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-dWtVvfYnNb6AnDVehNqz_w-1; Mon,
 08 Jun 2026 14:34:32 -0400
X-MC-Unique: dWtVvfYnNb6AnDVehNqz_w-1
X-Mimecast-MFC-AGG-ID: dWtVvfYnNb6AnDVehNqz_w_1780943671
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A21371977028;
	Mon,  8 Jun 2026 18:34:31 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 782E836928;
	Mon,  8 Jun 2026 18:34:29 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 51/52] stalld: fix error return in queue_track_get_cpu
Date: Mon,  8 Jun 2026 15:32:01 -0300
Message-ID: <20260608183206.140526-52-wander@redhat.com>
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

queue_track_get_cpu() returns 1 when the buffer is too small to hold
a stalld_cpu_data structure. Because callers treat any positive return
as a successful read, the parsing stage proceeds on a buffer that was
never filled, reading uninitialized memory. Return 0 instead so the
caller recognizes the failure and retries with the enlarged buffer on
the next monitoring cycle.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/queue_track.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/queue_track.c b/src/queue_track.c
index 2c1a11b..a1a127a 100644
--- a/src/queue_track.c
+++ b/src/queue_track.c
@@ -137,7 +137,7 @@ static int queue_track_get_cpu(char *buffer, int size, int cpu)
 		config_buffer_size = sizeof(struct stalld_cpu_data);
 		log_msg("queue_track is larger than the buffer, increasing the buffer to %zu\n",
 			config_buffer_size);
-		return 1;
+		return 0;
 	}
 
 	retval = get_cpu_data((struct stalld_cpu_data *) buffer, cpu);
-- 
2.54.0

