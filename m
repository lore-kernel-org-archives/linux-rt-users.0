Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613589;
	b=NV0VEFCxaAPZGqjwODkbc1d+AEZrEB3j7yrPpxjwkrnKoJkt9mBn1YybeGLZE061YX9o
	 dir/ZqrsjH++4cXLGX59Z09k8KUP0symATazVuA2d1/w1x6v/cHX2XMVt7RPa51i2BhcM
	 36RP2b2CYd6LD4LMyQM5++Pk/62gR+/oZqNBvCXAGttqLoFAPcDXpmAA8tqo+BTg+z2S5
	 WvmeYSaIp1YrbaoWYWON2vC5DPlJna23hzMs1ywx0s47NRhYR5/xnRRdSWp8z99L0ld0Z
	 6Iz8eypvicTfy3nt1b0kW8nTapI4xa0l7bsozJ68W/7MScRAEnvudgoHq0ye8WNaGfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613589;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=lRvq9to9evr3TCl6SVh6Q8p+PW2YGRdZapcKp1RyoBM=;
	b=i3T0GqnbR+UO5JbxgfDhwEX6cQTQHb5sLBIEy7JpKUtDDyiui4+Ri1Lo4K9f4IwzI9JF
	 BKwVP+9C1xgeOaw1Oc2d7RK+WynfwcC40dqdswf+y7i2jw//NRJpGWUzwgdnA0KsbSB4i
	 iYl5mAfxMeLcUc2ZWKvwzU2d/Tj73XCJDnZdmeKowwGx/+6xOmc0x8YkJcyZNt0xDRPEG
	 Ptirasyow9zFKv9NPdu9Clhr007ToOHL193iOcUCSPLA8YbgdfiMlTsgB7+p8vsP0rBsQ
	 wqORghe/NrawZyDwob7L4d8FXXIaIkBV/wUzq/AXgW8GKixq4BlKiSKDGajp0EOMSwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="c3F2L/7F";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A58606A329
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Nov 2026 23:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4A58606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c3F2L/7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794613587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRvq9to9evr3TCl6SVh6Q8p+PW2YGRdZapcKp1RyoBM=;
	b=c3F2L/7FBZ7eMGDWTcFSNkoeNnSyOSd5Tg0UTGHJQrodsx++xI1g3OweGma7MBu7qLxD4B
	1CHOuqK7sj9F8X+SwcLkQA5D/8XRTLK4cReUzWwUsA5pHmQaXMhC/WZwiiCM+8SEvd3Q5m
	dTWfEQoFV/qPVAppge9uke0pzYridZc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-zp4h5N_ZOwWhgirWBXTO8A-1; Fri,
 13 Nov 2026 18:46:26 -0500
X-MC-Unique: zp4h5N_ZOwWhgirWBXTO8A-1
X-Mimecast-MFC-AGG-ID: zp4h5N_ZOwWhgirWBXTO8A_1794613585
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 525B41955E92
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Nov 2026 23:46:25 +0000 (UTC)
Received: from dev-workstation (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66BAB30001B9;
	Fri, 13 Nov 2026 23:46:24 +0000 (UTC)
From: Chris White <chwhite@redhat.com>
To: jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 2/5] tuna: Verify cpuset controller is enabled in parent cgroup
Date: Fri, 13 Nov 2026 15:46:17 -0800
Message-ID: <20261113234620.1608227-3-chwhite@redhat.com>
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

When creating a child cpuset, _enable_controllers() attempts to enable
the cpuset controller in the parent's cgroup.subtree_control by writing
'+cpuset'. Any OSError or PermissionError was previously caught and
ignored. If the write failed, subsequent operations on cpuset.cpus or
cpuset.cpus.partition in the child fail unexpectedly.

Verify that 'cpuset' is actually present in the parent's
cgroup.subtree_control after the write, and raise an OSError if not.
In create_cpuset(), clean up the newly created directory if controller
activation fails.

This was tested and verified by running tuna isolation scenarios with
SameStack: its runtime isolation lease creates the isolated cpuset
through this code path on every acquisition, and the B-tuna campaign
on realtime-04 exercised it end to end, as did a 40-round
isolate/destroy/restore soak on centos-dev.

Assisted-by: Apogee
Signed-off-by: Chris White <chwhite@redhat.com>
---
 tests/test_cpuset_errors.py | 89 +++++++++++++++++++++++++++++++++++++
 tuna/cpuset.py              | 33 +++++++++++---
 2 files changed, 117 insertions(+), 5 deletions(-)

diff --git a/tests/test_cpuset_errors.py b/tests/test_cpuset_errors.py
index 78a51a5..8636bdc 100644
--- a/tests/test_cpuset_errors.py
+++ b/tests/test_cpuset_errors.py
@@ -91,6 +91,95 @@ class TestWriteCpuExclusive(unittest.TestCase):
         fake_cpuset(self.path).unset_cpu_exclusive()
 
 
+class TestEnableControllers(unittest.TestCase):
+    """_enable_controllers() must fail if cpuset stays disabled in the parent"""
+
+    def setUp(self):
+        self.tmp = tempfile.TemporaryDirectory()
+        self.subtree = os.path.join(self.tmp.name, 'cgroup.subtree_control')
+        self.cs = fake_cpuset(os.path.join(self.tmp.name, 'child'))
+
+    def tearDown(self):
+        self.tmp.cleanup()
+
+    def test_already_enabled(self):
+        Path(self.subtree).write_text('cpu cpuset memory\n')
+        self.cs._enable_controllers()
+
+    def test_enabled_by_write(self):
+        Path(self.subtree).write_text('cpu memory\n')
+        real_open = builtins.open
+
+        def fake_open(file, mode='r', *args, **kwargs):
+            if file == self.subtree and 'w' in mode:
+                # The kernel turns '+cpuset' into an enabled controller
+                handle = mock.mock_open()()
+                handle.write.side_effect = lambda s: Path(self.subtree).write_text(
+                    'cpu cpuset memory\n')
+                return handle
+            return real_open(file, mode, *args, **kwargs)
+        with mock.patch('builtins.open', side_effect=fake_open):
+            self.cs._enable_controllers()
+        self.assertIn('cpuset', Path(self.subtree).read_text().split())
+
+    def test_write_rejected_raises(self):
+        Path(self.subtree).write_text('cpu memory\n')
+        real_open = builtins.open
+
+        def fake_open(file, mode='r', *args, **kwargs):
+            if file == self.subtree and 'w' in mode:
+                raise OSError(errno.EBUSY, 'Device or resource busy', file)
+            return real_open(file, mode, *args, **kwargs)
+        with mock.patch('builtins.open', side_effect=fake_open):
+            with self.assertRaises(OSError) as ctx:
+                self.cs._enable_controllers()
+        self.assertEqual(ctx.exception.errno, errno.EBUSY)
+        self.assertIn('cpuset controller', str(ctx.exception))
+
+    def test_missing_subtree_control_raises(self):
+        with self.assertRaises(OSError):
+            self.cs._enable_controllers()
+
+
+class TestCreateCpusetCleanup(unittest.TestCase):
+    """A failed controller activation must not leave an empty cgroup behind"""
+
+    def setUp(self):
+        self.tmp = tempfile.TemporaryDirectory()
+        self.path = os.path.join(self.tmp.name, 'child')
+
+    def tearDown(self):
+        self.tmp.cleanup()
+
+    def new_cpuset(self):
+        cs = cpuset.Cpuset.__new__(cpuset.Cpuset)
+        cs.cpuset_name = None
+        cs._cpuset_path = None
+        cs.auto_destroy = False
+        return cs
+
+    def test_directory_is_removed_when_controllers_fail(self):
+        cs = self.new_cpuset()
+        with mock.patch.object(cpuset.Cpuset, 'mpath', self.tmp.name), \
+             mock.patch.object(cpuset.Cpuset, '_enable_controllers',
+                               side_effect=OSError(errno.EINVAL,
+                                                   'cannot enable cpuset')):
+            with self.assertRaises(OSError):
+                cs.create_cpuset('child')
+        self.assertFalse(os.path.exists(self.path))
+
+    def test_error_from_controllers_is_the_one_raised(self):
+        cs = self.new_cpuset()
+        with mock.patch.object(cpuset.Cpuset, 'mpath', self.tmp.name), \
+             mock.patch.object(cpuset.Cpuset, '_enable_controllers',
+                               side_effect=OSError(errno.EINVAL,
+                                                   'cannot enable cpuset')):
+            with self.assertRaises(OSError) as ctx:
+                cs.create_cpuset('child')
+        self.assertEqual(ctx.exception.errno, errno.EINVAL)
+        self.assertIn('cannot enable cpuset', str(ctx.exception))
+
+
 @unittest.skipUnless(sys.platform.startswith('linux') and os.geteuid() == 0,
                      "Requires root permissions")
 @unittest.skipUnless(cpuset.CpusetsInit().supported, "Requires cgroup v2 support")
diff --git a/tuna/cpuset.py b/tuna/cpuset.py
index 833c292..23450ff 100644
--- a/tuna/cpuset.py
+++ b/tuna/cpuset.py
@@ -86,16 +86,27 @@ class Cpuset:
         os.mkdir(path)
         self._cpuset_path = path
         # Enable cpuset controller in parent if needed
-        self._enable_controllers()
+        try:
+            self._enable_controllers()
+        except OSError:
+            os.rmdir(path)
+            raise
 
     def _enable_controllers(self):
-        """ Enable cpuset controller in parent cgroup """
+        """
+        Enable cpuset controller in parent cgroup
+
+        Raises:
+            OSError: if the cpuset controller is still not enabled in the
+                     parent's cgroup.subtree_control afterwards.
+        """
         # Get parent path
         parent_path = os.path.dirname(self._cpuset_path)
         if parent_path == '/sys/fs':
             parent_path = '/sys/fs/cgroup'
 
         subtree_control = os.path.join(parent_path, 'cgroup.subtree_control')
+        error = None
         try:
             # Read current controllers
             with open(subtree_control, 'r', encoding='utf-8') as f:
@@ -106,9 +117,21 @@ class Cpuset:
             if 'cpuset' not in current.split():
                 with open(subtree_control, 'w', encoding='utf-8') as f:
                     f.write('+cpuset')
-        except (OSError, PermissionError):
-            # May fail if already enabled or no permissions
-            pass
+        except OSError as err:
+            # The write may race with another writer; re-check below
+            error = err
+
+        try:
+            with open(subtree_control, 'r', encoding='utf-8') as f:
+                enabled = 'cpuset' in f.read().split()
+        except OSError as err:
+            error = err
+            enabled = False
+        if not enabled:
+            reason = f": {error.strerror}" if error and error.strerror else ""
+            raise OSError(error.errno if error else errno.EINVAL,
+                          f"cannot enable cpuset controller in {parent_path}{reason}",
+                          subtree_control)
 
     def assign_cpus(self, cpu_str):
         """
-- 
2.52.0

