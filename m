Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA2230FF2E
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781013; cv=none; b=oPo+SJDWMR6FJW9KixRYQbJhzDcGW80GjQcEzzoHRg1dsPG5VPXxIhObX/+Z8GVMUfXzPnTp6to4N73CWmFTgt60i965Sagxpy89oVOkwyg2+0lzzp2hhgUlhRUBKson+facPgjhW9b1MfSRCJMm2p7O6R1i0qVhMHkcGhtIeKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781013; c=relaxed/simple;
	bh=a1VOqnOmHM7pHtnKeqBFGns6atgWVhUpr5guu3E+bbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZkKTYiaQqIO7tkOaWEjdXjSO7uAcxM9MQbdv/hMrTNy25KsZ4le01SpgAklZSJb7+Lw7sDvzhvz0mFeD879Y6iDgBLJVTLS39vm6aZGfD+AM9b5jml6toXqdv7JvuZIJeIkdxixeDU654YftwjQ36qdA/hP28DY2bQbnf3rC48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JkhEiP5M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JkhEiP5M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762781010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/JxUXpRfuzeDYqFHaoSH5Tjgg9fTbQY5YHtzN/ya0Y=;
	b=JkhEiP5MpZUC541bKauEDc6U1P8r0+QN0EL5tNgQX/rx2b3xYbGAxwY53HwQThdXBbZ/rQ
	u2qKw27+2GTnWYprVAKwb/FFjUo8QJyBJwfVIFqBVh77gYFXNrnI/096ZkPMuaHlE2+U1V
	Gv6PH9eGGlbFex6+1egpIUnqkE2BAsE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-FQsIQ6EZMR261EoZ7d9aRA-1; Mon,
 10 Nov 2025 08:23:26 -0500
X-MC-Unique: FQsIQ6EZMR261EoZ7d9aRA-1
X-Mimecast-MFC-AGG-ID: FQsIQ6EZMR261EoZ7d9aRA_1762781006
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A42B18001D1;
	Mon, 10 Nov 2025 13:23:26 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.40])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AB476196FC8B;
	Mon, 10 Nov 2025 13:23:22 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Wander Lairson Costa <wander@redhat.com>,
	Derek Barbosa <debarbos@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [stalld v2 5/6] Makefile: Print BPF tool versions for debugging
Date: Mon, 10 Nov 2025 10:22:40 -0300
Message-ID: <20251110132241.43685-6-wander@redhat.com>
In-Reply-To: <20251110132241.43685-1-wander@redhat.com>
References: <20251110132241.43685-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This commit adds informational messages to the Makefile to print the
kernel version, clang version, and bpftool version. This will help in
debugging BPF-related compilation issues by providing clear information
about the build environment.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Chunsheng Luo <luochunsheng@ustc.edu>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index ba67698..43eb9b8 100644
--- a/Makefile
+++ b/Makefile
@@ -121,6 +121,10 @@ VMLINUX_BTF_PATHS	:= /sys/kernel/btf/vmlinux /boot/vmlinux-$(KERNEL_REL)
 VMLINUX_BTF_PATH	:= $(or $(VMLINUX_BTF),$(firstword                            \
                                           $(wildcard $(VMLINUX_BTF_PATHS))))
 
+$(info KERNEL=$(KERNEL_REL))
+$(info $(shell $(CLANG) --version | head -1))
+$(info $(shell $(BPFTOOL) --version))
+
 ifeq ($(ARCH),x86_64)
 CLANGARCH="-D__x86_64__"
 endif
-- 
2.51.1

