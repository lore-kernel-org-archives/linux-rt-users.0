Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9374A2E3D
	for <linux-rt-users@vger.kernel.org>; Tue,  5 May 2026 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003084; cv=none; b=gIT096+8mDq2KPouPZ9IBmutK2iQVDjgNloIlfnHJypjKIFxM0+jOJObKif+BsfE1cyrwwD+KhONdIZAPVqO+0WjFbwACmR3CsE7JzWWWXOInMHqIwA7cBEtrhxxGhoTSB/9SDkxjMaMuYcK7f0UICDiAqgQZ13tKaQSJkzgSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003084; c=relaxed/simple;
	bh=McqlyD++TULABuyiaJH7STqjtDpbuc2txrw1MpT0vg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tonWBrWD0gekux1rFMS41fWutqfdqbAej8TQLOrwZ66hzeQv40xroA9gffcwi8yajwFJWQCKs1h90UZM4bnvUTFFSBhYJf4fCx6ajoi+qm2txQA6gWIcwFuozC0uG2ev1M1l5C1E0Etb+Kf8UddearKjI2Ud+UdVF6aL2h/eMtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4zZn/rG; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4zZn/rG"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8b8e98fd885so22918846d6.0
        for <linux-rt-users@vger.kernel.org>; Tue, 05 May 2026 10:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003082; x=1778607882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dCfTJhb0SFGJtZLL1V27H3XjYYtML9u/5bho9pAWXU=;
        b=h4zZn/rGsfCoEvPf462fxTR4L5sGITLgI96eOh02Sb6nZnLII00ISEIt0mLKqL1WcN
         9brOvE+iGZFxBqrpds0e2F9OkVajJ8sWhBqU7OjNi9hUl4lLPs1h0celEgPmILVV8qO1
         GMgEnq5GqCXDZBcmzwOEkFA2/VI8fPddLY7mvd0BbZwDwWVdBDAuKVu+4+O8jBlk8yVZ
         L0Swo9PBDtPNE2ujmShbI8WXtrhwwjmeX0eQIAp5xdrq4bZAeKeRfy1416Ms47vuLQzO
         xnT7geyrWdgd6sju0S/ki3vmGHtOfPs64Bll0jONTh2BUbR+CYHkdWQ4/ZE0FLufZL2Q
         koKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003082; x=1778607882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dCfTJhb0SFGJtZLL1V27H3XjYYtML9u/5bho9pAWXU=;
        b=qAHpPs/7u8DTH5gghrsV7Iyi/0OxDmc8ap7LWYmwgMFWdin3ETiNHwBnObuPVYtd9L
         cvYRBRZUgleQPYiU9NIXClfmaYurFgPOBE1yfAODkjHHgMlkN8xO/FZa/52UCGk1BTY1
         vKtfGeiGXnUG0UyQeXnHWjg7vXz+QGM+yXasJmEQPoCRx/0yrWDH0yDXO79p8qfUxnh9
         Z6KVYAvgvXWl8b9l0QYWaUFnWDE3aewq1IyHtbI7bYsXAvLiL5cMM5zRiC5rVfNHlQ0b
         gxDCeNl8TxQ2md7PrzeTw6ojRo+I7t7dGSkLFiyViXbDq67bWkH3J3UqpKS6aN2tXm4l
         JDhA==
X-Gm-Message-State: AOJu0YwWf/NqgiaDZWmOFYt85giuV35XuhKk3mGoXYh7J9+gh7vo8XT+
	BcdRPvXE5488fxX17qGy8ght96zTtZqXqN7dcV7HpG0Wm+NQTSNTzsHTikiifA==
X-Gm-Gg: AeBDiesyjRqoOgS1DMqt7tfal07qbJL0006JYwQPhzIQfiOjuwzt93BOyuxHsWFw4sR
	Bqx9yqtuv+lUMeaTA94HlmzwwtSPBUg+bB3jd4rdoTwoxxAXYeLTI0kLrQWf41H40U11Ybwwrtw
	MunvyKC2nppzRlzdi4HRm2jAID0QvGLtQ6sto1CTNvQwFYj3G5GPZZdULhGKwJenBbYznp64wIt
	imDlZou+TWyJW69CaxcT6XnEzXg9XxTw+2bR+avM13seM9jFsWYYqV5YjCV6Sp25Hod10Tt/i7A
	CNwR2btG4NYFVxsutcFux8h6dW9ofJm6BoEuk9aUBthHVu10IPEgxYiFWtUddO68jmFiROLpfNz
	qXJvmfinUpDrrlbvsdGaf0MGCgKxq94EqUnTiTeT2MRyccD08KH5QJ6a6JYwLe8/gT3ZIuGvp8R
	sCmX1pGxpORSQPwECBGjIC+GTJoh/fiyVlJvakzw8LdKC67tSsoeUp9yVa9L9/vvg9oNKRzgx6A
	V4leRuczxro9TLEBeiu52iAcmmmWwoJBKqjsZ6o
X-Received: by 2002:a05:6214:5294:b0:89c:c2e7:97ad with SMTP id 6a1803df08f44-8b6698d0f5bmr231679976d6.43.1778003081252;
        Tue, 05 May 2026 10:44:41 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5391e3636sm161817896d6.13.2026.05.05.10.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:44:40 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <clark.williams@gmail.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 9/9] rteval: Move run_tests.sh to tests/ and remove obsolete test scripts
Date: Tue,  5 May 2026 13:43:53 -0400
Message-ID: <20260505174410.169442-10-jkacur@redhat.com>
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

Reorganize test infrastructure for better consistency by moving all
test-related files under the tests/ directory.

Changes:
- Move run_tests.sh to tests/run_tests.sh
  * Update script to cd to repository root (tests/..)
  * Update Makefile unit-tests target to call ./tests/run_tests.sh
  * Script now runs from tests/ directory like other test harnesses

- Remove obsolete core sharing test scripts
  * Delete test_core_sharing_scenarios.sh
  * Delete test_isolated_cpus.sh
  * These are superseded by tests/test_core_sharing_validation.py

All test infrastructure now organized under tests/:
- tests/run_tests.sh        - Unit test runner (Python tests)
- tests/*.py                 - Python unit tests
- tests/e2e/                 - End-to-end tests
- tests/regression/          - Regression tests
- tests/cpusets/             - Cpuset integration tests

Both 'make unit-tests' and 'make tests' work correctly.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                           |   2 +-
 test_core_sharing_scenarios.sh     | 260 -----------------------------
 test_isolated_cpus.sh              | 119 -------------
 run_tests.sh => tests/run_tests.sh |   5 +-
 4 files changed, 4 insertions(+), 382 deletions(-)
 delete mode 100755 test_core_sharing_scenarios.sh
 delete mode 100755 test_isolated_cpus.sh
 rename run_tests.sh => tests/run_tests.sh (94%)

diff --git a/Makefile b/Makefile
index bacfc3120148..a9d3a871f123 100644
--- a/Makefile
+++ b/Makefile
@@ -58,7 +58,7 @@ sysreport:
 
 unit-tests:
 	@echo "Running unit tests..."
-	./run_tests.sh
+	./tests/run_tests.sh
 
 tests: unit-tests
 
diff --git a/test_core_sharing_scenarios.sh b/test_core_sharing_scenarios.sh
deleted file mode 100755
index 7ff04b09f11e..000000000000
--- a/test_core_sharing_scenarios.sh
+++ /dev/null
@@ -1,260 +0,0 @@
-#!/bin/bash
-# Comprehensive test for core sharing warnings in different scenarios
-# Tests both console warnings and XML/XSLT output
-
-set -e
-
-echo "========================================================================="
-echo "Core Sharing Warning Test Suite"
-echo "========================================================================="
-echo ""
-
-# Check for isolated CPUs
-ISOLATED=$(cat /sys/devices/system/cpu/isolated 2>/dev/null || echo "")
-if [ -z "$ISOLATED" ]; then
-    echo "⚠ WARNING: No isolated CPUs found!"
-    echo ""
-    echo "This test requires isolated CPUs configured via kernel boot parameter."
-    echo "Example: isolcpus=0,8,1,9 (or similar based on your CPU topology)"
-    echo ""
-    echo "To configure isolated CPUs:"
-    echo "  1. Edit /etc/default/grub"
-    echo "  2. Add isolcpus=<cpulist> to GRUB_CMDLINE_LINUX"
-    echo "  3. Update bootloader:"
-    echo "     - RHEL/Fedora: sudo grub2-mkconfig -o /boot/grub2/grub.cfg"
-    echo "     - Debian/Ubuntu: sudo update-grub"
-    echo "  4. Reboot"
-    echo ""
-    echo "SKIPPING: Tests require isolated CPUs"
-    exit 0
-fi
-echo "✓ Isolated CPUs detected: $ISOLATED"
-echo ""
-
-# Cleanup old test results
-rm -rf rteval-test-scenario-* 2>/dev/null || true
-
-# CPU topology on this system:
-# CPUs 0,8 share core 0 (both isolated)
-# CPUs 1,9 share core 1 (both isolated)
-# CPUs 4,12 share core 4 (neither isolated)
-
-# =========================================================================
-echo "Scenario 1: Only isolated CPU warnings (default behavior)"
-echo "  Housekeeping: 0 (isol), Measurement: 8 (isol), Load: 1 (isol)"
-echo "  Expected: Warnings for 0 vs 8 (both isol) only"
-echo "-------------------------------------------------------------------------"
-
-WORKDIR="rteval-test-scenario-1"
-mkdir -p "$WORKDIR"
-
-./rteval-cmd -D -L -d 30s --housekeeping 0 --measurement-cpulist 8 --loads-cpulist 1 \
-    -w "$WORKDIR" 2>&1 | tee "$WORKDIR/console.log"
-
-echo ""
-echo "Console warnings:"
-grep -i "warning.*shares core" "$WORKDIR/console.log" || echo "  (none found)"
-
-# Find the actual rteval output directory
-SUMMARY_XML=$(find "$WORKDIR" -name "summary.xml" -type f | head -1)
-
-echo ""
-echo "XML CoreSharingWarnings:"
-if [ -z "$SUMMARY_XML" ]; then
-    echo "  ✗ FAIL: summary.xml not found in $WORKDIR"
-elif grep -q "CoreSharingWarnings" "$SUMMARY_XML"; then
-    grep -A 10 "CoreSharingWarnings" "$SUMMARY_XML" | grep -E "(warning>|CoreSharingWarnings)" || true
-    WARN_COUNT=$(grep -c "<warning>" "$SUMMARY_XML" || echo "0")
-    echo "  Total warnings in XML: $WARN_COUNT"
-    if [ "$WARN_COUNT" -eq 1 ]; then
-        echo "  ✓ PASS: Expected 1 warning"
-    else
-        echo "  ✗ FAIL: Expected 1 warning, got $WARN_COUNT"
-    fi
-else
-    echo "  ✗ FAIL: No CoreSharingWarnings section found"
-fi
-
-echo ""
-echo "Text report (via -Z):"
-if [ -n "$SUMMARY_XML" ]; then
-    ./rteval-cmd -Z "$SUMMARY_XML" 2>&1 | grep -A 5 "Core Sharing" || echo "  (no warnings in text report)"
-else
-    echo "  (summary.xml not found)"
-fi
-
-echo ""
-echo ""
-
-# =========================================================================
-echo "Scenario 2: Non-isolated warnings WITHOUT flag (should not warn)"
-echo "  Measurement: 4 (non-isol), Load: 12 (non-isol)"
-echo "  Expected: No warnings (flag not used)"
-echo "-------------------------------------------------------------------------"
-
-WORKDIR="rteval-test-scenario-2"
-mkdir -p "$WORKDIR"
-
-./rteval-cmd -D -L -d 30s --measurement-cpulist 4 --loads-cpulist 12 \
-    -w "$WORKDIR" 2>&1 | tee "$WORKDIR/console.log"
-
-echo ""
-echo "Console warnings:"
-if grep -qi "warning.*shares core" "$WORKDIR/console.log"; then
-    echo "  ✗ FAIL: Unexpected warning found"
-    grep -i "warning.*shares core" "$WORKDIR/console.log"
-else
-    echo "  ✓ PASS: No warnings (correct)"
-fi
-
-# Find the actual rteval output directory
-SUMMARY_XML=$(find "$WORKDIR" -name "summary.xml" -type f | head -1)
-
-echo ""
-echo "XML CoreSharingWarnings:"
-if [ -z "$SUMMARY_XML" ]; then
-    echo "  ✗ FAIL: summary.xml not found in $WORKDIR"
-elif grep -q "CoreSharingWarnings" "$SUMMARY_XML"; then
-    echo "  ✗ FAIL: CoreSharingWarnings section should not exist"
-    grep -A 10 "CoreSharingWarnings" "$SUMMARY_XML" | grep -E "(warning>|CoreSharingWarnings)" || true
-else
-    echo "  ✓ PASS: No CoreSharingWarnings section (correct)"
-fi
-
-echo ""
-echo ""
-
-# =========================================================================
-echo "Scenario 3: Non-isolated warnings WITH flag (should warn)"
-echo "  Measurement: 4 (non-isol), Load: 12 (non-isol)"
-echo "  Flag: --warn-non-isolated-core-sharing"
-echo "  Expected: Warning for 4 vs 12"
-echo "-------------------------------------------------------------------------"
-
-WORKDIR="rteval-test-scenario-3"
-mkdir -p "$WORKDIR"
-
-./rteval-cmd -D -L -d 30s --measurement-cpulist 4 --loads-cpulist 12 \
-    --warn-non-isolated-core-sharing -w "$WORKDIR" 2>&1 | tee "$WORKDIR/console.log"
-
-echo ""
-echo "Console warnings:"
-if grep -qi "warning.*CPU 4.*CPU 12" "$WORKDIR/console.log"; then
-    echo "  ✓ PASS: Found expected warning"
-    grep -i "warning.*shares core" "$WORKDIR/console.log"
-else
-    echo "  ✗ FAIL: Expected warning not found"
-fi
-
-# Find the actual rteval output directory
-SUMMARY_XML=$(find "$WORKDIR" -name "summary.xml" -type f | head -1)
-
-echo ""
-echo "XML CoreSharingWarnings:"
-if [ -z "$SUMMARY_XML" ]; then
-    echo "  ✗ FAIL: summary.xml not found in $WORKDIR"
-elif grep -q "CoreSharingWarnings" "$SUMMARY_XML"; then
-    grep -A 10 "CoreSharingWarnings" "$SUMMARY_XML" | grep -E "(warning>|CoreSharingWarnings)" || true
-    WARN_COUNT=$(grep -c "<warning>" "$SUMMARY_XML" || echo "0")
-    echo "  Total warnings in XML: $WARN_COUNT"
-    if [ "$WARN_COUNT" -eq 1 ]; then
-        echo "  ✓ PASS: Expected 1 warning in XML"
-    else
-        echo "  ✗ FAIL: Expected 1 warning, got $WARN_COUNT"
-    fi
-else
-    echo "  ✗ FAIL: CoreSharingWarnings section not found in XML"
-fi
-
-echo ""
-echo "Text report (via -Z):"
-if [ -n "$SUMMARY_XML" ]; then
-    ./rteval-cmd -Z "$SUMMARY_XML" 2>&1 | grep -A 5 "Core Sharing" || echo "  ✗ FAIL: No warnings in text report"
-else
-    echo "  (summary.xml not found)"
-fi
-
-echo ""
-echo ""
-
-# =========================================================================
-echo "Scenario 4: BOTH isolated and non-isolated warnings WITH flag"
-echo "  Housekeeping: 0 (isol), Measurement: 8,4 (8 isol, 4 not), Load: 12 (not isol)"
-echo "  Flag: --warn-non-isolated-core-sharing"
-echo "  Expected: 2 warnings - one for 0 vs 8 (both isol), one for 4 vs 12 (neither isol)"
-echo "-------------------------------------------------------------------------"
-
-WORKDIR="rteval-test-scenario-4"
-mkdir -p "$WORKDIR"
-
-./rteval-cmd -D -L -d 30s --housekeeping 0 --measurement-cpulist 8,4 --loads-cpulist 12 \
-    --warn-non-isolated-core-sharing -w "$WORKDIR" 2>&1 | tee "$WORKDIR/console.log"
-
-echo ""
-echo "Console warnings:"
-grep -i "warning.*shares core" "$WORKDIR/console.log" || echo "  (none found)"
-
-CONSOLE_WARN_COUNT=$(grep -ci "warning.*shares core" "$WORKDIR/console.log" || echo "0")
-echo "  Total console warnings: $CONSOLE_WARN_COUNT"
-
-# Find the actual rteval output directory
-SUMMARY_XML=$(find "$WORKDIR" -name "summary.xml" -type f | head -1)
-
-echo ""
-echo "XML CoreSharingWarnings:"
-if [ -z "$SUMMARY_XML" ]; then
-    echo "  ✗ FAIL: summary.xml not found in $WORKDIR"
-elif grep -q "CoreSharingWarnings" "$SUMMARY_XML"; then
-    echo "  Warnings found:"
-    grep -A 10 "CoreSharingWarnings" "$SUMMARY_XML" | grep "<warning>" | sed 's/^/    /'
-
-    XML_WARN_COUNT=$(grep -c "<warning>" "$SUMMARY_XML" || echo "0")
-    echo "  Total warnings in XML: $XML_WARN_COUNT"
-
-    # Check for both expected warnings
-    HAS_ISOL_WARN=$(grep -c "CPU 0.*isol.*CPU 8.*isol" "$SUMMARY_XML" || echo "0")
-    HAS_NON_ISOL_WARN=$(grep -c "CPU 4 shares core with load CPU 12" "$SUMMARY_XML" || echo "0")
-
-    if [ "$XML_WARN_COUNT" -eq 2 ] && [ "$HAS_ISOL_WARN" -eq 1 ] && [ "$HAS_NON_ISOL_WARN" -eq 1 ]; then
-        echo "  ✓ PASS: Both warnings present in XML"
-    else
-        echo "  ✗ FAIL: Expected 2 specific warnings (isolated and non-isolated)"
-    fi
-else
-    echo "  ✗ FAIL: CoreSharingWarnings section not found in XML"
-fi
-
-echo ""
-echo "Text report (via -Z):"
-if [ -n "$SUMMARY_XML" ]; then
-    ./rteval-cmd -Z "$SUMMARY_XML" 2>&1 | grep -A 10 "Core Sharing" || echo "  ✗ FAIL: No warnings in text report"
-else
-    echo "  (summary.xml not found)"
-fi
-
-echo ""
-echo ""
-
-# =========================================================================
-echo "========================================================================="
-echo "Test Summary"
-echo "========================================================================="
-echo ""
-echo "All test results are saved in rteval-test-scenario-* directories"
-echo "You can review:"
-echo "  - Console output: rteval-test-scenario-*/console.log"
-echo "  - XML reports: rteval-test-scenario-*/rteval-*/summary.xml"
-echo "  - Text reports: ./rteval-cmd -Z rteval-test-scenario-*/rteval-*/summary.xml"
-echo ""
-echo "Quick check of all XML files:"
-for dir in rteval-test-scenario-*/rteval-*/summary.xml; do
-    if [ -f "$dir" ]; then
-        echo "  $dir"
-        if grep -q "CoreSharingWarnings" "$dir"; then
-            echo "    - Has CoreSharingWarnings section"
-        else
-            echo "    - No CoreSharingWarnings section"
-        fi
-    fi
-done
-echo ""
diff --git a/test_isolated_cpus.sh b/test_isolated_cpus.sh
deleted file mode 100755
index 8b9aa3b7e5b6..000000000000
--- a/test_isolated_cpus.sh
+++ /dev/null
@@ -1,119 +0,0 @@
-#!/bin/bash
-# Test script for core sharing validation with real isolated CPUs
-# Run as root after rebooting with isolcpus=0,8,1,9,2,10,3,11
-
-set -e
-
-echo "========================================================================"
-echo "Testing Core Sharing Validation with Isolated CPUs"
-echo "========================================================================"
-echo
-
-# Check if running as root
-if [ "$EUID" -ne 0 ]; then
-   echo "ERROR: This script must be run as root"
-   exit 1
-fi
-
-# Verify isolated CPUs are configured
-echo "Step 1: Verifying isolated CPUs setup"
-echo "----------------------------------------"
-ISOLATED=$(cat /sys/devices/system/cpu/isolated 2>/dev/null || echo "")
-if [ -z "$ISOLATED" ]; then
-    echo "⚠ WARNING: No isolated CPUs found!"
-    echo ""
-    echo "This test requires isolated CPUs configured via kernel boot parameter."
-    echo "Example: isolcpus=0-3,8-11"
-    echo ""
-    echo "To configure isolated CPUs:"
-    echo "  1. Edit /etc/default/grub"
-    echo "  2. Add isolcpus=<cpulist> to GRUB_CMDLINE_LINUX"
-    echo "  3. Update bootloader:"
-    echo "     - RHEL/Fedora: sudo grub2-mkconfig -o /boot/grub2/grub.cfg"
-    echo "     - Debian/Ubuntu: sudo update-grub"
-    echo "  4. Reboot"
-    echo ""
-    echo "SKIPPING: All tests require isolated CPUs"
-    exit 0
-fi
-echo "✓ Isolated CPUs: $ISOLATED"
-echo
-
-# Verify isolcpus in kernel command line
-echo "Kernel command line:"
-grep -o 'isolcpus=[^ ]*' /proc/cmdline || echo "WARNING: isolcpus not found in cmdline"
-echo
-
-# Show core topology
-echo "Step 2: Core topology"
-echo "----------------------------------------"
-python3 rteval/sysinfo/coresiblings.py | head -12
-echo
-
-# Test 1: Trigger warning - split siblings across workloads
-echo "========================================================================"
-echo "TEST 1: Trigger Warning (siblings split across workloads)"
-echo "========================================================================"
-echo "Configuration:"
-echo "  --housekeeping 0"
-echo "  --measurement-cpulist 8"
-echo "  --loads-cpulist 2"
-echo
-echo "Expected: Warning that CPUs 0 and 8 share a core"
-echo "----------------------------------------"
-
-./rteval-cmd -D -L -d30s --housekeeping 0 --measurement-cpulist 8 --loads-cpulist 2 2>&1 | \
-    grep -E "(Warning:|shares core)" || echo "No warnings found"
-
-# Check the XML report
-REPORT=$(ls -t /tmp/rteval-* 2>/dev/null | head -1)
-if [ -n "$REPORT" ]; then
-    echo
-    echo "Checking XML report: $REPORT"
-    if grep -q "CoreSharingWarnings" "$REPORT"/*.xml 2>/dev/null; then
-        echo "✓ XML contains CoreSharingWarnings section:"
-        grep -A 5 "CoreSharingWarnings" "$REPORT"/*.xml | head -10
-    else
-        echo "✗ No CoreSharingWarnings in XML"
-    fi
-fi
-
-echo
-echo "========================================================================"
-echo "TEST 2: No Warning (proper separation)"
-echo "========================================================================"
-echo "Configuration:"
-echo "  --housekeeping 0,8"
-echo "  --measurement-cpulist 1,9,2,10"
-echo "  --loads-cpulist 3,11"
-echo
-echo "Expected: No warnings (each workload on separate cores)"
-echo "----------------------------------------"
-
-./rteval-cmd -D -L -d30s --housekeeping 0,8 --measurement-cpulist 1,9,2,10 --loads-cpulist 3,11 2>&1 | \
-    grep -E "(Warning:|shares core)" && echo "✗ Unexpected warning!" || echo "✓ No warnings (correct!)"
-
-echo
-echo "========================================================================"
-echo "TEST 3: Multiple conflicts"
-echo "========================================================================"
-echo "Configuration:"
-echo "  --housekeeping 0"
-echo "  --measurement-cpulist 8,1"
-echo "  --loads-cpulist 9"
-echo
-echo "Expected: Warnings about 0 vs 8, and 1 vs 9"
-echo "----------------------------------------"
-
-./rteval-cmd -D -L -d30s --housekeeping 0 --measurement-cpulist 8,1 --loads-cpulist 9 2>&1 | \
-    grep -E "(Warning:|shares core)" || echo "No warnings found"
-
-echo
-echo "========================================================================"
-echo "All tests complete!"
-echo "========================================================================"
-echo
-echo "Summary:"
-echo "  Test 1: Should show warning about CPUs 0 and 8"
-echo "  Test 2: Should show NO warnings"
-echo "  Test 3: Should show warnings about 0 vs 8, and 1 vs 9"
diff --git a/run_tests.sh b/tests/run_tests.sh
similarity index 94%
rename from run_tests.sh
rename to tests/run_tests.sh
index 77ef90bea294..5ac4e7bf2ff3 100755
--- a/run_tests.sh
+++ b/tests/run_tests.sh
@@ -15,9 +15,10 @@ GREEN='\033[0;32m'
 YELLOW='\033[1;33m'
 NC='\033[0m' # No Color
 
-# Get the directory where this script is located
+# Get the directory where this script is located (tests/)
 SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
-cd "$SCRIPT_DIR"
+# Change to repository root (parent of tests/)
+cd "$SCRIPT_DIR/.."
 
 # Test results tracking
 TOTAL_TESTS=0
-- 
2.54.0

