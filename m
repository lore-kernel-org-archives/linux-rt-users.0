Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C01403EA1
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152975; cv=none; b=opYNgTOlGib1OtFlwlXybK0cMsstQWGQDHShnhfv+VEVuK7YjWLi3br9uFFHg/xvJlhqi/Gr22vTMOC4U4E9ZsTy6tOMv9FESYAbMoJri+ILUZuVuQ55VXyD4d7Zx4Fy07N6bdhN0jtLe1yA4LOJGfNlQxn/i1uRoHIQc+qMPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152975; c=relaxed/simple;
	bh=tkIIAiYKIAQyADhbxVMP2VejaGWBqGzACObGGbiJAP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxUWfNrDqb7TzAsqbw2m7OdUdQQmMmTqRZMweTKuXHoIoEaJik5FkyT8NyDtcVQSTTqbIzGZ5PO4MbyQk91vl+xRrPFpw/QYRF0UX/P6wSaT7UbCxg+g+POlf9YMqT2LyXTs7t1ck338Br1Df1gFla7h31wFNGYIvcjfjqou/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nboO9sml; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nboO9sml"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-90e7c71f86eso9899666d6.1
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 11:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789152967; x=1789757767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tZBosJrRFcMFa5V4qsdwDcVA33Oe7Ah8EzmsZ2FOvus=;
        b=nboO9sml0pyouxktSaJzZ5bGyqRfjYUdU/IbQ+/ZaJi4lg5YCmDs9imrpj2jQOo9MU
         5z5Ec5SxZkluIFmNyZqNtp1kjJCTFw3sJAAwaY//R6po60NV1NFqOEA46ZAj3H2gyqad
         zoN0Dy/kV4Ja09xl1A+m7WHzUR3Oqbc8+EYKTXVMnIpIply/hikGdAF3XMOdNCIpuMk/
         ed0EzjW4FVIAMB3RARDoWcp6punXDsnYku2/vAPd3aFJEBXQ1lTweBvMZICwvGQ+KL8b
         gGCPTnXu/nGAu6pFVAEGOmhFfalJjBaCQ/X/+eWWEBEvI37UFzkt+JeuPGyj+RVlIat+
         0RDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789152967; x=1789757767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tZBosJrRFcMFa5V4qsdwDcVA33Oe7Ah8EzmsZ2FOvus=;
        b=C4TMUoEGcbwldGhIiO3UHZV0aJ/8SqmQ+3/GRso2qLkwyG8oYrAPRNcLhudsoiC1Br
         anP2qjGA2bbMJPWqQhGCjw9EUFXsjfvCsEVeYpcOYYJrOU7FTkAVOjmd5veYiZE2SAtc
         02wESbLue1COFEFQHzT39zh00UgoOpmV9ditSDiJDQk/mzbamVlO5LhZTM5MxBBRf0r7
         pjTfftU0b/GEt1Yun5sAT8t/s4lI8PlktatLEIwifJv5AzcF5Y2VkPDsdS/xnFUGHz1X
         wf+3t4zqqe7JWqcu/7C9Q4prX9T+5+oyBV8x4N9czchDsVOfZjD7evD4vYBdoUDG12t4
         xvZQ==
X-Gm-Message-State: AFuF++lZuHSqYtrSBQbNSNaJPD7MYcN7ACOHFo/znKMgTow739r+mhXd
	BvTPYjICsarYfHQcsoTnaiFnPal9cO4Rc94+Qcz2sfpJ/1qjR4mJBih9K3ue8A==
X-Gm-Gg: AYBFou0lF3U3PgY0HLSlTiCd5wex+/PSIHfn2Pv411by6EO6j7vgKXmv5Gf4LEfawns
	BmFWTmRXjSAcxkPMquGW3HYBP+fvCBawrHBB19CHJ7pRTjY6ulIaaUlT4c0OGqfxhVsou5SAyUo
	rpUyIjnxLLGEsVv+vJ1mh5I0ez+QqKUN07KYfg2r4/MXwg6PgmGEdmgtuh0RMS8Ed6HLFZoE03g
	0sk4cCupBa2+kBj0oMxPBI3q2Faa6ErMsXz4miM50Rn61VgiEtM0VA1ROgNGBYItIqrj5xDluuS
	anVeohxhPKOFBNBZMstOt0TjzLpoVsRZ+KpuKg3Utr8klfUByYLtbwxqWZyNR9ZoZycO8Bv3Zum
	f2fN2xqvkqnZWlaXc8vpveCOgKd0LDCjDNmmRbAHvtVtQR//RFibGjKqLbB/+6wpHQNiOSb++dK
	TmK04NWdi4bXoTxQbsMDnRIuYOL3f1tEzXXK5wy/bEYrc6U0+YpG7nctu9+m0ihICmc+sZeBi9K
	clWCot8iPsA/PXite/4sWmxRHClbaJnzxiAWY4esRz+17uu98YXVFRLMxXoZq1B
X-Received: by 2002:a05:6214:2301:b0:910:6f24:2816 with SMTP id 6a1803df08f44-912120d76d0mr75078966d6.18.1789152967298;
        Fri, 11 Sep 2026 11:56:07 -0700 (PDT)
Received: from Cumhall.redhat.corp ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4920c5sm27254726d6.32.2026.09.11.11.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:56:06 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 02/10] rteval: Default make to help and make test-all run every test suite
Date: Fri, 11 Sep 2026 14:55:35 -0400
Message-ID: <20260911185549.604199-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911185549.604199-1-jkacur@redhat.com>
References: <20260911185549.604199-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running "make" with no target ran the first target in the Makefile
(e2e-tests), which unexpectedly launched the root-requiring end-to-end
suite. Set .DEFAULT_GOAL to help so a bare "make" prints the list of
targets instead, and update the help text to mark help as the default.

Rework the test-all target so it genuinely runs every test suite -
unit, e2e, regression and cpuset - via recursive make, with the
root-privilege check performed first. Previously test-all only ran
unittest discovery and silently skipped the e2e, regression and cpuset
tests, making its name misleading.

Replace the hardcoded, stale test list in tests/run_tests.sh (which
referenced a nonexistent test_another_feature.py and omitted several
real tests) with dynamic discovery of tests/test_*.py and
tests/unittest-legacy.py, so unit-tests picks up test files
automatically instead of missing them.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile           | 17 +++++++++++------
 tests/run_tests.sh | 32 ++++++++++++--------------------
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/Makefile b/Makefile
index 869d42d7eb11..ae033e7d73d1 100644
--- a/Makefile
+++ b/Makefile
@@ -18,6 +18,8 @@ KLOAD	:=	$(LOADDIR)/linux-6.17.7.tar.xz
 BLOAD	:=	$(LOADDIR)/dbench-4.0.tar.gz
 LOADS	:=	$(KLOAD) $(BLOAD)
 
+.DEFAULT_GOAL := help
+
 e2e-tests: rteval-cmd
 	PYTHON="$(PYTHON)" RTEVAL="$(HERE)/rteval-cmd" RTEVAL_PKG="$(HERE)" prove -o -f -v tests/e2e/
 
@@ -70,15 +72,17 @@ mcp-tests:
 tests: unit-tests
 
 test-all:
-	@echo "Running ALL tests (including root-required tests)..."
-	@echo ""
 	@if [ "$$(id -u)" != "0" ]; then \
 		echo "ERROR: test-all must be run as root"; \
 		echo "Usage: sudo make test-all"; \
 		exit 1; \
 	fi
-	@echo "Running unit tests (including root-required)..."
-	$(PYTHON) -m unittest discover -s tests -p "test_*.py" -v
+	@echo "Running ALL tests (unit + e2e + regression + cpuset)..."
+	@echo ""
+	$(MAKE) unit-tests
+	$(MAKE) e2e-tests
+	$(MAKE) regression-tests
+	$(MAKE) cpuset-tests
 
 clean:
 	rm -f *~ rteval/*~ rteval/*.py[co] *.tar.bz2 *.tar.gz doc/*~
@@ -139,7 +143,8 @@ help:
 	@echo ""
 	@echo "rteval Makefile targets:"
 	@echo ""
-	@echo "        runit:            do a short testrun locally [default]"
+	@echo "        help:             show this help message [default]"
+	@echo "        runit:            do a short testrun locally"
 	@echo "        tests:            run unit tests (alias for unit-tests)"
 	@echo "        unit-tests:       run unit tests"
 	@echo "        mcp-tests:        run MCP server tests (requires rteval result files)"
@@ -165,4 +170,4 @@ tags:
 cleantags:
 	rm -f tags
 
-.PHONY: tests unit-tests mcp-tests test-all e2e-tests regression-tests cpuset-tests uninstall
+.PHONY: help tests unit-tests mcp-tests test-all e2e-tests regression-tests cpuset-tests uninstall
diff --git a/tests/run_tests.sh b/tests/run_tests.sh
index d61616070cec..2dbf9f9effb6 100755
--- a/tests/run_tests.sh
+++ b/tests/run_tests.sh
@@ -50,28 +50,20 @@ run_test() {
     echo ""
 }
 
-# Find and run all test files in tests/
+# Find and run all Python test files in tests/
+# Discovered dynamically so new test files are picked up automatically:
+#   - tests/test_*.py          (unittest-based and script-style tests)
+#   - tests/unittest-legacy.py (legacy custom harness, does not match test_*.py)
 if [ -d "tests" ]; then
-    # Run test_measurement_module_selection.py
-    if [ -f "tests/test_measurement_module_selection.py" ]; then
-        run_test "tests/test_measurement_module_selection.py"
+    shopt -s nullglob
+    test_files=(tests/test_*.py tests/unittest-legacy.py)
+    if [ ${#test_files[@]} -eq 0 ]; then
+        echo -e "${RED}Error: no test files found in tests/${NC}"
+        exit 1
     fi
-
-    # Run test_core_sharing_validation.py
-    if [ -f "tests/test_core_sharing_validation.py" ]; then
-        run_test "tests/test_core_sharing_validation.py"
-    fi
-
-    # Run test_cpusetmanager.py (non-root tests only)
-    if [ -f "tests/test_cpusetmanager.py" ]; then
-        run_test "tests/test_cpusetmanager.py"
-    fi
-
-    # Add more tests here as they are created
-    # Example:
-    # if [ -f "tests/test_another_feature.py" ]; then
-    #     run_test "tests/test_another_feature.py"
-    # fi
+    for test_file in "${test_files[@]}"; do
+        run_test "$test_file"
+    done
 else
     echo -e "${RED}Error: tests/ directory not found${NC}"
     exit 1
-- 
2.55.0

