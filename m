Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909753;
	b=MHVMSg5+cSdrdMEaTrV7+LYspeoQ7iJRwEkAj7MGLqjko0y5mWkxF/Z8M0/kQVhflpc0
	 bioFoU2eKXZCEgN2Tsn59MdClfbV9DU+Gvzn1c2QDRdYDelfqdFR6LRs0+fCOm2MMbtG3
	 BlL9FhZVSyMO+mm4cGQD3tblrAYvQE/X4rFovUIkfrm59u01zR8npL2RlCko0T9jLibUE
	 v7Rh+ogy7zS9b9nN/lBt6xpQhIjVEJm+VWbDEA8bIQewIdvGqVm2brYpW6INXPR304ehW
	 9Ae0d5dHaOxGe+A4bUfmerEJIAKNLjXrDrCzVpzwknjINh5i96lTT0nh+vRA/V0mI2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909753;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=3Lrw2Quyalkkxos3/+3eSbw33s8Ed5QhUe/PPtGprT4=;
	b=ART+iRDl09mnQHyBNbtc90cQSQzxBuBpe8dkjONtze+gjCzR851x3DOhCxvlW3KgfoFk
	 9a/FOFL9r9ll9T2MvQ9/2KvEvIsk6Y4k3G/dQ0p5gb1CryRxqvPb/0/nf8MVl94IND4Nm
	 vPXDQZUM3lp3PNB1W354y7r0IJfIVd6dKzVwisScFjdJDdRRoxkpzDCx+qU+r9vC3yvpJ
	 c8HlmfLEuDvw2rP8MP7EbiD7VtgRCGTdAPl92EblKDD6s2hYyr0EB/ShqIhrO8cTgwgWR
	 VpApAjCE9GwehTaBikoqV40IhD8PtFjl8LG2ea3GIwtO1XNOIGYySu7xAvbpMbOK6Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PMn+muzO;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="pb/wVMTs";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F82606A32C
	for <linux-rt-users@vger.kernel.org>; Thu,  5 Nov 2026 20:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39F82606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PMn+muzO;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pb/wVMTs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793909752;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=3Lrw2Quyalkkxos3/+3eSbw33s8Ed5QhUe/PPtGprT4=;
	b=PMn+muzOtNERv8LPIeaLFWUKOHI6FWkz3bNczRszatDIQMJUzGLMgXDzP/sPrNV1E/7z7r
	pcyLxwC6vAIsMt5IEFcdxh6CnBfD4uczBluYSiYuqe6ew9nDTIyN43HzTQ2aBIlxVMPaQt
	E0rt+wWNH4it7HKwca1TfcN+aTdLI8g=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-iThAF0IAPueMNSWSXaI8mQ-1; Thu, 05 Nov 2026 15:15:51 -0500
X-MC-Unique: iThAF0IAPueMNSWSXaI8mQ-1
X-Mimecast-MFC-AGG-ID: iThAF0IAPueMNSWSXaI8mQ_1793909750
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b18d691d54so41205957b3.3
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Nov 2026 12:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793909750; x=1794514550; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Lrw2Quyalkkxos3/+3eSbw33s8Ed5QhUe/PPtGprT4=;
        b=pb/wVMTsfYxH/KbySJN6A66O34k3OLOImLP0/urFNWciN6Be+dx7cZ3i8uvVYM7GNw
         L7pxy5GKdR6hyZ9iho/wSCitX6AdZ+enEnxLARnB5lxeL4O/LglqPVGSYipSSljvctxw
         j+BTnEeki0eDsv6++V5eX8kbPLRcYzRiL8cGyAA+l0VSm1AcfhIDroFe9KKZFiw/9s62
         uJ5piB5BInr5cbO3W8lJLb2CsbNyYclzG6KzaGJyrMqwVuSbNNhrNtS4tb7rxuM9oecw
         Bx8+22oEa6EsTN89My6EdJlXj6ccQQJz+YTNht+7/e/D49GhvkCu+Jrc+U3wR9WROY9P
         7T6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909750; x=1794514550;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3Lrw2Quyalkkxos3/+3eSbw33s8Ed5QhUe/PPtGprT4=;
        b=zGdJXGVUElq7LGX8sttaa6Ima+HqfmyvYTwEXLtNnIlCd4GNG0M55VwcNP5e3k5w8w
         Ty1eqAVy7WGI+ELBm2X36fkMAc+1wX0T9b2OHi7+xxeTmu5hTSUdtnBvrD1hj5LVezOj
         eUWr7XZ64wAA3majobm6EnXFCFZgbFYPxIIe1kCbE9exOZLZk9evmNan1mOuRp+xiOVF
         TvmgqvRY277Tl3v9NRozGeiubvIK2p/qHK+JcxX7G9fi3opB3XJzL9AtxBNHUAGJ/GkE
         rRVLc0msn8zoGbbqwtE9MKHkVWqffY6gVpMfES4HDGi+z79fhWmrvqoQ2xQBO4zBCRvG
         dDbw==
X-Gm-Message-State: APuU4Z9+VG1QTPZmmZNNrhdOgyi9moHsa7CpwxQtkFqgynZ626NyvpRS
	OHTnDgKMiq+sBwu00/hthEZ19jNFwFrA6LKcUR7oD67Wi4+jHiKreG0hqBckUiJybbO4RUWwBko
	vzj2m0pODBTlm1/BQS14QEwjrtOCb9i5WxKaIk3FMDPjLew/UDy1j3WMqi6PQij/nJ9ofrZxU9H
	QHPs9XZT6/SlfRpDkTsZ1KbYLbtnyyRA4FCqq2DTMtgdXHJRAZslCmr+c=
X-Gm-Gg: AYBFou0v3Zjy1m5FojJ0D2hkcQtgV2PdG+pNhwO6tbsND7XUeh7m1TZ/fAk17U1isTQ
	CRNY8mT3mNKHZI+7i6lhiQ17l5lUPyeawWZXFuBOgibx5OSvsPyZuKoaC/WrafVtcgNJfYW7jd5
	MKo+7z9Zc3ytIg/JjRNGl7xTdTNy4lY4Hijcccf8NjzwP0U1In1P6UzHPa8trJCT75orSGV7USx
	iaLAaa7zAykRzdVYKrOrJkAp0kicD9vBIs/BNH8wZajaSG66j5dqqvFkSxtsZVuHKNa/HnZHEmn
	9ZH6HZEqEopCZTMKRWSzN3umAzwsD1dlpPwshxbBvQwr49hVOXvRIUrOsYyCmwiNV3fsUubJByb
	h4OpgRM1y8lIPpELd0xiSCwvmkqEDhlD0rpdG/z+Ez1krPNldSLzoxCCGyr1Gdfu5pb/neRIoZ8
	I27Sgj9g==
X-Received: by 2002:a05:690c:7003:b0:8b3:141c:b6c4 with SMTP id 00721157ae682-8b3418de989mr863417b3.12.1793909749984;
        Thu, 05 Nov 2026 12:15:49 -0800 (PST)
X-Received: by 2002:a05:690c:7003:b0:8b3:141c:b6c4 with SMTP id 00721157ae682-8b3418de989mr863067b3.12.1793909749162;
        Thu, 05 Nov 2026 12:15:49 -0800 (PST)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f88389dsm3220747b3.40.2026.11.05.12.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:15:48 -0800 (PST)
Date: Thu, 5 Nov 2026 15:15:44 -0500
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v2] rteval: Added integration tests multi stressor support in
 stress-ng
Message-ID: <auzj8PnZf8SY9us8@sansshar-thinkpadp1gen4i.boston.csb>
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
index 5961ee2..d854a69 100644
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
+            ["./rteval-cmd", "--stressng-stressor","-d","5","--measurement-module","timerlat"],
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
+            ["./rteval-cmd", "--stressng-stressor", "cpu","-d","5","--measurement-module","timerlat"],
+            capture_output=True,
+            text=True
+        )
+        assert result.returncode == 0
+        assert "stressng: stress-ng --cpu 0 --taskset" in result.stdout
+
+    def test_set_worker_single(self):
+        """Test that single stressor with a set number of workers passes the number through"""
+        result = subprocess.run(
+            ["./rteval-cmd", "--stressng-stressor", "cpu", "--stressng-workers", "3","-d","5","--measurement-module","timerlat"],
+            capture_output=True,
+            text=True
+        )
+        assert result.returncode == 0
+        assert "stressng: stress-ng --cpu 3 --taskset" in result.stdout
+
+    def test_single_with_multi(self):
+        """Tests that passing multiple stressors with the single stressor argument raises a Value Error """
+        result = subprocess.run(
+            ["./rteval-cmd", "--stressng-stressor", "cpu,vm", "--stressng-workers", "3","-d","5","--measurement-module","timerlat"],
+            capture_output=True,
+            text=True
+        )
+        assert result.returncode != 0
+        assert "ValueError: Invalid stress-ng stressors: cpu,vm. Run 'stress-ng --stressors' to see valid options." in result.stderr
+
+    def test_multiple_singles(self):
+        """Tests that when multiple single stressors are passed with single arguments the code runs all the stressors """
+        result = subprocess.run(
+            ["./rteval-cmd", "--stressng-stressor", "cpu", "--stressng-stressor", "vm", "--stressng-workers", "3","-d","5","--measurement-module","timerlat"],
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
+            ["./rteval-cmd", "--stressng-stressors","-d","5","--measurement-module","timerlat"],
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
+            ["./rteval-cmd", "--stressng-stressors","cpu","-d","5","--measurement-module","timerlat"],
+            capture_output=True,
+            text=True
+        )
+        assert result.returncode == 0
+        assert "stressng: stress-ng --cpu 0 --taskset" in result.stdout
+
+    def test_multi_stressor_default_workers(self):
+        """Tests that the default workers is 0"""
+        result = subprocess.run(
+            ["./rteval-cmd", "--stressng-stressors", "cpu,vm","-d","5","--measurement-module","timerlat"],
+            capture_output=True,
+            text=True
+        )
+        assert result.returncode == 0
+        assert "stressng: stress-ng --cpu 0 --vm 0 --taskset" in result.stdout
+
+    def test_multi_stressor_set_workers(self):
+        """Tests that multiple stressors with a set number of workers passes correctly"""
+        result = subprocess.run(
+            ["./rteval-cmd", "--stressng-stressors", "cpu,vm", "--stressng-workers", "2","-d","5","--measurement-module","timerlat"],
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
2.55.0

