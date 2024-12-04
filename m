Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ED220B816
	for <linux-rt-users@vger.kernel.org>; Wed,  4 Dec 2024 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326899; cv=none; b=C8MEfJEnOzbCeO5lGO33CrIRsYrBhVrF3mT4YAMlOa4xp8dNEa0dpkIDxORtIxe3addHzh+qgXdJF61yw65UtGU9NmhKmMScMI/zaFraeieETE0cPiWwZN23tR8V/PLj3OI/RSAMg43NvvQ87ydyWnnVGi/Evp4hpjY/WI6QO0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326899; c=relaxed/simple;
	bh=LPL4dJ+aUJYK1t/eV19tFHnRDHZRNQ2wXZtzrbOus38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBlc8rupMT5I2t7OBvYdFCWyAsK2dRRsfuvJjQQ/PHnJRF0F2G1hoMWDqo8r+hQEisln9ZTJpViysiQ3AyIsqYO5Wti/lXzIr523ucGR81P5yKG19aQr3GX9QMkYEPWP+7wEOB609hxo9uaNPwYs7J6YFjzi8DYlVZ9ocNh5yDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSiZ+e93; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSiZ+e93"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733326897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+r/xFqbZtblNdyLiBL3u2mLrVT/72cwG0q/0NAhsEc=;
	b=gSiZ+e93C7mbAIInKeh9LBprg2cdVE4jbqzPHwlQj4qSelHQf3dqS1E0COOTWy4iksdwVE
	ZqXaJzwt3YeNYUbChDczUQxLoEOXxHjXfKIrnqj/mtDdrhQeh1LAqdK/m3a1TNNckDMNLO
	+ouCTpt61XtNwMQWPzDKAOIaM4qu8mU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-qD1xNQb2MbWeSmzteZ98dw-1; Wed,
 04 Dec 2024 10:41:34 -0500
X-MC-Unique: qD1xNQb2MbWeSmzteZ98dw-1
X-Mimecast-MFC-AGG-ID: qD1xNQb2MbWeSmzteZ98dw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E917018EBA8B
	for <linux-rt-users@vger.kernel.org>; Wed,  4 Dec 2024 15:40:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 539033000197;
	Wed,  4 Dec 2024 15:40:57 +0000 (UTC)
From: tglozar@redhat.com
To: jkacur@redhat.com,
	williams@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/2] rt-tests: Handle -lcpupower flag outside LDFLAGS
Date: Wed,  4 Dec 2024 16:40:04 +0100
Message-ID: <20241204154004.560615-3-tglozar@redhat.com>
In-Reply-To: <20241204154004.560615-1-tglozar@redhat.com>
References: <20241204154004.560615-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Tomas Glozar <tglozar@redhat.com>

The rt-tests Makefile adds -lcpupower to LDFLAGS if libcpupower support
is detected on the system. However, this does not work when LDFLAGS is
overwritten by an external source.

Add separate variable LIBCPUPOWER to contain the flag and pass it to the
cyclictest linking phase. This also avoids unnecessarily passing the
flag to the linking of other rt-tests binaries which do not use
libcpupower.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index f656e34..0fa0928 100644
--- a/Makefile
+++ b/Makefile
@@ -43,7 +43,7 @@ PYLIB ?= $(shell python3 -m get_pylib)
 ifneq ($(no_libcpupower), 1)
 ifeq ($(call test-feature,libcpupower), 0)
 CPPFLAGS += -DHAVE_LIBCPUPOWER_SUPPORT
-LDFLAGS += -lcpupower
+LIBCPUPOWER += -lcpupower
 else
 $(warning libcpupower is missing, building without --deepest-idle-state support.)
 $(warning Please install libcpupower-dev/kernel-tools-libs-devel)
@@ -135,7 +135,7 @@ $(OBJDIR):
 -include $(addprefix $(OBJDIR)/,$(sources:.c=.d))
 
 cyclictest: $(OBJDIR)/cyclictest.o $(OBJDIR)/librttest.a $(OBJDIR)/librttestnuma.a
-	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(RTTESTNUMA)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(RTTESTNUMA) $(LIBCPUPOWER)
 
 cyclicdeadline: $(OBJDIR)/cyclicdeadline.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
-- 
2.47.0

