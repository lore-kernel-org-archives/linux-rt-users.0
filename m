Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD323376A3
	for <linux-rt-users@vger.kernel.org>; Fri, 24 Oct 2025 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326492; cv=none; b=XjwmB5wH5i3m0PxJn6mMf5EzSHx7ZyhxLzw8dZL8ZC+wH5qlH3QGOziRJxkCYbhjTgNf1uoMxigRWWztANP5wtFNJqbKNVks9N2z0BPIKJ/as5ry0tlceZWK/ndrrECe2iYqDHG4K8uAThpaxE7avMLDYw1qq9+zGzO9W+uBoDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326492; c=relaxed/simple;
	bh=KeQ0llUrLakiZgGmt1FXxxVndxioYSN+nam300wv7d4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gIEWIvSSpbnjr4dYMQHztZtBhgX08Su9oce1sAhdoxjGo2dSGE2H6vNqWxeEtgeO33mJ5+0ZCE0GhsyCJKpGNETOW32syfQpRqp1DOEINKjr/9b0SF/nbJjvWIPsG16yRv7zw+OBMi/1DUcbrPBJK1Gdd3gr8Ut0Lrxmr2gQCLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XbC4bl3d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbC4bl3d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761326489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pRibkXI6v4iemd0ZTuRi2aRRXoJJ1WIhylW74J+PURY=;
	b=XbC4bl3d4t7k5SYJ2IAa1zeVAm0bKWU+p+ChvgQEiX+GlwUr81rXqlY2AyUV+GgjShkLoq
	/Kk3+oxu9jeLPjpzdD7P65yvkWQIbzIQJzjZcA87QG2hfOE0OffMdCtTb61nwGfiuAkHmK
	MjaRWU4KMinNEVVcN/8OgTmjHYk938I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-ufPkrC3zOtSaHcSyZi48KQ-1; Fri,
 24 Oct 2025 13:21:27 -0400
X-MC-Unique: ufPkrC3zOtSaHcSyZi48KQ-1
X-Mimecast-MFC-AGG-ID: ufPkrC3zOtSaHcSyZi48KQ_1761326486
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CF911800345;
	Fri, 24 Oct 2025 17:21:26 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 335C1195398C;
	Fri, 24 Oct 2025 17:21:22 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Wander Lairson Costa <wander@redhat.com>,
	Derek Barbosa <debarbos@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH] Makefile: Make BPF compilation verbose
Date: Fri, 24 Oct 2025 14:21:15 -0300
Message-ID: <20251024172115.73224-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Remove the '@' prefix from the CLANG and LLVM_STRIP commands in the
Makefile. This makes the build system print the commands to the console
during the BPF compilation process. This increased verbosity is useful
for debugging build issues.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Chunsheng Luo <luochunsheng@ustc.edu>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 7234a46..0b1ad6d 100644
--- a/Makefile
+++ b/Makefile
@@ -154,9 +154,9 @@ bpf/vmlinux.h:
 # The .bpf.c needs to be transformed into the .bpf.o.
 # The .bpf.o is then required to build the .skel.h.
 bpf/stalld.bpf.o: bpf/vmlinux.h bpf/stalld.bpf.c
-	@$(CLANG) -g -O2 -target bpf $(CLANGARCH) -DDEBUG_STALLD=$(DEBUG) -D__TARGET_ARCH_$(ARCH) \
+	$(CLANG) -g -O2 -target bpf $(CLANGARCH) -DDEBUG_STALLD=$(DEBUG) -D__TARGET_ARCH_$(ARCH) \
 		$(INCLUDES) $(CLANG_BPF_SYS_INCLUDES) -c $(filter %.c,$^) -o $@
-	@$(LLVM_STRIP) -g $@ # strip useless DWARF info
+	$(LLVM_STRIP) -g $@ # strip useless DWARF info
 
 # This is the second step: The .bpf.o object is translated into
 # a bytecode that is embedded into the .skel.h header.
-- 
2.51.0

