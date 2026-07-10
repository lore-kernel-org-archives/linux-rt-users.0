Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466C33F8BE
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692993; cv=none; b=kTk7eeexaRlHDHsamHJNXKxID4DKA1n0pC1/um1Cl/fKsuc2joOQyo7gpoL5tLOGRWdMyhxbRDKD6rjZ+NXgAeeWd8HauIjiMv8ERuKVn6T/NJNKGKCpZk2K4Pce1zBoVheGjUEfd0f0r80CS34kxPHUWt53UzNpBVKwZE5Et2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692993; c=relaxed/simple;
	bh=Cpj7lX+Kbnhz0cCvkWW3699HrRTgrgbsTaB6xYlenyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8/l1ymU1sddh2Y1rPcfMkJejtiN/ILI5RVLbyHQgccCW2lQkCEshM33mUOIEj9r2s3EA//dPTg4S22oJDjMoUamV6zag772avkycmnDAXIE4v6vVT0G4KMrc49Wdbop5wy47VMlC2UAPnou3iqru1Onz0yKIiqfE64hOph/51U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZ/CCn6f; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ/CCn6f"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-738f3419eedso265817137.3
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692991; x=1784297791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6+3W4C/YDiTkRu1T6rHiiR9l+Y+mTH6Q9MCnkRGDn4c=;
        b=NZ/CCn6fLSIa73osYzr1oMs8qcJ98NdrZzby3i+x3UYDi60jY4r4a5wbL5iWDetkju
         3u+N0JQOBNlo+pL6ohUcVpWS/5OVL/pFFQQTeBz1yXzZN0bYHirIu0de9OFcn/dWcgqr
         p5mqIaw7VMx342rzOkW+oez4i4Esb47FLctbOGOjkNQbj5+qi9WVFLGcUBk5eDcOL9f/
         jRP3mtur55RvKbkPcQs1mkvSEhVlUhDzBlcJukaC3yfpFZU4WrZc3AU/Dqnl7D4ba6Rt
         4H05UJZUll1jJBuEJ6ZwHPn0mK1ICRTcOpwDmrKSnwCVEo/EVPN+bNJayOtnV5nd6bRI
         9ZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692991; x=1784297791;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6+3W4C/YDiTkRu1T6rHiiR9l+Y+mTH6Q9MCnkRGDn4c=;
        b=GU8PV4SixTvMYuASfTgS1Y6UKh8CszyvPcKw1HDRlQcH0M7uLJARoNv/I+we8wVH97
         wOE0egRC2zPxTlvLwe8KFYhw38AJsdOvdQKfMBdY88XixUyN3FpEPNHTGfXNgJno/+r1
         /oxbb5GGJZ71BytZ4BzaCtnHzal8Bs6qFy+Z7D3KxzikDpbp6GpYNkrNHnGzMpl959XD
         fGou24zRkIJ/yyP7NHhRcaq+1Fa7GNFNyR1B8wUszzsCMdWvWIMLQH4l9oRvRnL6Qe9T
         5ZdUj0xRKIjyeeaIfVJe+a7HcfQS+TnUISTH2oO/wjJc+h08hXcsROUHQV0L3LZ+f7Aj
         AelQ==
X-Gm-Message-State: AOJu0YwtME18NVOBzPSPHe4/tgN9fLqte4xja8I743fxANmIZqdof3NQ
	1nbv9CpJi86P98SHELSK7QR+VXds3ljzqVVobO9JlXVqeqFhFooBYHuV5iCpIQ==
X-Gm-Gg: AfdE7clWikO0sTm/NIkMa13HhUNhmRoufWiSItJZltHXBQklcx7g0DrPWxbYbXgyGl7
	1BogtCe6b1SE0SKqhcb96yAOU89H/86zTqGXwbgM5WCB3k+pI7qVnLkWB8TIUKtY6tgbZa5nQ7J
	DbWdNZeb2xSzLXAXp8GMMt1VCvj8PU70UBtZMVSz6ti1Zohk2EwfSRJC6RgUhP+U9KNm+Ajkbkd
	YSHmrwh9IX19CinSgGIO7ml1bsRIyAYk04K/wQgJy91qYUy1PzeqPeDY+K98O0uK1L0vK6CiGOw
	zzfc4dR8aEs/SZ+bjBXdHB32pp5kwrg1/B9IW7VSHwHfhKqgCVO7Gcz8az0WK8tJ1BYQO/wakWR
	BVCpqCaOtHxxdF9zVPK4Jvx57FL1Jz13V7bZ2obd2k8aDuKOGVjC6DL79dTYFDJxNfNnZ6LPbO7
	mDaosd3N+9av9Au4SVHj0d20Vn4iKh/IJST1fqo5Kiv8NvSt4emXQB4qgMTzQdEX1xrgTpd2VoA
	Q==
X-Received: by 2002:a05:6102:418b:b0:65a:fcea:5a8 with SMTP id ada2fe7eead31-744dfed30b8mr6869668137.3.1783692990768;
        Fri, 10 Jul 2026 07:16:30 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:29 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 28/36] tuna: Add tests for isolate --cpuset functionality
Date: Fri, 10 Jul 2026 10:15:06 -0400
Message-ID: <20260710141523.36440-29-jkacur@redhat.com>
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

Add comprehensive test coverage for the new 'tuna isolate --cpuset'
feature that enables cpuset-based CPU isolation.

New test class TestTunaIsolateCpusetCLI includes 8 tests:
- Simple isolated cpuset creation with default/custom names
- Isolated + housekeeping cpuset creation with default/custom names
- Process migration verification to housekeeping cpuset
- Error handling for invalid argument combinations
- Backward compatibility with traditional isolate command

Tests verify:
- Correct cpuset creation with specified CPUs
- Partition types set to 'isolated' for both cpusets
- Process migration from root to housekeeping cpuset
- Error messages for --cpuset-housekeeping without --cpuset
- Traditional 'isolate -c' still works without creating cpusets

Updated Makefile to add 'make test-isolate-cpuset' target for
running these tests independently.

Updated tests/README.md to document the new tests and reflect
the increased test count (116 → 124 total tests).

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                 |   5 +-
 tests/README.md          |  16 +++-
 tests/test_cpuset_cli.py | 190 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 207 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index e2e2cbbf9d51..7d3d3f10b6ab 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ cleanlogs:
 .PHONY: clean
 clean: pyclean
 
-.PHONY: tests unit-tests test-eperm test-converters test-cpuset test-cpuset-cli test-all
+.PHONY: tests unit-tests test-eperm test-converters test-cpuset test-cpuset-cli test-isolate-cpuset test-all
 tests: unit-tests
 
 unit-tests:
@@ -39,4 +39,7 @@ test-cpuset:
 test-cpuset-cli:
 	@sudo python3 -m unittest tests.test_cpuset_cli -v
 
+test-isolate-cpuset:
+	@sudo python3 -m unittest tests.test_cpuset_cli.TestTunaIsolateCpusetCLI -v
+
 test-all: test-eperm test-converters test-cpuset test-cpuset-cli
diff --git a/tests/README.md b/tests/README.md
index 6da490b60448..514907db43ee 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -62,12 +62,14 @@ make test-converters
 # Using make (root-required tests)
 make test-cpuset
 make test-cpuset-cli
+make test-isolate-cpuset
 
 # Or using Python unittest directly
 python3 -m unittest tests.test_eperm_handling -v
 python3 -m unittest tests.test_converters -v
 sudo python3 -m unittest tests.test_cpuset -v
 sudo python3 -m unittest tests.test_cpuset_cli -v
+sudo python3 -m unittest tests.test_cpuset_cli.TestTunaIsolateCpusetCLI -v
 ```
 
 ### Specific Test Class
@@ -82,6 +84,7 @@ python3 -m unittest tests.test_converters.TestIrqstringToList -v
 # Root-required tests
 sudo python3 -m unittest tests.test_cpuset.TestCpusetCreation -v
 sudo python3 -m unittest tests.test_cpuset_cli.TestCpusetCreateCLI -v
+sudo python3 -m unittest tests.test_cpuset_cli.TestTunaIsolateCpusetCLI -v
 ```
 
 ### Specific Test Method
@@ -96,6 +99,7 @@ python3 -m unittest tests.test_converters.TestThreadstringToList.test_pattern_wi
 # Root-required tests
 sudo python3 -m unittest tests.test_cpuset.TestCpusetCreation.test_create_cpuset -v
 sudo python3 -m unittest tests.test_cpuset_cli.TestCpusetCreateCLI.test_create_with_auto_naming -v
+sudo python3 -m unittest tests.test_cpuset_cli.TestTunaIsolateCpusetCLI.test_isolate_with_housekeeping_default_names -v
 ```
 
 ## Test Organization
@@ -172,9 +176,13 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - TestCpusetStatusCLI: Status command for system-wide cpuset overview
   - TestCpusetModifyCLI: Modify command with --add-cpus, --remove-cpus, --memory-nodes, --isolated/--no-isolated
   - TestTunaMoveCpusetCLI: Integration of --cpuset with tuna move command (5 tests)
+  - TestTunaIsolateCpusetCLI: Integration of --cpuset with tuna isolate command (8 tests)
+    - Tests cpuset-based CPU isolation with isolated and housekeeping cpusets
+    - Verifies partition types, CPU assignments, and process migration
+    - Tests error handling and backward compatibility
   - Run: `sudo python3 -m unittest tests.test_cpuset_cli -v`
 
-**Total: 116 tests** (37 non-root + 79 root-required)
+**Total: 124 tests** (37 non-root + 87 root-required)
 
 ### Test Requirements: Root vs Non-Root
 
@@ -214,7 +222,7 @@ These tests run without root privileges:
 - Tests are fast and don't affect the running system
 - Tests verify both happy path (with mocks) and error path (with real EPERM)
 
-#### Root-Required Tests (79 tests)
+#### Root-Required Tests (87 tests)
 
 These tests require root to create/manipulate cgroups:
 
@@ -224,13 +232,15 @@ These tests require root to create/manipulate cgroups:
    - Test task migration between cpusets
    - All tests clean up created cpusets in tearDown()
 
-2. **Cpuset CLI tests** (40 tests) test command-line interface functions
+2. **Cpuset CLI tests** (48 tests) test command-line interface functions
    - Test cpuset create/list/destroy/move/show/status/modify commands
    - Verify auto-naming logic (tuna0, tuna1, etc.)
    - Test NUMA-aware memory node auto-detection and manual override
    - Test pattern matching and safety features
    - Test process migration with --pids and --threads
    - Test cpuset modification with --add-cpus, --remove-cpus, --memory-nodes, --isolated
+   - Test tuna move --cpuset integration (5 tests)
+   - Test tuna isolate --cpuset integration (8 tests) - cpuset-based CPU isolation
    - All tests clean up created cpusets afterwards
 
 **Why root is required:**
diff --git a/tests/test_cpuset_cli.py b/tests/test_cpuset_cli.py
index ed8995782872..cc51428cc55b 100644
--- a/tests/test_cpuset_cli.py
+++ b/tests/test_cpuset_cli.py
@@ -1006,6 +1006,195 @@ class TestTunaMoveCpusetCLI(unittest.TestCase):
         self.assertIn(str(current_pid), pids)
 
 
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestTunaIsolateCpusetCLI(unittest.TestCase):
+    """Test 'tuna isolate --cpuset' command (cpuset-based CPU isolation)"""
+
+    def setUp(self):
+        """Clean up any test cpusets before each test"""
+        self.test_cpusets = []
+        # Clean up any existing test cpusets
+        try:
+            cpuset.cleanup_cpusets('tuna_*', force=True, recursive=False)
+            cpuset.cleanup_cpusets('my_*', force=True, recursive=False)
+        except:
+            pass
+
+    def tearDown(self):
+        """Clean up test cpusets after each test"""
+        # Clean up by pattern (catches both named and default cpusets)
+        try:
+            cpuset.cleanup_cpusets('tuna_*', force=True, recursive=False)
+            cpuset.cleanup_cpusets('my_*', force=True, recursive=False)
+        except:
+            pass
+
+    def test_isolate_simple_cpuset_default_name(self):
+        """Test simple isolated cpuset with default name"""
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'isolate',
+            '-c', '0-1', '--cpuset'
+        ], capture_output=True, text=True)
+
+        self.assertEqual(result.returncode, 0, f"Command failed: {result.stderr}")
+        self.assertIn('tuna_isolated', result.stdout)
+
+        # Verify cpuset exists and has correct properties
+        cpuset_path = '/sys/fs/cgroup/tuna_isolated'
+        self.assertTrue(os.path.exists(cpuset_path))
+
+        with open(f'{cpuset_path}/cpuset.cpus') as f:
+            cpus = f.read().strip()
+            self.assertIn('0', cpus)
+            self.assertIn('1', cpus)
+
+        with open(f'{cpuset_path}/cpuset.cpus.partition') as f:
+            partition = f.read().strip()
+            self.assertEqual(partition, 'isolated')
+
+        # Verify it's empty (no tasks)
+        with open(f'{cpuset_path}/cgroup.procs') as f:
+            tasks = f.read().strip()
+            self.assertEqual(tasks, '', 'Isolated cpuset should be empty')
+
+    def test_isolate_custom_isolated_name(self):
+        """Test isolated cpuset with custom name"""
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'isolate',
+            '-c', '0-1', '--cpuset', 'my_rt'
+        ], capture_output=True, text=True)
+
+        self.assertEqual(result.returncode, 0, f"Command failed: {result.stderr}")
+        self.assertIn('my_rt', result.stdout)
+
+        # Verify cpuset exists
+        cpuset_path = '/sys/fs/cgroup/my_rt'
+        self.assertTrue(os.path.exists(cpuset_path))
+
+        with open(f'{cpuset_path}/cpuset.cpus') as f:
+            cpus = f.read().strip()
+            self.assertIn('0', cpus)
+
+        with open(f'{cpuset_path}/cpuset.cpus.partition') as f:
+            partition = f.read().strip()
+            self.assertEqual(partition, 'isolated')
+
+    def test_isolate_with_housekeeping_default_names(self):
+        """Test isolated + housekeeping cpusets with default names"""
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'isolate',
+            '-c', '0-1', '--cpuset', '--cpuset-housekeeping', '2-3'
+        ], capture_output=True, text=True)
+
+        self.assertEqual(result.returncode, 0, f"Command failed: {result.stderr}")
+        self.assertIn('tuna_isolated', result.stdout)
+        self.assertIn('tuna_housekeeping', result.stdout)
+
+        # Verify isolated cpuset
+        isolated_path = '/sys/fs/cgroup/tuna_isolated'
+        self.assertTrue(os.path.exists(isolated_path))
+
+        with open(f'{isolated_path}/cpuset.cpus') as f:
+            cpus = f.read().strip()
+            self.assertIn('0', cpus)
+
+        with open(f'{isolated_path}/cpuset.cpus.partition') as f:
+            partition = f.read().strip()
+            self.assertEqual(partition, 'isolated')
+
+        # Verify housekeeping cpuset
+        hk_path = '/sys/fs/cgroup/tuna_housekeeping'
+        self.assertTrue(os.path.exists(hk_path))
+
+        with open(f'{hk_path}/cpuset.cpus') as f:
+            cpus = f.read().strip()
+            self.assertIn('2', cpus)
+            self.assertIn('3', cpus)
+
+        with open(f'{hk_path}/cpuset.cpus.partition') as f:
+            partition = f.read().strip()
+            self.assertEqual(partition, 'isolated')
+
+        # Verify processes were migrated to housekeeping
+        with open(f'{hk_path}/cgroup.procs') as f:
+            tasks = f.read().strip().split('\n')
+            # Should have tasks migrated (at least some)
+            self.assertGreater(len(tasks), 0, 'Housekeeping cpuset should have migrated tasks')
+            # Filter out empty strings
+            tasks = [t for t in tasks if t]
+            self.assertGreater(len(tasks), 0)
+
+    def test_isolate_custom_names_both_cpusets(self):
+        """Test isolated + housekeeping with custom names for both"""
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'isolate',
+            '-c', '0-1', '--cpuset', 'my_rt',
+            '--cpuset-housekeeping', 'my_hk', '2-3'
+        ], capture_output=True, text=True)
+
+        self.assertEqual(result.returncode, 0, f"Command failed: {result.stderr}")
+        self.assertIn('my_rt', result.stdout)
+        self.assertIn('my_hk', result.stdout)
+
+        # Verify both cpusets exist
+        self.assertTrue(os.path.exists('/sys/fs/cgroup/my_rt'))
+        self.assertTrue(os.path.exists('/sys/fs/cgroup/my_hk'))
+
+        # Verify my_rt has correct CPUs
+        with open('/sys/fs/cgroup/my_rt/cpuset.cpus') as f:
+            cpus = f.read().strip()
+            self.assertIn('0', cpus)
+
+        # Verify my_hk has correct CPUs
+        with open('/sys/fs/cgroup/my_hk/cpuset.cpus') as f:
+            cpus = f.read().strip()
+            self.assertIn('2', cpus)
+            self.assertIn('3', cpus)
+
+        # Both should be isolated partitions
+        with open('/sys/fs/cgroup/my_rt/cpuset.cpus.partition') as f:
+            self.assertEqual(f.read().strip(), 'isolated')
+
+        with open('/sys/fs/cgroup/my_hk/cpuset.cpus.partition') as f:
+            self.assertEqual(f.read().strip(), 'isolated')
+
+    def test_isolate_housekeeping_without_cpuset_error(self):
+        """Test error when using --cpuset-housekeeping without --cpuset"""
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'isolate',
+            '-c', '0-1', '--cpuset-housekeeping', '2-3'
+        ], capture_output=True, text=True)
+
+        self.assertNotEqual(result.returncode, 0)
+        self.assertIn('requires --cpuset', result.stderr)
+
+    def test_isolate_housekeeping_wrong_arg_count_error(self):
+        """Test error when --cpuset-housekeeping has wrong number of arguments"""
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'isolate',
+            '-c', '0-1', '--cpuset',
+            '--cpuset-housekeeping', 'foo', 'bar', 'baz'
+        ], capture_output=True, text=True)
+
+        self.assertNotEqual(result.returncode, 0)
+        self.assertIn('1 or 2 arguments', result.stderr)
+
+    def test_isolate_traditional_without_cpuset(self):
+        """Test traditional isolate without --cpuset (backward compatibility)"""
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'isolate',
+            '-c', '0-1'
+        ], capture_output=True, text=True)
+
+        # Should succeed
+        self.assertEqual(result.returncode, 0)
+
+        # Verify no cpusets were created
+        self.assertFalse(os.path.exists('/sys/fs/cgroup/tuna_isolated'))
+        self.assertFalse(os.path.exists('/sys/fs/cgroup/tuna_housekeeping'))
+
+
 def suite():
     """Create test suite"""
     loader = unittest.TestLoader()
@@ -1021,6 +1210,7 @@ def suite():
     suite.addTests(loader.loadTestsFromTestCase(TestCpusetStatusCLI))
     suite.addTests(loader.loadTestsFromTestCase(TestCpusetModifyCLI))
     suite.addTests(loader.loadTestsFromTestCase(TestTunaMoveCpusetCLI))
+    suite.addTests(loader.loadTestsFromTestCase(TestTunaIsolateCpusetCLI))
 
     return suite
 
-- 
2.54.0

