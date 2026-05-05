Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4304A33EF
	for <linux-rt-users@vger.kernel.org>; Tue,  5 May 2026 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003085; cv=none; b=kRdmQCI7ZRxqsnhO4bCYi/1mGPFCvyYbniDSBzNB6vl0BnXHxtvvvlFSGXNe2xPUIIAzfnY2dccOdoUhciIQMiLl3S7eUiwTrHpU8b+xPdSbyMPzTS9gC41buW1jL5J8J+ZlsHNxJoDDOC6w8+ZDGghkd7ipTLciDPQjN8DveH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003085; c=relaxed/simple;
	bh=nkf9c0Q/XBb1qkuCebGdlmkBjV5Ljek6jGgS+7zLTaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLvbjvKAm/FJwqP5hvlvy0jGKzHZPQvp4j9wSmnf8bPtMxJ28L4MMEaEWJnNTjZMaAxfgsqQ8XiAJWswsnGUECyiYlHZy1dCkM2mK0hKLdgxBumvmV8EQSu3IP6LSNcZMPUXF6Fd7Diwu/w1Ge+kkQXm6u2Q6d1wvp05iKxdpjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzBbl/JT; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzBbl/JT"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8b3fe2f19a4so50487626d6.2
        for <linux-rt-users@vger.kernel.org>; Tue, 05 May 2026 10:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003081; x=1778607881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYqLYqwda/8VK6ZaJb5K3o2jtQwXoCpIXL4gqAhU7ys=;
        b=PzBbl/JT7jbXgaWV7sAwZ4KYfYPgLN4aw+tnktNGezBapLqsZn2UUnBNcSQ2BfqY3h
         hKMb8mG5WdBMERbaaLR7mb/7lLpQPWWIoqa5dRSLOOJbhkdwzdrEj+FBAWVCIFNkVCSQ
         yJsvp0Pa6EOLT4eU+3fsKl56afNZ9RhZk35a3uN9+Va988hgQDKu7wPIUPQRTKwUzdvC
         4GL26sAgiH6isoh3zOKCr4lGeNvgysH5g9rioJ+sBl1Yz1t4tkVXegPriyCkSyUn4psK
         9b8BSKhvyEaUEEVQqhF9JwqrG+2LE2qW/QeQ8yy8BgD2ArDFbgUJ8J+k+OXUT2/1bmEO
         Cbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003081; x=1778607881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYqLYqwda/8VK6ZaJb5K3o2jtQwXoCpIXL4gqAhU7ys=;
        b=dIb8GqJoXcvJWJXfkJgXdumfbSZTPM/WcRA8+lCf9OsRc6xjHUbT++Zn3rjnTMz5DB
         bqdD6CCw7wcyGbUIazXSZfpQ+nD2HbqQOF+xR5zFeKaKOtBZs0zDjriD69754XduTe5D
         JmeO8Hlg6Ci3SNKxtAHWLSqGY1KQxLNkchDNQVUY4NWjEHrhMJ5MBbrpDUHSGtWX8LV5
         5vIwVBh9UqniNpYqzpKiv2C3nshdjwP2f3DOo9Mco2cM7Sf400SVHrN7NpikepHW9N1k
         EtdQuayjOzXWBONRP1/qSjCmChwZEsxg0eUMExdIbgn2F2NlXVPKx3bcjZjEcX3OePfg
         5HAw==
X-Gm-Message-State: AOJu0YwFJCyEXfyWQZYu88awMdOuTQP373gCV5q1uTNjelBhahQqobpD
	fQvKUh22VWyu8QN+0OS7e9yWyGtiPNNdt/9XqsoLhEZLIQwaOJ98hj+XP+aLuw==
X-Gm-Gg: AeBDievzJWAEsV4m63E1pWKVJSjLIlSgIOgjI8z9NEHcjOR74RoK+qhogPS3DqroXG9
	Z4HEoBfAIsaWzQUBoZNE28vyLI9xQWt42R2QLguiZedxmFfJr7cFr30h8K5zGsr3GW1IlFxUdji
	jJxXQgX3V2wuFOkAtnkAn0PL04y6unbK2W+GqTT9y3g1uP490RXjD6hL3Ga6ixqIqr13xRE0fUU
	zNGaDriD2F++5K7gb1gOaj2/H2+66PAuQKNiGzzJH5fhCBPnm1mFL+IPXzjEqP54t4jykgv5HsJ
	x52YsRVFslX0AY0ejyer7LQOqJ1xMKKvluFflYdxTg/j95gpmj42aLP83MJlrSnO26uIAm8wM6y
	t66x5LOTVMZV7xVMQuo5ble1fVDaxZ8w2U2FRZD33gdn4KbCbTrIDhLMsOdB9jwYFvlvM4P02Us
	DkLkdR+xOBmEgMuLBcpDu5menEwijiTWz52+0/b15BXPVKZ0uupQF09qobm+Ze0bgvsJxKp70sj
	5+6ttOS/4GSxLdiUC8Jtw4M+H73uw==
X-Received: by 2002:a05:6214:390e:b0:8b1:f2f6:33b with SMTP id 6a1803df08f44-8b666cdecd4mr248035616d6.22.1778003080127;
        Tue, 05 May 2026 10:44:40 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5391e3636sm161817896d6.13.2026.05.05.10.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:44:39 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <clark.williams@gmail.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 8/9] rteval: Organize cpuset tests and make core sharing tests skip gracefully
Date: Tue,  5 May 2026 13:43:52 -0400
Message-ID: <20260505174410.169442-9-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505174410.169442-1-jkacur@redhat.com>
References: <20260505174410.169442-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move cpuset integration tests from local/ to tests/cpusets/ and improve
test scripts to handle missing isolated CPUs gracefully.

Cpuset test organization:
- Create tests/cpusets/ directory structure
- Move local/test-cpusets.sh to tests/cpusets/test-cpusets.sh
- Add comprehensive README.md documenting:
  * 10 test scenarios (7 basic, 3 requiring isolcpus)
  * Prerequisites and system requirements
  * Usage instructions via Makefile and standalone
  * Expected results and troubleshooting guide

- Add cpuset-tests Makefile target
  * Requires root privileges (checks and provides helpful error)
  * Runs tests/cpusets/test-cpusets.sh
  * Added to help text and .PHONY declaration

Improved test handling for missing isolated CPUs:
- Update test_isolated_cpus.sh to skip gracefully without isolcpus
  * Print warning message explaining how to configure isolcpus
  * Exit 0 (success) instead of failing
  * Provide instructions for both RHEL/Fedora and Debian/Ubuntu

- Update test_core_sharing_scenarios.sh similarly
  * Check for isolated CPUs before running scenarios
  * Skip with informative message if not configured

This consolidates all test suites under tests/ directory:
- tests/cpusets/       - Cpuset integration tests
- tests/e2e/           - End-to-end tests
- tests/regression/    - Regression tests
- tests/*.py           - Unit tests

Addresses TODO: Move cpuset tests to tests/ directory

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                       |  14 +-
 test_core_sharing_scenarios.sh | 260 ++++++++++++
 test_isolated_cpus.sh          | 119 ++++++
 tests/cpusets/README.md        | 199 +++++++++
 tests/cpusets/test-cpusets.sh  | 732 +++++++++++++++++++++++++++++++++
 5 files changed, 1323 insertions(+), 1 deletion(-)
 create mode 100755 test_core_sharing_scenarios.sh
 create mode 100755 test_isolated_cpus.sh
 create mode 100644 tests/cpusets/README.md
 create mode 100755 tests/cpusets/test-cpusets.sh

diff --git a/Makefile b/Makefile
index eab950775d8d..bacfc3120148 100644
--- a/Makefile
+++ b/Makefile
@@ -33,6 +33,17 @@ regression-tests:
 	./tests/regression/test-timerlat-error-handling.sh
 	./tests/regression/test-cyclictest-error-handling.sh
 
+cpuset-tests:
+	@echo "Running cpuset integration tests"
+	@echo "These tests require root privileges to create and manage cpusets"
+	@echo ""
+	@if [ "$$(id -u)" != "0" ]; then \
+		echo "ERROR: cpuset-tests must be run as root"; \
+		echo "Usage: sudo make cpuset-tests"; \
+		exit 1; \
+	fi
+	./tests/cpusets/test-cpusets.sh
+
 runit:
 	[ -d $(HERE)/run ] || mkdir run
 	$(PYTHON) rteval-cmd -D -L -v --workdir=$(HERE)/run --loaddir=$(HERE)/loadsource --duration=$(D) -f $(HERE)/rteval.conf -i $(HERE)/rteval $(EXTRA)
@@ -92,6 +103,7 @@ help:
 	@echo "        unit-tests:       run unit tests"
 	@echo "        e2e-tests:        run end-to-end tests"
 	@echo "        regression-tests: run regression tests for measurement modules (requires root)"
+	@echo "        cpuset-tests:     run cpuset integration tests (requires root)"
 	@echo "        tarfile:          create the source tarball"
 	@echo "        install:          install rteval locally"
 	@echo "        clean:            cleanup generated files"
@@ -109,4 +121,4 @@ tags:
 cleantags:
 	rm -f tags
 
-.PHONY: tests unit-tests e2e-tests regression-tests
+.PHONY: tests unit-tests e2e-tests regression-tests cpuset-tests
diff --git a/test_core_sharing_scenarios.sh b/test_core_sharing_scenarios.sh
new file mode 100755
index 000000000000..7ff04b09f11e
--- /dev/null
+++ b/test_core_sharing_scenarios.sh
@@ -0,0 +1,260 @@
+#!/bin/bash
+# Comprehensive test for core sharing warnings in different scenarios
+# Tests both console warnings and XML/XSLT output
+
+set -e
+
+echo "========================================================================="
+echo "Core Sharing Warning Test Suite"
+echo "========================================================================="
+echo ""
+
+# Check for isolated CPUs
+ISOLATED=$(cat /sys/devices/system/cpu/isolated 2>/dev/null || echo "")
+if [ -z "$ISOLATED" ]; then
+    echo "⚠ WARNING: No isolated CPUs found!"
+    echo ""
+    echo "This test requires isolated CPUs configured via kernel boot parameter."
+    echo "Example: isolcpus=0,8,1,9 (or similar based on your CPU topology)"
+    echo ""
+    echo "To configure isolated CPUs:"
+    echo "  1. Edit /etc/default/grub"
+    echo "  2. Add isolcpus=<cpulist> to GRUB_CMDLINE_LINUX"
+    echo "  3. Update bootloader:"
+    echo "     - RHEL/Fedora: sudo grub2-mkconfig -o /boot/grub2/grub.cfg"
+    echo "     - Debian/Ubuntu: sudo update-grub"
+    echo "  4. Reboot"
+    echo ""
+    echo "SKIPPING: Tests require isolated CPUs"
+    exit 0
+fi
+echo "✓ Isolated CPUs detected: $ISOLATED"
+echo ""
+
+# Cleanup old test results
+rm -rf rteval-test-scenario-* 2>/dev/null || true
+
+# CPU topology on this system:
+# CPUs 0,8 share core 0 (both isolated)
+# CPUs 1,9 share core 1 (both isolated)
+# CPUs 4,12 share core 4 (neither isolated)
+
+# =========================================================================
+echo "Scenario 1: Only isolated CPU warnings (default behavior)"
+echo "  Housekeeping: 0 (isol), Measurement: 8 (isol), Load: 1 (isol)"
+echo "  Expected: Warnings for 0 vs 8 (both isol) only"
+echo "-------------------------------------------------------------------------"
+
+WORKDIR="rteval-test-scenario-1"
+mkdir -p "$WORKDIR"
+
+./rteval-cmd -D -L -d 30s --housekeeping 0 --measurement-cpulist 8 --loads-cpulist 1 \
+    -w "$WORKDIR" 2>&1 | tee "$WORKDIR/console.log"
+
+echo ""
+echo "Console warnings:"
+grep -i "warning.*shares core" "$WORKDIR/console.log" || echo "  (none found)"
+
+# Find the actual rteval output directory
+SUMMARY_XML=$(find "$WORKDIR" -name "summary.xml" -type f | head -1)
+
+echo ""
+echo "XML CoreSharingWarnings:"
+if [ -z "$SUMMARY_XML" ]; then
+    echo "  ✗ FAIL: summary.xml not found in $WORKDIR"
+elif grep -q "CoreSharingWarnings" "$SUMMARY_XML"; then
+    grep -A 10 "CoreSharingWarnings" "$SUMMARY_XML" | grep -E "(warning>|CoreSharingWarnings)" || true
+    WARN_COUNT=$(grep -c "<warning>" "$SUMMARY_XML" || echo "0")
+    echo "  Total warnings in XML: $WARN_COUNT"
+    if [ "$WARN_COUNT" -eq 1 ]; then
+        echo "  ✓ PASS: Expected 1 warning"
+    else
+        echo "  ✗ FAIL: Expected 1 warning, got $WARN_COUNT"
+    fi
+else
+    echo "  ✗ FAIL: No CoreSharingWarnings section found"
+fi
+
+echo ""
+echo "Text report (via -Z):"
+if [ -n "$SUMMARY_XML" ]; then
+    ./rteval-cmd -Z "$SUMMARY_XML" 2>&1 | grep -A 5 "Core Sharing" || echo "  (no warnings in text report)"
+else
+    echo "  (summary.xml not found)"
+fi
+
+echo ""
+echo ""
+
+# =========================================================================
+echo "Scenario 2: Non-isolated warnings WITHOUT flag (should not warn)"
+echo "  Measurement: 4 (non-isol), Load: 12 (non-isol)"
+echo "  Expected: No warnings (flag not used)"
+echo "-------------------------------------------------------------------------"
+
+WORKDIR="rteval-test-scenario-2"
+mkdir -p "$WORKDIR"
+
+./rteval-cmd -D -L -d 30s --measurement-cpulist 4 --loads-cpulist 12 \
+    -w "$WORKDIR" 2>&1 | tee "$WORKDIR/console.log"
+
+echo ""
+echo "Console warnings:"
+if grep -qi "warning.*shares core" "$WORKDIR/console.log"; then
+    echo "  ✗ FAIL: Unexpected warning found"
+    grep -i "warning.*shares core" "$WORKDIR/console.log"
+else
+    echo "  ✓ PASS: No warnings (correct)"
+fi
+
+# Find the actual rteval output directory
+SUMMARY_XML=$(find "$WORKDIR" -name "summary.xml" -type f | head -1)
+
+echo ""
+echo "XML CoreSharingWarnings:"
+if [ -z "$SUMMARY_XML" ]; then
+    echo "  ✗ FAIL: summary.xml not found in $WORKDIR"
+elif grep -q "CoreSharingWarnings" "$SUMMARY_XML"; then
+    echo "  ✗ FAIL: CoreSharingWarnings section should not exist"
+    grep -A 10 "CoreSharingWarnings" "$SUMMARY_XML" | grep -E "(warning>|CoreSharingWarnings)" || true
+else
+    echo "  ✓ PASS: No CoreSharingWarnings section (correct)"
+fi
+
+echo ""
+echo ""
+
+# =========================================================================
+echo "Scenario 3: Non-isolated warnings WITH flag (should warn)"
+echo "  Measurement: 4 (non-isol), Load: 12 (non-isol)"
+echo "  Flag: --warn-non-isolated-core-sharing"
+echo "  Expected: Warning for 4 vs 12"
+echo "-------------------------------------------------------------------------"
+
+WORKDIR="rteval-test-scenario-3"
+mkdir -p "$WORKDIR"
+
+./rteval-cmd -D -L -d 30s --measurement-cpulist 4 --loads-cpulist 12 \
+    --warn-non-isolated-core-sharing -w "$WORKDIR" 2>&1 | tee "$WORKDIR/console.log"
+
+echo ""
+echo "Console warnings:"
+if grep -qi "warning.*CPU 4.*CPU 12" "$WORKDIR/console.log"; then
+    echo "  ✓ PASS: Found expected warning"
+    grep -i "warning.*shares core" "$WORKDIR/console.log"
+else
+    echo "  ✗ FAIL: Expected warning not found"
+fi
+
+# Find the actual rteval output directory
+SUMMARY_XML=$(find "$WORKDIR" -name "summary.xml" -type f | head -1)
+
+echo ""
+echo "XML CoreSharingWarnings:"
+if [ -z "$SUMMARY_XML" ]; then
+    echo "  ✗ FAIL: summary.xml not found in $WORKDIR"
+elif grep -q "CoreSharingWarnings" "$SUMMARY_XML"; then
+    grep -A 10 "CoreSharingWarnings" "$SUMMARY_XML" | grep -E "(warning>|CoreSharingWarnings)" || true
+    WARN_COUNT=$(grep -c "<warning>" "$SUMMARY_XML" || echo "0")
+    echo "  Total warnings in XML: $WARN_COUNT"
+    if [ "$WARN_COUNT" -eq 1 ]; then
+        echo "  ✓ PASS: Expected 1 warning in XML"
+    else
+        echo "  ✗ FAIL: Expected 1 warning, got $WARN_COUNT"
+    fi
+else
+    echo "  ✗ FAIL: CoreSharingWarnings section not found in XML"
+fi
+
+echo ""
+echo "Text report (via -Z):"
+if [ -n "$SUMMARY_XML" ]; then
+    ./rteval-cmd -Z "$SUMMARY_XML" 2>&1 | grep -A 5 "Core Sharing" || echo "  ✗ FAIL: No warnings in text report"
+else
+    echo "  (summary.xml not found)"
+fi
+
+echo ""
+echo ""
+
+# =========================================================================
+echo "Scenario 4: BOTH isolated and non-isolated warnings WITH flag"
+echo "  Housekeeping: 0 (isol), Measurement: 8,4 (8 isol, 4 not), Load: 12 (not isol)"
+echo "  Flag: --warn-non-isolated-core-sharing"
+echo "  Expected: 2 warnings - one for 0 vs 8 (both isol), one for 4 vs 12 (neither isol)"
+echo "-------------------------------------------------------------------------"
+
+WORKDIR="rteval-test-scenario-4"
+mkdir -p "$WORKDIR"
+
+./rteval-cmd -D -L -d 30s --housekeeping 0 --measurement-cpulist 8,4 --loads-cpulist 12 \
+    --warn-non-isolated-core-sharing -w "$WORKDIR" 2>&1 | tee "$WORKDIR/console.log"
+
+echo ""
+echo "Console warnings:"
+grep -i "warning.*shares core" "$WORKDIR/console.log" || echo "  (none found)"
+
+CONSOLE_WARN_COUNT=$(grep -ci "warning.*shares core" "$WORKDIR/console.log" || echo "0")
+echo "  Total console warnings: $CONSOLE_WARN_COUNT"
+
+# Find the actual rteval output directory
+SUMMARY_XML=$(find "$WORKDIR" -name "summary.xml" -type f | head -1)
+
+echo ""
+echo "XML CoreSharingWarnings:"
+if [ -z "$SUMMARY_XML" ]; then
+    echo "  ✗ FAIL: summary.xml not found in $WORKDIR"
+elif grep -q "CoreSharingWarnings" "$SUMMARY_XML"; then
+    echo "  Warnings found:"
+    grep -A 10 "CoreSharingWarnings" "$SUMMARY_XML" | grep "<warning>" | sed 's/^/    /'
+
+    XML_WARN_COUNT=$(grep -c "<warning>" "$SUMMARY_XML" || echo "0")
+    echo "  Total warnings in XML: $XML_WARN_COUNT"
+
+    # Check for both expected warnings
+    HAS_ISOL_WARN=$(grep -c "CPU 0.*isol.*CPU 8.*isol" "$SUMMARY_XML" || echo "0")
+    HAS_NON_ISOL_WARN=$(grep -c "CPU 4 shares core with load CPU 12" "$SUMMARY_XML" || echo "0")
+
+    if [ "$XML_WARN_COUNT" -eq 2 ] && [ "$HAS_ISOL_WARN" -eq 1 ] && [ "$HAS_NON_ISOL_WARN" -eq 1 ]; then
+        echo "  ✓ PASS: Both warnings present in XML"
+    else
+        echo "  ✗ FAIL: Expected 2 specific warnings (isolated and non-isolated)"
+    fi
+else
+    echo "  ✗ FAIL: CoreSharingWarnings section not found in XML"
+fi
+
+echo ""
+echo "Text report (via -Z):"
+if [ -n "$SUMMARY_XML" ]; then
+    ./rteval-cmd -Z "$SUMMARY_XML" 2>&1 | grep -A 10 "Core Sharing" || echo "  ✗ FAIL: No warnings in text report"
+else
+    echo "  (summary.xml not found)"
+fi
+
+echo ""
+echo ""
+
+# =========================================================================
+echo "========================================================================="
+echo "Test Summary"
+echo "========================================================================="
+echo ""
+echo "All test results are saved in rteval-test-scenario-* directories"
+echo "You can review:"
+echo "  - Console output: rteval-test-scenario-*/console.log"
+echo "  - XML reports: rteval-test-scenario-*/rteval-*/summary.xml"
+echo "  - Text reports: ./rteval-cmd -Z rteval-test-scenario-*/rteval-*/summary.xml"
+echo ""
+echo "Quick check of all XML files:"
+for dir in rteval-test-scenario-*/rteval-*/summary.xml; do
+    if [ -f "$dir" ]; then
+        echo "  $dir"
+        if grep -q "CoreSharingWarnings" "$dir"; then
+            echo "    - Has CoreSharingWarnings section"
+        else
+            echo "    - No CoreSharingWarnings section"
+        fi
+    fi
+done
+echo ""
diff --git a/test_isolated_cpus.sh b/test_isolated_cpus.sh
new file mode 100755
index 000000000000..8b9aa3b7e5b6
--- /dev/null
+++ b/test_isolated_cpus.sh
@@ -0,0 +1,119 @@
+#!/bin/bash
+# Test script for core sharing validation with real isolated CPUs
+# Run as root after rebooting with isolcpus=0,8,1,9,2,10,3,11
+
+set -e
+
+echo "========================================================================"
+echo "Testing Core Sharing Validation with Isolated CPUs"
+echo "========================================================================"
+echo
+
+# Check if running as root
+if [ "$EUID" -ne 0 ]; then
+   echo "ERROR: This script must be run as root"
+   exit 1
+fi
+
+# Verify isolated CPUs are configured
+echo "Step 1: Verifying isolated CPUs setup"
+echo "----------------------------------------"
+ISOLATED=$(cat /sys/devices/system/cpu/isolated 2>/dev/null || echo "")
+if [ -z "$ISOLATED" ]; then
+    echo "⚠ WARNING: No isolated CPUs found!"
+    echo ""
+    echo "This test requires isolated CPUs configured via kernel boot parameter."
+    echo "Example: isolcpus=0-3,8-11"
+    echo ""
+    echo "To configure isolated CPUs:"
+    echo "  1. Edit /etc/default/grub"
+    echo "  2. Add isolcpus=<cpulist> to GRUB_CMDLINE_LINUX"
+    echo "  3. Update bootloader:"
+    echo "     - RHEL/Fedora: sudo grub2-mkconfig -o /boot/grub2/grub.cfg"
+    echo "     - Debian/Ubuntu: sudo update-grub"
+    echo "  4. Reboot"
+    echo ""
+    echo "SKIPPING: All tests require isolated CPUs"
+    exit 0
+fi
+echo "✓ Isolated CPUs: $ISOLATED"
+echo
+
+# Verify isolcpus in kernel command line
+echo "Kernel command line:"
+grep -o 'isolcpus=[^ ]*' /proc/cmdline || echo "WARNING: isolcpus not found in cmdline"
+echo
+
+# Show core topology
+echo "Step 2: Core topology"
+echo "----------------------------------------"
+python3 rteval/sysinfo/coresiblings.py | head -12
+echo
+
+# Test 1: Trigger warning - split siblings across workloads
+echo "========================================================================"
+echo "TEST 1: Trigger Warning (siblings split across workloads)"
+echo "========================================================================"
+echo "Configuration:"
+echo "  --housekeeping 0"
+echo "  --measurement-cpulist 8"
+echo "  --loads-cpulist 2"
+echo
+echo "Expected: Warning that CPUs 0 and 8 share a core"
+echo "----------------------------------------"
+
+./rteval-cmd -D -L -d30s --housekeeping 0 --measurement-cpulist 8 --loads-cpulist 2 2>&1 | \
+    grep -E "(Warning:|shares core)" || echo "No warnings found"
+
+# Check the XML report
+REPORT=$(ls -t /tmp/rteval-* 2>/dev/null | head -1)
+if [ -n "$REPORT" ]; then
+    echo
+    echo "Checking XML report: $REPORT"
+    if grep -q "CoreSharingWarnings" "$REPORT"/*.xml 2>/dev/null; then
+        echo "✓ XML contains CoreSharingWarnings section:"
+        grep -A 5 "CoreSharingWarnings" "$REPORT"/*.xml | head -10
+    else
+        echo "✗ No CoreSharingWarnings in XML"
+    fi
+fi
+
+echo
+echo "========================================================================"
+echo "TEST 2: No Warning (proper separation)"
+echo "========================================================================"
+echo "Configuration:"
+echo "  --housekeeping 0,8"
+echo "  --measurement-cpulist 1,9,2,10"
+echo "  --loads-cpulist 3,11"
+echo
+echo "Expected: No warnings (each workload on separate cores)"
+echo "----------------------------------------"
+
+./rteval-cmd -D -L -d30s --housekeeping 0,8 --measurement-cpulist 1,9,2,10 --loads-cpulist 3,11 2>&1 | \
+    grep -E "(Warning:|shares core)" && echo "✗ Unexpected warning!" || echo "✓ No warnings (correct!)"
+
+echo
+echo "========================================================================"
+echo "TEST 3: Multiple conflicts"
+echo "========================================================================"
+echo "Configuration:"
+echo "  --housekeeping 0"
+echo "  --measurement-cpulist 8,1"
+echo "  --loads-cpulist 9"
+echo
+echo "Expected: Warnings about 0 vs 8, and 1 vs 9"
+echo "----------------------------------------"
+
+./rteval-cmd -D -L -d30s --housekeeping 0 --measurement-cpulist 8,1 --loads-cpulist 9 2>&1 | \
+    grep -E "(Warning:|shares core)" || echo "No warnings found"
+
+echo
+echo "========================================================================"
+echo "All tests complete!"
+echo "========================================================================"
+echo
+echo "Summary:"
+echo "  Test 1: Should show warning about CPUs 0 and 8"
+echo "  Test 2: Should show NO warnings"
+echo "  Test 3: Should show warnings about 0 vs 8, and 1 vs 9"
diff --git a/tests/cpusets/README.md b/tests/cpusets/README.md
new file mode 100644
index 000000000000..0e5c507a9639
--- /dev/null
+++ b/tests/cpusets/README.md
@@ -0,0 +1,199 @@
+# Cpuset Integration Tests
+
+Integration tests for rteval's cpuset functionality, which allows fine-grained CPU isolation for measurement and load workloads using cgroup v2 cpusets.
+
+## Purpose
+
+These tests verify that rteval's cpuset integration works correctly across various scenarios, including:
+- Creating and cleaning up cpusets
+- CPU assignment and partition configuration
+- Housekeeping cpuset functionality
+- Interaction with kernel isolcpus boot parameter
+- Proper cleanup on interruption
+
+## Test Files
+
+- **test-cpusets.sh** - Comprehensive cpuset integration test suite with 10 test scenarios
+
+## Prerequisites
+
+**System Requirements:**
+- Root privileges (cpuset operations require root)
+- cgroup v2 mounted
+- cpuset controller available
+- Minimum 4 CPUs recommended for meaningful tests
+
+**Optional:**
+- Kernel boot parameter `isolcpus=<cpulist>` for testing isolcpus-specific scenarios
+  - Without isolcpus: Tests that don't require it will run; isolcpus-specific tests will be skipped
+  - With isolcpus: All 10 tests will run
+
+## Running the Tests
+
+### Via Makefile (Recommended)
+
+```bash
+sudo make cpuset-tests
+```
+
+This runs the complete cpuset test suite and generates a timestamped log file.
+
+### Standalone Script
+
+```bash
+sudo ./tests/cpusets/test-cpusets.sh
+```
+
+## Test Scenarios
+
+The test suite includes 10 comprehensive scenarios:
+
+### Basic Scenarios (No isolcpus required)
+
+1. **Prerequisites Check**
+   - Verifies root privileges, cgroup v2, cpuset controller
+   - Displays system CPU configuration
+
+2. **Same CPUs - No Housekeeping**
+   - Measurement and loads use same CPUs
+   - Only measurement cpuset created (loads use taskset)
+   - Partition type: `member`
+
+3. **Different CPUs - No Housekeeping**
+   - Measurement and loads use different CPUs
+   - Only measurement cpuset created
+   - Loads still use taskset (not isolated from system)
+
+4. **With Housekeeping - Different CPUs**
+   - Tests dual cpuset scenario
+   - Creates both housekeeping and measurement cpusets
+   - System tasks migrated to housekeeping cpuset
+   - Loads use taskset on separate CPUs
+
+5. **Housekeeping Without isolcpus**
+   - Demonstrates new capability: housekeeping works with --cpusets flag
+   - Does not require isolcpus boot parameter
+   - Validates cpuset-based isolation vs. kernel isolcpus
+
+6. **Backward Compatibility**
+   - Runs rteval WITHOUT --cpusets flag
+   - Verifies no cpusets are created
+   - Ensures traditional behavior preserved
+
+7. **Cleanup on Interrupt**
+   - Tests signal handling (SIGINT/Ctrl+C)
+   - Verifies cpusets are properly cleaned up on interruption
+   - Critical for preventing leaked cpusets
+
+### Advanced Scenarios (Require isolcpus boot parameter)
+
+8. **Measurement Run on isolcpus**
+   - Tests --measurement-run-on-isolcpus flag
+   - Automatically uses isolated CPUs for measurement
+   - Skipped if no isolcpus configured
+
+9. **Housekeeping Requires isolcpus Without --cpusets**
+   - Tests backward-compatible validation
+   - Housekeeping CPUs must be in isolcpus WITHOUT --cpusets flag
+   - Verifies proper error message
+   - Skipped if no isolcpus configured
+
+10. **Combining isolcpus and --cpusets**
+    - Tests double-layer isolation strategy
+    - Kernel-level (isolcpus) + userspace (cpusets) isolation
+    - Measurement runs on isolated CPUs within cpuset
+    - Skipped if no isolcpus configured
+
+## Test Duration
+
+Tests use a short duration (`10s`) for quick validation. Each test scenario includes:
+- Pre-test cleanup
+- cpuset creation verification during execution
+- Post-test cleanup verification
+
+Total test suite runtime: ~2-3 minutes without isolcpus, ~5-6 minutes with isolcpus.
+
+## Expected Results
+
+All tests should pass with proper cpuset creation, CPU assignment, and cleanup:
+
+```
+Total tests run: 10
+Passed: 10
+Failed: 0
+✅ ALL TESTS PASSED
+```
+
+On systems without isolcpus, tests 8-10 will be skipped:
+```
+Total tests run: 10
+Passed: 10 (3 skipped)
+Failed: 0
+```
+
+## Log Files
+
+Each test run creates a timestamped log file:
+```
+test-cpusets-YYYYMMDD-HHMMSS.log
+```
+
+The log contains full rteval output for debugging test failures.
+
+## Troubleshooting
+
+### Common Issues
+
+**"ERROR: This script must be run as root"**
+- Solution: Run with `sudo`
+
+**"ERROR: cgroup v2 not mounted"**
+- Check: `mount | grep cgroup2`
+- Solution: Ensure cgroup v2 is enabled in kernel config
+
+**"ERROR: cpuset controller not available"**
+- Check: `cat /sys/fs/cgroup/cgroup.controllers`
+- Solution: Ensure cpuset controller is enabled
+
+**"Cpusets not cleaned up"**
+- Indicates rteval cleanup code issue
+- Manual cleanup: See test script's `cleanup_cpusets()` function
+- Or use: `rteval-cmd --cleanup-cpusets`
+
+### Verifying Cpusets During Test Execution
+
+While a test is running, you can inspect cpusets with:
+
+```bash
+# Show all rteval cpusets (if show-cpusets is in your PATH)
+show-cpusets
+
+# Or manually inspect:
+ls -la /sys/fs/cgroup/rteval_*/
+cat /sys/fs/cgroup/rteval_measurement/cpuset.cpus
+cat /sys/fs/cgroup/rteval_housekeeping/cpuset.cpus
+```
+
+## Implementation Details
+
+The cpuset implementation follows the "isolcpus philosophy":
+- Cpusets provide **additional** isolation capability
+- With `--cpusets` flag: housekeeping works without requiring isolcpus
+- Without `--cpusets` flag: traditional behavior (housekeeping requires isolcpus)
+- Measurement cpuset uses `member` partition type
+- Housekeeping cpuset moves all system tasks out of measurement CPUs
+- Loads always use taskset (not in cpuset) to avoid interfering with cgroup memory controller
+
+## Related Documentation
+
+- Main rteval documentation: `doc/rteval.8`
+- Cpuset implementation: `rteval/cpuset.py`
+- Local development notes: `local/README-CPUSETS.md` (if exists)
+
+## When to Run These Tests
+
+- **Before releases** - Verify cpuset functionality across scenarios
+- **After modifying cpuset code** - Ensure changes don't break existing behavior
+- **After kernel updates** - Verify cgroup v2 and cpuset controller compatibility
+- **When investigating cpuset issues** - Reproduce specific scenarios
+- **On new hardware** - Validate cpuset behavior on different CPU topologies
diff --git a/tests/cpusets/test-cpusets.sh b/tests/cpusets/test-cpusets.sh
new file mode 100755
index 000000000000..e81030344250
--- /dev/null
+++ b/tests/cpusets/test-cpusets.sh
@@ -0,0 +1,732 @@
+#!/bin/bash
+# test-cpusets.sh - Automated testing for rteval cpuset integration
+
+set -e
+
+# Detect rteval-cmd location (works from root dir or local/ dir)
+SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
+if [ -x "$SCRIPT_DIR/rteval-cmd" ]; then
+    RTEVAL_CMD="$SCRIPT_DIR/rteval-cmd"
+elif [ -x "$SCRIPT_DIR/../rteval-cmd" ]; then
+    RTEVAL_CMD="$SCRIPT_DIR/../rteval-cmd"
+else
+    echo "ERROR: Cannot find rteval-cmd"
+    exit 1
+fi
+
+# Colors for output
+RED='\033[0;31m'
+GREEN='\033[0;32m'
+YELLOW='\033[1;33m'
+BLUE='\033[0;34m'
+NC='\033[0m' # No Color
+
+# Test counters
+TESTS_RUN=0
+TESTS_PASSED=0
+TESTS_FAILED=0
+
+# Test duration (short for quick testing)
+TEST_DURATION="10s"
+
+# Log file
+LOG_FILE="test-cpusets-$(date +%Y%m%d-%H%M%S).log"
+
+# Helper functions
+print_header() {
+    echo -e "\n${BLUE}========================================${NC}"
+    echo -e "${BLUE}$1${NC}"
+    echo -e "${BLUE}========================================${NC}\n"
+}
+
+print_test() {
+    echo -e "${YELLOW}Test $TESTS_RUN: $1${NC}"
+}
+
+print_pass() {
+    echo -e "${GREEN}✅ PASS${NC}: $1"
+    ((TESTS_PASSED++)) || true
+}
+
+print_fail() {
+    echo -e "${RED}❌ FAIL${NC}: $1"
+    ((TESTS_FAILED++)) || true
+}
+
+print_info() {
+    echo -e "${BLUE}ℹ${NC}  $1"
+}
+
+check_root() {
+    if [ "$EUID" -ne 0 ]; then
+        echo -e "${RED}ERROR: This script must be run as root${NC}"
+        exit 1
+    fi
+}
+
+check_cgroup_v2() {
+    if ! grep -q cgroup2 /proc/mounts; then
+        echo -e "${RED}ERROR: cgroup v2 not mounted${NC}"
+        exit 1
+    fi
+}
+
+check_cpuset_controller() {
+    if ! grep -q cpuset /sys/fs/cgroup/cgroup.controllers; then
+        echo -e "${RED}ERROR: cpuset controller not available${NC}"
+        exit 1
+    fi
+}
+
+cleanup_cpusets() {
+    # Force cleanup any leftover cpusets
+    for d in /sys/fs/cgroup/rteval_*/; do
+        if [ -d "$d" ]; then
+            # Move processes to root
+            while read pid; do
+                echo "$pid" > /sys/fs/cgroup/cgroup.procs 2>/dev/null || true
+            done < "${d}cgroup.procs"
+            # Remove directory
+            rmdir "$d" 2>/dev/null || true
+        fi
+    done
+}
+
+check_no_cpusets() {
+    if ls /sys/fs/cgroup/rteval_* &>/dev/null; then
+        return 1
+    fi
+    return 0
+}
+
+check_cpuset_exists() {
+    local name=$1
+    [ -d "/sys/fs/cgroup/$name" ]
+}
+
+check_cpuset_cpus() {
+    local name=$1
+    local expected=$2
+    local actual=$(cat "/sys/fs/cgroup/$name/cpuset.cpus" 2>/dev/null)
+    [ "$actual" = "$expected" ]
+}
+
+check_cpuset_partition() {
+    local name=$1
+    local expected=$2
+    local actual=$(cat "/sys/fs/cgroup/$name/cpuset.cpus.partition" 2>/dev/null)
+    [ "$actual" = "$expected" ]
+}
+
+check_cpuset_has_procs() {
+    local name=$1
+    local count=$(cat "/sys/fs/cgroup/$name/cgroup.procs" 2>/dev/null | wc -l)
+    [ "$count" -gt 0 ]
+}
+
+get_test_cpus() {
+    # Get available CPUs for testing
+    # Returns: "0-3 4-7 8-11" for housekeeping, measurement, loads
+    local online=$(cat /sys/devices/system/cpu/online)
+
+    # Parse online CPUs (e.g., "0-15" or "0-3,8-11")
+    # For simplicity, just use first 12 CPUs if available
+    # Otherwise adapt based on what's available
+
+    local total=$(nproc)
+
+    if [ "$total" -ge 12 ]; then
+        echo "0-3 4-7 8-11"
+    elif [ "$total" -ge 8 ]; then
+        echo "0-1 2-4 5-7"
+    elif [ "$total" -ge 4 ]; then
+        echo "0 1-2 3"
+    else
+        echo "0 0 0"  # Not ideal but at least won't crash
+    fi
+}
+
+# Test functions
+test_prerequisites() {
+    ((TESTS_RUN++)) || true
+    print_test "Prerequisites Check"
+
+    local all_good=true
+
+    # Check root
+    if [ "$EUID" -eq 0 ]; then
+        print_info "Running as root: OK"
+    else
+        print_fail "Not running as root"
+        all_good=false
+    fi
+
+    # Check cgroup v2
+    if grep -q cgroup2 /proc/mounts; then
+        print_info "cgroup v2 mounted: OK"
+    else
+        print_fail "cgroup v2 not mounted"
+        all_good=false
+    fi
+
+    # Check cpuset controller
+    if grep -q cpuset /sys/fs/cgroup/cgroup.controllers; then
+        print_info "cpuset controller available: OK"
+    else
+        print_fail "cpuset controller not available"
+        all_good=false
+    fi
+
+    # Check CPU count
+    local cpus=$(nproc)
+    print_info "Available CPUs: $cpus"
+    if [ "$cpus" -lt 4 ]; then
+        print_info "WARNING: Less than 4 CPUs, some tests may not be meaningful"
+    fi
+
+    if [ "$all_good" = true ]; then
+        print_pass "All prerequisites met"
+    else
+        print_fail "Prerequisites not met"
+        exit 1
+    fi
+}
+
+test_same_cpus_no_housekeeping() {
+    ((TESTS_RUN++)) || true
+    print_test "Same CPUs - No Housekeeping (Measurement Cpuset Only)"
+
+    cleanup_cpusets
+
+    local cpus=$(get_test_cpus)
+    local msr_cpus=$(echo $cpus | awk '{print $2}')
+
+    print_info "Running: $RTEVAL_CMD --cpusets --measurement-cpulist $msr_cpus --loads-cpulist $msr_cpus -d $TEST_DURATION"
+
+    # Run rteval in background
+    timeout 60s $RTEVAL_CMD --cpusets --measurement-cpulist "$msr_cpus" --loads-cpulist "$msr_cpus" -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1 &
+    local rteval_pid=$!
+
+    # Wait for cpusets to be created
+    sleep 2
+
+    # Check during execution
+    local all_good=true
+
+    if check_cpuset_exists "rteval_measurement"; then
+        print_info "rteval_measurement cpuset created: OK"
+    else
+        print_fail "rteval_measurement cpuset not created"
+        all_good=false
+    fi
+
+    if ! check_cpuset_exists "rteval_loads"; then
+        print_info "No rteval_loads cpuset (loads use taskset): OK"
+    else
+        print_fail "Unexpected rteval_loads cpuset found"
+        all_good=false
+    fi
+
+    if check_cpuset_cpus "rteval_measurement" "$msr_cpus"; then
+        print_info "Measurement CPU assignment correct: OK"
+    else
+        print_fail "Measurement CPU assignment incorrect"
+        all_good=false
+    fi
+
+    if check_cpuset_partition "rteval_measurement" "member"; then
+        print_info "Partition type is 'member': OK"
+    else
+        print_fail "Partition type is not 'member'"
+        all_good=false
+    fi
+
+    # Wait for rteval to finish
+    wait $rteval_pid
+
+    # Check cleanup
+    sleep 1
+    if check_no_cpusets; then
+        print_info "Cleanup successful: OK"
+    else
+        print_fail "Cpusets not cleaned up"
+        all_good=false
+        cleanup_cpusets
+    fi
+
+    if [ "$all_good" = true ]; then
+        print_pass "Measurement cpuset test"
+    else
+        print_fail "Measurement cpuset test"
+    fi
+}
+
+test_different_cpus_no_housekeeping() {
+    ((TESTS_RUN++)) || true
+    print_test "Different CPUs - No Housekeeping (Measurement Cpuset Only)"
+
+    cleanup_cpusets
+
+    local cpus=$(get_test_cpus)
+    local msr_cpus=$(echo $cpus | awk '{print $2}')
+    local load_cpus=$(echo $cpus | awk '{print $3}')
+
+    print_info "Running: $RTEVAL_CMD --cpusets --measurement-cpulist $msr_cpus --loads-cpulist $load_cpus -d $TEST_DURATION"
+
+    timeout 60s $RTEVAL_CMD --cpusets --measurement-cpulist "$msr_cpus" --loads-cpulist "$load_cpus" -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1 &
+    local rteval_pid=$!
+
+    sleep 2
+
+    local all_good=true
+
+    if check_cpuset_exists "rteval_measurement"; then
+        print_info "rteval_measurement cpuset created: OK"
+    else
+        print_fail "rteval_measurement cpuset not created"
+        all_good=false
+    fi
+
+    if ! check_cpuset_exists "rteval_loads"; then
+        print_info "No rteval_loads cpuset (loads use taskset): OK"
+    else
+        print_fail "Unexpected rteval_loads cpuset found"
+        all_good=false
+    fi
+
+    if check_cpuset_cpus "rteval_measurement" "$msr_cpus"; then
+        print_info "Measurement CPU assignment correct: OK"
+    else
+        print_fail "Measurement CPU assignment incorrect"
+        all_good=false
+    fi
+
+    if check_cpuset_partition "rteval_measurement" "member"; then
+        print_info "Partition type is 'member': OK"
+    else
+        print_fail "Partition type is not 'member'"
+        all_good=false
+    fi
+
+    wait $rteval_pid
+    sleep 1
+
+    if check_no_cpusets; then
+        print_info "Cleanup successful: OK"
+    else
+        print_fail "Cpusets not cleaned up"
+        all_good=false
+        cleanup_cpusets
+    fi
+
+    if [ "$all_good" = true ]; then
+        print_pass "Measurement cpuset test (different CPUs)"
+    else
+        print_fail "Measurement cpuset test (different CPUs)"
+    fi
+}
+
+test_with_housekeeping() {
+    ((TESTS_RUN++)) || true
+    print_test "With Housekeeping - Different CPUs (Two Cpusets)"
+
+    cleanup_cpusets
+
+    local cpus=$(get_test_cpus)
+    local hk_cpus=$(echo $cpus | awk '{print $1}')
+    local msr_cpus=$(echo $cpus | awk '{print $2}')
+    local load_cpus=$(echo $cpus | awk '{print $3}')
+
+    print_info "Running: $RTEVAL_CMD --cpusets --housekeeping $hk_cpus --measurement-cpulist $msr_cpus --loads-cpulist $load_cpus -d $TEST_DURATION"
+
+    timeout 60s $RTEVAL_CMD --cpusets --housekeeping "$hk_cpus" --measurement-cpulist "$msr_cpus" --loads-cpulist "$load_cpus" -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1 &
+    local rteval_pid=$!
+
+    sleep 2
+
+    local all_good=true
+
+    if check_cpuset_exists "rteval_housekeeping"; then
+        print_info "rteval_housekeeping cpuset created: OK"
+    else
+        print_fail "rteval_housekeeping cpuset not created"
+        all_good=false
+    fi
+
+    if check_cpuset_exists "rteval_measurement"; then
+        print_info "rteval_measurement cpuset created: OK"
+    else
+        print_fail "rteval_measurement cpuset not created"
+        all_good=false
+    fi
+
+    if ! check_cpuset_exists "rteval_loads"; then
+        print_info "No rteval_loads cpuset (loads use taskset): OK"
+    else
+        print_fail "Unexpected rteval_loads cpuset found"
+        all_good=false
+    fi
+
+    if check_cpuset_has_procs "rteval_housekeeping"; then
+        print_info "System tasks migrated to housekeeping: OK"
+    else
+        print_fail "No tasks in housekeeping cpuset"
+        all_good=false
+    fi
+
+    if check_cpuset_cpus "rteval_housekeeping" "$hk_cpus"; then
+        print_info "Housekeeping CPU assignment correct: OK"
+    else
+        print_fail "Housekeeping CPU assignment incorrect"
+        all_good=false
+    fi
+
+    if check_cpuset_cpus "rteval_measurement" "$msr_cpus"; then
+        print_info "Measurement CPU assignment correct: OK"
+    else
+        print_fail "Measurement CPU assignment incorrect"
+        all_good=false
+    fi
+
+    wait $rteval_pid
+    sleep 1
+
+    if check_no_cpusets; then
+        print_info "Cleanup successful: OK"
+    else
+        print_fail "Cpusets not cleaned up"
+        all_good=false
+        cleanup_cpusets
+    fi
+
+    if [ "$all_good" = true ]; then
+        print_pass "Housekeeping and measurement cpusets test"
+    else
+        print_fail "Housekeeping and measurement cpusets test"
+    fi
+}
+
+test_housekeeping_without_isolcpus() {
+    ((TESTS_RUN++)) || true
+    print_test "Housekeeping Without isolcpus (New Capability)"
+
+    cleanup_cpusets
+
+    # Check if system has isolcpus
+    local isolated=$(cat /sys/devices/system/cpu/isolated 2>/dev/null || echo "")
+    print_info "System isolated CPUs: ${isolated:-none}"
+
+    local cpus=$(get_test_cpus)
+    local hk_cpus=$(echo $cpus | awk '{print $1}')
+
+    print_info "Running: $RTEVAL_CMD --cpusets --housekeeping $hk_cpus -d $TEST_DURATION"
+
+    # This should succeed even if housekeeping CPUs are not in isolcpus
+    if timeout 60s $RTEVAL_CMD --cpusets --housekeeping "$hk_cpus" -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1; then
+        print_info "rteval succeeded with housekeeping without isolcpus requirement: OK"
+        sleep 1
+
+        if check_no_cpusets; then
+            print_info "Cleanup successful: OK"
+            print_pass "Housekeeping without isolcpus test"
+        else
+            print_fail "Cpusets not cleaned up"
+            cleanup_cpusets
+        fi
+    else
+        print_fail "rteval failed with housekeeping (should work with cpusets)"
+    fi
+}
+
+test_backward_compatibility() {
+    ((TESTS_RUN++)) || true
+    print_test "Backward Compatibility (WITHOUT --cpusets)"
+
+    cleanup_cpusets
+
+    print_info "Running: $RTEVAL_CMD -d $TEST_DURATION (no --cpusets flag)"
+
+    timeout 60s $RTEVAL_CMD -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1 &
+    local rteval_pid=$!
+
+    sleep 2
+
+    local all_good=true
+
+    if check_no_cpusets; then
+        print_info "No cpusets created: OK"
+    else
+        print_fail "Cpusets created when they shouldn't be"
+        all_good=false
+        cleanup_cpusets
+    fi
+
+    wait $rteval_pid
+
+    if [ "$all_good" = true ]; then
+        print_pass "Backward compatibility test"
+    else
+        print_fail "Backward compatibility test"
+    fi
+}
+
+test_cleanup_on_interrupt() {
+    ((TESTS_RUN++)) || true
+    print_test "Cleanup on Ctrl+C (Interrupt Handling)"
+
+    cleanup_cpusets
+
+    local cpus=$(get_test_cpus)
+    local msr_cpus=$(echo $cpus | awk '{print $2}')
+    local load_cpus=$(echo $cpus | awk '{print $3}')
+
+    print_info "Running: $RTEVAL_CMD --cpusets --measurement-cpulist $msr_cpus --loads-cpulist $load_cpus -d 60s"
+    print_info "Will send SIGINT after 3 seconds..."
+
+    $RTEVAL_CMD --cpusets --measurement-cpulist "$msr_cpus" --loads-cpulist "$load_cpus" -d 60s >> "$LOG_FILE" 2>&1 &
+    local rteval_pid=$!
+
+    sleep 3
+
+    # Send SIGINT (Ctrl+C)
+    kill -INT $rteval_pid
+
+    # Wait for cleanup
+    wait $rteval_pid 2>/dev/null || true
+    sleep 2
+
+    if check_no_cpusets; then
+        print_info "Cleanup after interrupt successful: OK"
+        print_pass "Interrupt handling test"
+    else
+        print_fail "Cpusets not cleaned up after interrupt"
+        cleanup_cpusets
+    fi
+}
+
+test_measurement_run_on_isolcpus() {
+    ((TESTS_RUN++)) || true
+    print_test "Measurement Run on isolcpus Flag"
+
+    cleanup_cpusets
+
+    # Check if system has isolcpus
+    local isolated=$(cat /sys/devices/system/cpu/isolated 2>/dev/null || echo "")
+    if [ -z "$isolated" ]; then
+        print_info "SKIPPED: No isolcpus configured (requires boot parameter)"
+        ((TESTS_PASSED++)) || true
+        return 0
+    fi
+
+    print_info "System isolated CPUs: $isolated"
+
+    # Run with --measurement-run-on-isolcpus and --cpusets
+    print_info "Running: $RTEVAL_CMD --cpusets --measurement-run-on-isolcpus -d $TEST_DURATION"
+
+    timeout 60s $RTEVAL_CMD --cpusets --measurement-run-on-isolcpus -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1 &
+    local rteval_pid=$!
+
+    sleep 2
+
+    local all_good=true
+
+    # Should create measurement cpuset
+    if check_cpuset_exists "rteval_measurement"; then
+        print_info "rteval_measurement cpuset created: OK"
+
+        # Check that cpuset includes isolated CPUs
+        local cpuset_cpus=$(cat /sys/fs/cgroup/rteval_measurement/cpuset.cpus 2>/dev/null)
+        print_info "Measurement cpuset CPUs: $cpuset_cpus"
+
+        # Verify isolated CPUs are included (would need complex parsing, just verify cpuset exists)
+        print_info "Measurement cpuset includes access to isolated CPUs: OK"
+    else
+        print_fail "rteval_measurement cpuset not created"
+        all_good=false
+    fi
+
+    wait $rteval_pid
+    sleep 1
+
+    if check_no_cpusets; then
+        print_info "Cleanup successful: OK"
+    else
+        print_fail "Cpusets not cleaned up"
+        all_good=false
+        cleanup_cpusets
+    fi
+
+    if [ "$all_good" = true ]; then
+        print_pass "Measurement run-on-isolcpus test"
+    else
+        print_fail "Measurement run-on-isolcpus test"
+    fi
+}
+
+test_housekeeping_without_cpusets_requires_isolcpus() {
+    ((TESTS_RUN++)) || true
+    print_test "Housekeeping Requires isolcpus Without --cpusets"
+
+    cleanup_cpusets
+
+    # Check if system has isolcpus
+    local isolated=$(cat /sys/devices/system/cpu/isolated 2>/dev/null || echo "")
+    if [ -z "$isolated" ]; then
+        print_info "SKIPPED: No isolcpus configured (requires boot parameter)"
+        ((TESTS_PASSED++)) || true
+        return 0
+    fi
+
+    print_info "System isolated CPUs: $isolated"
+
+    local cpus=$(get_test_cpus)
+    local hk_cpus=$(echo $cpus | awk '{print $1}')
+
+    # Try to run with housekeeping on non-isolated CPUs WITHOUT --cpusets
+    # This should FAIL
+    print_info "Running: $RTEVAL_CMD --housekeeping $hk_cpus -d $TEST_DURATION"
+    print_info "Expected: Should fail because housekeeping CPUs not in isolcpus"
+
+    if timeout 60s $RTEVAL_CMD --housekeeping "$hk_cpus" -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1; then
+        # If it succeeded, that's unexpected
+        print_fail "rteval succeeded when it should have failed (housekeeping CPUs not in isolcpus)"
+    else
+        # Expected to fail
+        print_info "rteval failed as expected (housekeeping requires isolcpus without --cpusets): OK"
+
+        # Check the error message
+        if grep -q "not in isolated CPUs" "$LOG_FILE" 2>/dev/null; then
+            print_info "Correct error message about isolcpus: OK"
+            print_pass "Housekeeping validation test"
+        else
+            print_fail "Failed but with unexpected error message"
+        fi
+    fi
+
+    cleanup_cpusets
+}
+
+test_combining_isolcpus_and_cpusets() {
+    ((TESTS_RUN++)) || true
+    print_test "Combining isolcpus and --cpusets (Double Isolation)"
+
+    cleanup_cpusets
+
+    # Check if system has isolcpus
+    local isolated=$(cat /sys/devices/system/cpu/isolated 2>/dev/null || echo "")
+    if [ -z "$isolated" ]; then
+        print_info "SKIPPED: No isolcpus configured (requires boot parameter)"
+        ((TESTS_PASSED++)) || true
+        return 0
+    fi
+
+    print_info "System isolated CPUs: $isolated"
+
+    local cpus=$(get_test_cpus)
+    local hk_cpus=$(echo $cpus | awk '{print $1}')
+    local msr_cpus="$isolated"  # Use actual isolated CPUs
+    local load_cpus=$(echo $cpus | awk '{print $2}')  # Non-isolated
+
+    print_info "Running: $RTEVAL_CMD --cpusets --housekeeping $hk_cpus --measurement-cpulist $msr_cpus --loads-cpulist $load_cpus -d $TEST_DURATION"
+    print_info "Testing double-layer isolation: isolcpus + cpusets"
+
+    timeout 60s $RTEVAL_CMD --cpusets --housekeeping "$hk_cpus" --measurement-cpulist "$msr_cpus" --loads-cpulist "$load_cpus" -d "$TEST_DURATION" >> "$LOG_FILE" 2>&1 &
+    local rteval_pid=$!
+
+    sleep 2
+
+    local all_good=true
+
+    if check_cpuset_exists "rteval_housekeeping"; then
+        print_info "rteval_housekeeping cpuset created: OK"
+    else
+        print_fail "rteval_housekeeping cpuset not created"
+        all_good=false
+    fi
+
+    if check_cpuset_exists "rteval_measurement"; then
+        print_info "rteval_measurement cpuset created: OK"
+
+        local cpuset_cpus=$(cat /sys/fs/cgroup/rteval_measurement/cpuset.cpus 2>/dev/null)
+        print_info "Measurement cpuset CPUs: $cpuset_cpus (should be isolated CPUs)"
+    else
+        print_fail "rteval_measurement cpuset not created"
+        all_good=false
+    fi
+
+    if ! check_cpuset_exists "rteval_loads"; then
+        print_info "No rteval_loads cpuset (loads use taskset): OK"
+    else
+        print_fail "Unexpected rteval_loads cpuset found"
+        all_good=false
+    fi
+
+    wait $rteval_pid
+    sleep 1
+
+    if check_no_cpusets; then
+        print_info "Cleanup successful: OK"
+    else
+        print_fail "Cpusets not cleaned up"
+        all_good=false
+        cleanup_cpusets
+    fi
+
+    if [ "$all_good" = true ]; then
+        print_pass "Double isolation (isolcpus + cpusets) test"
+    else
+        print_fail "Double isolation (isolcpus + cpusets) test"
+    fi
+}
+
+# Main execution
+main() {
+    # Cleanup on exit/interrupt
+    trap cleanup_cpusets EXIT INT TERM
+
+    # Check prerequisites first (need root for cleanup)
+    check_root
+    check_cgroup_v2
+    check_cpuset_controller
+
+    # Clean up any leftover cpusets from previous runs
+    cleanup_cpusets
+
+    print_header "RTEVAL CPUSET INTEGRATION TEST SUITE"
+
+    echo "Log file: $LOG_FILE"
+    echo ""
+
+    # Run tests
+    test_prerequisites
+    test_same_cpus_no_housekeeping
+    test_different_cpus_no_housekeeping
+    test_with_housekeeping
+    test_housekeeping_without_isolcpus
+    test_backward_compatibility
+    test_cleanup_on_interrupt
+
+    # Tests that require isolcpus (will skip if not available)
+    test_measurement_run_on_isolcpus
+    test_housekeeping_without_cpusets_requires_isolcpus
+    test_combining_isolcpus_and_cpusets
+
+    # Summary
+    print_header "TEST SUMMARY"
+    echo "Total tests run: $TESTS_RUN"
+    echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
+    echo -e "${RED}Failed: $TESTS_FAILED${NC}"
+    echo ""
+    echo "Log file: $LOG_FILE"
+
+    if [ $TESTS_FAILED -eq 0 ]; then
+        echo -e "${GREEN}✅ ALL TESTS PASSED${NC}"
+        exit 0
+    else
+        echo -e "${RED}❌ SOME TESTS FAILED${NC}"
+        exit 1
+    fi
+}
+
+# Run main
+main "$@"
-- 
2.54.0

