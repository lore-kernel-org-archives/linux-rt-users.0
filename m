Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4988016132F
	for <linux-rt-users@vger.kernel.org>; Thu,  2 Oct 2025 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438528; cv=none; b=HxYPowN8F0z6Ev9n8MrOcJPXiCD3mNhNPB/Dynh/IDQfjXuQTMIlTz+1OcM03xMLVL9rD09RNMbAoCOKkiQvoUI1pexKhBxOCWSE0cihiYqhgQ6bCNYJg722zL8A/Jz3n4/UEHmbxj2fSWDUOgnCyyDyxjzNDClR6b4MiHUfliM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438528; c=relaxed/simple;
	bh=Dumsi7gG3uLhTgqK+0HVRDlyFTBxD0N06DhI9nUwhd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGiG3CUf7NCHWvGT/Zjg9ZsuselAQh07qvbct26fzS5CdDKqDZz7vrPnh4uU+6EWJWy8IpnDLjkBbHCu6e/3YXmDQTm2LWGSnASZiSLWK+qc+oob0+7pQBnrNoQsjPiQ26gzBUgtDt/3L+RZmSBE1Pr6MKX2xi4YSahtMVQQfxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxDN20h0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxDN20h0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759438525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBUQOF25x3mRKi5WXW1WIbqUUotLZ6uij72l96dWkRw=;
	b=dxDN20h099j/MBk0FL7QIc+QrMMYcfLiYRAzoAtlWNODey3ATOXKgbmQ/RY7btptn1w5ay
	35qRO/zQqEKirs6tcDkdL3cdEwXWlBn35PLMZxzaz9orhOUP7AkmSd70fqybgH0E4V3oAz
	aEPCOIs3psJIGCjdnkKZXreBh2qzgSM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-3k_7aetAOZeA3R7vGWhbTQ-1; Thu,
 02 Oct 2025 16:55:24 -0400
X-MC-Unique: 3k_7aetAOZeA3R7vGWhbTQ-1
X-Mimecast-MFC-AGG-ID: 3k_7aetAOZeA3R7vGWhbTQ_1759438523
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38DE31800577;
	Thu,  2 Oct 2025 20:55:23 +0000 (UTC)
Received: from localhost (unknown [10.22.65.65])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D8581955F19;
	Thu,  2 Oct 2025 20:55:22 +0000 (UTC)
From: Derek Barbosa <debarbos@redhat.com>
To: clrkwllms@kernel.org
Cc: linux-rt-users@vger.kernel.org,
	wander@redhat.com,
	debarbos@redhat.com
Subject: [PATCH 2/3] Makefile: Add support for legacy kernels
Date: Thu,  2 Oct 2025 16:55:14 -0400
Message-ID: <20251002205515.1299816-3-debarbos@redhat.com>
In-Reply-To: <20251002205515.1299816-1-debarbos@redhat.com>
References: <20251002205515.1299816-1-debarbos@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In the sched_debug backend code, we conditionally parse the running
tasks block of the sched_debug file to support the older task format (as
denoted by OLD_TASK_FORMAT).

This task format is only present on legacy 3.X kernels. However, on said
legacy kernels, the current Makefile directives and #if macros in the
stalld.c code do not fully support compilation of stalld.

Add a LEGACY check to the makefile, which parses `uname -r` output for
the major kernel version, and adds a LEGACY compilation flag to the
CFLAGS. Use the compilation flag to default to sched_debug_backend in
the stalld.c file to avoid missing references to the queue_track code.

Also, disable Intel CET -fcf-protection and BPF support, remove
annocheck targets, and default to the c99 compiler (if present).

Signed-off-by: Derek Barbosa <debarbos@redhat.com>
---
 Makefile     | 40 +++++++++++++++++++++++++++++++++++++++-
 src/stalld.c |  6 ++++--
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 7234a46..c09d574 100644
--- a/Makefile
+++ b/Makefile
@@ -9,6 +9,14 @@ ARCH=$(shell uname -m)
 endif
 $(info ARCH=$(ARCH))
 
+LEGACY_VER := 3
+ifeq ($(strip $(KERNEL_VER)),)
+KERNEL_VER=$(shell uname -r | cut -f 1 -d .)
+endif
+$(info Kernel Major Version is $(KERNEL_VER))
+
+IS_LEGACY:= $(shell test $(KERNEL_VER) -le $(LEGACY_VER) && echo "true" || echo "false")
+
 USE_BPF := 1
 FCF_PROTECTION := -fcf-protection
 MTUNE	:= -mtune=generic
@@ -33,6 +41,10 @@ ifeq ($(ARCH),powerpc)
 USE_BPF := 0
 MTUNE := -mtune=powerpc
 endif
+ifeq ($(IS_LEGACY),true)
+USE_BPF := 0
+FCF_PROTECTION := 
+endif
 
 $(info USE_BPF=$(USE_BPF))
 $(info FCF_PROTECTION=$(FCF_PROTECTION))
@@ -57,6 +69,7 @@ DEFS	:=	-DUSE_BPF=$(USE_BPF) -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_S
 
 # note that RPMCFLAGS and RPMLDFLAGS are variables that come from the specfile when
 # building for Fedora/CentOS/RHEL/et al
+#
 
 ifeq ($(RPMCFLAGS),)
 CFLAGS	:=	-DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(SOPTS) $(DEFS)
@@ -64,6 +77,12 @@ else
 CFLAGS	:=	 $(RPMCFLAGS) $(DEFS)
 endif
 
+ifeq ($(IS_LEGACY),true)
+$(info Compiling with Legacy Mode enabled)
+$(info Overwriting RPMCFLAGS...)
+CFLAGS	:=	-DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(DEFS) -std=c99 -DLEGACY
+endif
+
 ifeq ($(DEBUG),0)
 CFLAGS	+=	-g -O2
 else
@@ -200,7 +219,7 @@ uninstall:
 	rm -f $(DESTDIR)$(BINDIR)/throttlectl
 	make -C systemd DESTDIR=$(INSPATH) uninstall
 
-.PHONY: clean tarball systemd push annocheck
+.PHONY: clean tarball systemd push annocheck help
 clean:
 	@test ! -f stalld || rm stalld
 	@test ! -f stalld-static || rm stalld-static
@@ -221,3 +240,22 @@ tarball:  clean
 
 annocheck: stalld
 	annocheck --ignore-unknown --verbose --profile=el10 --debug-dir=/usr/lib/debug/ ./stalld
+
+help:
+	@echo  'Cleaning targets:'
+	@echo  '  clean            - Clean the main executable, tests, objects, and tarballs.'
+	@echo  ''
+	@echo 'Building targets:'
+	@echo '  stalld            - Build the main executable (stalld).'
+	@echo '  static            - Build a statically linked executable (stalld-static).'
+	@echo '  tests             - Run tests in the "tests" subdirectory.'
+	@echo '  tarball           - Create a source tarball: $(NAME)-$(VERSION).tar.$(CEXT)'
+	@echo ''
+	@echo 'Installation targets:'
+	@echo '  install           - Install the executable, man page, docs, and licenses.'
+	@echo '  uninstall         - Remove all installed files.'
+	@echo ''
+	@echo 'Utility targets:'
+	@echo '  annocheck         - Run the annocheck security analysis tool on the stalld executable.'
+	@echo '  help              - Display this help message.'
+
diff --git a/src/stalld.c b/src/stalld.c
index 4c00158..b47d21c 100644
--- a/src/stalld.c
+++ b/src/stalld.c
@@ -153,14 +153,16 @@ int config_reservation = 0;
 
 /*
  * Select a backend.
- * Note that eBPF not supported on i686 and powerpc
+ * Note that eBPF not supported on i686, powerpc, and on x86 3.X kernels.
  */
-#if !__powerpc__ && !__i386__
+#if !__powerpc__ && !__i386__ && !LEGACY
 struct stalld_backend *backend = &queue_track_backend;
 #else
 struct stalld_backend *backend = &sched_debug_backend;
 #endif
 
+
+
 /*
  * Set of CPUs in which stalld should run.
  */
-- 
2.50.0

