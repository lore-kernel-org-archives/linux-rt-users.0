Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D0A31716B
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692976; cv=none; b=ZJ9PHC/JD1OKYS3lExgWFimLsMaP30aeibVimQofBZPKCXrCBDZlx2NF2CHFGfBO6gvZYsHMNEgoUOFeq/9iMrq0E/uxUiAz0sxOVskJ11vctPkNN44sbUqrcQBpsLmxUr43yZMpsADBcsSnFqrLwa//Ri78gr7ZO1Jg0/8FkEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692976; c=relaxed/simple;
	bh=MHvlEDF0ciFqxVT/S9OZkY9FEqvtt4yWyyKY/o6j4qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bU1boTtFu55aHIJC5QA4CENtOc4tNI1AZwFLjpXMaWx8ga9a5fL+WdCvztRhCUhP3WHKqNQt0lTFdlKGpIKGBc2vzEGOyZB4azWTcEma0/OGpQAY5DyxsUswlRa5adHedb1puoKSa8F2l4QBNEZBL40o+zCQoHWWt5+S1j4MV6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y13H0qaa; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y13H0qaa"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-737de52625cso485710137.3
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692974; x=1784297774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mg9XTnTgwjD4ejeoKqlZbsyhJMIm/lbWZmbkCfN8iTE=;
        b=Y13H0qaakNjyLx1XdeV0wX2Fa1gS3CSidgPzDdDtd6qRpGVc7iwqws5yUAbSXrK2f2
         d857MD/t+1qRMwA5Wd2qWV1daA2jEPhG3d2OdWFg/YkI7wzvpCtuzUn0bqSn2n4YfNDF
         1I9T6Ri5Vo8CMEAum7iUGuxkk8kzOGeR7XqqnFLsizYHiIjXFKyAl5yGW8gI4sDbGS7P
         rUCHdweFpt0vc9cZ6G5G3GFUhzvwoMg2Rvg6DlDwFEsaSMUa7DzOkB2RIcs+FblcPefN
         PMIWvMMARPF1V8yyWVvPRowN8WvPwyIjMzzJO0ImE0GFqCt7kgRXTPk/w/KkZvItUPU8
         oEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692974; x=1784297774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mg9XTnTgwjD4ejeoKqlZbsyhJMIm/lbWZmbkCfN8iTE=;
        b=SSzPyClXMriF0h2Qja3yKxz2t3vYfzuJ77MtsnCn4zLSQ4l9bGiBrcIVJVWUFEUUcW
         IyneAgmNgFRfhVSb4jgjPYQ9aysuEewGk6JnR7jDrujGp/hinm9syKaQ/SaB5fcW9pK+
         Tm3n+Tt9qE7+VIsJZH9x7Tbsq0wlnPsFvibIjrJQvtnsrKPPMzvMIqsTTPc8ZxpN9PaR
         GSQVniCVDEIVqVxf5kBG4vGAmGn5lR2rKFt8FVeG1tQfONIECgtDfVtWD/Xec/yOwRaY
         gbOFa+57Jmcoa7rCmHi8EtMjiXH+JOGswX7rYXDuvYlcksEE3Z8I2ziP3OCkglXolJgC
         9Iyg==
X-Gm-Message-State: AOJu0YzCSzjIkLNx+BADMefcgwgET0QcpmEHT/gSJuy8ckIXhWPEpM5S
	CTDsD6AolIEcSuP1289yrv2j8fLzS60YqFId1lbbZ6xCPaAbLagpSOfiY2x5eg==
X-Gm-Gg: AfdE7cmzSa5+RhuClnnjhgN6TUcYrosk7rIV2mYawNnbDAFJm30Y/HgLJg53Oxriy8g
	28Zv4LOk5+TWJSvEN5CZYE4ecKICan4XPbL5sak/rvDNAGm3qMX3dyt89+HbfSv5vk233CNc10D
	hlV0TZAesKF7Ip6xs13++tCNOsoflW4v0iQE10jffKpSRSVeKwCcyvzz9mrtN8kw8qtRq9/uyx+
	NyWtvW9LjR6pY/EkBlSMq5wwRC1RVSlsQBnN+rMWVK2EDByQd91PwC11PeXv4M12MLznZwKXdGt
	s0eleVjD3pARWjPPlQR3hBNY8l/cpKr3DdvTmXj9hYHVkYlKZL+hDWeHZOje+VpZPxCpl/Tsztd
	EzhAx8m6hSzhcaOL1eMvBo0yJ9CNHYzbgYF6MNyv/qX37w0H4VDbIGtCb4wFRBm+xoG3xGDMxiU
	XkduewLI91e27lqQEEzsFQsL1cGd1JqqhGKu4rCrbvTwSpOjQYDHvYMNVCI3C1sI4bP+tJSbIoh
	Q==
X-Received: by 2002:a05:6102:5129:b0:739:977f:c1ba with SMTP id ada2fe7eead31-744dfdf14dfmr7126847137.2.1783692973965;
        Fri, 10 Jul 2026 07:16:13 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:13 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 19/36] tuna: Add tests for cpuset show and status commands
Date: Fri, 10 Jul 2026 10:14:57 -0400
Message-ID: <20260710141523.36440-20-jkacur@redhat.com>
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

Add comprehensive test coverage for the new cpuset show and status
commands:

- TestCpusetShowCLI (4 tests):
  * test_show_basic_info - Verify basic cpuset information display
  * test_show_nonexistent_cpuset - Error handling for missing cpusets
  * test_show_with_tasks - Task list display functionality
  * test_get_cpuset_info_error_handling - Error handling in helper

- TestCpusetStatusCLI (4 tests):
  * test_status_with_multiple_cpusets - Multiple cpusets display
  * test_status_with_pattern_filter - Pattern filtering functionality
  * test_status_skip_empty - Skip empty cpusets option
  * test_status_shows_isolated - Isolated cpuset identification

Update tests/README.md to reflect new test counts:
- Total tests: 91 (up from 71)
- Non-root tests: 37 (unchanged)
- Root-required tests: 54 (up from 42)

All tests follow the existing patterns with proper setup/teardown
and cleanup to ensure no test cpusets are left behind.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/README.md          |  53 ++++++------
 tests/test_cpuset_cli.py | 175 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 203 insertions(+), 25 deletions(-)

diff --git a/tests/README.md b/tests/README.md
index a199f7efa9e6..c890b0ab0c78 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -9,10 +9,10 @@ This directory contains the test suite for tuna, using Python's `unittest` frame
 ## Quick Start
 
 ```bash
-# Run all non-root tests only (29 tests)
+# Run all non-root tests only (37 tests)
 make tests
 
-# Run ALL tests (all 71 tests, requires sudo for root-required tests)
+# Run ALL tests (all 91 tests, requires sudo for root-required tests)
 make test-all
 
 # Run specific test module
@@ -32,12 +32,12 @@ sudo python3 -m unittest tests.test_cpuset -v
 Run all unit tests using any of these methods:
 
 ```bash
-# Using make (non-root tests only, 29 tests)
+# Using make (non-root tests only, 37 tests)
 make tests
 # or
 make unit-tests
 
-# Using make (ALL tests including root-required tests, 71 tests)
+# Using make (ALL tests including root-required tests, 91 tests)
 make test-all
 
 # Using the test runner directly (non-root tests only)
@@ -144,32 +144,35 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - Validates smart NUMA-aware memory node assignment for cpusets
   - Run: `python3 -m unittest tests.test_cpuset.TestNumaDetection -v`
 
-#### Root-Required Tests (44 tests)
+#### Root-Required Tests (54 tests)
 
 - **test_process_blocklist.py** (2 tests) - Process blocklist root tests
   - Tests actual blocking of systemd from being moved to cpusets
   - Verifies normal processes can still be moved
   - Run: `sudo python3 -m unittest tests.test_process_blocklist.TestProcessBlocklist.test_write_pid_blocks_systemd tests.test_process_blocklist.TestProcessBlocklist.test_write_pid_allows_normal_process -v`
 
-- **test_cpuset.py** (22 tests) - Core cpuset module tests
+- **test_cpuset.py** (25 tests) - Core cpuset module tests
   - TestCpusetCreation: Creating and destroying cpusets
   - TestCpusetConfiguration: CPU/memory assignment
   - TestContextManager: auto_destroy behavior with context managers
+  - TestProcessMovement: write_pid() functionality
   - TestTaskMigration: Process migration between cpusets
   - TestDiscoveryFunctions: list_cpusets() with patterns and recursion
   - TestCleanupFunctions: destroy_cpuset() and cleanup_cpusets()
-  - Note: TestCpusetsInit (5 tests) runs without root, see non-root section
-  - Run: `sudo python3 -m unittest tests.test_cpuset -v` (runs all 27 tests with root)
+  - Note: TestCpusetsInit (5 tests) and TestNumaDetection (6 tests) run without root, see non-root section
+  - Run: `sudo python3 -m unittest tests.test_cpuset -v` (runs all 36 tests with root)
 
-- **test_cpuset_cli.py** (22 tests) - CLI command tests
+- **test_cpuset_cli.py** (30 tests) - CLI command tests
   - TestGetNextTunaCpusetName: Auto-naming logic (tuna0, tuna1, gap-filling)
   - TestCpusetCreateCLI: Create command with auto/custom names, --isolated, and NUMA auto-detection/override
   - TestCpusetListCLI: List command with --pattern, --verbose, --skip-empty
   - TestCpusetDestroyCLI: Destroy command with patterns and safety options
   - TestCpusetMoveCLI: Move command with --pids, --threads, error handling, blocklist protection
+  - TestCpusetShowCLI: Show command for detailed cpuset information
+  - TestCpusetStatusCLI: Status command for system-wide cpuset overview
   - Run: `sudo python3 -m unittest tests.test_cpuset_cli -v`
 
-**Total: 83 tests** (37 non-root + 46 root-required)
+**Total: 91 tests** (37 non-root + 54 root-required)
 
 ### Test Requirements: Root vs Non-Root
 
@@ -209,11 +212,11 @@ These tests run without root privileges:
 - Tests are fast and don't affect the running system
 - Tests verify both happy path (with mocks) and error path (with real EPERM)
 
-#### Root-Required Tests (42 tests)
+#### Root-Required Tests (54 tests)
 
 These tests require root to create/manipulate cgroups:
 
-1. **Cpuset module tests** (22 tests) create actual cgroups in /sys/fs/cgroup
+1. **Cpuset module tests** (25 tests) create actual cgroups in /sys/fs/cgroup
    - Test real cgroup v2 operations
    - Verify CPU assignment, memory node configuration
    - Test task migration between cpusets
@@ -316,7 +319,7 @@ self.assertRaises(Exception, fn) # fn() raises Exception
 
 ## Expected Output
 
-### Non-Root Tests Only (29 tests)
+### Non-Root Tests Only (37 tests)
 
 Running without sudo will run only the non-root tests:
 
@@ -349,27 +352,27 @@ test_numa_node_int (test_cpuset.TestNumaDetection) ... ok
 ... (most cpuset tests skipped: "Requires root permissions")
 
 ----------------------------------------------------------------------
-Ran 29 tests in 0.XXXs
+Ran 37 tests in 0.XXXs
 
-OK (skipped=42)
+OK (skipped=54)
 ```
 
-### All Tests Including Root-Required (71 tests)
+### All Tests Including Root-Required (91 tests)
 
-Running with sudo will run all 71 tests:
+Running with sudo will run all 91 tests:
 
 ```bash
 $ sudo python3 -m unittest discover -s tests -p "test_*.py" -v
-... (29 non-root tests as above)
+... (37 non-root tests as above)
 test_initialization (test_cpuset.TestCpusetsInit) ... ok
 test_cpuset_path (test_cpuset.TestCpusetsInit) ... ok
-... (27 cpuset module tests)
+... (25 cpuset module tests)
 test_first_name_is_tuna0 (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
 test_sequential_naming (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
-... (20 cpuset CLI tests)
+... (28 cpuset CLI tests)
 
 ----------------------------------------------------------------------
-Ran 71 tests in X.XXXs
+Ran 91 tests in X.XXXs
 
 OK
 ```
@@ -378,13 +381,13 @@ OK
 
 The test suite includes:
 
-### Unit Tests (29 tests - no root required)
+### Unit Tests (37 tests - no root required)
 - **Converter tests**: Pure logic testing with mocks
 - **EPERM tests**: Error handling verification
 - **CpusetsInit tests**: System capability detection (read-only)
 - **NUMA detection tests**: NUMA topology discovery and memory node assignment (read-only)
 
-### Integration Tests (42 tests - require root)
+### Integration Tests (54 tests - require root)
 - **Cpuset module tests**: Test interaction with cgroup v2 subsystem
 - **Cpuset CLI tests**: Test command-line interface integration
 
@@ -397,7 +400,7 @@ Future test categories might include:
 
 ### Non-Root Tests (Recommended for CI)
 
-The non-root tests (29 tests) are designed to run in CI/CD environments:
+The non-root tests (37 tests) are designed to run in CI/CD environments:
 - Run without root privileges
 - No special system configuration required
 - Exit code 0 on success, non-zero on failure
@@ -411,7 +414,7 @@ python3 -m unittest discover -s tests -p "test_*.py" -v
 
 ### Root-Required Tests (Optional for CI)
 
-The cpuset tests (42 tests) can run in CI with special setup:
+The cpuset tests (54 tests) can run in CI with special setup:
 - Requires root access or privileged containers
 - Requires cgroup v2 support
 - May need dedicated test runners with appropriate permissions
diff --git a/tests/test_cpuset_cli.py b/tests/test_cpuset_cli.py
index 77b7fcbe1a4f..51c9b5d193c0 100644
--- a/tests/test_cpuset_cli.py
+++ b/tests/test_cpuset_cli.py
@@ -8,6 +8,9 @@ Tests the command-line interface functions added to tuna-cmd.py:
 - cpuset create (with auto-naming, custom names, --isolated)
 - cpuset list (with --pattern, --verbose, --skip-empty)
 - cpuset destroy (single and pattern-based, with --skip-empty)
+- cpuset move (moving processes to cpusets)
+- cpuset show (detailed information about a specific cpuset)
+- cpuset status (system-wide overview of all cpusets)
 - get_next_tuna_cpuset_name() auto-naming logic
 
 All tests clean up created cpusets afterwards (even though tuna creates persistent cpusets).
@@ -38,6 +41,10 @@ cpuset_create = tuna_cmd.cpuset_create
 cpuset_list = tuna_cmd.cpuset_list
 cpuset_destroy = tuna_cmd.cpuset_destroy
 cpuset_move = tuna_cmd.cpuset_move
+cpuset_show = tuna_cmd.cpuset_show
+cpuset_status = tuna_cmd.cpuset_status
+get_cpuset_info = tuna_cmd.get_cpuset_info
+get_all_cpusets_info = tuna_cmd.get_all_cpusets_info
 
 
 @unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
@@ -477,6 +484,172 @@ class TestCpusetMoveCLI(unittest.TestCase):
         self.assertIn(str(current_pid), pids, "Normal process should be moved")
 
 
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestCpusetShowCLI(unittest.TestCase):
+    """Test 'tuna cpuset show' command"""
+
+    def setUp(self):
+        """Create test cpusets before each test"""
+        self.ci = cpuset.CpusetsInit()
+        # Clean up any existing test cpusets
+        try:
+            cpuset.cleanup_cpusets('test_show_*', force=True, recursive=True)
+        except:
+            pass
+
+    def tearDown(self):
+        """Clean up test cpusets after each test"""
+        try:
+            cpuset.cleanup_cpusets('test_show_*', force=True, recursive=True)
+        except:
+            pass
+
+    def test_show_basic_info(self):
+        """Test showing basic cpuset information"""
+        # Create a test cpuset
+        cs = cpuset.Cpuset('test_show_basic')
+        cs.write_memnode('0')
+        cs.assign_cpus('0-1')
+
+        # Get info using the helper function
+        info = get_cpuset_info('test_show_basic')
+
+        self.assertEqual(info['name'], 'test_show_basic')
+        self.assertEqual(info['cpus'], '0-1')
+        self.assertEqual(info['mems'], '0')
+        self.assertIsNone(info['error'])
+
+    def test_show_nonexistent_cpuset(self):
+        """Test showing info for nonexistent cpuset"""
+        # Try to show a cpuset that doesn't exist
+        with self.assertRaises(SystemExit):
+            # Capture stdout to avoid cluttering test output
+            import io
+            import contextlib
+            f = io.StringIO()
+            with contextlib.redirect_stderr(f):
+                cpuset_show('test_show_nonexistent', show_tasks=False)
+
+    def test_show_with_tasks(self):
+        """Test showing cpuset with tasks"""
+        # Create a test cpuset and add current process
+        cs = cpuset.Cpuset('test_show_tasks')
+        cs.write_memnode('0')
+        cs.assign_cpus('0-1')
+        cs.write_pid(os.getpid())
+
+        # Get info
+        info = get_cpuset_info('test_show_tasks')
+
+        self.assertGreater(info['task_count'], 0)
+        self.assertIn(str(os.getpid()), info['tasks'])
+
+    def test_get_cpuset_info_error_handling(self):
+        """Test get_cpuset_info with invalid cpuset"""
+        info = get_cpuset_info('nonexistent_cpuset')
+
+        self.assertIsNotNone(info['error'])
+        self.assertEqual(info['name'], 'nonexistent_cpuset')
+
+
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestCpusetStatusCLI(unittest.TestCase):
+    """Test 'tuna cpuset status' command"""
+
+    def setUp(self):
+        """Create test cpusets before each test"""
+        self.ci = cpuset.CpusetsInit()
+        # Clean up any existing test cpusets
+        try:
+            cpuset.cleanup_cpusets('test_status_*', force=True, recursive=True)
+        except:
+            pass
+
+    def tearDown(self):
+        """Clean up test cpusets after each test"""
+        try:
+            cpuset.cleanup_cpusets('test_status_*', force=True, recursive=True)
+        except:
+            pass
+
+    def test_status_with_multiple_cpusets(self):
+        """Test status showing multiple cpusets"""
+        # Create multiple test cpusets
+        cs1 = cpuset.Cpuset('test_status_1')
+        cs1.write_memnode('0')
+        cs1.assign_cpus('0-1')
+
+        cs2 = cpuset.Cpuset('test_status_2')
+        cs2.write_memnode('0')
+        cs2.assign_cpus('2-3')
+        cs2.set_cpu_exclusive()
+
+        # Get all cpusets info
+        infos = get_all_cpusets_info(pattern='test_status_*', recursive=False)
+
+        self.assertEqual(len(infos), 2)
+        names = [info['name'] for info in infos]
+        self.assertIn('test_status_1', names)
+        self.assertIn('test_status_2', names)
+
+    def test_status_with_pattern_filter(self):
+        """Test status with pattern filtering"""
+        # Create cpusets with different patterns
+        cs1 = cpuset.Cpuset('test_status_match')
+        cs1.write_memnode('0')
+        cs1.assign_cpus('0')
+
+        cs2 = cpuset.Cpuset('test_other_nomatch')
+        cs2.write_memnode('0')
+        cs2.assign_cpus('1')
+
+        # Get cpusets matching pattern
+        infos = get_all_cpusets_info(pattern='test_status_*', recursive=False)
+
+        self.assertEqual(len(infos), 1)
+        self.assertEqual(infos[0]['name'], 'test_status_match')
+
+        # Clean up the non-matching one manually
+        try:
+            cpuset.destroy_cpuset('test_other_nomatch', force=True)
+        except:
+            pass
+
+    def test_status_skip_empty(self):
+        """Test status with skip_empty option"""
+        # Create cpuset with CPUs
+        cs1 = cpuset.Cpuset('test_status_filled')
+        cs1.write_memnode('0')
+        cs1.assign_cpus('0-1')
+
+        # Create cpuset without CPUs
+        cs2 = cpuset.Cpuset('test_status_empty')
+        cs2.write_memnode('0')
+
+        # Get all (should include both)
+        all_infos = get_all_cpusets_info(pattern='test_status_*', skip_empty=False)
+        self.assertEqual(len(all_infos), 2)
+
+        # Get non-empty only
+        nonempty_infos = get_all_cpusets_info(pattern='test_status_*', skip_empty=True)
+        self.assertEqual(len(nonempty_infos), 1)
+        self.assertEqual(nonempty_infos[0]['name'], 'test_status_filled')
+
+    def test_status_shows_isolated(self):
+        """Test status correctly identifies isolated cpusets"""
+        # Create isolated cpuset
+        cs = cpuset.Cpuset('test_status_isolated')
+        cs.write_memnode('0')
+        cs.assign_cpus('0-1')
+        cs.set_cpu_exclusive()
+
+        info = get_cpuset_info('test_status_isolated')
+
+        self.assertEqual(info['partition'], 'isolated')
+
+
 def suite():
     """Create test suite"""
     loader = unittest.TestLoader()
@@ -488,6 +661,8 @@ def suite():
     suite.addTests(loader.loadTestsFromTestCase(TestCpusetListCLI))
     suite.addTests(loader.loadTestsFromTestCase(TestCpusetDestroyCLI))
     suite.addTests(loader.loadTestsFromTestCase(TestCpusetMoveCLI))
+    suite.addTests(loader.loadTestsFromTestCase(TestCpusetShowCLI))
+    suite.addTests(loader.loadTestsFromTestCase(TestCpusetStatusCLI))
 
     return suite
 
-- 
2.54.0

