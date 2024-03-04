Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E801C68E
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Mar 2024 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587021; cv=none; b=W2oa4XIwyPrbch6xP+n7t8miV/Hil52TIQpWFUc6IzSnpX3oeAXDJhMJhfdHVWVwVVrhRPFD+TOk8KBvWVnKvWoq3VX6rDOlH6OCDvQzcAg5aZ2dcBrJHx8PPpEkKiK0MYzEiLmKf55xdEcxq4mTHXMN5O348qiZrhQlYyNnlQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587021; c=relaxed/simple;
	bh=brDUcpkfbTIz8/yjNnFfpLhMcV+hclVQDZ0flZznQ/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cX/3IMC05K3UTKEtFWw2GPnKavC4vrxp9nQDvqojtFOyE/rWZttLFRuYpfYBFyC0Drs1HdqmmVHySJ6WhJl8f1cUfADIXNMBiS4jUT3S/Bcj5Sw5wwDUcf8UmDLheJDJmGUOK5vpGcLFFo0a78waN0/D8U6her1B4Vyhr5012NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MyCY/sFI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyCY/sFI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709587019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cJzsX4XksOd1oBfBKQEUMv6XEbObVLKNB7JG16pwJ88=;
	b=MyCY/sFI5tl/KTp/QEi+TWxRAMb2Z6O6k2aFuCq8+QMUgrE3ssSJH6FI8cTzMZQXXsObZj
	WGONYL8B6UPBP+eYOa5oBPGxyXGiYBxbaceoyYUXwXkvwOqaimnabGigvKM0xPrsZfozz1
	xYeohx2qkxs5F4GbeM+qaR22dngxlZ4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-HEmg0kXyNiq-nyx-lmt98g-1; Mon, 04 Mar 2024 16:16:57 -0500
X-MC-Unique: HEmg0kXyNiq-nyx-lmt98g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7698B185A783
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Mar 2024 21:16:57 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.16.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1E8B1C0348A;
	Mon,  4 Mar 2024 21:16:57 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 2/5] rteval: kcompile: Fix path lookups in _remove_build_dirs
Date: Mon,  4 Mar 2024 15:16:52 -0600
Message-ID: <20240304211655.20174-3-crwood@redhat.com>
In-Reply-To: <20240304211655.20174-1-crwood@redhat.com>
References: <20240304211655.20174-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

- Use the actual source directory rather than the incorrect kernel* to
  match what the tarball generates
- Use glob to expand the node* wildcard
- Fix the incorrect variable name in the error message

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 rteval/modules/loads/kcompile.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index b606f7aad202..de1539986723 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -145,12 +145,11 @@ class Kcompile(CommandLineLoad):
             return
         self._log(Log.DEBUG, f"removing kcompile directories in {self.builddir}")
         null = os.open("/dev/null", os.O_RDWR)
-        cmd = ["rm", "-rf", os.path.join(self.builddir, "kernel*"),
-               os.path.join(self.builddir, "node*")]
+        cmd = ["rm", "-rf", self.mydir, *glob.glob(os.path.join(self.builddir, 'node*'))]
         ret = subprocess.call(cmd, stdin=null, stdout=null, stderr=null)
         if ret:
             raise rtevalRuntimeError(self, \
-                f"error removing builddir ({self.buildir}) (ret={ret})")
+                f"error removing builddir ({self.builddir}) (ret={ret})")
 
     def _find_tarball(self):
        # If the user specifies the full kernel name, check if available
-- 
2.43.0

