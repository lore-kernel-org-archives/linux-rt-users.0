Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B61323C8AE
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Oct 2025 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760667901; cv=none; b=tWl52JpY9OgC6FW/TixS2bDtBU6KcqbvIJahwckbOuKes7zrN//TdwcNHSuPAneoEnqKJrEbrTC9VdyEfHyes5ZjkH1p2nvG/2RjbqtmwZRPSM5MRhYyJcoDTkEUBKxoAvNV3/x1TSj12FAejMV02k8zyf/tNq/7tnx28K9zqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760667901; c=relaxed/simple;
	bh=RX0VLADgk8kpoV8mLq63+yEpym2qBlH2QT4PauB039c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=dvEBOdJLTGWnmyGdwT1kXqUPKGqPqShvlGmcJnZCrL0G8oeHX3pwkmHmy1NngwfgfnsNmyrxM4L8AQv4315nFf07y6POErvahmoPffH8U2pK9DPoTO/H0z1FmYdUQCluSdRC7/m+mqkbwJ36OXH/rtpbn+X4go0PKg2WoAtbxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aD4zL1/S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aD4zL1/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEE2C4CEF1;
	Fri, 17 Oct 2025 02:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760667901;
	bh=RX0VLADgk8kpoV8mLq63+yEpym2qBlH2QT4PauB039c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aD4zL1/SHy2pFw7xG9XY5Z4EYFo2stPiT98xIV4Wb7XDoYAg6YK+yp5Aqzecq/ZlO
	 UabFinhi2i1MZv+q2VKjyR1ToUZFH4hK8+/qR05yQddnT9O+KTKHiuEZqCXmiO6/hG
	 BlDEUtmdQR1Ro6smEdEw+WySvrVGZjDfdbUabtLnbzA46JZrDPsvsvhPYn7fw6rvIu
	 wQGt9qlJNyYRdR8SK0+LxTxOFqpx2aaQK9T9hbmmv8FWGEpSSbbrmu5LzbtOku56/6
	 bVmWthABJ7BAlorbhcxZSHJLzZ66JKKPPVuSbR93HaRb/brezqczctABivFY3nd3b+
	 1ww/1ovuUYDdg==
From: Clark Williams <clrkwllms@kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: Derek Barbosa <debarbos@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Clark Williams <williams@redhat.com>,
	wander@redhat.com,
	marco.chiappero@suse.com,
	chris.friesen@windriver.com,
	luochunsheng@ustc.edu
Subject: [PATCH 10/12] Makefile: Add support for legacy kernels
Date: Thu, 16 Oct 2025 21:24:42 -0500
Message-ID: <20251017022444.118802-10-clrkwllms@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017022444.118802-1-clrkwllms@kernel.org>
References: <20251017022444.118802-1-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Derek Barbosa <debarbos@redhat.com>

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
Signed-off-by: Clark Williams <clrkwllms@kernel.org>
Signed-off-by: Clark Williams <williams@redhat.com>
---
 Makefile     | 40 +++++++++++++++++++++++++++++++++++++++-
 src/stalld.c |  6 ++++--
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 7234a46976aa..c09d5743b696 100644
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
@@ -200,7 +219,7 @@ install: stalld
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
index 466b6db15668..305618e577fc 100644
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
2.51.0

