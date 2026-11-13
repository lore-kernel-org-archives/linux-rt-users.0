Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613588;
	b=UaQmCw/13rlitWNAckB5PSzSle6XhSa5bqXrFkHZAg1/gTz14BWFKN+L7ZCRNgXXiDgM
	 nhJdnSo4Of83Cli6uZKa0SZIdVNrf+acmXQeq1nZuQXdnmGmlaLfbme/2Oh+xPJ+EI70x
	 Vd+f69QGN1pKK+KDbvpOi075X7PzohMF2Bx/CyWXMLZzXFesz+bo1BRBpdwrvhZFpKWeo
	 TRTEQHNxl3FobD8EUZOuvi4Vio+2SDavEpn59KmDSvfYGief/m/UULLEo/PJOlaDgq83+
	 I5q2fyW5XNLUPgvA29f4uoUNDcnpEhxSgdTYYw4cqKSSH+SgBdef9BOmxeg0zPAKfvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613588;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=PGCPqTKk4oT5O4jHXoVhzHnsNEovoqr0RMyfm0gDnSw=;
	b=pCjXfiIjtSTpvs51nPGjN6Yrz39LcmaZoFSwuwWL4zHGPVXdKDPpIV1V6SPg86ABbKeZ
	 yQlSA0RwbFi25L2kb+WkJZ9prw0gL0qD/FtiFCql10dSLQl4cqY3UWW/e3kyRaOmLIdcz
	 j9KX3m2K4Ckb5H9zd5nYOymx93tVCIBSqMtQvyT8a4WvquxFT99+3k6enxfsx+qkvpoRp
	 wTfup4VWlEHxO+Avl5Zry+/rTX+RnBpehYRAPAYTnLKaP2QTrAMmoKadG63pC7Mmzls9U
	 1ApcLGBri9CvZuXAD/jrziXUyZzs55PWov/y7NcTBM2GT4JlKmbZsFRSX8qDI9KF0Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pl8obG2D;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41464606A883
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Nov 2026 23:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41464606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pl8obG2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794613586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGCPqTKk4oT5O4jHXoVhzHnsNEovoqr0RMyfm0gDnSw=;
	b=Pl8obG2DgIEajTLxKcoRyyWzMmAP3Bd/ivT4Ytr8HR7hhHVOZeGkogeUgYmtw5xQuDlR33
	dpDDI6QID/7SqNiKF2cqEnSoGzvr9jAusdHUzelkhw7nuTammy9Z0QN5kW8VtMNNwpWR9x
	oH3ttTBDH2SMz//WLVsci6VBBgYPPrs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-4WJDrJIiNMu3s8gLeewrqA-1; Fri,
 13 Nov 2026 18:46:24 -0500
X-MC-Unique: 4WJDrJIiNMu3s8gLeewrqA-1
X-Mimecast-MFC-AGG-ID: 4WJDrJIiNMu3s8gLeewrqA_1794613584
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1742B18004FE
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Nov 2026 23:46:24 +0000 (UTC)
Received: from dev-workstation (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2908E30001B9;
	Fri, 13 Nov 2026 23:46:22 +0000 (UTC)
From: Chris White <chwhite@redhat.com>
To: jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 1/5] tuna: Check cpuset partition state on isolation and propagate errors
Date: Fri, 13 Nov 2026 15:46:16 -0800
Message-ID: <20261113234620.1608227-2-chwhite@redhat.com>
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

When setting a cpuset partition to 'isolated', the kernel accepts the
write to cpuset.cpus.partition even if the partition cannot be activated
(e.g. if a sibling cpuset has overlapping CPUs), but changes the
contents to 'isolated invalid (...)'.

Currently write_cpu_exclusive() silently ignores missing files or write
errors and does not inspect the readback, giving callers the false
impression that partition isolation succeeded.

Check cpuset.cpus.partition after writing 'isolated', and raise OSError
if the file is missing or if the readback does not match 'isolated'
(retaining the full kernel error string in the exception message).
Setting 'member' remains best-effort.

This was tested and verified by running tuna isolation scenarios with
SameStack: its runtime isolation lease deploys this series and reads
the partition back after 'tuna isolate', so every rep of the B-tuna
campaign on realtime-04 exercised this path, as did a 40-round
isolate/destroy/restore soak on centos-dev.

The invalid-partition case is covered by a root-only test that builds
an overlapping sibling cpuset and requires the isolation to raise.

Assisted-by: Apogee
Signed-off-by: Chris White <chwhite@redhat.com>
---
 tests/test_cpuset_errors.py | 130 ++++++++++++++++++++++++++++++++++++
 tuna/cpuset.py              |  36 +++++++---
 2 files changed, 156 insertions(+), 10 deletions(-)
 create mode 100644 tests/test_cpuset_errors.py

diff --git a/tests/test_cpuset_errors.py b/tests/test_cpuset_errors.py
new file mode 100644
index 0000000..78a51a5
--- /dev/null
+++ b/tests/test_cpuset_errors.py
@@ -0,0 +1,130 @@
+#!/usr/bin/python3
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-only
+"""
+Error reporting tests for tuna.cpuset that do not need root.
+
+The cgroup files are emulated with regular files in a temporary directory,
+so these run anywhere.
+"""
+
+import builtins
+import errno
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
+from tuna import cpuset
+
+
+def fake_cpuset(path):
+    cs = cpuset.Cpuset.__new__(cpuset.Cpuset)
+    cs.cpuset_name = os.path.basename(path)
+    cs._cpuset_path = path
+    cs.auto_destroy = False
+    return cs
+
+
+class TestWriteCpuExclusive(unittest.TestCase):
+    """write_cpu_exclusive() must not report success for a failed partition"""
+
+    def setUp(self):
+        self.tmp = tempfile.TemporaryDirectory()
+        self.path = self.tmp.name
+        self.partition = os.path.join(self.path, 'cpuset.cpus.partition')
+
+    def tearDown(self):
+        self.tmp.cleanup()
+
+    def kernel_reports(self, state):
+        """Make reads of cpuset.cpus.partition return STATE, as the kernel would"""
+        real_open = builtins.open
+
+        def fake_open(file, mode='r', *args, **kwargs):
+            if file == self.partition and 'r' in mode:
+                return mock.mock_open(read_data=state + '\n')()
+            return real_open(file, mode, *args, **kwargs)
+        return mock.patch('builtins.open', side_effect=fake_open)
+
+    def test_isolated_ok(self):
+        Path(self.partition).write_text('member\n')
+        fake_cpuset(self.path).write_cpu_exclusive(True)
+        self.assertEqual(Path(self.partition).read_text(), 'isolated')
+
+    def test_isolated_missing_file_raises(self):
+        with self.assertRaises(OSError) as ctx:
+            fake_cpuset(self.path).write_cpu_exclusive(True)
+        self.assertEqual(ctx.exception.errno, errno.ENOTSUP)
+
+    def test_isolated_invalid_raises_with_reason(self):
+        Path(self.partition).write_text('member\n')
+        reason = 'isolated invalid (Cpu list in cpuset.cpus not exclusive)'
+        with self.kernel_reports(reason):
+            with self.assertRaises(OSError) as ctx:
+                fake_cpuset(self.path).write_cpu_exclusive(True)
+        self.assertIn(reason, str(ctx.exception))
+
+    def test_isolated_member_readback_raises(self):
+        Path(self.partition).write_text('member\n')
+        with self.kernel_reports('member'):
+            with self.assertRaises(OSError):
+                fake_cpuset(self.path).set_cpu_exclusive()
+
+    def test_isolated_write_error_propagates(self):
+        os.mkdir(self.partition)  # open(..., 'w') fails with EISDIR
+        with self.assertRaises(OSError) as ctx:
+            fake_cpuset(self.path).write_cpu_exclusive(True)
+        self.assertEqual(ctx.exception.errno, errno.EISDIR)
+
+    def test_member_missing_file_tolerated(self):
+        fake_cpuset(self.path).write_cpu_exclusive(False)
+        self.assertFalse(os.path.exists(self.partition))
+
+    def test_member_write_error_tolerated(self):
+        os.mkdir(self.partition)
+        fake_cpuset(self.path).unset_cpu_exclusive()
+
+
+@unittest.skipUnless(sys.platform.startswith('linux') and os.geteuid() == 0,
+                     "Requires root permissions")
+@unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
+class TestInvalidPartition(unittest.TestCase):
+    """The kernel accepts the write but reports 'isolated invalid (...)'"""
+
+    def setUp(self):
+        self.created = []
+
+    def tearDown(self):
+        for cs in reversed(self.created):
+            try:
+                cs.unset_cpu_exclusive()
+                cs.destroy()
+            except OSError:
+                pass
+
+    def make(self, name, cpu):
+        cs = cpuset.Cpuset(name)
+        self.created.append(cs)
+        cs.write_memnode(cpuset.get_numa_nodes_for_cpus([cpu]))
+        cs.assign_cpus(str(cpu))
+        return cs
+
+    def test_overlapping_sibling_raises(self):
+        """A sibling whose cpuset.cpus overlap makes the partition invalid"""
+        cpu = max(os.sched_getaffinity(0))
+        self.make('test_overlap_sibling', cpu)
+        iso = self.make('test_overlap_iso', cpu)
+        with self.assertRaises(OSError) as ctx:
+            iso.set_cpu_exclusive()
+        self.assertIn('invalid', str(ctx.exception))
+        self.assertTrue(iso.get_partition_type().startswith('isolated invalid'))
+
+
+if __name__ == '__main__':
+    unittest.main()
diff --git a/tuna/cpuset.py b/tuna/cpuset.py
index 3f9b053..833c292 100644
--- a/tuna/cpuset.py
+++ b/tuna/cpuset.py
@@ -188,11 +188,14 @@ class Cpuset:
 
         Args:
             cpu_exclusive: True/1/'1' for 'isolated', False/0/'0' for 'member'
+
+        Raises:
+            OSError: when isolating and the kernel has no partition support,
+                     rejects the write, or reports the partition as invalid
+                     (e.g. "isolated invalid (Cpu list in cpuset.cpus not
+                     exclusive)"). Setting 'member' stays best-effort.
         """
         path = os.path.join(self._cpuset_path, "cpuset.cpus.partition")
-        if not os.path.exists(path):
-            # cpuset.cpus.partition may not exist in all kernels
-            return
 
         # Convert to boolean: handles bool, int, or string input
         if isinstance(cpu_exclusive, str):
@@ -200,13 +203,26 @@ class Cpuset:
         else:
             is_exclusive = bool(cpu_exclusive)
 
-        partition_type = 'isolated' if is_exclusive else 'member'
-        try:
-            with open(path, 'w', encoding='utf-8') as f:
-                f.write(partition_type)
-        except OSError:
-            # Partition may not be supported or may fail
-            pass
+        if not is_exclusive:
+            if not os.path.exists(path):
+                return
+            try:
+                with open(path, 'w', encoding='utf-8') as f:
+                    f.write('member')
+            except OSError:
+                pass
+            return
+
+        if not os.path.exists(path):
+            raise OSError(errno.ENOTSUP,
+                          "kernel does not support cpuset partitions", path)
+        with open(path, 'w', encoding='utf-8') as f:
+            f.write('isolated')
+        with open(path, 'r', encoding='utf-8') as f:
+            state = f.read().strip()
+        if state != 'isolated':
+            raise OSError(errno.EINVAL,
+                          f"cpuset partition not isolated: {state}", path)
 
     def set_cpu_exclusive(self):
         """ Turn cpu_exclusive on (set partition to isolated) """
-- 
2.52.0

