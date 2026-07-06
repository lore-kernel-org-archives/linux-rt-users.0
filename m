Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A301353A64
	for <linux-rt-users@vger.kernel.org>; Mon,  6 Jul 2026 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336571; cv=none; b=gwBZeNGDuk1iEfNiP0ijTpeWtrs0NLn/hqJbsLwwnw/HFExNH4E8Rd/X97zNsBu8btrZSWfADdEmzXlh6sL1HH0SMzeLe93vBcd8SU/mDrwrv3r0O9+rTE3yfo+RhJK6ddNwz/9EjL7ce4Fv/sEXljgvwbGWk4DJAAZQ0ExNziM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336571; c=relaxed/simple;
	bh=StdrIDtP7AjPpvTzcXIAGigTZoZluMP8pXzGeZX9l0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e18ipY5W76MnicOO9RM7MtYE+6Mc4hF/DSjgNBxPeTuf+gFv2Do3Nyh/iAdvQKH8HDiRqefMiGcvlImt/4JnNo6nHrbDFfyYYkZ/43cCcMQ5Y9skIMGNzM3MmwucmVjLkmGas7n0Z+Xwf10HFYH2inmtJAOTT2Tuno/CDU99QOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ye7HQuZ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ye7HQuZ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783336569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nVWfpQ7z04PLa5N48z4VGwOgfzLMfviw+upE8SKbEoI=;
	b=Ye7HQuZ4Y3rncL2JKeMlPQNfTzlJ4Ri0h+AKEvzKH53y3UokECkeQJQtxIffADjKckIu8d
	yWwlJUw/2MPAo3De679QnsLV1L8KE71jcgNxEvHhXYnM8myq132e7r0jsmYrqO0wqD7XDK
	4+AQE7cc4ejQrPgHck4uh7xBB8iqguA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-VVktCEhoPBSZZXV-iLt12Q-1; Mon,
 06 Jul 2026 07:16:07 -0400
X-MC-Unique: VVktCEhoPBSZZXV-iLt12Q-1
X-Mimecast-MFC-AGG-ID: VVktCEhoPBSZZXV-iLt12Q_1783336567
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E77A11955F0C
	for <linux-rt-users@vger.kernel.org>; Mon,  6 Jul 2026 11:16:06 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.49.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BCC243000715;
	Mon,  6 Jul 2026 11:16:04 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH] rteval: Make thread excepthook portable and support chaining
Date: Mon,  6 Jul 2026 13:16:01 +0200
Message-ID: <20260706111601.363596-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Replace the direct use of threading.__excepthook__ with the original
threading.excepthook captured at module initialization. This enables
compatibility with Python versions 3.8 and 3.9 (where __excepthook__ is
not defined) and preserves any custom exception hooks registered by test
runners or parent programs.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 rteval/__init__.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rteval/__init__.py b/rteval/__init__.py
index 2eadb20..6e49889 100644
--- a/rteval/__init__.py
+++ b/rteval/__init__.py
@@ -41,10 +41,11 @@ def sig_handler(signum, frame):
     else:
         raise RuntimeError(f"SIGNAL received! ({signum})")
 
+orig_excepthook = threading.excepthook
 def except_hook(args):
     global threaderr
 
-    threading.__excepthook__(args)
+    orig_excepthook(args)
     threaderr = True
     stopsig.set()
 

base-commit: 6b38190d2d66968b637dada5c8af9226ca8a7a5b
-- 
2.55.0

