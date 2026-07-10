Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C2133FE26
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692986; cv=none; b=fncRTrqkyDbj5mM2Rzz2UQfBh4nRR1PvmBFydPg7IT2ARLI5R7P6bMI7SZJDcS+iebPmxBAqbIOzbwgvdZHjGWwamnE3RL4njkpO6zgo8r4H3YSJH3PPxmTnQnF9rO/n9BQf0FtnUn4rbIPImefDNb17h2ivgBToO1yWMKNjB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692986; c=relaxed/simple;
	bh=jo/1hs3D0kAcYPtFH/9zBZjaAvJNd8z2dY058qMjxP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhtrIMdwBJ/eU4dAG5ke2ILVTncadN6Pef3q+xVhmMelOIdZYy7bjlJ1DlbUbdHGM7dq8Kqc7I9myyi+VdC3eTUwdd/5UTzEyLY6Dlspg3bzUAV6vgOsoq0pIZxg5FYFTkpdFtA6voBYsL4yxVQ31PBA0Dw7iRJ8h5r2Xbu1F6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lp2orql1; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp2orql1"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-736eea06c3eso332448137.0
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692984; x=1784297784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0qRC/No1g8PcEQDcU52wP9duNRsn2jNfKKht3BgheYY=;
        b=Lp2orql16HfHIwDLCV91xFUHEbdXifYxMIg9ixFIlAgpLTQaO5mOZDWULWPZYTtlD1
         5AgWGsb4mbw1kcmpixUCwqdxVNJ+ROLu+SPksbVVrn53G7RPXXCUS1Hz6sNYPBR/K33C
         7DSlan36B1G1mqT2KGpQY/IhiMyeRz4zDwj615gkOtH9FBf9Ot9hwAImXOtcswVsNIff
         VNdy6SL6uvilJJZgEj2QYcTU7SAQjjvB70uElo7aXtTR6+5wArgYbkcjVIwDub6ywkqo
         8GqY2exLTsxQPnIqhn15zkz+Mi6IjI9w+7S8qfBR/+FkrbmHcT3UwNgTnHPTo4VH8Aa1
         RKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692984; x=1784297784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0qRC/No1g8PcEQDcU52wP9duNRsn2jNfKKht3BgheYY=;
        b=m4AvFJMxIk6vFtN2efDFDlehVe337nbE5Fo2HTaWGBPTfi1vCA1FalAWDF5llcwKAy
         eYPwkBwVFnaHiFDwzt3+f+O3x1fDneLtMQp4ayqvlhBo61Sw+jEn7FFUU8FBaRM3vUEx
         0iubHfuzirq88QgKUKYNLRh+c/C27zuW7a5fYIOWV+Cx2iDpoxPEyhvgfzWZp6A3wdIE
         3IfxsxN1bY1n+U4XK4ukO5XGnpVwx4xiSsbhdptTar6cQJ3QMf39XSzHsUDH0Y3n0G7J
         4H5mdCqTWa0GAVjfO/Rd75dMQoFtk5NNrMBWffongAnFSt9aAc5dMoNGkP5/uQYvmgo0
         q1CQ==
X-Gm-Message-State: AOJu0Yz42Cf5GMX9sv5wA1ecUp6X+tE8jPZUGuwUVtD7caezjrODHQ9v
	ZPqER/vHNvOOa5WnR3Ua0vl8E6NeWWIjvFrliPc6G8HwA70BYzX5c6KBgm51Nw==
X-Gm-Gg: AfdE7ck1POhAQV0rl/b5bo+D9TmDoE/WwGXW5EY1HoPWetvUxnUXHqDQZcavYECGTh+
	egovDRG0XjScYhwvdUyU6UcAaGpaTWucHWlZ/QVNuEyXDgUUyo4A4/MxOhDzyBeS742Zncxz5FC
	+3PfGhE92DtwCsQ1A2hE7XU1/K6QFIgR5BeR9st0PQs49r7fgZBz8MDQiw/XrzaZZNJYzuk6hMg
	y7N6ZyoexBHFpS+4h4EqIOPyoLSHIQE1B3XYnDP+SDTYR0+311e5JOsl3pxlcM3DbAAhTeHzO5p
	5IVaj7jjVt7EyOA2eDuRXC72dZoYkregI+PIwa9uKmAB1Asix6JVj4n0ewUz34y/Ha5NP2uvs9e
	fOx7duusSn9WXZ8P2KrupFoIO9Bk8LZ5YNwDPPhiYtrkBabx7O/CEH6gR5pF9kwrcvr5/PuVtFR
	JjcqOSGQnrDggdb+kg/mpjQdYYNkGpCm/piK6RC86KOG90EJwT7DfPhwUZK1IUIe8+nttjd+lgw
	g==
X-Received: by 2002:a05:6102:c54:b0:740:22ba:8a4e with SMTP id ada2fe7eead31-744dfed12b0mr7211944137.6.1783692980999;
        Fri, 10 Jul 2026 07:16:20 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:19 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 23/36] tuna: Add tests for cpuset modify command
Date: Fri, 10 Jul 2026 10:15:01 -0400
Message-ID: <20260710141523.36440-24-jkacur@redhat.com>
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

Add comprehensive unit and CLI tests for the new cpuset modify functionality:

Unit tests (test_cpuset.py):
- test_get_cpus: Test getting current CPU assignment
- test_get_memnode: Test getting current memory node assignment
- test_get_partition_type: Test getting partition type
- test_modify_cpus_add: Test adding CPUs
- test_modify_cpus_remove: Test removing CPUs
- test_modify_cpus_add_and_remove: Test both operations simultaneously
- test_modify_cpus_empty_result: Test removing all CPUs

CLI tests (test_cpuset_cli.py):
- test_modify_add_cpus: Test --add-cpus option
- test_modify_remove_cpus: Test --remove-cpus option
- test_modify_add_and_remove_cpus: Test combining add and remove
- test_modify_memory_nodes: Test -m/--memory-nodes option
- test_modify_set_isolated: Test --isolated option
- test_modify_unset_isolated: Test --no-isolated option
- test_modify_multiple_changes: Test multiple modifications at once
- test_modify_nonexistent_cpuset_error: Test error handling
- test_modify_no_options_error: Test validation
- test_modify_conflicting_partition_options_error: Test mutual exclusivity

Total new tests: 17 (7 unit + 10 CLI)
All tests verify both success paths and error handling.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/README.md          |  42 ++++----
 tests/test_cpuset.py     | 123 +++++++++++++++++++++
 tests/test_cpuset_cli.py | 227 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 372 insertions(+), 20 deletions(-)

diff --git a/tests/README.md b/tests/README.md
index c890b0ab0c78..4c3ecaca2563 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -12,7 +12,7 @@ This directory contains the test suite for tuna, using Python's `unittest` frame
 # Run all non-root tests only (37 tests)
 make tests
 
-# Run ALL tests (all 91 tests, requires sudo for root-required tests)
+# Run ALL tests (all 111 tests, requires sudo for root-required tests)
 make test-all
 
 # Run specific test module
@@ -37,7 +37,7 @@ make tests
 # or
 make unit-tests
 
-# Using make (ALL tests including root-required tests, 91 tests)
+# Using make (ALL tests including root-required tests, 111 tests)
 make test-all
 
 # Using the test runner directly (non-root tests only)
@@ -144,25 +144,25 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - Validates smart NUMA-aware memory node assignment for cpusets
   - Run: `python3 -m unittest tests.test_cpuset.TestNumaDetection -v`
 
-#### Root-Required Tests (54 tests)
+#### Root-Required Tests (74 tests)
 
 - **test_process_blocklist.py** (2 tests) - Process blocklist root tests
   - Tests actual blocking of systemd from being moved to cpusets
   - Verifies normal processes can still be moved
   - Run: `sudo python3 -m unittest tests.test_process_blocklist.TestProcessBlocklist.test_write_pid_blocks_systemd tests.test_process_blocklist.TestProcessBlocklist.test_write_pid_allows_normal_process -v`
 
-- **test_cpuset.py** (25 tests) - Core cpuset module tests
+- **test_cpuset.py** (32 tests) - Core cpuset module tests
   - TestCpusetCreation: Creating and destroying cpusets
-  - TestCpusetConfiguration: CPU/memory assignment
+  - TestCpusetConfiguration: CPU/memory assignment, including modify_cpus() with add/remove operations
   - TestContextManager: auto_destroy behavior with context managers
   - TestProcessMovement: write_pid() functionality
   - TestTaskMigration: Process migration between cpusets
   - TestDiscoveryFunctions: list_cpusets() with patterns and recursion
   - TestCleanupFunctions: destroy_cpuset() and cleanup_cpusets()
   - Note: TestCpusetsInit (5 tests) and TestNumaDetection (6 tests) run without root, see non-root section
-  - Run: `sudo python3 -m unittest tests.test_cpuset -v` (runs all 36 tests with root)
+  - Run: `sudo python3 -m unittest tests.test_cpuset -v` (runs all 43 tests with root)
 
-- **test_cpuset_cli.py** (30 tests) - CLI command tests
+- **test_cpuset_cli.py** (40 tests) - CLI command tests
   - TestGetNextTunaCpusetName: Auto-naming logic (tuna0, tuna1, gap-filling)
   - TestCpusetCreateCLI: Create command with auto/custom names, --isolated, and NUMA auto-detection/override
   - TestCpusetListCLI: List command with --pattern, --verbose, --skip-empty
@@ -170,9 +170,10 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - TestCpusetMoveCLI: Move command with --pids, --threads, error handling, blocklist protection
   - TestCpusetShowCLI: Show command for detailed cpuset information
   - TestCpusetStatusCLI: Status command for system-wide cpuset overview
+  - TestCpusetModifyCLI: Modify command with --add-cpus, --remove-cpus, --memory-nodes, --isolated/--no-isolated
   - Run: `sudo python3 -m unittest tests.test_cpuset_cli -v`
 
-**Total: 91 tests** (37 non-root + 54 root-required)
+**Total: 111 tests** (37 non-root + 74 root-required)
 
 ### Test Requirements: Root vs Non-Root
 
@@ -212,22 +213,23 @@ These tests run without root privileges:
 - Tests are fast and don't affect the running system
 - Tests verify both happy path (with mocks) and error path (with real EPERM)
 
-#### Root-Required Tests (54 tests)
+#### Root-Required Tests (74 tests)
 
 These tests require root to create/manipulate cgroups:
 
-1. **Cpuset module tests** (25 tests) create actual cgroups in /sys/fs/cgroup
+1. **Cpuset module tests** (32 tests) create actual cgroups in /sys/fs/cgroup
    - Test real cgroup v2 operations
-   - Verify CPU assignment, memory node configuration
+   - Verify CPU assignment, memory node configuration, and CPU modification (add/remove)
    - Test task migration between cpusets
    - All tests clean up created cpusets in tearDown()
 
-2. **Cpuset CLI tests** (20 tests) test command-line interface functions
-   - Test cpuset create/list/destroy/move commands
+2. **Cpuset CLI tests** (40 tests) test command-line interface functions
+   - Test cpuset create/list/destroy/move/show/status/modify commands
    - Verify auto-naming logic (tuna0, tuna1, etc.)
    - Test NUMA-aware memory node auto-detection and manual override
    - Test pattern matching and safety features
    - Test process migration with --pids and --threads
+   - Test cpuset modification with --add-cpus, --remove-cpus, --memory-nodes, --isolated
    - All tests clean up created cpusets afterwards
 
 **Why root is required:**
@@ -354,25 +356,25 @@ test_numa_node_int (test_cpuset.TestNumaDetection) ... ok
 ----------------------------------------------------------------------
 Ran 37 tests in 0.XXXs
 
-OK (skipped=54)
+OK (skipped=74)
 ```
 
-### All Tests Including Root-Required (91 tests)
+### All Tests Including Root-Required (111 tests)
 
-Running with sudo will run all 91 tests:
+Running with sudo will run all 111 tests:
 
 ```bash
 $ sudo python3 -m unittest discover -s tests -p "test_*.py" -v
 ... (37 non-root tests as above)
 test_initialization (test_cpuset.TestCpusetsInit) ... ok
 test_cpuset_path (test_cpuset.TestCpusetsInit) ... ok
-... (25 cpuset module tests)
+... (32 cpuset module tests)
 test_first_name_is_tuna0 (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
 test_sequential_naming (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
-... (28 cpuset CLI tests)
+... (38 cpuset CLI tests)
 
 ----------------------------------------------------------------------
-Ran 91 tests in X.XXXs
+Ran 111 tests in X.XXXs
 
 OK
 ```
@@ -414,7 +416,7 @@ python3 -m unittest discover -s tests -p "test_*.py" -v
 
 ### Root-Required Tests (Optional for CI)
 
-The cpuset tests (54 tests) can run in CI with special setup:
+The cpuset tests (74 tests) can run in CI with special setup:
 - Requires root access or privileged containers
 - Requires cgroup v2 support
 - May need dedicated test runners with appropriate permissions
diff --git a/tests/test_cpuset.py b/tests/test_cpuset.py
index 92a3f833f371..1d703ddfef6a 100644
--- a/tests/test_cpuset.py
+++ b/tests/test_cpuset.py
@@ -268,6 +268,129 @@ class TestCpusetConfiguration(unittest.TestCase):
             self.assertIn(partition, ['isolated', 'root', 'member'],
                          f"Unexpected partition state: {partition}")
 
+    def test_get_cpus(self):
+        """Test getting current CPU assignment"""
+        cs = cpuset.Cpuset('test_get_cpus')
+        self.test_cpusets.append(cs)
+
+        cs.write_memnode('0')
+        cs.assign_cpus('0-1')
+
+        # Get CPUs using new method
+        cpus = cs.get_cpus()
+
+        # Should return a non-empty string with '0' and '1'
+        self.assertIsInstance(cpus, str)
+        self.assertTrue(cpus)
+        self.assertIn('0', cpus)
+        self.assertIn('1', cpus)
+
+    def test_get_memnode(self):
+        """Test getting current memory node assignment"""
+        cs = cpuset.Cpuset('test_get_memnode')
+        self.test_cpusets.append(cs)
+
+        cs.write_memnode('0')
+
+        # Get memory node using new method
+        mems = cs.get_memnode()
+
+        self.assertEqual(mems, '0')
+
+    def test_get_partition_type(self):
+        """Test getting current partition type"""
+        cs = cpuset.Cpuset('test_get_partition')
+        self.test_cpusets.append(cs)
+
+        cs.write_memnode('0')
+        cs.assign_cpus('0')
+
+        # Get partition type
+        partition = cs.get_partition_type()
+
+        # Should be 'member', 'isolated', 'root', or None
+        self.assertIn(partition, ['member', 'isolated', 'root', None])
+
+    def test_modify_cpus_add(self):
+        """Test adding CPUs to a cpuset"""
+        cs = cpuset.Cpuset('test_modify_add')
+        self.test_cpusets.append(cs)
+
+        cs.write_memnode('0')
+        cs.assign_cpus('0-1')
+
+        # Add CPUs 2-3
+        cs.modify_cpus(add_cpus=[2, 3])
+
+        # Check result
+        from tuna import tuna
+        cpus_str = cs.get_cpus()
+        cpu_list = tuna.expand_cpulist(cpus_str)
+
+        self.assertIn(0, cpu_list)
+        self.assertIn(1, cpu_list)
+        self.assertIn(2, cpu_list)
+        self.assertIn(3, cpu_list)
+
+    def test_modify_cpus_remove(self):
+        """Test removing CPUs from a cpuset"""
+        cs = cpuset.Cpuset('test_modify_remove')
+        self.test_cpusets.append(cs)
+
+        cs.write_memnode('0')
+        cs.assign_cpus('0-3')
+
+        # Remove CPUs 2-3
+        cs.modify_cpus(remove_cpus=[2, 3])
+
+        # Check result
+        from tuna import tuna
+        cpus_str = cs.get_cpus()
+        cpu_list = tuna.expand_cpulist(cpus_str)
+
+        self.assertIn(0, cpu_list)
+        self.assertIn(1, cpu_list)
+        self.assertNotIn(2, cpu_list)
+        self.assertNotIn(3, cpu_list)
+
+    def test_modify_cpus_add_and_remove(self):
+        """Test adding and removing CPUs in a single operation"""
+        cs = cpuset.Cpuset('test_modify_both')
+        self.test_cpusets.append(cs)
+
+        cs.write_memnode('0')
+        cs.assign_cpus('0-3')
+
+        # Remove 0-1, add 4-5
+        cs.modify_cpus(add_cpus=[4, 5], remove_cpus=[0, 1])
+
+        # Check result
+        from tuna import tuna
+        cpus_str = cs.get_cpus()
+        cpu_list = tuna.expand_cpulist(cpus_str)
+
+        self.assertNotIn(0, cpu_list)
+        self.assertNotIn(1, cpu_list)
+        self.assertIn(2, cpu_list)
+        self.assertIn(3, cpu_list)
+        self.assertIn(4, cpu_list)
+        self.assertIn(5, cpu_list)
+
+    def test_modify_cpus_empty_result(self):
+        """Test that modify_cpus can result in empty CPU set"""
+        cs = cpuset.Cpuset('test_modify_empty')
+        self.test_cpusets.append(cs)
+
+        cs.write_memnode('0')
+        cs.assign_cpus('0-1')
+
+        # Remove all CPUs
+        cs.modify_cpus(remove_cpus=[0, 1])
+
+        # Check result should be empty
+        cpus_str = cs.get_cpus()
+        self.assertEqual(cpus_str, '')
+
 
 @unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
 @unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
diff --git a/tests/test_cpuset_cli.py b/tests/test_cpuset_cli.py
index f8bf723d5c72..fc647ad93c97 100644
--- a/tests/test_cpuset_cli.py
+++ b/tests/test_cpuset_cli.py
@@ -19,6 +19,7 @@ All tests clean up created cpusets afterwards (even though tuna creates persiste
 import unittest
 import os
 import sys
+import subprocess
 from pathlib import Path
 
 # Add tuna to path if running from tests directory
@@ -650,6 +651,231 @@ class TestCpusetStatusCLI(unittest.TestCase):
         self.assertEqual(info['partition'], 'isolated')
 
 
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestCpusetModifyCLI(unittest.TestCase):
+    """Test 'tuna cpuset modify' command"""
+
+    def setUp(self):
+        """Create test cpusets"""
+        self.test_cpusets = []
+
+    def tearDown(self):
+        """Clean up test cpusets"""
+        for cs_name in self.test_cpusets:
+            try:
+                cpuset.destroy_cpuset(cs_name, force=True)
+            except:
+                pass
+
+    def test_modify_add_cpus(self):
+        """Test modifying cpuset by adding CPUs"""
+        # Create test cpuset
+        cs = cpuset.Cpuset('test_modify_add')
+        cs.write_memnode('0')
+        cs.assign_cpus('0-1')
+        self.test_cpusets.append('test_modify_add')
+
+        # Call modify command
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'cpuset', 'modify',
+            'test_modify_add', '--add-cpus', '2-3'
+        ], capture_output=True, text=True)
+
+        self.assertEqual(result.returncode, 0)
+        self.assertIn('Modified cpuset', result.stdout)
+        self.assertIn('CPUs:', result.stdout)
+
+        # Verify CPUs were added
+        from tuna import tuna
+        cs_reload = cpuset.Cpuset('test_modify_add', existing_ok=True)
+        cpus_str = cs_reload.get_cpus()
+        cpu_list = tuna.expand_cpulist(cpus_str)
+
+        self.assertIn(0, cpu_list)
+        self.assertIn(1, cpu_list)
+        self.assertIn(2, cpu_list)
+        self.assertIn(3, cpu_list)
+
+    def test_modify_remove_cpus(self):
+        """Test modifying cpuset by removing CPUs"""
+        # Create test cpuset
+        cs = cpuset.Cpuset('test_modify_remove')
+        cs.write_memnode('0')
+        cs.assign_cpus('0-3')
+        self.test_cpusets.append('test_modify_remove')
+
+        # Call modify command
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'cpuset', 'modify',
+            'test_modify_remove', '--remove-cpus', '2-3'
+        ], capture_output=True, text=True)
+
+        self.assertEqual(result.returncode, 0)
+        self.assertIn('Modified cpuset', result.stdout)
+
+        # Verify CPUs were removed
+        from tuna import tuna
+        cs_reload = cpuset.Cpuset('test_modify_remove', existing_ok=True)
+        cpus_str = cs_reload.get_cpus()
+        cpu_list = tuna.expand_cpulist(cpus_str)
+
+        self.assertIn(0, cpu_list)
+        self.assertIn(1, cpu_list)
+        self.assertNotIn(2, cpu_list)
+        self.assertNotIn(3, cpu_list)
+
+    def test_modify_add_and_remove_cpus(self):
+        """Test modifying cpuset by adding and removing CPUs simultaneously"""
+        # Create test cpuset
+        cs = cpuset.Cpuset('test_modify_both')
+        cs.write_memnode('0')
+        cs.assign_cpus('0-3')
+        self.test_cpusets.append('test_modify_both')
+
+        # Call modify command
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'cpuset', 'modify',
+            'test_modify_both', '--add-cpus', '4-5', '--remove-cpus', '0-1'
+        ], capture_output=True, text=True)
+
+        self.assertEqual(result.returncode, 0)
+
+        # Verify changes
+        from tuna import tuna
+        cs_reload = cpuset.Cpuset('test_modify_both', existing_ok=True)
+        cpus_str = cs_reload.get_cpus()
+        cpu_list = tuna.expand_cpulist(cpus_str)
+
+        self.assertNotIn(0, cpu_list)
+        self.assertNotIn(1, cpu_list)
+        self.assertIn(2, cpu_list)
+        self.assertIn(3, cpu_list)
+        self.assertIn(4, cpu_list)
+        self.assertIn(5, cpu_list)
+
+    def test_modify_memory_nodes(self):
+        """Test modifying memory nodes"""
+        # Create test cpuset
+        cs = cpuset.Cpuset('test_modify_mems')
+        cs.write_memnode('0')
+        cs.assign_cpus('0-1')
+        self.test_cpusets.append('test_modify_mems')
+
+        # Call modify command
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'cpuset', 'modify',
+            'test_modify_mems', '-m', '0'
+        ], capture_output=True, text=True)
+
+        self.assertEqual(result.returncode, 0)
+        self.assertIn('Memory nodes:', result.stdout)
+
+    def test_modify_set_isolated(self):
+        """Test setting partition to isolated"""
+        # Create test cpuset
+        cs = cpuset.Cpuset('test_modify_isolated')
+        cs.write_memnode('0')
+        cs.assign_cpus('0')
+        self.test_cpusets.append('test_modify_isolated')
+
+        # Call modify command
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'cpuset', 'modify',
+            'test_modify_isolated', '--isolated'
+        ], capture_output=True, text=True)
+
+        self.assertEqual(result.returncode, 0)
+        self.assertIn('Partition:', result.stdout)
+        self.assertIn('isolated', result.stdout)
+
+    def test_modify_unset_isolated(self):
+        """Test setting partition to member (not isolated)"""
+        # Create test cpuset with isolated partition
+        cs = cpuset.Cpuset('test_modify_member')
+        cs.write_memnode('0')
+        cs.assign_cpus('0')
+        cs.set_cpu_exclusive()
+        self.test_cpusets.append('test_modify_member')
+
+        # Call modify command to unset isolated
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'cpuset', 'modify',
+            'test_modify_member', '--no-isolated'
+        ], capture_output=True, text=True)
+
+        self.assertEqual(result.returncode, 0)
+        self.assertIn('Partition:', result.stdout)
+        self.assertIn('member', result.stdout)
+
+    def test_modify_multiple_changes(self):
+        """Test modifying multiple properties at once"""
+        # Create test cpuset
+        cs = cpuset.Cpuset('test_modify_multi')
+        cs.write_memnode('0')
+        cs.assign_cpus('0-1')
+        self.test_cpusets.append('test_modify_multi')
+
+        # Call modify command with multiple changes
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'cpuset', 'modify',
+            'test_modify_multi',
+            '--add-cpus', '2-3',
+            '-m', '0',
+            '--isolated'
+        ], capture_output=True, text=True)
+
+        self.assertEqual(result.returncode, 0)
+        self.assertIn('CPUs:', result.stdout)
+        self.assertIn('Memory nodes:', result.stdout)
+        self.assertIn('Partition:', result.stdout)
+
+    def test_modify_nonexistent_cpuset_error(self):
+        """Test error when modifying nonexistent cpuset"""
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'cpuset', 'modify',
+            'nonexistent_cpuset', '--add-cpus', '0'
+        ], capture_output=True, text=True)
+
+        self.assertNotEqual(result.returncode, 0)
+        self.assertIn('does not exist', result.stderr)
+
+    def test_modify_no_options_error(self):
+        """Test error when no modification options specified"""
+        # Create test cpuset
+        cs = cpuset.Cpuset('test_modify_no_opts')
+        cs.write_memnode('0')
+        cs.assign_cpus('0')
+        self.test_cpusets.append('test_modify_no_opts')
+
+        # Call modify with no options
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'cpuset', 'modify',
+            'test_modify_no_opts'
+        ], capture_output=True, text=True)
+
+        self.assertNotEqual(result.returncode, 0)
+        self.assertIn('at least one modification', result.stderr)
+
+    def test_modify_conflicting_partition_options_error(self):
+        """Test error when both --isolated and --no-isolated specified"""
+        # Create test cpuset
+        cs = cpuset.Cpuset('test_modify_conflict')
+        cs.write_memnode('0')
+        cs.assign_cpus('0')
+        self.test_cpusets.append('test_modify_conflict')
+
+        # This should be caught by argparse, not our code
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'cpuset', 'modify',
+            'test_modify_conflict', '--isolated', '--no-isolated'
+        ], capture_output=True, text=True)
+
+        self.assertNotEqual(result.returncode, 0)
+        # argparse will complain about mutually exclusive group
+        self.assertTrue(result.stderr)  # Should have error output
+
+
 def suite():
     """Create test suite"""
     loader = unittest.TestLoader()
@@ -663,6 +889,7 @@ def suite():
     suite.addTests(loader.loadTestsFromTestCase(TestCpusetMoveCLI))
     suite.addTests(loader.loadTestsFromTestCase(TestCpusetShowCLI))
     suite.addTests(loader.loadTestsFromTestCase(TestCpusetStatusCLI))
+    suite.addTests(loader.loadTestsFromTestCase(TestCpusetModifyCLI))
 
     return suite
 
-- 
2.54.0

