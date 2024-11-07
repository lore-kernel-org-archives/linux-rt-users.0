Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A82847F4A
	for <linux-rt-users@vger.kernel.org>; Thu,  7 Nov 2024 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992901; cv=none; b=JQUOaZ8FOV0wKDywp8+v7CYZXPqfcW6Lf/rbYP3uq77+Cwd6UIdAzM3saTBn3TCIyDs+xAANpDULnUcX0Qn1fPBMoMrl+8SeJmcttyHlI6gCplnFNv+UHK3AF26G4y6Rv/gTkVEHAYLKh309NxoHckH37j0KXo5NfuFrhoN6QjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992901; c=relaxed/simple;
	bh=X2fvr7y0JHZUySNME+rg/OWJIu4X2RbzzF8Fg50Jvwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CWSEQY+RfOLEePBElGlg4QDGvTxy1kUd9q4/hlrYFAjIoMINw2nFtNfCMpPU5xZFsO2+qAgOESPUh17HtrBwJK7CPXcy1RfzXK71VtBLY67M9DwSfXqy+zHlQgWlkn4Rp6NZXF51k4OUjYKTG2ygZVezb6ZKzWJVO7SxYiLLboI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dRysVTU1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRysVTU1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730992898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TFPSeBodkpT99ZllawF8ujFQp0nsd4RUuEyB1f+dFqg=;
	b=dRysVTU1u8RoE+Zy8OWdQUdO7dvno/d/PxdC75sWCj4l2GyoR8g40KceKhehWrHtbvtNo7
	Q5dwXbcyB0uMD7patzL7ioou90VxBOuHuQXYpKMLLF0DCtiG2bFH5K2/Luf6rnXH9ULPUm
	ci5Zry9wfqEeJ+W5Yng6P9r8hhi6mD4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-Q3ipJkIwMiOMUt6gtOcEdw-1; Thu,
 07 Nov 2024 10:21:37 -0500
X-MC-Unique: Q3ipJkIwMiOMUt6gtOcEdw-1
X-Mimecast-MFC-AGG-ID: Q3ipJkIwMiOMUt6gtOcEdw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E1D11955DC4
	for <linux-rt-users@vger.kernel.org>; Thu,  7 Nov 2024 15:21:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.42])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEA731956054;
	Thu,  7 Nov 2024 15:21:13 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	williams@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 1/2] rt-tests: Detect libcpupower presence
Date: Thu,  7 Nov 2024 16:20:48 +0100
Message-ID: <20241107152049.822810-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Tomas Glozar <tglozar@redhat.com>

Add test to detect the presence of libcpupower on the system, allowing
to conditionally build features that depend on it.

The test uses a similar mechanism to the Linux kernel's tools' feature
detection: a small C program using the library is compiled, and based on
the success of the compilation, the presence of the library is
determined.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Makefile                   | 11 +++++++++++
 feature/Makefile           | 12 ++++++++++++
 feature/test-feature.mak   |  4 ++++
 feature/test-libcpupower.c |  8 ++++++++
 4 files changed, 35 insertions(+)
 create mode 100644 feature/Makefile
 create mode 100644 feature/test-feature.mak
 create mode 100644 feature/test-libcpupower.c

diff --git a/Makefile b/Makefile
index e2f8579..1f698cf 100644
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
+include feature/test-feature.mak
+
 VERSION = 2.7
 CC = $(CROSS_COMPILE)gcc
 AR = $(CROSS_COMPILE)ar
@@ -37,6 +39,15 @@ LDFLAGS ?=
 
 PYLIB ?= $(shell python3 -m get_pylib)
 
+# Check for optional libcpupower dependency
+ifeq ($(call test-feature,libcpupower), 0)
+CPPFLAGS += -DHAVE_LIBCPUPOWER_SUPPORT
+LDFLAGS += -lcpupower
+else
+$(warning libcpupower is missing, building without --deepest-idle-state support.)
+$(warning Please install libcpupower-dev/kernel-tools-libs-devel)
+endif
+
 # Check for errors, such as python3 not available
 ifeq (${PYLIB},)
 	undefine PYLIB
diff --git a/feature/Makefile b/feature/Makefile
new file mode 100644
index 0000000..085e3a9
--- /dev/null
+++ b/feature/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+all: feature-libcpupower
+
+feature-libcpupower: $(OBJDIR)/test-libcpupower.o
+
+$(OBJDIR)/test-libcpupower.o: feature/test-libcpupower.c
+	@$(CC) $(CFLAGS) $(CPPFLAGS) $< -lcpupower -o $@
+
+.PHONY: clean
+
+clean:
+	rm -f $(OBJDIR)/test-*.o
diff --git a/feature/test-feature.mak b/feature/test-feature.mak
new file mode 100644
index 0000000..fffddef
--- /dev/null
+++ b/feature/test-feature.mak
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+define test-feature
+$(shell $(MAKE) OBJDIR=$(OBJDIR) -f feature/Makefile feature-$1 clean >/dev/null 2>/dev/null; echo $$?)
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

