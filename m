Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4102620B817
	for <linux-rt-users@vger.kernel.org>; Wed,  4 Dec 2024 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326900; cv=none; b=sqCbHMMTO/TG7g+7sVulNzG6utwKMDGh2gC4TP3O7zHjq/l5et7ShEBBNT+hsE0EO4qVOdl/vMgAOm5SvzXgjF1r72oSOGzoh2eC9GmeK0Y+ahXSIk0iOg8RHx2dEke28lEqghH1Tke3CIkhqf8roujbPTWa1f/+OuyYHUcNuEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326900; c=relaxed/simple;
	bh=LApF23/OBLW9Mf96Tzaxf2ofULJhhcgQ1ySnif8GuH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYPhRnh2LTz3CpWMGlR6LFkpm/MsikXfMxBDfKTKcbktzwtHlm32vSkXDg0b0doL1O0synp4a5Wa8PKkstV5IXQ0jW2/OKS4v2o7o95jjK5oSWap++uGCpJ2cVDvQNc83kGz7zO6XsE6tlzauk1o1xsAA8X2QKPBG9MFNwOo+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GjeL6/gP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjeL6/gP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733326897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uSESdY53ujtRfIfo3XnyvTcQLzjpPPeDRCp7f20T6cA=;
	b=GjeL6/gPTD9PTnyyVTjqJrB4R0l1YUAHdu5k2MOEGqEbiESFgrToX6NQu6N+bQKftRC9pM
	UnWH0fuCcm3400X/h3iyAxKwWRQKvLzefZdy3TnJkg3VY2FDMxZca400i3nBUH8zOD9Dp5
	3o1j7K9ixKpr4skuRLL4gkO3eOaZRGE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-EYBZ_ZaVO1uq45xIxUXjgg-1; Wed,
 04 Dec 2024 10:41:35 -0500
X-MC-Unique: EYBZ_ZaVO1uq45xIxUXjgg-1
X-Mimecast-MFC-AGG-ID: EYBZ_ZaVO1uq45xIxUXjgg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C768A18DB298
	for <linux-rt-users@vger.kernel.org>; Wed,  4 Dec 2024 15:40:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0DC33000197;
	Wed,  4 Dec 2024 15:40:54 +0000 (UTC)
From: tglozar@redhat.com
To: jkacur@redhat.com,
	williams@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 1/2] rt-tests: Put variables in test-feature in quotes
Date: Wed,  4 Dec 2024 16:40:03 +0100
Message-ID: <20241204154004.560615-2-tglozar@redhat.com>
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

test-feature passes several variables (OBJDIR, CFLAGS, CPPFLAGS,
LDFLAGS) to make via a shell command from inside the Makefile. If there
are spaces in either of these, it gets parsed as a second argument
to make and feature detection fails.

Add quotes around the values to prevent them being passed as multiple
arguments.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 feature/test-feature.mak | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/feature/test-feature.mak b/feature/test-feature.mak
index 0b3e51c..aef915a 100644
--- a/feature/test-feature.mak
+++ b/feature/test-feature.mak
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 define test-feature
-$(shell $(MAKE) OBJDIR=$(OBJDIR) CFLAGS=$(CFLAGS) CPPFLAGS=$(CPPFLAGS) LDFLAGS=$(LDFLAGS) \
+$(shell $(MAKE) OBJDIR="$(OBJDIR)" CFLAGS="$(CFLAGS)" CPPFLAGS="$(CPPFLAGS)" LDFLAGS="$(LDFLAGS)" \
 -f feature/Makefile feature-$1 clean >/dev/null 2>/dev/null; echo $$?)
 endef
-- 
2.47.0

