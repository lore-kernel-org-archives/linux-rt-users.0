Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0E83E120D
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943642; cv=none; b=d76u11F6j3yAKrZiSxxsqcGtJ82DP4ck7qD4fEXUzTVgIuHNO85tKQokIgaMtWPcvehQp50/MzpW9Vvgh4gZQ0a/K0bvDdt3GFHEdjq0YF+46vhz3Y4OmXNHbq1v3VBEtJHaQK9omtVeI9d3AA0EFf0b5XZHMvTn8tl90Oif8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943642; c=relaxed/simple;
	bh=WAHQz7K8yCKien/vk5dDEWN4JiOFKpr+LP/O1ij/qsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUE8R3SQ0EvTJAikPW9ziIFEJrMjBkzFxNf8DUsAhDVNrEnBjrJ0prMXvQ+/N0NXUMnlLEAPF4dzPdSEnFYvTl9SvrIamzC8Cyy3eCQt8WRlRjNOfVgSzrX/YcTaRxM+GsXeq0nlwqPJowfr3iHjtk+lKSu+Y52djdpnwQI1Azk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVbmXfwM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVbmXfwM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/pmDktGiYtquX98nvNvigGlsqRDgVvcpmQWgMqDEAE=;
	b=GVbmXfwMQp43IbXtCIc14HKD2e5a/tT2ZwJZX485HhCHZG+2mt2zpzVZix03ieb97x8U6Y
	48PWnUrdCRc35N2vmixWEr0ZDl6ZPBbaR1PqtUDrq3OV2KUleqEjXABJ2oGxL3dJVi3iVy
	28bYaw6k5ZX1CaT5Fu/SJJ4N9JEroUE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-kmcQhsKpPLCdCce8fzVLOA-1; Mon,
 08 Jun 2026 14:33:57 -0400
X-MC-Unique: kmcQhsKpPLCdCce8fzVLOA-1
X-Mimecast-MFC-AGG-ID: kmcQhsKpPLCdCce8fzVLOA_1780943636
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C64319540F0;
	Mon,  8 Jun 2026 18:33:56 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E7A5D36928;
	Mon,  8 Jun 2026 18:33:53 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 37/52] stalld: fix buffer underflow in read_proc_stat
Date: Mon,  8 Jun 2026 15:31:47 -0300
Message-ID: <20260608183206.140526-38-wander@redhat.com>
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

The null termination of the buffer after the read loop writes to
buffer[position-1] without checking that position is non-zero. If
read() returns zero on the first call, position remains at its
initial value of zero and the write goes to buffer[-1], corrupting
the byte immediately before the buffer on the stack.

Add a guard to only null-terminate when at least one byte was read.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/utils.c b/src/utils.c
index 90a0024..5d54ae9 100644
--- a/src/utils.c
+++ b/src/utils.c
@@ -1376,7 +1376,8 @@ int read_proc_stat(char *buffer, int size)
 
 	} while (retval > 0 && position < size);
 
-	buffer[position-1] = '\0';
+	if (position > 0)
+		buffer[position-1] = '\0';
 
 	close(fd);
 
-- 
2.54.0

