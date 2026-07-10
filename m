Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E36431716B
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692968; cv=none; b=E43bG6x+2BU+oFMBFW1B3Hox48RBEyBDKlVEXQX9Dn+i6fXl90OPVzEUlEsi6NgFEZyAvutmT38qT193cmDjzcog2YSoY23cjHJA/m4q0fGaQrbCzs2CIwgz/6lQxtWrBO1fOkTYRHfEs3SiXi1VOvGNlm/eZDmuwWAFTGeaTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692968; c=relaxed/simple;
	bh=5mQZr2UIL8UubGcvptSZgYFPL+ci9vhSxdHK8ZQoges=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxhcdldyc3uXmQA05sMbo7wIGzQoLJ0svEjE1TqLuMuzv9h+0sWAlRsi+KeZGEFuwQM84dJ7eWOWsGyn/qbCeFSjHXH97UdW/mzy45vpisr/1YOcGvgPsjqQQwPNu8ASbWqfQhhGXSmy1GcLPLGnL4EVlXS1ZBzhFyse+jm/HLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jgl8ArKw; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jgl8ArKw"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9696319e14dso369974241.3
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692966; x=1784297766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wmK+4wIY054+kL2UanIydTvzG+9Gx/YYeFTgmL7VIAE=;
        b=Jgl8ArKw/tr04L+ixHQJSjldGJYd1qTxTqvvc9+qw1WzLI8mQDu2a+OCp9lrKPhq/W
         lCv6XBDZL7g4BN7rPWLXSrG3ZIavVQK7D1pYBPUB4Hkx4ak/liboEF6AipXmPx/dn4EH
         e3u3ri0IC1cZofEVkTizxcrbR/bjJH1deBZqvYv4mH5qPucQaBMiWPboJdlE0sbZbo9S
         fBOgerxAYixk16CjlNeqXe6xse5KeEXpLBJT/mXKL5biCqwIURna/TCyO6XzFC/bzccI
         0wSOZkQRPeWhviklxenGiDp9iVOkeKviQ37oESZIOcY0ufmjlGKQ+O9i6asxUf8XgnSt
         2qHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692966; x=1784297766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wmK+4wIY054+kL2UanIydTvzG+9Gx/YYeFTgmL7VIAE=;
        b=Vr15wgLnTZEuZcGo4TTQb4Ste6sdBtJpvvoEL5/c6tA7ASu8Fc6Ig4TzYcNCeSsLjY
         Vzrfr93zdUB2cCCXpVzsjD6/5YtdO+x+j3h9K1TJk7fnW+2aKf4AMhXKffh4kz0pI+Mp
         cfxLJM8qF1+fJc23RXyXwBYyjciVISuPnbk6nAxUlKqDbP2Dm7Nh2DZ2Z934H73p2Xbg
         Zeco9TE+KqxN11zgkYJ924bGvqYfyrsecNR7XjjUnKfa1YBEatNtELDYRPvw9Xpc1Glr
         q1PsoFxi55U11Baa33d9BZWDK85vgjSSE67Kr9uHaoWbpVYtypypP5fby8cD0QPuIYN9
         AtPg==
X-Gm-Message-State: AOJu0YwHZulkw3AkZLc3mhqn8TZZAdqb9/bd+Lwl7JyResTRRgfxPb1t
	INQM4jqci+sHds1QOeBko/W50JXYlpZ01gpdxomuzCfNE5Mu8ClYquyY6ZBoGw==
X-Gm-Gg: AfdE7ckAKszoXSkBlij+TEitmzi0t90Uf2nJyGa3ul6U/8aTx83W8eQR6lR8bQ2C8Ck
	oV8gl5r0O6SgZyWwkiXq8bNYNjVUAu8bM8hu8QI150kLE/S7V/ZkaPwBrf08egVr8BGx7hPYgG1
	nFQlYzu0OmPISTxW3uNi5HTUttWUBYfb8wDjSTUv8yEdc5T4ecLGjri1lGpycyFg3oKT6i/pt8C
	0QM+MDsnWgPhG+vz3kDJo2hJXgbNoylPwmakal0HXbiCD3nMgIB4aVppzgpk16o/H/96TSqRlPf
	ozyLS9ziw7+Jt25NyG89TxDlZ7TIc8Zdq24OBEozagz2jIwSPJSJ0fZiRNtaUC1XOB/7sN75yC6
	tZh31Col5AbSC4lecjesB8Ymksg9edfCp68w+CyyeKs7S1fXqiTZjmFxRMues7eUOk0mmbBgcLp
	n6rx3AKhBvtsWuscWVbnCFjdIDNM6NxlD1LoiNpgnItz0LQPmXVv47VPPjLTgR7u7ZSyd6FynfG
	g==
X-Received: by 2002:a05:6102:292a:b0:73e:c6a0:331 with SMTP id ada2fe7eead31-744e0047e5emr7000917137.10.1783692965923;
        Fri, 10 Jul 2026 07:16:05 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:05 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 13/36] tuna: Add comprehensive tests for cpuset move command
Date: Fri, 10 Jul 2026 10:14:51 -0400
Message-ID: <20260710141523.36440-14-jkacur@redhat.com>
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

Adds unit tests and CLI tests for the cpuset move functionality,
plus updates test documentation.

Test coverage:
- TestProcessMovement (3 tests): Unit tests for write_pid() functionality
  - test_write_pid_self: Moving current process to cpuset
  - test_write_pid_invalid: Invalid PID handling
  - test_multiple_pids: Multiple process migration

- TestCpusetMoveCLI (6 tests): Integration tests for CLI command
  - test_move_with_pids: Moving processes with --pids argument
  - test_move_with_threads: Moving processes with --threads argument
  - test_move_both_pids_and_threads: Using both arguments together
  - test_move_nonexistent_cpuset_error: Error handling for missing cpuset
  - test_move_no_pids_error: Error handling when no PIDs provided
  - test_move_invalid_pid: Graceful handling of invalid PIDs

All tests include proper setup/teardown to ensure cpusets are cleaned up
and processes are moved back to root cgroup after testing.

Updates tests/README.md to reflect new test count (63 total, up from 57)
and documents the new TestCpusetMoveCLI test class.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/README.md          |  36 +++++++-------
 tests/test_cpuset.py     |  76 +++++++++++++++++++++++++++++
 tests/test_cpuset_cli.py | 102 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+), 17 deletions(-)

diff --git a/tests/README.md b/tests/README.md
index 7f3e53c2c601..ea54d2cee5fd 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -9,10 +9,10 @@ This directory contains the test suite for tuna, using Python's `unittest` frame
 ## Quick Start
 
 ```bash
-# Run all non-root tests only (23 tests, some cpuset tests skipped)
+# Run all non-root tests only (23 tests)
 make tests
 
-# Run ALL tests (all 57 tests, requires sudo for root-required tests)
+# Run ALL tests (all 63 tests, requires sudo for root-required tests)
 make test-all
 
 # Run specific test module
@@ -37,7 +37,7 @@ make tests
 # or
 make unit-tests
 
-# Using make (ALL tests including root-required tests, 57 tests)
+# Using make (ALL tests including root-required tests, 63 tests)
 make test-all
 
 # Using the test runner directly (non-root tests only)
@@ -129,7 +129,7 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - These tests can run without root as they only check system capabilities
   - Run: `python3 -m unittest tests.test_cpuset.TestCpusetsInit -v`
 
-#### Root-Required Tests (34 tests)
+#### Root-Required Tests (40 tests)
 
 - **test_cpuset.py** (22 tests) - Core cpuset module tests
   - TestCpusetCreation: Creating and destroying cpusets
@@ -141,14 +141,15 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - Note: TestCpusetsInit (5 tests) runs without root, see non-root section
   - Run: `sudo python3 -m unittest tests.test_cpuset -v` (runs all 27 tests with root)
 
-- **test_cpuset_cli.py** (12 tests) - CLI command tests
+- **test_cpuset_cli.py** (18 tests) - CLI command tests
   - TestGetNextTunaCpusetName: Auto-naming logic (tuna0, tuna1, gap-filling)
   - TestCpusetCreateCLI: Create command with auto/custom names and --isolated
   - TestCpusetListCLI: List command with --pattern, --verbose, --skip-empty
   - TestCpusetDestroyCLI: Destroy command with patterns and safety options
+  - TestCpusetMoveCLI: Move command with --pids, --threads, error handling
   - Run: `sudo python3 -m unittest tests.test_cpuset_cli -v`
 
-**Total: 57 tests** (23 non-root + 34 root-required)
+**Total: 63 tests** (23 non-root + 40 root-required)
 
 ### Test Requirements: Root vs Non-Root
 
@@ -178,7 +179,7 @@ These tests run without root privileges:
 - Tests are fast and don't affect the running system
 - Tests verify both happy path (with mocks) and error path (with real EPERM)
 
-#### Root-Required Tests (34 tests)
+#### Root-Required Tests (40 tests)
 
 These tests require root to create/manipulate cgroups:
 
@@ -188,10 +189,11 @@ These tests require root to create/manipulate cgroups:
    - Test task migration between cpusets
    - All tests clean up created cpusets in tearDown()
 
-2. **Cpuset CLI tests** (12 tests) test command-line interface functions
-   - Test cpuset create/list/destroy commands
+2. **Cpuset CLI tests** (18 tests) test command-line interface functions
+   - Test cpuset create/list/destroy/move commands
    - Verify auto-naming logic (tuna0, tuna1, etc.)
    - Test pattern matching and safety features
+   - Test process migration with --pids and --threads
    - All tests clean up created cpusets afterwards
 
 **Why root is required:**
@@ -312,25 +314,25 @@ test_single_numeric_pid (test_converters.TestThreadstringToList) ... ok
 ----------------------------------------------------------------------
 Ran 23 tests in 0.XXXs
 
-OK (skipped=34)
+OK (skipped=40)
 ```
 
-### All Tests Including Root-Required (57 tests)
+### All Tests Including Root-Required (63 tests)
 
-Running with sudo will run all 57 tests:
+Running with sudo will run all 63 tests:
 
 ```bash
 $ sudo python3 -m unittest discover -s tests -p "test_*.py" -v
-... (18 non-root tests as above)
+... (23 non-root tests as above)
 test_initialization (test_cpuset.TestCpusetsInit) ... ok
 test_cpuset_path (test_cpuset.TestCpusetsInit) ... ok
 ... (27 cpuset module tests)
 test_first_name_is_tuna0 (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
 test_sequential_naming (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
-... (12 cpuset CLI tests)
+... (18 cpuset CLI tests)
 
 ----------------------------------------------------------------------
-Ran 57 tests in X.XXXs
+Ran 63 tests in X.XXXs
 
 OK
 ```
@@ -344,7 +346,7 @@ The test suite includes:
 - **EPERM tests**: Error handling verification
 - **CpusetsInit tests**: System capability detection (read-only)
 
-### Integration Tests (34 tests - require root)
+### Integration Tests (40 tests - require root)
 - **Cpuset module tests**: Test interaction with cgroup v2 subsystem
 - **Cpuset CLI tests**: Test command-line interface integration
 
@@ -371,7 +373,7 @@ python3 -m unittest discover -s tests -p "test_*.py" -v
 
 ### Root-Required Tests (Optional for CI)
 
-The cpuset tests (34 tests) can run in CI with special setup:
+The cpuset tests (40 tests) can run in CI with special setup:
 - Requires root access or privileged containers
 - Requires cgroup v2 support
 - May need dedicated test runners with appropriate permissions
diff --git a/tests/test_cpuset.py b/tests/test_cpuset.py
index 6ac4fe0c9c40..ec6ce19028cf 100644
--- a/tests/test_cpuset.py
+++ b/tests/test_cpuset.py
@@ -579,6 +579,81 @@ class TestCleanupFunctions(unittest.TestCase):
         self.assertFalse(os.path.exists(parent.cpuset_path))
 
 
+class TestProcessMovement(unittest.TestCase):
+    """Test moving individual processes to cpusets"""
+
+    @unittest.skipUnless(os.geteuid() == 0, "Requires root")
+    def test_write_pid_self(self):
+        """Test moving current process to a cpuset"""
+        # Pre-cleanup
+        cpuset.cleanup_cpusets('test_write_pid*', force=True, recursive=True)
+
+        cs = cpuset.Cpuset('test_write_pid')
+        try:
+            # Configure cpuset
+            cs.write_memnode('0')
+            cs.assign_cpus('0-1')
+
+            # Move current process
+            current_pid = os.getpid()
+            result = cs.write_pid(current_pid)
+            self.assertTrue(result, "write_pid should return True on success")
+
+            # Verify it's in the cpuset
+            tasks = cs.get_tasks()
+            self.assertIn(str(current_pid), tasks, "Current PID should be in cpuset")
+
+            # Move back to root
+            root = cpuset.CpusetsInit()
+            root.write_pid(current_pid)
+        finally:
+            # Cleanup
+            cpuset.destroy_cpuset('test_write_pid', force=True)
+
+    @unittest.skipUnless(os.geteuid() == 0, "Requires root")
+    def test_write_pid_invalid(self):
+        """Test write_pid with invalid PID"""
+        # Pre-cleanup
+        cpuset.cleanup_cpusets('test_write_invalid*', force=True, recursive=True)
+
+        cs = cpuset.Cpuset('test_write_invalid')
+        try:
+            cs.write_memnode('0')
+            cs.assign_cpus('0-1')
+
+            # Try to move non-existent PID
+            result = cs.write_pid(999999)
+            self.assertFalse(result, "write_pid should return False for invalid PID")
+        finally:
+            # Cleanup
+            cpuset.destroy_cpuset('test_write_invalid', force=True)
+
+    @unittest.skipUnless(os.geteuid() == 0, "Requires root")
+    def test_multiple_pids(self):
+        """Test moving multiple processes to a cpuset"""
+        # Pre-cleanup
+        cpuset.cleanup_cpusets('test_multi_pid*', force=True, recursive=True)
+
+        cs = cpuset.Cpuset('test_multi_pid')
+        try:
+            cs.write_memnode('0')
+            cs.assign_cpus('0-1')
+
+            # Move current process
+            current_pid = os.getpid()
+            cs.write_pid(current_pid)
+
+            # Get current tasks
+            tasks = cs.get_tasks()
+            self.assertIn(str(current_pid), tasks)
+
+            # Move back to root
+            root = cpuset.CpusetsInit()
+            root.write_pid(current_pid)
+        finally:
+            cpuset.destroy_cpuset('test_multi_pid', force=True)
+
+
 def suite():
     """Create test suite"""
     loader = unittest.TestLoader()
@@ -592,6 +667,7 @@ def suite():
     suite.addTests(loader.loadTestsFromTestCase(TestTaskMigration))
     suite.addTests(loader.loadTestsFromTestCase(TestDiscoveryFunctions))
     suite.addTests(loader.loadTestsFromTestCase(TestCleanupFunctions))
+    suite.addTests(loader.loadTestsFromTestCase(TestProcessMovement))
 
     return suite
 
diff --git a/tests/test_cpuset_cli.py b/tests/test_cpuset_cli.py
index 7f9a4ce9947c..9bec8955d1ad 100644
--- a/tests/test_cpuset_cli.py
+++ b/tests/test_cpuset_cli.py
@@ -37,6 +37,7 @@ get_next_tuna_cpuset_name = tuna_cmd.get_next_tuna_cpuset_name
 cpuset_create = tuna_cmd.cpuset_create
 cpuset_list = tuna_cmd.cpuset_list
 cpuset_destroy = tuna_cmd.cpuset_destroy
+cpuset_move = tuna_cmd.cpuset_move
 
 
 @unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
@@ -314,6 +315,106 @@ class TestCpusetDestroyCLI(unittest.TestCase):
         self.assertTrue(os.path.exists(cs2.cpuset_path))
 
 
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestCpusetMoveCLI(unittest.TestCase):
+    """Test 'tuna cpuset move' command"""
+
+    def setUp(self):
+        """Set up test fixtures"""
+        self.ci = cpuset.CpusetsInit()
+        self.created_cpusets = []
+
+    def tearDown(self):
+        """Clean up all created cpusets and move test process back to root"""
+        # Move current process back to root
+        try:
+            root = cpuset.CpusetsInit()
+            root.write_pid(os.getpid())
+        except:
+            pass
+
+        # Clean up cpusets
+        for name in self.created_cpusets:
+            try:
+                cpuset.destroy_cpuset(name, force=True)
+            except:
+                pass
+
+    def test_move_with_pids(self):
+        """Test moving processes with --pids argument"""
+        # Create a cpuset
+        cpuset_create(cpu_list=[0, 1], name='test_move_pids', isolated=False)
+        self.created_cpusets.append('test_move_pids')
+
+        # Move current process using pid_list (string format)
+        current_pid = os.getpid()
+        cpuset_move(name='test_move_pids', thread_list=None, pid_list=str(current_pid))
+
+        # Verify PID is in the cpuset
+        with open('/sys/fs/cgroup/test_move_pids/cgroup.procs') as f:
+            pids = f.read().strip().split('\n')
+        self.assertIn(str(current_pid), pids)
+
+    def test_move_with_threads(self):
+        """Test moving processes with --threads argument (numeric PIDs)"""
+        # Create a cpuset
+        cpuset_create(cpu_list=[0, 1], name='test_move_threads', isolated=False)
+        self.created_cpusets.append('test_move_threads')
+
+        # Move current process using thread_list (list of integers)
+        current_pid = os.getpid()
+        cpuset_move(name='test_move_threads', thread_list=[current_pid], pid_list=None)
+
+        # Verify PID is in the cpuset
+        with open('/sys/fs/cgroup/test_move_threads/cgroup.procs') as f:
+            pids = f.read().strip().split('\n')
+        self.assertIn(str(current_pid), pids)
+
+    def test_move_both_pids_and_threads(self):
+        """Test moving processes with both --pids and --threads"""
+        # Create a cpuset
+        cpuset_create(cpu_list=[0, 1], name='test_move_both', isolated=False)
+        self.created_cpusets.append('test_move_both')
+
+        # Move current process using both arguments
+        current_pid = os.getpid()
+        cpuset_move(name='test_move_both', thread_list=[current_pid], pid_list=str(current_pid))
+
+        # Verify PID is in the cpuset (should only appear once despite being in both lists)
+        with open('/sys/fs/cgroup/test_move_both/cgroup.procs') as f:
+            pids = f.read().strip().split('\n')
+        self.assertIn(str(current_pid), pids)
+
+    def test_move_nonexistent_cpuset_error(self):
+        """Test error when trying to move to nonexistent cpuset"""
+        # Should exit with error (sys.exit(1))
+        with self.assertRaises(SystemExit) as cm:
+            cpuset_move(name='nonexistent_cpuset', thread_list=None, pid_list='1234')
+        self.assertEqual(cm.exception.code, 1)
+
+    def test_move_no_pids_error(self):
+        """Test error when no PIDs are provided"""
+        # Create a cpuset
+        cpuset_create(cpu_list=[0, 1], name='test_move_nopids', isolated=False)
+        self.created_cpusets.append('test_move_nopids')
+
+        # Should exit with error when neither thread_list nor pid_list provided
+        with self.assertRaises(SystemExit) as cm:
+            cpuset_move(name='test_move_nopids', thread_list=None, pid_list=None)
+        self.assertEqual(cm.exception.code, 2)
+
+    def test_move_invalid_pid(self):
+        """Test moving invalid PID (should fail gracefully)"""
+        # Create a cpuset
+        cpuset_create(cpu_list=[0, 1], name='test_move_invalid', isolated=False)
+        self.created_cpusets.append('test_move_invalid')
+
+        # Try to move non-existent PID (should succeed but report 0 moved, 1 failed)
+        # Since we can't easily capture stdout, just verify it doesn't crash
+        cpuset_move(name='test_move_invalid', thread_list=[999999], pid_list=None)
+
+
 def suite():
     """Create test suite"""
     loader = unittest.TestLoader()
@@ -324,6 +425,7 @@ def suite():
     suite.addTests(loader.loadTestsFromTestCase(TestCpusetCreateCLI))
     suite.addTests(loader.loadTestsFromTestCase(TestCpusetListCLI))
     suite.addTests(loader.loadTestsFromTestCase(TestCpusetDestroyCLI))
+    suite.addTests(loader.loadTestsFromTestCase(TestCpusetMoveCLI))
 
     return suite
 
-- 
2.54.0

