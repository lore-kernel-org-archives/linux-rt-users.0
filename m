Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613594;
	b=M778u2mdxa01Vdo1UU1i/7f3If0XakCp0BTDAz/iZ2wLF0NP3Bk0NELDhOgKwZmVNyMj
	 ovfdxABuauDgfve2j27Bd6rAPZqHboKb0E8EVwZhiT9mWhIUBEVqPyvS6S6fygEZ5YPuE
	 oA/khPYnsGaFj7B2JKw2joxbu2LVdLuD8NU3hcJJHrS2naapqssoRJ/2UnVEpofV6JPSV
	 FDhkjLfxbWXGMy+xKm9jL0e9MFKSW0So1eO3VanQrRoLlFRMaHMDqJwUx8viEDN/F1aeI
	 CkpBQiTeX/SYQyaxYVHw8+Q00Lea3kLfwnhhgEIRXpG3vd/rjHlwowdkv8IzQHDyozQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613594;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=4f+cQCwVFLqKFVUdExD20o9LSiJADCuOLxWz5bGa9Qs=;
	b=XX8k97jJ6JNtoB6F4IwUlg8CFN6g63MOqc/Ii8KMRajEitt31gtraBXBczMxmKzwjecD
	 v1lxYQLxid4Kn3xsEZUydzDP6kcPuif2k4KKhRC3pLlPLarpbeL8ARsc3b2UUajGrLrMo
	 tbjFuMdoO9n/nLVJ0M6x7c99ctlIYZITtHXAIaSNHYq80mCZgeSlq5CGMx0Q+sWHbuNqn
	 9cpdS2tMM/KvTnUhZqYVibUJwdLlyJCcxvyXgiSBCI47tN2nXkYJ9R33Oq9HGzsn3co7I
	 Hr4RV40QgMOT3AaS4ZwmZ9qJSeyIeQNbOMUt9dJ5qd5oHn/ALalFayNkoJmEQMkso6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LwBGoakJ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A02D606A329
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Nov 2026 23:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A02D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LwBGoakJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794613593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4f+cQCwVFLqKFVUdExD20o9LSiJADCuOLxWz5bGa9Qs=;
	b=LwBGoakJ5NiT3eozbn+MusVP+Twvm5wlVKN07j2Z/3O15/5lnPtSy7j7bXlD4l4CBaYqBq
	bFW7MmI38aX7Hqkq6GpFnMJmCqvHPwSPTkqg9xFE0Y8Mh4PVAPdwIQTGiEelzQwZmtFwRx
	wHTA1bpItLJ4qXIgXkcnXhQJLxuuwk0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-sbuHbL_uMQ-QdFmFZm7-sQ-1; Fri,
 13 Nov 2026 18:46:28 -0500
X-MC-Unique: sbuHbL_uMQ-QdFmFZm7-sQ-1
X-Mimecast-MFC-AGG-ID: sbuHbL_uMQ-QdFmFZm7-sQ_1794613588
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1E3F180035D
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Nov 2026 23:46:27 +0000 (UTC)
Received: from dev-workstation (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E706030001B9;
	Fri, 13 Nov 2026 23:46:26 +0000 (UTC)
From: Chris White <chwhite@redhat.com>
To: jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 4/5] tuna: Add --save-state to isolate and a restore command
Date: Fri, 13 Nov 2026 15:46:19 -0800
Message-ID: <20261113234620.1608227-5-chwhite@redhat.com>
In-Reply-To: <20261113234620.1608227-1-chwhite@redhat.com>
References: <20261113234620.1608227-1-chwhite@redhat.com>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

While 'tuna isolate' modifies process affinities, IRQ affinities, and
default_smp_affinity to clear isolated CPUs, the complementary
'tuna include' simply restores all allowed threads and IRQs to include
the isolated CPUs, without restoring exact pre-isolation affinities.
Processes that were deliberately pinned to a subset of CPUs lose their
original affinities.

Add '--save-state FILE' to 'tuna isolate' and a new 'tuna restore --state FILE'
command.
- 'isolate --save-state' captures exact pre- and post-isolation affinities
  for tasks, IRQs, and default_smp_affinity, along with task starttimes
  and system boot_id, saving them atomically to JSON.
- 'restore' resets affinities in reverse order: IRQs, default_smp_affinity,
  and tasks. Tasks whose affinity drifted after isolation or whose PID
  was reused (verified via /proc/<pid>/stat starttime) are safely skipped.
- Tests verify exact mask restoration, drift skipping, reused PID skipping,
  and mismatched boot_id rejection.

The restore path deliberately skips anything it no longer owns: a tid
whose starttime changed, a task or IRQ whose mask moved since isolation,
or an IRQ that disappeared. Those paths are covered by
tests/test_isolate_state.py, which needs no root and drives every
branch of save/load/capture/restore with the /proc helpers mocked.

This was tested and verified by running tuna isolation scenarios with
SameStack: its runtime isolation lease always passes --save-state and
calls 'tuna restore' on release, and the B-tuna campaign on realtime-04
ran the round trip for every rep, as did a 40-round soak on centos-dev.
A live round trip on a 12-CPU cgroup v2 host captured 1844 tasks and 16
IRQs, restored 1841 tasks and 16 IRQs exactly, skipped 3 threads that
exited mid-run, restored default_smp_affinity, and recorded the 6
unmovable managed IRQs as residual instead of attempting to restore
them.

Assisted-by: Apogee
Signed-off-by: Chris White <chwhite@redhat.com>
---
 Makefile                      |   7 +-
 docs/tuna.8                   |  13 +
 tests/README.md               |  15 +-
 tests/test_isolate_restore.py | 155 ++++++++++
 tests/test_isolate_state.py   | 550 ++++++++++++++++++++++++++++++++++
 tuna-cmd.py                   |  38 ++-
 tuna/isolate_state.py         | 233 ++++++++++++++
 7 files changed, 1001 insertions(+), 10 deletions(-)
 create mode 100644 tests/test_isolate_restore.py
 create mode 100644 tests/test_isolate_state.py
 create mode 100644 tuna/isolate_state.py

diff --git a/Makefile b/Makefile
index 9bee6cd..9cbafe5 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ cleanlogs:
 .PHONY: clean
 clean: pyclean
 
-.PHONY: tests unit-tests test-eperm test-converters test-cpuset test-cpuset-cli test-isolate-cpuset test-run-cpuset test-show-threads-cpuset test-show-threads-cgroups test-all
+.PHONY: tests unit-tests test-eperm test-converters test-cpuset test-cpuset-cli test-isolate-cpuset test-run-cpuset test-show-threads-cpuset test-show-threads-cgroups test-isolate-restore test-all
 tests: unit-tests
 
 unit-tests:
@@ -48,8 +48,11 @@ test-run-cpuset:
 test-show-threads-cpuset:
 	@sudo python3 -m unittest tests.test_show_threads_cpuset -v
 
+test-isolate-restore:
+	@sudo python3 -m unittest tests.test_isolate_restore tests.test_cpuset_errors -v
+
 test-show-threads-cgroups:
 	@python3 -m unittest tests.test_show_threads_cgroups.TestExtractCpusetName -v
 	@sudo python3 -m unittest tests.test_show_threads_cgroups.TestShowThreadsCgroupsDisplay -v
 
-test-all: test-eperm test-converters test-cpuset test-cpuset-cli test-show-threads-cpuset test-show-threads-cgroups
+test-all: test-eperm test-converters test-cpuset test-cpuset-cli test-show-threads-cpuset test-show-threads-cgroups test-isolate-restore
diff --git a/docs/tuna.8 b/docs/tuna.8
index 7920ddf..439ffbe 100644
--- a/docs/tuna.8
+++ b/docs/tuna.8
@@ -65,6 +65,19 @@ optional arguments:
   --cpuset-housekeeping [NAME] CPU-LIST
                         Create housekeeping cpuset: [NAME] CPU-LIST (default name:
                         tuna_housekeeping, partition=member)
+  --save-state STATE_FILE
+                        Save pre-isolation task, IRQ and default SMP affinity
+                        masks to STATE_FILE for later restoration with tuna restore
+.TP
+\fBtuna restore\fR
+usage: tuna-cmd.py restore [-h] --state STATE_FILE
+
+Restore task, IRQ and default SMP affinity masks saved by \fBtuna isolate --save-state\fR.
+Skips tasks whose affinity drifted or whose PID has been reused since isolation.
+
+optional arguments:
+  -h, --help            show this help message and exit
+  --state STATE_FILE    State file created by tuna isolate --save-state
 .TP
 \fBtuna include\fR
 usage: tuna-cmd.py include [-h] (-c CPU-LIST | -S CPU-SOCKET-LIST | -N)
diff --git a/tests/README.md b/tests/README.md
index 073f798..279bc21 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -9,10 +9,10 @@ This directory contains the test suite for tuna, using Python's `unittest` frame
 ## Quick Start
 
 ```bash
-# Run all non-root tests only (45 tests)
+# Run all non-root tests only (67 tests)
 make tests
 
-# Run ALL tests (all 159 tests, requires sudo for root-required tests)
+# Run ALL tests (all 175 tests, requires sudo for root-required tests)
 make test-all
 
 # Run specific test module
@@ -32,12 +32,12 @@ sudo python3 -m unittest tests.test_cpuset -v
 Run all unit tests using any of these methods:
 
 ```bash
-# Using make (non-root tests only, 45 tests)
+# Using make (non-root tests only, 67 tests)
 make tests
 # or
 make unit-tests
 
-# Using make (ALL tests including root-required tests, 159 tests)
+# Using make (ALL tests including root-required tests, 175 tests)
 make test-all
 
 # Using the test runner directly (non-root tests only)
@@ -117,7 +117,7 @@ Tests are organized using Python's `unittest` framework. Each test file contains
 
 ### Current Tests
 
-#### Non-Root Tests (45 tests)
+#### Non-Root Tests (67 tests)
 
 - **test_eperm_handling.py** (6 tests) - Tests for EPERM error handling
   - Verifies that Permission Denied errors are handled gracefully
@@ -244,13 +244,14 @@ Tests are organized using Python's `unittest` framework. Each test file contains
     - test_save_skips_system_cpusets: Verify system cpuset filtering
   - Run: `sudo python3 -m unittest tests.test_save_apply -v`
 
-**Total: 159 tests** (45 non-root + 114 root-required)
+**Total: 175 tests** (67 run without root; the rest need root or
+`ruamel.yaml`)
 
 ### Test Requirements: Root vs Non-Root
 
 The test suite is split between tests that require root and those that don't:
 
-#### Non-Root Tests (45 tests)
+#### Non-Root Tests (67 tests)
 
 These tests run without root privileges:
 
diff --git a/tests/test_isolate_restore.py b/tests/test_isolate_restore.py
new file mode 100644
index 0000000..3b1f171
--- /dev/null
+++ b/tests/test_isolate_restore.py
@@ -0,0 +1,155 @@
+#!/usr/bin/python3
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-only
+"""
+Test 'tuna isolate --save-state' followed by 'tuna restore'.
+
+These tests isolate a real CPU for a moment: every movable thread and IRQ
+on the system is moved off it and then put back. They need root.
+"""
+
+import json
+import os
+import subprocess
+import sys
+import tempfile
+import unittest
+from pathlib import Path
+
+ROOT = Path(__file__).parent.parent
+TUNA = [sys.executable, str(ROOT / 'tuna-cmd.py')]
+
+sys.path.insert(0, str(ROOT))
+
+# Child process: main thread pinned to {other, cpu}, worker thread to {cpu}
+CHILD = """
+import os, sys, threading
+cpu, other = int(sys.argv[1]), int(sys.argv[2])
+ready = threading.Event()
+def worker():
+    os.sched_setaffinity(0, {cpu})
+    print(threading.get_native_id(), flush=True)
+    ready.set()
+    threading.Event().wait()
+os.sched_setaffinity(0, {other, cpu})
+threading.Thread(target=worker, daemon=True).start()
+ready.wait()
+sys.stdin.read()
+"""
+
+
+def affinity(tid):
+    return os.sched_getaffinity(tid)
+
+
+@unittest.skipUnless(sys.platform.startswith('linux') and os.geteuid() == 0,
+                     "Requires root permissions")
+class TestIsolateRestore(unittest.TestCase):
+
+    def setUp(self):
+        allowed = sorted(os.sched_getaffinity(0))
+        if len(allowed) < 2:
+            self.skipTest("Requires at least two CPUs")
+        self.cpu, self.other = allowed[-1], allowed[0]
+        self.child = subprocess.Popen(
+            [sys.executable, '-c', CHILD, str(self.cpu), str(self.other)],
+            stdin=subprocess.PIPE, stdout=subprocess.PIPE, text=True)
+        self.worker = int(self.child.stdout.readline())
+        self.main = self.child.pid
+        self.tmp = tempfile.TemporaryDirectory()
+        self.state_file = os.path.join(self.tmp.name, 'state.json')
+        self.isolated = False
+
+    def tearDown(self):
+        if self.isolated:
+            # Never leave the CPU isolated, whatever the test did
+            subprocess.run(TUNA + ['restore', '--state', self.state_file],
+                           capture_output=True)
+        self.child.stdin.close()
+        self.child.stdout.close()
+        self.child.wait()
+        self.tmp.cleanup()
+
+    def isolate(self):
+        result = subprocess.run(TUNA + ['isolate', '-c', str(self.cpu),
+                                        '--save-state', self.state_file],
+                                capture_output=True, text=True)
+        self.isolated = True
+        self.assertEqual(result.returncode, 0, result.stderr)
+        with open(self.state_file, encoding='utf-8') as f:
+            return json.load(f)
+
+    def restore(self):
+        result = subprocess.run(TUNA + ['restore', '--state', self.state_file],
+                                capture_output=True, text=True)
+        self.isolated = False
+        summary = dict(item.split('=') for item in
+                       result.stdout.split('Restore summary: ')[1].split())
+        return result, summary
+
+    def irq_mask(self, irq):
+        from tuna import isolate_state
+        return set(isolate_state.read_irq_mask(f'{irq}/smp_affinity', os.cpu_count()))
+
+    def test_round_trip_is_exact(self):
+        state = self.isolate()
+        self.assertEqual(affinity(self.main), {self.other})
+        self.assertNotIn(self.cpu, affinity(self.worker))
+        self.assertEqual(state['cpus'], str(self.cpu))
+        self.assertIn(str(self.main), state['tasks'])
+        self.assertIn(str(self.worker), state['tasks'])
+
+        result, summary = self.restore()
+        self.assertEqual(result.returncode, 0, result.stderr)
+        self.assertEqual(affinity(self.main), {self.other, self.cpu})
+        self.assertEqual(affinity(self.worker), {self.cpu})
+        self.assertEqual(summary['tasks_failed'], '0')
+        self.assertEqual(summary['irqs_failed'], '0')
+        from tuna import tuna
+        for irq, item in state['irqs'].items():
+            # irqbalance may legitimately move an IRQ in the meantime
+            if f'IRQ {irq} affinity changed' in result.stderr:
+                continue
+            if os.path.exists(f'/proc/irq/{irq}'):
+                self.assertEqual(self.irq_mask(irq),
+                                 set(tuna.cpustring_to_list(item['before'])), f'IRQ {irq}')
+
+    def test_drift_is_skipped(self):
+        self.isolate()
+        os.sched_setaffinity(self.worker, {self.other})
+        result, summary = self.restore()
+        self.assertEqual(result.returncode, 0, result.stderr)
+        self.assertGreaterEqual(int(summary['tasks_drift']), 1)
+        self.assertIn(f'tid {self.worker} affinity changed', result.stderr)
+        self.assertEqual(affinity(self.worker), {self.other})
+        self.assertEqual(affinity(self.main), {self.other, self.cpu})
+
+    def test_reused_tid_is_skipped(self):
+        state = self.isolate()
+        isolated_mask = affinity(self.worker)
+        state['tasks'][str(self.worker)]['starttime'] += 1
+        with open(self.state_file, 'w', encoding='utf-8') as f:
+            json.dump(state, f)
+        result, summary = self.restore()
+        self.assertEqual(result.returncode, 0, result.stderr)
+        self.assertGreaterEqual(int(summary['tasks_reused']), 1)
+        self.assertIn(f'tid {self.worker} was reused', result.stderr)
+        self.assertEqual(affinity(self.worker), isolated_mask)
+        self.assertEqual(affinity(self.main), {self.other, self.cpu})
+
+    def test_state_from_another_boot_is_rejected(self):
+        state = self.isolate()
+        good = dict(state)
+        state['boot_id'] = '00000000-0000-0000-0000-000000000000'
+        with open(self.state_file, 'w', encoding='utf-8') as f:
+            json.dump(state, f)
+        result = subprocess.run(TUNA + ['restore', '--state', self.state_file],
+                                capture_output=True, text=True)
+        self.assertNotEqual(result.returncode, 0)
+        self.assertIn('different boot', result.stderr)
+        with open(self.state_file, 'w', encoding='utf-8') as f:
+            json.dump(good, f)
+
+
+if __name__ == '__main__':
+    unittest.main()
diff --git a/tests/test_isolate_state.py b/tests/test_isolate_state.py
new file mode 100644
index 0000000..9cd7b1f
--- /dev/null
+++ b/tests/test_isolate_state.py
@@ -0,0 +1,550 @@
+#!/usr/bin/python3
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-only
+"""
+Unit tests for tuna.isolate_state that do not need root.
+
+The module only ever touches /proc through a few small helpers, so the
+restore and capture logic is exercised here with those helpers mocked.
+tests/test_isolate_restore.py covers the same code end to end on a real
+system.
+"""
+
+import errno
+import json
+import os
+import sys
+import tempfile
+import unittest
+from pathlib import Path
+from unittest import mock
+
+if Path(__file__).parent.name == 'tests':
+    sys.path.insert(0, str(Path(__file__).parent.parent))
+
+from tuna import isolate_state
+
+NR_CPUS = 8
+
+
+def state(tasks=None, irqs=None, default=None, cpus='7'):
+    """Build a state dict shaped like isolate_state.capture() returns"""
+    return {
+        'version': isolate_state.STATE_VERSION,
+        'boot_id': isolate_state.boot_id(),
+        'cpus': cpus,
+        'tasks': tasks or {},
+        'irqs': irqs or {},
+        'default_smp_affinity': default or {'before': '0-7', 'after': '0-6'},
+        'residual_irqs': [],
+    }
+
+
+class Warns:
+    """Collect the warning callback messages"""
+
+    def __init__(self):
+        self.messages = []
+
+    def __call__(self, message):
+        self.messages.append(message)
+
+
+class TestRestoreTasks(unittest.TestCase):
+    """_restore_tasks() must only touch tasks it still owns"""
+
+    def run_restore(self, tasks, starttime=100, current=(0, 1, 2)):
+        warn = Warns()
+        result = self.new_result()
+        with mock.patch.object(isolate_state, 'task_starttime',
+                               return_value=starttime), \
+             mock.patch.object(isolate_state.os, 'sched_getaffinity',
+                               return_value=set(current)), \
+             mock.patch.object(isolate_state.os, 'sched_setaffinity') as setaff:
+            isolate_state._restore_tasks(tasks, result, warn)
+        return result, warn, setaff
+
+    @staticmethod
+    def new_result():
+        return dict.fromkeys(('tasks_restored', 'tasks_exited', 'tasks_reused',
+                              'tasks_drift', 'tasks_failed'), 0)
+
+    def task(self, starttime=100, before='0-2', after='0-2'):
+        return {'starttime': starttime, 'before': before, 'after': after}
+
+    def test_restores_when_unchanged(self):
+        result, warn, setaff = self.run_restore({'42': self.task()})
+        setaff.assert_called_once_with(42, [0, 1, 2])
+        self.assertEqual(result['tasks_restored'], 1)
+        self.assertEqual(warn.messages, [])
+
+    def test_exited_task_is_counted(self):
+        result, warn, setaff = self.run_restore(
+            {'42': self.task()}, starttime=None)
+        setaff.assert_not_called()
+        self.assertEqual(result['tasks_exited'], 1)
+        self.assertEqual(warn.messages, [])
+
+    def test_reused_tid_is_skipped(self):
+        """A different task now owns the tid, so leave it alone"""
+        result, warn, setaff = self.run_restore(
+            {'42': self.task(starttime=100)}, starttime=999)
+        setaff.assert_not_called()
+        self.assertEqual(result['tasks_reused'], 1)
+        self.assertIn('was reused', warn.messages[0])
+        self.assertIn('42', warn.messages[0])
+
+    def test_drift_is_skipped(self):
+        result, warn, setaff = self.run_restore(
+            {'42': self.task(after='0-2')}, current=(0, 1, 5))
+        setaff.assert_not_called()
+        self.assertEqual(result['tasks_drift'], 1)
+        self.assertIn('affinity changed', warn.messages[0])
+
+    def test_disappeared_before_getaffinity(self):
+        warn = Warns()
+        result = self.new_result()
+        with mock.patch.object(isolate_state, 'task_starttime', return_value=100), \
+             mock.patch.object(isolate_state.os, 'sched_getaffinity',
+                               side_effect=ProcessLookupError), \
+             mock.patch.object(isolate_state.os, 'sched_setaffinity') as setaff:
+            isolate_state._restore_tasks({'42': self.task()}, result, warn)
+        setaff.assert_not_called()
+        self.assertEqual(result['tasks_exited'], 1)
+
+    def test_disappeared_before_setaffinity(self):
+        warn = Warns()
+        result = self.new_result()
+        with mock.patch.object(isolate_state, 'task_starttime', return_value=100), \
+             mock.patch.object(isolate_state.os, 'sched_getaffinity',
+                               return_value={0, 1}), \
+             mock.patch.object(isolate_state.os, 'sched_setaffinity',
+                               side_effect=ProcessLookupError):
+            isolate_state._restore_tasks({'42': self.task(after='0-1')},
+                                         result, warn)
+        self.assertEqual(result['tasks_exited'], 1)
+
+    def test_setaffinity_error_is_a_failure(self):
+        warn = Warns()
+        result = self.new_result()
+        with mock.patch.object(isolate_state, 'task_starttime', return_value=100), \
+             mock.patch.object(isolate_state.os, 'sched_getaffinity',
+                               return_value={0, 1}), \
+             mock.patch.object(isolate_state.os, 'sched_setaffinity',
+                               side_effect=OSError(errno.EPERM,
+                                                   'Operation not permitted')):
+            isolate_state._restore_tasks({'42': self.task(after='0-1')},
+                                         result, warn)
+        self.assertEqual(result['tasks_failed'], 1)
+        self.assertIn('cannot restore affinity', warn.messages[0])
+
+    def test_tasks_are_visited_in_numeric_order(self):
+        warn = Warns()
+        result = self.new_result()
+        seen = []
+        with mock.patch.object(isolate_state, 'task_starttime', return_value=100), \
+             mock.patch.object(isolate_state.os, 'sched_getaffinity',
+                               return_value={0, 1}), \
+             mock.patch.object(isolate_state.os, 'sched_setaffinity',
+                               side_effect=lambda tid, cpus: seen.append(tid)):
+            isolate_state._restore_tasks(
+                {'1000': self.task(after='0-1'), '9': self.task(after='0-1')},
+                result, warn)
+        self.assertEqual(seen, [9, 1000])
+
+
+class TestRestoreIrqs(unittest.TestCase):
+    """_restore_irqs() must skip IRQs that moved or vanished"""
+
+    @staticmethod
+    def new_result():
+        return dict.fromkeys(('irqs_restored', 'irqs_gone', 'irqs_drift',
+                              'irqs_failed'), 0)
+
+    def run_restore(self, irqs, current=(0, 1), write_ok=True):
+        warn = Warns()
+        result = self.new_result()
+        with mock.patch.object(isolate_state, 'read_irq_mask',
+                               return_value=list(current)), \
+             mock.patch.object(isolate_state, 'write_irq_mask',
+                               return_value=write_ok) as write:
+            isolate_state._restore_irqs(irqs, NR_CPUS, result, warn)
+        return result, warn, write
+
+    def irq(self, before='0-2', after='0-1'):
+        return {'before': before, 'after': after}
+
+    def test_restores_when_unchanged(self):
+        result, warn, write = self.run_restore({'30': self.irq()})
+        write.assert_called_once_with('30/smp_affinity', [0, 1, 2], NR_CPUS)
+        self.assertEqual(result['irqs_restored'], 1)
+        self.assertEqual(warn.messages, [])
+
+    def test_gone_irq_is_counted(self):
+        warn = Warns()
+        result = self.new_result()
+        with mock.patch.object(isolate_state, 'read_irq_mask',
+                               side_effect=FileNotFoundError):
+            isolate_state._restore_irqs({'30': self.irq()}, NR_CPUS, result, warn)
+        self.assertEqual(result['irqs_gone'], 1)
+        self.assertEqual(warn.messages, [])
+
+    def test_drift_is_skipped(self):
+        result, warn, write = self.run_restore({'30': self.irq()},
+                                               current=(0, 5))
+        write.assert_not_called()
+        self.assertEqual(result['irqs_drift'], 1)
+        self.assertIn('IRQ 30 affinity changed', warn.messages[0])
+
+    def test_failed_write_is_counted(self):
+        result, warn, write = self.run_restore({'30': self.irq()},
+                                               write_ok=False)
+        self.assertEqual(result['irqs_failed'], 1)
+        self.assertIn('cannot restore affinity', warn.messages[0])
+
+    def test_irqs_are_visited_in_numeric_order(self):
+        warn = Warns()
+        result = self.new_result()
+        seen = []
+        with mock.patch.object(isolate_state, 'read_irq_mask',
+                               return_value=[0, 1]), \
+             mock.patch.object(isolate_state, 'write_irq_mask',
+                               side_effect=lambda f, c, n: seen.append(f) or True):
+            isolate_state._restore_irqs(
+                {'100': self.irq(), '9': self.irq()}, NR_CPUS, result, warn)
+        self.assertEqual(seen, ['9/smp_affinity', '100/smp_affinity'])
+
+
+class TestRestoreDefault(unittest.TestCase):
+    """_restore_default() has three outcomes plus a failure"""
+
+    def run_restore(self, current, before='0-7', after='0-6', write_ok=True):
+        warn = Warns()
+        with mock.patch.object(isolate_state, 'read_irq_mask',
+                               return_value=list(current)), \
+             mock.patch.object(isolate_state, 'write_irq_mask',
+                               return_value=write_ok) as write:
+            outcome = isolate_state._restore_default(
+                {'before': before, 'after': after}, NR_CPUS, warn)
+        return outcome, warn, write
+
+    def test_already_restored_is_unchanged(self):
+        outcome, warn, write = self.run_restore((0, 1, 2, 3, 4, 5, 6, 7))
+        write.assert_not_called()
+        self.assertEqual(outcome, 'unchanged')
+        self.assertEqual(warn.messages, [])
+
+    def test_restores_when_still_at_after(self):
+        outcome, warn, write = self.run_restore((0, 1, 2, 3, 4, 5, 6))
+        write.assert_called_once_with('default_smp_affinity',
+                                      [0, 1, 2, 3, 4, 5, 6, 7], NR_CPUS)
+        self.assertEqual(outcome, 'restored')
+
+    def test_drift_is_reported(self):
+        outcome, warn, write = self.run_restore((0, 5))
+        write.assert_not_called()
+        self.assertEqual(outcome, 'drift')
+        self.assertIn('default_smp_affinity changed', warn.messages[0])
+
+    def test_failed_write_is_reported(self):
+        outcome, warn, write = self.run_restore((0, 1, 2, 3, 4, 5, 6),
+                                                write_ok=False)
+        self.assertEqual(outcome, 'failed')
+        self.assertIn('cannot restore', warn.messages[0])
+
+
+class TestRestoreSummary(unittest.TestCase):
+    """restore() orchestrates the three phases and failed() judges them"""
+
+    def test_restore_runs_irqs_then_default_then_tasks(self):
+        order = []
+        with mock.patch.object(isolate_state, '_restore_irqs',
+                               side_effect=lambda *a: order.append('irqs')), \
+             mock.patch.object(isolate_state, '_restore_default',
+                               side_effect=lambda *a: order.append('default') or 'restored'), \
+             mock.patch.object(isolate_state, '_restore_tasks',
+                               side_effect=lambda *a: order.append('tasks')):
+            isolate_state.restore(state(), NR_CPUS, Warns())
+        self.assertEqual(order, ['irqs', 'default', 'tasks'])
+
+    def test_summary_has_every_counter(self):
+        with mock.patch.object(isolate_state, '_restore_irqs'), \
+             mock.patch.object(isolate_state, '_restore_default',
+                               return_value='unchanged'), \
+             mock.patch.object(isolate_state, '_restore_tasks'):
+            result = isolate_state.restore(state(), NR_CPUS, Warns())
+        self.assertEqual(result, {
+            'tasks_restored': 0, 'tasks_exited': 0, 'tasks_reused': 0,
+            'tasks_drift': 0, 'tasks_failed': 0, 'irqs_restored': 0,
+            'irqs_gone': 0, 'irqs_drift': 0, 'irqs_failed': 0,
+            'default_smp_affinity': 'unchanged',
+        })
+
+    def test_clean_restore_is_not_a_failure(self):
+        self.assertFalse(isolate_state.failed({
+            'tasks_failed': 0, 'irqs_failed': 0,
+            'default_smp_affinity': 'restored'}))
+
+    def test_skips_are_not_failures(self):
+        """Drift and reuse are expected; they must not fail the command"""
+        self.assertFalse(isolate_state.failed({
+            'tasks_failed': 0, 'irqs_failed': 0,
+            'default_smp_affinity': 'drift'}))
+
+    def test_each_failure_kind_is_a_failure(self):
+        for result in ({'tasks_failed': 1, 'irqs_failed': 0,
+                        'default_smp_affinity': 'restored'},
+                       {'tasks_failed': 0, 'irqs_failed': 1,
+                        'default_smp_affinity': 'restored'},
+                       {'tasks_failed': 0, 'irqs_failed': 0,
+                        'default_smp_affinity': 'failed'}):
+            self.assertTrue(isolate_state.failed(result), result)
+
+
+class TestSaveAndLoad(unittest.TestCase):
+    """save() is atomic and load() rejects states it cannot honour"""
+
+    def setUp(self):
+        self.tmp = tempfile.TemporaryDirectory()
+        self.path = os.path.join(self.tmp.name, 'state.json')
+
+    def tearDown(self):
+        self.tmp.cleanup()
+
+    def test_round_trip(self):
+        original = state(tasks={'42': {'starttime': 1, 'before': '0-2',
+                                      'after': '0-1'}})
+        isolate_state.save(self.path, original)
+        self.assertEqual(isolate_state.load(self.path), original)
+
+    def test_saved_file_is_sorted_and_newline_terminated(self):
+        isolate_state.save(self.path, state())
+        text = Path(self.path).read_text()
+        self.assertTrue(text.endswith('\n'))
+        self.assertIn('"boot_id"', text)
+        self.assertLess(text.index('"boot_id"'), text.index('"cpus"'))
+
+    def test_no_temporary_file_is_left_behind(self):
+        isolate_state.save(self.path, state())
+        self.assertEqual(sorted(os.listdir(self.tmp.name)), ['state.json'])
+
+    def test_failed_write_leaves_no_temporary_file(self):
+        with mock.patch.object(isolate_state.os, 'replace',
+                               side_effect=OSError(errno.ENOSPC, 'No space')):
+            with self.assertRaises(OSError):
+                isolate_state.save(self.path, state())
+        self.assertEqual(os.listdir(self.tmp.name), [])
+
+    def test_cleanup_tolerates_an_already_removed_temp_file(self):
+        """The cleanup must not mask the original error"""
+        with mock.patch.object(isolate_state.os, 'replace',
+                               side_effect=OSError(errno.ENOSPC, 'No space')), \
+             mock.patch.object(isolate_state.os.path, 'exists',
+                               return_value=False):
+            with self.assertRaises(OSError) as ctx:
+                isolate_state.save(self.path, state())
+        self.assertEqual(ctx.exception.errno, errno.ENOSPC)
+
+    def test_rejects_a_different_boot(self):
+        written = state()
+        written['boot_id'] = '00000000-0000-0000-0000-000000000000'
+        isolate_state.save(self.path, written)
+        with self.assertRaises(ValueError) as ctx:
+            isolate_state.load(self.path)
+        self.assertIn('different boot', str(ctx.exception))
+
+    def test_rejects_an_unknown_version(self):
+        written = state()
+        written['version'] = isolate_state.STATE_VERSION + 1
+        with mock.patch.object(isolate_state, 'boot_id',
+                               return_value=written['boot_id']):
+            isolate_state.save(self.path, written)
+            with self.assertRaises(ValueError) as ctx:
+                isolate_state.load(self.path)
+        self.assertIn('unsupported state version', str(ctx.exception))
+
+    def test_rejects_missing_version(self):
+        Path(self.path).write_text(json.dumps({'boot_id': 'x'}))
+        with self.assertRaises(ValueError):
+            isolate_state.load(self.path)
+
+
+class TestCapture(unittest.TestCase):
+    """capture() records only what isolation actually changed"""
+
+    def capture(self, pid_before, irqs_after=None, cpus=(7,), default_before=(0, 1, 2, 3, 4, 5, 6, 7),
+                after_affinity=(0, 1, 2), starttime=100):
+        irqs_after = irqs_after or {}
+        irq_before = {'30': [0, 7], '31': [0, 1]}
+
+        def read_mask(filename, nr_cpus):
+            if filename == 'default_smp_affinity':
+                return [0, 1, 2, 3, 4, 5, 6]
+            irq = filename.split('/')[0]
+            if irq not in irqs_after:
+                raise FileNotFoundError
+            return irqs_after[irq]
+
+        with mock.patch.object(isolate_state, 'task_starttime',
+                               return_value=starttime), \
+             mock.patch.object(isolate_state.os, 'sched_getaffinity',
+                               return_value=set(after_affinity)), \
+             mock.patch.object(isolate_state, 'read_irq_mask',
+                               side_effect=read_mask), \
+             mock.patch.object(isolate_state, 'boot_id', return_value='boot'):
+            return isolate_state.capture(list(cpus), NR_CPUS, pid_before,
+                                         irq_before, list(default_before))
+
+    def test_changed_task_is_recorded(self):
+        st = self.capture({42: [0, 1, 2, 7]})
+        self.assertEqual(st['tasks']['42'],
+                         {'starttime': 100, 'before': '0-2,7', 'after': '0-2'})
+
+    def test_unchanged_task_is_not_recorded(self):
+        st = self.capture({42: [0, 1, 2]})
+        self.assertEqual(st['tasks'], {})
+
+    def test_exited_task_is_not_recorded(self):
+        st = self.capture({42: [0, 1, 2, 7]}, irqs_after={}, starttime=None)
+        self.assertEqual(st['tasks'], {})
+
+    def test_irq_still_on_isolated_cpu_is_residual(self):
+        st = self.capture({}, irqs_after={'30': [0, 7], '31': [0, 1]})
+        self.assertEqual(st['residual_irqs'], [30])
+        # It did not move, so it must not be recorded as changed
+        self.assertEqual(st['irqs'], {})
+
+    def test_task_that_died_mid_capture_is_skipped(self):
+        """starttime succeeded but the task was gone for sched_getaffinity"""
+        with mock.patch.object(isolate_state, 'task_starttime', return_value=100), \
+             mock.patch.object(isolate_state.os, 'sched_getaffinity',
+                               side_effect=ProcessLookupError), \
+             mock.patch.object(isolate_state, 'read_irq_mask', return_value=[]), \
+             mock.patch.object(isolate_state, 'boot_id', return_value='boot'):
+            st = isolate_state.capture([7], NR_CPUS, {42: [0, 7]}, {}, [0, 7])
+        self.assertEqual(st['tasks'], {})
+
+    def test_vanished_irq_is_skipped(self):
+        st = self.capture({}, irqs_after={'31': [0, 2]})
+        self.assertEqual(sorted(st['irqs']), ['31'])
+        self.assertEqual(st['residual_irqs'], [])
+
+    def test_unchanged_irq_is_not_recorded(self):
+        st = self.capture({}, irqs_after={'30': [0, 7], '31': [0, 1]})
+        self.assertEqual(st['irqs'], {})
+
+    def test_default_affinity_is_recorded(self):
+        st = self.capture({})
+        self.assertEqual(st['default_smp_affinity'],
+                         {'before': '0-7', 'after': '0-6'})
+
+    def test_header_fields(self):
+        st = self.capture({}, cpus=[7])
+        self.assertEqual(st['version'], isolate_state.STATE_VERSION)
+        self.assertEqual(st['boot_id'], 'boot')
+        self.assertEqual(st['cpus'], '7')
+
+
+class TestIrqMaskHelpers(unittest.TestCase):
+    """write_irq_mask() reports whether the write actually took"""
+
+    def test_write_ok_when_it_reads_back(self):
+        with mock.patch.object(isolate_state.tuna, 'set_irq_affinity_filename',
+                               return_value=True), \
+             mock.patch.object(isolate_state, 'read_irq_mask',
+                               return_value=[0, 1]):
+            self.assertTrue(isolate_state.write_irq_mask('30/smp_affinity',
+                                                         [0, 1], NR_CPUS))
+
+    def test_write_false_when_close_failed(self):
+        with mock.patch.object(isolate_state.tuna, 'set_irq_affinity_filename',
+                               return_value=False):
+            self.assertFalse(isolate_state.write_irq_mask('30/smp_affinity',
+                                                          [0, 1], NR_CPUS))
+
+    def test_write_false_when_readback_differs(self):
+        with mock.patch.object(isolate_state.tuna, 'set_irq_affinity_filename',
+                               return_value=True), \
+             mock.patch.object(isolate_state, 'read_irq_mask',
+                               return_value=[0, 1, 2]):
+            self.assertFalse(isolate_state.write_irq_mask('30/smp_affinity',
+                                                          [0, 1], NR_CPUS))
+
+    def test_write_false_on_oserror(self):
+        with mock.patch.object(isolate_state.tuna, 'set_irq_affinity_filename',
+                               side_effect=OSError(errno.EIO, 'I/O error')):
+            self.assertFalse(isolate_state.write_irq_mask('30/smp_affinity',
+                                                          [0, 1], NR_CPUS))
+
+
+class TestProcReaders(unittest.TestCase):
+    """task_starttime() and read_irq_mask() against a fake procfs"""
+
+    def setUp(self):
+        self.tmp = tempfile.TemporaryDirectory()
+        self.root = self.tmp.name
+
+    def tearDown(self):
+        self.tmp.cleanup()
+
+    def proc_file(self, relative, text):
+        path = os.path.join(self.root, relative)
+        os.makedirs(os.path.dirname(path), exist_ok=True)
+        with open(path, 'w', encoding='utf-8') as f:
+            f.write(text)
+        return path
+
+    def test_starttime_parses_field_22(self):
+        # Fields after comm: state ppid pgrp session tty tpgid flags minflt
+        # cminflt majflt cmajflt utime stime cutime cstime priority nice
+        # num_threads itrealvalue starttime -> index 19
+        fields = ['S', '1', '1', '1', '0', '-1', '4194560'] + ['0'] * 12 + ['4242']
+        self.proc_file('1234/stat', f'1234 (app) {" ".join(fields)}\n')
+        real_open = open
+
+        def fake_open(path, *args, **kwargs):
+            path = str(path)
+            if path.startswith('/proc/1234/'):
+                return real_open(os.path.join(self.root, '1234', 'stat'),
+                                 *args, **kwargs)
+            return real_open(path, *args, **kwargs)
+
+        with mock.patch('builtins.open', side_effect=fake_open):
+            self.assertEqual(isolate_state.task_starttime(1234), 4242)
+
+    def test_starttime_handles_spaces_and_parens_in_comm(self):
+        fields = ['S', '1', '1', '1', '0', '-1', '4194560'] + ['0'] * 12 + ['77']
+        self.proc_file('55/stat', f'55 (a (weird) name) {" ".join(fields)}\n')
+        real_open = open
+
+        def fake_open(path, *args, **kwargs):
+            path = str(path)
+            if path.startswith('/proc/55/'):
+                return real_open(os.path.join(self.root, '55', 'stat'),
+                                 *args, **kwargs)
+            return real_open(path, *args, **kwargs)
+
+        with mock.patch('builtins.open', side_effect=fake_open):
+            self.assertEqual(isolate_state.task_starttime(55), 77)
+
+    def test_starttime_returns_none_for_gone_task(self):
+        self.assertIsNone(isolate_state.task_starttime(999999999))
+
+    def test_read_irq_mask_parses_the_file(self):
+        self.proc_file('irq/30/smp_affinity', '00000000,0000000f\n')
+        real_open = open
+
+        def fake_open(path, *args, **kwargs):
+            path = str(path)
+            if path.startswith('/proc/irq/30/'):
+                return real_open(os.path.join(self.root, 'irq', '30',
+                                              'smp_affinity'), *args, **kwargs)
+            return real_open(path, *args, **kwargs)
+
+        with mock.patch('builtins.open', side_effect=fake_open):
+            self.assertEqual(isolate_state.read_irq_mask('30/smp_affinity', NR_CPUS),
+                             [0, 1, 2, 3])
+
+
+if __name__ == '__main__':
+    unittest.main()
diff --git a/tuna-cmd.py b/tuna-cmd.py
index 62972cd..e40ec2f 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -23,6 +23,7 @@ import tuna.tuna_sched as tuna_sched
 import procfs
 from tuna import tuna, sysfs, utils
 from tuna import cpuset
+from tuna import isolate_state
 from tuna.version import TUNA_VERSION
 import logging
 import time
@@ -203,6 +204,8 @@ def gen_parser():
                                     help="Move all allowed threads and IRQs away from CPU-LIST")
     include = subparser.add_parser('include', description="Allow all threads to run on CPU-LIST",
                                      help="Allow all threads to run on CPU-LIST")
+    restore = subparser.add_parser('restore', description="Restore the thread and IRQ affinities saved by 'tuna isolate --save-state'",
+                                     help="Undo 'tuna isolate --save-state'")
     move = subparser.add_parser('move', description="Move selected threads/IRQs to specified CPUs, sockets, or cpusets",
                                     help="Move selected threads/IRQs to specified CPUs, sockets, or cpusets")
     spread = subparser.add_parser('spread', description="Spread selected entities to CPU-LIST",
@@ -229,6 +232,11 @@ def gen_parser():
                         help='Create housekeeping cpuset: [NAME] CPU-LIST (default name: tuna_housekeeping, partition=member)')
     isolate.add_argument('--housekeeping-isolated', action='store_true',
                         help='Make housekeeping cpuset use partition=isolated instead of member (requires --cpuset-housekeeping)')
+    isolate.add_argument('--save-state', type=str, metavar='FILE', default=None,
+                        help="Save the changed thread and IRQ affinities to FILE for 'tuna restore'")
+
+    restore.add_argument('--state', type=str, metavar='FILE', required=True,
+                         help="State file written by 'tuna isolate --save-state'")
 
     include_group = include.add_mutually_exclusive_group(required=True)
     include_group.add_argument('-c', '--cpus', **MODS['cpus'])
@@ -1691,6 +1699,18 @@ def main():
     if args.command in ['include', 'I']:
         tuna.include_cpus(args.cpu_list, utils.get_nr_cpus())
 
+    elif args.command == 'restore':
+        try:
+            state = isolate_state.load(args.state)
+        except (OSError, ValueError) as e:
+            print(f"Error reading state file: {e}", file=sys.stderr)
+            sys.exit(1)
+        result = isolate_state.restore(state, utils.get_nr_cpus(),
+                                       lambda msg: print(f"Warning: {msg}", file=sys.stderr))
+        print("Restore summary: " + " ".join(f"{k}={v}" for k, v in result.items()))
+        if isolate_state.failed(result):
+            sys.exit(1)
+
     elif args.command in ['isolate', 'i']:
         # Parse --cpuset-housekeeping arguments
         housekeeping_name = None
@@ -1713,8 +1733,24 @@ def main():
                 print("Error: --cpuset-housekeeping takes 1 or 2 arguments: [NAME] CPU-LIST", file=sys.stderr)
                 sys.exit(1)
 
+        nr_cpus = utils.get_nr_cpus()
+        if args.save_state:
+            default_before = isolate_state.read_irq_mask('default_smp_affinity', nr_cpus)
+
         # Traditional affinity-based isolation (existing behavior)
-        tuna.isolate_cpus(args.cpu_list, utils.get_nr_cpus())
+        pid_before, irq_before = tuna.isolate_cpus(args.cpu_list, nr_cpus)
+
+        # Save before creating cpusets, so a failed partition can be undone
+        if args.save_state:
+            try:
+                state = isolate_state.capture(args.cpu_list, nr_cpus, pid_before,
+                                              irq_before, default_before)
+                isolate_state.save(args.save_state, state)
+            except (OSError, ValueError) as e:
+                print(f"Error saving isolation state: {e}", file=sys.stderr)
+                sys.exit(1)
+            print(f"Saved {len(state['tasks'])} thread and {len(state['irqs'])} "
+                  f"IRQ affinities to {args.save_state}")
 
         # Create cpusets if requested
         if args.cpuset:
diff --git a/tuna/isolate_state.py b/tuna/isolate_state.py
new file mode 100644
index 0000000..6af3764
--- /dev/null
+++ b/tuna/isolate_state.py
@@ -0,0 +1,233 @@
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-only
+"""
+Save and restore the thread and IRQ affinities changed by 'tuna isolate'.
+
+'tuna include' is not an exact undo of 'tuna isolate': it adds the CPUs to
+every affinity, so a thread or IRQ that was pinned to a few CPUs comes back
+wider than it was. 'tuna isolate --save-state FILE' records what isolation
+changed, and 'tuna restore --state FILE' puts back exactly that, skipping
+anything that changed again in the meantime.
+"""
+
+import json
+import os
+import tempfile
+
+import procfs
+from procfs import utilist
+from tuna import tuna
+
+STATE_VERSION = 1
+
+
+def boot_id():
+    """ Return the current boot ID """
+    with open('/proc/sys/kernel/random/boot_id', encoding='utf-8') as f:
+        return f.read().strip()
+
+
+def task_starttime(tid):
+    """ Return the start time of TID, or None if it no longer exists """
+    try:
+        with open(f'/proc/{tid}/stat', encoding='utf-8') as f:
+            stat = f.read()
+    except (FileNotFoundError, ProcessLookupError):
+        return None
+    # comm can contain spaces and ')'; field 3 starts after the last ')'
+    return int(stat[stat.rindex(')') + 2:].split()[19])
+
+
+def read_irq_mask(filename, nr_cpus):
+    """ Return the CPUs in /proc/irq/FILENAME as a sorted list """
+    with open(f'/proc/irq/{filename}', encoding='utf-8') as f:
+        return sorted(utilist.bitmasklist(f.read(), nr_cpus))
+
+
+def write_irq_mask(filename, cpus, nr_cpus):
+    """ Write CPUS to /proc/irq/FILENAME and return True if it reads back """
+    try:
+        if not tuna.set_irq_affinity_filename(filename,
+                                              procfs.hexbitmask(cpus, nr_cpus)):
+            return False
+        return set(read_irq_mask(filename, nr_cpus)) == set(cpus)
+    except OSError:
+        return False
+
+
+def capture(cpus, nr_cpus, pid_before, irq_before, default_before):
+    """
+    Build the state of an isolation that has just been applied.
+
+    Args:
+        cpus: the isolated CPUs
+        nr_cpus: number of CPUs on the system
+        pid_before, irq_before: the dictionaries returned by isolate_cpus()
+        default_before: default_smp_affinity before isolate_cpus() ran
+
+    Only entries whose affinity actually changed are recorded. IRQs that
+    still include an isolated CPU (e.g. managed IRQs) are listed in
+    'residual_irqs'.
+    """
+    tasks = {}
+    for tid, before in sorted(pid_before.items()):
+        starttime = task_starttime(tid)
+        if starttime is None:
+            continue
+        try:
+            after = os.sched_getaffinity(tid)
+        except ProcessLookupError:
+            continue
+        if set(after) != set(before):
+            tasks[str(tid)] = {'starttime': starttime,
+                               'before': tuna.collapse_cpulist(before),
+                               'after': tuna.collapse_cpulist(after)}
+
+    irqs = {}
+    residual = []
+    for irq, before in sorted(irq_before.items(), key=lambda item: int(item[0])):
+        try:
+            after = read_irq_mask(f'{irq}/smp_affinity', nr_cpus)
+        except FileNotFoundError:
+            continue
+        if set(after) & set(cpus):
+            residual.append(int(irq))
+        if set(after) != set(before):
+            irqs[str(irq)] = {'before': tuna.collapse_cpulist(before),
+                              'after': tuna.collapse_cpulist(after)}
+
+    return {
+        'version': STATE_VERSION,
+        'boot_id': boot_id(),
+        'cpus': tuna.collapse_cpulist(cpus),
+        'tasks': tasks,
+        'irqs': irqs,
+        'default_smp_affinity': {
+            'before': tuna.collapse_cpulist(default_before),
+            'after': tuna.collapse_cpulist(read_irq_mask('default_smp_affinity', nr_cpus)),
+        },
+        'residual_irqs': residual,
+    }
+
+
+def save(path, state):
+    """ Write STATE to PATH atomically """
+    directory = os.path.dirname(os.path.abspath(path))
+    fd, tmp = tempfile.mkstemp(dir=directory, prefix='.tuna-state-')
+    try:
+        with os.fdopen(fd, 'w', encoding='utf-8') as f:
+            json.dump(state, f, indent=2, sort_keys=True)
+            f.write('\n')
+            f.flush()
+            os.fsync(f.fileno())
+        os.replace(tmp, path)
+    except BaseException:
+        if os.path.exists(tmp):
+            os.unlink(tmp)
+        raise
+
+
+def load(path):
+    """ Read and check a state file written by save() """
+    with open(path, encoding='utf-8') as f:
+        state = json.load(f)
+    if state.get('version') != STATE_VERSION:
+        raise ValueError(f"unsupported state version {state.get('version')!r} in {path}")
+    if state.get('boot_id') != boot_id():
+        raise ValueError(f"{path} was saved during a different boot")
+    return state
+
+
+def _restore_tasks(tasks, result, warn):
+    for tid_str, item in sorted(tasks.items(), key=lambda item: int(item[0])):
+        tid = int(tid_str)
+        starttime = task_starttime(tid)
+        if starttime is None:
+            result['tasks_exited'] += 1
+            continue
+        if starttime != item['starttime']:
+            warn(f"tid {tid} was reused by another task, skipping")
+            result['tasks_reused'] += 1
+            continue
+        try:
+            current = os.sched_getaffinity(tid)
+        except ProcessLookupError:
+            result['tasks_exited'] += 1
+            continue
+        if current != set(tuna.cpustring_to_list(item['after'])):
+            warn(f"tid {tid} affinity changed since isolate "
+                 f"(now {tuna.collapse_cpulist(current)}, isolate set {item['after']}), skipping")
+            result['tasks_drift'] += 1
+            continue
+        try:
+            os.sched_setaffinity(tid, tuna.cpustring_to_list(item['before']))
+        except ProcessLookupError:
+            result['tasks_exited'] += 1
+            continue
+        except OSError as err:
+            warn(f"tid {tid}: cannot restore affinity {item['before']}: {err.strerror}")
+            result['tasks_failed'] += 1
+            continue
+        result['tasks_restored'] += 1
+
+
+def _restore_irqs(irqs, nr_cpus, result, warn):
+    for irq, item in sorted(irqs.items(), key=lambda item: int(item[0])):
+        try:
+            current = read_irq_mask(f'{irq}/smp_affinity', nr_cpus)
+        except FileNotFoundError:
+            result['irqs_gone'] += 1
+            continue
+        if set(current) != set(tuna.cpustring_to_list(item['after'])):
+            warn(f"IRQ {irq} affinity changed since isolate "
+                 f"(now {tuna.collapse_cpulist(current)}, isolate set {item['after']}), skipping")
+            result['irqs_drift'] += 1
+            continue
+        if write_irq_mask(f'{irq}/smp_affinity',
+                          tuna.cpustring_to_list(item['before']), nr_cpus):
+            result['irqs_restored'] += 1
+        else:
+            warn(f"IRQ {irq}: cannot restore affinity {item['before']}")
+            result['irqs_failed'] += 1
+
+
+def _restore_default(default, nr_cpus, warn):
+    current = read_irq_mask('default_smp_affinity', nr_cpus)
+    if set(current) == set(tuna.cpustring_to_list(default['before'])):
+        return 'unchanged'
+    if set(current) != set(tuna.cpustring_to_list(default['after'])):
+        warn("default_smp_affinity changed since isolate "
+             f"(now {tuna.collapse_cpulist(current)}, isolate set {default['after']}), skipping")
+        return 'drift'
+    if write_irq_mask('default_smp_affinity',
+                      tuna.cpustring_to_list(default['before']), nr_cpus):
+        return 'restored'
+    warn(f"default_smp_affinity: cannot restore {default['before']}")
+    return 'failed'
+
+
+def restore(state, nr_cpus, warn):
+    """
+    Restore the affinities recorded in STATE.
+
+    An item is restored only if it still holds the value isolation gave it;
+    a thread must also have the same start time, so a reused tid is left
+    alone. Failures do not stop the restore.
+
+    Returns a dictionary of counters; 'tasks_failed', 'irqs_failed' and
+    default_smp_affinity == 'failed' are the failures.
+    """
+    result = dict.fromkeys(('tasks_restored', 'tasks_exited', 'tasks_reused',
+                            'tasks_drift', 'tasks_failed', 'irqs_restored',
+                            'irqs_gone', 'irqs_drift', 'irqs_failed'), 0)
+    _restore_irqs(state['irqs'], nr_cpus, result, warn)
+    result['default_smp_affinity'] = _restore_default(state['default_smp_affinity'],
+                                                      nr_cpus, warn)
+    _restore_tasks(state['tasks'], result, warn)
+    return result
+
+
+def failed(result):
+    """ Return True if RESULT from restore() contains a failure """
+    return (result['tasks_failed'] > 0 or result['irqs_failed'] > 0
+            or result['default_smp_affinity'] == 'failed')
-- 
2.52.0

