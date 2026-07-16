Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FEF36A356
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 20:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784232578; cv=none; b=RD8ko+115ko5ixSedz6G00acwnvQZR8QlpZyBP7Mimpug7lmQ4gpqZi/RwiZJQUmrEre91zcUUUrUMcwhwsnomvmSwD9JzMJZyfH+sI6lPrI95JQ351zlXIHjOjkxb3sw207HcHoKq+FPE6GerVCWiRXKqMZRVmYdQFpz6YWuTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784232578; c=relaxed/simple;
	bh=99z7kyHSQIIrI/EsPTO9+9fH3F8nf98MnVrLq/Lm5oA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PO5NCfn2lBUpwYjYsTUK6ezCwZVkbMXDOjgDC2XdQmqz+ald9+kj5G2cb0nAB0tbpSqrbUslXi9oTq60dw6Ybs7uLjIX/0FbE0r7wU3OEiBH+6FkLuskSKtteeg+NBWYSvFB0N/kwDbHUM7F/Uw9p+0MJucSMK/tJeLtkdcxyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JV6MB/gC; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JV6MB/gC"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e7c6ec9dbso314258085a.0
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 13:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784232573; x=1784837373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8co+g+6VOz4CPK/mloMdV+PBIPvp/L4U92VgHetcVLI=;
        b=JV6MB/gCgrs6krehc4kFHzAPZf8TcytezOWhFXRfxuaMuwSQ0EnLkulxo/1CCSKuan
         M9UH7ek+icHo6JzZRHhNNhmwgPbi98o/pQggGo4dAeiMAbXx0gFByylfhLBivGKXPksU
         uwxGOfk1RHBa+IsSIE9vvAlZOyLTRKZR68cCZPDkEAj8FAQvUCHrjt6bp4ws/6GZoFQj
         Fza1lCKfCS2foIebFgVXGRCCKO86cteqRGBSNJPMwMk0hzhcK6tHgGtJNuaJkYsBv27t
         9jMFGY55chN9EIixwYrgpcpknpzRPf0MxPRYpaHAB+hQBEoxa8wa8aysvJuD+P4qrbCl
         Zf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784232573; x=1784837373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8co+g+6VOz4CPK/mloMdV+PBIPvp/L4U92VgHetcVLI=;
        b=V5wT/c4zM0fYK0sJJypd6KPMKaOdoGkwWaoeeROACAAc1Zgrn9xvnhmy/86duMUM9r
         b/SWBbjs/HesEw/iAa3mzm6NUmL/gS/KT5b4ajsgqnDIMw0j+W9cQxnHJUF+Bk39hTfv
         mV/nq5kAlshmOnT85gIx0EZBLSUdz5SS3aaQRx5LwisUOyjzTZAyAGu3WBBeC4gF/LsM
         YBmHERN3OB3IEvG7ONuMLmG1zFcAFm0+5LQyn0MYw8nyOr2/qy8cEq+dPf4GHO9CrECU
         gAFoUWCNFTPmv5K6Spj0KpVgGz8MVj+bFWOAkNyvlsAGvpzSbCmZ6ROWHrAMR19J/IVE
         B5WA==
X-Gm-Message-State: AOJu0YyOGG4P6bvfdkD9UvhsJhDe8+m0VeuT2OIs0Ept1cYccncrgZYb
	jSMi9PO0FL0Q6N/welixj2OCFJVzIn+ywlglkm0uZh0oZYCuXWlhBXQsUvHGcA==
X-Gm-Gg: AfdE7ckzbvf2vGWKIOyGrpqJ+pS7P8njnuQM98G4QWyONaH1IILzCcReVLj+VLV2X8k
	8wUGFp6qZ1NdiipPaLk5Mbp8tYWP1Eiv9hgv8Qy/TdED9wByTHyunyRbz33XLMOgOuk7FD8Jg1S
	cXLCOZZi2duEzse6K/oVKKuvk5I3GaDZSNdpfzC72vzwr0VxFhLoUoednaVQIVY8I9Bb7fEz2iV
	60iiZSGVFG8k7VB+cReXqiU7Mp/SkMdl3pjSq0SCqjDZq3odWYuna5i771QgTEX8uh/oFKJFtq5
	Py5RrzXvW61hq23vxtDDZEYV5QiBhw2FzyAo19wgbkcrCvAhAGNzYgKCSXRU+CuHW0zGqzFtac+
	501oR7Jbu47QXUNkIBst7snucToPElizxEFo3rvVYbcfCpJUH2zJwFdCqOP4DcdMuX39yOuvrMp
	E+BJrzhD02cev6A606KP4HGolgU3SIFrrqtzfD6wz4/dVq96Go/ZFGLAQ7VYaGTNIX41/L
X-Received: by 2002:a05:620a:bca:b0:92e:ea70:4f99 with SMTP id af79cd13be357-930868323d8mr1407143885a.9.1784232572986;
        Thu, 16 Jul 2026 13:09:32 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf9b7dsm2100226385a.23.2026.07.16.13.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 13:09:32 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH] rteval: Add --housekeeping-isolated flag
Date: Thu, 16 Jul 2026 16:09:15 -0400
Message-ID: <20260716200915.168400-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add optional --housekeeping-isolated flag to allow users to make the
housekeeping cpuset use partition=isolated instead of the default
partition=member. This provides strict CPU partitioning where tasks
in the housekeeping cpuset cannot be scheduled on other CPUs, which
may reduce RT latency for measurement workloads.

Changes to rteval-cmd:
- Add --housekeeping-isolated command-line argument
- Fix --housekeeping help text (removed incorrect "isolated CPUs")
- Add validation requiring both --cpusets and --housekeeping flags

Changes to rteval/cpusetmanager.py:
- Accept housekeeping_isolated parameter in __init__()
- Pass parameter to write_cpu_exclusive() during cpuset creation
- Default behavior unchanged: housekeeping uses partition=member
- Measurement cpuset always uses partition=isolated

Testing:
- Add comprehensive test suite (tests/test_cpusetmanager.py)
  - 2 non-root tests for basic functionality
  - 13 root-required tests for cpuset operations, partition types,
    CLI validation, cleanup, and task migration
- Add test-all Makefile target for running all tests with root
- Add tests/README.md documenting the test suite
- Update tests/run_tests.sh to include new tests

Usage:
  # Default: housekeeping uses partition=member
  rteval --cpusets --housekeeping 0-1 --duration 60

  # Strict partitioning: housekeeping uses partition=isolated
  rteval --cpusets --housekeeping 0-1 --housekeeping-isolated --duration 60

This matches the interface implemented in tuna for consistency.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                    |  14 +-
 rteval-cmd                  |  15 +-
 rteval/cpusetmanager.py     |   9 +-
 tests/README.md             | 322 ++++++++++++++++++++++++++++
 tests/run_tests.sh          |   5 +
 tests/test_cpusetmanager.py | 412 ++++++++++++++++++++++++++++++++++++
 6 files changed, 771 insertions(+), 6 deletions(-)
 create mode 100644 tests/README.md
 create mode 100644 tests/test_cpusetmanager.py

diff --git a/Makefile b/Makefile
index 8b540c6c68b4..57b37334136a 100644
--- a/Makefile
+++ b/Makefile
@@ -62,6 +62,17 @@ unit-tests:
 
 tests: unit-tests
 
+test-all:
+	@echo "Running ALL tests (including root-required tests)..."
+	@echo ""
+	@if [ "$$(id -u)" != "0" ]; then \
+		echo "ERROR: test-all must be run as root"; \
+		echo "Usage: sudo make test-all"; \
+		exit 1; \
+	fi
+	@echo "Running unit tests (including root-required)..."
+	$(PYTHON) -m unittest discover -s tests -p "test_*.py" -v
+
 clean:
 	rm -f *~ rteval/*~ rteval/*.py[co] *.tar.bz2 *.tar.gz doc/*~
 	rm -rf rteval-[0-9]*-[0-9]*
@@ -124,6 +135,7 @@ help:
 	@echo "        runit:            do a short testrun locally [default]"
 	@echo "        tests:            run unit tests (alias for unit-tests)"
 	@echo "        unit-tests:       run unit tests"
+	@echo "        test-all:         run ALL tests including root-required tests (requires root)"
 	@echo "        e2e-tests:        run end-to-end tests"
 	@echo "        regression-tests: run regression tests for measurement modules (requires root)"
 	@echo "        cpuset-tests:     run cpuset integration tests (requires root)"
@@ -145,4 +157,4 @@ tags:
 cleantags:
 	rm -f tags
 
-.PHONY: tests unit-tests e2e-tests regression-tests cpuset-tests uninstall
+.PHONY: tests unit-tests test-all e2e-tests regression-tests cpuset-tests uninstall
diff --git a/rteval-cmd b/rteval-cmd
index 82531e915833..69fad2cc80e4 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -122,7 +122,10 @@ def parse_options(cfg, parser, cmdargs):
                       help="use cgroup v2 cpusets to isolate measurement and housekeeping workloads")
     parser.add_argument("--housekeeping", dest="rteval___housekeeping",
                       type=str, default="", metavar="CPULIST",
-                      help="isolated CPUs reserved for system tasks (not used by rteval)")
+                      help="CPUs reserved for system tasks (not used by measurement or loads)")
+    parser.add_argument("--housekeeping-isolated", dest="rteval___housekeeping_isolated",
+                      action="store_true", default=False,
+                      help="make housekeeping cpuset use partition=isolated instead of member (requires --cpusets and --housekeeping)")
     parser.add_argument("--warn-non-isolated-core-sharing", dest="rteval___warn_non_isolated_core_sharing",
                       action="store_true", default=False,
                       help="warn about measurement and load CPUs sharing cores even when neither is isolated")
@@ -410,6 +413,13 @@ if __name__ == '__main__':
         ldcfg = config.GetSection('loads')
         msrcfg = config.GetSection('measurement')
 
+        # Validate --housekeeping-isolated usage
+        if rtevcfg.housekeeping_isolated:
+            if not rtevcfg.cpusets:
+                raise RuntimeError("--housekeeping-isolated requires --cpusets")
+            if not rtevcfg.housekeeping:
+                raise RuntimeError("--housekeeping-isolated requires --housekeeping")
+
         # Validate and process housekeeping CPUs
         housekeeping_cpus = []
         if rtevcfg.housekeeping:
@@ -560,7 +570,8 @@ if __name__ == '__main__':
             cpuset_manager = CpusetManager(
                 housekeeping_cpus=housekeeping_cpus,
                 measurement_cpus=msrcfg_cpus,
-                logger=logger
+                logger=logger,
+                housekeeping_isolated=rtevcfg.housekeeping_isolated
             )
 
         # Pass cpuset_manager to RtEval (None if not using cpusets)
diff --git a/rteval/cpusetmanager.py b/rteval/cpusetmanager.py
index abf5760db28c..a204312eda9a 100644
--- a/rteval/cpusetmanager.py
+++ b/rteval/cpusetmanager.py
@@ -71,7 +71,7 @@ class CpusetManager:
             except Exception as e:
                 logger.log(Log.WARN, f"Failed to clean up {cpuset_name}: {e}")
 
-    def __init__(self, housekeeping_cpus, measurement_cpus, logger):
+    def __init__(self, housekeeping_cpus, measurement_cpus, logger, housekeeping_isolated=False):
         """
         Initialize cpuset manager
 
@@ -79,6 +79,7 @@ class CpusetManager:
             housekeeping_cpus: List of CPU integers for housekeeping (may be empty)
             measurement_cpus: List of CPU integers for measurement workloads
             logger: rteval Log instance for logging
+            housekeeping_isolated: If True, use partition=isolated for housekeeping (default: False = partition=member)
 
         Note: Load workloads use taskset for CPU affinity and don't need cpusets.
         """
@@ -91,6 +92,7 @@ class CpusetManager:
         self.housekeeping_cpus = housekeeping_cpus
         self.measurement_cpus = measurement_cpus
         self.logger = logger
+        self.housekeeping_isolated = housekeeping_isolated
 
         # Cpuset objects (will be created in __enter__)
         self.housekeeping_cpuset = None
@@ -114,11 +116,12 @@ class CpusetManager:
 
         # Create housekeeping cpuset if requested
         if self.housekeeping_cpus:
-            self.logger.log(Log.DEBUG, f"Creating rteval_housekeeping cpuset with CPUs {collapse_cpulist(self.housekeeping_cpus)}")
+            partition_type = "isolated" if self.housekeeping_isolated else "member"
+            self.logger.log(Log.DEBUG, f"Creating rteval_housekeeping cpuset with CPUs {collapse_cpulist(self.housekeeping_cpus)} (partition={partition_type})")
             self.housekeeping_cpuset = Cpuset('rteval_housekeeping')
             self.housekeeping_cpuset.write_memnode(self.numa_nodes)
             self.housekeeping_cpuset.assign_cpus(collapse_cpulist(self.housekeeping_cpus))
-            self.housekeeping_cpuset.write_cpu_exclusive(False)  # partition=member
+            self.housekeeping_cpuset.write_cpu_exclusive(self.housekeeping_isolated)  # partition=isolated if True, member if False
 
         # Create measurement cpuset
         self.logger.log(Log.DEBUG, f"Creating rteval_measurement cpuset with CPUs {collapse_cpulist(self.measurement_cpus)}")
diff --git a/tests/README.md b/tests/README.md
new file mode 100644
index 000000000000..cac4f0e4021f
--- /dev/null
+++ b/tests/README.md
@@ -0,0 +1,322 @@
+# rteval Test Suite
+
+This directory contains the test suite for rteval, using Python's `unittest` framework.
+
+## Quick Start
+
+```bash
+# Run non-root unit tests only
+make tests
+# or
+./tests/run_tests.sh
+
+# Run ALL tests including root-required tests
+sudo make test-all
+# or
+sudo python3 -m unittest discover -s tests -p "test_*.py" -v
+
+# Run specific test module
+python3 -m unittest tests.test_cpusetmanager -v            # Non-root tests only
+sudo python3 -m unittest tests.test_cpusetmanager -v       # All tests including root
+```
+
+## Running Tests
+
+### All Non-Root Tests
+
+Run all unit tests that don't require root using the test runner:
+
+```bash
+# Using make
+make tests
+# or
+make unit-tests
+
+# Using the test runner directly
+./tests/run_tests.sh
+
+# Using Python unittest directly
+python3 -m unittest discover -s tests -p "test_*.py" -v
+```
+
+### All Tests Including Root-Required
+
+Run the complete test suite including tests that require root permissions:
+
+```bash
+# Using make (recommended)
+sudo make test-all
+
+# Using Python unittest directly
+sudo python3 -m unittest discover -s tests -p "test_*.py" -v
+```
+
+### Specific Test File
+
+Run a specific test file:
+
+```bash
+# Non-root tests
+python3 -m unittest tests.test_cpusetmanager -v
+python3 -m unittest tests.test_measurement_module_selection -v
+python3 -m unittest tests.test_core_sharing_validation -v
+
+# Root-required tests
+sudo python3 -m unittest tests.test_cpusetmanager -v
+```
+
+### Specific Test Class
+
+Run a specific test class:
+
+```bash
+# Non-root tests
+python3 -m unittest tests.test_cpusetmanager.TestCpusetManagerBasic -v
+
+# Root-required tests
+sudo python3 -m unittest tests.test_cpusetmanager.TestCpusetManagerHousekeepingPartitions -v
+```
+
+### Specific Test Method
+
+Run a single test method:
+
+```bash
+# Non-root tests
+python3 -m unittest tests.test_cpusetmanager.TestCpusetManagerBasic.test_import_cpusetmanager -v
+
+# Root-required tests
+sudo python3 -m unittest tests.test_cpusetmanager.TestCpusetManagerHousekeepingPartitions.test_housekeeping_default_partition_member -v
+```
+
+## Test Organization
+
+Tests are organized using Python's `unittest` framework. Each test file contains:
+- A test class that inherits from `unittest.TestCase`
+- Individual test methods (prefixed with `test_`)
+- Setup/teardown methods if needed
+
+### Current Tests
+
+#### Non-Root Tests
+
+- **test_measurement_module_selection.py** - Tests for measurement module selection logic
+- **test_core_sharing_validation.py** - Tests for CPU core sharing validation
+- **test_cpusetmanager.py::TestCpusetManagerBasic** (2 tests) - Basic CpusetManager functionality
+  - test_import_cpusetmanager: Verify CpusetManager can be imported
+  - test_cleanup_leftover_cpusets_callable: Verify cleanup method exists
+
+#### Root-Required Tests
+
+- **test_cpusetmanager.py** - CpusetManager functionality tests (requires root)
+  - **TestCpusetManagerHousekeepingPartitions** (4 tests) - Housekeeping partition type tests
+    - test_housekeeping_default_partition_member: Verify default partition=member
+    - test_housekeeping_isolated_flag: Verify --housekeeping-isolated makes partition=isolated
+    - test_measurement_always_isolated: Verify measurement is always partition=isolated
+    - test_no_housekeeping_cpuset_created_when_empty: Verify no housekeeping cpuset when empty
+  - **TestCpusetManagerCLIIntegration** (4 tests) - Command-line integration tests
+    - test_housekeeping_isolated_requires_cpusets: Verify validation
+    - test_housekeeping_isolated_requires_housekeeping: Verify validation
+    - test_housekeeping_isolated_help_text: Verify help text
+    - test_housekeeping_help_text_accuracy: Verify corrected help text
+  - **TestCpusetManagerCleanup** (2 tests) - Cleanup functionality tests
+    - test_cleanup_removes_leftover_cpusets: Verify cleanup removes cpusets
+    - test_cleanup_logs_when_no_cpusets: Verify graceful handling when no cpusets
+  - **TestCpusetManagerTaskMigration** (3 tests) - Task migration tests
+    - test_migrate_root_tasks_to_housekeeping: Verify root task migration
+    - test_migrate_measurement_threads: Verify measurement thread migration
+    - test_no_migration_when_no_housekeeping: Verify graceful handling
+
+### Test Requirements: Root vs Non-Root
+
+The test suite is split between tests that require root and those that don't:
+
+#### Non-Root Tests
+
+These tests run without root privileges:
+- Basic import and functionality checks
+- Logic validation tests
+- Tests using mock objects or read-only operations
+
+**Benefits:**
+- Developers can run basic tests without `sudo`
+- Tests run in CI/CD environments without elevated privileges
+- Tests are fast and don't affect the running system
+
+#### Root-Required Tests
+
+These tests require root to create/manipulate cgroups:
+- Tests that create actual cpusets in /sys/fs/cgroup
+- Tests that verify CPU assignment and partition types
+- Tests that migrate processes between cpusets
+- All tests clean up created cpusets in tearDown()
+
+**Why root is required:**
+- Creating cgroups requires write access to /sys/fs/cgroup
+- Migrating processes between cgroups requires CAP_SYS_ADMIN
+- Testing with actual cgroups ensures real-world behavior
+
+**Run without root:** Tests will be skipped with message "Requires root permissions"
+
+## Writing New Tests
+
+### Test File Structure
+
+Create a new test file following this pattern:
+
+```python
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright 2026 John Kacur <jkacur@redhat.com>
+"""
+Description of what this test module tests.
+"""
+
+import unittest
+import os
+import sys
+
+# Add parent directory to path for imports
+sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
+
+from rteval import some_module
+
+
+class TestSomething(unittest.TestCase):
+    """Test cases for something in rteval"""
+
+    @classmethod
+    def setUpClass(cls):
+        """Set up test fixtures (runs once before all tests)"""
+        # Common setup for all tests in this class
+        pass
+
+    def setUp(self):
+        """Set up for each test (runs before each test method)"""
+        # Per-test setup
+        pass
+
+    def test_something(self):
+        """Test that something works correctly"""
+        # Your test code here
+        self.assertEqual(expected, actual)
+        self.assertTrue(condition)
+        self.assertIn(item, collection)
+
+    def tearDown(self):
+        """Clean up after each test (runs after each test method)"""
+        # Per-test cleanup
+        pass
+
+
+if __name__ == '__main__':
+    unittest.main()
+```
+
+### Naming Conventions
+
+- Test files: `test_*.py` (e.g., `test_cpusetmanager.py`)
+- Test classes: `Test*` (e.g., `TestCpusetManager`)
+- Test methods: `test_*` (e.g., `test_housekeeping_isolated_flag`)
+
+### Common Assertions
+
+```python
+self.assertEqual(a, b)           # a == b
+self.assertNotEqual(a, b)        # a != b
+self.assertTrue(x)               # bool(x) is True
+self.assertFalse(x)              # bool(x) is False
+self.assertIn(a, b)              # a in b
+self.assertNotIn(a, b)           # a not in b
+self.assertIsNone(x)             # x is None
+self.assertIsNotNone(x)          # x is not None
+self.assertRaises(Exception, fn) # fn() raises Exception
+```
+
+### Adding Tests to the Test Runner
+
+After creating a new test file, add it to `tests/run_tests.sh`:
+
+```bash
+# Run test_your_feature.py
+if [ -f "tests/test_your_feature.py" ]; then
+    run_test "tests/test_your_feature.py"
+fi
+```
+
+## Requirements
+
+### All Tests
+- Python 3.6 or later
+- rteval source code
+
+### Root-Required Tests
+- Root permissions (sudo)
+- cgroup v2 support (kernel 4.5+, recommended 5.0+)
+- cgroup v2 mounted at /sys/fs/cgroup with cpuset controller enabled
+
+## Expected Output
+
+### Non-Root Tests Only
+
+Running without sudo will run only the non-root tests:
+
+```bash
+$ python3 -m unittest discover -s tests -p "test_*.py" -v
+test_cleanup_leftover_cpusets_callable (tests.test_cpusetmanager.TestCpusetManagerBasic) ... ok
+test_import_cpusetmanager (tests.test_cpusetmanager.TestCpusetManagerBasic) ... ok
+... (root-required tests skipped: "Requires root permissions")
+
+----------------------------------------------------------------------
+Ran 2 tests in 0.XXXs
+
+OK (skipped=13)
+```
+
+### All Tests Including Root-Required
+
+Running with sudo will run all tests:
+
+```bash
+$ sudo python3 -m unittest discover -s tests -p "test_*.py" -v
+... (2 non-root tests as above)
+test_housekeeping_default_partition_member (tests.test_cpusetmanager.TestCpusetManagerHousekeepingPartitions) ... ok
+test_housekeeping_isolated_flag (tests.test_cpusetmanager.TestCpusetManagerHousekeepingPartitions) ... ok
+... (all 13 root-required cpusetmanager tests)
+
+----------------------------------------------------------------------
+Ran 15 tests in X.XXXs
+
+OK
+```
+
+## Continuous Integration
+
+### Non-Root Tests (Recommended for CI)
+
+The non-root tests are designed to run in CI/CD environments:
+- Run without root privileges
+- No special system configuration required
+- Exit code 0 on success, non-zero on failure
+- Fast execution
+
+```bash
+# CI-friendly test command
+make tests
+# or
+python3 -m unittest discover -s tests -p "test_*.py" -v
+```
+
+### Root-Required Tests (Optional for CI)
+
+The root-required tests can run in CI with special setup:
+- Requires root access or privileged containers
+- Requires cgroup v2 support
+- May need dedicated test runners with appropriate permissions
+
+```bash
+# Full test suite (requires root)
+sudo make test-all
+# or
+sudo python3 -m unittest discover -s tests -p "test_*.py" -v
+```
diff --git a/tests/run_tests.sh b/tests/run_tests.sh
index 5ac4e7bf2ff3..d61616070cec 100755
--- a/tests/run_tests.sh
+++ b/tests/run_tests.sh
@@ -62,6 +62,11 @@ if [ -d "tests" ]; then
         run_test "tests/test_core_sharing_validation.py"
     fi
 
+    # Run test_cpusetmanager.py (non-root tests only)
+    if [ -f "tests/test_cpusetmanager.py" ]; then
+        run_test "tests/test_cpusetmanager.py"
+    fi
+
     # Add more tests here as they are created
     # Example:
     # if [ -f "tests/test_another_feature.py" ]; then
diff --git a/tests/test_cpusetmanager.py b/tests/test_cpusetmanager.py
new file mode 100644
index 000000000000..6501b9a022d4
--- /dev/null
+++ b/tests/test_cpusetmanager.py
@@ -0,0 +1,412 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright 2026 John Kacur <jkacur@redhat.com>
+"""
+Unit tests for rteval CpusetManager functionality.
+
+Tests verify cpuset creation, partition types, task migration, and the
+--housekeeping-isolated flag functionality.
+"""
+
+import unittest
+import os
+import sys
+import subprocess
+import tempfile
+
+# Add parent directory to path for imports
+sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
+
+from rteval.cpusetmanager import CpusetManager
+from rteval import cpuset
+from rteval.Log import Log
+
+
+class TestCpusetManagerBasic(unittest.TestCase):
+    """Test basic CpusetManager functionality (non-root tests)"""
+
+    def test_import_cpusetmanager(self):
+        """Test that CpusetManager can be imported"""
+        self.assertIsNotNone(CpusetManager)
+
+    def test_cleanup_leftover_cpusets_callable(self):
+        """Test that cleanup_leftover_cpusets method exists"""
+        self.assertTrue(hasattr(CpusetManager, 'cleanup_leftover_cpusets'))
+        self.assertTrue(callable(CpusetManager.cleanup_leftover_cpusets))
+
+
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestCpusetManagerHousekeepingPartitions(unittest.TestCase):
+    """Test housekeeping cpuset partition type behavior"""
+
+    def setUp(self):
+        """Clean up before each test"""
+        self.logger = Log()
+        self.logger.SetLogVerbosity(Log.ERR | Log.WARN)
+        try:
+            cpuset.cleanup_cpusets('rteval_*', force=True, recursive=False)
+        except:
+            pass
+
+    def tearDown(self):
+        """Clean up after each test"""
+        try:
+            cpuset.cleanup_cpusets('rteval_*', force=True, recursive=False)
+        except:
+            pass
+
+    def test_housekeeping_default_partition_member(self):
+        """Test that housekeeping cpuset defaults to partition=member"""
+        with CpusetManager(
+            housekeeping_cpus=[0, 1],
+            measurement_cpus=[2, 3],
+            logger=self.logger,
+            housekeeping_isolated=False
+        ) as manager:
+            # Check housekeeping partition type
+            hk_partition_file = '/sys/fs/cgroup/rteval_housekeeping/cpuset.cpus.partition'
+            with open(hk_partition_file) as f:
+                partition = f.read().strip()
+            self.assertEqual(partition, 'member',
+                           "Housekeeping cpuset should have partition=member by default")
+
+    def test_housekeeping_isolated_flag(self):
+        """Test that housekeeping_isolated=True makes partition=isolated"""
+        with CpusetManager(
+            housekeeping_cpus=[0, 1],
+            measurement_cpus=[2, 3],
+            logger=self.logger,
+            housekeeping_isolated=True
+        ) as manager:
+            # Check housekeeping partition type
+            hk_partition_file = '/sys/fs/cgroup/rteval_housekeeping/cpuset.cpus.partition'
+            with open(hk_partition_file) as f:
+                partition = f.read().strip()
+            self.assertEqual(partition, 'isolated',
+                           "Housekeeping cpuset should have partition=isolated when flag is True")
+
+    def test_measurement_always_isolated(self):
+        """Test that measurement cpuset is always partition=isolated"""
+        # Test with housekeeping_isolated=False
+        with CpusetManager(
+            housekeeping_cpus=[0, 1],
+            measurement_cpus=[2, 3],
+            logger=self.logger,
+            housekeeping_isolated=False
+        ) as manager:
+            measurement_partition_file = '/sys/fs/cgroup/rteval_measurement/cpuset.cpus.partition'
+            with open(measurement_partition_file) as f:
+                partition = f.read().strip()
+            self.assertEqual(partition, 'isolated',
+                           "Measurement cpuset should always be partition=isolated")
+
+        # Test with housekeeping_isolated=True
+        with CpusetManager(
+            housekeeping_cpus=[0, 1],
+            measurement_cpus=[2, 3],
+            logger=self.logger,
+            housekeeping_isolated=True
+        ) as manager:
+            measurement_partition_file = '/sys/fs/cgroup/rteval_measurement/cpuset.cpus.partition'
+            with open(measurement_partition_file) as f:
+                partition = f.read().strip()
+            self.assertEqual(partition, 'isolated',
+                           "Measurement cpuset should always be partition=isolated")
+
+    def test_no_housekeeping_cpuset_created_when_empty(self):
+        """Test that housekeeping cpuset is not created when housekeeping_cpus is empty"""
+        with CpusetManager(
+            housekeeping_cpus=[],
+            measurement_cpus=[0, 1],
+            logger=self.logger,
+            housekeeping_isolated=False
+        ) as manager:
+            # Check that housekeeping cpuset does NOT exist
+            hk_path = '/sys/fs/cgroup/rteval_housekeeping'
+            self.assertFalse(os.path.exists(hk_path),
+                           "Housekeeping cpuset should not exist when housekeeping_cpus is empty")
+
+            # Check that measurement cpuset DOES exist
+            measurement_path = '/sys/fs/cgroup/rteval_measurement'
+            self.assertTrue(os.path.exists(measurement_path),
+                          "Measurement cpuset should exist")
+
+
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestCpusetManagerCLIIntegration(unittest.TestCase):
+    """Test rteval-cmd integration with --housekeeping-isolated"""
+
+    def setUp(self):
+        """Clean up before each test"""
+        try:
+            cpuset.cleanup_cpusets('rteval_*', force=True, recursive=False)
+        except:
+            pass
+
+    def tearDown(self):
+        """Clean up after each test"""
+        try:
+            cpuset.cleanup_cpusets('rteval_*', force=True, recursive=False)
+        except:
+            pass
+
+    def test_housekeeping_isolated_requires_cpusets(self):
+        """Test that --housekeeping-isolated requires --cpusets"""
+        result = subprocess.run(
+            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd',
+             '--housekeeping', '0-1', '--housekeeping-isolated',
+             '--duration', '1', '--onlyload'],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertNotEqual(result.returncode, 0,
+                          "--housekeeping-isolated without --cpusets should fail")
+        self.assertIn('requires --cpusets', result.stderr,
+                     "Error message should mention --cpusets requirement")
+
+    def test_housekeeping_isolated_requires_housekeeping(self):
+        """Test that --housekeeping-isolated requires --housekeeping"""
+        result = subprocess.run(
+            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd',
+             '--cpusets', '--housekeeping-isolated',
+             '--duration', '1', '--onlyload'],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertNotEqual(result.returncode, 0,
+                          "--housekeeping-isolated without --housekeeping should fail")
+        self.assertIn('requires --housekeeping', result.stderr,
+                     "Error message should mention --housekeeping requirement")
+
+    def test_housekeeping_isolated_help_text(self):
+        """Test that --housekeeping-isolated appears in help"""
+        result = subprocess.run(
+            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd', '--help'],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertEqual(result.returncode, 0)
+        self.assertIn('--housekeeping-isolated', result.stdout,
+                     "--housekeeping-isolated should appear in help")
+        self.assertIn('partition=isolated', result.stdout,
+                     "Help should mention partition=isolated")
+
+    def test_housekeeping_help_text_accuracy(self):
+        """Test that --housekeeping help text is accurate (no longer says 'isolated CPUs')"""
+        result = subprocess.run(
+            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd', '--help'],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertEqual(result.returncode, 0)
+        # Find the --housekeeping help text
+        lines = result.stdout.split('\n')
+        housekeeping_help = None
+        for i, line in enumerate(lines):
+            if '--housekeeping' in line and '--housekeeping-isolated' not in line:
+                # Get this line and potentially the next line (help text may wrap)
+                housekeeping_help = line
+                if i + 1 < len(lines):
+                    housekeeping_help += ' ' + lines[i + 1]
+                break
+
+        self.assertIsNotNone(housekeeping_help, "--housekeeping should be in help")
+        # Should NOT say "isolated CPUs"
+        self.assertNotIn('isolated CPUs', housekeeping_help,
+                        "--housekeeping help should not incorrectly say 'isolated CPUs'")
+        # Should say something about system tasks
+        self.assertIn('system tasks', housekeeping_help,
+                     "--housekeeping help should mention system tasks")
+
+
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestCpusetManagerCleanup(unittest.TestCase):
+    """Test cleanup_leftover_cpusets functionality"""
+
+    def setUp(self):
+        """Clean up before each test"""
+        self.logger = Log()
+        self.logger.SetLogVerbosity(Log.ERR | Log.WARN)
+        try:
+            cpuset.cleanup_cpusets('rteval_*', force=True, recursive=False)
+        except:
+            pass
+
+    def tearDown(self):
+        """Clean up after each test"""
+        try:
+            cpuset.cleanup_cpusets('rteval_*', force=True, recursive=False)
+        except:
+            pass
+
+    def test_cleanup_removes_leftover_cpusets(self):
+        """Test that cleanup removes leftover rteval cpusets"""
+        # Create some leftover cpusets
+        cs1 = cpuset.Cpuset('rteval_test1')
+        cs1.write_memnode('0')
+        cs1.assign_cpus('0')
+
+        cs2 = cpuset.Cpuset('rteval_test2')
+        cs2.write_memnode('0')
+        cs2.assign_cpus('1')
+
+        # Verify they exist
+        self.assertTrue(os.path.exists('/sys/fs/cgroup/rteval_test1'))
+        self.assertTrue(os.path.exists('/sys/fs/cgroup/rteval_test2'))
+
+        # Run cleanup
+        CpusetManager.cleanup_leftover_cpusets(self.logger)
+
+        # Verify they're gone
+        self.assertFalse(os.path.exists('/sys/fs/cgroup/rteval_test1'),
+                        "cleanup should remove rteval_test1")
+        self.assertFalse(os.path.exists('/sys/fs/cgroup/rteval_test2'),
+                        "cleanup should remove rteval_test2")
+
+    def test_cleanup_logs_when_no_cpusets(self):
+        """Test that cleanup handles no leftover cpusets gracefully"""
+        # Make sure no rteval cpusets exist
+        try:
+            cpuset.cleanup_cpusets('rteval_*', force=True, recursive=False)
+        except:
+            pass
+
+        # This should not raise an exception
+        try:
+            CpusetManager.cleanup_leftover_cpusets(self.logger)
+        except Exception as e:
+            self.fail(f"cleanup_leftover_cpusets raised exception: {e}")
+
+
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestCpusetManagerTaskMigration(unittest.TestCase):
+    """Test task migration functionality"""
+
+    def setUp(self):
+        """Clean up before each test"""
+        self.logger = Log()
+        self.logger.SetLogVerbosity(Log.ERR | Log.WARN)
+        try:
+            cpuset.cleanup_cpusets('rteval_*', force=True, recursive=False)
+        except:
+            pass
+
+    def tearDown(self):
+        """Clean up after each test and move current process back to root"""
+        # Move current process back to root
+        try:
+            ci = cpuset.CpusetsInit()
+            ci.write_pid(os.getpid())
+        except:
+            pass
+
+        # Clean up cpusets
+        try:
+            cpuset.cleanup_cpusets('rteval_*', force=True, recursive=False)
+        except:
+            pass
+
+    def test_migrate_root_tasks_to_housekeeping(self):
+        """Test migrating root tasks to housekeeping cpuset"""
+        with CpusetManager(
+            housekeeping_cpus=[0, 1],
+            measurement_cpus=[2, 3],
+            logger=self.logger,
+            housekeeping_isolated=False
+        ) as manager:
+            # Migrate root tasks
+            manager.migrate_root_tasks_to_housekeeping()
+
+            # Verify some tasks were migrated
+            with open('/sys/fs/cgroup/rteval_housekeeping/cgroup.procs') as f:
+                tasks = f.read().strip().split('\n')
+                tasks = [t for t in tasks if t]  # Filter empty strings
+
+            self.assertGreater(len(tasks), 0,
+                             "Should have migrated some tasks to housekeeping")
+
+    def test_migrate_measurement_threads(self):
+        """Test migrating measurement threads to measurement cpuset"""
+        with CpusetManager(
+            housekeeping_cpus=[0, 1],
+            measurement_cpus=[2, 3],
+            logger=self.logger,
+            housekeeping_isolated=False
+        ) as manager:
+            # Use current process as a test measurement thread
+            current_pid = os.getpid()
+
+            # Migrate
+            manager.migrate_measurement_threads([current_pid])
+
+            # Verify PID is in measurement cpuset
+            with open('/sys/fs/cgroup/rteval_measurement/cgroup.procs') as f:
+                tasks = f.read().strip().split('\n')
+
+            self.assertIn(str(current_pid), tasks,
+                         "Current PID should be in measurement cpuset")
+
+    def test_no_migration_when_no_housekeeping(self):
+        """Test that root task migration is skipped when no housekeeping cpuset"""
+        with CpusetManager(
+            housekeeping_cpus=[],
+            measurement_cpus=[0, 1],
+            logger=self.logger,
+            housekeeping_isolated=False
+        ) as manager:
+            # This should not raise an exception
+            try:
+                manager.migrate_root_tasks_to_housekeeping()
+            except Exception as e:
+                self.fail(f"migrate_root_tasks_to_housekeeping raised exception: {e}")
+
+
+def suite():
+    """Create test suite"""
+    loader = unittest.TestLoader()
+    suite = unittest.TestSuite()
+
+    # Add all test classes
+    suite.addTests(loader.loadTestsFromTestCase(TestCpusetManagerBasic))
+    suite.addTests(loader.loadTestsFromTestCase(TestCpusetManagerHousekeepingPartitions))
+    suite.addTests(loader.loadTestsFromTestCase(TestCpusetManagerCLIIntegration))
+    suite.addTests(loader.loadTestsFromTestCase(TestCpusetManagerCleanup))
+    suite.addTests(loader.loadTestsFromTestCase(TestCpusetManagerTaskMigration))
+
+    return suite
+
+
+if __name__ == '__main__':
+    # Check if running as root
+    if os.geteuid() != 0:
+        print("\n" + "="*60)
+        print("WARNING: Not running as root")
+        print("="*60)
+        print("Most tests require root permissions.")
+        print("\nTo run tests:")
+        print("  sudo python3 -m unittest tests.test_cpusetmanager -v")
+        print("="*60 + "\n")
+
+    # Check cgroup v2 support
+    ci = cpuset.CpusetsInit()
+    if not ci.supported:
+        print("\n" + "="*60)
+        print("WARNING: cgroup v2 not supported")
+        print("="*60)
+        print("Most tests require cgroup v2 support.")
+        print("="*60 + "\n")
+
+    # Run tests
+    runner = unittest.TextTestRunner(verbosity=2)
+    result = runner.run(suite())
+
+    # Exit with appropriate code
+    sys.exit(0 if result.wasSuccessful() else 1)
-- 
2.55.0

