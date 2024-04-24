Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E2E143894
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Apr 2024 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980732; cv=none; b=u74DYUBqu3zgFvXMY1KNdF/GfR9plFdP43sSqZZGPYxzfCsBHGOJMNVVVs/Z9KqMFmKA08SR8KcrlshvZnp/SiQ6wI238CZCtiSlP0J+L31z+row/UPIuqt1nWgTDXIxUb7AYb1MiDOdVCZYKm/ed9BC2rD4aHpr+t8MOTebyjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980732; c=relaxed/simple;
	bh=i+Lv3Uas3bdTuBMktfym6MIqWRSJhgZ7SjCtyXhQBgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6nV+FoTCUbCSlg2f8dyHAumozCOKd8KnPJd3F8MMmZyud3CJvfaZYFPBBzTjsl4X1wocZd6qho41B2xs6VxcLLGJYmbkZn2PyZlJleEUFZfnEMp35qiTuBa3SP91YfWSLP1JMqiY1Cnhox1lTZG3EQDtobFb3zSkwlaDsa+M2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/iDdmi3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/iDdmi3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713980729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QxZ3CgcnhxNvU1H7XEFFHN17lovaTrPCWVowHdzMn+o=;
	b=a/iDdmi3Trxy40M1XgjBSzXMVbr8HwRkmKJOtKrNJbDep2YLqdDj29SB+JlLz2zaVrqydj
	BtGLLM9XCVxMyFvxfxfsYOuDse7AdrJq8izVvKWmRYidJ9lR5lr+sczb9C6n3/frXZQiX1
	CuxYJC7W6k/grrsh3XG5M5jS1pyWEXU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-s14XYPSJPoKt5LcAw33oHg-1; Wed, 24 Apr 2024 13:45:27 -0400
X-MC-Unique: s14XYPSJPoKt5LcAw33oHg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FDC2800CAC
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Apr 2024 17:45:27 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.16.213])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 432AA2166B31;
	Wed, 24 Apr 2024 17:45:27 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH] rteval: Use -j with make mrproper
Date: Wed, 24 Apr 2024 12:45:26 -0500
Message-ID: <20240424174526.190509-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

This reduces the startup overhead somewhat.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
On my 12-cpu laptop the gain is about half of what
https://lore.kernel.org/linux-rt-users/20240304211655.20174-4-crwood@redhat.com/
does, but *shrug*
---
 rteval/modules/loads/kcompile.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index de1539986723..f7a9c0084805 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -248,7 +248,7 @@ class Kcompile(CommandLineLoad):
 
         # clean up any damage from previous runs
         try:
-            cmd = ["make", "-C", self.mydir, "mrproper"]
+            cmd = ["make", "-C", self.mydir, "-j", str(os.cpu_count()), "mrproper"]
             ret = subprocess.call(cmd, stdin=null, stdout=out, stderr=err)
             if ret:
                 # if the above make failed, remove and reinstall the source tree
-- 
2.44.0

