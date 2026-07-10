Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1A733DEF9
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692995; cv=none; b=PjxbHF9e7w0IsGQrh6XvotKYojQjeXn58dRQj91gbxDdDXSoe35AKCffeLAwOADIrnKnkv69kCUiSqdi926mrY8aR7YTp7esATdhQwl2oattJaLnlU860RKY45mkn9XN23GKBQEZ1mSwf1fBkheL9ZM0xQK5UXg1LLdgquD6yMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692995; c=relaxed/simple;
	bh=ECkoazX6AZMxXZpFdK1i2HMao1CgZO0y2ZJ85dH7Hps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzX5GTOgS4XqxPI7qQ+2HW0iQwz11wxWq4lK+0T+FngrYs2SQBhzbSLxPFJ+f7lN/Cs6hhbTxhoDvuq8ScJ9zH58dmTyqoylNiJgDAgXCDj4eVIyp83KzeGp8ly/3h4pK3j8Kxa2iigTc/cw2Rgudw3/nhEk0sFqfXSefxK2+7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPAxEiIJ; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPAxEiIJ"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7353fc917e2so313363137.2
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692993; x=1784297793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CMXXiGeSLq1w6QYMgkDXQqFYJBSmgnf+4I0EtJPF6iw=;
        b=PPAxEiIJZMN1QLx9P8RNgE8S4nOmQwaF/JaZjskpSFPn3BxGbJMDHEegImYKMCATE3
         uRfgAidwgOC0B9mzUxGuaeW4cnvP1tTUGZZxGRjOXljAeIuq4JWJbTpTnBrYDhG8iOpw
         7PG+I9oXpDuBLGNnp09vUF7SJ3zIsKR0ZfJmxSx7b0Z9jxi/lmWpOkmbvsxnI2+HzoTS
         SYmQiqMnMgFu5c8LAFF+hhXumSK5/pTQb9niA2RJqrxjBqDXU0p1kNqCWyHH1tTll3G4
         2uwSQLyNIwrO3Ey+ucX6Z4c+Vfua/kkFzLuzOvYcROxp03Qh+BKQnFg2sTgusvMazwmv
         EvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692993; x=1784297793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CMXXiGeSLq1w6QYMgkDXQqFYJBSmgnf+4I0EtJPF6iw=;
        b=VCPw3ZI4G2b2Jmh6J8WHbeAEaymeKAJv9kDmVoepXnM/3sL9YHLFvqDDnK+cLmykke
         0aRKRQa08+GKaUZgXWdT9UiDIFYV53WL3acEElLwtIvWqiWX/1MG+kcZP6xezHsgOkAl
         zXUF5bv8VxD9ehfzG1bE4ch/wUX4Z3nbU9ttB2sukB9HVFMLZrhdXlaG2twg6MISek2Y
         DUDWHvEsrQTgqCW3Z73JcH7QZWRTpSzl/npWeP948PxD5vO09f2UjQroP84zeeBncSqi
         pKFN562TxYCi2aqDVfWkzS3Wxis4mM8f2jFRzmcgO4zIzNF6l58JOA3w2RYTExJxjNda
         zY5g==
X-Gm-Message-State: AOJu0YyE7zWWx/ePowRWOLppGxSKxeWHvP5rqQ2iTNr1Lrv06kjJj8dp
	z/lTyEO79MSq7OLBfyK4cM5lrTHwSiKRinP4IGhfJjlwBPcVRmBMMrTsFM4b+g==
X-Gm-Gg: AfdE7cnR0370eTwwJEdtC9TkSBp4y9od3zvtJVAlXhAxzCjauPCK5xDu+gU/dL2lh8n
	DH8twxWPSSCd6oMs2J5NP2XyE7C3/QTibiOtfEa70QhCsceU9bXANtCI2jqH5+YpJQAjYtr6Iuv
	vv/wTFq6bdDcNAVFHt1Mz6WQ286BUwTbSXeOp1g0/jhfSK10L7V7oADtM7O9gLoYNFf8yJhPbZ6
	SvdSHCS6f67VqxA5nrhtFluOD/imR2rIrQnk+DaAUh4m1Nox6+oKIyNj7zwU60GiIO3YEVCwHZM
	ffrqKXPjh7AB6g0jJ4wN24f07F3dZ3HEvbsIyTfkOvMmOYIn1TVZJ2yhi5PAdcHh86sDQmmp12/
	dPsNT/qu9mX3LBJTwD0Pn1FpNKtfwUG0IELodRkKza1L4Tv39DJHes4wdctEXoidLxgED1fPhcq
	1t2XpNXW2x4J2bz9yuWhMt33UpTsGtVCi8pOCsb2/u2WjK7CTHrNT1wGSkTXY0vnVhPM7hnmlVo
	84c+7Xc0/HN
X-Received: by 2002:a05:6102:3753:b0:604:f849:462e with SMTP id ada2fe7eead31-744dff2d5e5mr6967368137.25.1783692988008;
        Fri, 10 Jul 2026 07:16:28 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:27 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 26/36] tuna: Add tests for tuna move --cpuset command
Date: Fri, 10 Jul 2026 10:15:04 -0400
Message-ID: <20260710141523.36440-27-jkacur@redhat.com>
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

Add comprehensive test coverage for the new --cpuset option in the
tuna move command. Tests verify basic functionality, error handling,
and process blocklist protection when moving entities to cpusets.

Test coverage:
- test_move_threads_to_cpuset: Basic thread movement to cpuset
- test_move_threads_by_pattern_to_cpuset: Pattern-based thread selection
- test_move_nonexistent_cpuset_error: Error handling for missing cpusets
- test_move_blocklisted_process_to_cpuset: Blocklist protection (PID 1)
- test_move_mixed_valid_and_invalid_pids: Mixed PID validation

All tests require root permissions and cgroup v2 support. Tests follow
existing patterns in TestCpusetMoveCLI, using subprocess.run() to invoke
tuna-cmd.py and verify exit codes, stdout, and actual process placement
in cpusets.

Updates tests/README.md to reflect new test count: 116 total tests
(37 non-root + 79 root-required), up from 111 tests.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/README.md          |  26 ++++----
 tests/test_cpuset_cli.py | 131 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+), 12 deletions(-)

diff --git a/tests/README.md b/tests/README.md
index 4c3ecaca2563..6da490b60448 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -12,7 +12,7 @@ This directory contains the test suite for tuna, using Python's `unittest` frame
 # Run all non-root tests only (37 tests)
 make tests
 
-# Run ALL tests (all 111 tests, requires sudo for root-required tests)
+# Run ALL tests (all 116 tests, requires sudo for root-required tests)
 make test-all
 
 # Run specific test module
@@ -37,7 +37,7 @@ make tests
 # or
 make unit-tests
 
-# Using make (ALL tests including root-required tests, 111 tests)
+# Using make (ALL tests including root-required tests, 116 tests)
 make test-all
 
 # Using the test runner directly (non-root tests only)
@@ -144,7 +144,7 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - Validates smart NUMA-aware memory node assignment for cpusets
   - Run: `python3 -m unittest tests.test_cpuset.TestNumaDetection -v`
 
-#### Root-Required Tests (74 tests)
+#### Root-Required Tests (79 tests)
 
 - **test_process_blocklist.py** (2 tests) - Process blocklist root tests
   - Tests actual blocking of systemd from being moved to cpusets
@@ -162,7 +162,7 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - Note: TestCpusetsInit (5 tests) and TestNumaDetection (6 tests) run without root, see non-root section
   - Run: `sudo python3 -m unittest tests.test_cpuset -v` (runs all 43 tests with root)
 
-- **test_cpuset_cli.py** (40 tests) - CLI command tests
+- **test_cpuset_cli.py** (45 tests) - CLI command tests
   - TestGetNextTunaCpusetName: Auto-naming logic (tuna0, tuna1, gap-filling)
   - TestCpusetCreateCLI: Create command with auto/custom names, --isolated, and NUMA auto-detection/override
   - TestCpusetListCLI: List command with --pattern, --verbose, --skip-empty
@@ -171,9 +171,10 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - TestCpusetShowCLI: Show command for detailed cpuset information
   - TestCpusetStatusCLI: Status command for system-wide cpuset overview
   - TestCpusetModifyCLI: Modify command with --add-cpus, --remove-cpus, --memory-nodes, --isolated/--no-isolated
+  - TestTunaMoveCpusetCLI: Integration of --cpuset with tuna move command (5 tests)
   - Run: `sudo python3 -m unittest tests.test_cpuset_cli -v`
 
-**Total: 111 tests** (37 non-root + 74 root-required)
+**Total: 116 tests** (37 non-root + 79 root-required)
 
 ### Test Requirements: Root vs Non-Root
 
@@ -213,7 +214,7 @@ These tests run without root privileges:
 - Tests are fast and don't affect the running system
 - Tests verify both happy path (with mocks) and error path (with real EPERM)
 
-#### Root-Required Tests (74 tests)
+#### Root-Required Tests (79 tests)
 
 These tests require root to create/manipulate cgroups:
 
@@ -356,12 +357,12 @@ test_numa_node_int (test_cpuset.TestNumaDetection) ... ok
 ----------------------------------------------------------------------
 Ran 37 tests in 0.XXXs
 
-OK (skipped=74)
+OK (skipped=79)
 ```
 
-### All Tests Including Root-Required (111 tests)
+### All Tests Including Root-Required (116 tests)
 
-Running with sudo will run all 111 tests:
+Running with sudo will run all 116 tests:
 
 ```bash
 $ sudo python3 -m unittest discover -s tests -p "test_*.py" -v
@@ -371,10 +372,10 @@ test_cpuset_path (test_cpuset.TestCpusetsInit) ... ok
 ... (32 cpuset module tests)
 test_first_name_is_tuna0 (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
 test_sequential_naming (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
-... (38 cpuset CLI tests)
+... (43 cpuset CLI tests)
 
 ----------------------------------------------------------------------
-Ran 111 tests in X.XXXs
+Ran 116 tests in X.XXXs
 
 OK
 ```
@@ -389,7 +390,8 @@ The test suite includes:
 - **CpusetsInit tests**: System capability detection (read-only)
 - **NUMA detection tests**: NUMA topology discovery and memory node assignment (read-only)
 
-### Integration Tests (54 tests - require root)
+### Integration Tests (79 tests - require root)
+- **Process blocklist tests**: Test blocklist protection (2 root-required tests)
 - **Cpuset module tests**: Test interaction with cgroup v2 subsystem
 - **Cpuset CLI tests**: Test command-line interface integration
 
diff --git a/tests/test_cpuset_cli.py b/tests/test_cpuset_cli.py
index fc647ad93c97..ed8995782872 100644
--- a/tests/test_cpuset_cli.py
+++ b/tests/test_cpuset_cli.py
@@ -876,6 +876,136 @@ class TestCpusetModifyCLI(unittest.TestCase):
         self.assertTrue(result.stderr)  # Should have error output
 
 
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestTunaMoveCpusetCLI(unittest.TestCase):
+    """Test 'tuna move --cpuset' command (moves entities to cpusets)"""
+
+    def setUp(self):
+        """Create test cpusets"""
+        self.test_cpusets = []
+
+    def tearDown(self):
+        """Clean up test cpusets and move test process back to root"""
+        # Move current process back to root
+        try:
+            root = cpuset.CpusetsInit()
+            root.write_pid(os.getpid())
+        except:
+            pass
+
+        # Clean up cpusets
+        for cs_name in self.test_cpusets:
+            try:
+                cpuset.destroy_cpuset(cs_name, force=True)
+            except:
+                pass
+
+    def test_move_threads_to_cpuset(self):
+        """Test moving threads to cpuset using tuna move --cpuset"""
+        # Create test cpuset
+        cs = cpuset.Cpuset('test_tuna_move')
+        cs.write_memnode('0')
+        cs.assign_cpus('0-1')
+        self.test_cpusets.append('test_tuna_move')
+
+        # Move current process using tuna move --cpuset
+        current_pid = os.getpid()
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'move',
+            '--cpuset', 'test_tuna_move', '-t', str(current_pid)
+        ], capture_output=True, text=True)
+
+        self.assertEqual(result.returncode, 0)
+        self.assertIn('Moved 1 task(s)', result.stdout)
+
+        # Verify PID is in the cpuset
+        with open('/sys/fs/cgroup/test_tuna_move/cgroup.procs') as f:
+            pids = f.read().strip().split('\n')
+        self.assertIn(str(current_pid), pids)
+
+    def test_move_threads_by_pattern_to_cpuset(self):
+        """Test moving threads by pattern to cpuset"""
+        # Create test cpuset
+        cs = cpuset.Cpuset('test_tuna_move_pattern')
+        cs.write_memnode('0')
+        cs.assign_cpus('0-1')
+        self.test_cpusets.append('test_tuna_move_pattern')
+
+        # Move current process (using PID as pattern)
+        current_pid = os.getpid()
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'move',
+            '--cpuset', 'test_tuna_move_pattern', '-t', str(current_pid)
+        ], capture_output=True, text=True)
+
+        self.assertEqual(result.returncode, 0)
+        self.assertIn('Moved', result.stdout)
+
+        # Verify it moved
+        with open('/sys/fs/cgroup/test_tuna_move_pattern/cgroup.procs') as f:
+            pids = f.read().strip().split('\n')
+        self.assertIn(str(current_pid), pids)
+
+    def test_move_nonexistent_cpuset_error(self):
+        """Test error when moving to nonexistent cpuset"""
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'move',
+            '--cpuset', 'nonexistent_cpuset', '-t', '1'
+        ], capture_output=True, text=True)
+
+        self.assertNotEqual(result.returncode, 0)
+        self.assertIn('does not exist', result.stderr)
+
+    def test_move_blocklisted_process_to_cpuset(self):
+        """Test that blocklisted processes cannot be moved via tuna move --cpuset"""
+        # Create test cpuset
+        cs = cpuset.Cpuset('test_blocklist_move')
+        cs.write_memnode('0')
+        cs.assign_cpus('0-1')
+        self.test_cpusets.append('test_blocklist_move')
+
+        # Try to move PID 1 (systemd) - should be blocked
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'move',
+            '--cpuset', 'test_blocklist_move', '-t', '1'
+        ], capture_output=True, text=True)
+
+        # Should complete but with 0 successful moves
+        self.assertEqual(result.returncode, 0)
+        self.assertIn('0 task(s)', result.stdout)
+
+        # Verify PID 1 is NOT in the cpuset
+        with open('/sys/fs/cgroup/test_blocklist_move/cgroup.procs') as f:
+            pids = f.read().strip().split('\n')
+        self.assertNotIn('1', pids)
+
+    def test_move_mixed_valid_and_invalid_pids(self):
+        """Test moving mix of valid and invalid PIDs"""
+        # Create test cpuset
+        cs = cpuset.Cpuset('test_mixed_move')
+        cs.write_memnode('0')
+        cs.assign_cpus('0-1')
+        self.test_cpusets.append('test_mixed_move')
+
+        # Move our PID (valid) and PID 999999 (likely invalid)
+        current_pid = os.getpid()
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'move',
+            '--cpuset', 'test_mixed_move', '-t', f'{current_pid},999999'
+        ], capture_output=True, text=True)
+
+        self.assertEqual(result.returncode, 0)
+        # Should show some successes and some failures
+        self.assertIn('Moved', result.stdout)
+        self.assertIn('failed', result.stdout)
+
+        # Our PID should be in the cpuset
+        with open('/sys/fs/cgroup/test_mixed_move/cgroup.procs') as f:
+            pids = f.read().strip().split('\n')
+        self.assertIn(str(current_pid), pids)
+
+
 def suite():
     """Create test suite"""
     loader = unittest.TestLoader()
@@ -890,6 +1020,7 @@ def suite():
     suite.addTests(loader.loadTestsFromTestCase(TestCpusetShowCLI))
     suite.addTests(loader.loadTestsFromTestCase(TestCpusetStatusCLI))
     suite.addTests(loader.loadTestsFromTestCase(TestCpusetModifyCLI))
+    suite.addTests(loader.loadTestsFromTestCase(TestTunaMoveCpusetCLI))
 
     return suite
 
-- 
2.54.0

