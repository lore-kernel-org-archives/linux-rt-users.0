Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F019B442FB4
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223977; cv=none; b=RKDM8LA5q4jEjaf8uARMxVuKaE1LYVuXCcDPdI9gg5Bi90Mv7sHtljeqwUcuUPfBVuWGuITb9UxPzjEmMUb9Km3+x/pYq16wmXBY4GjNzIsgvBOE+v3+rPd7QYAiLValUX2zvhbBCMYvr0rcgnFir2fZPQU8fHtFtnJ0QIazt9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223977; c=relaxed/simple;
	bh=xCNIIg4dzc03fr6gnsjWsEqSfN2nrO0oeG2Pdf+NKLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ta/epNZhSO08PSAF5lXsKljKOWX9kVhWemOou4qRzehQR+b7oqgTn/wGhwPRP7p04WOfpeImkzc/69RvmScT2XVkkA4LKQqGcTl2SdTxmeu4cx1BJjV8cCU77OLbbOeJ294XytgqOPjJ9Ps8607cU5zB0ckfkf2oPNDg7vpnBSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KecMjPq3; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KecMjPq3"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-90327237340so6166066d6.1
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 10:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784223974; x=1784828774; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DGM1A6iYtI/u2ItH6HRC8I9CT4mOgqMVk3HkqpzyYNU=;
        b=KecMjPq3ZVuTkiXwqIojt5pDc3oCboMyIT/D2C6sQjLfIDAOQVhAZnruZ4I5t4sj2a
         ncU1ItDZpOSYJ7U/9QKT2pnnUT/UkfH2oi/t4qdrWGMNsHYz9HSzcaqM4YJWIzI1SbdE
         zLWNbowrI+kqgKroSniZq03fzk4OqGZlqetTD19OOBDtbj0l9QwgCZHYG/5DWewBAFiA
         HRyERmaONq+LIbtcDM4rgcQWQlyuD2tHgWtv4r/B9kT4ab8nLFnZRIftoCwLowXSC1J8
         TSYn9oNImvogBA0Z7DmAFPbeW0a/uesXDrl8jt9R0nIthS2FcTqyPzT9MUcpOIGBvInf
         Sq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223974; x=1784828774;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DGM1A6iYtI/u2ItH6HRC8I9CT4mOgqMVk3HkqpzyYNU=;
        b=d2GEe/SQ9PyTZ8C6zjKI8/wZ0qhXmWn1nFn7gjhznpHxfihTeRjUzK1qKXvZh8nUmA
         8zeaC5n5Nc4ZCAtw3EJxRPrXO7CcIVF9GLKiDW8p6Xf4qEiPeCtCcs64LZiouq8QNidK
         /03NN5gNSmNwqeZotTTcmLEBuR2j4gTgpMsP6B7s8NKdbgSAhzW8lLA1e1Vt6Zc3ruiZ
         6blm2qEVl/0cuFY4MPxNVHK/3oUim8PD7Zn2ASuRUqFpzelz131jowoOeoMZya2K1KaZ
         f8i8uhknq05lsQMubn8ObEI7jfgkLffqsdjF2AYLQSvTIpqV4ANQs/gyKF/9wA/uk55x
         n1lw==
X-Gm-Message-State: AOJu0YxOX0BixfOKFzuUFDgBgsomEEqGKizYQFJKkMlkdJCpDIi5KFIT
	fx3D3TkgarlZHuLmyVHE5edx/Vm6glAIYm3d5aNPu7Nq5H7mGEJL60G/ytIBQQ==
X-Gm-Gg: AfdE7cmYxxodVo6ow+aT5o7b+2B68mFDFV5Lo7CD2NoSzQq1NXxm7azU58ZSWrb2OAS
	e1vS8cAqdm111hCfCQLTL9AS/MqoEHIlqJ12UUYBW4b5r6z3XfFd6oDd9jooknaFJsWN66Q62hl
	K8Y9FpFHwRu0J8cbzW2UzZ6Qa9bowDr9R4U8ALEgPa3uFsQj00ORBRHxl/jTw2+XKJ0A33dLY8L
	MXR3KqiuGyKsX2EqdDMpyi5uwqEnoc/JW3o2Rxvppa9jSVENH9wgsVL953luszg+BceAgT1luf4
	8Pu2xCRM2Cvl0PyZIevOEM4KpqAJa9CTIpdV2Rsc7Qoq7JMhXe13CuNbo2vNW3gBzdb+Jxt+2m3
	U9Sfa5MhY9lf5ErVdKPbu9dax+vArH195QLM7f9FdJ/8bZTfU1kd5gzXe17jThc5dYSKVOg+NPN
	Dw25nXLeGrH8g0ZHMsOmIBdsPsiEaoUYJqm0LNrfSeK10JoFcGO/z/h/JyuLLsPWnDaNUu
X-Received: by 2002:a05:6214:459c:b0:8ef:a6b:18a with SMTP id 6a1803df08f44-90768cc4252mr37880486d6.6.1784223973604;
        Thu, 16 Jul 2026 10:46:13 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e0347sm224952276d6.2.2026.07.16.10.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:46:13 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 3/7] tuna: Add comprehensive tests for save/apply functionality
Date: Thu, 16 Jul 2026 13:45:46 -0400
Message-ID: <20260716174554.126145-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716174554.126145-1-jkacur@redhat.com>
References: <20260716174554.126145-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add Python test suite for cpuset save/apply subcommands with 12 test
cases covering all functionality and edge cases.

Test coverage (tests/test_save_apply.py):
- test_save_creates_yaml_file: Verify save creates output file
- test_save_captures_all_cpusets: Verify all user cpusets are saved
- test_save_captures_partition_types: Verify isolated vs member preserved
- test_save_captures_cpu_ranges: Verify CPU assignments preserved
- test_apply_recreates_cpusets: Verify apply recreates from YAML
- test_apply_preserves_partition_types: Verify partition types restored
- test_apply_preserves_cpu_assignments: Verify CPU assignments restored
- test_apply_with_existing_cpusets_warns: Verify idempotent operation
- test_apply_missing_file_returns_error: Error handling for missing files
- test_roundtrip_preserves_configuration: Full save→destroy→apply→verify
- test_save_with_no_cpusets: Handle empty cpuset case gracefully
- test_save_skips_system_cpusets: Verify system cpuset filtering

Test structure:
- Uses unittest framework (consistent with existing tests)
- Requires root permissions (@skipUnless decorator)
- Requires cgroup v2 support (@skipUnless decorator)
- setUp/tearDown for cleanup (creates temp files, cleans cpusets)
- Cleans up test cpusets from both automated and manual testing
- Helper method create_test_cpusets() for test data
- Uses tempfile module for safe YAML file handling

All tests follow the same pattern as existing cpuset tests in
test_cpuset.py and test_cpuset_cli.py, ensuring consistency
across the test suite.

Tests can be run with:
  sudo python3 -m unittest tests.test_save_apply -v

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/README.md          |  37 +++--
 tests/test_save_apply.py | 300 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 327 insertions(+), 10 deletions(-)
 create mode 100644 tests/test_save_apply.py

diff --git a/tests/README.md b/tests/README.md
index 3e8b84a81fd4..1b96a54807f9 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -12,7 +12,7 @@ This directory contains the test suite for tuna, using Python's `unittest` frame
 # Run all non-root tests only (45 tests)
 make tests
 
-# Run ALL tests (all 146 tests, requires sudo for root-required tests)
+# Run ALL tests (all 158 tests, requires sudo for root-required tests)
 make test-all
 
 # Run specific test module
@@ -37,7 +37,7 @@ make tests
 # or
 make unit-tests
 
-# Using make (ALL tests including root-required tests, 146 tests)
+# Using make (ALL tests including root-required tests, 158 tests)
 make test-all
 
 # Using the test runner directly (non-root tests only)
@@ -168,7 +168,7 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - Tests edge cases: empty string and None inputs
   - Run: `python3 -m unittest tests.test_show_threads_cgroups.TestExtractCpusetName -v`
 
-#### Root-Required Tests (102 tests)
+#### Root-Required Tests (114 tests)
 
 - **test_process_blocklist.py** (2 tests) - Process blocklist root tests
   - Tests actual blocking of systemd from being moved to cpusets
@@ -226,7 +226,23 @@ Tests are organized using Python's `unittest` framework. Each test file contains
     - test_cgroups_displays_system_slice_shortened: Verifies system.slice shows shortened name
   - Run: `sudo python3 -m unittest tests.test_show_threads_cgroups.TestShowThreadsCgroupsDisplay -v`
 
-**Total: 146 tests** (45 non-root + 101 root-required)
+- **test_save_apply.py** (12 tests) - save/apply cpuset configuration tests
+  - TestSaveApply: Tests cpuset save and apply functionality
+    - test_save_creates_yaml_file: Verify save creates output file
+    - test_save_captures_all_cpusets: Verify all user cpusets are saved
+    - test_save_captures_partition_types: Verify isolated vs member preserved
+    - test_save_captures_cpu_ranges: Verify CPU assignments preserved
+    - test_apply_recreates_cpusets: Verify apply recreates from YAML
+    - test_apply_preserves_partition_types: Verify partition types restored
+    - test_apply_preserves_cpu_assignments: Verify CPU assignments restored
+    - test_apply_with_existing_cpusets_warns: Verify idempotent operation
+    - test_apply_missing_file_returns_error: Error handling for missing files
+    - test_roundtrip_preserves_configuration: Full save→destroy→apply→verify
+    - test_save_with_no_cpusets: Handle empty cpuset case gracefully
+    - test_save_skips_system_cpusets: Verify system cpuset filtering
+  - Run: `sudo python3 -m unittest tests.test_save_apply -v`
+
+**Total: 158 tests** (45 non-root + 113 root-required)
 
 ### Test Requirements: Root vs Non-Root
 
@@ -275,7 +291,7 @@ These tests run without root privileges:
 - Tests are fast and don't affect the running system
 - Tests verify both happy path (with mocks) and error path (with real EPERM)
 
-#### Root-Required Tests (102 tests)
+#### Root-Required Tests (114 tests)
 
 These tests require root to create/manipulate cgroups:
 
@@ -446,9 +462,9 @@ Ran 45 tests in 0.XXXs
 OK (skipped=102)
 ```
 
-### All Tests Including Root-Required (146 tests)
+### All Tests Including Root-Required (158 tests)
 
-Running with sudo will run all 146 tests:
+Running with sudo will run all 158 tests:
 
 ```bash
 $ sudo python3 -m unittest discover -s tests -p "test_*.py" -v
@@ -463,7 +479,7 @@ test_sequential_naming (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
 ... (4 show_threads -G display tests)
 
 ----------------------------------------------------------------------
-Ran 146 tests in X.XXXs
+Ran 158 tests in X.XXXs
 
 OK
 ```
@@ -480,12 +496,13 @@ The test suite includes:
 - **show_threads --cpuset help test**: CLI documentation verification (read-only)
 - **Cpuset name extraction tests**: Cgroup path parsing logic (pure function testing)
 
-### Integration Tests (102 tests - require root)
+### Integration Tests (114 tests - require root)
 - **Process blocklist tests**: Test blocklist protection (2 root-required tests)
 - **Cpuset module tests**: Test interaction with cgroup v2 subsystem
 - **Cpuset CLI tests**: Test command-line interface integration
 - **show_threads --cpuset tests**: Test process filtering by cpuset membership
 - **show_threads -G display tests**: Test cpuset name display in cgroups output
+- **Save/apply tests**: Test cpuset configuration save and restore functionality
 
 Future test categories might include:
 - **System tests** - Full end-to-end tests requiring CPU affinity operations
@@ -510,7 +527,7 @@ python3 -m unittest discover -s tests -p "test_*.py" -v
 
 ### Root-Required Tests (Optional for CI)
 
-The cpuset tests (102 tests) can run in CI with special setup:
+The cpuset tests (114 tests) can run in CI with special setup:
 - Requires root access or privileged containers
 - Requires cgroup v2 support
 - May need dedicated test runners with appropriate permissions
diff --git a/tests/test_save_apply.py b/tests/test_save_apply.py
new file mode 100644
index 000000000000..30630d2a0b92
--- /dev/null
+++ b/tests/test_save_apply.py
@@ -0,0 +1,300 @@
+#!/usr/bin/python3
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-only
+"""
+Test suite for tuna cpuset save/apply commands
+
+Tests the cpuset save and apply functionality:
+- save: Saving cpuset configuration to YAML
+- apply: Restoring cpuset configuration from YAML
+- Round-trip: save → destroy → apply → verify
+- Edge cases: existing cpusets, missing files, empty profiles, etc.
+
+All tests clean up created files and cpusets afterwards.
+"""
+
+import unittest
+import os
+import sys
+import tempfile
+from pathlib import Path
+
+# Add tuna to path if running from tests directory
+if Path(__file__).parent.name == 'tests':
+    sys.path.insert(0, str(Path(__file__).parent.parent))
+
+from tuna import cpuset, profile
+
+
+# Import the CLI functions from tuna-cmd.py
+tuna_cmd_path = Path(__file__).parent.parent / 'tuna-cmd.py'
+spec = __import__('importlib.util').util.spec_from_file_location("tuna_cmd", tuna_cmd_path)
+tuna_cmd = __import__('importlib.util').util.module_from_spec(spec)
+spec.loader.exec_module(tuna_cmd)
+
+# Import the functions we want to test
+save_cpusets_cmd = tuna_cmd.save_cpusets_cmd
+apply_cpusets_cmd = tuna_cmd.apply_cpusets_cmd
+get_all_cpusets_info = tuna_cmd.get_all_cpusets_info
+
+
+@unittest.skipUnless(os.geteuid() == 0, "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestSaveApply(unittest.TestCase):
+    """Test save and apply commands for cpuset configuration"""
+
+    def setUp(self):
+        """Create temporary file and test cpusets before each test"""
+        self.ci = cpuset.CpusetsInit()
+
+        # Create temporary YAML file
+        self.temp_fd, self.temp_file = tempfile.mkstemp(suffix='.yaml', prefix='tuna-test-')
+        os.close(self.temp_fd)  # Close fd, we'll use the filename
+
+        # Clean up any existing test cpusets (including from manual tests)
+        for pattern in ['test_save_*', 'test_rt', 'test_housekeeping']:
+            try:
+                cpuset.cleanup_cpusets(pattern, force=True, recursive=False)
+            except:
+                pass
+
+    def tearDown(self):
+        """Clean up test cpusets and temporary file after each test"""
+        # Clean up test cpusets (including from manual tests)
+        for pattern in ['test_save_*', 'test_rt', 'test_housekeeping']:
+            try:
+                cpuset.cleanup_cpusets(pattern, force=True, recursive=False)
+            except:
+                pass
+
+        # Remove temporary YAML file
+        if os.path.exists(self.temp_file):
+            os.unlink(self.temp_file)
+
+    def create_test_cpusets(self):
+        """Helper: Create two test cpusets for testing"""
+        # Create test_save_rt (isolated)
+        cs_rt = cpuset.Cpuset('test_save_rt')
+        cs_rt.write_memnode('0')
+        cs_rt.assign_cpus('2-3')
+        cs_rt.set_cpu_exclusive()
+
+        # Create test_save_hk (member)
+        cs_hk = cpuset.Cpuset('test_save_hk')
+        cs_hk.write_memnode('0')
+        cs_hk.assign_cpus('0-1')
+
+        return cs_rt, cs_hk
+
+    def test_save_creates_yaml_file(self):
+        """Test that save command creates a YAML file"""
+        self.create_test_cpusets()
+
+        # Save cpusets
+        save_cpusets_cmd(self.temp_file)
+
+        # Verify file exists and has content
+        self.assertTrue(os.path.exists(self.temp_file))
+        self.assertGreater(os.path.getsize(self.temp_file), 0)
+
+    def test_save_captures_all_cpusets(self):
+        """Test that save captures all user cpusets"""
+        self.create_test_cpusets()
+
+        # Save cpusets
+        save_cpusets_cmd(self.temp_file)
+
+        # Read and verify YAML content
+        from ruamel.yaml import YAML
+        yaml = YAML()
+        with open(self.temp_file, 'r') as f:
+            data = yaml.load(f)
+
+        self.assertIn('cpusets', data)
+        self.assertEqual(len(data['cpusets']), 2)
+
+        # Check cpuset names
+        names = {cs['name'] for cs in data['cpusets']}
+        self.assertEqual(names, {'test_save_rt', 'test_save_hk'})
+
+    def test_save_captures_partition_types(self):
+        """Test that save preserves partition types (isolated vs member)"""
+        self.create_test_cpusets()
+
+        # Save cpusets
+        save_cpusets_cmd(self.temp_file)
+
+        # Read YAML
+        from ruamel.yaml import YAML
+        yaml = YAML()
+        with open(self.temp_file, 'r') as f:
+            data = yaml.load(f)
+
+        # Find each cpuset in saved data
+        cpusets_by_name = {cs['name']: cs for cs in data['cpusets']}
+
+        self.assertEqual(cpusets_by_name['test_save_rt']['partition'], 'isolated')
+        self.assertEqual(cpusets_by_name['test_save_hk']['partition'], 'member')
+
+    def test_save_captures_cpu_ranges(self):
+        """Test that save captures CPU assignments correctly"""
+        self.create_test_cpusets()
+
+        # Save cpusets
+        save_cpusets_cmd(self.temp_file)
+
+        # Read YAML
+        from ruamel.yaml import YAML
+        yaml = YAML()
+        with open(self.temp_file, 'r') as f:
+            data = yaml.load(f)
+
+        # Find each cpuset in saved data
+        cpusets_by_name = {cs['name']: cs for cs in data['cpusets']}
+
+        self.assertEqual(cpusets_by_name['test_save_rt']['cpus'], '2-3')
+        self.assertEqual(cpusets_by_name['test_save_hk']['cpus'], '0-1')
+
+    def test_apply_recreates_cpusets(self):
+        """Test that apply recreates cpusets from YAML"""
+        # Create and save cpusets
+        self.create_test_cpusets()
+        save_cpusets_cmd(self.temp_file)
+
+        # Destroy cpusets
+        cpuset.cleanup_cpusets('test_save_*', force=True, recursive=False)
+
+        # Verify they're gone
+        remaining = cpuset.list_cpusets(pattern='test_save_*', recursive=False)
+        self.assertEqual(len(remaining), 0)
+
+        # Apply profile to recreate
+        apply_cpusets_cmd(self.temp_file, verbose=False)
+
+        # Verify cpusets were recreated
+        recreated = cpuset.list_cpusets(pattern='test_save_*', recursive=False)
+        self.assertEqual(len(recreated), 2)
+        self.assertIn('test_save_rt', recreated)
+        self.assertIn('test_save_hk', recreated)
+
+    def test_apply_preserves_partition_types(self):
+        """Test that apply restores partition types correctly"""
+        # Create, save, destroy, apply
+        self.create_test_cpusets()
+        save_cpusets_cmd(self.temp_file)
+        cpuset.cleanup_cpusets('test_save_*', force=True, recursive=False)
+        apply_cpusets_cmd(self.temp_file, verbose=False)
+
+        # Verify partition types
+        cs_rt = cpuset.Cpuset('test_save_rt', existing_ok=True)
+        cs_hk = cpuset.Cpuset('test_save_hk', existing_ok=True)
+
+        self.assertEqual(cs_rt.get_partition_type(), 'isolated')
+        self.assertEqual(cs_hk.get_partition_type(), 'member')
+
+    def test_apply_preserves_cpu_assignments(self):
+        """Test that apply restores CPU assignments correctly"""
+        # Create, save, destroy, apply
+        self.create_test_cpusets()
+        save_cpusets_cmd(self.temp_file)
+        cpuset.cleanup_cpusets('test_save_*', force=True, recursive=False)
+        apply_cpusets_cmd(self.temp_file, verbose=False)
+
+        # Verify CPU assignments
+        cs_rt = cpuset.Cpuset('test_save_rt', existing_ok=True)
+        cs_hk = cpuset.Cpuset('test_save_hk', existing_ok=True)
+
+        self.assertEqual(cs_rt.get_cpus(), '2-3')
+        self.assertEqual(cs_hk.get_cpus(), '0-1')
+
+    def test_apply_with_existing_cpusets_warns(self):
+        """Test that apply warns when cpusets already exist"""
+        # Create and save cpusets
+        self.create_test_cpusets()
+        save_cpusets_cmd(self.temp_file)
+
+        # Apply without destroying (cpusets already exist)
+        # This should return warnings
+        num_applied, num_warnings, num_errors = profile.apply_cpusets(
+            self.temp_file, cpuset, verbose=False
+        )
+
+        self.assertEqual(num_applied, 0)  # Nothing new created
+        self.assertEqual(num_warnings, 2)  # Both cpusets already exist
+        self.assertEqual(num_errors, 0)
+
+    def test_apply_missing_file_returns_error(self):
+        """Test that apply returns error for missing file"""
+        missing_file = '/tmp/nonexistent-tuna-test.yaml'
+
+        num_applied, num_warnings, num_errors = profile.apply_cpusets(
+            missing_file, cpuset, verbose=False
+        )
+
+        self.assertEqual(num_applied, 0)
+        self.assertEqual(num_warnings, 0)
+        self.assertEqual(num_errors, 1)
+
+    def test_roundtrip_preserves_configuration(self):
+        """Test full round-trip: save → destroy → apply → verify"""
+        # Step 1: Create test cpusets
+        cs_rt, cs_hk = self.create_test_cpusets()
+        original_rt_cpus = cs_rt.get_cpus()
+        original_hk_cpus = cs_hk.get_cpus()
+        original_rt_partition = cs_rt.get_partition_type()
+        original_hk_partition = cs_hk.get_partition_type()
+
+        # Step 2: Save configuration
+        save_cpusets_cmd(self.temp_file)
+
+        # Step 3: Destroy cpusets
+        cpuset.cleanup_cpusets('test_save_*', force=True, recursive=False)
+
+        # Step 4: Apply configuration
+        apply_cpusets_cmd(self.temp_file, verbose=False)
+
+        # Step 5: Verify configuration matches original
+        cs_rt_restored = cpuset.Cpuset('test_save_rt', existing_ok=True)
+        cs_hk_restored = cpuset.Cpuset('test_save_hk', existing_ok=True)
+
+        self.assertEqual(cs_rt_restored.get_cpus(), original_rt_cpus)
+        self.assertEqual(cs_hk_restored.get_cpus(), original_hk_cpus)
+        self.assertEqual(cs_rt_restored.get_partition_type(), original_rt_partition)
+        self.assertEqual(cs_hk_restored.get_partition_type(), original_hk_partition)
+
+    def test_save_with_no_cpusets(self):
+        """Test that save handles case with no cpusets gracefully"""
+        # Don't create any cpusets
+        # save_cpusets_cmd will print to stderr but shouldn't crash
+
+        # This should complete without error but save 0 cpusets
+        num_saved = profile.save_cpusets(self.temp_file, get_all_cpusets_info)
+        self.assertEqual(num_saved, 0)
+
+    def test_save_skips_system_cpusets(self):
+        """Test that save automatically filters out system cpusets"""
+        # Create one test cpuset
+        cs = cpuset.Cpuset('test_save_single')
+        cs.write_memnode('0')
+        cs.assign_cpus('0')
+
+        # Save (should only save test_save_single, not any .slice/.scope/.service cpusets)
+        save_cpusets_cmd(self.temp_file)
+
+        # Read YAML
+        from ruamel.yaml import YAML
+        yaml = YAML()
+        with open(self.temp_file, 'r') as f:
+            data = yaml.load(f)
+
+        # Verify only our test cpuset was saved (no system cpusets)
+        saved_names = [cs['name'] for cs in data['cpusets']]
+        for name in saved_names:
+            self.assertFalse(name.endswith(('.slice', '.scope', '.mount', '.service')))
+
+        # Cleanup
+        cpuset.destroy_cpuset('test_save_single', force=True)
+
+
+if __name__ == '__main__':
+    unittest.main()
-- 
2.55.0

