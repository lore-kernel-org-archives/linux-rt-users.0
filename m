Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF933368A5
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692966; cv=none; b=iRmxh76Z8K6pKWsNNAmwuawX9YESofb9yadg+k4gxpErT7+W0lVepO6vxMa2TP6wDxecaGCYBbVD+4baXwAttYk3etfb/vG/unsT62NkYbVAgInz5uHKL5UkQgn9pvqxJ8jdF6LLtp1mK+C9P9C+nAt4Nf/HgcF8oezp25W0Blc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692966; c=relaxed/simple;
	bh=j+cVN0Lc9EC9X93zOqKNHGgQ3aoSsgwZjPRHvMQVH6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUJInN8+Kz+9+thTqsJCeJF7Ft6hHuCY7NO2mXHFvGSpt61pqeaicUFBsrktQpcfEDe0Q41bifc7+1R9wVgW5nvy4n6+NHWc9WBdLuluiEVm61NP4HeT/uzOb/IAQtQm1JjkAee+fNjvmmR2ZWlabBLQ6vww5Cj7fc3kptUXXgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVdoolcq; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVdoolcq"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-738bd0b7960so792181137.0
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692964; x=1784297764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=75P8ZQOxxARDCoDLvnhDgBFuDQcT8c8pVC+UannhMgM=;
        b=SVdoolcqlaNQW49noB0gBztwn5RdTna49lna3U4EMmKfgoWmRE13Y1BicaPr8fLFWU
         pQx7XJqRmgs25KvqKhhnYaL0W6bUu4/SHh7uulsQqo2B0rL/SdU/jb3VHJdyH7i7TYzR
         VIYG2KLTLy26pOIQuR0jD/9qgblizGWDdMOqPMDCJ8HzmQA225gtBHLFhMSkGHw1g2rH
         zkqGd44lNfFfx23FkN957dgGKxQa/Yg2tmI+urQoyVVQE90h/a2lLnb81FtY2ysSPNPw
         TqmmvqqQb8CeKS6sZwHtCP+oE0mj5pVveUkn4eb7hXeOTi+Jjb1yt4JaUensK7UmyAXg
         S5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692964; x=1784297764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75P8ZQOxxARDCoDLvnhDgBFuDQcT8c8pVC+UannhMgM=;
        b=rbhRMVHkpkWq3JZBr5jkYDAT+c3vZnb6ma1BR3sNRJPjlQOSdRjjD3uukjLTnOdbdp
         r8kqCvYbR0IiLwP+kZInG3rc59FpxwtwDSUvS8CZpseWc/UaRafF0O3hHGreZFmy8hYd
         oHBvM0YZ68rRRxZ2WC9oZNnklxZTxfg7lrcwVQ9iWEtBd8ypdlTny3HjH4Qi834kzBXP
         vENwc6jBpiT5eLf3roEFA+AzI5vlJqRw3Sx5Ks2qaaBs0Ze8+jWVq3kTAgTCuk1FK/Ul
         VrlbQSpYMHYSnhpiiXEDLKd2qYdsT53h6G//QfvDFOKgIo/v/fJHOe8jK6o8PzGyRV54
         bq7A==
X-Gm-Message-State: AOJu0Yy4iLBnw8E36JLWoHwex4BgCUe1/QJfk4Ve8fbyYdXRWZDTF5iJ
	oUFNMPy5UoCXOjNekL1eJSaRLVx72CDkSsu2y+i8+Ws/L9Fx064kqdVsNHHI6Q==
X-Gm-Gg: AfdE7ck8y2o8KLO0BYxI8T2OvwEs6Q7XFt/h0GXOdR8+4xhWA1SlkjoALeO3yd8DEVE
	fR8ZgkDlbrrvYUDR8xBnzWhvWn+vviYFs4yEa4uWIDXnJCvjNwIA/xacaGbjzWVjilMvzOGeXqS
	16M3J78hWatpdzHrM7Eq5P1vsZYCPCettcBP9zs55s8zi9UqTk/2pCLoGt63nb62d8ke0ebP1Mc
	QTRCt0/7TDpNxY/9LlkWdg1DG1Eh44xv9UqiDX5KmEYpkBO4zNEI2tE4DfoP7eMN/hrjEwhlPJT
	E9laws6bCIYfBPGT+ma3Z2miA41c21uGPwbVjMyTcpC1XvTiutAaskLgriWEGSIYQj16SQyI6IX
	yzmTwDbKx/H0aJVfbhyjt/RYhOcAO5RSOTdHE4UfocRoJlL0biVUZx3ZI4PCsbZwnJkc+WAyvt2
	jF8jaeF3T83qo8h2zJlK2qb9D0AMEuUKvzm9LHZ43bJ4EzdGlCENz9GKU5tLhO3mlLbPswRV0j5
	A==
X-Received: by 2002:a05:6102:3e25:b0:727:48aa:f604 with SMTP id ada2fe7eead31-744e03deac9mr6832233137.28.1783692963013;
        Fri, 10 Jul 2026 07:16:03 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:02 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 11/36] tuna: Add comprehensive test targets and documentation
Date: Fri, 10 Jul 2026 10:14:49 -0400
Message-ID: <20260710141523.36440-12-jkacur@redhat.com>
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

Add make targets for running different test suites:
- test-eperm: Run EPERM handling tests (non-root)
- test-converters: Run converter function tests (non-root)
- test-cpuset: Run cpuset module tests (root-required)
- test-cpuset-cli: Run cpuset CLI tests (root-required)
- test-all: Run all 57 tests (handles sudo automatically)

All test targets properly declared as .PHONY to prevent conflicts
with files. The Makefile handles sudo internally so users can simply
run 'make test-all' to execute the full test suite.

Update tests/README.md with comprehensive documentation:
- Add SPDX license identifier and copyright
- Quick start guide with common test commands
- Detailed breakdown of all 57 tests (23 non-root + 34 root-required)
- Root vs non-root test requirements explanation
- Expected output examples for both test modes
- CI/CD integration guidance
- Writing new tests guidelines

The test suite is split between non-root tests (23 tests: 6 EPERM
handling, 12 converters, 5 CpusetsInit) that can run in CI/CD
environments without privileges, and root-required tests (34 tests:
22 cpuset module, 12 cpuset CLI) that create actual cgroups and
require CAP_SYS_ADMIN.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile        |  13 ++-
 tests/README.md | 213 ++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 198 insertions(+), 28 deletions(-)

diff --git a/Makefile b/Makefile
index f331f4715d1c..e2e2cbbf9d51 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ cleanlogs:
 .PHONY: clean
 clean: pyclean
 
-.PHONY: tests unit-tests
+.PHONY: tests unit-tests test-eperm test-converters test-cpuset test-cpuset-cli test-all
 tests: unit-tests
 
 unit-tests:
@@ -29,3 +29,14 @@ unit-tests:
 
 test-eperm:
 	@python3 -m unittest tests.test_eperm_handling -v
+
+test-converters:
+	@python3 -m unittest tests.test_converters -v
+
+test-cpuset:
+	@sudo python3 -m unittest tests.test_cpuset -v
+
+test-cpuset-cli:
+	@sudo python3 -m unittest tests.test_cpuset_cli -v
+
+test-all: test-eperm test-converters test-cpuset test-cpuset-cli
diff --git a/tests/README.md b/tests/README.md
index 9f85e6fe97c2..7f3e53c2c601 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -1,7 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+# Copyright (C) 2026 John Kacur
+
 # Tuna Test Suite
 
 This directory contains the test suite for tuna, using Python's `unittest` framework.
 
+## Quick Start
+
+```bash
+# Run all non-root tests only (23 tests, some cpuset tests skipped)
+make tests
+
+# Run ALL tests (all 57 tests, requires sudo for root-required tests)
+make test-all
+
+# Run specific test module
+make test-converters       # Non-root
+make test-cpuset          # Root-required
+make test-cpuset-cli      # Root-required
+
+# Or use Python unittest directly
+python3 -m unittest tests.test_converters -v
+sudo python3 -m unittest tests.test_cpuset -v
+```
+
 ## Running Tests
 
 ### All Tests
@@ -9,16 +32,22 @@ This directory contains the test suite for tuna, using Python's `unittest` frame
 Run all unit tests using any of these methods:
 
 ```bash
-# Using make (recommended)
+# Using make (non-root tests only, 23 tests)
 make tests
 # or
 make unit-tests
 
-# Using the test runner directly
+# Using make (ALL tests including root-required tests, 57 tests)
+make test-all
+
+# Using the test runner directly (non-root tests only)
 ./tests/run_tests.sh
 
-# Using Python unittest directly
+# Using Python unittest directly (non-root tests only)
 python3 -m unittest discover -s tests -p "test_*.py" -v
+
+# Using Python unittest directly (ALL tests including root-required)
+sudo python3 -m unittest discover -s tests -p "test_*.py" -v
 ```
 
 ### Specific Test File
@@ -26,11 +55,19 @@ python3 -m unittest discover -s tests -p "test_*.py" -v
 Run a specific test file:
 
 ```bash
-# Using make
+# Using make (non-root tests)
 make test-eperm
+make test-converters
+
+# Using make (root-required tests)
+make test-cpuset
+make test-cpuset-cli
 
-# Using Python unittest
+# Or using Python unittest directly
 python3 -m unittest tests.test_eperm_handling -v
+python3 -m unittest tests.test_converters -v
+sudo python3 -m unittest tests.test_cpuset -v
+sudo python3 -m unittest tests.test_cpuset_cli -v
 ```
 
 ### Specific Test Class
@@ -38,8 +75,13 @@ python3 -m unittest tests.test_eperm_handling -v
 Run a specific test class:
 
 ```bash
+# Non-root tests
 python3 -m unittest tests.test_converters.TestThreadstringToList -v
 python3 -m unittest tests.test_converters.TestIrqstringToList -v
+
+# Root-required tests
+sudo python3 -m unittest tests.test_cpuset.TestCpusetCreation -v
+sudo python3 -m unittest tests.test_cpuset_cli.TestCpusetCreateCLI -v
 ```
 
 ### Specific Test Method
@@ -47,8 +89,13 @@ python3 -m unittest tests.test_converters.TestIrqstringToList -v
 Run a single test method:
 
 ```bash
+# Non-root tests
 python3 -m unittest tests.test_eperm_handling.TestEPERMHandling.test_set_affinity_eperm -v
 python3 -m unittest tests.test_converters.TestThreadstringToList.test_pattern_with_mock_ps -v
+
+# Root-required tests
+sudo python3 -m unittest tests.test_cpuset.TestCpusetCreation.test_create_cpuset -v
+sudo python3 -m unittest tests.test_cpuset_cli.TestCpusetCreateCLI.test_create_with_auto_naming -v
 ```
 
 ## Test Organization
@@ -60,26 +107,56 @@ Tests are organized using Python's `unittest` framework. Each test file contains
 
 ### Current Tests
 
+#### Non-Root Tests (23 tests)
+
 - **test_eperm_handling.py** (6 tests) - Tests for EPERM error handling
   - Verifies that Permission Denied errors are handled gracefully
   - Tests reading and setting affinity, scheduler, and priority on PID 1
   - Ensures tuna handles permission errors without crashing
+  - Run: `python3 -m unittest tests.test_eperm_handling -v`
 
 - **test_converters.py** (12 tests) - Tests for argument converter functions
   - Tests `threadstring_to_list()`: Converting thread specifications to PID lists
   - Tests `irqstring_to_list()`: Converting IRQ specifications to IRQ number lists
   - Tests `socketstring_to_list()`: Socket string conversion
   - Uses MockPidStats to test without requiring real process access
+  - Run: `python3 -m unittest tests.test_converters -v`
+
+- **test_cpuset.py::TestCpusetsInit** (5 tests) - CpusetsInit and cgroup v2 detection
+  - Tests initialization and cgroup v2 support detection
+  - Verifies cpuset path configuration
+  - Tests NUMA node detection
+  - These tests can run without root as they only check system capabilities
+  - Run: `python3 -m unittest tests.test_cpuset.TestCpusetsInit -v`
+
+#### Root-Required Tests (34 tests)
+
+- **test_cpuset.py** (22 tests) - Core cpuset module tests
+  - TestCpusetCreation: Creating and destroying cpusets
+  - TestCpusetConfiguration: CPU/memory assignment
+  - TestContextManager: auto_destroy behavior with context managers
+  - TestTaskMigration: Process migration between cpusets
+  - TestDiscoveryFunctions: list_cpusets() with patterns and recursion
+  - TestCleanupFunctions: destroy_cpuset() and cleanup_cpusets()
+  - Note: TestCpusetsInit (5 tests) runs without root, see non-root section
+  - Run: `sudo python3 -m unittest tests.test_cpuset -v` (runs all 27 tests with root)
+
+- **test_cpuset_cli.py** (12 tests) - CLI command tests
+  - TestGetNextTunaCpusetName: Auto-naming logic (tuna0, tuna1, gap-filling)
+  - TestCpusetCreateCLI: Create command with auto/custom names and --isolated
+  - TestCpusetListCLI: List command with --pattern, --verbose, --skip-empty
+  - TestCpusetDestroyCLI: Destroy command with patterns and safety options
+  - Run: `sudo python3 -m unittest tests.test_cpuset_cli -v`
+
+**Total: 57 tests** (23 non-root + 34 root-required)
 
-### Why Tests Don't Require Root
+### Test Requirements: Root vs Non-Root
 
-The tuna program requires root privileges for operations like:
-- Setting CPU affinity on other processes
-- Changing scheduler policies and priorities
-- Moving IRQs to different CPUs
-- Isolating CPUs (system-wide CPU management)
+The test suite is split between tests that require root and those that don't:
 
-However, the tests are designed to run without root privileges:
+#### Non-Root Tests (23 tests)
+
+These tests run without root privileges:
 
 1. **EPERM tests** verify that permission errors are handled gracefully when running as non-root
    - They intentionally trigger permission errors by trying to modify PID 1
@@ -90,12 +167,40 @@ However, the tests are designed to run without root privileges:
    - MockPidStats provides test data without accessing /proc
    - No actual process manipulation occurs
 
+3. **CpusetsInit tests** verify system capability detection
+   - Test cgroup v2 detection logic
+   - Check NUMA node configuration
+   - Read-only operations that don't require root
+
 **Benefits:**
-- Developers can run tests without `sudo`
+- Developers can run basic tests without `sudo`
 - Tests run in CI/CD environments without elevated privileges
 - Tests are fast and don't affect the running system
 - Tests verify both happy path (with mocks) and error path (with real EPERM)
 
+#### Root-Required Tests (34 tests)
+
+These tests require root to create/manipulate cgroups:
+
+1. **Cpuset module tests** (22 tests) create actual cgroups in /sys/fs/cgroup
+   - Test real cgroup v2 operations
+   - Verify CPU assignment, memory node configuration
+   - Test task migration between cpusets
+   - All tests clean up created cpusets in tearDown()
+
+2. **Cpuset CLI tests** (12 tests) test command-line interface functions
+   - Test cpuset create/list/destroy commands
+   - Verify auto-naming logic (tuna0, tuna1, etc.)
+   - Test pattern matching and safety features
+   - All tests clean up created cpusets afterwards
+
+**Why root is required:**
+- Creating cgroups requires write access to /sys/fs/cgroup
+- Migrating processes between cgroups requires CAP_SYS_ADMIN
+- Testing with actual cgroups ensures real-world behavior
+
+**Run without root:** Tests will be skipped with message "Requires root permissions"
+
 ## Writing New Tests
 
 ### Test File Structure
@@ -166,17 +271,24 @@ self.assertRaises(Exception, fn) # fn() raises Exception
 
 ## Requirements
 
+### All Tests
 - Python 3.6 or later
 - python3-procfs package (for importing procfs module used by converters)
 - No other external packages required (uses Python standard library and mocks)
 
+### Root-Required Tests (cpuset tests only)
+- Root permissions (sudo)
+- cgroup v2 support (kernel 4.5+, recommended 5.0+)
+- cgroup v2 mounted at /sys/fs/cgroup with cpuset controller enabled
+
 ## Expected Output
 
-A successful test run with all 18 tests should look like:
+### Non-Root Tests Only (23 tests)
 
-```
-Running tuna unit tests...
+Running without sudo will run only the non-root tests:
 
+```bash
+$ python3 -m unittest discover -s tests -p "test_*.py" -v
 test_get_affinity_eperm (test_eperm_handling.TestEPERMHandling) ... ok
 test_get_priority_eperm (test_eperm_handling.TestEPERMHandling) ... ok
 test_get_scheduler_eperm (test_eperm_handling.TestEPERMHandling) ... ok
@@ -195,30 +307,77 @@ test_mixed_numeric_and_pattern (test_converters.TestThreadstringToList) ... ok
 test_multiple_numeric_pids (test_converters.TestThreadstringToList) ... ok
 test_pattern_with_mock_ps (test_converters.TestThreadstringToList) ... ok
 test_single_numeric_pid (test_converters.TestThreadstringToList) ... ok
+... (most cpuset tests skipped: "Requires root permissions")
 
 ----------------------------------------------------------------------
-Ran 18 tests in 0.XXXs
+Ran 23 tests in 0.XXXs
 
-OK
+OK (skipped=34)
+```
+
+### All Tests Including Root-Required (57 tests)
+
+Running with sudo will run all 57 tests:
+
+```bash
+$ sudo python3 -m unittest discover -s tests -p "test_*.py" -v
+... (18 non-root tests as above)
+test_initialization (test_cpuset.TestCpusetsInit) ... ok
+test_cpuset_path (test_cpuset.TestCpusetsInit) ... ok
+... (27 cpuset module tests)
+test_first_name_is_tuna0 (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
+test_sequential_naming (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
+... (12 cpuset CLI tests)
+
+----------------------------------------------------------------------
+Ran 57 tests in X.XXXs
 
-All tests passed!
+OK
 ```
 
 ## Test Types
 
-Currently all tests are **unit tests** that verify code behavior without requiring:
-- Root privileges
-- Special system configuration
-- External dependencies
+The test suite includes:
+
+### Unit Tests (23 tests - no root required)
+- **Converter tests**: Pure logic testing with mocks
+- **EPERM tests**: Error handling verification
+- **CpusetsInit tests**: System capability detection (read-only)
+
+### Integration Tests (34 tests - require root)
+- **Cpuset module tests**: Test interaction with cgroup v2 subsystem
+- **Cpuset CLI tests**: Test command-line interface integration
 
 Future test categories might include:
-- **Integration tests** - Test interaction between tuna components
-- **System tests** - Tests requiring actual CPU affinity operations (need root)
+- **System tests** - Full end-to-end tests requiring CPU affinity operations
 - **Regression tests** - Tests for specific bug fixes
+- **Performance tests** - Benchmarking cpuset operations
 
 ## Continuous Integration
 
-The test suite is designed to run in CI/CD environments:
-- All tests run without root privileges
+### Non-Root Tests (Recommended for CI)
+
+The non-root tests (23 tests) are designed to run in CI/CD environments:
+- Run without root privileges
 - No special system configuration required
 - Exit code 0 on success, non-zero on failure
+- Fast execution (< 1 second)
+- Includes basic cpuset capability detection tests
+
+```bash
+# CI-friendly test command
+python3 -m unittest discover -s tests -p "test_*.py" -v
+```
+
+### Root-Required Tests (Optional for CI)
+
+The cpuset tests (34 tests) can run in CI with special setup:
+- Requires root access or privileged containers
+- Requires cgroup v2 support
+- May need dedicated test runners with appropriate permissions
+- Slightly slower execution due to actual cgroup operations
+
+```bash
+# Full test suite (requires root)
+sudo python3 -m unittest discover -s tests -p "test_*.py" -v
+```
-- 
2.54.0

