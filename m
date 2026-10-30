Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368189;
	b=Llc5gfB8Dqn/9wTlgVYjqJB4ZKBIymn2Yi5wCuQ1NEut+pNnZZ9/7uvxPZQwVHh+2xdl
	 FzreB3nqO9Yz7Clo10Q8ZydrbvlyTR79q+yFdQC5qAE8CNWisoCyMg2JwE0QnpwnXXxxR
	 ArzDtDCqPa/5zDe0cYVA9qdbGHfAqufzYb7JakYIy3LFF/KV6KJCob7FXeFhgPCVR+tZm
	 Q4vN2UJ/Hlg4NW4utzJGHjYlh6DVslWQUVtlqPd70ux/DAU2qMwk+lvLahU6mqhjD3olS
	 JI99BjYOX2nmQmV0J/epyEFBa/+nETfiXr8gPEOdZ3iwy7Es58Orq5FMInU5SObK8Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368189;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=6/IgFQFMKd1/zTE4V2DZCEDTrrCPSUZBO5PgRm8lzmM=;
	b=De5fp11uyonnAeVdnv2EK3tt7MHLGKFUoFkU5FxaNY1rukq4DHVAOO2eTrohYo7oL7h+
	 trOA/vtVytGbSqMQWQo0fSHJnQ+GE6cTWdWcXJrRQQf1oCzyJRx+BDKSspx8OtSHklUAu
	 wgMCLiT+fOuLBbfrt4qfRT2SVO/zhLu/Izo2T7IV1R1Ev6a5pVFzbdVxxk+iC1LusOxTx
	 KcHPbs5HOWfVVPwT+Ge1b8RMfjefbrxzPbWWqhpOK6qeM16YRju3irEW+qS1qYzJPYbLT
	 nE2Q1NCldjKARh2YxDQMBNO6PvL4RpwdpfAfmJQwxyDinFFbrSmFLa+O5ha5HhUJRKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZdGHPpNI;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mI9+ndnp;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13792606A31A
	for <linux-rt-users@vger.kernel.org>; Fri, 30 Oct 2026 13:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13792606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZdGHPpNI;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=mI9+ndnp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793368188;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=6/IgFQFMKd1/zTE4V2DZCEDTrrCPSUZBO5PgRm8lzmM=;
	b=ZdGHPpNIlSLkYbH35BBAop8oOoa4k3rCCqBrPXCPy5HvqCp+mUFytXUBm/FsmxOuSJZ6x8
	tlHlLaV09UFV14UcAZegX/0myTkTlwobRUqUpLn/jnH/EgoHD8xbXobHPhSjq3+EWLSQFN
	dtrZpkJmaptKiXUbzazuXdZDq1IBNhY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-pAttytleMXGDKPMAeTeRpA-1; Fri, 30 Oct 2026 09:49:46 -0400
X-MC-Unique: pAttytleMXGDKPMAeTeRpA-1
X-Mimecast-MFC-AGG-ID: pAttytleMXGDKPMAeTeRpA_1793368186
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb71b1443so140592185a.2
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Oct 2026 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793368186; x=1793972986; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6/IgFQFMKd1/zTE4V2DZCEDTrrCPSUZBO5PgRm8lzmM=;
        b=mI9+ndnp3aPin1AKLRJ9stJDu4WTQaBobYbxyfcBD5MPx0vojgrSqO/r3mBuep+d5y
         3O8su1FxEYx/cpXlL7Lb/Regp9hO8qQ4cToTo6pCJe2qKIjLSp6F+j0reXIiPB/0p6PR
         4O/be/TdSXsDXo7aQZGYeD7uV/OMAFK7qPDe9t89pFCrEg6vZfARW4B3qHCrqCKydT4F
         bLQLI5gq9OdQszXilgaem6oRC+A6CVSzZAyTHc34CNDSRLW3qK21AmisgF4lwcTnqNDy
         rhlpILDbcadoQmGCbZlBHHgx1XEaVI8CoKfM0hPPSC9z+AuIjT8+FUfGvGIlPc6zCNdd
         Q3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368186; x=1793972986;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6/IgFQFMKd1/zTE4V2DZCEDTrrCPSUZBO5PgRm8lzmM=;
        b=wVljYQYBtg4lB4mHQHmg/nF1AcyTy1v8wwdWzjbFHaZ1aegufSC65Aiyx9Xk+93PO9
         fi9htB1XVg+NxrHxHK75QvZE3xVM2N2Hac9A9IZ+IK8FEDH02e6YFo4fbRIowmpZYHaR
         yNQR8+8WEhJHRmIXfccQxBFQeXV5oHtwkJcxOoPYM5jjLU/wARplu1OHvE+SH8cy6PeS
         8yixU+6cjLqoM43GSZWpTCyxw08ADTpkn+g19LpRAB+JqXUB3gFod5seGTCKmCj7ejGa
         qZLW0UWEru1V0jgoP8kaj0kSnAKh4fvuc/uyFUCCGN8IDC9P0RVO+gzr/MT2k8NdDYgm
         kx0A==
X-Gm-Message-State: AFq9FYL/lfGOCOAzH88KRDE13X16GoI5zOFMhdNjAFDvCCo1jToxlRt3
	KjtSlNOqiZspODWrxs1hoTlUZc3awXvU4bhYmqUEkIbUN2JGguoHe0/ETsVXPr29ok5e40QvjSo
	Jnx3819JSy9NKpxj+34hhRjFiglJPtb6OrX0DKnasDUl4EDA46OB4Ve8Z4TevxZ0xGpYoqkyP/Q
	KowwLxHUiclT3PBLp6zomE4q5fNZNyqCb2vuzUWIM7Z5nWh2PYQqKQ5mo=
X-Gm-Gg: AYBFou3ZGURItWIYtlOGyGDb/yyMV4il+qfZiIYWdz/sqklzxNPUQ/ibXOzSqi8AnzF
	9VpGaBy39Use6nBoWQJnyMM4JFpdsvVxt/SgwgJZ8YB75e0oOX1sXd/ie/9hMg6Sy8sXoFTSpdA
	gvts0bKM6Wv9vsDkr+MixONzPdzm0+GB8zgHA5Uav9CjvAGpn/5EHwcoXARRR5NZb7IaK6Zp7f1
	dnOsf23IMBPvYJwIVmpd4nCtqapDT7JptkOM0r42h0n2wjmlvWI8tkJ94Ty73wuCsKze6v0AFsv
	WRWie1NB6mXsAivscTU4XCB1i+nwtNF6dNG44Qayu2HEJ2nPO2lCUxWPHHqBNB7kwPr75OYMf60
	4Fub8H4rZI6wA2eGqipqG7WQrxNiUWRtLPk6t6gvLRtvwb3M1KTSINFvrzy53ZwBLRjUZVd7KTw
	lV9Z9k8Uo=
X-Received: by 2002:a05:620a:f04:b0:93e:6f65:de63 with SMTP id af79cd13be357-944217bd696mr387595285a.47.1793368185633;
        Fri, 30 Oct 2026 06:49:45 -0700 (PDT)
X-Received: by 2002:a05:620a:f04:b0:93e:6f65:de63 with SMTP id af79cd13be357-944217bd696mr387590685a.47.1793368185030;
        Fri, 30 Oct 2026 06:49:45 -0700 (PDT)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9442581b2d2sm146615085a.15.2026.10.30.06.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:49:44 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:49:39 -0400
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v1] rteval: Added integration tests multi stressor support in
 stress-ng
Message-ID: <auSgczD-qWxJhBbC@fedora>
Reply-To: sansshar@redhat.com
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Added integrations test that checked the single-stressor and
multi-stressor support as well as the cpuset logic in this
context.

Assisted-by: Claude Opus 4.8
Signed-off-by: Sana Sharma <sansshar@redhat.com>
---
 tests/test_stressng.py | 239 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 238 insertions(+), 1 deletion(-)

diff --git a/tests/test_stressng.py b/tests/test_stressng.py
index 29291e6..d684ff6 100644
--- a/tests/test_stressng.py
+++ b/tests/test_stressng.py
@@ -6,8 +6,11 @@
 import sys
 import subprocess
 import unittest
+from types import SimpleNamespace
 from unittest.mock import patch, MagicMock
-sys.path.insert(0,'.')
+from pathlib import Path
+
+sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
 from rteval.modules.loads import stressng
 
 class TestGetValidStressors(unittest.TestCase):
@@ -50,6 +53,240 @@ class TestValidateStressor(unittest.TestCase):
         with self.assertRaises(ValueError):    
             stressng.validate_stressors('bogus')
 
+
+"""Integration Tests for stress_ng stressor functionality"""
+
+class TestSingleStressor(unittest.TestCase):
+    """Test suite for single stressor case"""
+
+    def test_no_stressor_single(self):
+        """Test that the single stressor argument with no stressors throws the correct error"""
+        result = subprocess.run(
+            ["./rteval-cmd", "--stressng-stressor"],
+            capture_output=True,
+            text=True
+        )
+        assert result.returncode != 0
+        assert "usage: rteval-cmd" in result.stderr
+        assert "rteval-cmd: error: argument --stressng-stressor: expected one argument" in result.stderr
+
+    def test_default_worker_single(self):
+        """Test that for the single stressor the undefined workers defaults to 0"""
+        result = subprocess.run(
+            ["./rteval-cmd", "--stressng-stressor", "cpu"],
+            capture_output=True,
+            text=True
+        )
+        assert result.returncode == 0
+        assert "stressng: stress-ng --cpu 0 --taskset" in result.stdout
+
+    def test_set_worker_single(self):
+        """Test that single stressor with a set number of workers passes the number through"""
+        result = subprocess.run(
+            ["./rteval-cmd", "--stressng-stressor", "cpu", "--stressng-workers", "3"],
+            capture_output=True,
+            text=True
+        )
+        assert result.returncode == 0
+        assert "stressng: stress-ng --cpu 3 --taskset" in result.stdout
+
+    def test_single_with_multi(self):
+        """Tests that passing multiple stressors with the single stressor argument raises a Value Error """
+        result = subprocess.run(
+            ["./rteval-cmd", "--stressng-stressor", "cpu,vm", "--stressng-workers", "3"],
+            capture_output=True,
+            text=True
+        )
+        assert result.returncode != 0
+        assert "ValueError: Invalid stress-ng stressors: cpu,vm. Run 'stress-ng --stressors' to see valid options." in result.stderr
+
+    def test_multiple_singles(self):
+        """Tests that when multiple single stressors are passed with single arguments the code runs all the stressors """
+        result = subprocess.run(
+            ["./rteval-cmd", "--stressng-stressor", "cpu", "--stressng-stressor", "vm", "--stressng-workers", "3"],
+            capture_output=True,
+            text=True
+        )
+        assert result.returncode == 0
+        assert "stressng: stress-ng --cpu 3 --vm 3 --taskset" in result.stdout
+
+class TestMultiStressor(unittest.TestCase):
+
+    def test_no_stressor_multi(self):
+        """Tests that multi stressors with no stressor name leads to an error"""
+        result = subprocess.run(
+            ["./rteval-cmd", "--stressng-stressors"],
+            capture_output=True,
+            text=True
+        )
+        assert result.returncode != 0
+        assert "usage: rteval-cmd" in result.stderr
+        assert "rteval-cmd: error: argument --stressng-stressors: expected one argument" in result.stderr
+
+    def test_one_stressor_multi(self):
+        """Tests that multiple stressors with one stressor argument works"""
+        result = subprocess.run(
+            ["./rteval-cmd", "--stressng-stressors","cpu"],
+            capture_output=True,
+            text=True
+        )
+        assert result.returncode == 0
+        assert "stressng: stress-ng --cpu 0 --taskset" in result.stdout
+
+    def test_multi_stressor_default_workers(self):
+        """Tests that the default workers is 0"""
+        result = subprocess.run(
+            ["./rteval-cmd", "--stressng-stressors", "cpu,vm"],
+            capture_output=True,
+            text=True
+        )
+        assert result.returncode == 0
+        assert "stressng: stress-ng --cpu 0 --vm 0 --taskset" in result.stdout
+
+    def test_multi_stressor_set_workers(self):
+        """Tests that multiple stressors with a set number of workers passes correctly"""
+        result = subprocess.run(
+            ["./rteval-cmd", "--stressng-stressors", "cpu,vm", "--stressng-workers", "2"],
+            capture_output=True,
+            text=True
+        )
+        assert result.returncode == 0
+        assert "stressng: stress-ng --cpu 2 --vm 2 --taskset" in result.stdout
+
+class TestWorkloadPrepareCpuset(unittest.TestCase):
+    """
+    Integration tests for the cpuset/taskset logic in _WorkloadPrepare.
+
+    Each scenario is exercised for both ways of configuring stressors:
+      * single stressor form  -> cfg.stressors is a list, e.g. ['cpu']
+        (this is what __init__ produces from --stressng-stressor)
+      * multi stressor form   -> cfg.stressors is a comma-separated string,
+        e.g. 'cpu,vm' (this comes from --stressng-stressors)
+    """
+
+    # stressor configs covered by every cpuset scenario: (label, cfg.stressors,
+    # expected --<flag> options that should land in args)
+    STRESSOR_FORMS = (
+        ("single", ['cpu'], ['--cpu']),
+        ("multi", 'cpu,vm', ['--cpu', '--vm']),
+    )
+
+    @staticmethod
+    def make_stressng(stressors, workers='0', timeout=None, cpulist=""):
+        """Build a Stressng instance without running the heavy __init__.
+
+        Only the attributes read by _WorkloadPrepare() are populated. The
+        cfg.stressors attribute mirrors what __init__ would store: a list for
+        the single-stressor flag, or a comma-separated string for the
+        multi-stressor flag.
+        """
+        inst = stressng.Stressng.__new__(stressng.Stressng)
+        inst.cfg = SimpleNamespace(stressors=stressors, workers=workers,
+                                   timeout=timeout)
+        inst.cpulist = cpulist
+        inst._logging = False
+        inst._log = MagicMock()
+        inst.args = None
+        return inst
+
+    @staticmethod
+    def taskset_arg(args):
+        """Return the value following --taskset, or None if not present."""
+        if '--taskset' not in args:
+            return None
+        return args[args.index('--taskset') + 1]
+
+    @patch('rteval.modules.loads.stressng.get_valid_stressors',
+           return_value=['cpu', 'vm', 'matrix', 'io'])
+    @patch('rteval.modules.loads.stressng.os.open', return_value=42)
+    @patch('rteval.modules.loads.stressng.SysTopology')
+    def test_cpulist_restricts_taskset(self, mock_systop, _mock_open, _mock_valid):
+        """A cpulist keeps only its CPUs, intersected per node."""
+        topo = mock_systop.return_value
+        topo.getnodes.return_value = [0, 1]
+        topo.getcpus.side_effect = lambda n: {0: [0, 1, 2, 3],
+                                              1: [4, 5, 6, 7]}[n]
+
+        for label, stressors, flags in self.STRESSOR_FORMS:
+            with self.subTest(form=label):
+                s = self.make_stressng(stressors=stressors, cpulist="0,1,4,5")
+                s._WorkloadPrepare()
+
+                self.assertEqual(self.taskset_arg(s.args), "0,1,4,5")
+                for flag in flags:
+                    self.assertIn(flag, s.args)
+
+    @patch('rteval.modules.loads.stressng.get_valid_stressors',
+           return_value=['cpu', 'vm', 'matrix', 'io'])
+    @patch('rteval.modules.loads.stressng.os.open', return_value=42)
+    @patch('rteval.modules.loads.stressng.SysTopology')
+    def test_empty_node_is_dropped(self, mock_systop, _mock_open, _mock_valid):
+        """A node whose CPUs are all filtered out is removed from the taskset."""
+        topo = mock_systop.return_value
+        topo.getnodes.return_value = [0, 1]
+        topo.getcpus.side_effect = lambda n: {0: [0, 1, 2, 3],
+                                              1: [4, 5, 6, 7]}[n]
+
+        # cpulist only matches CPUs on node 0, so node 1 has no usable CPUs
+        for label, stressors, flags in self.STRESSOR_FORMS:
+            with self.subTest(form=label):
+                s = self.make_stressng(stressors=stressors, cpulist="0,1")
+                s._WorkloadPrepare()
+
+                self.assertEqual(self.taskset_arg(s.args), "0,1")
+                for flag in flags:
+                    self.assertIn(flag, s.args)
+
+    @patch('rteval.cpulist_utils.sysread', return_value="2-3")
+    @patch('rteval.cpulist_utils._isolated_file_exists', return_value=True)
+    @patch('rteval.modules.loads.stressng.get_valid_stressors',
+           return_value=['cpu', 'vm', 'matrix', 'io'])
+    @patch('rteval.modules.loads.stressng.os.open', return_value=42)
+    @patch('rteval.modules.loads.stressng.SysTopology')
+    def test_no_cpulist_excludes_isolated(self, mock_systop, _mock_open,
+                                          _mock_valid, _mock_isofile, _mock_sysread):
+        """Without a cpulist, isolated CPUs (2,3 here) are excluded."""
+        topo = mock_systop.return_value
+        topo.getnodes.return_value = [0]
+        topo.getcpus.side_effect = lambda n: [0, 1, 2, 3]
+
+        for label, stressors, flags in self.STRESSOR_FORMS:
+            with self.subTest(form=label):
+                s = self.make_stressng(stressors=stressors, cpulist="")
+                s._WorkloadPrepare()
+
+                self.assertEqual(self.taskset_arg(s.args), "0,1")
+                for flag in flags:
+                    self.assertIn(flag, s.args)
+
+    @patch('rteval.modules.loads.stressng.get_valid_stressors',
+           return_value=['cpu', 'vm', 'matrix', 'io'])
+    @patch('rteval.modules.loads.stressng.os.open', return_value=42)
+    @patch('rteval.modules.loads.stressng.SysTopology')
+    def test_workers_and_timeout_appended(self, mock_systop, _mock_open, _mock_valid):
+        """Worker count and timeout are placed in args before --taskset."""
+        topo = mock_systop.return_value
+        topo.getnodes.return_value = [0]
+        topo.getcpus.side_effect = lambda n: [0, 1]
+
+        # single stressor: --cpu <workers> --timeout <t> ...
+        s = self.make_stressng(stressors=['cpu'], workers='3', timeout='30',
+                               cpulist="0,1")
+        s._WorkloadPrepare()
+        self.assertEqual(s.args[:5],
+                         ['stress-ng', '--cpu', '3', '--timeout', '30'])
+        self.assertEqual(self.taskset_arg(s.args), "0,1")
+
+        # multi stressor: each stressor gets the worker count, then --timeout
+        s = self.make_stressng(stressors='cpu,vm', workers='2', timeout='30',
+                               cpulist="0,1")
+        s._WorkloadPrepare()
+        self.assertEqual(s.args[:7],
+                         ['stress-ng', '--cpu', '2', '--vm', '2',
+                          '--timeout', '30'])
+        self.assertEqual(self.taskset_arg(s.args), "0,1")
+
+
 def main():
     """Run the test suite"""
     unittest.main(verbosity=2)
-- 
2.54.0


-- 
Sana Sharma <sansshar@redhat.com>

