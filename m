Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2E0340293
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693002; cv=none; b=tpcsJ1xrumiwhpEl7bH1qFu7IcssmYM6X6gUvJakfGl6AqkSHJG5wNKnF0NPPkqJSN6jJvljZMawJ3Ft0gPbbfsWe1/UJpIvITvLTbZvcaZBKu75MBp9GA69NlNoi7ejyqGMhak4ZiBXXVGF/sNB+P8gHNFcI56aMajohFDSSJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693002; c=relaxed/simple;
	bh=ZCg9CXJW7zmn+ZsP+lK9VDl3JesjCo+J+kWMjjNOIyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZvMWaKYUp7onVzaVsHrNXo74PbMzfYlyHGPme+B5ySGyOKSQYK8WAEQvrP6uAo2KW8o6wbDi7kiHO/VGnJeGURiQmp7wHVANQ/frZiYCXVVX/mSY4cI8Vv5gh37arHn4FRKakG54qxJcZ4avZ73eed/Z3g0vuwERGDwbQgL4Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7UEFRnN; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7UEFRnN"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7383cdb7800so341705137.1
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692999; x=1784297799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=81CINe4qOgRKl0rubHTy3l1Ehea5U0DBmeRaRWp0fMM=;
        b=D7UEFRnN+MaYJTKcmC4rBnFZPNfWZ4CQ9zGXnJbfgMd0kh/sBw2vc5UVJPi3lxh7F4
         tB5OG4PKa6uC7EDgKUuLGc3caOSXRL6WUzvE3EUa2IV4GgIp37bEA5wfjEiwi9TP6ec0
         hM0Ezw/bJlL8LO6dpHoIQvCfGrtaPDc/+LEQwSibXc8u4tGZTd1hII+/n78HURVrTZ3U
         +XfdO/V1VR6fe7E+bt1yUcFryd3a2pd3qCQRZCJlRNOWJ4y0Ca4Wjn2VoA/MmEfpXa2n
         Zg1lN5AANOQkZPRxTemofJBBSUX1oXpcW9TqdInbeJjcNLQ2gtouAZvU+wepvfer+ozi
         eeew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692999; x=1784297799;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=81CINe4qOgRKl0rubHTy3l1Ehea5U0DBmeRaRWp0fMM=;
        b=YAHGCzFqFV5vzkwnF+omhjoL1qVOX/qwaP1v/Q/s2KGkMqq7R145F9sSvQd4mo9bNo
         LL/8tf6zOFOmbEzM2mYKE/zq3ZxrXn0+JeBD3zXggFUqjZaVqJh+57luuKKi8iJmGnJv
         oavmerQ4WonW4aArrMPmxDp1pG3xzMzpVCOEIDwuQ16nNlJ4G1fXcTjEyCHe6PYrd7r5
         zdyS8aheA3P2EUIud8+62fC0tKnWY48OkZXxHGm4NetMoldyqEaqvnV+I3BKLWrkSc0l
         +ppYmPlVFCTu8zmxKVTiWBxBDlxLBubG4PCwpqnUJf1R56MO03bBAyI6H785Hkc4xyDQ
         Wyig==
X-Gm-Message-State: AOJu0YyLvXRHgyEA8ojspxQlJk+p6Pqq6aKcoQi93HKnxh8f5GQFgVFG
	krFT9f1IzgogWpC3NBpZeOli0IKdzc9G5IF48OSd0m1V19QfTkPC20xsx5gYRg==
X-Gm-Gg: AfdE7clGm4Qoa695nq7nno17I5tCcCYj5ErqKCI0xrfTVMzSCbdqbSu675at91mz4dB
	6UV8hKrDvwOyAyRSPNZahdfCITdgUJgqgba1zopdvjQB8xMO/7c49Jd9FeLwCAZIpz/YbtK4qY4
	cmgzfAZ9WqFNRq/0rwMQJyH84OWF44WR7gVM/14eK8ZcytZywzCuSmMtkqvFYTqkDZ07daDAJS2
	NDyfkjvww7SQ9I8XqQtlpdI7/cs1P9xozFo1WS7C4EIoGZUpcosVUJC12qkinQrUmxVWArB0UZ5
	AFqZ46tupEaH0VqA+uip7e8M/cn3R442YXzzs1XniJhzGYWFzNLqZalKAmI7iAJ57Xp+v185UxE
	jxvluiyevDObbpFqmuZ9eVSmVMa++SJYDoN3Z49iLJyUMtmtfBSHXtIo0U9zsSNPFOlXgfZ3iyO
	g8Ce05UP9QJJrTwdrszcJJMrAMyxfQ0Cx1t0/AiG9ObGTlEpqN3vxeQn9J+bxsuLMBmbYdq944t
	A==
X-Received: by 2002:a05:6102:508e:b0:739:15ef:cdfb with SMTP id ada2fe7eead31-744dff7d21emr7358760137.5.1783692999103;
        Fri, 10 Jul 2026 07:16:39 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:38 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 33/36] tuna: Add tests for cpuset name display in show_threads -G
Date: Fri, 10 Jul 2026 10:15:11 -0400
Message-ID: <20260710141523.36440-34-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710141523.36440-1-jkacur@redhat.com>
References: <20260710141523.36440-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add comprehensive test suite for the enhanced cpuset display
functionality in 'tuna show_threads -G'.

Test coverage:
- 7 non-root tests for extract_cpuset_name() function
  - Basic cpuset extraction: "0::/tuna0" → "tuna0"
  - Root cgroup: "0::/" → ""
  - System/user slices: first component extraction
  - Nested cpusets and edge cases (empty, None)
- 4 root-required tests for display behavior
  - Verify cpuset name display (not full path)
  - Verify header shows "cpuset" not "cgroup"
  - Verify root cgroup displays as empty
  - Verify system.slice processes show shortened names

Total new tests: 11 (7 non-root + 4 root-required)
Updated test count: 142 tests (45 non-root + 97 root-required)

Documentation updates:
- Makefile: Added test-show-threads-cgroups target
- tests/README.md: Updated test counts and added test descriptions

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                           |   8 +-
 tests/README.md                    |  82 +++++++++---
 tests/test_show_threads_cgroups.py | 199 +++++++++++++++++++++++++++++
 3 files changed, 267 insertions(+), 22 deletions(-)
 create mode 100644 tests/test_show_threads_cgroups.py

diff --git a/Makefile b/Makefile
index 9e3ffe81bda5..b68c2a2a9925 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ cleanlogs:
 .PHONY: clean
 clean: pyclean
 
-.PHONY: tests unit-tests test-eperm test-converters test-cpuset test-cpuset-cli test-isolate-cpuset test-show-threads-cpuset test-all
+.PHONY: tests unit-tests test-eperm test-converters test-cpuset test-cpuset-cli test-isolate-cpuset test-show-threads-cpuset test-show-threads-cgroups test-all
 tests: unit-tests
 
 unit-tests:
@@ -45,4 +45,8 @@ test-isolate-cpuset:
 test-show-threads-cpuset:
 	@sudo python3 -m unittest tests.test_show_threads_cpuset -v
 
-test-all: test-eperm test-converters test-cpuset test-cpuset-cli test-show-threads-cpuset
+test-show-threads-cgroups:
+	@python3 -m unittest tests.test_show_threads_cgroups.TestExtractCpusetName -v
+	@sudo python3 -m unittest tests.test_show_threads_cgroups.TestShowThreadsCgroupsDisplay -v
+
+test-all: test-eperm test-converters test-cpuset test-cpuset-cli test-show-threads-cpuset test-show-threads-cgroups
diff --git a/tests/README.md b/tests/README.md
index f9908326d6f3..799fc1ffe2dd 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -9,10 +9,10 @@ This directory contains the test suite for tuna, using Python's `unittest` frame
 ## Quick Start
 
 ```bash
-# Run all non-root tests only (38 tests)
+# Run all non-root tests only (45 tests)
 make tests
 
-# Run ALL tests (all 131 tests, requires sudo for root-required tests)
+# Run ALL tests (all 142 tests, requires sudo for root-required tests)
 make test-all
 
 # Run specific test module
@@ -32,12 +32,12 @@ sudo python3 -m unittest tests.test_cpuset -v
 Run all unit tests using any of these methods:
 
 ```bash
-# Using make (non-root tests only, 38 tests)
+# Using make (non-root tests only, 45 tests)
 make tests
 # or
 make unit-tests
 
-# Using make (ALL tests including root-required tests, 131 tests)
+# Using make (ALL tests including root-required tests, 142 tests)
 make test-all
 
 # Using the test runner directly (non-root tests only)
@@ -64,6 +64,7 @@ make test-cpuset
 make test-cpuset-cli
 make test-isolate-cpuset
 make test-show-threads-cpuset
+make test-show-threads-cgroups
 
 # Or using Python unittest directly
 python3 -m unittest tests.test_eperm_handling -v
@@ -72,6 +73,8 @@ sudo python3 -m unittest tests.test_cpuset -v
 sudo python3 -m unittest tests.test_cpuset_cli -v
 sudo python3 -m unittest tests.test_cpuset_cli.TestTunaIsolateCpusetCLI -v
 sudo python3 -m unittest tests.test_show_threads_cpuset -v
+python3 -m unittest tests.test_show_threads_cgroups.TestExtractCpusetName -v
+sudo python3 -m unittest tests.test_show_threads_cgroups.TestShowThreadsCgroupsDisplay -v
 ```
 
 ### Specific Test Class
@@ -113,7 +116,7 @@ Tests are organized using Python's `unittest` framework. Each test file contains
 
 ### Current Tests
 
-#### Non-Root Tests (38 tests)
+#### Non-Root Tests (45 tests)
 
 - **test_eperm_handling.py** (6 tests) - Tests for EPERM error handling
   - Verifies that Permission Denied errors are handled gracefully
@@ -155,7 +158,16 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - Can run without root as it only checks help output
   - Run: `python3 -m unittest tests.test_show_threads_cpuset.TestShowThreadsCpusetFilterNonRoot -v`
 
-#### Root-Required Tests (93 tests)
+- **test_show_threads_cgroups.py::TestExtractCpusetName** (7 tests) - Cpuset name extraction tests
+  - Tests extract_cpuset_name() function for parsing cgroup paths
+  - Tests basic cpuset name extraction: "0::/tuna0" → "tuna0"
+  - Tests root cgroup: "0::/" → ""
+  - Tests system.slice: "0::/system.slice/ssh.service" → "system.slice"
+  - Tests user.slice and nested cpusets
+  - Tests edge cases: empty string and None inputs
+  - Run: `python3 -m unittest tests.test_show_threads_cgroups.TestExtractCpusetName -v`
+
+#### Root-Required Tests (97 tests)
 
 - **test_process_blocklist.py** (2 tests) - Process blocklist root tests
   - Tests actual blocking of systemd from being moved to cpusets
@@ -199,13 +211,21 @@ Tests are organized using Python's `unittest` framework. Each test file contains
     - test_filter_empty_cpuset: Tests filtering on empty cpuset
   - Run: `sudo python3 -m unittest tests.test_show_threads_cpuset -v`
 
-**Total: 131 tests** (38 non-root + 93 root-required)
+- **test_show_threads_cgroups.py** (4 tests) - show_threads -G cpuset display tests
+  - TestShowThreadsCgroupsDisplay: Tests cpuset name display in show_threads -G output
+    - test_cgroups_displays_cpuset_name: Verifies -G shows cpuset name, not full path
+    - test_cgroups_header_shows_cpuset: Verifies header says "cpuset" not "cgroup"
+    - test_cgroups_displays_root_as_empty: Verifies root cgroup shows empty cpuset
+    - test_cgroups_displays_system_slice_shortened: Verifies system.slice shows shortened name
+  - Run: `sudo python3 -m unittest tests.test_show_threads_cgroups.TestShowThreadsCgroupsDisplay -v`
+
+**Total: 142 tests** (45 non-root + 97 root-required)
 
 ### Test Requirements: Root vs Non-Root
 
 The test suite is split between tests that require root and those that don't:
 
-#### Non-Root Tests (38 tests)
+#### Non-Root Tests (45 tests)
 
 These tests run without root privileges:
 
@@ -237,13 +257,18 @@ These tests run without root privileges:
    - Tests that --cpuset option appears in help text
    - Read-only operation checking command-line interface
 
+7. **Cpuset name extraction tests** verify cgroup path parsing
+   - Test extract_cpuset_name() function for parsing cgroup paths
+   - Test various cgroup path formats (cpusets, system.slice, user.slice, etc.)
+   - Pure logic testing with no system dependencies
+
 **Benefits:**
 - Developers can run basic tests without `sudo`
 - Tests run in CI/CD environments without elevated privileges
 - Tests are fast and don't affect the running system
 - Tests verify both happy path (with mocks) and error path (with real EPERM)
 
-#### Root-Required Tests (93 tests)
+#### Root-Required Tests (97 tests)
 
 These tests require root to create/manipulate cgroups:
 
@@ -272,6 +297,13 @@ These tests require root to create/manipulate cgroups:
    - Test filtering on empty cpusets
    - All tests create temporary cpusets and processes, then clean up
 
+4. **show_threads -G cpuset display tests** (4 tests) test cpuset name display
+   - Test that -G displays cpuset name instead of full cgroup path
+   - Test that header shows "cpuset" instead of "cgroup"
+   - Test that root cgroup displays as empty string
+   - Test that system.slice processes show shortened names
+   - All tests create temporary cpusets and processes, then clean up
+
 **Why root is required:**
 - Creating cgroups requires write access to /sys/fs/cgroup
 - Migrating processes between cgroups requires CAP_SYS_ADMIN
@@ -361,7 +393,7 @@ self.assertRaises(Exception, fn) # fn() raises Exception
 
 ## Expected Output
 
-### Non-Root Tests Only (38 tests)
+### Non-Root Tests Only (45 tests)
 
 Running without sudo will run only the non-root tests:
 
@@ -391,21 +423,28 @@ test_get_numa_nodes_for_empty_list (test_cpuset.TestNumaDetection) ... ok
 test_get_numa_nodes_for_single_cpu (test_cpuset.TestNumaDetection) ... ok
 test_numa_node_contains (test_cpuset.TestNumaDetection) ... ok
 test_numa_node_int (test_cpuset.TestNumaDetection) ... ok
+test_extract_cpuset_name_basic (test_show_threads_cgroups.TestExtractCpusetName) ... ok
+test_extract_cpuset_name_root (test_show_threads_cgroups.TestExtractCpusetName) ... ok
+test_extract_cpuset_name_system_slice (test_show_threads_cgroups.TestExtractCpusetName) ... ok
+test_extract_cpuset_name_user_slice (test_show_threads_cgroups.TestExtractCpusetName) ... ok
+test_extract_cpuset_name_nested (test_show_threads_cgroups.TestExtractCpusetName) ... ok
+test_extract_cpuset_name_empty_string (test_show_threads_cgroups.TestExtractCpusetName) ... ok
+test_extract_cpuset_name_none (test_show_threads_cgroups.TestExtractCpusetName) ... ok
 ... (most cpuset tests skipped: "Requires root permissions")
 
 ----------------------------------------------------------------------
-Ran 38 tests in 0.XXXs
+Ran 45 tests in 0.XXXs
 
-OK (skipped=93)
+OK (skipped=97)
 ```
 
-### All Tests Including Root-Required (131 tests)
+### All Tests Including Root-Required (142 tests)
 
-Running with sudo will run all 131 tests:
+Running with sudo will run all 142 tests:
 
 ```bash
 $ sudo python3 -m unittest discover -s tests -p "test_*.py" -v
-... (38 non-root tests as above)
+... (45 non-root tests as above)
 test_initialization (test_cpuset.TestCpusetsInit) ... ok
 test_cpuset_path (test_cpuset.TestCpusetsInit) ... ok
 ... (32 cpuset module tests)
@@ -413,9 +452,10 @@ test_first_name_is_tuna0 (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
 test_sequential_naming (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
 ... (45 cpuset CLI tests)
 ... (6 show_threads --cpuset tests)
+... (4 show_threads -G display tests)
 
 ----------------------------------------------------------------------
-Ran 131 tests in X.XXXs
+Ran 142 tests in X.XXXs
 
 OK
 ```
@@ -424,18 +464,20 @@ OK
 
 The test suite includes:
 
-### Unit Tests (38 tests - no root required)
+### Unit Tests (45 tests - no root required)
 - **Converter tests**: Pure logic testing with mocks
 - **EPERM tests**: Error handling verification
 - **CpusetsInit tests**: System capability detection (read-only)
 - **NUMA detection tests**: NUMA topology discovery and memory node assignment (read-only)
 - **show_threads --cpuset help test**: CLI documentation verification (read-only)
+- **Cpuset name extraction tests**: Cgroup path parsing logic (pure function testing)
 
-### Integration Tests (93 tests - require root)
+### Integration Tests (97 tests - require root)
 - **Process blocklist tests**: Test blocklist protection (2 root-required tests)
 - **Cpuset module tests**: Test interaction with cgroup v2 subsystem
 - **Cpuset CLI tests**: Test command-line interface integration
 - **show_threads --cpuset tests**: Test process filtering by cpuset membership
+- **show_threads -G display tests**: Test cpuset name display in cgroups output
 
 Future test categories might include:
 - **System tests** - Full end-to-end tests requiring CPU affinity operations
@@ -446,7 +488,7 @@ Future test categories might include:
 
 ### Non-Root Tests (Recommended for CI)
 
-The non-root tests (38 tests) are designed to run in CI/CD environments:
+The non-root tests (45 tests) are designed to run in CI/CD environments:
 - Run without root privileges
 - No special system configuration required
 - Exit code 0 on success, non-zero on failure
@@ -460,7 +502,7 @@ python3 -m unittest discover -s tests -p "test_*.py" -v
 
 ### Root-Required Tests (Optional for CI)
 
-The cpuset tests (93 tests) can run in CI with special setup:
+The cpuset tests (97 tests) can run in CI with special setup:
 - Requires root access or privileged containers
 - Requires cgroup v2 support
 - May need dedicated test runners with appropriate permissions
diff --git a/tests/test_show_threads_cgroups.py b/tests/test_show_threads_cgroups.py
new file mode 100644
index 000000000000..67fbb7e5a6ff
--- /dev/null
+++ b/tests/test_show_threads_cgroups.py
@@ -0,0 +1,199 @@
+#!/usr/bin/python3
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-only
+"""
+Test suite for tuna show_threads -G cpuset display
+
+Tests the cpuset name extraction and display in show_threads -G output.
+"""
+
+import unittest
+import os
+import sys
+import subprocess
+import time
+import importlib.util
+from pathlib import Path
+
+# Add tuna to path if running from tests directory
+if Path(__file__).parent.name == 'tests':
+    sys.path.insert(0, str(Path(__file__).parent.parent))
+
+from tuna import cpuset
+import importlib.util
+
+# Load tuna-cmd.py as a module
+spec = importlib.util.spec_from_file_location("tuna_cmd", "tuna-cmd.py")
+tuna_cmd = importlib.util.module_from_spec(spec)
+
+
+class TestExtractCpusetName(unittest.TestCase):
+    """Test extract_cpuset_name() function (non-root tests)"""
+
+    @classmethod
+    def setUpClass(cls):
+        """Load the extract_cpuset_name function"""
+        spec.loader.exec_module(tuna_cmd)
+        cls.extract_cpuset_name = staticmethod(tuna_cmd.extract_cpuset_name)
+
+    def test_extract_cpuset_name_basic(self):
+        """Test basic cpuset name extraction"""
+        result = self.extract_cpuset_name("0::/tuna0")
+        self.assertEqual(result, "tuna0")
+
+    def test_extract_cpuset_name_root(self):
+        """Test root cgroup extraction"""
+        result = self.extract_cpuset_name("0::/")
+        self.assertEqual(result, "")
+
+    def test_extract_cpuset_name_system_slice(self):
+        """Test system.slice extraction"""
+        result = self.extract_cpuset_name("0::/system.slice/ssh.service")
+        self.assertEqual(result, "system.slice")
+
+    def test_extract_cpuset_name_user_slice(self):
+        """Test user.slice extraction"""
+        result = self.extract_cpuset_name("0::/user.slice/user-1000.slice/session-2.scope")
+        self.assertEqual(result, "user.slice")
+
+    def test_extract_cpuset_name_nested(self):
+        """Test nested cpuset extraction"""
+        result = self.extract_cpuset_name("0::/parent/child")
+        self.assertEqual(result, "parent")
+
+    def test_extract_cpuset_name_empty_string(self):
+        """Test empty string input"""
+        result = self.extract_cpuset_name("")
+        self.assertEqual(result, "")
+
+    def test_extract_cpuset_name_none(self):
+        """Test None input"""
+        result = self.extract_cpuset_name(None)
+        self.assertEqual(result, "")
+
+
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestShowThreadsCgroupsDisplay(unittest.TestCase):
+    """Test show_threads -G cpuset display with root permissions"""
+
+    @classmethod
+    def setUpClass(cls):
+        """Set up test environment once for all tests"""
+        cls.ci = cpuset.CpusetsInit()
+        cls.test_cpuset_name = 'test_cgroups_display'
+        cls.sleep_proc = None
+
+    def setUp(self):
+        """Clean up before each test"""
+        # Clean up any leftover test cpusets
+        try:
+            cpuset.destroy_cpuset(self.test_cpuset_name, force=True)
+        except:
+            pass
+
+    def tearDown(self):
+        """Clean up after each test"""
+        # Kill sleep process if running
+        if self.sleep_proc and self.sleep_proc.poll() is None:
+            self.sleep_proc.kill()
+            self.sleep_proc.wait()
+            self.sleep_proc = None
+
+        # Destroy test cpuset
+        try:
+            cpuset.destroy_cpuset(self.test_cpuset_name, force=True)
+        except:
+            pass
+
+    def test_cgroups_displays_cpuset_name(self):
+        """Test that -G displays cpuset name (not full path)"""
+        # Create test cpuset
+        cs = cpuset.Cpuset(self.test_cpuset_name)
+        cs.assign_cpus('0-1')
+        cs.write_memnode('0')
+
+        # Start a sleep process
+        self.sleep_proc = subprocess.Popen(['sleep', '60'])
+        sleep_pid = self.sleep_proc.pid
+        time.sleep(0.1)
+
+        # Move to cpuset
+        cs.write_pid(sleep_pid)
+        time.sleep(0.1)
+
+        # Run show_threads with -G
+        result = subprocess.run(
+            [sys.executable, 'tuna-cmd.py', 'show_threads', '-G', '-t', str(sleep_pid)],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertEqual(result.returncode, 0)
+        # Should show cpuset name, not full path
+        self.assertIn(self.test_cpuset_name, result.stdout)
+        # Should NOT show "0::/" prefix
+        self.assertNotIn("0::", result.stdout)
+
+    def test_cgroups_header_shows_cpuset(self):
+        """Test that -G header shows 'cpuset' not 'cgroup'"""
+        # Import necessary modules to test the header function directly
+        import io
+        import sys as test_sys
+        from importlib import reload
+
+        # Reload tuna_cmd to get fresh import
+        spec = importlib.util.spec_from_file_location("tuna_cmd", "tuna-cmd.py")
+        tuna_cmd = importlib.util.module_from_spec(spec)
+        spec.loader.exec_module(tuna_cmd)
+
+        # Initialize i18n to set up the _() function
+        tuna_cmd.i18n_init()
+
+        # Capture output from ps_show_header
+        old_stdout = test_sys.stdout
+        test_sys.stdout = io.StringIO()
+
+        try:
+            # Call ps_show_header with cgroups=True
+            tuna_cmd.ps_show_header(has_ctxt_switch_info=False, cgroups=True)
+            output = test_sys.stdout.getvalue()
+
+            # Header should say "cpuset" not "cgroup"
+            self.assertIn("cpuset", output)
+        finally:
+            test_sys.stdout = old_stdout
+
+    def test_cgroups_displays_root_as_empty(self):
+        """Test that processes in root cgroup show empty cpuset"""
+        # Get a process that's likely in root cgroup (PID 1 - systemd)
+        result = subprocess.run(
+            [sys.executable, 'tuna-cmd.py', 'show_threads', '-G', '-t', '1'],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertEqual(result.returncode, 0)
+        # Should NOT show "0::/" for root cgroup
+        self.assertNotIn("0::/", result.stdout)
+
+    def test_cgroups_displays_system_slice_shortened(self):
+        """Test that system.slice processes show shortened name"""
+        # Find a process in system.slice (many system daemons are there)
+        # We'll look for any process and check the display format
+        result = subprocess.run(
+            [sys.executable, 'tuna-cmd.py', 'show_threads', '-G'],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertEqual(result.returncode, 0)
+        # If any system.slice processes exist, they should show "system.slice"
+        # not the full path like "0::/system.slice/service.service"
+        if "system.slice" in result.stdout:
+            # Should NOT show "0::/" prefix
+            self.assertNotIn("0::/system.slice/", result.stdout)
+
+
+if __name__ == '__main__':
+    unittest.main()
-- 
2.54.0

