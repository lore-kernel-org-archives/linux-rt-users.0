Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34C02003C1
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Nov 2024 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498329; cv=none; b=TLDz5r6RvJk+Z7vS0gYIK3IVPkDmEFdg5iMTd6qYM/7MP9tdM0kyQ/zRs2nsbgdnF2/ej731RvM5bxrljFoUqZHNeGGMHKrRbMMiTukWGdVZJuAiS+F+owyulJmAtqZxU96aGo7nudIv7b5mMth6lUrqK03AD5S4Rl5EDK51R/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498329; c=relaxed/simple;
	bh=Fu+8u1xN6JNGozSjqSEeR6bxbGTuDnfPCpXeqJ5mpjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbLObf/AXGlFW+vRA323iEbAEhHHPFrm1EDJnem2mPDqwyQHAzSQzm28tiaiuvSmUIL1urw8EK/dj+9zWTlCpqHAyxsKnXHZMC6PPIz9jaBPFBKSEitYU3cp/8zBzqlFrWohaKH6LkeP3G3Iv8VwiSHI6RXTcXxeDPDFDkjwVrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQjn5OAq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQjn5OAq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731498326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihFa79lWHg4XosicqRTPk1PXF/qFWqemAd9gV1pBAp8=;
	b=TQjn5OAqTybwN6aT5VWBBu7exnXsIgDCj+y0NrgcC6PquMkYRqBzKJ5NKpjraD03iORI5B
	xo1ypn6CHO2yuhLLpylFNdghBiIozrXauZhNL33gPXreq35g8HnGP8SVbqCca8ktEz5rxu
	Z9OVV+FnsFQhh448r2PoI0D1G84jDcU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-GBg4O5FDNYuGP-VyYcFwjQ-1; Wed,
 13 Nov 2024 06:45:25 -0500
X-MC-Unique: GBg4O5FDNYuGP-VyYcFwjQ-1
X-Mimecast-MFC-AGG-ID: GBg4O5FDNYuGP-VyYcFwjQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A02B51955D4D
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Nov 2024 11:45:24 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 462B819560A3;
	Wed, 13 Nov 2024 11:45:23 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	williams@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 1/3] rt-tests: Detect libcpupower presence
Date: Wed, 13 Nov 2024 12:45:07 +0100
Message-ID: <20241113114509.1058593-2-tglozar@redhat.com>
In-Reply-To: <20241113114509.1058593-1-tglozar@redhat.com>
References: <20241113114509.1058593-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Tomas Glozar <tglozar@redhat.com>

Add test to detect the presence of libcpupower on the system, allowing
to conditionally build features that depend on it.

The test uses a similar mechanism to the Linux kernel's tools' feature
detection: a small C program using the library is compiled, and based on
the success of the compilation, the presence of the library is
determined.

no_libcpupower=1 may be passed to make to disable libcpupower dependency
even on systems where the library is present.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Makefile                   | 15 +++++++++++++++
 feature/Makefile           | 12 ++++++++++++
 feature/test-feature.mak   |  5 +++++
 feature/test-libcpupower.c |  8 ++++++++
 4 files changed, 40 insertions(+)
 create mode 100644 feature/Makefile
 create mode 100644 feature/test-feature.mak
 create mode 100644 feature/test-libcpupower.c

diff --git a/Makefile b/Makefile
index e2f8579..60d2f69 100644
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
+include feature/test-feature.mak
+
 VERSION = 2.7
 CC = $(CROSS_COMPILE)gcc
 AR = $(CROSS_COMPILE)ar
@@ -37,6 +39,19 @@ LDFLAGS ?=
 
 PYLIB ?= $(shell python3 -m get_pylib)
 
+# Check for optional libcpupower dependency
+ifneq ($(no_libcpupower), 1)
+ifeq ($(call test-feature,libcpupower), 0)
+CPPFLAGS += -DHAVE_LIBCPUPOWER_SUPPORT
+LDFLAGS += -lcpupower
+else
+$(warning libcpupower is missing, building without --deepest-idle-state support.)
+$(warning Please install libcpupower-dev/kernel-tools-libs-devel)
+endif
+else
+$(warning libcpupower disabled, building without --deepest-idle-state support.)
+endif
+
 # Check for errors, such as python3 not available
 ifeq (${PYLIB},)
 	undefine PYLIB
diff --git a/feature/Makefile b/feature/Makefile
new file mode 100644
index 0000000..de08121
--- /dev/null
+++ b/feature/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+all: feature-libcpupower
+
+feature-libcpupower: $(OBJDIR)/test-libcpupower.o
+
+$(OBJDIR)/test-libcpupower.o: feature/test-libcpupower.c
+	@$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< -lcpupower -o $@
+
+.PHONY: clean
+
+clean:
+	rm -f $(OBJDIR)/test-*.o
diff --git a/feature/test-feature.mak b/feature/test-feature.mak
new file mode 100644
index 0000000..0b3e51c
--- /dev/null
+++ b/feature/test-feature.mak
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+define test-feature
+$(shell $(MAKE) OBJDIR=$(OBJDIR) CFLAGS=$(CFLAGS) CPPFLAGS=$(CPPFLAGS) LDFLAGS=$(LDFLAGS) \
+-f feature/Makefile feature-$1 clean >/dev/null 2>/dev/null; echo $$?)
+endef
diff --git a/feature/test-libcpupower.c b/feature/test-libcpupower.c
new file mode 100644
index 0000000..cd16269
--- /dev/null
+++ b/feature/test-libcpupower.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <cpuidle.h>
+
+int main(void)
+{
+	int rv = cpuidle_state_count(0);
+	return rv;
+}
-- 
2.47.0

