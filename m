Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D961EC01F
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Dec 2024 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436210; cv=none; b=auLv8pUblj3Mlpc3VzVC9jsb4jFZNVRK/o+hq0a/X5cMHc417EsYUJpwaWFFqlkA7Sady0NGffUyWd9EmykVi8BqwSuKDn/pidlest7ayQRzD/Mf1XUL3mfvaQwfBbrQANRfB89UifEKPl6KHlVvzyJ3E8eKil4flq4wOq3xVWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436210; c=relaxed/simple;
	bh=4qIN2lhSW0zLpkxIxdNtFcyJ8lL5CPF6nLcWsKCaB4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aPjiIV/ZOJ+tH+r0X2H/acsAuE9lpdfGAc9xX86+rYoobcHKXtOhcEno4bCtB8cTkYGvMF59LcL8ljjLOhQ71a4SjjGzU5PxILPzgg6aUVFakDuL2cVUfk+qV+ypUrq2LgQ68I7szVVL7fWf8jzUklgawim3E7xF6vjDjMTdQpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vh6DUckB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vh6DUckB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734436207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9hn/cNd9j8gF4OjGvpZz0bGjwh9x9NhycsePJIJe+xc=;
	b=Vh6DUckBx4q/HKhlC4csP6WNp0kSARmswsH8RymZpOWS3pvGl4JdCEBNAGkeYYkqqw6sjh
	BdwaW7zuDw3uNPVQDxG3ta2XY5rLjBUlW3DkHc6AYrRtDh/hlnYlW8Pj73BWiTHoOUt4HZ
	z7db82f7VyLj7py9u3vcRbnQhC0YZzs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-tGrt8XRkNZuT1NoaeNHYGw-1; Tue,
 17 Dec 2024 06:50:06 -0500
X-MC-Unique: tGrt8XRkNZuT1NoaeNHYGw-1
X-Mimecast-MFC-AGG-ID: tGrt8XRkNZuT1NoaeNHYGw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A999B1956086
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Dec 2024 11:50:05 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A681195394B;
	Tue, 17 Dec 2024 11:50:04 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] rt-tests: Skip feature tests on non-build targets
Date: Tue, 17 Dec 2024 12:49:42 +0100
Message-ID: <20241217114942.2670452-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Do not check for dependencies when not building anything, i.e. on clean,
distclean, and tarball targets.

Inspired by a similar check in rtla.

Suggested-by: John Kacur <jkacur@redhat.com>
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Makefile b/Makefile
index 0fa0928..ce7f5c5 100644
--- a/Makefile
+++ b/Makefile
@@ -39,6 +39,17 @@ LDFLAGS ?=
 
 PYLIB ?= $(shell python3 -m get_pylib)
 
+# Check for dependencies only when building
+NON_CONFIG_TARGETS := clean distclean tarball
+
+config          := 1
+ifdef MAKECMDGOALS
+ifeq ($(filter-out $(NON_CONFIG_TARGETS),$(MAKECMDGOALS)),)
+ config         := 0
+endif
+endif
+
+ifeq ($(config),1)
 # Check for optional libcpupower dependency
 ifneq ($(no_libcpupower), 1)
 ifeq ($(call test-feature,libcpupower), 0)
@@ -51,6 +62,7 @@ endif
 else
 $(warning libcpupower disabled, building without --deepest-idle-state support.)
 endif
+endif
 
 # Check for errors, such as python3 not available
 ifeq (${PYLIB},)
-- 
2.47.1

