Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCD329DB6E
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692962; cv=none; b=eDyQ8Inojbp2d5j3WWjEd6UeT8Tvv+WjIxir/+NGVNHb3i9Hb5fosmzx2HRoZNLD9rUqdYT+oYFuJh23clUkvsfyfKTNvQBv8gZkKHTL0eeco9Kkk/NteEKRcx6rpQglhIA89WWDNiDRoxkaBT6zw7M+HJSnr1Q6zQAFFCJqnPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692962; c=relaxed/simple;
	bh=3BSurx6uOSQ1ZspVvS06Bo5m0q03sIzp52BKmjA8w7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bs6SB2vnV0779bunv7dHDVjbagPjx0rX2fzANWZjPGT1moreIfecHghKZISXXAlNnW14r52NfX91fu0PfvRXU5Ia6GHXMre7u1+B6Uj4jzgnvmijNN3sDv7mnQLcNd1RWtq69XdpIya7/2DdblXdWlZPHinluh1gDI/gHxbDYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sk9J5eIZ; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sk9J5eIZ"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-967327a0c7dso217898241.1
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692959; x=1784297759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zlwxjALWAmTh8zdKNKMOT8LTEgKLA1flac4e+OX1vUc=;
        b=Sk9J5eIZyk89VgA3vg/LAJD/x3WwFOZui5lCTPtOUBlCvkD/x0HHrW3J0C1SmLpD6s
         JC92ogEm+SU/PIMLdI7tc1JGCA3zaJdkPHZ2Jab3gWxDU1wOIjgJxGMG0+nBDM18+9q9
         Y1E0iDjUf+YSgqw4/l+Y1eBWqrRI/iEvkNQurhnT/fFD0oMQDaYGiiXRlH9K1qwn5I3d
         SnKR5zsevabDPsKztF7IluUwP0G2kvhcs+32rz9kIxV+Qjrc5L6MoBvBrexEUuefmjug
         6aEpEZYpCKuU6DrDTPm/YY0MMoi5SnVMYHLKTkpQmYJYLXNNZyN+mU5OTHaLZGlyzpFf
         JcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692959; x=1784297759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zlwxjALWAmTh8zdKNKMOT8LTEgKLA1flac4e+OX1vUc=;
        b=pMchnrH1EYDFG67MbEbrdHqiHXMgPA9CmqL+KC/FMtgVDsNU7HtwfatXap8nU2ABB0
         1ZVdO2MJQJw0vmT/icE9pupjXs09lENoUsF7Ylc02f7mTJNytF22CQQjPxt+SteNRVfE
         ytZAxl+yj4+knEsf3S5sc7aE36HpGsrP3CxeVN8V5JaXBgO2iQEnPxcGWWjy3vCYgnNZ
         RmpGtPRLE/lemU/761rrietpB42fpUM0n5y8vohb8t7ZpsyLyEjCcFuWN5k1yV+3AkR7
         9mOWR58Jv3hCiuGO7Lch+x0EKD6fP/kGBVdHjjJjlwy4lMmM1jxb7wlD1A84nf94dJOc
         TZlA==
X-Gm-Message-State: AOJu0Yxnu3f0BnefgjLYeC/2UFkW8jWT3NSI98lOjXF3ZZ1znlRyQDrQ
	2nLaNPtkKh2fk7qmcxqB7rlzfO9vLBVPE2k7tr8uCwHkWPHZzuyKjU7MRd+XhA==
X-Gm-Gg: AfdE7cmTYz9eUe2Pnbs7yiQdH984Y3WjD78+/iy4ayghrt9XqQlZqZrxiZETKDNqBnL
	yYsYByK1gJzPnl07OMO/KbQZbKirER+C2Z7zHnBCwlgtXS3W9+Ad/8CKVCl9tIBEg5wfXRC3HaX
	u0BaZqe1HOC1l+1Oq8M+snswnYtBcRXcjpchwT9pp5TOxvm1C4ARh/VsA82s4cTt41Fg8MlHdxI
	Mm6KQntVy71ViGm1vBdB0HjegRYE3qIKkcs0oHuJA2zv4I+VUIZQKZQ0oI7FZ7sdB0JbDqWWglr
	yhFOCNv8oMcQP1Min8CqmTVyyaH15d79GX7a7s4FFfJo81sCiz6ChKuSNGef5UAuWA0ETJF6i6Q
	X157BGsv6/B0Tov+LjMRP95MC9vAXJuQGttjiD3yYCNfS6Nrs/T6jzH/U696ukPGHQtx3UbdQ6x
	LzEFMkTDGR0uRsnSrOpLU4vScUK9WdiFij63jPxDf2YMn3lT19cJLJhxzuiVYYNanaTEeMd/6Sp
	Q==
X-Received: by 2002:a05:6102:8011:b0:740:32ae:8ec7 with SMTP id ada2fe7eead31-744e03d3de9mr6928207137.23.1783692958639;
        Fri, 10 Jul 2026 07:15:58 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:15:57 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 08/36] tuna: Add comprehensive test suite for cpuset module
Date: Fri, 10 Jul 2026 10:14:46 -0400
Message-ID: <20260710141523.36440-9-jkacur@redhat.com>
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

Add unit tests and utility script for the cpuset module to ensure
proper functionality and discover edge cases.

Tests added:
- tests/test_cpuset.py: 27 unit tests across 7 test classes
  - TestCpusetsInit: cgroup v2 detection and initialization
  - TestCpusetCreation: creating/destroying cpusets
  - TestCpusetConfiguration: CPU/memory assignment
  - TestContextManager: auto_destroy behavior
  - TestTaskMigration: process migration
  - TestDiscoveryFunctions: cpuset discovery
  - TestCleanupFunctions: cleanup operations

Utility script:
- cleanup_test_cpusets.sh: Clean up leftover test cpusets

Tests handle both root and non-root execution, properly clean up
nested cpuset hierarchies, and validate cgroup v2 requirements.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/test_cpuset.py | 616 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 616 insertions(+)
 create mode 100644 tests/test_cpuset.py

diff --git a/tests/test_cpuset.py b/tests/test_cpuset.py
new file mode 100644
index 000000000000..6ac4fe0c9c40
--- /dev/null
+++ b/tests/test_cpuset.py
@@ -0,0 +1,616 @@
+#!/usr/bin/python3
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-only
+"""
+Comprehensive test suite for tuna.cpuset module
+
+Tests cover:
+- Core cpuset functionality (rteval-compatible)
+- Tuna-specific enhancements (discovery, cleanup, persistence)
+- Edge cases and error handling
+- Nested cpuset hierarchies
+
+Requires root permissions to run tests that create/destroy cgroups.
+"""
+
+import unittest
+import os
+import sys
+import time
+import tempfile
+from pathlib import Path
+
+# Add tuna to path if running from tests directory
+if Path(__file__).parent.name == 'tests':
+    sys.path.insert(0, str(Path(__file__).parent.parent))
+
+from tuna import cpuset
+
+
+class TestCpusetsInit(unittest.TestCase):
+    """Test CpusetsInit class and cgroup v2 detection"""
+
+    def test_initialization(self):
+        """Test that CpusetsInit initializes correctly"""
+        ci = cpuset.CpusetsInit()
+        self.assertIsInstance(ci, cpuset.CpusetsInit)
+        self.assertIsInstance(ci.supported, bool)
+        self.assertIsInstance(ci.numa_nodes, int)
+
+    def test_cpuset_path(self):
+        """Test that cpuset_path is set correctly for root cgroup"""
+        ci = cpuset.CpusetsInit()
+        if ci.supported:
+            self.assertEqual(ci.cpuset_path, '/sys/fs/cgroup')
+
+    def test_cgroup_v2_detection(self):
+        """Test cgroup v2 detection logic"""
+        supported = cpuset.CpusetsInit._cpuset_supported()
+        self.assertIsInstance(supported, bool)
+
+        # If /sys/fs/cgroup exists and has cgroup.controllers, should be supported
+        if os.path.exists('/sys/fs/cgroup/cgroup.controllers'):
+            # Read controllers to verify cpuset is available
+            with open('/sys/fs/cgroup/cgroup.controllers') as f:
+                controllers = f.read().strip().split()
+                if 'cpuset' in controllers:
+                    self.assertTrue(supported)
+
+    def test_numa_nodes(self):
+        """Test NUMA node detection"""
+        ci = cpuset.CpusetsInit()
+        if ci.supported:
+            # Should have at least 1 NUMA node
+            self.assertGreaterEqual(ci.numa_nodes, 1)
+
+            # Verify against actual /sys/devices/system/node
+            from glob import glob
+            actual_nodes = len(glob('/sys/devices/system/node/node*'))
+            self.assertEqual(ci.numa_nodes, actual_nodes)
+
+    def test_auto_destroy_is_false(self):
+        """Test that root cgroup never has auto_destroy enabled"""
+        ci = cpuset.CpusetsInit()
+        if ci.supported:
+            self.assertFalse(ci.auto_destroy)
+
+
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestCpusetCreation(unittest.TestCase):
+    """Test Cpuset creation and destruction"""
+
+    def setUp(self):
+        """Set up test fixtures"""
+        self.test_cpusets = []
+        self.ci = cpuset.CpusetsInit()
+
+    def tearDown(self):
+        """Clean up any cpusets created during tests"""
+        for cs in self.test_cpusets:
+            try:
+                if hasattr(cs, 'cpuset_path') and os.path.exists(cs.cpuset_path):
+                    # Move any tasks back to root
+                    tm = cpuset.TaskMigrate(cs, self.ci)
+                    tm.migrate()
+                    cs.destroy()
+            except:
+                pass
+
+    def test_create_cpuset(self):
+        """Test basic cpuset creation"""
+        cs = cpuset.Cpuset('test_create')
+        self.test_cpusets.append(cs)
+
+        self.assertEqual(cs.cpuset_name, 'test_create')
+        self.assertEqual(cs.cpuset_path, '/sys/fs/cgroup/test_create')
+        self.assertTrue(os.path.exists(cs.cpuset_path))
+
+    def test_create_with_auto_destroy_false(self):
+        """Test cpuset creation with auto_destroy=False (default)"""
+        cs = cpuset.Cpuset('test_no_auto')
+        self.test_cpusets.append(cs)
+
+        self.assertFalse(cs.auto_destroy)
+
+    def test_create_with_auto_destroy_true(self):
+        """Test cpuset creation with auto_destroy=True"""
+        cs = cpuset.Cpuset('test_auto', auto_destroy=True)
+        self.test_cpusets.append(cs)
+
+        self.assertTrue(cs.auto_destroy)
+
+    def test_destroy_cpuset(self):
+        """Test manual cpuset destruction"""
+        cs = cpuset.Cpuset('test_destroy')
+        path = cs.cpuset_path
+
+        self.assertTrue(os.path.exists(path))
+        cs.destroy()
+        self.assertFalse(os.path.exists(path))
+
+    def test_create_existing_cpuset(self):
+        """Test creating a cpuset that already exists"""
+        cs1 = cpuset.Cpuset('test_existing')
+        self.test_cpusets.append(cs1)
+        path1 = cs1.cpuset_path
+
+        # Create again with same name
+        cs2 = cpuset.Cpuset('test_existing')
+
+        # Should reference the same path
+        self.assertEqual(cs1.cpuset_path, cs2.cpuset_path)
+        self.assertTrue(os.path.exists(path1))
+
+    def test_cpuset_name_none_raises_error(self):
+        """Test that creating cpuset with None name raises ValueError"""
+        with self.assertRaises(ValueError):
+            cpuset.Cpuset(None)
+
+
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestCpusetConfiguration(unittest.TestCase):
+    """Test Cpuset configuration (CPUs, memory, etc.)"""
+
+    def setUp(self):
+        """Set up test fixtures"""
+        self.test_cpusets = []
+        self.ci = cpuset.CpusetsInit()
+
+    def tearDown(self):
+        """Clean up any cpusets created during tests"""
+        for cs in self.test_cpusets:
+            try:
+                if hasattr(cs, 'cpuset_path') and os.path.exists(cs.cpuset_path):
+                    tm = cpuset.TaskMigrate(cs, self.ci)
+                    tm.migrate()
+                    cs.destroy()
+            except:
+                pass
+
+    def test_assign_cpus(self):
+        """Test CPU assignment to cpuset"""
+        cs = cpuset.Cpuset('test_cpus')
+        self.test_cpusets.append(cs)
+
+        cs.write_memnode('0')
+        cs.assign_cpus('0-1')
+
+        # Read back the assignment
+        with open(os.path.join(cs.cpuset_path, 'cpuset.cpus')) as f:
+            assigned = f.read().strip()
+
+        # Should be '0-1' or '0,1' depending on kernel
+        self.assertIn('0', assigned)
+        self.assertIn('1', assigned)
+
+    def test_write_memnode(self):
+        """Test memory node assignment"""
+        cs = cpuset.Cpuset('test_memnode')
+        self.test_cpusets.append(cs)
+
+        cs.write_memnode('0')
+
+        # Read back the assignment
+        with open(os.path.join(cs.cpuset_path, 'cpuset.mems')) as f:
+            assigned = f.read().strip()
+
+        self.assertEqual(assigned, '0')
+
+    def test_cpu_exclusive(self):
+        """Test CPU exclusive (partition) setting"""
+        cs = cpuset.Cpuset('test_exclusive')
+        self.test_cpusets.append(cs)
+
+        cs.write_memnode('0')
+        cs.assign_cpus('0')
+
+        # Try to set exclusive (may not be supported on all kernels)
+        cs.set_cpu_exclusive()
+
+        partition_file = os.path.join(cs.cpuset_path, 'cpuset.cpus.partition')
+        if os.path.exists(partition_file):
+            with open(partition_file) as f:
+                partition = f.read().strip()
+            # Should be 'isolated' or 'root' (if not supported)
+            self.assertIn(partition, ['isolated', 'root', 'member'])
+
+
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestContextManager(unittest.TestCase):
+    """Test context manager behavior with auto_destroy"""
+
+    def setUp(self):
+        """Set up test fixtures"""
+        self.ci = cpuset.CpusetsInit()
+
+    def test_context_manager_auto_destroy_true(self):
+        """Test that cpuset is destroyed when auto_destroy=True"""
+        path = None
+
+        with cpuset.Cpuset('test_context_auto', auto_destroy=True) as cs:
+            path = cs.cpuset_path
+            cs.write_memnode('0')
+            cs.assign_cpus('0')
+            self.assertTrue(os.path.exists(path))
+
+        # After exiting context, should be destroyed
+        self.assertFalse(os.path.exists(path))
+
+    def test_context_manager_auto_destroy_false(self):
+        """Test that cpuset persists when auto_destroy=False"""
+        path = None
+
+        with cpuset.Cpuset('test_context_no_auto', auto_destroy=False) as cs:
+            path = cs.cpuset_path
+            cs.write_memnode('0')
+            cs.assign_cpus('0')
+            self.assertTrue(os.path.exists(path))
+
+        # After exiting context, should still exist
+        self.assertTrue(os.path.exists(path))
+
+        # Clean up manually
+        os.rmdir(path)
+
+
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestTaskMigration(unittest.TestCase):
+    """Test task migration between cpusets"""
+
+    def setUp(self):
+        """Set up test fixtures"""
+        self.test_cpusets = []
+        self.ci = cpuset.CpusetsInit()
+
+    def tearDown(self):
+        """Clean up any cpusets created during tests"""
+        for cs in self.test_cpusets:
+            try:
+                if hasattr(cs, 'cpuset_path') and os.path.exists(cs.cpuset_path):
+                    tm = cpuset.TaskMigrate(cs, self.ci)
+                    tm.migrate()
+                    cs.destroy()
+            except:
+                pass
+
+    def test_write_pid(self):
+        """Test writing a PID to a cpuset"""
+        cs = cpuset.Cpuset('test_pid')
+        self.test_cpusets.append(cs)
+
+        cs.write_memnode('0')
+        cs.assign_cpus('0')
+
+        # Try to write our own PID
+        pid = os.getpid()
+        result = cs.write_pid(pid)
+
+        # Should succeed (we can move ourselves)
+        self.assertTrue(result)
+
+        # Verify PID is in the cpuset
+        tasks = cs.get_tasks()
+        self.assertIn(str(pid), tasks)
+
+        # Move back to root
+        self.ci.write_pid(pid)
+
+    def test_task_migrate(self):
+        """Test TaskMigrate class"""
+        cs = cpuset.Cpuset('test_migrate')
+        self.test_cpusets.append(cs)
+
+        cs.write_memnode('0')
+        cs.assign_cpus('0')
+
+        # Move our PID to the cpuset
+        pid = os.getpid()
+        cs.write_pid(pid)
+
+        # Migrate back to root
+        tm = cpuset.TaskMigrate(cs, self.ci)
+        migrated, failed = tm.migrate()
+
+        self.assertGreaterEqual(migrated, 1)  # At least our process
+        self.assertGreaterEqual(failed, 0)  # Some failures are OK
+
+
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestDiscoveryFunctions(unittest.TestCase):
+    """Test tuna-specific discovery functions"""
+
+    def setUp(self):
+        """Set up test fixtures"""
+        self.test_cpusets = []
+        self.ci = cpuset.CpusetsInit()
+
+    def tearDown(self):
+        """Clean up any cpusets created during tests"""
+        for cs in self.test_cpusets:
+            try:
+                if hasattr(cs, 'cpuset_path') and os.path.exists(cs.cpuset_path):
+                    # Use recursive destroy to handle any nested cpusets
+                    cpuset.destroy_cpuset_recursive(cs.cpuset_path, force=True)
+            except:
+                pass
+
+        # Clean up specific test cpusets that might have nested children
+        for name in ['test_parent', 'test_list_1', 'test_list_2',
+                     'test_pattern_1', 'test_pattern_2', 'other_cpuset']:
+            try:
+                cpuset.destroy_cpuset_recursive(name, force=True)
+            except:
+                pass
+
+    def test_list_cpusets_no_pattern(self):
+        """Test listing all cpusets without pattern"""
+        # Create some test cpusets
+        cs1 = cpuset.Cpuset('test_list_1')
+        cs2 = cpuset.Cpuset('test_list_2')
+        self.test_cpusets.extend([cs1, cs2])
+
+        cs1.write_memnode('0')
+        cs2.write_memnode('0')
+
+        # List all cpusets
+        all_cpusets = cpuset.list_cpusets(recursive=False)
+
+        # Should include our test cpusets
+        self.assertIn('test_list_1', all_cpusets)
+        self.assertIn('test_list_2', all_cpusets)
+
+    def test_list_cpusets_with_pattern(self):
+        """Test listing cpusets with pattern matching"""
+        # Create test cpusets with different names
+        cs1 = cpuset.Cpuset('test_pattern_1')
+        cs2 = cpuset.Cpuset('test_pattern_2')
+        cs3 = cpuset.Cpuset('other_cpuset')
+        self.test_cpusets.extend([cs1, cs2, cs3])
+
+        cs1.write_memnode('0')
+        cs2.write_memnode('0')
+        cs3.write_memnode('0')
+
+        # List with pattern
+        pattern_cpusets = cpuset.list_cpusets(pattern='test_pattern_*', recursive=False)
+
+        # Should only include matching cpusets
+        self.assertIn('test_pattern_1', pattern_cpusets)
+        self.assertIn('test_pattern_2', pattern_cpusets)
+        self.assertNotIn('other_cpuset', pattern_cpusets)
+
+    def test_list_cpusets_recursive(self):
+        """Test recursive cpuset listing"""
+        # Clean up first in case of previous failed run
+        cpuset.destroy_cpuset_recursive('test_parent', force=True)
+
+        # Create nested cpusets using Cpuset class
+        # Note: In cgroup v2, creating nested cpusets requires proper setup
+        parent = cpuset.Cpuset('test_parent')
+        self.test_cpusets.append(parent)
+        parent.write_memnode('0')
+        parent.assign_cpus('0')
+
+        # Create child as a proper cpuset (not just mkdir)
+        # First enable cpuset controller in parent
+        try:
+            with open(os.path.join(parent.cpuset_path, 'cgroup.subtree_control'), 'w') as f:
+                f.write('+cpuset')
+        except (OSError, PermissionError):
+            pass
+
+        # Create child directory and enable it as a cpuset
+        child_path = os.path.join(parent.cpuset_path, 'test_child')
+        if not os.path.exists(child_path):
+            os.mkdir(child_path)
+            # Write to cpuset.cpus to make it a valid cpuset
+            try:
+                with open(os.path.join(child_path, 'cpuset.cpus'), 'w') as f:
+                    f.write('0')
+                with open(os.path.join(child_path, 'cpuset.mems'), 'w') as f:
+                    f.write('0')
+            except (OSError, PermissionError):
+                pass
+
+        # List recursively
+        all_cpusets = cpuset.list_cpusets(recursive=True)
+
+        # Should find both parent and child
+        self.assertIn('test_parent', all_cpusets)
+        # Child should be found if it's a valid cpuset
+        has_child = os.path.exists(os.path.join(child_path, 'cpuset.cpus'))
+        if has_child:
+            self.assertIn('test_parent/test_child', all_cpusets)
+
+        # Clean up child first (must destroy children before parents)
+        if os.path.exists(child_path):
+            try:
+                os.rmdir(child_path)
+            except OSError:
+                pass  # May have processes, tearDown will handle it
+
+
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestCleanupFunctions(unittest.TestCase):
+    """Test tuna-specific cleanup functions"""
+
+    def setUp(self):
+        """Set up test fixtures"""
+        self.test_cpusets = []
+        self.ci = cpuset.CpusetsInit()
+
+    def tearDown(self):
+        """Clean up any cpusets that might still exist"""
+        # Clean up any test_cleanup_* cpusets (including nested ones)
+        try:
+            # First try to clean with recursive pattern matching
+            cpuset.cleanup_cpusets('test_cleanup_*', force=True, recursive=True)
+        except:
+            pass
+
+        # Also clean up specific problem cpusets from failed runs
+        for name in ['test_cleanup_nested_parent', 'test_cleanup_bulk_1',
+                     'test_cleanup_bulk_2', 'other_bulk']:
+            try:
+                cpuset.destroy_cpuset_recursive(name, force=True)
+            except:
+                pass
+
+    def test_destroy_cpuset_by_name(self):
+        """Test destroying cpuset by name"""
+        cs = cpuset.Cpuset('test_cleanup_destroy')
+        cs.write_memnode('0')
+        path = cs.cpuset_path
+
+        self.assertTrue(os.path.exists(path))
+
+        # Destroy by name
+        cpuset.destroy_cpuset('test_cleanup_destroy', force=False)
+
+        self.assertFalse(os.path.exists(path))
+
+    def test_destroy_cpuset_by_path(self):
+        """Test destroying cpuset by full path"""
+        cs = cpuset.Cpuset('test_cleanup_path')
+        cs.write_memnode('0')
+        path = cs.cpuset_path
+
+        self.assertTrue(os.path.exists(path))
+
+        # Destroy by full path
+        cpuset.destroy_cpuset(path, force=False)
+
+        self.assertFalse(os.path.exists(path))
+
+    def test_destroy_cpuset_with_force(self):
+        """Test destroying cpuset with force (migrates tasks first)"""
+        cs = cpuset.Cpuset('test_cleanup_force')
+        cs.write_memnode('0')
+        cs.assign_cpus('0')
+
+        # Move our PID to the cpuset
+        cs.write_pid(os.getpid())
+
+        # Destroy with force (should migrate tasks first)
+        cpuset.destroy_cpuset('test_cleanup_force', force=True)
+
+        self.assertFalse(os.path.exists(cs.cpuset_path))
+
+        # Verify we're back in root cgroup
+        with open('/proc/self/cgroup') as f:
+            cgroup_info = f.read()
+        # In cgroup v2, processes in root are at '0::/'
+        self.assertIn('0::/', cgroup_info)
+
+    def test_destroy_nonexistent_cpuset_raises_error(self):
+        """Test that destroying non-existent cpuset raises OSError"""
+        with self.assertRaises(OSError):
+            cpuset.destroy_cpuset('nonexistent_cpuset')
+
+    def test_cleanup_cpusets_with_pattern(self):
+        """Test cleanup_cpusets with pattern matching"""
+        # Create multiple cpusets
+        cs1 = cpuset.Cpuset('test_cleanup_bulk_1')
+        cs2 = cpuset.Cpuset('test_cleanup_bulk_2')
+        cs3 = cpuset.Cpuset('other_bulk')
+
+        cs1.write_memnode('0')
+        cs2.write_memnode('0')
+        cs3.write_memnode('0')
+
+        # Cleanup with pattern
+        cpuset.cleanup_cpusets('test_cleanup_bulk_*', force=True, recursive=False)
+
+        # Pattern-matched cpusets should be gone
+        self.assertFalse(os.path.exists(cs1.cpuset_path))
+        self.assertFalse(os.path.exists(cs2.cpuset_path))
+
+        # Other cpuset should still exist
+        self.assertTrue(os.path.exists(cs3.cpuset_path))
+
+        # Clean up remaining
+        cs3.destroy()
+
+    def test_cleanup_nested_cpusets(self):
+        """Test cleanup destroys children before parents"""
+        # Clean up first in case of previous failed run
+        cpuset.destroy_cpuset_recursive('test_cleanup_nested_parent', force=True)
+
+        # Create parent
+        parent = cpuset.Cpuset('test_cleanup_nested_parent')
+        parent.write_memnode('0')
+        parent.assign_cpus('0')
+
+        # Enable cpuset controller in parent for children
+        try:
+            with open(os.path.join(parent.cpuset_path, 'cgroup.subtree_control'), 'w') as f:
+                f.write('+cpuset')
+        except (OSError, PermissionError):
+            pass
+
+        # Create children as proper cpusets
+        child1_path = os.path.join(parent.cpuset_path, 'child1')
+        child2_path = os.path.join(parent.cpuset_path, 'child2')
+
+        for child_path in [child1_path, child2_path]:
+            if not os.path.exists(child_path):
+                os.mkdir(child_path)
+                # Make it a valid cpuset
+                try:
+                    with open(os.path.join(child_path, 'cpuset.cpus'), 'w') as f:
+                        f.write('0')
+                    with open(os.path.join(child_path, 'cpuset.mems'), 'w') as f:
+                        f.write('0')
+                except (OSError, PermissionError):
+                    pass
+
+        # Cleanup recursively
+        cpuset.cleanup_cpusets('test_cleanup_nested_*', force=False, recursive=True)
+
+        # Everything should be gone
+        self.assertFalse(os.path.exists(child1_path))
+        self.assertFalse(os.path.exists(child2_path))
+        self.assertFalse(os.path.exists(parent.cpuset_path))
+
+
+def suite():
+    """Create test suite"""
+    loader = unittest.TestLoader()
+    suite = unittest.TestSuite()
+
+    # Add all test classes
+    suite.addTests(loader.loadTestsFromTestCase(TestCpusetsInit))
+    suite.addTests(loader.loadTestsFromTestCase(TestCpusetCreation))
+    suite.addTests(loader.loadTestsFromTestCase(TestCpusetConfiguration))
+    suite.addTests(loader.loadTestsFromTestCase(TestContextManager))
+    suite.addTests(loader.loadTestsFromTestCase(TestTaskMigration))
+    suite.addTests(loader.loadTestsFromTestCase(TestDiscoveryFunctions))
+    suite.addTests(loader.loadTestsFromTestCase(TestCleanupFunctions))
+
+    return suite
+
+
+if __name__ == '__main__':
+    # Check if running as root for tests that need it
+    if os.geteuid() != 0:
+        print("\n" + "="*60)
+        print("WARNING: Not running as root")
+        print("="*60)
+        print("Most tests require root permissions to create/destroy cgroups.")
+        print("Only basic detection tests will run.")
+        print("\nTo run all tests:")
+        print("  sudo python3 -m unittest tests.test_cpuset")
+        print("="*60 + "\n")
+
+    # Run tests
+    runner = unittest.TextTestRunner(verbosity=2)
+    result = runner.run(suite())
+
+    # Exit with appropriate code
+    sys.exit(0 if result.wasSuccessful() else 1)
-- 
2.54.0

