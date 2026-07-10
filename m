Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3BF345CDD
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693004; cv=none; b=CZUixvU+9Pt7IvIngSBRu2Gr1TOxSi7fIV6CFtsSq7voQdwn3FHzDnGmbMPqbKl40Sbtkitr2TyeYtrNMGr/rC4jd3T8EDBT9yoMxvS7x8tUJjuJijiIQNQVl5uM6lnhswtNskPZyCG4Ms5WMQK1wFQqVSSowLSl65vXV+zl4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693004; c=relaxed/simple;
	bh=j/e4ejBrX0Y1jTokqEQ3wivax8qCHMjDBuRjiYnZmvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bzgb7jTliwom6shlE6SODf1gP22Kvbj8rmnxNQxk60OQBACYYfiiuE5x1FdDPelJ+Bp4oG3URTYHI/6RHyyY5QIemh3STmrFxKmtzHKZAloJggd7Xfj/Mq2i8A+XVrewBEIkPYCn51x8U0BS6NP0HBPPzRSOI4PyxnrzslKe9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jnao4t9E; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jnao4t9E"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-9618b8bdc51so325636241.1
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783693002; x=1784297802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/iKk3y3XQwneOPKvxeNiIfPIsg0l/PtJ5upCgm1lJSM=;
        b=Jnao4t9EIIdNngdts6ETLxaQw0nr/wCzovMYjNsULBvNdtRzpTk9sRNyB/Q8SAeNWL
         ULpb/jFYs5wACEKGVjxy4aL8RMj6tQ2DK9RYNAQi7Ud4gKWQCEmz0m/B+3+c7TefANV6
         GYqKGcwbVcrwiKsEfr2NNx/EW1FkIOCB7aGI4BEilhKPVO9w1bL3HnFBNwKgL+QPed8K
         648UykMNVUhlNN7vFP+5YUm0g4WBquxcOnSKfaHoW2Ff/jUPZyjLYHL27M2iHvN3P8TP
         tOd6nleh4l65d2cVZYBTya0CtTiUpJCFaK9KpbRo8JUY0pTltDExscbIUYIkrpFUEFlf
         8LEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783693002; x=1784297802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/iKk3y3XQwneOPKvxeNiIfPIsg0l/PtJ5upCgm1lJSM=;
        b=FmhkcLAZPv1GCHizErpBE71UpFloWoHyNbORbLvNFhuc6H8PYUrcM3gErXWFnH/f3U
         nURPWE+uG2dJvNtkcB/LJaDsw0HgRvE0Igo3BQLpaJz0kKl3ZpI0i/PTI8wsentMFVth
         Zzx5ZXyqrslv0UaE3p66uiQ0TgpcWe8uuUDKYZ9P560h7ueBRK7xhC4/NBChS7WBjkyK
         Bh1qMvHzXvMd5T/6zk3DNAKmOmip/a0BWOjx8g/qscuZQZXrinpZtLZd0xzoMd4vJdKY
         Wut1Ki5DXtvXinfhTOsbsKKj1g3sle0IaS6pCzLJzVTb7FpPyP1zjMyy9Fq8ArZlPBox
         RNuQ==
X-Gm-Message-State: AOJu0YwmSYLKAL+iZl+2yHnuejUcLOMw5GxeoADrcHT5hGrK8/eFzNnR
	yNYqReJr1vpC1wnnEWOWUYbVBCzpOYPk45rXNtvuY81oZ5wY6kLDg6DI52xxEA==
X-Gm-Gg: AfdE7cko/ydjCQIvc/5b6H/YluKXGUNtPJivWwYytSLhYs2xtGaRnkorzi67MrznddA
	Rb5QhXs/vtNybk61mMmErCq0uegA4TjYK3iZbSNh/Q2RDyySec5U2aBUY3VV7Q/6wMoljyPv2pQ
	z219rBSdL+e6DHrtKt3meoMChQVqjXbKHiyJ5h6qRFWubImoR3nA/SXwCxYIv3DU85JrhJ8W4JH
	0FURowiQ9PbtNhQZ5o144ATQNcfGhj80weYkoBk63Cb7K8SQHDDQIsrE6TiXz2AnKFGWZaJRSB9
	U95WVXw57U/jyLM0CwXhZVqApF7G3GuBP4Ol2z0qv1f4lzErIE+q1sd6N6+FUanQJqgzrcnvifa
	YFdVm9JQWFdqELlqlb314fH/FPYx6YrZKscOJOjEts0mO1NjwgbumRZx/at5G0o1M8tPmnMTmVd
	sGJUlZQTehebJHEOvzOHfLxzIzcAzshr7GbXxK3uzae92Xc28XcYzIa8DM79UYRNTNDhEmjomAc
	w==
X-Received: by 2002:a05:6102:6a85:b0:739:4470:db with SMTP id ada2fe7eead31-744e01684e9mr6732210137.21.1783693001787;
        Fri, 10 Jul 2026 07:16:41 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:41 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 35/36] tuna: Add tests for run --cpuset functionality
Date: Fri, 10 Jul 2026 10:15:13 -0400
Message-ID: <20260710141523.36440-36-jkacur@redhat.com>
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

Add comprehensive test coverage for the tuna run --cpuset feature,
which allows launching processes directly in cpusets.

Test coverage includes:
- test_run_with_cpuset_basic: Verifies running commands in cpusets
- test_run_with_cpuset_and_priority: Tests combining cpuset with
  priority settings (FIFO:50)
- test_run_with_nonexistent_cpuset: Tests error handling for
  non-existent cpusets
- test_run_cpuset_mutually_exclusive_with_cpus: Tests mutual
  exclusivity with -c option
- test_run_help_shows_cpuset_option: Verifies --cpuset appears
  in help output

Also updates:
- Makefile: Adds test-run-cpuset target for running these tests
- tests/README.md: Updates test counts from 142 to 146 total tests
  (45 non-root + 101 root-required), documents the new test class

All tests require root permissions and cgroup v2 support. Tests
create temporary cpusets, run commands, verify behavior, and clean up.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                 |  5 +-
 tests/README.md          | 36 +++++++++------
 tests/test_cpuset_cli.py | 99 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index b68c2a2a9925..9bee6cd24c1a 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ cleanlogs:
 .PHONY: clean
 clean: pyclean
 
-.PHONY: tests unit-tests test-eperm test-converters test-cpuset test-cpuset-cli test-isolate-cpuset test-show-threads-cpuset test-show-threads-cgroups test-all
+.PHONY: tests unit-tests test-eperm test-converters test-cpuset test-cpuset-cli test-isolate-cpuset test-run-cpuset test-show-threads-cpuset test-show-threads-cgroups test-all
 tests: unit-tests
 
 unit-tests:
@@ -42,6 +42,9 @@ test-cpuset-cli:
 test-isolate-cpuset:
 	@sudo python3 -m unittest tests.test_cpuset_cli.TestTunaIsolateCpusetCLI -v
 
+test-run-cpuset:
+	@sudo python3 -m unittest tests.test_cpuset_cli.TestTunaRunCpusetCLI -v
+
 test-show-threads-cpuset:
 	@sudo python3 -m unittest tests.test_show_threads_cpuset -v
 
diff --git a/tests/README.md b/tests/README.md
index 799fc1ffe2dd..3e8b84a81fd4 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -12,7 +12,7 @@ This directory contains the test suite for tuna, using Python's `unittest` frame
 # Run all non-root tests only (45 tests)
 make tests
 
-# Run ALL tests (all 142 tests, requires sudo for root-required tests)
+# Run ALL tests (all 146 tests, requires sudo for root-required tests)
 make test-all
 
 # Run specific test module
@@ -37,7 +37,7 @@ make tests
 # or
 make unit-tests
 
-# Using make (ALL tests including root-required tests, 142 tests)
+# Using make (ALL tests including root-required tests, 146 tests)
 make test-all
 
 # Using the test runner directly (non-root tests only)
@@ -63,6 +63,7 @@ make test-converters
 make test-cpuset
 make test-cpuset-cli
 make test-isolate-cpuset
+make test-run-cpuset
 make test-show-threads-cpuset
 make test-show-threads-cgroups
 
@@ -167,7 +168,7 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - Tests edge cases: empty string and None inputs
   - Run: `python3 -m unittest tests.test_show_threads_cgroups.TestExtractCpusetName -v`
 
-#### Root-Required Tests (97 tests)
+#### Root-Required Tests (102 tests)
 
 - **test_process_blocklist.py** (2 tests) - Process blocklist root tests
   - Tests actual blocking of systemd from being moved to cpusets
@@ -185,7 +186,7 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - Note: TestCpusetsInit (5 tests) and TestNumaDetection (6 tests) run without root, see non-root section
   - Run: `sudo python3 -m unittest tests.test_cpuset -v` (runs all 43 tests with root)
 
-- **test_cpuset_cli.py** (45 tests) - CLI command tests
+- **test_cpuset_cli.py** (50 tests) - CLI command tests
   - TestGetNextTunaCpusetName: Auto-naming logic (tuna0, tuna1, gap-filling)
   - TestCpusetCreateCLI: Create command with auto/custom names, --isolated, and NUMA auto-detection/override
   - TestCpusetListCLI: List command with --pattern, --verbose, --skip-empty
@@ -199,6 +200,12 @@ Tests are organized using Python's `unittest` framework. Each test file contains
     - Tests cpuset-based CPU isolation with isolated and housekeeping cpusets
     - Verifies partition types, CPU assignments, and process migration
     - Tests error handling and backward compatibility
+  - TestTunaRunCpusetCLI: Integration of --cpuset with tuna run command (5 tests)
+    - test_run_with_cpuset_basic: Verifies running commands in cpusets
+    - test_run_with_cpuset_and_priority: Tests combining cpuset with priority settings
+    - test_run_with_nonexistent_cpuset: Tests error handling for non-existent cpusets
+    - test_run_cpuset_mutually_exclusive_with_cpus: Tests mutual exclusivity with -c
+    - test_run_help_shows_cpuset_option: Verifies --cpuset appears in help
   - Run: `sudo python3 -m unittest tests.test_cpuset_cli -v`
 
 - **test_show_threads_cpuset.py** (6 tests) - show_threads --cpuset filter tests
@@ -219,7 +226,7 @@ Tests are organized using Python's `unittest` framework. Each test file contains
     - test_cgroups_displays_system_slice_shortened: Verifies system.slice shows shortened name
   - Run: `sudo python3 -m unittest tests.test_show_threads_cgroups.TestShowThreadsCgroupsDisplay -v`
 
-**Total: 142 tests** (45 non-root + 97 root-required)
+**Total: 146 tests** (45 non-root + 101 root-required)
 
 ### Test Requirements: Root vs Non-Root
 
@@ -268,7 +275,7 @@ These tests run without root privileges:
 - Tests are fast and don't affect the running system
 - Tests verify both happy path (with mocks) and error path (with real EPERM)
 
-#### Root-Required Tests (97 tests)
+#### Root-Required Tests (102 tests)
 
 These tests require root to create/manipulate cgroups:
 
@@ -278,7 +285,7 @@ These tests require root to create/manipulate cgroups:
    - Test task migration between cpusets
    - All tests clean up created cpusets in tearDown()
 
-2. **Cpuset CLI tests** (45 tests) test command-line interface functions
+2. **Cpuset CLI tests** (50 tests) test command-line interface functions
    - Test cpuset create/list/destroy/move/show/status/modify commands
    - Verify auto-naming logic (tuna0, tuna1, etc.)
    - Test NUMA-aware memory node auto-detection and manual override
@@ -287,6 +294,7 @@ These tests require root to create/manipulate cgroups:
    - Test cpuset modification with --add-cpus, --remove-cpus, --memory-nodes, --isolated
    - Test tuna move --cpuset integration (5 tests)
    - Test tuna isolate --cpuset integration (8 tests) - cpuset-based CPU isolation
+   - Test tuna run --cpuset integration (5 tests) - running commands in cpusets
    - All tests clean up created cpusets afterwards
 
 3. **show_threads --cpuset filter tests** (6 tests) test process filtering by cpuset
@@ -435,12 +443,12 @@ test_extract_cpuset_name_none (test_show_threads_cgroups.TestExtractCpusetName)
 ----------------------------------------------------------------------
 Ran 45 tests in 0.XXXs
 
-OK (skipped=97)
+OK (skipped=102)
 ```
 
-### All Tests Including Root-Required (142 tests)
+### All Tests Including Root-Required (146 tests)
 
-Running with sudo will run all 142 tests:
+Running with sudo will run all 146 tests:
 
 ```bash
 $ sudo python3 -m unittest discover -s tests -p "test_*.py" -v
@@ -450,12 +458,12 @@ test_cpuset_path (test_cpuset.TestCpusetsInit) ... ok
 ... (32 cpuset module tests)
 test_first_name_is_tuna0 (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
 test_sequential_naming (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
-... (45 cpuset CLI tests)
+... (50 cpuset CLI tests)
 ... (6 show_threads --cpuset tests)
 ... (4 show_threads -G display tests)
 
 ----------------------------------------------------------------------
-Ran 142 tests in X.XXXs
+Ran 146 tests in X.XXXs
 
 OK
 ```
@@ -472,7 +480,7 @@ The test suite includes:
 - **show_threads --cpuset help test**: CLI documentation verification (read-only)
 - **Cpuset name extraction tests**: Cgroup path parsing logic (pure function testing)
 
-### Integration Tests (97 tests - require root)
+### Integration Tests (102 tests - require root)
 - **Process blocklist tests**: Test blocklist protection (2 root-required tests)
 - **Cpuset module tests**: Test interaction with cgroup v2 subsystem
 - **Cpuset CLI tests**: Test command-line interface integration
@@ -502,7 +510,7 @@ python3 -m unittest discover -s tests -p "test_*.py" -v
 
 ### Root-Required Tests (Optional for CI)
 
-The cpuset tests (97 tests) can run in CI with special setup:
+The cpuset tests (102 tests) can run in CI with special setup:
 - Requires root access or privileged containers
 - Requires cgroup v2 support
 - May need dedicated test runners with appropriate permissions
diff --git a/tests/test_cpuset_cli.py b/tests/test_cpuset_cli.py
index cc51428cc55b..c95cea29b4a3 100644
--- a/tests/test_cpuset_cli.py
+++ b/tests/test_cpuset_cli.py
@@ -1195,6 +1195,104 @@ class TestTunaIsolateCpusetCLI(unittest.TestCase):
         self.assertFalse(os.path.exists('/sys/fs/cgroup/tuna_housekeeping'))
 
 
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestTunaRunCpusetCLI(unittest.TestCase):
+    """Test tuna run --cpuset command"""
+
+    def setUp(self):
+        """Clean up before each test"""
+        self.test_cpuset = 'test_run_cpuset'
+        try:
+            cpuset.destroy_cpuset(self.test_cpuset, force=True)
+        except:
+            pass
+
+    def tearDown(self):
+        """Clean up after each test"""
+        try:
+            cpuset.destroy_cpuset(self.test_cpuset, force=True)
+        except:
+            pass
+
+    def test_run_with_cpuset_basic(self):
+        """Test running a command in a cpuset"""
+        # Create test cpuset
+        cs = cpuset.Cpuset(self.test_cpuset)
+        cs.assign_cpus('0-1')
+        cs.write_memnode('0')
+
+        # Run a simple command in the cpuset
+        result = subprocess.run(
+            [sys.executable, 'tuna-cmd.py', 'run', '--cpuset', self.test_cpuset, 'echo hello'],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertEqual(result.returncode, 0)
+        self.assertIn('hello', result.stdout)
+
+    def test_run_with_cpuset_and_priority(self):
+        """Test running a command with both cpuset and priority"""
+        # Create test cpuset
+        cs = cpuset.Cpuset(self.test_cpuset)
+        cs.assign_cpus('0-1')
+        cs.write_memnode('0')
+
+        # Run command with priority
+        result = subprocess.run(
+            [sys.executable, 'tuna-cmd.py', 'run', '--cpuset', self.test_cpuset,
+             '-p', 'FIFO:50', 'echo priority test'],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertEqual(result.returncode, 0)
+        self.assertIn('priority test', result.stdout)
+
+    def test_run_with_nonexistent_cpuset(self):
+        """Test error handling for non-existent cpuset"""
+        result = subprocess.run(
+            [sys.executable, 'tuna-cmd.py', 'run', '--cpuset', 'nonexistent_cpuset', 'echo test'],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertNotEqual(result.returncode, 0)
+        self.assertIn('does not exist', result.stderr)
+
+    def test_run_cpuset_mutually_exclusive_with_cpus(self):
+        """Test that --cpuset and -c are mutually exclusive"""
+        # Create test cpuset
+        cs = cpuset.Cpuset(self.test_cpuset)
+        cs.assign_cpus('0-1')
+        cs.write_memnode('0')
+
+        # Try to use both --cpuset and -c
+        result = subprocess.run(
+            [sys.executable, 'tuna-cmd.py', 'run', '--cpuset', self.test_cpuset,
+             '-c', '0-1', 'echo test'],
+            capture_output=True,
+            text=True
+        )
+
+        # Should fail with error about mutually exclusive arguments
+        self.assertNotEqual(result.returncode, 0)
+        self.assertIn('not allowed with argument', result.stderr)
+
+    def test_run_help_shows_cpuset_option(self):
+        """Test that --cpuset option appears in help"""
+        result = subprocess.run(
+            [sys.executable, 'tuna-cmd.py', 'run', '--help'],
+            capture_output=True,
+            text=True
+        )
+
+        self.assertEqual(result.returncode, 0)
+        self.assertIn('--cpuset', result.stdout)
+        self.assertIn('Run process in specified cpuset', result.stdout)
+
+
 def suite():
     """Create test suite"""
     loader = unittest.TestLoader()
@@ -1211,6 +1309,7 @@ def suite():
     suite.addTests(loader.loadTestsFromTestCase(TestCpusetModifyCLI))
     suite.addTests(loader.loadTestsFromTestCase(TestTunaMoveCpusetCLI))
     suite.addTests(loader.loadTestsFromTestCase(TestTunaIsolateCpusetCLI))
+    suite.addTests(loader.loadTestsFromTestCase(TestTunaRunCpusetCLI))
 
     return suite
 
-- 
2.54.0

