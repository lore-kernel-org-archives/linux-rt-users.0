Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28A6161B6A
	for <linux-rt-users@vger.kernel.org>; Wed,  1 May 2024 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594169; cv=none; b=JM887/kEk1HYT/XrvmKkapSQNwvl4/b4mpyx1j1ZbvgaPic0gff792jcpRzmZ8KvoZmsfDDfso6nOggH0tolJFHlMpf+mPEQlj/0MxZv+cmFPqW4o7BQYDlxiHXcSHuvmnaozTCU4/3O1Y67VAmXc90oS/GgT+8g8FU1cs0JzFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594169; c=relaxed/simple;
	bh=ikOXhhtO+bTXRZRJt63xokyp1K5yW8BtVXEiXg2UTnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gW/9ObGvglRl/fSRAfiP4SGNskrzHEM6zZs7ruItvuKTBtjYkdBBIil2iQIIqxr5zs9SQUyEeVW6+7SiEqOidBG+8gU9EHR82cLXdoYV9AMQMQR5uyTcPeyOkDMkhasn3m3bl3lrWqfq62dP2dGAP7pGuEeYg2I2u30t/Dp6w/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9igiH8/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9igiH8/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714594166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Uj3x8ZIfxJMh7WB+Gwd9mLSX87wdfvRA1C2+JQJrrRU=;
	b=X9igiH8/KWSkU4FCTueHT2zZ/a4544NpUtJIHfjSX2AWsEnk2jwSuo1H1XA+AADWsZOMxW
	t+1SSFCdYZdJyqoBUX+UpbDffCTeVFq/Oh4vxUk2DI5ce/nZ1JPgV3AVBDuYlvPP4U7jmt
	Qozxt3H6hLKjtln+KfnXfvWgzxPfnaQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-bGklirjnPSmMwl7P4tSJhQ-1; Wed, 01 May 2024 16:09:23 -0400
X-MC-Unique: bGklirjnPSmMwl7P4tSJhQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDA858948A2
	for <linux-rt-users@vger.kernel.org>; Wed,  1 May 2024 20:09:22 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.16.177])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8EC806958;
	Wed,  1 May 2024 20:09:22 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH] rteval: cyclictest.py: reduce: Fix exception with missing samples
Date: Wed,  1 May 2024 15:09:22 -0500
Message-ID: <20240501200922.226347-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

If cyclictest omits a line of zeroes rather than printing it,
__samples[high] will not exist (rather than be zero).  Handle this
in preparation for cyclictest doing this.

Note that get() seems more suitable than setdefault(), but the latter
is used in order to match the code in timerlat.py.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index cef73abd1b4b..925065367eaf 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -115,7 +115,7 @@ class RunData:
                 low = i
                 break
         high = keys[-1]
-        while high and self.__samples[high] == 0:
+        while high and self.__samples.setdefault(high, 0) == 0:
             high -= 1
         self.__range = high - low
 
-- 
2.44.0

