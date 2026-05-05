Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B630EF77
	for <linux-rt-users@vger.kernel.org>; Tue,  5 May 2026 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003080; cv=none; b=SixUkBmjpvpGzwzH+MxJ0pasd9cZZmVxkDSFQwVCzhRMb7wEyMYup0GNnA2nouRHEXdFF4mDAKMcx9Z/kEBtndTLjSKTEGNRHFCBllDNwQZqiBxAhjKCJnSUEh0RL6EVbZSO5JfyHhwOQOvvQbAuO4Rr95LmiHviPBpFXydgV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003080; c=relaxed/simple;
	bh=tdMPzQjo1utanUPmTszkQIgEaCS9orYw7WPY9GX6+h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgH4ZpdP7K4/2WnAp0RUse0Cvi3PiVM8mC0qBJhm01tIejDZy7msxOhTa62AVN3Ymf0I/uOhotGu9Hz1mlSrTvsR6f7uv0iK61uf/4tYiomaFR2yz1yzY+ZaoMaA7nMgc6cutZWmpthziaLbCUS/ADPu5VM0z3Cp8Y/MMPmbYm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8iFIUte; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8iFIUte"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8b6dd874471so41489936d6.0
        for <linux-rt-users@vger.kernel.org>; Tue, 05 May 2026 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003078; x=1778607878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2xqwVZWhEBUr0fCNLvZ0CeKZ3EL9dNrlwg2dQTM9Ek=;
        b=W8iFIUte0GZ4WeIcBvvcpTR366M+VmyA1/ogJ0EP0y8FcRZA9B8TdYgkSjbhb+N+BQ
         dALHfM7vQENV1vYPnoN4Ssuu+yWcJl7n3GI8KDcoi2BWXu7tlybRjNkw8KmyTCQSq2VH
         atl/1q2fPIoQLAKpSIu1oDifQd8NzhAzZYjgS8f8SoAxes2KlhvgtUuS4JffyWcKUDb6
         Br7M7ICHbCyH6ZoD+Uywl0xL3CNAwcKhNrPMYL4rD+ns6SBoF24m6iYyE/PCMncyhLgc
         DlW1gTjrJYhl1dNKAXiLbwqqT4lfs7k3veitGP0mVO6kkHtSIa1GOiqOnj51nItKVuLo
         F0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003078; x=1778607878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2xqwVZWhEBUr0fCNLvZ0CeKZ3EL9dNrlwg2dQTM9Ek=;
        b=slNylpSBNj+R5w75hVJ2Vdp7x0ioW+wOlMUB7ehKV2n5h7QNrhquXTGSUZ9poajzs8
         lxpwT2nmaeaRlXQ4aPhRKmOEweJhX/8p6wlbKQr0WJ2SiylAPyFrPyqFAk5IGrV/cbRz
         4sQofxwil854omEcDVecWUys8hvvv8gWLHg2iKb61fR1IEgQisHyrlB5ILxlX/5YejzW
         zofoCT0zzFMYlqHbmtToSyI1mWdSaJX0ptt2bPIqmJhzu7O2xNLmMy/bCo42zklQetk1
         H3Okc4vjtdRYdZWru7ty0vrbFixD2IBnneXtz03dLEouP/VQI2R+Rf98nLGwElHBiAAM
         C+JQ==
X-Gm-Message-State: AOJu0YzzAZg5RQd4GfuUXewp7z6sklWPuZ5mLlj96esp/Y6QdxttiELX
	m5ZNPbJYt+dgOlTXo6DTucpzRWW+cr8dhgiSfw4sQMEDAcTQmmYqoc7D3poqAw==
X-Gm-Gg: AeBDieuMvqVApI49lhWUhm0kSIUTtuCP+GGuP87xkIlP5jM2q84ZICNnubWgohTt1Jj
	8uGM51d5U0HZ2WX8jBljJD0cdJqPEbpzzVnlABhrLDVVR9IzAwbTC76XwLp3m8ADC/14mNl1GHU
	M/XBlx3QzxjRZNWwDVAY3EJ66vgxzxgdM2+oOwOoudToXg/yP2TNvyM4itPHRto61GQebLJSTM+
	orR0x811fZV79pktP1LiN139Q6n9cJh1MR3Bauf3EzhX5d82ElFK3ViCYiwqwGdMqP2LjlaGusc
	BKfHT0d/C9hiqn7Q3LmK+r8FOUb5aJqBwq76WcClM/3pO0sLnL0DZxJmXKOep8g8w8rePW9GZsa
	YpZmQBEnR/jcmC2WCIog419RSniQ9411yJh7yPmbkBklNfMT4JZaSAICwshOyk6UWAbx4X5tOIA
	+23UC6eAxGuPWO5Le9io/eP2CPOKv78XY5CuJDnYTwCT34r9/jcFYAYTx2qxX7BQKbIOBPD94h5
	sicjyPbaV/DTcc15HcxMtDO0dLXXg==
X-Received: by 2002:a05:6214:4e82:b0:8a0:846e:8850 with SMTP id 6a1803df08f44-8bad9f48da7mr58037756d6.20.1778003077432;
        Tue, 05 May 2026 10:44:37 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5391e3636sm161817896d6.13.2026.05.05.10.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:44:36 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <clark.williams@gmail.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 6/9] rteval: Refactor core sharing validation test into proper unittest
Date: Tue,  5 May 2026 13:43:50 -0400
Message-ID: <20260505174410.169442-7-jkacur@redhat.com>
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

Refactor test_full_validation.py into a proper unittest-based test and
move it to tests/test_core_sharing_validation.py.

Changes:
- Convert from standalone script to unittest.TestCase class
- Replace manual print statements with proper assertions
- Add 6 comprehensive test cases covering:
  * Housekeeping/measurement core sharing conflicts
  * No warnings when workloads use different cores
  * Multiple conflict scenarios
  * XML report generation
  * Isolated CPU markers in warnings
  * Behavior when no CPUs are isolated

- Move from root directory to tests/ directory
- Add test to run_tests.sh for automatic execution
- Use mocking to simulate isolated CPUs for reproducibility
- All tests can run on any system without special boot parameters

This test validates the core sharing warning feature introduced in
commits cb3d0d0cdeff and 755700499e49, ensuring regression prevention
for the isolated CPU core sharing detection logic.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 run_tests.sh                          |   5 +
 test_full_validation.py               | 151 -------------------------
 tests/test_core_sharing_validation.py | 155 ++++++++++++++++++++++++++
 3 files changed, 160 insertions(+), 151 deletions(-)
 delete mode 100644 test_full_validation.py
 create mode 100755 tests/test_core_sharing_validation.py

diff --git a/run_tests.sh b/run_tests.sh
index c39d16feeea7..77ef90bea294 100755
--- a/run_tests.sh
+++ b/run_tests.sh
@@ -56,6 +56,11 @@ if [ -d "tests" ]; then
         run_test "tests/test_measurement_module_selection.py"
     fi
 
+    # Run test_core_sharing_validation.py
+    if [ -f "tests/test_core_sharing_validation.py" ]; then
+        run_test "tests/test_core_sharing_validation.py"
+    fi
+
     # Add more tests here as they are created
     # Example:
     # if [ -f "tests/test_another_feature.py" ]; then
diff --git a/test_full_validation.py b/test_full_validation.py
deleted file mode 100644
index 98c286fab344..000000000000
--- a/test_full_validation.py
+++ /dev/null
@@ -1,151 +0,0 @@
-#!/usr/bin/env python3
-"""
-Test core sharing validation with mocked isolated CPUs
-Tests both console warnings and XML output
-"""
-
-import sys
-sys.path.insert(0, '.')
-
-from unittest.mock import patch, Mock
-import libxml2
-from rteval.systopology import validate_core_sharing
-
-# Mock isolated CPUs: simulate CPUs 0, 8, 1, 9 as isolated
-# Based on actual topology: CPUs 0 and 8 share a core, 1 and 9 share a core
-MOCK_ISOLATED_CPUS = [0, 8, 1, 9]
-
-print("=" * 70)
-print("TESTING CORE SHARING VALIDATION")
-print("=" * 70)
-print()
-print("System core topology (from actual hardware):")
-from rteval.sysinfo.coresiblings import CoreSiblings
-cs = CoreSiblings()
-for i, group in enumerate(cs.get_core_groups()[:4]):
-    print(f"  Core {i}: {sorted(group)}")
-print()
-print(f"Simulating isolated CPUs: {MOCK_ISOLATED_CPUS}")
-print()
-
-# Test 1: Console warnings
-print("=" * 70)
-print("TEST 1: Console Warnings")
-print("=" * 70)
-print()
-
-with patch('rteval.systopology.SysTopology') as mock_systopo:
-    mock_instance = mock_systopo.return_value
-    mock_instance.isolated_cpus.return_value = MOCK_ISOLATED_CPUS
-
-    print("Scenario 1: Housekeeping and Measurement share core")
-    print("  Housekeeping: [0]  (isolated)")
-    print("  Measurement:  [8]  (isolated, shares core with 0)")
-    print("  Load:         [2]  (non-isolated)")
-    warnings = validate_core_sharing([0], [8], [2])
-    if warnings:
-        print(f"  ✓ Got {len(warnings)} warning(s):")
-        for w in warnings:
-            print(f"    {w}")
-    else:
-        print("  ✗ No warnings!")
-    print()
-
-    print("Scenario 2: All three workload types on different cores")
-    print("  Housekeeping: [0]  (isolated)")
-    print("  Measurement:  [1]  (isolated, different core)")
-    print("  Load:         [2]  (non-isolated, different core)")
-    warnings = validate_core_sharing([0], [1], [2])
-    if warnings:
-        print(f"  ✗ Unexpected warnings: {warnings}")
-    else:
-        print("  ✓ No warnings (correct!)")
-    print()
-
-    print("Scenario 3: Multiple conflicts")
-    print("  Housekeeping: [0]     (isolated)")
-    print("  Measurement:  [8]     (isolated, shares core with 0)")
-    print("  Load:         [1,9]   (1 and 9 both isolated, share a core)")
-    warnings = validate_core_sharing([0], [8], [1, 9])
-    if warnings:
-        print(f"  ✓ Got {len(warnings)} warning(s):")
-        for w in warnings:
-            print(f"    {w}")
-    else:
-        print("  ✗ No warnings!")
-    print()
-
-# Test 2: XML output
-print("=" * 70)
-print("TEST 2: XML Report Generation")
-print("=" * 70)
-print()
-
-with patch('rteval.systopology.SysTopology') as mock_systopo:
-    mock_instance = mock_systopo.return_value
-    mock_instance.isolated_cpus.return_value = MOCK_ISOLATED_CPUS
-    mock_instance.isolated_cpus_str.return_value = [str(cpu) for cpu in MOCK_ISOLATED_CPUS]
-
-    from rteval.sysinfo.cputopology import CPUtopology
-    from rteval.Log import Log
-
-    # Create CPUtopology and parse
-    cputop = CPUtopology()
-    cputop._parse()
-
-    # Now add warnings with conflicting CPU lists
-    print("Adding warnings for:")
-    print("  Housekeeping: [0]  (isolated)")
-    print("  Measurement:  [8]  (isolated, shares core with 0)")
-    print("  Load:         [1,9] (both isolated, share core with each other)")
-    print()
-
-    # First verify that validation itself works with the mock
-    from rteval.systopology import validate_core_sharing
-    test_warnings = validate_core_sharing([0], [8], [1, 9])
-    print(f"Direct validation call returned {len(test_warnings)} warning(s)")
-    print()
-
-    cputop.add_core_sharing_warnings([0], [8], [1, 9])
-
-    # Get the XML
-    xml = cputop.MakeReport()
-
-    # Check for warnings in XML
-    # Search for CoreSharingWarnings child node
-    warnings_section = None
-    child = xml.children
-    while child:
-        if child.name == 'CoreSharingWarnings':
-            warnings_section = child
-            break
-        child = child.next
-
-    if warnings_section:
-        warning_list = []
-        warning_child = warnings_section.children
-        while warning_child:
-            if warning_child.name == 'warning':
-                warning_list.append(warning_child.getContent())
-            warning_child = warning_child.next
-
-        if warning_list:
-            print(f"✓ Found {len(warning_list)} warning(s) in XML:")
-            for w in warning_list:
-                print(f"  - {w}")
-        else:
-            print("✗ CoreSharingWarnings section exists but is empty!")
-    else:
-        print("✗ No CoreSharingWarnings section found in XML!")
-
-    print()
-    print("Full CPUtopology XML section:")
-    print("-" * 70)
-    temp_doc = libxml2.newDoc("1.0")
-    temp_doc.setRootElement(xml.docCopyNode(temp_doc, 1))
-    temp_doc.saveFormatFileEnc("-", "UTF-8", 1)
-
-print()
-print("=" * 70)
-print("ALL TESTS COMPLETE")
-print("=" * 70)
diff --git a/tests/test_core_sharing_validation.py b/tests/test_core_sharing_validation.py
new file mode 100755
index 000000000000..3c229a47e722
--- /dev/null
+++ b/tests/test_core_sharing_validation.py
@@ -0,0 +1,155 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Unit test for core sharing validation with mocked isolated CPUs
+#
+# This test verifies that core sharing warnings are correctly generated
+# when isolated CPUs sharing a physical core are assigned to different
+# workload types (housekeeping, measurement, load).
+#
+# The test uses mocked isolated CPUs to ensure reproducibility across
+# different systems without requiring special boot parameters.
+#
+
+import sys
+import os
+import unittest
+from unittest.mock import patch, Mock
+import libxml2
+
+# Add rteval to path
+sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
+
+from rteval.systopology import validate_core_sharing
+from rteval.sysinfo.cputopology import CPUtopology
+from rteval.Log import Log
+
+
+class TestCoreSharingValidation(unittest.TestCase):
+    """Test suite for core sharing validation with mocked isolated CPUs"""
+
+    # Mock isolated CPUs: simulate CPUs 0, 8, 1, 9 as isolated
+    # Based on typical topology: CPUs 0 and 8 share a core, 1 and 9 share a core
+    MOCK_ISOLATED_CPUS = [0, 8, 1, 9]
+
+    @patch('rteval.systopology.SysTopology')
+    def test_housekeeping_measurement_share_core(self, mock_systopo):
+        """Test warning when housekeeping and measurement share a core"""
+        mock_instance = mock_systopo.return_value
+        mock_instance.isolated_cpus.return_value = self.MOCK_ISOLATED_CPUS
+
+        # Housekeeping: [0] (isolated)
+        # Measurement:  [8] (isolated, shares core with 0)
+        # Load:         [2] (non-isolated)
+        warnings = validate_core_sharing([0], [8], [2])
+
+        self.assertGreater(len(warnings), 0,
+                          "Expected warning when housekeeping and measurement share a core")
+        self.assertTrue(any("housekeeping" in w.lower() and "measurement" in w.lower()
+                           for w in warnings),
+                       "Warning should mention both housekeeping and measurement")
+
+    @patch('rteval.systopology.SysTopology')
+    def test_no_warnings_different_cores(self, mock_systopo):
+        """Test no warnings when all workload types use different cores"""
+        mock_instance = mock_systopo.return_value
+        mock_instance.isolated_cpus.return_value = self.MOCK_ISOLATED_CPUS
+
+        # Housekeeping: [0]  (isolated)
+        # Measurement:  [1]  (isolated, different core)
+        # Load:         [2]  (non-isolated, different core)
+        warnings = validate_core_sharing([0], [1], [2])
+
+        self.assertEqual(len(warnings), 0,
+                        "Expected no warnings when workloads use different cores")
+
+    @patch('rteval.systopology.SysTopology')
+    def test_multiple_conflicts(self, mock_systopo):
+        """Test warnings when multiple core sharing conflicts exist"""
+        mock_instance = mock_systopo.return_value
+        mock_instance.isolated_cpus.return_value = self.MOCK_ISOLATED_CPUS
+
+        # Housekeeping: [0]     (isolated)
+        # Measurement:  [8]     (isolated, shares core with 0)
+        # Load:         [1,9]   (1 and 9 both isolated, share a core)
+        warnings = validate_core_sharing([0], [8], [1, 9])
+
+        self.assertGreaterEqual(len(warnings), 1,
+                               "Expected at least one warning for core sharing conflicts")
+        # Verify the warning mentions the housekeeping/measurement conflict
+        self.assertTrue(any("housekeeping" in w.lower() and "measurement" in w.lower()
+                           for w in warnings),
+                       "Warning should mention housekeeping/measurement conflict")
+
+    @patch('rteval.systopology.SysTopology')
+    def test_xml_report_generation(self, mock_systopo):
+        """Test that warnings are properly added to XML report"""
+        mock_instance = mock_systopo.return_value
+        mock_instance.isolated_cpus.return_value = self.MOCK_ISOLATED_CPUS
+        mock_instance.isolated_cpus_str.return_value = [str(cpu) for cpu in self.MOCK_ISOLATED_CPUS]
+
+        # Create CPUtopology and parse
+        cputop = CPUtopology()
+        cputop._parse()
+
+        # Add warnings with conflicting CPU lists
+        # Housekeeping: [0]  (isolated)
+        # Measurement:  [8]  (isolated, shares core with 0)
+        # Load:         [1,9] (both isolated, share core with each other)
+        cputop.add_core_sharing_warnings([0], [8], [1, 9])
+
+        # Get the XML
+        xml = cputop.MakeReport()
+
+        # Search for CoreSharingWarnings child node
+        warnings_section = None
+        child = xml.children
+        while child:
+            if child.name == 'CoreSharingWarnings':
+                warnings_section = child
+                break
+            child = child.next
+
+        self.assertIsNotNone(warnings_section,
+                            "CoreSharingWarnings section should exist in XML")
+
+        # Extract warnings from XML
+        warning_list = []
+        if warnings_section:
+            warning_child = warnings_section.children
+            while warning_child:
+                if warning_child.name == 'warning':
+                    warning_list.append(warning_child.getContent())
+                warning_child = warning_child.next
+
+        self.assertGreater(len(warning_list), 0,
+                          "CoreSharingWarnings section should contain at least one warning")
+
+    @patch('rteval.systopology.SysTopology')
+    def test_isolated_marker_in_warnings(self, mock_systopo):
+        """Test that warnings include (isol) markers for isolated CPUs"""
+        mock_instance = mock_systopo.return_value
+        mock_instance.isolated_cpus.return_value = self.MOCK_ISOLATED_CPUS
+
+        warnings = validate_core_sharing([0], [8], [2])
+
+        self.assertGreater(len(warnings), 0, "Expected warnings")
+        # Check that warnings mention isolated CPUs with (isol) marker
+        self.assertTrue(any("(isol)" in w for w in warnings),
+                       "Warnings should mark isolated CPUs with (isol)")
+
+    @patch('rteval.systopology.SysTopology')
+    def test_no_warnings_without_isolated_cpus(self, mock_systopo):
+        """Test that no warnings are generated when no CPUs are isolated"""
+        mock_instance = mock_systopo.return_value
+        mock_instance.isolated_cpus.return_value = []  # No isolated CPUs
+
+        # Even if CPUs share cores, no warnings if none are isolated
+        warnings = validate_core_sharing([0], [8], [1])
+
+        self.assertEqual(len(warnings), 0,
+                        "Expected no warnings when no CPUs are isolated")
+
+
+if __name__ == '__main__':
+    unittest.main()
-- 
2.54.0

