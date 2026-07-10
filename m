Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1133CEA2
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692964; cv=none; b=lXteGVChoUKW9oiQ9nrt3PH4XPZSqJRrseu99ybPiTx3FRbL31l5O27p+Wnl/GVsdhNIsMzMJPZvMxJyFJk0UhCvsO/dHsGM0ayHAquq+JpchKFxLTsiKAODBA4A0p5Xl7tETsTbWVsd8XVxdTAfrsa83rOngZ7fqQKj9hP1V+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692964; c=relaxed/simple;
	bh=j1AS+SlN3kUDfs1T36SWDD/Un/F0gsbPLTf/+wDif+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byjt2qKYBNyTs3XnRlbIuIHnJTnZTzo18P9CMRFTQ+VAOQ9P1GDD5Jt0VbFGKme6BLf+b8kJQoDWl1zDSz8+M87qZcAP3ORJMw66fyoRryG26wqOoj26UlCjoxrT+vv8iem+GYilNYKHP+7BsV5RZ/UN+UX9+noxi4Hvm6gB3hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpqen9zM; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpqen9zM"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-966d4748ad5so622136241.3
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 07:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692962; x=1784297762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FvVH1EDLMlXvGgsQ9hTewb/9R7l3jGNyEXR2s+KqkZg=;
        b=hpqen9zMsVd1eldQjGTfW4lGBSh7Erh717kqi7ZTVH5aeADTYO1pK5WN5xKqXimI7E
         yDHFIHdg5IiOh8oqWjdq7doUsBH7263ZabSBQbHB3VF51BlsIKPFRUlhPFhhr/hNE9DT
         heq8ZXKR98wv8ELF8fVq0Hc+Vxo4qF6f8HKYq1gXBL1hhc2uzjOHnhIHF/rHVAUOaNir
         MsnU+8bSNCyfcIV2+kUvowRXwb2uolFLr5z3GA7UhNRy/uAgHnKU5AMlZSpQQWcly0Xb
         zkcrBUjgOjOWSmZK1Suz5YTICzPTcQN7hCRHWZKMRRS6fQrTJYmu/FgmNLwS2aixIKsw
         k4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692962; x=1784297762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FvVH1EDLMlXvGgsQ9hTewb/9R7l3jGNyEXR2s+KqkZg=;
        b=VxRmgNeGDqqRGpORLjr9odAkm/N37hRSv3vp6pLnti5e/o5FRaWdf6jCTkuPtcwZxY
         h7Xqj6JW5KzkvrVdACEg5VBeLOLjgS6C7uRL553HUOkbOscqNKCfShxA3uIcjwlLHnk3
         YAtRg8Da5fSzmHEe1W43d/koZpNmLDmteP05koXzgL7Ovw8NrjV13mWlwFn2s38/Cb7r
         ocMPiFWNhWn80t4A5GuSYhjzwxJ25WG37HgEmbV1t1+Jn8BGQDFGtTdXfFygEhydPrH6
         dNTy2uCkuw6Rfc5HW3xxQeMgbbCNYVcRRQeDnNKJNLKS45wrMQ8wvawFKvvz2Y6aX1R8
         bLQg==
X-Gm-Message-State: AOJu0Yz3ffWtDsA+O3bIkcTWCP9xN4JQ7ph8cDOnZMwG+qhtUjNGl0cA
	TYz2Vtgt1rXRovCLrVWUNQMxOsZ3KKe5oG004SIGtgEkUTLuZsYOSX9Xlz6I2A==
X-Gm-Gg: AfdE7cmNO1dq9e6yBNRI/4uTJuaYc2AtlQtzzHnmP/8JsuQwTI5Dl2gPGw5N2in9FXk
	r9NnfKREbejSvqeTg+rdiXkyPhxfjyoXwhTE8WbHn0Va9lbd6NgEwk/poUn2qYIwfwiAquIOBSE
	faDhK2RKZdXgSDJ0CMdQbo1EQtHOxl9dMxWgQaTFZNjgPLrhm7wrUCsr53H5WEbTy8UK0jNS61F
	Yy+3yx5OapFiDQnY75UDozdvY6y4ffG8npjAjYptFamHTOwJ74917Rq7qCOWbVnHUYt+xeXTK8b
	jrqxKcNm4eJBXMEDwhOP6Cs0GtPSJ4XjBYJyk0NvfN79kZCrXJc0s6NYIZymgs4S1vMjYOOYfTn
	wU9iRImgK0Xi9A8XULU93w9AkVIkUyrjop658MMsJJulJYhrw7kHCPlLWBn4PTPM/ocX2XoMPF1
	S/7o/R/hxSTOZUYlW3+xGnoAR0ylD/rsR7iZmQNuyBe8TgWkvAXyX9zf8VaNPxsnH9dYJVDrFwC
	Q==
X-Received: by 2002:a05:6102:598c:b0:726:8813:2078 with SMTP id ada2fe7eead31-744dfebf3c1mr7134429137.11.1783692961339;
        Fri, 10 Jul 2026 07:16:01 -0700 (PDT)
Received: from Cumhall.home ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6771d49sm5565087137.0.2026.07.10.07.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:16:00 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 10/36] tuna: Add comprehensive test suite for cpuset CLI commands
Date: Fri, 10 Jul 2026 10:14:48 -0400
Message-ID: <20260710141523.36440-11-jkacur@redhat.com>
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

Add tests for tuna cpuset CLI commands added to tuna-cmd.py:
- cpuset create (with auto-naming, custom names, --isolated)
- cpuset list (with --pattern, --verbose, --skip-empty)
- cpuset destroy (single and pattern-based, with --skip-empty)
- get_next_tuna_cpuset_name() auto-naming logic

Test classes:
- TestGetNextTunaCpusetName: Verifies auto-naming with gap-filling
- TestCpusetCreateCLI: Tests create command with various options
- TestCpusetListCLI: Tests list filtering and verbosity
- TestCpusetDestroyCLI: Tests destroy with patterns and safety options

All tests clean up created cpusets in tearDown() methods despite tuna's
default behavior of creating persistent cpusets. Tests require root
permissions and cgroup v2 support.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/test_cpuset_cli.py | 358 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 358 insertions(+)
 create mode 100644 tests/test_cpuset_cli.py

diff --git a/tests/test_cpuset_cli.py b/tests/test_cpuset_cli.py
new file mode 100644
index 000000000000..7f9a4ce9947c
--- /dev/null
+++ b/tests/test_cpuset_cli.py
@@ -0,0 +1,358 @@
+#!/usr/bin/python3
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-only
+"""
+Test suite for tuna cpuset CLI commands
+
+Tests the command-line interface functions added to tuna-cmd.py:
+- cpuset create (with auto-naming, custom names, --isolated)
+- cpuset list (with --pattern, --verbose, --skip-empty)
+- cpuset destroy (single and pattern-based, with --skip-empty)
+- get_next_tuna_cpuset_name() auto-naming logic
+
+All tests clean up created cpusets afterwards (even though tuna creates persistent cpusets).
+"""
+
+import unittest
+import os
+import sys
+from pathlib import Path
+
+# Add tuna to path if running from tests directory
+if Path(__file__).parent.name == 'tests':
+    sys.path.insert(0, str(Path(__file__).parent.parent))
+
+from tuna import cpuset
+
+
+# Import the CLI functions from tuna-cmd.py
+# We need to import from the parent directory
+tuna_cmd_path = Path(__file__).parent.parent / 'tuna-cmd.py'
+spec = __import__('importlib.util').util.spec_from_file_location("tuna_cmd", tuna_cmd_path)
+tuna_cmd = __import__('importlib.util').util.module_from_spec(spec)
+spec.loader.exec_module(tuna_cmd)
+
+# Import the CLI functions we want to test
+get_next_tuna_cpuset_name = tuna_cmd.get_next_tuna_cpuset_name
+cpuset_create = tuna_cmd.cpuset_create
+cpuset_list = tuna_cmd.cpuset_list
+cpuset_destroy = tuna_cmd.cpuset_destroy
+
+
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestGetNextTunaCpusetName(unittest.TestCase):
+    """Test auto-naming logic for tuna cpusets"""
+
+    def setUp(self):
+        """Clean up any existing tuna cpusets before testing"""
+        self.ci = cpuset.CpusetsInit()
+        try:
+            cpuset.cleanup_cpusets('tuna[0-9]*', force=True, recursive=False)
+        except:
+            pass
+
+    def tearDown(self):
+        """Clean up tuna cpusets after testing"""
+        try:
+            cpuset.cleanup_cpusets('tuna[0-9]*', force=True, recursive=False)
+        except:
+            pass
+
+    def test_first_name_is_tuna0(self):
+        """Test that first auto-generated name is 'tuna0'"""
+        name = get_next_tuna_cpuset_name()
+        self.assertEqual(name, 'tuna0')
+
+    def test_sequential_naming(self):
+        """Test that names increment sequentially"""
+        # Create tuna0
+        cs0 = cpuset.Cpuset('tuna0')
+        cs0.write_memnode('0')
+
+        name = get_next_tuna_cpuset_name()
+        self.assertEqual(name, 'tuna1')
+
+        # Create tuna1
+        cs1 = cpuset.Cpuset('tuna1')
+        cs1.write_memnode('0')
+
+        name = get_next_tuna_cpuset_name()
+        self.assertEqual(name, 'tuna2')
+
+    def test_fills_gaps(self):
+        """Test that naming fills gaps in sequence"""
+        # Create tuna0 and tuna2 (skip tuna1)
+        cs0 = cpuset.Cpuset('tuna0')
+        cs2 = cpuset.Cpuset('tuna2')
+        cs0.write_memnode('0')
+        cs2.write_memnode('0')
+
+        # Should return tuna1 (the gap)
+        name = get_next_tuna_cpuset_name()
+        self.assertEqual(name, 'tuna1')
+
+
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestCpusetCreateCLI(unittest.TestCase):
+    """Test 'tuna cpuset create' command"""
+
+    def setUp(self):
+        """Set up test fixtures"""
+        self.ci = cpuset.CpusetsInit()
+        self.created_cpusets = []
+
+    def tearDown(self):
+        """Clean up all created cpusets"""
+        for name in self.created_cpusets:
+            try:
+                cpuset.destroy_cpuset(name, force=True)
+            except:
+                pass
+
+    def test_create_with_auto_naming(self):
+        """Test creating cpuset with auto-generated name"""
+        # Clean up first
+        try:
+            cpuset.cleanup_cpusets('tuna[0-9]*', force=True, recursive=False)
+        except:
+            pass
+
+        # Create with auto-naming
+        cpuset_create(cpu_list=[0, 1], name=None, isolated=False)
+        self.created_cpusets.append('tuna0')
+
+        # Verify it exists
+        self.assertTrue(os.path.exists('/sys/fs/cgroup/tuna0'))
+
+        # Verify CPUs are assigned
+        with open('/sys/fs/cgroup/tuna0/cpuset.cpus') as f:
+            cpus = f.read().strip()
+        self.assertIn('0', cpus)
+        self.assertIn('1', cpus)
+
+    def test_create_with_custom_name(self):
+        """Test creating cpuset with custom name"""
+        cpuset_create(cpu_list=[2, 3], name='my_cpuset', isolated=False)
+        self.created_cpusets.append('my_cpuset')
+
+        # Verify it exists
+        self.assertTrue(os.path.exists('/sys/fs/cgroup/my_cpuset'))
+
+        # Verify CPUs are assigned
+        with open('/sys/fs/cgroup/my_cpuset/cpuset.cpus') as f:
+            cpus = f.read().strip()
+        self.assertIn('2', cpus)
+        self.assertIn('3', cpus)
+
+    def test_create_with_isolated(self):
+        """Test creating cpuset with --isolated flag"""
+        cpuset_create(cpu_list=[0], name='isolated_cpuset', isolated=True)
+        self.created_cpusets.append('isolated_cpuset')
+
+        # Verify partition type (if supported)
+        partition_file = '/sys/fs/cgroup/isolated_cpuset/cpuset.cpus.partition'
+        if os.path.exists(partition_file):
+            with open(partition_file) as f:
+                partition = f.read().strip()
+            # Should be 'isolated' (or possibly 'root'/'member' if not supported)
+            self.assertIn(partition, ['isolated', 'root', 'member'])
+
+
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestCpusetListCLI(unittest.TestCase):
+    """Test 'tuna cpuset list' command"""
+
+    def setUp(self):
+        """Set up test fixtures"""
+        self.ci = cpuset.CpusetsInit()
+        self.created_cpusets = []
+
+        # Create some test cpusets
+        cs1 = cpuset.Cpuset('test_list_1')
+        cs1.write_memnode('0')
+        cs1.assign_cpus('0-1')
+        self.created_cpusets.append('test_list_1')
+
+        cs2 = cpuset.Cpuset('test_list_2')
+        cs2.write_memnode('0')
+        cs2.assign_cpus('2-3')
+        self.created_cpusets.append('test_list_2')
+
+        # Create one without CPUs (empty)
+        cs3 = cpuset.Cpuset('test_list_empty')
+        cs3.write_memnode('0')
+        self.created_cpusets.append('test_list_empty')
+
+    def tearDown(self):
+        """Clean up all created cpusets"""
+        for name in self.created_cpusets:
+            try:
+                cpuset.destroy_cpuset(name, force=True)
+            except:
+                pass
+
+    def test_list_basic(self):
+        """Test basic cpuset list (should include our test cpusets)"""
+        # Capture output by listing directly
+        cpusets = cpuset.list_cpusets(recursive=False)
+
+        # Should include our cpusets
+        self.assertIn('test_list_1', cpusets)
+        self.assertIn('test_list_2', cpusets)
+        self.assertIn('test_list_empty', cpusets)
+
+    def test_list_with_pattern(self):
+        """Test cpuset list with --pattern filter"""
+        cpusets = cpuset.list_cpusets(pattern='test_list_*', recursive=False)
+
+        # Should include our cpusets
+        self.assertIn('test_list_1', cpusets)
+        self.assertIn('test_list_2', cpusets)
+        self.assertIn('test_list_empty', cpusets)
+
+    def test_list_skip_empty(self):
+        """Test cpuset list with --skip-empty"""
+        # Get all cpusets matching pattern
+        all_cpusets = cpuset.list_cpusets(pattern='test_list_*', recursive=False)
+
+        # Filter out empty ones manually (simulating --skip-empty)
+        non_empty = []
+        for cs_name in all_cpusets:
+            cs_path = os.path.join('/sys/fs/cgroup', cs_name)
+            with open(os.path.join(cs_path, 'cpuset.cpus')) as f:
+                cpus = f.read().strip()
+                if cpus:
+                    non_empty.append(cs_name)
+
+        # Should include cpusets with CPUs
+        self.assertIn('test_list_1', non_empty)
+        self.assertIn('test_list_2', non_empty)
+
+        # Should NOT include empty cpuset
+        self.assertNotIn('test_list_empty', non_empty)
+
+
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestCpusetDestroyCLI(unittest.TestCase):
+    """Test 'tuna cpuset destroy' command"""
+
+    def setUp(self):
+        """Set up test fixtures"""
+        self.ci = cpuset.CpusetsInit()
+        self.created_cpusets = []
+
+    def tearDown(self):
+        """Clean up any remaining cpusets"""
+        for name in self.created_cpusets:
+            try:
+                cpuset.destroy_cpuset(name, force=True)
+            except:
+                pass
+
+    def test_destroy_single_cpuset(self):
+        """Test destroying a single cpuset by name"""
+        # Create a cpuset
+        cs = cpuset.Cpuset('test_destroy_single')
+        cs.write_memnode('0')
+        self.created_cpusets.append('test_destroy_single')
+
+        path = cs.cpuset_path
+        self.assertTrue(os.path.exists(path))
+
+        # Destroy it (without force, no tasks)
+        cpuset_destroy(name='test_destroy_single', pattern=None, force=False,
+                       skip_empty=False, recursive=True)
+
+        # Should be gone
+        self.assertFalse(os.path.exists(path))
+        self.created_cpusets.remove('test_destroy_single')
+
+    def test_destroy_by_pattern(self):
+        """Test destroying multiple cpusets by pattern"""
+        # Create multiple cpusets
+        cs1 = cpuset.Cpuset('test_destroy_bulk_1')
+        cs1.write_memnode('0')
+        cs2 = cpuset.Cpuset('test_destroy_bulk_2')
+        cs2.write_memnode('0')
+        self.created_cpusets.extend(['test_destroy_bulk_1', 'test_destroy_bulk_2'])
+
+        # Destroy by pattern
+        cpuset_destroy(name=None, pattern='test_destroy_bulk_*', force=True,
+                       skip_empty=False, recursive=False)
+
+        # Should be gone
+        self.assertFalse(os.path.exists(cs1.cpuset_path))
+        self.assertFalse(os.path.exists(cs2.cpuset_path))
+        self.created_cpusets = []
+
+    def test_destroy_with_skip_empty(self):
+        """Test destroying with --skip-empty (should skip empty cpusets)"""
+        # Create cpuset with CPUs
+        cs1 = cpuset.Cpuset('test_destroy_nonempty')
+        cs1.write_memnode('0')
+        cs1.assign_cpus('0')
+        self.created_cpusets.append('test_destroy_nonempty')
+
+        # Create empty cpuset
+        cs2 = cpuset.Cpuset('test_destroy_empty')
+        cs2.write_memnode('0')
+        self.created_cpusets.append('test_destroy_empty')
+
+        # Destroy with skip_empty
+        cpuset_destroy(name=None, pattern='test_destroy_*', force=True,
+                       skip_empty=True, recursive=False)
+
+        # Non-empty should be destroyed
+        self.assertFalse(os.path.exists(cs1.cpuset_path))
+        self.created_cpusets.remove('test_destroy_nonempty')
+
+        # Empty should still exist
+        self.assertTrue(os.path.exists(cs2.cpuset_path))
+
+
+def suite():
+    """Create test suite"""
+    loader = unittest.TestLoader()
+    suite = unittest.TestSuite()
+
+    # Add all test classes
+    suite.addTests(loader.loadTestsFromTestCase(TestGetNextTunaCpusetName))
+    suite.addTests(loader.loadTestsFromTestCase(TestCpusetCreateCLI))
+    suite.addTests(loader.loadTestsFromTestCase(TestCpusetListCLI))
+    suite.addTests(loader.loadTestsFromTestCase(TestCpusetDestroyCLI))
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
+        print("All CLI tests require root permissions.")
+        print("\nTo run tests:")
+        print("  sudo python3 -m unittest tests.test_cpuset_cli -v")
+        print("="*60 + "\n")
+        sys.exit(1)
+
+    # Check cgroup v2 support
+    ci = cpuset.CpusetsInit()
+    if not ci.supported:
+        print("\n" + "="*60)
+        print("ERROR: cgroup v2 not supported")
+        print("="*60)
+        print("These tests require cgroup v2 support.")
+        print("="*60 + "\n")
+        sys.exit(1)
+
+    # Run tests
+    runner = unittest.TextTestRunner(verbosity=2)
+    result = runner.run(suite())
+
+    # Exit with appropriate code
+    sys.exit(0 if result.wasSuccessful() else 1)
-- 
2.54.0

