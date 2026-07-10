Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAEF33CEA9
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692973; cv=none; b=ZZUx+4t58dbjEI7hWk6/dy16/QEqtNjF6cqftBrZ+zLt2mVdtSAs6GuUqhajoQcd6VoEjtoQ6/Hzw3xLU9/IPz/U0ekctcCv6tT5MomndzjxyoaVH0dfMZl7fEg8nGKepm7BIdtMWa4SHsiknqRXjnR6cZedfHUFS8iHFmc289g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692973; c=relaxed/simple;
	bh=Iq0BWtXVZPyLD51jsmwFWdyjs4mXtE2EHKX1JOBTgpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUwiaiqiUHyTIcIQN2HMh/N7Ac72aC9r363OSG7qWwSawXIVNaw/ptbnrFVuLFXcyEqR/dxjEVwR/K5QV/Q66MyuYhAP54tR5o7/X/UfkRj1Enmvfqvku/SRDzP2oHlHDumE6LsHMrWqCBboJjjKO1QbokqxbZe3kdr/QPug1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMpj2vNX; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMpj2vNX"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-963f63fe025so307201241.0
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692971; x=1784297771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BPwJsFFKqgz2PtrRXgGXO0E+Nj3R8Tp/q7CeFAoZSJk=;
        b=YMpj2vNXsOO5T/hxp4EZ8Pb/MUHuDjthocSS4pNgJmrFVcFBncsEsWr0O9gAszVi1J
         tbmY4haHxhXLuUtxpFn1SYzh+KQv7EYx80VrBo72kBDYuMG1gyjYozs1apDxadv5B5RR
         aavqGBnSQoeSFIMBNbKo/5Tb6sOYfloiZssCg25JPG/JuYZu73J2DB7xeF0rwO96KcU1
         MLVhzNWAM54q4mkAY5+j8d3UqURRZNLoXaVkedVyfnkFgxoFi2mYMCZwj8QhWEAhHYv/
         pCyQQOgAm5k+hud0ruXH2jTagQRNA/jp04o/jBhmXzmYwjL5swDMvEaxE81hBrW4KrUR
         dAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692971; x=1784297771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BPwJsFFKqgz2PtrRXgGXO0E+Nj3R8Tp/q7CeFAoZSJk=;
        b=ISP2GKC8rO+/6wIKMua76eMYBbSt+k8t4N98odbsqMZj1ZH7bgP6UQb3oGqYMsnDlQ
         2rfB40WboKq0yzoRQhGl9aUhhxNh4B/NeYo5Qv+dr6C41ePFsFMBHWZeP1Ce5RTDwxyB
         kYgzjIez5r5HwQ4iDHOX1IMBqfo/izGmfjA7XYbMrHCngxhSbkyZtkKKVMafZU0XsDuY
         yZqPBnBjR3Dg15whv8IGjzVz4cw8/b89aRL0iIpy3I3KcHO4AsGEaP8kAYMYI+LX6RAs
         PfKNrjOiEMdVDQzEtmC8blhMCRbn14iQxzPx28RnbGQH8OMV1sWW1WYRLXhrulo2xSwR
         2P6g==
X-Gm-Message-State: AOJu0YxBGnCwyubUsiKW8pxUXFypjXIuQtR1R2injWkZQR69hC+up0e3
	bhq59wo6kaiQlqeI9/zsOMgCqaAo7G8hrVZcQgwvkMs1NF5173LQj5nJmr2V4g==
X-Gm-Gg: AfdE7ck0M5ejEjgI//a3+XSSi5xM21jbPgBLpW48mWtkq6MMcuPHq7/sj1sKYs+/bcI
	0VJAYXgs0v6Zm68al2j6rt6IbzDQV3sWLAtm2s60kL+vcHpgDk2XU0cHPL89w/JGpY7gLBhN054
	H0+LxS6cKL4akNz5GnH9ARlBiDabL2d0khlEQZvPl+kQkyJENmjiytG9gcclEuR9jRiFcMHpwI3
	BZyAb1Vxsw8fDmbz/lh38aRabZkO9jJqrB5ZPiAR4LDVuXbWYAqj4IK/K/WJxA8T3flF285TBE4
	MuC5C7WHzP+tOY5jDqhB4G52NDhFjy+dXBy6gi/Uv12yTgsJeyt17FXCwLXxUjTVGhsq1w/Nhr/
	re5cpE4kPngkh9CtTN5ceIhNOtLraCxZ6yjKPp0KNAlKy+vxYQ2l940ye8gK46k3ekhCuQbjFWC
	KKAIW5hjiFxLngYoFbc+UnVhctBPeijdS+cblc4GzTVpD/XJpKIDUGXtp5b1xjkp1cKG+TBfKvZ
	g==
X-Received: by 2002:a05:6102:41a7:b0:73f:a641:47d2 with SMTP id ada2fe7eead31-744e01eab1bmr7025571137.24.1783692969836;
        Fri, 10 Jul 2026 07:16:09 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:09 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 16/36] tuna: Add process blocklist to prevent shutdown issues
Date: Fri, 10 Jul 2026 10:14:54 -0400
Message-ID: <20260710141523.36440-17-jkacur@redhat.com>
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

When moving processes to cpusets with restricted CPU sets, critical
systemd processes (particularly systemd-logind) can lose the ability
to communicate with other systemd components. This breaks system
shutdown and session management, even after the cpuset is destroyed
and processes are migrated back to the root cgroup.

This commit implements a blocklist of critical system processes that
are automatically skipped when attempting to move them to custom
cpusets. The blocklist includes:

- systemd (PID 1) - init system
- systemd-logind - session/power management (critical for shutdown)
- systemd-journald - logging daemon
- dbus-daemon/dbus-broker - system message bus

All process movement goes through the write_pid() method in cpuset.py,
which now checks the blocklist before attempting to move any process.
Blocklisted processes are logged and counted as failed, providing clear
feedback to users without breaking existing error handling patterns.

The CLI (tuna-cmd.py cpuset move) was also updated to:
1. Check the blocklist before calling write_pid() for better messages
2. Change NAME from --name flag to positional argument for consistency
   with cpuset destroy command

User-facing changes:
- Attempting to move systemd shows: "Skipping PID 1 (systemd): critical
  system process" instead of generic "failed to move" message
- Command syntax changed from "tuna cpuset move --name=foo" to
  "tuna cpuset move foo" for consistency

Testing:
- Added 8 new tests in tests/test_process_blocklist.py (6 non-root,
  2 root-required)
- Updated 8 existing tests in tests/test_cpuset_cli.py for new syntax
- Added 2 new CLI tests for blocklist behavior
- All 83 tests pass (37 non-root + 46 root-required)

This fix prevents system instability and ensures clean shutdown when
using tuna cpusets for real-time tuning.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/README.md                 |  35 +++++---
 tests/test_cpuset_cli.py        |  51 ++++++++++--
 tests/test_process_blocklist.py | 139 ++++++++++++++++++++++++++++++++
 tuna-cmd.py                     |  13 ++-
 tuna/cpuset.py                  |  42 ++++++++++
 5 files changed, 260 insertions(+), 20 deletions(-)
 create mode 100644 tests/test_process_blocklist.py

diff --git a/tests/README.md b/tests/README.md
index 148d50447420..a199f7efa9e6 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -107,7 +107,7 @@ Tests are organized using Python's `unittest` framework. Each test file contains
 
 ### Current Tests
 
-#### Non-Root Tests (29 tests)
+#### Non-Root Tests (37 tests)
 
 - **test_eperm_handling.py** (6 tests) - Tests for EPERM error handling
   - Verifies that Permission Denied errors are handled gracefully
@@ -115,6 +115,13 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - Ensures tuna handles permission errors without crashing
   - Run: `python3 -m unittest tests.test_eperm_handling -v`
 
+- **test_process_blocklist.py** (8 tests) - Process blocklist functionality
+  - Verifies that critical system processes (systemd, systemd-logind, etc.) are protected
+  - Tests that blocklisted processes cannot be moved to custom cpusets
+  - Prevents system instability and shutdown issues caused by moving critical processes
+  - 6 non-root tests verify blocklist logic, 2 root tests verify actual blocking
+  - Run: `python3 -m unittest tests.test_process_blocklist -v`
+
 - **test_converters.py** (12 tests) - Tests for argument converter functions
   - Tests `threadstring_to_list()`: Converting thread specifications to PID lists
   - Tests `irqstring_to_list()`: Converting IRQ specifications to IRQ number lists
@@ -137,7 +144,12 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - Validates smart NUMA-aware memory node assignment for cpusets
   - Run: `python3 -m unittest tests.test_cpuset.TestNumaDetection -v`
 
-#### Root-Required Tests (42 tests)
+#### Root-Required Tests (44 tests)
+
+- **test_process_blocklist.py** (2 tests) - Process blocklist root tests
+  - Tests actual blocking of systemd from being moved to cpusets
+  - Verifies normal processes can still be moved
+  - Run: `sudo python3 -m unittest tests.test_process_blocklist.TestProcessBlocklist.test_write_pid_blocks_systemd tests.test_process_blocklist.TestProcessBlocklist.test_write_pid_allows_normal_process -v`
 
 - **test_cpuset.py** (22 tests) - Core cpuset module tests
   - TestCpusetCreation: Creating and destroying cpusets
@@ -149,21 +161,21 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - Note: TestCpusetsInit (5 tests) runs without root, see non-root section
   - Run: `sudo python3 -m unittest tests.test_cpuset -v` (runs all 27 tests with root)
 
-- **test_cpuset_cli.py** (20 tests) - CLI command tests
+- **test_cpuset_cli.py** (22 tests) - CLI command tests
   - TestGetNextTunaCpusetName: Auto-naming logic (tuna0, tuna1, gap-filling)
   - TestCpusetCreateCLI: Create command with auto/custom names, --isolated, and NUMA auto-detection/override
   - TestCpusetListCLI: List command with --pattern, --verbose, --skip-empty
   - TestCpusetDestroyCLI: Destroy command with patterns and safety options
-  - TestCpusetMoveCLI: Move command with --pids, --threads, error handling
+  - TestCpusetMoveCLI: Move command with --pids, --threads, error handling, blocklist protection
   - Run: `sudo python3 -m unittest tests.test_cpuset_cli -v`
 
-**Total: 71 tests** (29 non-root + 42 root-required)
+**Total: 83 tests** (37 non-root + 46 root-required)
 
 ### Test Requirements: Root vs Non-Root
 
 The test suite is split between tests that require root and those that don't:
 
-#### Non-Root Tests (29 tests)
+#### Non-Root Tests (37 tests)
 
 These tests run without root privileges:
 
@@ -171,17 +183,22 @@ These tests run without root privileges:
    - They intentionally trigger permission errors by trying to modify PID 1
    - Success means the error was caught and handled properly
 
-2. **Converter tests** use mock objects instead of real system access
+2. **Process blocklist tests** (6 non-root tests) verify the blocklist logic
+   - Test that critical processes (systemd, systemd-logind, etc.) are identified correctly
+   - Verify the blocklist prevents system instability and shutdown issues
+   - No actual process movement required - tests the detection logic
+
+3. **Converter tests** use mock objects instead of real system access
    - Test pure logic: string parsing and conversion
    - MockPidStats provides test data without accessing /proc
    - No actual process manipulation occurs
 
-3. **CpusetsInit tests** verify system capability detection
+4. **CpusetsInit tests** verify system capability detection
    - Test cgroup v2 detection logic
    - Check NUMA node configuration
    - Read-only operations that don't require root
 
-4. **NUMA detection tests** verify NUMA topology discovery
+5. **NUMA detection tests** verify NUMA topology discovery
    - Test NUMA node discovery from sysfs
    - Test smart memory node assignment for CPU lists
    - Read-only operations that work on any system (single or multi-node)
diff --git a/tests/test_cpuset_cli.py b/tests/test_cpuset_cli.py
index ac2197c77379..77b7fcbe1a4f 100644
--- a/tests/test_cpuset_cli.py
+++ b/tests/test_cpuset_cli.py
@@ -376,7 +376,7 @@ class TestCpusetMoveCLI(unittest.TestCase):
 
         # Move current process using pid_list (string format)
         current_pid = os.getpid()
-        cpuset_move(name='test_move_pids', thread_list=None, pid_list=str(current_pid))
+        cpuset_move('test_move_pids', thread_list=None, pid_list=str(current_pid))
 
         # Verify PID is in the cpuset
         with open('/sys/fs/cgroup/test_move_pids/cgroup.procs') as f:
@@ -391,7 +391,7 @@ class TestCpusetMoveCLI(unittest.TestCase):
 
         # Move current process using thread_list (list of integers)
         current_pid = os.getpid()
-        cpuset_move(name='test_move_threads', thread_list=[current_pid], pid_list=None)
+        cpuset_move('test_move_threads', thread_list=[current_pid], pid_list=None)
 
         # Verify PID is in the cpuset
         with open('/sys/fs/cgroup/test_move_threads/cgroup.procs') as f:
@@ -406,7 +406,7 @@ class TestCpusetMoveCLI(unittest.TestCase):
 
         # Move current process using both arguments
         current_pid = os.getpid()
-        cpuset_move(name='test_move_both', thread_list=[current_pid], pid_list=str(current_pid))
+        cpuset_move('test_move_both', thread_list=[current_pid], pid_list=str(current_pid))
 
         # Verify PID is in the cpuset (should only appear once despite being in both lists)
         with open('/sys/fs/cgroup/test_move_both/cgroup.procs') as f:
@@ -417,7 +417,7 @@ class TestCpusetMoveCLI(unittest.TestCase):
         """Test error when trying to move to nonexistent cpuset"""
         # Should exit with error (sys.exit(1))
         with self.assertRaises(SystemExit) as cm:
-            cpuset_move(name='nonexistent_cpuset', thread_list=None, pid_list='1234')
+            cpuset_move('nonexistent_cpuset', thread_list=None, pid_list='1234')
         self.assertEqual(cm.exception.code, 1)
 
     def test_move_no_pids_error(self):
@@ -428,7 +428,7 @@ class TestCpusetMoveCLI(unittest.TestCase):
 
         # Should exit with error when neither thread_list nor pid_list provided
         with self.assertRaises(SystemExit) as cm:
-            cpuset_move(name='test_move_nopids', thread_list=None, pid_list=None)
+            cpuset_move('test_move_nopids', thread_list=None, pid_list=None)
         self.assertEqual(cm.exception.code, 2)
 
     def test_move_invalid_pid(self):
@@ -437,9 +437,44 @@ class TestCpusetMoveCLI(unittest.TestCase):
         cpuset_create(cpu_list=[0, 1], name='test_move_invalid', isolated=False)
         self.created_cpusets.append('test_move_invalid')
 
-        # Try to move non-existent PID (should succeed but report 0 moved, 1 failed)
-        # Since we can't easily capture stdout, just verify it doesn't crash
-        cpuset_move(name='test_move_invalid', thread_list=[999999], pid_list=None)
+        # Try to move non-existent PID - should exit with error since all moves failed
+        with self.assertRaises(SystemExit) as cm:
+            cpuset_move('test_move_invalid', thread_list=[999999], pid_list=None)
+        self.assertEqual(cm.exception.code, 1)
+
+    def test_move_blocklisted_process(self):
+        """Test that blocklisted processes (like systemd) cannot be moved"""
+        # Create a cpuset
+        cpuset_create(cpu_list=[0, 1], name='test_move_blocklist', isolated=False)
+        self.created_cpusets.append('test_move_blocklist')
+
+        # Try to move PID 1 (systemd) - should be blocked and exit with error
+        # since all moves failed (success_count == 0)
+        with self.assertRaises(SystemExit) as cm:
+            cpuset_move('test_move_blocklist', thread_list=None, pid_list='1')
+        self.assertEqual(cm.exception.code, 1)
+
+        # Verify PID 1 is NOT in the cpuset
+        with open('/sys/fs/cgroup/test_move_blocklist/cgroup.procs') as f:
+            pids = f.read().strip().split('\n')
+        self.assertNotIn('1', pids, "PID 1 (systemd) should not be in the cpuset")
+
+    def test_move_mixed_blocklisted_and_normal(self):
+        """Test moving mix of blocklisted and normal processes"""
+        # Create a cpuset
+        cpuset_create(cpu_list=[0, 1], name='test_move_mixed', isolated=False)
+        self.created_cpusets.append('test_move_mixed')
+
+        # Try to move both PID 1 (blocklisted) and our own PID (normal)
+        current_pid = os.getpid()
+        cpuset_move('test_move_mixed', thread_list=None, pid_list=f'1,{current_pid}')
+
+        # Verify PID 1 is NOT in the cpuset
+        with open('/sys/fs/cgroup/test_move_mixed/cgroup.procs') as f:
+            pids = f.read().strip().split('\n')
+        self.assertNotIn('1', pids, "PID 1 should be blocked")
+        # Our PID should be there
+        self.assertIn(str(current_pid), pids, "Normal process should be moved")
 
 
 def suite():
diff --git a/tests/test_process_blocklist.py b/tests/test_process_blocklist.py
new file mode 100644
index 000000000000..67678f024f85
--- /dev/null
+++ b/tests/test_process_blocklist.py
@@ -0,0 +1,139 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-only
+"""
+Unit tests for process blocklist functionality.
+
+Tests verify that critical system processes (systemd, systemd-logind, etc.)
+are never moved to custom cpusets to prevent system instability and shutdown issues.
+"""
+
+import unittest
+import os
+import sys
+
+# Add parent directory to path for imports
+sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
+
+from tuna import cpuset
+
+
+class TestProcessBlocklist(unittest.TestCase):
+    """Test cases for process blocklist functionality"""
+
+    def test_blocklist_constant_exists(self):
+        """Test that PROCESS_BLOCKLIST is defined"""
+        self.assertIsNotNone(cpuset.PROCESS_BLOCKLIST)
+        self.assertIsInstance(cpuset.PROCESS_BLOCKLIST, set)
+        self.assertGreater(len(cpuset.PROCESS_BLOCKLIST), 0)
+
+    def test_blocklist_contains_critical_processes(self):
+        """Test that blocklist contains expected critical processes"""
+        expected_processes = {'systemd', 'systemd-logind', 'systemd-journald'}
+        for proc in expected_processes:
+            self.assertIn(proc, cpuset.PROCESS_BLOCKLIST,
+                         f"Critical process '{proc}' should be in blocklist")
+
+    def test_get_process_name_for_init(self):
+        """Test getting process name for PID 1 (init/systemd)"""
+        name = cpuset.Cpuset._get_process_name(1)
+        self.assertIsNotNone(name)
+        # PID 1 is typically systemd on modern systems, but could be init
+        self.assertIn(name, ['systemd', 'init'],
+                     f"PID 1 should be systemd or init, got: {name}")
+
+    def test_get_process_name_for_nonexistent_pid(self):
+        """Test getting process name for non-existent PID"""
+        # Use a very high PID that's unlikely to exist
+        name = cpuset.Cpuset._get_process_name(999999)
+        self.assertIsNone(name)
+
+    def test_get_process_name_for_self(self):
+        """Test getting process name for our own process"""
+        pid = os.getpid()
+        name = cpuset.Cpuset._get_process_name(pid)
+        self.assertIsNotNone(name)
+        # Should be python3 or similar
+        self.assertIn('python', name.lower())
+
+    def test_is_process_blocklisted_for_init(self):
+        """Test that PID 1 (systemd) is blocklisted"""
+        # This test works without root - just checks if PID 1 would be blocked
+        is_blocked = cpuset.Cpuset._is_process_blocklisted(1)
+        self.assertTrue(is_blocked, "PID 1 (systemd/init) should be blocklisted")
+
+    def test_is_process_blocklisted_for_normal_process(self):
+        """Test that normal processes are not blocklisted"""
+        pid = os.getpid()
+        is_blocked = cpuset.Cpuset._is_process_blocklisted(pid)
+        self.assertFalse(is_blocked, "Normal processes should not be blocklisted")
+
+    def test_is_process_blocklisted_for_nonexistent_pid(self):
+        """Test that non-existent PIDs are not considered blocklisted"""
+        is_blocked = cpuset.Cpuset._is_process_blocklisted(999999)
+        self.assertFalse(is_blocked, "Non-existent PIDs should not be blocklisted")
+
+    @unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+    @unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+    def test_write_pid_blocks_systemd(self):
+        """Test that write_pid actually blocks systemd from being moved"""
+        ci = cpuset.CpusetsInit()
+        cs = cpuset.Cpuset('test_blocklist_systemd')
+
+        try:
+            cs.write_memnode('0')
+            cs.assign_cpus('0')
+
+            # Try to move PID 1 (systemd)
+            result = cs.write_pid(1)
+
+            # Should return False (blocked)
+            self.assertFalse(result, "write_pid should return False for systemd (PID 1)")
+
+            # Verify PID 1 is NOT in the cpuset
+            tasks = cs.get_tasks()
+            self.assertNotIn('1', tasks, "PID 1 should not be in the cpuset")
+
+        finally:
+            # Cleanup
+            try:
+                tm = cpuset.TaskMigrate(cs, ci)
+                tm.migrate()
+                cs.destroy()
+            except:
+                pass
+
+    @unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+    @unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+    def test_write_pid_allows_normal_process(self):
+        """Test that write_pid still allows normal processes to be moved"""
+        ci = cpuset.CpusetsInit()
+        cs = cpuset.Cpuset('test_blocklist_normal')
+
+        try:
+            cs.write_memnode('0')
+            cs.assign_cpus('0')
+
+            # Try to move our own PID
+            pid = os.getpid()
+            result = cs.write_pid(pid)
+
+            # Should return True (allowed)
+            self.assertTrue(result, "write_pid should return True for normal processes")
+
+            # Verify our PID is in the cpuset
+            tasks = cs.get_tasks()
+            self.assertIn(str(pid), tasks, "Our PID should be in the cpuset")
+
+        finally:
+            # Cleanup - migrate back and destroy
+            try:
+                tm = cpuset.TaskMigrate(cs, ci)
+                tm.migrate()
+                cs.destroy()
+            except:
+                pass
+
+
+if __name__ == '__main__':
+    unittest.main()
diff --git a/tuna-cmd.py b/tuna-cmd.py
index 04c72a5352ac..50e6e9f9d937 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -296,7 +296,7 @@ def gen_parser():
 
     # cpuset move
     cpuset_move = cpuset_subparser.add_parser('move', description='Move processes to a cpuset', help='Move processes to a cpuset')
-    cpuset_move.add_argument('-n', '--name', type=str, metavar='NAME', required=True, help='Cpuset name to move processes to')
+    cpuset_move.add_argument('name', type=str, metavar='NAME', help='Cpuset name to move processes to')
     cpuset_move.add_argument('-t', '--threads', **MODS['threads'])
     cpuset_move.add_argument('-p', '--pids', dest='pid_list', type=str, metavar='PID-LIST', help='Comma-separated list of PIDs to move')
 
@@ -1082,12 +1082,19 @@ def cpuset_move(name, thread_list, pid_list):
     # Move each PID to the cpuset
     success_count = 0
     fail_count = 0
+    blocked_count = 0
 
     for pid in pids:
-        if cs.write_pid(pid):
+        # Check if process is on the blocklist before attempting to move
+        if cpuset.Cpuset._is_process_blocklisted(pid):
+            comm = cpuset.Cpuset._get_process_name(pid)
+            print(f"Skipping PID {pid} ({comm}): critical system process", file=sys.stderr)
+            fail_count += 1
+            blocked_count += 1
+        elif cs.write_pid(pid):
             success_count += 1
         else:
-            # write_pid returns False on failure
+            # write_pid returns False on failure (permission, process gone, etc.)
             print(f"Warning: failed to move PID {pid} to cpuset '{name}'", file=sys.stderr)
             fail_count += 1
 
diff --git a/tuna/cpuset.py b/tuna/cpuset.py
index 513e1b198c38..79f86d8cfe9f 100644
--- a/tuna/cpuset.py
+++ b/tuna/cpuset.py
@@ -16,6 +16,16 @@ from glob import glob
 
 logger = logging.getLogger(__name__)
 
+# Blocklist of critical processes that should never be moved to custom cpusets
+# Moving these processes can break system functionality and prevent clean shutdown
+PROCESS_BLOCKLIST = {
+    'systemd',           # PID 1 - init system
+    'systemd-logind',    # Session/power management - critical for shutdown
+    'systemd-journald',  # Logging daemon
+    'dbus-daemon',       # D-Bus system message bus
+    'dbus-broker',       # Alternative D-Bus implementation
+}
+
 
 class Cpuset:
     """ Class for manipulating cpusets """
@@ -109,12 +119,44 @@ class Cpuset:
         with open(path, 'w', encoding='utf-8') as f:
             f.write(cpu_str)
 
+    @staticmethod
+    def _get_process_name(pid):
+        """
+        Get the process name (comm) for a given PID
+        Returns None if the process doesn't exist or can't be read
+        """
+        try:
+            with open(f'/proc/{pid}/comm', 'r', encoding='utf-8') as f:
+                return f.read().strip()
+        except (OSError, FileNotFoundError):
+            return None
+
+    @staticmethod
+    def _is_process_blocklisted(pid):
+        """
+        Check if a process is on the blocklist of critical system processes
+        Returns True if the process should not be moved to a custom cpuset
+        """
+        comm = Cpuset._get_process_name(pid)
+        if comm is None:
+            return False
+        return comm in PROCESS_BLOCKLIST
+
     def write_pid(self, pid):
         """
         Place a pid in a cpuset
         Returns True if successful, False if the process cannot be moved
         Raises OSError for unexpected errors
+
+        Note: Critical system processes (systemd, systemd-logind, etc.) are
+        automatically skipped to prevent system instability and shutdown issues.
         """
+        # Check if process is on the blocklist
+        if self._is_process_blocklisted(pid):
+            comm = self._get_process_name(pid)
+            logger.info(f"Skipping blocklisted process {pid} ({comm})")
+            return False
+
         path = os.path.join(self._cpuset_path, "cgroup.procs")
         pid_str = str(pid)
         try:
-- 
2.54.0

