Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613594;
	b=26YtG/vsXNkX90R/smNCmeO/651qXDL4MfPL4yjiw02opPiIgDjRFnxdrW5hE/oWFtPD
	 P8s42sNGm7cd3ZwGaKYFVPX5nO7khSfvSpqFVfVjU2R1KqNkqvEdMqr7lq8cSNHapZZO+
	 UMomus2jfXkAcxWcs9AtV6H17+wwG4g95ZDHi84OU3B+8nqUkw35c1bjOl6O4DtovSzbt
	 NKF2zyDZ1bQ4FBxKk0g7AM5WIpyUaCiQXiOc7+XwK7kzis5S3qZg2COwN4XrZdPYlVQo1
	 Rw4OqqB3OGQv2fqLCkhGr/eOPZYXabqc9D6fbNQtuEwLH7exCo26wr28QI5n3nbPDSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613594;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=AMOFwkHvyPX4lDRFu4DxB++uB46cPPm4kV8iRbIsW4U=;
	b=fi/S98RQspq81LbjqBI+a1gqd4CNehGV7X6173cMM5yiqcZ7uGwt7xIv1y6yV6Mti67M
	 hCadkbz9i8W9iTKNoT0mDxCQ/Qh8+FHAFwll0xazR1DndFOLcTgqNPknEp91TDo5NRu+i
	 9UE0YDcJ2/ycwYS7UlGUNzfZWphZgppjfm8NRwQZ57lsJpYgS/1PGEaXpEFvjdQ2X0IA0
	 Yl4GPy4fGfYPBMtsnuFIY+9DjCfpy1+55HNeII9xBajGX45cV/WD+kbPJswmAssdCmAs7
	 zMdT34c3OGt9OQWq7zSuUIdJ3NpMkL5otq7JJ9lHTXp6CZW0fZAWTdkbU2by5F/XhAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YQ+73n5h;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E383606A333
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Nov 2026 23:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E383606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YQ+73n5h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794613592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMOFwkHvyPX4lDRFu4DxB++uB46cPPm4kV8iRbIsW4U=;
	b=YQ+73n5hk0lQqnrG30wH/2k4V3b4pV7raskWPRU8DyIc0sPNkGZjOYvxkHMSy8KOrbDyKl
	OUYWXouTK+b3ruJJ82jL/6BaSYxBX4+EiGKj13wgdKutVeRf/Wb1RrNxfV8cBXZ4rH+E4G
	De3KfOLy3ODgn/N+uCXmmUP7L1r5LCU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-aJMvwSA1NJaXqnFeMaJ9mQ-1; Fri,
 13 Nov 2026 18:46:30 -0500
X-MC-Unique: aJMvwSA1NJaXqnFeMaJ9mQ-1
X-Mimecast-MFC-AGG-ID: aJMvwSA1NJaXqnFeMaJ9mQ_1794613589
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C2631956064
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Nov 2026 23:46:29 +0000 (UTC)
Received: from dev-workstation (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E6A930001B9;
	Fri, 13 Nov 2026 23:46:28 +0000 (UTC)
From: Chris White <chwhite@redhat.com>
To: jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 5/5] tuna: Demote partition and retry rmdir on EBUSY in destroy_cpuset
Date: Fri, 13 Nov 2026 15:46:20 -0800
Message-ID: <20261113234620.1608227-6-chwhite@redhat.com>
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

When destroying an isolated cpuset partition, demote it to 'member'
first so that the isolated CPUs are immediately released back to the
root cgroup. Furthermore, retry os.rmdir() on EBUSY with a 1-second
bounded backoff to allow terminating or migrating tasks to finish
draining out of the cgroup.

Put this in one helper used by both teardown paths: destroy_cpuset()
and Cpuset.destroy(), the latter being what the auto_destroy context
manager calls. Fixing only the CLI path would have left anything using
the context manager with the old immediate-rmdir behaviour.

The EBUSY case is reproducible: SameStack's runtime isolation lease
destroyed the partition right after its workload processes exited and
hit EBUSY often enough that it carried its own 20 x 50 ms retry around
'tuna cpuset destroy' to stop a rep from failing. This moves the retry
into tuna, where the drain actually happens.

This was tested and verified by running tuna isolation scenarios with
SameStack: the B-tuna campaign on realtime-04 and a 40-round soak on
centos-dev tear the partition down through this path after every rep,
and the demote-first order was confirmed to release the isolated CPUs
before the rmdir.

Tests cover both entry points: the demote-before-rmdir ordering, a
successful retry after EBUSY, propagation of other errno values without
a retry, the bounded give-up when EBUSY never clears, and that leaving
an auto_destroy block demotes the partition. They use a temporary
directory, so they do not need root.

Assisted-by: Apogee
Signed-off-by: Chris White <chwhite@redhat.com>
---
 tests/test_cpuset_errors.py | 192 ++++++++++++++++++++++++++++++++++++
 tuna/cpuset.py              |  55 ++++++++++-
 2 files changed, 242 insertions(+), 5 deletions(-)

diff --git a/tests/test_cpuset_errors.py b/tests/test_cpuset_errors.py
index 8636bdc..5abe33a 100644
--- a/tests/test_cpuset_errors.py
+++ b/tests/test_cpuset_errors.py
@@ -180,6 +180,198 @@ class TestCreateCpusetCleanup(unittest.TestCase):
         self.assertIn('cannot enable cpuset', str(ctx.exception))
 
 
+class TestDestroyCpuset(unittest.TestCase):
+    """destroy_cpuset() must demote the partition and drain lingering tasks"""
+
+    def setUp(self):
+        self.tmp = tempfile.TemporaryDirectory()
+        self.path = os.path.join(self.tmp.name, 'cpuset')
+        os.mkdir(self.path)
+        self.partition = os.path.join(self.path, 'cpuset.cpus.partition')
+
+    def tearDown(self):
+        self.tmp.cleanup()
+
+    def test_demotes_partition_before_rmdir(self):
+        Path(self.partition).write_text('isolated\n')
+        seen = {}
+        real_rmdir = os.rmdir
+
+        def fake_rmdir(path):
+            # The kernel drops the cgroup files along with the directory
+            seen['partition'] = Path(self.partition).read_text()
+            os.unlink(self.partition)
+            real_rmdir(path)
+
+        with mock.patch('tuna.cpuset.os.rmdir', side_effect=fake_rmdir):
+            cpuset.destroy_cpuset(self.path)
+        self.assertEqual(seen['partition'], 'member\n')
+        self.assertFalse(os.path.exists(self.path))
+
+    def test_without_partition_file(self):
+        real_rmdir = os.rmdir
+
+        def fake_rmdir(path):
+            real_rmdir(path)
+
+        with mock.patch('tuna.cpuset.os.rmdir', side_effect=fake_rmdir):
+            cpuset.destroy_cpuset(self.path)
+        self.assertFalse(os.path.exists(self.path))
+
+    def test_failed_demote_does_not_block_rmdir(self):
+        Path(self.partition).write_text('isolated\n')
+        real_open = builtins.open
+        real_rmdir = os.rmdir
+
+        def fake_open(file, mode='r', *args, **kwargs):
+            if file == self.partition and 'w' in mode:
+                raise OSError(errno.EROFS, 'Read-only file system', file)
+            return real_open(file, mode, *args, **kwargs)
+
+        def fake_rmdir(path):
+            os.unlink(self.partition)
+            real_rmdir(path)
+
+        with mock.patch('builtins.open', side_effect=fake_open), \
+             mock.patch('tuna.cpuset.os.rmdir', side_effect=fake_rmdir):
+            cpuset.destroy_cpuset(self.path)
+        self.assertFalse(os.path.exists(self.path))
+
+    def test_retries_rmdir_on_ebusy(self):
+        Path(self.partition).write_text('member\n')
+        calls = []
+        real_rmdir = os.rmdir
+
+        def fake_rmdir(path):
+            calls.append(path)
+            if len(calls) < 3:
+                raise OSError(errno.EBUSY, 'Device or resource busy', path)
+            os.unlink(self.partition)
+            real_rmdir(path)
+
+        with mock.patch('tuna.cpuset.os.rmdir', side_effect=fake_rmdir), \
+             mock.patch('tuna.cpuset.time.sleep') as sleep:
+            cpuset.destroy_cpuset(self.path)
+        self.assertEqual(len(calls), 3)
+        self.assertEqual(sleep.call_count, 2)
+        self.assertFalse(os.path.exists(self.path))
+
+    def test_other_errors_propagate_without_retry(self):
+        Path(self.partition).write_text('member\n')
+        with mock.patch('tuna.cpuset.os.rmdir',
+                        side_effect=OSError(errno.EACCES,
+                                            'Permission denied')) as rmdir:
+            with self.assertRaises(OSError) as ctx:
+                cpuset.destroy_cpuset(self.path)
+        self.assertEqual(ctx.exception.errno, errno.EACCES)
+        self.assertEqual(rmdir.call_count, 1)
+
+    def test_gives_up_after_bounded_backoff(self):
+        Path(self.partition).write_text('member\n')
+        clock = [0.0]
+
+        def fake_time():
+            clock[0] += 0.1
+            return clock[0]
+
+        with mock.patch('tuna.cpuset.os.rmdir',
+                        side_effect=OSError(errno.EBUSY,
+                                            'Device or resource busy')) as rmdir, \
+             mock.patch('tuna.cpuset.time.time', side_effect=fake_time), \
+             mock.patch('tuna.cpuset.time.sleep') as sleep:
+            with self.assertRaises(OSError) as ctx:
+                cpuset.destroy_cpuset(self.path)
+        self.assertEqual(ctx.exception.errno, errno.EBUSY)
+        self.assertGreaterEqual(rmdir.call_count, 2)
+        self.assertLessEqual(rmdir.call_count, 25)
+        self.assertEqual(sleep.call_count, rmdir.call_count - 1)
+        self.assertTrue(os.path.exists(self.path))
+
+
+class TestCpusetDestroyMethod(unittest.TestCase):
+    """Cpuset.destroy() must behave like destroy_cpuset()
+
+    This is the teardown path used by the auto_destroy context manager, so it
+    has to demote the partition and drain tasks the same way the CLI does.
+    """
+
+    def setUp(self):
+        self.tmp = tempfile.TemporaryDirectory()
+        self.path = os.path.join(self.tmp.name, 'cpuset')
+        os.mkdir(self.path)
+        self.partition = os.path.join(self.path, 'cpuset.cpus.partition')
+        self.cs = fake_cpuset(self.path)
+
+    def tearDown(self):
+        self.tmp.cleanup()
+
+    def test_destroy_demotes_partition_first(self):
+        Path(self.partition).write_text('isolated\n')
+        seen = {}
+        real_rmdir = os.rmdir
+
+        def fake_rmdir(path):
+            seen['partition'] = Path(self.partition).read_text()
+            os.unlink(self.partition)
+            real_rmdir(path)
+
+        with mock.patch('tuna.cpuset.os.rmdir', side_effect=fake_rmdir):
+            self.cs.destroy()
+        self.assertEqual(seen['partition'], 'member\n')
+        self.assertFalse(os.path.exists(self.path))
+
+    def test_destroy_retries_on_ebusy(self):
+        Path(self.partition).write_text('member\n')
+        calls = []
+        real_rmdir = os.rmdir
+
+        def fake_rmdir(path):
+            calls.append(path)
+            if len(calls) < 2:
+                raise OSError(errno.EBUSY, 'Device or resource busy', path)
+            os.unlink(self.partition)
+            real_rmdir(path)
+
+        with mock.patch('tuna.cpuset.os.rmdir', side_effect=fake_rmdir), \
+             mock.patch('tuna.cpuset.time.sleep'):
+            self.cs.destroy()
+        self.assertEqual(len(calls), 2)
+        self.assertFalse(os.path.exists(self.path))
+
+    def test_context_manager_uses_the_same_teardown(self):
+        """Leaving an auto_destroy block must demote, not just rmdir"""
+        Path(self.partition).write_text('isolated\n')
+        seen = {}
+        real_rmdir = os.rmdir
+        cs = fake_cpuset(self.path)
+        cs.auto_destroy = True
+
+        def fake_rmdir(path):
+            seen['partition'] = Path(self.partition).read_text()
+            os.unlink(self.partition)
+            real_rmdir(path)
+
+        with mock.patch('tuna.cpuset.os.rmdir', side_effect=fake_rmdir):
+            with cs:
+                pass
+        self.assertEqual(seen['partition'], 'member\n')
+        self.assertFalse(os.path.exists(self.path))
+
+    def test_destroy_missing_dir_is_a_noop(self):
+        cs = fake_cpuset(os.path.join(self.tmp.name, 'never-created'))
+        cs.destroy()
+
+    def test_destroy_without_partition_file(self):
+        real_rmdir = os.rmdir
+
+        def fake_rmdir(path):
+            real_rmdir(path)
+
+        with mock.patch('tuna.cpuset.os.rmdir', side_effect=fake_rmdir):
+            self.cs.destroy()
+        self.assertFalse(os.path.exists(self.path))
+
+
 @unittest.skipUnless(sys.platform.startswith('linux') and os.geteuid() == 0,
                      "Requires root permissions")
 @unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
diff --git a/tuna/cpuset.py b/tuna/cpuset.py
index 23450ff..3b047e8 100644
--- a/tuna/cpuset.py
+++ b/tuna/cpuset.py
@@ -10,8 +10,9 @@
 """ Module for creating and using cpusets (cgroup v2) """
 
 import errno
-import os
 import logging
+import os
+import time
 from glob import glob
 
 logger = logging.getLogger(__name__)
@@ -273,11 +274,16 @@ class Cpuset:
     def destroy(self):
         """
         Remove this cpuset (cgroup directory)
-        The cpuset must be empty (no processes) before it can be removed.
+
+        The partition is demoted to 'member' first so isolated CPUs are
+        returned to the root cgroup, and rmdir is retried briefly on EBUSY
+        while exiting tasks drain. The cpuset must be empty (no processes)
+        before it can be removed.
+
         Raises OSError if the directory is not empty or doesn't exist.
         """
         if self._cpuset_path and os.path.exists(self._cpuset_path):
-            os.rmdir(self._cpuset_path)
+            _demote_and_rmdir(self._cpuset_path)
 
     def __enter__(self):
         """
@@ -634,6 +640,44 @@ def list_cpusets(pattern=None, recursive=True):
     return sorted(cpusets)
 
 
+def _demote_and_rmdir(cpuset_path, timeout=1.0):
+    """
+    Demote a cpuset partition and remove the cgroup directory
+
+    Isolated CPUs are only returned to the root cgroup once the partition is
+    demoted, so do that before the rmdir. A cgroup with tasks still draining
+    out of it makes rmdir fail with EBUSY, which is transient; retry for a
+    bounded time before giving up.
+
+    Args:
+        cpuset_path: Full path to the cgroup directory
+        timeout: Seconds to keep retrying rmdir on EBUSY
+
+    Raises:
+        OSError: If the directory cannot be removed (including EBUSY once
+                 the timeout expires)
+    """
+    part_file = os.path.join(cpuset_path, 'cpuset.cpus.partition')
+    if os.path.exists(part_file):
+        try:
+            with open(part_file, 'w', encoding='utf-8') as f:
+                f.write('member\n')
+        except OSError:
+            pass
+
+    # Retry on EBUSY while exiting tasks drain out of the cgroup
+    start = time.time()
+    while True:
+        try:
+            os.rmdir(cpuset_path)
+            return
+        except OSError as e:
+            if e.errno == errno.EBUSY and (time.time() - start) < timeout:
+                time.sleep(0.05)
+                continue
+            raise
+
+
 def destroy_cpuset(name_or_path, force=False):
     """
     Destroy a cpuset by name or path
@@ -681,8 +725,9 @@ def destroy_cpuset(name_or_path, force=False):
         migrated, failed = tm.migrate()
         logger.info(f"Migrated {migrated} tasks to root cgroup, {failed} failed")
 
-    # Destroy the cpuset
-    os.rmdir(cpuset_path)
+    # Demote the partition and drop the cgroup, draining tasks if they are
+    # still on their way out (see _demote_and_rmdir)
+    _demote_and_rmdir(cpuset_path)
     logger.info(f"Destroyed cpuset: {cpuset_path}")
 
 
-- 
2.52.0

