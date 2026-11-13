Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613590;
	b=gu7aKPW9v9u9FspZJV4Lm8lmB/626phqz+/oX9IDHMzGUWjFjBkOPzrv5JkWAfcnW37x
	 KHAo1THPxJLJOKbgHhSMqJ2RzJrB4RWB/9EmXxEbYRw8td0m40KM/el5g5fkFxw+/AhId
	 RLlrxcDbmwejT5iGQkhq1Mvyux505clv9tw66a8yOoZkIdOUo8P7/svnP+YRg3o53Ryk6
	 Oi3tPcOUqSuGa9goqZW51NcMI+4l519gTOtPdMW2m89/Uxz9OcB4k9RyXfHPUSAnCMO1W
	 8A/lWi9/9sPqRl1pRArrgyKwBL7yeznYjKuJGUpJQbeKTVNG9emYbYutSfJQLfJJ7yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613590;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=Ns8rNFFaE9GD7F1mN3+M+ynDzvBlb52fgE+rQ1XFj08=;
	b=S/PM5h1alWEI0F7mCLuKc9t3A4oxC4E2FsB8BiovBO7QuFq+1dEvWm6YgWTM4u/5pJYo
	 wkGveH7Cy24PXdRbQ+JKZOUlpa1bSvKsmGFiObilbBSnU4NJZ/ItDnzMVQskrLe209OZ2
	 5ri0nTbawbbxC/cDkCiRsXzN1MT538jcsx3DpxVhrdC/EE7uq9a1krHd/7Nxff7V4Eb7W
	 jKpDRAaUfSWK19Kv/MHmLJCNqJ5U0pb0KBBVdZtA9CblelvDt+EenIaWU1qMalureI5pe
	 eIp18idRhZCVpwSakSfwna5RLfCopaZ+QspEGAzpYjYMyyI5fAEI69oxKbr1vFdm9DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IVLMGUCi;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3ED606A33E
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Nov 2026 23:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB3ED606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IVLMGUCi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794613589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ns8rNFFaE9GD7F1mN3+M+ynDzvBlb52fgE+rQ1XFj08=;
	b=IVLMGUCiUAKQHufiMfwqIijj3gOfN7KsMwkTa0KfpdP/rdNuFbCOhqmFAbSSYbQpv+LELi
	cnA/SXDLTy3d2/etctp/9XFjLfauMxkp676au45AAQoSp7cN/lz69ge8Wj4aSnwNfVa2cu
	H8NBAH090IJyeFe13xJOA4kdcoPofyM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-1nsUmBSeM0GuPPSQJHXWZA-1; Fri,
 13 Nov 2026 18:46:27 -0500
X-MC-Unique: 1nsUmBSeM0GuPPSQJHXWZA-1
X-Mimecast-MFC-AGG-ID: 1nsUmBSeM0GuPPSQJHXWZA_1794613586
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96961195605A
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Nov 2026 23:46:26 +0000 (UTC)
Received: from dev-workstation (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A3ED430001B9;
	Fri, 13 Nov 2026 23:46:25 +0000 (UTC)
From: Chris White <chwhite@redhat.com>
To: jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 3/5] tuna: Handle thread EBUSY/EPERM and aggregate unmovable IRQ warnings
Date: Fri, 13 Nov 2026 15:46:18 -0800
Message-ID: <20261113234620.1608227-4-chwhite@redhat.com>
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

In isolate_cpus(), the process loop catches EBUSY and EPERM when
modifying affinity, printing a warning and continuing with the remaining
tasks. However, the inner thread loop did not handle EBUSY or EPERM,
causing any thread that rejects an affinity update (e.g. pinned or
permission-restricted thread) to terminate isolation mid-run.

Additionally, IRQ affinity updates that fail (such as kernel managed
IRQs on multi-queue NICs or NVMe controllers) previously failed silently
or raised on write error before close.

Add EBUSY and EPERM handling to the thread loop to match the process
loop. Collect IRQs whose affinity could not be changed and report them
in a single aggregated warning on stderr without aborting isolation.

Keeping the report to a single line also makes it usable by callers
that need to know which IRQs stayed put: SameStack's runtime isolation
lease parses this warning to journal the residual IRQs for each run,
instead of having to re-read every /proc/irq entry afterwards.

While here, take the pre-isolation IRQ masks from /proc/irq/<n>/
smp_affinity instead of procfs's parsed copy. procfs parses
/proc/interrupts with one column per online CPU, so a mask that also
references offline CPUs is silently truncated; callers that save and
restore affinities read the file at the runtime CPU count, and the two
widths have to agree or a mask that never moved looks modified. On a
host with offline CPUs this made every unmovable managed IRQ look like
a failed restore. An IRQ that disappears between interrupts() and this
read keeps the procfs value rather than aborting.

This was tested and verified by running tuna isolation scenarios with
SameStack: the B-tuna campaign on realtime-04 and a 40-round soak on
centos-dev hit both paths on real hardware (pinned threads, and
per-queue NIC IRQs that cannot be moved), and isolation completed with
the IRQs reported rather than aborting.

Assisted-by: Apogee
Signed-off-by: Chris White <chwhite@redhat.com>
---
 tests/test_isolate_errors.py | 174 +++++++++++++++++++++++++++++++++++
 tuna/tuna.py                 |  35 ++++++-
 2 files changed, 207 insertions(+), 2 deletions(-)
 create mode 100644 tests/test_isolate_errors.py

diff --git a/tests/test_isolate_errors.py b/tests/test_isolate_errors.py
new file mode 100644
index 0000000..4bc7e6f
--- /dev/null
+++ b/tests/test_isolate_errors.py
@@ -0,0 +1,174 @@
+#!/usr/bin/python3
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-only
+"""
+isolate_cpus() must keep going when single threads or IRQs cannot be moved.
+
+procfs, the affinity syscalls and the /proc/irq writes are mocked, so these
+tests do not need root and do not change the system.
+"""
+
+import builtins
+import errno
+import io
+import sys
+import unittest
+from contextlib import redirect_stderr, redirect_stdout
+from pathlib import Path
+from unittest import mock
+
+if Path(__file__).parent.name == 'tests':
+    sys.path.insert(0, str(Path(__file__).parent.parent))
+
+from tuna import tuna
+
+NR_CPUS = 4
+ALL = {0, 1, 2, 3}
+
+
+class Task(dict):
+    def __init__(self, comm, threads=None):
+        super().__init__()
+        self.stat = {'comm': comm}
+        if threads is not None:
+            self['threads'] = threads
+
+
+def fake_procfs(ps, irqs):
+    procfs = mock.MagicMock()
+    procfs.pidstats.return_value = ps
+    procfs.cannot_set_affinity.return_value = False
+    procfs.cannot_set_thread_affinity.return_value = False
+    procfs.interrupts.return_value = irqs
+    procfs.hexbitmask.side_effect = lambda cpus, nr: sorted(cpus)
+    return procfs
+
+
+class TestIsolateCpusErrors(unittest.TestCase):
+
+    def run_isolate(self, ps, irqs, setaffinity, set_irq, read_irq=None):
+        if read_irq is None:
+            def read_irq(filename, nr_cpus):
+                if filename == 'default_smp_affinity':
+                    return list(ALL)
+                return irqs[filename.split('/')[0]]['affinity']
+        stdout, stderr = io.StringIO(), io.StringIO()
+        with mock.patch.object(tuna, 'procfs', fake_procfs(ps, irqs)), \
+             mock.patch.object(tuna.os, 'sched_getaffinity', return_value=set(ALL)), \
+             mock.patch.object(tuna.os, 'sched_setaffinity', side_effect=setaffinity), \
+             mock.patch.object(tuna, 'set_irq_affinity', side_effect=set_irq), \
+             mock.patch.object(tuna, 'parse_irq_affinity_filename', side_effect=read_irq), \
+             mock.patch.object(tuna, 'set_irq_affinity_filename', return_value=True), \
+             redirect_stdout(stdout), redirect_stderr(stderr):
+            result = tuna.isolate_cpus([3], NR_CPUS)
+        return result, stdout.getvalue(), stderr.getvalue()
+
+    def test_thread_eperm_and_ebusy_continue(self):
+        """A thread that refuses the new affinity does not stop isolation"""
+        ps = mock.MagicMock()
+        tasks = {100: Task('app', {101: Task('locked'), 102: Task('busy'), 103: Task('worker')})}
+        ps.keys.return_value = list(tasks)
+        ps.__getitem__.side_effect = tasks.__getitem__
+        moved = {}
+
+        def setaffinity(tid, cpus):
+            if tid == 101:
+                raise OSError(errno.EPERM, 'Operation not permitted')
+            if tid == 102:
+                raise OSError(errno.EBUSY, 'Device or resource busy')
+            moved[tid] = set(cpus)
+
+        _, stdout, _ = self.run_isolate(ps, {}, setaffinity, lambda irq, mask: True)
+        self.assertEqual(moved, {100: {0, 1, 2}, 103: {0, 1, 2}})
+        self.assertIn('Unable to isolate tid 101 [locked]', stdout)
+        self.assertIn('Unable to isolate tid 102 [busy]', stdout)
+
+    def test_unmovable_irqs_reported_once(self):
+        """IRQs whose affinity cannot be changed are listed in one warning"""
+        ps = mock.MagicMock()
+        ps.keys.return_value = []
+        irqs = {'30': {'affinity': [0, 1, 2, 3]},
+                '31': {'affinity': [3]},
+                '32': {'affinity': [0, 1, 2, 3]},
+                '33': {'affinity': [0]},
+                'LOC': {}}
+        written = {}
+
+        def set_irq(irq, mask):
+            if irq == 30:
+                return False   # e.g. managed IRQ, error reported on close()
+            if irq == 31:
+                raise OSError(errno.EIO, 'Input/output error')
+            written[irq] = mask
+            return True
+
+        (_, previous_irqs), _, stderr = self.run_isolate(ps, irqs, lambda t, c: None, set_irq)
+        self.assertEqual(written, {32: [0, 1, 2]})
+        self.assertEqual(sorted(previous_irqs), ['30', '31', '32'])
+        warnings = [line for line in stderr.splitlines() if 'Unable to move IRQs' in line]
+        self.assertEqual(len(warnings), 1)
+        self.assertTrue(warnings[0].endswith(': 30,31'), warnings[0])
+
+    def test_irq_masks_are_read_at_runtime_width(self):
+        """The mask must come from the file, not the truncated procfs value
+
+        procfs parses /proc/interrupts with one column per online CPU, so a
+        mask referencing offline CPUs loses those bits. Callers that save and
+        restore the mask use the runtime CPU count, so the 'before' value has
+        to be read at that width too.
+        """
+        ps = mock.MagicMock()
+        ps.keys.return_value = []
+        # procfs only saw CPUs 0-3 and reports the truncated mask [0]
+        irqs = {'40': {'affinity': [0]}}
+        seen = []
+
+        def read_irq(filename, nr_cpus):
+            if filename == 'default_smp_affinity':
+                return list(ALL)
+            seen.append((filename, nr_cpus))
+            return [3, 8]          # the real mask: CPU 3 plus offline CPU 8
+
+        def set_irq(irq, mask):
+            return True
+
+        (_, previous_irqs), _, _ = self.run_isolate(
+            ps, irqs, lambda t, c: None, set_irq, read_irq)
+        self.assertIn(('40/smp_affinity', NR_CPUS), seen)
+        self.assertEqual(previous_irqs['40'], [3, 8])
+
+    def test_vanished_irq_falls_back_to_procfs(self):
+        """An IRQ that disappeared since interrupts() was read is skipped"""
+        ps = mock.MagicMock()
+        ps.keys.return_value = []
+        irqs = {'41': {'affinity': [0, 3]}}
+
+        def read_irq(filename, nr_cpus):
+            if filename == 'default_smp_affinity':
+                return list(ALL)
+            raise OSError(errno.ENOENT, 'No such file or directory')
+
+        def set_irq(irq, mask):
+            return True
+
+        (_, previous_irqs), _, stderr = self.run_isolate(
+            ps, irqs, lambda t, c: None, set_irq, read_irq)
+        self.assertEqual(previous_irqs['41'], [0, 3])
+        self.assertEqual(stderr, '')
+
+    def test_parse_irq_affinity_filename_raises_on_missing_irq(self):
+        """A vanished IRQ must not leave the caller reading an unbound file"""
+        real_open = builtins.open
+
+        def fake_open(path, *args, **kwargs):
+            if 'smp_affinity' in str(path):
+                raise FileNotFoundError(errno.ENOENT, 'No such file')
+            return real_open(path, *args, **kwargs)
+
+        with mock.patch('builtins.open', side_effect=fake_open):
+            with self.assertRaises(OSError):
+                tuna.parse_irq_affinity_filename('9999/smp_affinity', NR_CPUS)
+
+
+if __name__ == '__main__':
+    unittest.main()
diff --git a/tuna/tuna.py b/tuna/tuna.py
index fd08b5e..293cca5 100755
--- a/tuna/tuna.py
+++ b/tuna/tuna.py
@@ -386,6 +386,7 @@ def parse_irq_affinity_filename(filename, nr_cpus):
             print("This operation is not supported on s390", file=sys.stderr)
             print(f"tuna: {err}", file=sys.stderr)
             sys.exit(2)
+        raise
 
     line = f.readline()
     f.close()
@@ -456,6 +457,14 @@ def isolate_cpus(cpus, nr_cpus):
                     if err.args[0] == errno.EINVAL:
                         print("Function:", fname, ",", err.strerror, file=sys.stderr)
                         sys.exit(2)
+                    if err.args[0] == errno.EBUSY:
+                        comm = threads[tid].stat["comm"]
+                        print(f'Warning: Unable to isolate tid {tid} [{comm}]')
+                        continue
+                    if err.args[0] == errno.EPERM:
+                        comm = threads[tid].stat["comm"]
+                        print(f'Warning: Unable to isolate tid {tid} [{comm}]')
+                        continue
                     raise err
 
     del ps
@@ -463,15 +472,37 @@ def isolate_cpus(cpus, nr_cpus):
     # Now isolate it from IRQs too
     irqs = procfs.interrupts()
     previous_irq_affinities = {}
+    unmoved_irqs = []
     for irq in list(irqs.keys()):
         # LOC, NMI, TLB, etc
         if "affinity" not in irqs[irq]:
             continue
-        affinity = irqs[irq]["affinity"]
+        # procfs parses /proc/interrupts with one column per online CPU, so a
+        # mask that also references offline CPUs (common when some are
+        # offlined) is truncated there. Read the file at nr_cpus so the
+        # 'before' masks recorded below match the width used by callers that
+        # save and restore them. An IRQ that disappeared since interrupts()
+        # was read keeps the procfs value instead of aborting isolation.
+        try:
+            affinity = parse_irq_affinity_filename(f"{irq}/smp_affinity", nr_cpus)
+        except OSError:
+            affinity = irqs[irq]["affinity"]
         if set(affinity).intersection(set(cpus)):
             previous_irq_affinities[irq] = copy.copy(affinity)
             affinity = affinity_remove_cpus(affinity, cpus, nr_cpus)
-            set_irq_affinity(int(irq), procfs.hexbitmask(affinity, nr_cpus))
+            try:
+                moved = set_irq_affinity(int(irq), procfs.hexbitmask(affinity, nr_cpus))
+            except OSError:
+                moved = False
+            if not moved:
+                # Managed IRQs (e.g. per-queue NIC/NVMe vectors) reject writes
+                unmoved_irqs.append(int(irq))
+
+    if unmoved_irqs:
+        print("Warning: Unable to move IRQs away from CPUs "
+              f"{collapse_cpulist(cpus)}: "
+              f"{','.join(str(i) for i in sorted(unmoved_irqs))}",
+              file=sys.stderr)
 
     affinity = parse_irq_affinity_filename("default_smp_affinity", nr_cpus)
     affinity = affinity_remove_cpus(affinity, cpus, nr_cpus)
-- 
2.52.0

