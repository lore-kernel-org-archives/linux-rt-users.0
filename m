Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879633F8DC
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692999; cv=none; b=UkG0RdQPDxqEgLXiw5WdH44rwIrRqClEJk6ELU7o4Q9zRoUMsgFF0TAbth3otyXK9ueKXeVR7atyzznLBOGqzF6yKmCdzhdMjRoGvPwi4WbMkW6dx3OYQdDurFpJkOGYO8kduXZaZoJigsr7PtwyFB2xJ5zsBP5eFtrKN5ZbeZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692999; c=relaxed/simple;
	bh=RugnbimNh1gFEV7aLc9xRAm6lreKGIEMVTFnQ1NaMnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxo15DbkGkGIZX7tuFaauHJDeowndjQtjx+Pv/YENXdOPWqWSS7ZuybDY5nZ40ah2uJgHVm/otgYou+G+ljd8xPcMtimqYcfP83CqtxQZW2QVn+BkkL442E6jMTqEPmXnXaKPaZh3sHWg+HA6+dWAkmeTdwvsfkvR7FCJwjL8RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwmhQH4v; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwmhQH4v"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9666739d3bcso248658241.0
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692996; x=1784297796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D3mxv5lPjKvhk9oxFwX6F1f/iqdRzKjQP04spXHqqwY=;
        b=XwmhQH4vGUH+Om5xj5XXE0N3x6bDGnqkjd+cyq2aa1NArigVrcRad3lvvO5rbj2sf3
         IdgY7WDYChelMvXvfpFPSAyy40P+kus5xqGJR2m4Xgywqc+82XPiVOHh7tUxgG9+11Dl
         jQMzkEmucsVTk3L5t8rv1Cs6gwEiGTs80YO5S3SxWWqk+nWhrtVmY795M/cF0HdRS1xW
         VyESl+AA0NUyEGlS9K1LcC1q32a8WqH6n6EcNc3kgaQvcd+R66ZnuQznZfrSDf3g0QbB
         WL9SiVandu+L4TpNIZ1DYcx62kc0bT/5DM1ycPKrsvadruyOnfNwYBqS0SitElNmwN86
         jl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692996; x=1784297796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D3mxv5lPjKvhk9oxFwX6F1f/iqdRzKjQP04spXHqqwY=;
        b=sT5WwUlwbq4JZbVAmQGYU3X3M+zEo6y5AU76kESO6j1zhXXz6iAfq8RqOCFw7i6u0H
         dZCNHd7Bibs13Mi2dPu1YZ+ozpWhNQc9LLkmQdgL+IhIZ8A/ZIl/Ei8G/oWyF1rtefc+
         4JEYSkW5FTFbQYDRo5BWEvoO8fAUJgdMkMUcqcWn1LRUIbH8WdifjdTqWfRYhI8E//GM
         Shy41WM7Fx6MLxqRETK5W4tcoiSvS9gAzWDbsi4lblBYbMGYKRT27RzC3/7ltex/l6Pf
         RaeaWNZtZV1IbgH9dPF8iiE51qYI2EtdB6PV4FVz+zjICboxqMuD6p321AVk/jIPgNg8
         Z8VQ==
X-Gm-Message-State: AOJu0YzSBpsNIHgr8Q/f8ogXxA4ZhgNDhzyXz3iXu99AIEPtMgHpVZSY
	3dAoQ2wKlHdOR5pbWypHEXqHuN/rNhZF9EyuDH3I4kBzbF8bRRF//Q4P9weVwA==
X-Gm-Gg: AfdE7clA5PJRAX9SMcLhgNTwz/tGds2ftJYUBBIFK2uBldbMPBa8LhgPMmxARdFC9Qi
	faeRORet3fiVy0Ba3SMpF8w3HPBX5lo4kmIKfbAqlwsd34IXazkhQWPaplExmGeUaX4Uy6NvQG6
	RgzzP4zug/NtuurqWWkfi1oEXzs8XAomVZyIJGFF2S3uEP6mpEYAM37JBkooqTfg1Oziyo7QvEe
	/s6NREXQjFgL5XiBu07aFGNYnNWPw19BSiY0HSjlus6JPXJkIDUi2/4jeoLrDXFyMK9ylpEAgDY
	yGjUekVmUYKQE87SImjKCIUvSSNZRaWmRnQG3xxduvFLP6erFYc+uj2+xhcSGlcHUf3RzOqdN+c
	fXrhuPXu9GhN6kwDcr71v707NvPUFqIbfHGJc+tRWhRVYzgMAL5LGqSabZqGfM+8SoKq/3tMFOo
	uPL/IT6PwlBieM9DDm+/PVLh49wCIU698nhhTZeAJq0FfORWdqveplZYEgkPo/tBUhDtujWflRa
	Q==
X-Received: by 2002:a05:6102:3911:b0:726:e608:6658 with SMTP id ada2fe7eead31-744dff43a82mr6909557137.11.1783692995411;
        Fri, 10 Jul 2026 07:16:35 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:34 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 31/36] tuna: Add tests for show_threads --cpuset filter
Date: Fri, 10 Jul 2026 10:15:09 -0400
Message-ID: <20260710141523.36440-32-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710141523.36440-1-jkacur@redhat.com>
References: <20260710141523.36440-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comprehensive test suite for the new --cpuset filter option in
show_threads command. Tests verify correct filtering behavior across
various scenarios and edge cases.

Test coverage includes:
- Basic filtering to show only processes in specified cpuset
- Filtering with non-existent cpuset (shows nothing)
- Exclusion of processes from other cpusets
- Combining --cpuset with -G (cgroup display)
- Combining --cpuset with -t (thread list)
- Filtering on empty cpusets

The test file includes 7 tests total:
- 1 non-root test: Verifies --cpuset appears in help output
- 6 root-required tests: Create temporary cpusets and processes to test
  filtering behavior, then clean up

Also updates:
- Makefile: Add test-show-threads-cpuset target and include in test-all
- tests/README.md: Update test counts (131 total: 38 non-root + 93 root)
  and document the new test suite

All tests pass successfully and integrate with the existing test
infrastructure using Python's unittest framework.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                          |   7 +-
 tests/README.md                   |  76 ++++++---
 tests/test_show_threads_cpuset.py | 245 ++++++++++++++++++++++++++++++
 3 files changed, 304 insertions(+), 24 deletions(-)
 create mode 100755 tests/test_show_threads_cpuset.py

diff --git a/Makefile b/Makefile
index 7d3d3f10b6ab..9e3ffe81bda5 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ cleanlogs:
 .PHONY: clean
 clean: pyclean
 
-.PHONY: tests unit-tests test-eperm test-converters test-cpuset test-cpuset-cli test-isolate-cpuset test-all
+.PHONY: tests unit-tests test-eperm test-converters test-cpuset test-cpuset-cli test-isolate-cpuset test-show-threads-cpuset test-all
 tests: unit-tests
 
 unit-tests:
@@ -42,4 +42,7 @@ test-cpuset-cli:
 test-isolate-cpuset:
 	@sudo python3 -m unittest tests.test_cpuset_cli.TestTunaIsolateCpusetCLI -v
 
-test-all: test-eperm test-converters test-cpuset test-cpuset-cli
+test-show-threads-cpuset:
+	@sudo python3 -m unittest tests.test_show_threads_cpuset -v
+
+test-all: test-eperm test-converters test-cpuset test-cpuset-cli test-show-threads-cpuset
diff --git a/tests/README.md b/tests/README.md
index 514907db43ee..f9908326d6f3 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -9,10 +9,10 @@ This directory contains the test suite for tuna, using Python's `unittest` frame
 ## Quick Start
 
 ```bash
-# Run all non-root tests only (37 tests)
+# Run all non-root tests only (38 tests)
 make tests
 
-# Run ALL tests (all 116 tests, requires sudo for root-required tests)
+# Run ALL tests (all 131 tests, requires sudo for root-required tests)
 make test-all
 
 # Run specific test module
@@ -32,12 +32,12 @@ sudo python3 -m unittest tests.test_cpuset -v
 Run all unit tests using any of these methods:
 
 ```bash
-# Using make (non-root tests only, 37 tests)
+# Using make (non-root tests only, 38 tests)
 make tests
 # or
 make unit-tests
 
-# Using make (ALL tests including root-required tests, 116 tests)
+# Using make (ALL tests including root-required tests, 131 tests)
 make test-all
 
 # Using the test runner directly (non-root tests only)
@@ -63,6 +63,7 @@ make test-converters
 make test-cpuset
 make test-cpuset-cli
 make test-isolate-cpuset
+make test-show-threads-cpuset
 
 # Or using Python unittest directly
 python3 -m unittest tests.test_eperm_handling -v
@@ -70,6 +71,7 @@ python3 -m unittest tests.test_converters -v
 sudo python3 -m unittest tests.test_cpuset -v
 sudo python3 -m unittest tests.test_cpuset_cli -v
 sudo python3 -m unittest tests.test_cpuset_cli.TestTunaIsolateCpusetCLI -v
+sudo python3 -m unittest tests.test_show_threads_cpuset -v
 ```
 
 ### Specific Test Class
@@ -111,7 +113,7 @@ Tests are organized using Python's `unittest` framework. Each test file contains
 
 ### Current Tests
 
-#### Non-Root Tests (37 tests)
+#### Non-Root Tests (38 tests)
 
 - **test_eperm_handling.py** (6 tests) - Tests for EPERM error handling
   - Verifies that Permission Denied errors are handled gracefully
@@ -148,7 +150,12 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - Validates smart NUMA-aware memory node assignment for cpusets
   - Run: `python3 -m unittest tests.test_cpuset.TestNumaDetection -v`
 
-#### Root-Required Tests (79 tests)
+- **test_show_threads_cpuset.py::TestShowThreadsCpusetFilterNonRoot** (1 test) - Help text verification
+  - Tests that --cpuset option appears in show_threads --help
+  - Can run without root as it only checks help output
+  - Run: `python3 -m unittest tests.test_show_threads_cpuset.TestShowThreadsCpusetFilterNonRoot -v`
+
+#### Root-Required Tests (93 tests)
 
 - **test_process_blocklist.py** (2 tests) - Process blocklist root tests
   - Tests actual blocking of systemd from being moved to cpusets
@@ -182,13 +189,23 @@ Tests are organized using Python's `unittest` framework. Each test file contains
     - Tests error handling and backward compatibility
   - Run: `sudo python3 -m unittest tests.test_cpuset_cli -v`
 
-**Total: 124 tests** (37 non-root + 87 root-required)
+- **test_show_threads_cpuset.py** (6 tests) - show_threads --cpuset filter tests
+  - TestShowThreadsCpusetFilter: Tests filtering processes by cpuset membership
+    - test_filter_shows_only_cpuset_processes: Verifies basic filtering works
+    - test_filter_with_nonexistent_cpuset: Tests non-existent cpuset shows nothing
+    - test_filter_excludes_other_cpuset_processes: Tests exclusion of other cpusets
+    - test_filter_with_cgroups_option: Tests combining --cpuset with -G
+    - test_filter_with_thread_list: Tests combining --cpuset with -t
+    - test_filter_empty_cpuset: Tests filtering on empty cpuset
+  - Run: `sudo python3 -m unittest tests.test_show_threads_cpuset -v`
+
+**Total: 131 tests** (38 non-root + 93 root-required)
 
 ### Test Requirements: Root vs Non-Root
 
 The test suite is split between tests that require root and those that don't:
 
-#### Non-Root Tests (37 tests)
+#### Non-Root Tests (38 tests)
 
 These tests run without root privileges:
 
@@ -216,13 +233,17 @@ These tests run without root privileges:
    - Test smart memory node assignment for CPU lists
    - Read-only operations that work on any system (single or multi-node)
 
+6. **show_threads --cpuset help test** verifies CLI documentation
+   - Tests that --cpuset option appears in help text
+   - Read-only operation checking command-line interface
+
 **Benefits:**
 - Developers can run basic tests without `sudo`
 - Tests run in CI/CD environments without elevated privileges
 - Tests are fast and don't affect the running system
 - Tests verify both happy path (with mocks) and error path (with real EPERM)
 
-#### Root-Required Tests (87 tests)
+#### Root-Required Tests (93 tests)
 
 These tests require root to create/manipulate cgroups:
 
@@ -232,7 +253,7 @@ These tests require root to create/manipulate cgroups:
    - Test task migration between cpusets
    - All tests clean up created cpusets in tearDown()
 
-2. **Cpuset CLI tests** (48 tests) test command-line interface functions
+2. **Cpuset CLI tests** (45 tests) test command-line interface functions
    - Test cpuset create/list/destroy/move/show/status/modify commands
    - Verify auto-naming logic (tuna0, tuna1, etc.)
    - Test NUMA-aware memory node auto-detection and manual override
@@ -243,6 +264,14 @@ These tests require root to create/manipulate cgroups:
    - Test tuna isolate --cpuset integration (8 tests) - cpuset-based CPU isolation
    - All tests clean up created cpusets afterwards
 
+3. **show_threads --cpuset filter tests** (6 tests) test process filtering by cpuset
+   - Test basic filtering to show only processes in a specific cpuset
+   - Test filtering with non-existent cpusets (shows nothing)
+   - Test exclusion of processes from other cpusets
+   - Test combining --cpuset with other options (-G, -t)
+   - Test filtering on empty cpusets
+   - All tests create temporary cpusets and processes, then clean up
+
 **Why root is required:**
 - Creating cgroups requires write access to /sys/fs/cgroup
 - Migrating processes between cgroups requires CAP_SYS_ADMIN
@@ -332,7 +361,7 @@ self.assertRaises(Exception, fn) # fn() raises Exception
 
 ## Expected Output
 
-### Non-Root Tests Only (37 tests)
+### Non-Root Tests Only (38 tests)
 
 Running without sudo will run only the non-root tests:
 
@@ -365,27 +394,28 @@ test_numa_node_int (test_cpuset.TestNumaDetection) ... ok
 ... (most cpuset tests skipped: "Requires root permissions")
 
 ----------------------------------------------------------------------
-Ran 37 tests in 0.XXXs
+Ran 38 tests in 0.XXXs
 
-OK (skipped=79)
+OK (skipped=93)
 ```
 
-### All Tests Including Root-Required (116 tests)
+### All Tests Including Root-Required (131 tests)
 
-Running with sudo will run all 116 tests:
+Running with sudo will run all 131 tests:
 
 ```bash
 $ sudo python3 -m unittest discover -s tests -p "test_*.py" -v
-... (37 non-root tests as above)
+... (38 non-root tests as above)
 test_initialization (test_cpuset.TestCpusetsInit) ... ok
 test_cpuset_path (test_cpuset.TestCpusetsInit) ... ok
 ... (32 cpuset module tests)
 test_first_name_is_tuna0 (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
 test_sequential_naming (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
-... (43 cpuset CLI tests)
+... (45 cpuset CLI tests)
+... (6 show_threads --cpuset tests)
 
 ----------------------------------------------------------------------
-Ran 116 tests in X.XXXs
+Ran 131 tests in X.XXXs
 
 OK
 ```
@@ -394,16 +424,18 @@ OK
 
 The test suite includes:
 
-### Unit Tests (37 tests - no root required)
+### Unit Tests (38 tests - no root required)
 - **Converter tests**: Pure logic testing with mocks
 - **EPERM tests**: Error handling verification
 - **CpusetsInit tests**: System capability detection (read-only)
 - **NUMA detection tests**: NUMA topology discovery and memory node assignment (read-only)
+- **show_threads --cpuset help test**: CLI documentation verification (read-only)
 
-### Integration Tests (79 tests - require root)
+### Integration Tests (93 tests - require root)
 - **Process blocklist tests**: Test blocklist protection (2 root-required tests)
 - **Cpuset module tests**: Test interaction with cgroup v2 subsystem
 - **Cpuset CLI tests**: Test command-line interface integration
+- **show_threads --cpuset tests**: Test process filtering by cpuset membership
 
 Future test categories might include:
 - **System tests** - Full end-to-end tests requiring CPU affinity operations
@@ -414,7 +446,7 @@ Future test categories might include:
 
 ### Non-Root Tests (Recommended for CI)
 
-The non-root tests (37 tests) are designed to run in CI/CD environments:
+The non-root tests (38 tests) are designed to run in CI/CD environments:
 - Run without root privileges
 - No special system configuration required
 - Exit code 0 on success, non-zero on failure
@@ -428,7 +460,7 @@ python3 -m unittest discover -s tests -p "test_*.py" -v
 
 ### Root-Required Tests (Optional for CI)
 
-The cpuset tests (74 tests) can run in CI with special setup:
+The cpuset tests (93 tests) can run in CI with special setup:
 - Requires root access or privileged containers
 - Requires cgroup v2 support
 - May need dedicated test runners with appropriate permissions
diff --git a/tests/test_show_threads_cpuset.py b/tests/test_show_threads_cpuset.py
new file mode 100755
index 000000000000..fd1c70489cd4
--- /dev/null
+++ b/tests/test_show_threads_cpuset.py
@@ -0,0 +1,245 @@
+#!/usr/bin/python3
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-only
+"""
+Test suite for tuna show_threads --cpuset filter
+
+Tests the --cpuset filter option added to show_threads command.
+"""
+
+import unittest
+import os
+import sys
+import subprocess
+import time
+from pathlib import Path
+
+# Add tuna to path if running from tests directory
+if Path(__file__).parent.name == 'tests':
+    sys.path.insert(0, str(Path(__file__).parent.parent))
+
+from tuna import cpuset
+
+
+class TestShowThreadsCpusetFilterNonRoot(unittest.TestCase):
+    """Test show_threads --cpuset filter without root (basic tests)"""
+
+    def test_help_shows_cpuset_option(self):
+        """Test that --cpuset option appears in help"""
+        result = subprocess.run(
+            [sys.executable, 'tuna-cmd.py', 'show_threads', '--help'],
+            capture_output=True,
+            text=True
+        )
+        self.assertEqual(result.returncode, 0)
+        self.assertIn('--cpuset', result.stdout)
+        self.assertIn('Show only threads in the specified cpuset', result.stdout)
+
+
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestShowThreadsCpusetFilter(unittest.TestCase):
+    """Test show_threads --cpuset filter with root permissions"""
+
+    @classmethod
+    def setUpClass(cls):
+        """Set up test environment once for all tests"""
+        cls.ci = cpuset.CpusetsInit()
+        cls.test_cpuset_name = 'test_show_filter'
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
+    def test_filter_shows_only_cpuset_processes(self):
+        """Test that --cpuset filter shows only processes in specified cpuset"""
+        # Create test cpuset
+        cs = cpuset.Cpuset(self.test_cpuset_name)
+        cs.assign_cpus('0-1')
+        cs.write_memnode('0')
+
+        # Start a sleep process in the background
+        self.sleep_proc = subprocess.Popen(['sleep', '60'])
+        sleep_pid = self.sleep_proc.pid
+        time.sleep(0.1)  # Give process time to start
+
+        # Move sleep process to test cpuset
+        cs.write_pid(sleep_pid)
+        time.sleep(0.1)  # Give cgroup time to update
+
+        # Verify process is in the cpuset
+        with open(f'/proc/{sleep_pid}/cgroup', 'r') as f:
+            cgroup = f.read().strip()
+        self.assertIn(self.test_cpuset_name, cgroup)
+
+        # Run show_threads with cpuset filter
+        result = subprocess.run(
+            [sys.executable, 'tuna-cmd.py', 'show_threads', '--cpuset', self.test_cpuset_name],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertEqual(result.returncode, 0)
+        # Check that sleep process is in output
+        self.assertIn(str(sleep_pid), result.stdout)
+        self.assertIn('sleep', result.stdout)
+
+    def test_filter_with_nonexistent_cpuset(self):
+        """Test that filtering with non-existent cpuset shows no processes"""
+        # Run show_threads with non-existent cpuset
+        result = subprocess.run(
+            [sys.executable, 'tuna-cmd.py', 'show_threads', '--cpuset', 'nonexistent_cpuset'],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertEqual(result.returncode, 0)
+        # Output should be empty or just header
+        lines = [line for line in result.stdout.split('\n') if line.strip()]
+        # Should have at most 2 lines (header rows) and no process entries
+        self.assertLessEqual(len(lines), 2, "Should show no processes for non-existent cpuset")
+
+    def test_filter_excludes_other_cpuset_processes(self):
+        """Test that filter excludes processes from other cpusets"""
+        # Create first test cpuset
+        cs1 = cpuset.Cpuset(self.test_cpuset_name)
+        cs1.assign_cpus('0-1')
+        cs1.write_memnode('0')
+
+        # Create second cpuset
+        cs2_name = f'{self.test_cpuset_name}_2'
+        try:
+            cs2 = cpuset.Cpuset(cs2_name)
+            cs2.assign_cpus('0-1')
+            cs2.write_memnode('0')
+
+            # Start two sleep processes
+            self.sleep_proc = subprocess.Popen(['sleep', '60'])
+            sleep_pid1 = self.sleep_proc.pid
+            sleep_proc2 = subprocess.Popen(['sleep', '60'])
+            sleep_pid2 = sleep_proc2.pid
+            time.sleep(0.1)
+
+            # Move first to test_cpuset_name, second to test_cpuset_name_2
+            cs1.write_pid(sleep_pid1)
+            cs2.write_pid(sleep_pid2)
+            time.sleep(0.1)
+
+            # Filter for first cpuset
+            result = subprocess.run(
+                [sys.executable, 'tuna-cmd.py', 'show_threads', '--cpuset', self.test_cpuset_name],
+                capture_output=True,
+                text=True
+            )
+
+            self.assertEqual(result.returncode, 0)
+            # Should show first process but not second
+            self.assertIn(str(sleep_pid1), result.stdout)
+            self.assertNotIn(str(sleep_pid2), result.stdout)
+
+            # Clean up second process and cpuset
+            sleep_proc2.kill()
+            sleep_proc2.wait()
+
+        finally:
+            # Clean up second cpuset
+            try:
+                cpuset.destroy_cpuset(cs2_name, force=True)
+            except:
+                pass
+
+    def test_filter_with_cgroups_option(self):
+        """Test that --cpuset works together with -G (cgroups display)"""
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
+        # Run with both --cpuset and -G
+        result = subprocess.run(
+            [sys.executable, 'tuna-cmd.py', 'show_threads', '--cpuset', self.test_cpuset_name, '-G'],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertEqual(result.returncode, 0)
+        self.assertIn(str(sleep_pid), result.stdout)
+        # Should show cgroup path in output
+        self.assertIn(self.test_cpuset_name, result.stdout)
+
+    def test_filter_with_thread_list(self):
+        """Test that --cpuset can be combined with -t (thread list)"""
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
+        # Run with both --cpuset and -t
+        result = subprocess.run(
+            [sys.executable, 'tuna-cmd.py', 'show_threads', '--cpuset', self.test_cpuset_name, '-t', str(sleep_pid)],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertEqual(result.returncode, 0)
+        self.assertIn(str(sleep_pid), result.stdout)
+
+    def test_filter_empty_cpuset(self):
+        """Test filtering on an empty cpuset (no processes)"""
+        # Create empty cpuset
+        cs = cpuset.Cpuset(self.test_cpuset_name)
+        cs.assign_cpus('0-1')
+        cs.write_memnode('0')
+
+        # Filter for empty cpuset
+        result = subprocess.run(
+            [sys.executable, 'tuna-cmd.py', 'show_threads', '--cpuset', self.test_cpuset_name],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertEqual(result.returncode, 0)
+        # Should show no processes
+        lines = [line for line in result.stdout.split('\n') if line.strip()]
+        self.assertLessEqual(len(lines), 2, "Empty cpuset should show no processes")
+
+
+if __name__ == '__main__':
+    unittest.main()
-- 
2.54.0

