Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED24D3E0C51
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943652; cv=none; b=Kz6C5C8+02c0iGe3KJ7h1xFs8lbfAKMkMT7VcBxspFxxeJffWRVC+Kw7T05xLKoPoku232uX4LmY6u3RmNM5Wa6FMF9JQuQjIXypj+1svkAOoN+iG+9ND62bba0oFJXWSF7Fg2uoGzRFfD2T/d3+DWdl7IerYqVnu9XQDOyBaEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943652; c=relaxed/simple;
	bh=kHKyZ92xswONv/HcP4pkxjj+5cVlPw/Oy0htkNr2Ctw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjUQhJs9G3xFZ2seETmJ/TbK+T1+eMICuRLXLImoP/L6Fgfwd6v6/5AAdPvjmjknH44NSBDL0evHgeyP0eKEX65vbHdgG36DEa0ajPjmq4f3pUfZbiHSveqI1gxjjbUs89qiCc50XcNpDKJcJe0wHkI3BaRdmy5MHmTrEjZ2GiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXu25iyw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXu25iyw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aoTTDklzBTBbhk9qU1f5ZxIvoeYoUzs2TZQbgUnmJAw=;
	b=WXu25iywbpL/vdlCHOGZOUIf4CoGIc22A4xFUle5da0+358niZ3L5uKG7pkAdGJye4j6ep
	6Ktc99SyXgB/uWYt6UehVN9wKe4TR264+h94ar4sK18SUPE/OtrbzjSvnsw+ZlO7T034ab
	H6WJst0fxBPUfni7zkjY/IylgBMQ3Yg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-VHJH8-1iOrSFFTKrO1axBg-1; Mon,
 08 Jun 2026 14:33:51 -0400
X-MC-Unique: VHJH8-1iOrSFFTKrO1axBg-1
X-Mimecast-MFC-AGG-ID: VHJH8-1iOrSFFTKrO1axBg_1780943630
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C254B1977031;
	Mon,  8 Jun 2026 18:33:50 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AECFA36927;
	Mon,  8 Jun 2026 18:33:48 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 35/52] stalld: fix inverted DAEMON_UMASK value
Date: Mon,  8 Jun 2026 15:31:45 -0300
Message-ID: <20260608183206.140526-36-wander@redhat.com>
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

DAEMON_UMASK is defined as 0644, which is a file permission mode rather
than a proper umask value. Since umask() clears the specified bits,
umask(0644) strips owner read and write permissions while leaving files
world-writable. Change the value to 0022 so that newly created files
get the intended restrictive permissions.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/stalld.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/stalld.h b/src/stalld.h
index 69bc9e7..b910870 100644
--- a/src/stalld.h
+++ b/src/stalld.h
@@ -46,7 +46,7 @@
 /*
  * Daemon umask value.
  */
-#define DAEMON_UMASK  0644
+#define DAEMON_UMASK  0022
 
 /*
  * Informnation about running tasks on a CPU.
-- 
2.54.0

