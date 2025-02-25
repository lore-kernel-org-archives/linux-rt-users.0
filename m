Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDA220E70C
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Feb 2025 22:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521359; cv=none; b=nxcumQFJJJETBMdnPTcBSCZYhTudzIyhLr0P4WoVfqrYpwIPbyAJDiu0rJmqw8h2Tru7V0axs7JKfU+8OfG77i3RBa6XjmuiRqvfCgSvYHmELTm8txfuhAPnq/GKgiqamWVydl8G0U5+HdcNglz8mKvGcFdokmwmcrbJlK28FRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521359; c=relaxed/simple;
	bh=EmocSqU7j8iZB07ryl0Vgrh0uQFTG/xczsRCQRiURbI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9f4TEio316kdCvKyIaNfgb6Ju1n0Y2orQL7ZIhZjxFhaMhs/8mPgsmPfu1DdZSmVl3rhq1oTjg1MAMsokQgPzClbQk2TYtxHayJBquQIXsa5wYslLx5XFg+Eu1LYHfC+s6tCuh2K+evRGOC1XqPFSxd0OxIxBloQstvjz5W094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DqgQpshU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqgQpshU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740521356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ft5DNbZex974TNt1cxwk2Xo9vRwR1ucWYDv+62gn3DI=;
	b=DqgQpshU/UYpHwyAnAvdmEMNgWnkvxN87U108jfAEb0qIcacjKOP1e2auL5V2x4m30GWli
	PXC7f2aRlecG/CT6xM/GLtiED4KI7NTtNN2bNXcQdeKwk0tfD34shVdOwavjgIJapaxN5m
	rkpwwhceTTbzLS6MJTtTTQcf5+h0/GQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-UWyx9aV6OySeJob1_MF-_w-1; Tue,
 25 Feb 2025 17:09:12 -0500
X-MC-Unique: UWyx9aV6OySeJob1_MF-_w-1
X-Mimecast-MFC-AGG-ID: UWyx9aV6OySeJob1_MF-_w_1740521350
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 478D8180036F;
	Tue, 25 Feb 2025 22:09:10 +0000 (UTC)
Received: from localhost (unknown [10.22.80.185])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91008180035E;
	Tue, 25 Feb 2025 22:09:08 +0000 (UTC)
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Wang Yong <wang.yong12@zte.com.cn>,
	Xuexin Jiang <jiang.xuexin@zte.com.cn>,
	Yang Yang <yang.yang29@zte.com.cn>,
	Xiaokai Ran <ran.xiaokai@zte.com.cn>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 3/4] rt: fix build issue in at_hdmac
Date: Tue, 25 Feb 2025 19:08:56 -0300
Message-ID: <20250225220857.216591-4-lgoncalv@redhat.com>
In-Reply-To: <20250225220857.216591-1-lgoncalv@redhat.com>
References: <20250225220857.216591-1-lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

v5.10.234-rt127-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


The problem described here is specific to v5.10-rt.

The functions atc_advance_work() and atc_issue_pending(), defined at
drivers/dma/at_hdmac.c, both have a similar statement:

    return spin_unlock_irqrestore(&atchan->lock, flags);

That results in a macro expansion error during build.

This problem is unique to v5.10-rt because of the way spin_unlock_irqrestore()
is defined as a macro at include/linux/spinlock_rt.h.

Newer versions of the PREEMPT_RT patch (v5.15-rt and newer) have
spin_unlock_irqrestore() defined as a function.

Kernels such as v4.19-rt and older are also not affected because they don't
have the two commits below, which implement the statements that trigger the
compiler error:

  1582cc3b4805 dmaengine: at_hdmac: Fix concurrency problems by removing atc_complete_all()
  7078e935b410 dmaengine: at_hdmac: Fix premature completion of desc in issue_pending

It  makes more sense, at the current point in v5.10-rt life cycle, decoupling
the return and spin_unlock_irqrestore() statements instead of backporting
the new definition of spin_unlock_irqrestore() and related bits.

Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 drivers/dma/at_hdmac.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 6a4f9697b574..bdbd85adeea9 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -483,8 +483,10 @@ static void atc_advance_work(struct at_dma_chan *atchan)
 	dev_vdbg(chan2dev(&atchan->chan_common), "advance_work\n");
 
 	spin_lock_irqsave(&atchan->lock, flags);
-	if (atc_chan_is_enabled(atchan) || list_empty(&atchan->active_list))
-		return spin_unlock_irqrestore(&atchan->lock, flags);
+	if (atc_chan_is_enabled(atchan) || list_empty(&atchan->active_list)) {
+		spin_unlock_irqrestore(&atchan->lock, flags);
+		return;
+	}
 
 	desc = atc_first_active(atchan);
 	/* Remove the transfer node from the active list. */
@@ -1477,8 +1479,10 @@ static void atc_issue_pending(struct dma_chan *chan)
 	dev_vdbg(chan2dev(chan), "issue_pending\n");
 
 	spin_lock_irqsave(&atchan->lock, flags);
-	if (atc_chan_is_enabled(atchan) || list_empty(&atchan->queue))
-		return spin_unlock_irqrestore(&atchan->lock, flags);
+	if (atc_chan_is_enabled(atchan) || list_empty(&atchan->queue)) {
+		spin_unlock_irqrestore(&atchan->lock, flags);
+		return;
+	}
 
 	desc = atc_first_queued(atchan);
 	list_move_tail(&desc->desc_node, &atchan->active_list);
-- 
2.48.1

