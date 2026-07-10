Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA49831716B
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692971; cv=none; b=Ai39sz2ywor5Ka4GvjFZsXKzsa1zEbLKxdh7uYtgYjj4GgRA7g45yPsEx3VmTS4ZaFJixGv2rJEnd7GzehsWAksYG7yEkCKCWlkJgcaEk90xo+KqWiM3ZAWfIb0vVXy0ThErejGpWZvoOlQbbSWNcXrmdM7kXmT5UHmFXkCCodo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692971; c=relaxed/simple;
	bh=FqWzw92qnvMJDCJs2YS9vs3fORd1htzOyPqzMfs7pa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDY+ieqfYZczSfQh/Emd6BQDVElYbe7CbnOyBsfpAGmnuxdoMwRpzwrYfgkEZhjKibl+67tDsVS7fOu14JwCp/ZjgEygh6XMFLOES5Ez+WvxgJA5hsO+9zwcrJvtECx0aTMCpddbhaFux7NYJOLHDNH7mWL3EN845EoCc1crM2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2nkhNTx; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2nkhNTx"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-737de525d2eso1101086137.2
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692969; x=1784297769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0JhFyRhfvCTWYvIV7K1mVSps+1CPYHv0vWQPZqY69pc=;
        b=I2nkhNTxdBtqkeWwOpBmNyZkkMcJFllUV6KtgV+fk4+3KxrCyhMXVoDwUYpbzT26p7
         qzDp7ltaD2wbbo+hBMllWZeovmvdwj1Rxz/TWrsCR+TQa/HXR7faQinkAKPF+RiZ5Swp
         FRgToWpg+STMeELsNOObfRHEWaNbBWNfYS/m06P+/2BWJxxHXJXWCFtU4At4gYABLSKH
         7j81Nh8qcEXI+BN1GjN/xQaqOsYSOF4udsqKo+TeoCZ8NyyUpCt7CvnFfUP1aEsAlWPF
         mTxZ1AUGOfMzoxqollOp3fGRf+2mpENyHQkji7DfAaAuu4ht7wfr0h26u8kKPtjagPi5
         m1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692969; x=1784297769;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0JhFyRhfvCTWYvIV7K1mVSps+1CPYHv0vWQPZqY69pc=;
        b=HhLB5KdYoPH9rj6PZPhpf6aF1Oee5n/G+SaOuioh61If4WWuA/mTGQOA2pBhhR7GaQ
         GY1CDtrddy/Sg7AXHNupCy7hP7R/54E/iZVFrtti7bgwOfqF/wR8yVT3mfeAimenWvjc
         rEsw4nGgOHI+3ETNrQGORz4Zt7H8/K65i/WEBzBZ5N0KUSljtOs7el0AoGPgnraXscw6
         YjF4yG8vEmGLcXphnuO2Mahyw9QnkS8CIL3KWWP0wLO1+2jslqCXUSL3HRfCbArRdY0t
         SzfXnQUb/i6uc+yQH2cwfn/wnmvNQrtHTRv86lADQIzihDUzVlJy9GDKqqIxLrvCZX8d
         eSmA==
X-Gm-Message-State: AOJu0Yxxz4dnEwtNzY6NOFllkiSwBpDwWLi1jNs4zzhl0lsJ15Xe9H2N
	ClAQiBEY52og9Y0/FRhnvh0MaVnFZQTU+HBU6qhHp9PAaGFL3mXt9rN992xetA==
X-Gm-Gg: AfdE7ckSVHzoue40egoyUkXpBZJjRU7+RolZlaOhi/82Ik+hsn5LuAKaC31KD6zNhU7
	BK/3fbCY2VdzQNAreNV2qlelVkcyvlwGDBSaFpENEH0LB/aLlVKiRNp6D297pSisfI/uFUBVE8c
	eCpTtUj/fu0eHyaw56zidQDwxbX8dCEWKMBKiOJ6jBj7oHLfRLlJ5GhzrfD2yXoDXSzbooGrYhV
	LIO3gBWnZaTa8lWkJzxU14a2+5hp1vuuHxFMaJPVpbiO3KTpFK9I2ek8/OgGc3yhp+SzvQG5hFI
	auzUW7pCpAuPFYQOELfveMnsnl6Q/KnmKHgctgHRf8H4UqRdg8I147g8MLW6Vk12h7qSigCoNNu
	DCiqoCbR1KfNwSBha8Iz5jsSNDYmjjbw/3XDwSGhjWWGayYZ08V/ohb0uL/LuzCPmOBl3f/+xHu
	0skhhtuFplbjSrh2v7oSc+wXu6YgoBrK9V43oZi87Qc26Ws9GAOhOvvFF9mtidLLChB2zCO+jBO
	A==
X-Received: by 2002:a05:6102:8099:b0:726:cd42:d039 with SMTP id ada2fe7eead31-744dff98663mr7844668137.24.1783692968634;
        Fri, 10 Jul 2026 07:16:08 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:07 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 15/36] tuna: Add tests for NUMA-aware memory node assignment
Date: Fri, 10 Jul 2026 10:14:53 -0400
Message-ID: <20260710141523.36440-16-jkacur@redhat.com>
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

Add comprehensive test coverage for the NUMA detection and auto-assignment
functionality added to cpusets.

Changes to tests/test_cpuset.py:
- Add TestNumaDetection class with 6 tests
  - test_discover_numa_nodes: Validates NUMA topology discovery
  - test_get_numa_nodes_for_cpus_basic: Tests memory node detection
  - test_get_numa_nodes_for_empty_list: Tests empty CPU list fallback
  - test_get_numa_nodes_for_single_cpu: Tests single CPU detection
  - test_numa_node_contains: Tests NumaNode __contains__ operator
  - test_numa_node_int: Tests NumaNode __int__ operator
- All tests run without root (read-only sysfs access)
- Tests work on both single-node and multi-node systems

Changes to tests/test_cpuset_cli.py:
- Add test_create_with_numa_autodetect: Tests auto-detection path
- Add test_create_with_numa_manual: Tests --memory-nodes override
- Both tests validate cpuset.mems is set correctly

Changes to tests/README.md:
- Update test counts: 63 → 71 total (29 non-root + 42 root-required)
- Document TestNumaDetection class and its 6 tests
- Update TestCpusetCreateCLI description to mention NUMA tests
- Update all example outputs to reflect new test counts

All 8 new tests pass successfully.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/README.md          | 71 ++++++++++++++++++++++++++--------------
 tests/test_cpuset.py     | 70 +++++++++++++++++++++++++++++++++++++++
 tests/test_cpuset_cli.py | 27 +++++++++++++++
 3 files changed, 143 insertions(+), 25 deletions(-)

diff --git a/tests/README.md b/tests/README.md
index ea54d2cee5fd..148d50447420 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -9,10 +9,10 @@ This directory contains the test suite for tuna, using Python's `unittest` frame
 ## Quick Start
 
 ```bash
-# Run all non-root tests only (23 tests)
+# Run all non-root tests only (29 tests)
 make tests
 
-# Run ALL tests (all 63 tests, requires sudo for root-required tests)
+# Run ALL tests (all 71 tests, requires sudo for root-required tests)
 make test-all
 
 # Run specific test module
@@ -32,12 +32,12 @@ sudo python3 -m unittest tests.test_cpuset -v
 Run all unit tests using any of these methods:
 
 ```bash
-# Using make (non-root tests only, 23 tests)
+# Using make (non-root tests only, 29 tests)
 make tests
 # or
 make unit-tests
 
-# Using make (ALL tests including root-required tests, 63 tests)
+# Using make (ALL tests including root-required tests, 71 tests)
 make test-all
 
 # Using the test runner directly (non-root tests only)
@@ -107,7 +107,7 @@ Tests are organized using Python's `unittest` framework. Each test file contains
 
 ### Current Tests
 
-#### Non-Root Tests (23 tests)
+#### Non-Root Tests (29 tests)
 
 - **test_eperm_handling.py** (6 tests) - Tests for EPERM error handling
   - Verifies that Permission Denied errors are handled gracefully
@@ -129,7 +129,15 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - These tests can run without root as they only check system capabilities
   - Run: `python3 -m unittest tests.test_cpuset.TestCpusetsInit -v`
 
-#### Root-Required Tests (40 tests)
+- **test_cpuset.py::TestNumaDetection** (6 tests) - NUMA topology detection
+  - Tests `discover_numa_nodes()`: NUMA node discovery from sysfs
+  - Tests `get_numa_nodes_for_cpus()`: Auto-detecting memory nodes for CPU lists
+  - Tests NumaNode class operators (__contains__, __int__)
+  - Tests single-node and multi-node system support
+  - Validates smart NUMA-aware memory node assignment for cpusets
+  - Run: `python3 -m unittest tests.test_cpuset.TestNumaDetection -v`
+
+#### Root-Required Tests (42 tests)
 
 - **test_cpuset.py** (22 tests) - Core cpuset module tests
   - TestCpusetCreation: Creating and destroying cpusets
@@ -141,21 +149,21 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - Note: TestCpusetsInit (5 tests) runs without root, see non-root section
   - Run: `sudo python3 -m unittest tests.test_cpuset -v` (runs all 27 tests with root)
 
-- **test_cpuset_cli.py** (18 tests) - CLI command tests
+- **test_cpuset_cli.py** (20 tests) - CLI command tests
   - TestGetNextTunaCpusetName: Auto-naming logic (tuna0, tuna1, gap-filling)
-  - TestCpusetCreateCLI: Create command with auto/custom names and --isolated
+  - TestCpusetCreateCLI: Create command with auto/custom names, --isolated, and NUMA auto-detection/override
   - TestCpusetListCLI: List command with --pattern, --verbose, --skip-empty
   - TestCpusetDestroyCLI: Destroy command with patterns and safety options
   - TestCpusetMoveCLI: Move command with --pids, --threads, error handling
   - Run: `sudo python3 -m unittest tests.test_cpuset_cli -v`
 
-**Total: 63 tests** (23 non-root + 40 root-required)
+**Total: 71 tests** (29 non-root + 42 root-required)
 
 ### Test Requirements: Root vs Non-Root
 
 The test suite is split between tests that require root and those that don't:
 
-#### Non-Root Tests (23 tests)
+#### Non-Root Tests (29 tests)
 
 These tests run without root privileges:
 
@@ -173,13 +181,18 @@ These tests run without root privileges:
    - Check NUMA node configuration
    - Read-only operations that don't require root
 
+4. **NUMA detection tests** verify NUMA topology discovery
+   - Test NUMA node discovery from sysfs
+   - Test smart memory node assignment for CPU lists
+   - Read-only operations that work on any system (single or multi-node)
+
 **Benefits:**
 - Developers can run basic tests without `sudo`
 - Tests run in CI/CD environments without elevated privileges
 - Tests are fast and don't affect the running system
 - Tests verify both happy path (with mocks) and error path (with real EPERM)
 
-#### Root-Required Tests (40 tests)
+#### Root-Required Tests (42 tests)
 
 These tests require root to create/manipulate cgroups:
 
@@ -189,9 +202,10 @@ These tests require root to create/manipulate cgroups:
    - Test task migration between cpusets
    - All tests clean up created cpusets in tearDown()
 
-2. **Cpuset CLI tests** (18 tests) test command-line interface functions
+2. **Cpuset CLI tests** (20 tests) test command-line interface functions
    - Test cpuset create/list/destroy/move commands
    - Verify auto-naming logic (tuna0, tuna1, etc.)
+   - Test NUMA-aware memory node auto-detection and manual override
    - Test pattern matching and safety features
    - Test process migration with --pids and --threads
    - All tests clean up created cpusets afterwards
@@ -285,7 +299,7 @@ self.assertRaises(Exception, fn) # fn() raises Exception
 
 ## Expected Output
 
-### Non-Root Tests Only (23 tests)
+### Non-Root Tests Only (29 tests)
 
 Running without sudo will run only the non-root tests:
 
@@ -309,30 +323,36 @@ test_mixed_numeric_and_pattern (test_converters.TestThreadstringToList) ... ok
 test_multiple_numeric_pids (test_converters.TestThreadstringToList) ... ok
 test_pattern_with_mock_ps (test_converters.TestThreadstringToList) ... ok
 test_single_numeric_pid (test_converters.TestThreadstringToList) ... ok
+test_discover_numa_nodes (test_cpuset.TestNumaDetection) ... ok
+test_get_numa_nodes_for_cpus_basic (test_cpuset.TestNumaDetection) ... ok
+test_get_numa_nodes_for_empty_list (test_cpuset.TestNumaDetection) ... ok
+test_get_numa_nodes_for_single_cpu (test_cpuset.TestNumaDetection) ... ok
+test_numa_node_contains (test_cpuset.TestNumaDetection) ... ok
+test_numa_node_int (test_cpuset.TestNumaDetection) ... ok
 ... (most cpuset tests skipped: "Requires root permissions")
 
 ----------------------------------------------------------------------
-Ran 23 tests in 0.XXXs
+Ran 29 tests in 0.XXXs
 
-OK (skipped=40)
+OK (skipped=42)
 ```
 
-### All Tests Including Root-Required (63 tests)
+### All Tests Including Root-Required (71 tests)
 
-Running with sudo will run all 63 tests:
+Running with sudo will run all 71 tests:
 
 ```bash
 $ sudo python3 -m unittest discover -s tests -p "test_*.py" -v
-... (23 non-root tests as above)
+... (29 non-root tests as above)
 test_initialization (test_cpuset.TestCpusetsInit) ... ok
 test_cpuset_path (test_cpuset.TestCpusetsInit) ... ok
 ... (27 cpuset module tests)
 test_first_name_is_tuna0 (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
 test_sequential_naming (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
-... (18 cpuset CLI tests)
+... (20 cpuset CLI tests)
 
 ----------------------------------------------------------------------
-Ran 63 tests in X.XXXs
+Ran 71 tests in X.XXXs
 
 OK
 ```
@@ -341,12 +361,13 @@ OK
 
 The test suite includes:
 
-### Unit Tests (23 tests - no root required)
+### Unit Tests (29 tests - no root required)
 - **Converter tests**: Pure logic testing with mocks
 - **EPERM tests**: Error handling verification
 - **CpusetsInit tests**: System capability detection (read-only)
+- **NUMA detection tests**: NUMA topology discovery and memory node assignment (read-only)
 
-### Integration Tests (40 tests - require root)
+### Integration Tests (42 tests - require root)
 - **Cpuset module tests**: Test interaction with cgroup v2 subsystem
 - **Cpuset CLI tests**: Test command-line interface integration
 
@@ -359,12 +380,12 @@ Future test categories might include:
 
 ### Non-Root Tests (Recommended for CI)
 
-The non-root tests (23 tests) are designed to run in CI/CD environments:
+The non-root tests (29 tests) are designed to run in CI/CD environments:
 - Run without root privileges
 - No special system configuration required
 - Exit code 0 on success, non-zero on failure
 - Fast execution (< 1 second)
-- Includes basic cpuset capability detection tests
+- Includes basic cpuset capability detection and NUMA detection tests
 
 ```bash
 # CI-friendly test command
@@ -373,7 +394,7 @@ python3 -m unittest discover -s tests -p "test_*.py" -v
 
 ### Root-Required Tests (Optional for CI)
 
-The cpuset tests (40 tests) can run in CI with special setup:
+The cpuset tests (42 tests) can run in CI with special setup:
 - Requires root access or privileged containers
 - Requires cgroup v2 support
 - May need dedicated test runners with appropriate permissions
diff --git a/tests/test_cpuset.py b/tests/test_cpuset.py
index ec6ce19028cf..ca0a6b0c9ccd 100644
--- a/tests/test_cpuset.py
+++ b/tests/test_cpuset.py
@@ -654,6 +654,75 @@ class TestProcessMovement(unittest.TestCase):
             cpuset.destroy_cpuset('test_multi_pid', force=True)
 
 
+class TestNumaDetection(unittest.TestCase):
+    """Test NUMA topology detection functions"""
+
+    def test_discover_numa_nodes(self):
+        """Test that NUMA node discovery returns valid data"""
+        nodes = cpuset.discover_numa_nodes()
+
+        # Should have at least one node
+        self.assertGreaterEqual(len(nodes), 1)
+
+        # All nodes should have node IDs starting from 0
+        self.assertIn(0, nodes)
+
+        # Each node should have CPUs
+        for nodeid, node in nodes.items():
+            self.assertIsInstance(nodeid, int)
+            self.assertIsInstance(node, cpuset.NumaNode)
+            self.assertEqual(node.nodeid, nodeid)
+            self.assertIsInstance(node.cpus, set)
+
+    def test_get_numa_nodes_for_cpus_basic(self):
+        """Test NUMA node detection for basic CPU lists"""
+        # Get available nodes
+        nodes = cpuset.discover_numa_nodes()
+
+        # Get some CPUs from first node
+        first_node = nodes[min(nodes.keys())]
+        test_cpus = list(first_node.cpus)[:4] if len(first_node.cpus) >= 4 else list(first_node.cpus)
+
+        if test_cpus:
+            result = cpuset.get_numa_nodes_for_cpus(test_cpus)
+            # Should return a string
+            self.assertIsInstance(result, str)
+            # Should contain at least the first node
+            self.assertIn(str(min(nodes.keys())), result)
+
+    def test_get_numa_nodes_for_empty_list(self):
+        """Test NUMA node detection for empty CPU list"""
+        result = cpuset.get_numa_nodes_for_cpus([])
+        # Should default to "0"
+        self.assertEqual(result, "0")
+
+    def test_get_numa_nodes_for_single_cpu(self):
+        """Test NUMA node detection for single CPU"""
+        # Get first available CPU
+        nodes = cpuset.discover_numa_nodes()
+        first_node = nodes[min(nodes.keys())]
+
+        if first_node.cpus:
+            test_cpu = list(first_node.cpus)[0]
+            result = cpuset.get_numa_nodes_for_cpus([test_cpu])
+            # Should return a valid node string
+            self.assertIsInstance(result, str)
+            self.assertTrue(len(result) > 0)
+
+    def test_numa_node_contains(self):
+        """Test NumaNode __contains__ operator"""
+        node = cpuset.NumaNode(0, {0, 1, 2, 3})
+        self.assertIn(0, node)
+        self.assertIn(3, node)
+        self.assertNotIn(4, node)
+        self.assertNotIn(100, node)
+
+    def test_numa_node_int(self):
+        """Test NumaNode __int__ operator"""
+        node = cpuset.NumaNode(5, {0, 1})
+        self.assertEqual(int(node), 5)
+
+
 def suite():
     """Create test suite"""
     loader = unittest.TestLoader()
@@ -661,6 +730,7 @@ def suite():
 
     # Add all test classes
     suite.addTests(loader.loadTestsFromTestCase(TestCpusetsInit))
+    suite.addTests(loader.loadTestsFromTestCase(TestNumaDetection))
     suite.addTests(loader.loadTestsFromTestCase(TestCpusetCreation))
     suite.addTests(loader.loadTestsFromTestCase(TestCpusetConfiguration))
     suite.addTests(loader.loadTestsFromTestCase(TestContextManager))
diff --git a/tests/test_cpuset_cli.py b/tests/test_cpuset_cli.py
index 9bec8955d1ad..ac2197c77379 100644
--- a/tests/test_cpuset_cli.py
+++ b/tests/test_cpuset_cli.py
@@ -160,6 +160,33 @@ class TestCpusetCreateCLI(unittest.TestCase):
             # Should be 'isolated' (or possibly 'root'/'member' if not supported)
             self.assertIn(partition, ['isolated', 'root', 'member'])
 
+    def test_create_with_numa_autodetect(self):
+        """Test creating cpuset with NUMA auto-detection (no --memory-nodes)"""
+        cpuset_create(cpu_list=[0, 1], name='test_numa_auto', isolated=False, memory_nodes=None)
+        self.created_cpusets.append('test_numa_auto')
+
+        # Verify cpuset exists
+        self.assertTrue(os.path.exists('/sys/fs/cgroup/test_numa_auto'))
+
+        # Verify memory nodes are set (should be auto-detected)
+        with open('/sys/fs/cgroup/test_numa_auto/cpuset.mems') as f:
+            mems = f.read().strip()
+        # Should have at least one memory node set
+        self.assertTrue(len(mems) > 0)
+        # On single-node system, should be "0"
+        # On multi-node, could be "0", "1", "0-1", etc.
+        self.assertRegex(mems, r'^[0-9,-]+$')
+
+    def test_create_with_numa_manual(self):
+        """Test creating cpuset with manual --memory-nodes override"""
+        cpuset_create(cpu_list=[0, 1], name='test_numa_manual', isolated=False, memory_nodes='0')
+        self.created_cpusets.append('test_numa_manual')
+
+        # Verify memory nodes are set to what we specified
+        with open('/sys/fs/cgroup/test_numa_manual/cpuset.mems') as f:
+            mems = f.read().strip()
+        self.assertEqual(mems, '0')
+
 
 @unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
 @unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
-- 
2.54.0

