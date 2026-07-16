Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490CD44210A
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223980; cv=none; b=Dv2gkzlxCrIPNkRPMwsoM7crGSlh4ctlz1xRGJq/Ovf/9lw/z309x6JNCth99rAinY8zmcDxkAsjoYguAgFd0reDlsdzW0dfVA5/Zunkraze0eDqObkReCPdoftD39g3v6tqUkhSgq2LebKq4/3qv+pla9EkUYOLluE7k/N6oJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223980; c=relaxed/simple;
	bh=kXaVGwCpAimGLNFawFuE5vVSKzjijr9zBjQCRJVz+XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EP0GVI5VgWfcHY1w0QyftVRqFQ+ms/ktU803ZUOgXU58xvH3ryGzUC2BJrw3YSf5T1nhjqD3QGXMoQXJTppW9FIwItKlwfUr3JNNz6XP1ul4AnDvVBJeXAvEjNpXdiEKIsbOquWK/BAhtrfbXhjlJNqjED3tj4ymEGT+K9xJ+a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s8W5J/Nt; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8W5J/Nt"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-902f92b8504so61694576d6.2
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2026 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784223977; x=1784828777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXBQMCVsmnCe7ndWGvc5B5/1QaER0qVna/zoSZj5VY0=;
        b=s8W5J/Nt9jNvHJVC4Xas1BVaiHoOmksYWxP7jwsjPlwJOsyVGdiWUcpxvV75AgQi6M
         rnBmj19pNS3nqYb/zriocXKWRod/dLN5CBUpOhfl8YyKByRKcVS2jfY1VbwYEz/1nuU7
         Uj9ccu1rd9gxzXEGzade1++/Rd3+nmo+YxHKw5c2YKXpC6B3QkfkwaYwoqQjuQA0OOlA
         KUam+VBCrmL3iGoQlh50pC7f7htf5KP4Ya09kxo+7mOUGrXvMFnZsD466pXOMXVJAz29
         NTwsBkiX1Z96f0FIKe5KE6tW7NvjWFzJ5RmwGeu+p3HMCMv1cJbkV7F680kZXJS2jreY
         KtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223977; x=1784828777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SXBQMCVsmnCe7ndWGvc5B5/1QaER0qVna/zoSZj5VY0=;
        b=T4aykShmVvwGkEScBnm85WdeG0uSv0RT0BZ8JbUe8s+WwZ/UC/B62Pk1PDD1qiMtS0
         fWHzfs8IJSzzwjyC+IDRdWX9g8s2/DAgDK5G1/zj6sWPtzWkrkTva5OFxN6b80cTv/Zl
         LAM+dw3DqDexC7+iky42OvCW7zno7ysl5UJ1ewTjlcPgSxXq6m7pY1BO4voH8XgewIxO
         4pwPVlNi6wZH3ru8T7khxb1Zb8tOXonw69MitsyPKyTs45+2RczKyvUYQMJ7tXuLFlqG
         hjszlPSXkHE/oPJo2+YSYAldW6UE9SS7t0GOo4LpRK8ZO3HV42yzqa3xzCbOVbxJriww
         E0xw==
X-Gm-Message-State: AOJu0YzEdqObLYOaR6pPg3m2HYnZB27ZLnPUrgI10uLgyek23FMjmvMt
	Tgs2yOXaw4BlXEcoiU5zEeJbyhjgJZ7D3GlmYCJzWYp18fPhQ6SVXjscVk27pQ==
X-Gm-Gg: AfdE7cm+lP5dChLeEeyfXy/MDzogaCcMRXyPd99FG3d3Qoc0Ag+gKxDzNVCv4F1jssf
	NnMM2ESEJHsxUZkDPXlJfvGRtaDinNbvlglFI+ijunIcOE+BhfQB5KnPABLw/YIqvJTcsn2YK5Y
	Z5Fce8jwiRVwo3M9Sa292FvsleXcXHNd3HrC8mvtTriLpdDm3Qh3MoIuDVItTkGup4Omsw8/LOo
	B7VAo1O4Vgk6HTl1oUhon7Cic5awpe6+uVAjGWaOZ/C8ol0Byp6QWPnvDH9ZLXMgj9UXgHw+69g
	ewu2va7mfOBYQuaqDDW/FpD8eQw6TvZe4b+tpP20qkNF85PdbybNxLLScaygKRZpShH3Dm6Xmq3
	fxpDRC48+Glsv+981m+ArbY4TC5LKxY7qf/42V/Brly3GiFKHvqzv0kgeuBpyPnBH8Nlqv8d1Du
	l+rL1no+17QY8CluKlcyos7yRMiDKUKmm/czHqrG6IUH9k1hh/6Exr9rAZM3sezT4pAZVo
X-Received: by 2002:a05:6214:4006:b0:8fd:d5a7:f95c with SMTP id 6a1803df08f44-90758d0d7ccmr99814976d6.28.1784223976781;
        Thu, 16 Jul 2026 10:46:16 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e0347sm224952276d6.2.2026.07.16.10.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:46:16 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Chris White <chwhite@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH 6/7] tuna: Change housekeeping cpuset default to partition=member
Date: Thu, 16 Jul 2026 13:45:49 -0400
Message-ID: <20260716174554.126145-7-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716174554.126145-1-jkacur@redhat.com>
References: <20260716174554.126145-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the default partition type for housekeeping cpusets from 'isolated'
to 'member', aligning with rteval's design. In rteval, housekeeping cpusets
use partition=member while only the measurement cpuset uses partition=isolated.

This change makes tuna's behavior consistent with rteval for users who are
familiar with both tools.

Add a new --housekeeping-isolated flag to allow users to override the default
and create housekeeping cpusets with partition=isolated if desired.

Updated tests to reflect the new behavior:
- Fixed two existing tests to expect partition=member for housekeeping
- Added test_isolate_housekeeping_isolated_flag to verify the new flag works
- Updated tests/README.md to document the changes (159 total tests now)

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/README.md          | 27 +++++++++++++++------------
 tests/test_cpuset_cli.py | 30 ++++++++++++++++++++++++++++--
 tuna-cmd.py              |  8 ++++++--
 3 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/tests/README.md b/tests/README.md
index 1b96a54807f9..073f79837196 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -12,7 +12,7 @@ This directory contains the test suite for tuna, using Python's `unittest` frame
 # Run all non-root tests only (45 tests)
 make tests
 
-# Run ALL tests (all 158 tests, requires sudo for root-required tests)
+# Run ALL tests (all 159 tests, requires sudo for root-required tests)
 make test-all
 
 # Run specific test module
@@ -37,7 +37,7 @@ make tests
 # or
 make unit-tests
 
-# Using make (ALL tests including root-required tests, 158 tests)
+# Using make (ALL tests including root-required tests, 159 tests)
 make test-all
 
 # Using the test runner directly (non-root tests only)
@@ -186,7 +186,7 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - Note: TestCpusetsInit (5 tests) and TestNumaDetection (6 tests) run without root, see non-root section
   - Run: `sudo python3 -m unittest tests.test_cpuset -v` (runs all 43 tests with root)
 
-- **test_cpuset_cli.py** (50 tests) - CLI command tests
+- **test_cpuset_cli.py** (51 tests) - CLI command tests
   - TestGetNextTunaCpusetName: Auto-naming logic (tuna0, tuna1, gap-filling)
   - TestCpusetCreateCLI: Create command with auto/custom names, --isolated, and NUMA auto-detection/override
   - TestCpusetListCLI: List command with --pattern, --verbose, --skip-empty
@@ -196,9 +196,11 @@ Tests are organized using Python's `unittest` framework. Each test file contains
   - TestCpusetStatusCLI: Status command for system-wide cpuset overview
   - TestCpusetModifyCLI: Modify command with --add-cpus, --remove-cpus, --memory-nodes, --isolated/--no-isolated
   - TestTunaMoveCpusetCLI: Integration of --cpuset with tuna move command (5 tests)
-  - TestTunaIsolateCpusetCLI: Integration of --cpuset with tuna isolate command (8 tests)
+  - TestTunaIsolateCpusetCLI: Integration of --cpuset with tuna isolate command (9 tests)
     - Tests cpuset-based CPU isolation with isolated and housekeeping cpusets
-    - Verifies partition types, CPU assignments, and process migration
+    - Verifies partition types: isolated cpuset uses partition=isolated, housekeeping uses partition=member by default
+    - Tests --housekeeping-isolated flag to override default and make housekeeping partition=isolated
+    - Verifies CPU assignments and process migration
     - Tests error handling and backward compatibility
   - TestTunaRunCpusetCLI: Integration of --cpuset with tuna run command (5 tests)
     - test_run_with_cpuset_basic: Verifies running commands in cpusets
@@ -242,7 +244,7 @@ Tests are organized using Python's `unittest` framework. Each test file contains
     - test_save_skips_system_cpusets: Verify system cpuset filtering
   - Run: `sudo python3 -m unittest tests.test_save_apply -v`
 
-**Total: 158 tests** (45 non-root + 113 root-required)
+**Total: 159 tests** (45 non-root + 114 root-required)
 
 ### Test Requirements: Root vs Non-Root
 
@@ -301,7 +303,7 @@ These tests require root to create/manipulate cgroups:
    - Test task migration between cpusets
    - All tests clean up created cpusets in tearDown()
 
-2. **Cpuset CLI tests** (50 tests) test command-line interface functions
+2. **Cpuset CLI tests** (51 tests) test command-line interface functions
    - Test cpuset create/list/destroy/move/show/status/modify commands
    - Verify auto-naming logic (tuna0, tuna1, etc.)
    - Test NUMA-aware memory node auto-detection and manual override
@@ -309,7 +311,8 @@ These tests require root to create/manipulate cgroups:
    - Test process migration with --pids and --threads
    - Test cpuset modification with --add-cpus, --remove-cpus, --memory-nodes, --isolated
    - Test tuna move --cpuset integration (5 tests)
-   - Test tuna isolate --cpuset integration (8 tests) - cpuset-based CPU isolation
+   - Test tuna isolate --cpuset integration (9 tests) - cpuset-based CPU isolation
+   - Test --housekeeping-isolated flag to override default partition=member for housekeeping
    - Test tuna run --cpuset integration (5 tests) - running commands in cpusets
    - All tests clean up created cpusets afterwards
 
@@ -462,9 +465,9 @@ Ran 45 tests in 0.XXXs
 OK (skipped=102)
 ```
 
-### All Tests Including Root-Required (158 tests)
+### All Tests Including Root-Required (159 tests)
 
-Running with sudo will run all 158 tests:
+Running with sudo will run all 159 tests:
 
 ```bash
 $ sudo python3 -m unittest discover -s tests -p "test_*.py" -v
@@ -474,12 +477,12 @@ test_cpuset_path (test_cpuset.TestCpusetsInit) ... ok
 ... (32 cpuset module tests)
 test_first_name_is_tuna0 (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
 test_sequential_naming (test_cpuset_cli.TestGetNextTunaCpusetName) ... ok
-... (50 cpuset CLI tests)
+... (51 cpuset CLI tests)
 ... (6 show_threads --cpuset tests)
 ... (4 show_threads -G display tests)
 
 ----------------------------------------------------------------------
-Ran 158 tests in X.XXXs
+Ran 159 tests in X.XXXs
 
 OK
 ```
diff --git a/tests/test_cpuset_cli.py b/tests/test_cpuset_cli.py
index c95cea29b4a3..619c719094ac 100644
--- a/tests/test_cpuset_cli.py
+++ b/tests/test_cpuset_cli.py
@@ -1018,6 +1018,7 @@ class TestTunaIsolateCpusetCLI(unittest.TestCase):
         try:
             cpuset.cleanup_cpusets('tuna_*', force=True, recursive=False)
             cpuset.cleanup_cpusets('my_*', force=True, recursive=False)
+            cpuset.cleanup_cpusets('test_*', force=True, recursive=False)
         except:
             pass
 
@@ -1027,6 +1028,7 @@ class TestTunaIsolateCpusetCLI(unittest.TestCase):
         try:
             cpuset.cleanup_cpusets('tuna_*', force=True, recursive=False)
             cpuset.cleanup_cpusets('my_*', force=True, recursive=False)
+            cpuset.cleanup_cpusets('test_*', force=True, recursive=False)
         except:
             pass
 
@@ -1114,7 +1116,7 @@ class TestTunaIsolateCpusetCLI(unittest.TestCase):
 
         with open(f'{hk_path}/cpuset.cpus.partition') as f:
             partition = f.read().strip()
-            self.assertEqual(partition, 'isolated')
+            self.assertEqual(partition, 'member')
 
         # Verify processes were migrated to housekeeping
         with open(f'{hk_path}/cgroup.procs') as f:
@@ -1152,11 +1154,35 @@ class TestTunaIsolateCpusetCLI(unittest.TestCase):
             self.assertIn('2', cpus)
             self.assertIn('3', cpus)
 
-        # Both should be isolated partitions
+        # Verify partition types: isolated cpuset should be 'isolated', housekeeping should be 'member'
         with open('/sys/fs/cgroup/my_rt/cpuset.cpus.partition') as f:
             self.assertEqual(f.read().strip(), 'isolated')
 
         with open('/sys/fs/cgroup/my_hk/cpuset.cpus.partition') as f:
+            self.assertEqual(f.read().strip(), 'member')
+
+    def test_isolate_housekeeping_isolated_flag(self):
+        """Test --housekeeping-isolated flag makes housekeeping partition=isolated"""
+        result = subprocess.run([
+            sys.executable, './tuna-cmd.py', 'isolate',
+            '-c', '0-1', '--cpuset', 'test_iso',
+            '--cpuset-housekeeping', 'test_hk_iso', '2-3',
+            '--housekeeping-isolated'
+        ], capture_output=True, text=True)
+
+        self.assertEqual(result.returncode, 0, f"Command failed: {result.stderr}")
+        self.assertIn('test_iso', result.stdout)
+        self.assertIn('test_hk_iso', result.stdout)
+
+        # Verify both cpusets exist
+        self.assertTrue(os.path.exists('/sys/fs/cgroup/test_iso'))
+        self.assertTrue(os.path.exists('/sys/fs/cgroup/test_hk_iso'))
+
+        # Both should have partition=isolated when --housekeeping-isolated is used
+        with open('/sys/fs/cgroup/test_iso/cpuset.cpus.partition') as f:
+            self.assertEqual(f.read().strip(), 'isolated')
+
+        with open('/sys/fs/cgroup/test_hk_iso/cpuset.cpus.partition') as f:
             self.assertEqual(f.read().strip(), 'isolated')
 
     def test_isolate_housekeeping_without_cpuset_error(self):
diff --git a/tuna-cmd.py b/tuna-cmd.py
index 5e88ed252575..3d4414d93d0e 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -181,7 +181,9 @@ def gen_parser():
                         metavar='NAME', default=None,
                         help='Use cpusets for isolation with optional name (default: tuna_isolated, partition=isolated)')
     isolate.add_argument('--cpuset-housekeeping', nargs='+', metavar='...',
-                        help='Create housekeeping cpuset: [NAME] CPU-LIST (default name: tuna_housekeeping, partition=isolated)')
+                        help='Create housekeeping cpuset: [NAME] CPU-LIST (default name: tuna_housekeeping, partition=member)')
+    isolate.add_argument('--housekeeping-isolated', action='store_true',
+                        help='Make housekeeping cpuset use partition=isolated instead of member (requires --cpuset-housekeeping)')
 
     include_group = include.add_mutually_exclusive_group(required=True)
     include_group.add_argument('-c', '--cpus', **MODS['cpus'])
@@ -1694,7 +1696,9 @@ def main():
                     hk_cpuset = cpuset.Cpuset(housekeeping_name)
                     hk_cpuset.write_memnode(hk_numa)
                     hk_cpuset.assign_cpus(housekeeping_cpus)
-                    hk_cpuset.write_cpu_exclusive(True)  # partition=isolated
+                    # Default to partition=member (False) unless --housekeeping-isolated specified
+                    hk_isolated = getattr(args, 'housekeeping_isolated', False)
+                    hk_cpuset.write_cpu_exclusive(hk_isolated)
 
                     # Migrate processes from root to housekeeping
                     print(f"Migrating processes to housekeeping cpuset...")
-- 
2.55.0

