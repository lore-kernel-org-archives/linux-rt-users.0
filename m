Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994235;
	b=AzBGuZhzWLAZsCPeUrlFm72YFlOS0DSRvQp4GjV9LmqBDXOaEoF0PZNrsgtQLZvB0B0U
	 wCfrx+OjWHm9FPS1PzLq/TM7/l0qKN4eE+nT0cb+1tafOFASFiXASsyR2We6P3caZ8IXp
	 IKm43451rgWa7PU8Rt+oHKcmN0lwZ++tRMpc58Sj+sCncETHSfkKQQrGcis5CCEL6prQk
	 RpSAbRdSJ4p0EnUih+ovBrbC93h04/3dtFU3NVh+z/Lr0yubxqMSFic6iAyDK7/D81TMv
	 JuI1lH5ayk8vhHpW1iZ1lN8CiAJHGkngzaqft9SuU2pY4N+H6c8fzixl+fDsu7svCTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994235;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=WssqC46qExAJjxhc4yAYpknb0OuPA0k4K10k3Li4G7E=;
	b=Ua+lPNYs583gOvEUMFYr7GB7TbRnR2r+o8jmokWbbfy7CY+EewBRv3O0rhr2D3qnDrNy
	 cjjqJMuTSRCJfsBavegC52QFqtdQpzjO8ZuX6l4h353qc4I2UpIKu/62mrZ+Tr6HjbYb2
	 KGnFROAaKgUq+rLWVFjnuNHcudge/xuI7CH9y1yVRPo6lFNlA1J1ugobIJClJZTtXRryP
	 zZTF5UJPt3VT7e3kSyixlozBYBBPtLoqOCqLtEgAF23wiHrDiCdZzC6HKFQBQT248o/cK
	 ItT19iKuaLaM9u6GKlQ1EqHMFr6hRN4ZPI+cG4uFcTxbl0RY6wAq35HapmIKIxvc4/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L3SNRVTA;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="LpwLU/hx";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A679B606A326
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Nov 2026 19:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A679B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L3SNRVTA;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=LpwLU/hx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793994233;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=WssqC46qExAJjxhc4yAYpknb0OuPA0k4K10k3Li4G7E=;
	b=L3SNRVTAmCCIe+icj0JuN8LNoo188OQob/N7mCgxssOBWKRGKyua19NrJXyHh45Ndy7CEU
	3SqNI2lR3juzN3torQP2zuJ9CZqQ5Gs0W8fk9/zfJyIa3C1udXRTa1uj9mWdtl8OngmbeW
	vH8PZCWnBG6Tl3KDKRAvUO1PI1d5Hhk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-CD6q6NEgOyWdBgykSsUlbQ-1; Fri, 06 Nov 2026 14:43:49 -0500
X-MC-Unique: CD6q6NEgOyWdBgykSsUlbQ-1
X-Mimecast-MFC-AGG-ID: CD6q6NEgOyWdBgykSsUlbQ_1793994229
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f2373e9b4so126515885a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Nov 2026 11:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793994229; x=1794599029; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WssqC46qExAJjxhc4yAYpknb0OuPA0k4K10k3Li4G7E=;
        b=LpwLU/hxEx+fdxQmxPHJWrlYTZArroFnvkuNYtS/UbRJt0mYOZT/fI+g7wD+L5Y+OV
         d0k658ADWNzj5wD2vdvPwyhZGTsCh3QmmmrhGtP4PF+E1Gz33qYpJg/DKgd4iqN+dWSm
         SEUHILYoWSebKaZKo3Po8+sH/nFxVjuTF4sOsgLOJPloC7NTr6U5UVY5Wu3xpshuJwjF
         ywSseJrKpW8zNgFdjeD7UIjVnszsRvW0OGaCYUXDV++WJqDMJBUMlilQ0UIlH9hGVyIh
         mi0FFkHs+flPA9nbLJPq0RvlMEUoW8uljaJ+jCKjccMd8gRn+oCvUS/4x3yglbta5qoc
         8KPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793994229; x=1794599029;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WssqC46qExAJjxhc4yAYpknb0OuPA0k4K10k3Li4G7E=;
        b=tkoJI7ZYvi/jwiqnaKgOhPb6no8QYQ6Q69f/dY4ZAY++IOvSdXGJLNLIV5gbZwYLbP
         zIuYAZqAzT1lbM+N0I/axx5OGW1oFEdHy5BfsOgDHMvYn0ypVtBz5Gx/1aOQDd8N/adR
         KVS8uXpSkNQAWFVTboAjZ5IWfV51yjpIfDnm4oYlr6XYx6wXrkLTjWKCMZUoEDG/9qJs
         E5BcqD/qN/eQc4R0Z9O+JVsq5crqkasdSZXZWAPB6A0DFZSQdTTyoNJs3v/W+WBtTw9K
         vS68yAZQeWHc+v0UphO3GVBCWdknd4U2X+IbZtZa434tizOYVVUCWh5NLB+xvwJ+zF8v
         2KvQ==
X-Gm-Message-State: APuU4Z8cEIkouy3LSvkVMgtrs/VJdykCJtl8BqlfG/6CaJCc1WZbsxfV
	sltqujtjGQieQPlcs037Jgv57RM+FmoyIsqAs1GvaxY2RssHo+uqFYTZ7L+5l6t1fIaPPZNw9KC
	8dz/1NOmaQ83lHSvguPzbjpPA/qFToNLqf98JZASzjHZRIQwlqGdxBqTCsEtvxvXdIDqHTjID2h
	2u6D8NIxoPam5gsSaRW4z8I2hwnQq3zXjInmSpAewTW83elotbk4Y/uwI=
X-Gm-Gg: AYBFou3lZuAXwgYbHnbriSJhNhgrb1KepgylCxlHAB7kEJQl6qzMrnvB3J50QEDerVf
	z7e3JsONO2t/1/wsYja+xgWTKaOn8ZfV8Q94t7QgyvdbBSqYqs9+DFxihQgPAS5QIARIjj1wn68
	yeoCNAyuKgASdskuZr75BUG89Digy9xNiB8MU/TYDERo6lQRw0A3NPPkQSoQc9iQj7LYISHMhtO
	GqXGPw5KfkUMuMNryxvNjZb5as4WXYFavnsp3nrJVcj5tYFT4YHKYIfqhb/V7aH8p9Bo+7Hv+xp
	6yPiQkmj4i20LQ/LZBhyTFeVdqW8Ry8t1RZMOuHCvD7VzwPBVDXvnETGEaoGLavUpGzq1kjHQ6m
	yIrUXpg+AN1L7bKMCOF4OZQUnhZzieSt3cp4agcdt2/wgakUf/iWpfAlOE550WKVf4J2A/anUHo
	//Yk0Scg==
X-Received: by 2002:a05:620a:1a28:b0:93c:c162:1260 with SMTP id af79cd13be357-945f34fb99amr515984385a.38.1793994228457;
        Fri, 06 Nov 2026 11:43:48 -0800 (PST)
X-Received: by 2002:a05:620a:1a28:b0:93c:c162:1260 with SMTP id af79cd13be357-945f34fb99amr515980685a.38.1793994227806;
        Fri, 06 Nov 2026 11:43:47 -0800 (PST)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945f5a97aa1sm211720085a.8.2026.11.06.11.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:43:47 -0800 (PST)
Date: Fri, 6 Nov 2026 14:43:42 -0500
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v1] rteval: Covering edge cases in multi-stressor support
Message-ID: <au4t5C1-WpgWChOm@sansshar-thinkpadp1gen4i.boston.csb>
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

Added a number of unit and integration tests for edga case coverage
Also added some logic to multi-stressor support to de-duplicate values
and cleans up trailing spaces and commas.

Signed-off-by: Sana Sharma <sansshar@redhat.com>
---
 rteval/modules/loads/stressng.py | 46 ++++++++++++++++++++---
 tests/test_stressng.py           | 64 ++++++++++++++++++++++++++------
 2 files changed, 93 insertions(+), 17 deletions(-)

diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index a3f8d6f..ec59bf9 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -7,14 +7,26 @@ import subprocess
 import signal
 import sys
 import warnings
+import re
 from rteval.modules.loads import CommandLineLoad
 from rteval.Log import Log
 from rteval.systopology import SysTopology
 from rteval.cpulist_utils import CpuList
 from rteval.cpuset import cpuset_preexec
 
+def validate_workers(workers):
+    try:
+        workers_int = int(workers)
+    except:
+        raise TypeError("Invalid stress-ng workers: Needs to be int")
+    if ( workers_int >= 0):
+        return workers
+    else:
+        raise ValueError("Invalid stress-ng workers >=0" )
+
+
 def validate_stressors(stressor_list):
-    """Validate multiple stressor names.
+    """Validate multiple stressor names, cleaning up all formatting anomalies.
 
     Args:
         stressor_list: stressor names to validate, either as a list
@@ -25,20 +37,39 @@ def validate_stressors(stressor_list):
         ValueError: If any stressor is invalid
     """
     valid = get_valid_stressors()
+
+    # Normalize input types safely (handles strings, lists, tuples, or None)
     if isinstance(stressor_list, str):
-        stressor_list = stressor_list.split(",")
-    stressors = [word.strip() for word in stressor_list]
+        raw_items = [stressor_list]
+    elif isinstance(stressor_list, (list, tuple)):
+        raw_items = [str(item) for item in stressor_list if item is not None]
+    else:
+        raw_items = []
+
+    # Aggressively split out any continuous sequence of commas and whitespace
+    stressors = []
+    for item in raw_items:
+        parts = re.split(r'[,\s]+', item)
+        for part in parts:
+            if part:  # Effectively skips empty entries like '', ' ', ','
+                stressors.append(part)
+
+    # de-duplicate stressors
+    stressors = list(dict.fromkeys(stressors))
+
+    # Validate against valid stress-ng options
     invalid = []
     for stressor in stressors:
         if stressor not in valid:
             invalid.append(stressor)
-            continue
 
     if invalid:
         raise ValueError(f"Invalid stress-ng stressors: {', '.join(invalid)}. "
-                        f"Run 'stress-ng --stressors' to see valid options.")
+                         f"Run 'stress-ng --stressors' to see valid options.")
+
     return stressors
 
+
 def get_valid_stressors():
     """Query stress-ng for list of valid stressor names."""
     try:
@@ -68,6 +99,9 @@ class Stressng(CommandLineLoad):
         " Warn if both stressor and stressors are invoked "
         if (self.cfg.stressors is not None and self.cfg.stressor is not None):
             warnings.warn("In cases where stressng-stressor and stressng-stressors are both invoked, rteval will choose only stressors")
+        elif (self.cfg.stressors is None and self.cfg.stressor is None):
+            warnings.warn("Stress-ng will not run as no stressor has been invoked")
+            self._donotrun = True
         " Only run this module if the user specifies an stressor "
         if (hasattr(self.cfg, 'stressors') and self.cfg.stressors is not None):
             self._donotrun = False
@@ -101,7 +135,7 @@ class Stressng(CommandLineLoad):
         # stress-ng is only run if the user specifies an stressor
         self.args = ['stress-ng']
         stressors = validate_stressors(self.cfg.stressors)
-        workers = str(self.cfg.workers)  # defaults to '0'
+        workers = validate_workers(self.cfg.workers)  # defaults to '0'
         for stressor in stressors:
             self.args.extend([f'--{stressor}', workers])
         if self.cfg.timeout is not None:
diff --git a/tests/test_stressng.py b/tests/test_stressng.py
index d854a69..090822a 100644
--- a/tests/test_stressng.py
+++ b/tests/test_stressng.py
@@ -13,6 +13,22 @@ from pathlib import Path
 sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
 from rteval.modules.loads import stressng
 
+class TestValidateWorkers(unittest.TestCase):
+    """Test suite for the function validate_workers"""
+    def test_valid_passes(self):
+        """Test that a valid worker count is accepted"""
+        stressng.validate_workers('3')   # should not raise
+
+    def test_neg_int_fails(self):
+        """Test that a invalid worker count is rejected"""
+        with self.assertRaises(ValueError):
+            stressng.validate_workers('-1')   # should not raise
+
+    def test_non_num_fails(self):
+        """Test that a invalid worker type is rejected"""
+        with self.assertRaises(TypeError):
+             stressng.validate_workers('cpu')   # should not raise
+
 class TestGetValidStressors(unittest.TestCase):
     """Test suite for the function get_valid_stressors"""
 
@@ -41,18 +57,45 @@ class TestValidateStressor(unittest.TestCase):
     """Test suite for the function validate_stressor"""
 
     @patch('rteval.modules.loads.stressng.get_valid_stressors',
-           return_value=['cpu', 'vm'])
+            return_value=['cpu', 'vm'])
     def test_valid_passes(self, _):
         """Test that a valid stressor is accepted"""
         stressng.validate_stressors('cpu, vm')   # should not raise
 
     @patch('rteval.modules.loads.stressng.get_valid_stressors',
            return_value=['cpu', 'vm'])
-    def test_invalid_exits(self, _):
+    def test_patial_invalid_fails(self, _):
+        """Test that a valid stressor is rejected"""
+        with self.assertRaises(ValueError):
+            stressng.validate_stressors('cpu, bogus')   # should raise
+
+    @patch('rteval.modules.loads.stressng.get_valid_stressors',
+           return_value=['cpu', 'vm'])
+    def test_invalid_fails(self, _):
         """Test that an invalid stressor is rejected"""
         with self.assertRaises(ValueError):
             stressng.validate_stressors('bogus')
 
+    @patch('rteval.modules.loads.stressng.get_valid_stressors',
+           return_value=['cpu', 'vm'])
+    def test_multiple_invalid_fails(self, _):
+        """Test that a list of invalid stressors is rejected"""
+        with self.assertRaises(ValueError):
+            stressng.validate_stressors('fake, bogus')
+
+    @patch('rteval.modules.loads.stressng.get_valid_stressors',
+           return_value=['cpu', 'vm'])
+    def test_invalid_case_fails(self, _):
+        """Test that an invalid stressor is rejected"""
+        with self.assertRaises(ValueError):
+            stressng.validate_stressors('CPU, VM')
+
+    @patch('rteval.modules.loads.stressng.get_valid_stressors',
+           return_value=['cpu', 'vm'])
+    def test_extra_comma_passes(self, _):
+        """Test that extra commas are accepted"""
+        stressng.validate_stressors('cpu,vm,,')
+
 
 """Integration Tests for stress_ng stressor functionality"""
 
@@ -91,14 +134,13 @@ class TestSingleStressor(unittest.TestCase):
         assert "stressng: stress-ng --cpu 3 --taskset" in result.stdout
 
     def test_single_with_multi(self):
-        """Tests that passing multiple stressors with the single stressor argument raises a Value Error """
+        """Tests that passing multiple stressors with the single stressor argument works """
         result = subprocess.run(
             ["./rteval-cmd", "--stressng-stressor", "cpu,vm", "--stressng-workers", "3","-d","5","--measurement-module","timerlat"],
             capture_output=True,
             text=True
         )
-        assert result.returncode != 0
-        assert "ValueError: Invalid stress-ng stressors: cpu,vm. Run 'stress-ng --stressors' to see valid options." in result.stderr
+        assert result.returncode == 0
 
     def test_multiple_singles(self):
         """Tests that when multiple single stressors are passed with single arguments the code runs all the stressors """
@@ -108,7 +150,7 @@ class TestSingleStressor(unittest.TestCase):
             text=True
         )
         assert result.returncode == 0
-        assert "stressng: stress-ng --cpu 3 --vm 3 --taskset" in result.stdout
+        assert "stressng: stress-ng --cpu 3 --vm 3" in result.stdout
 
 class TestMultiStressor(unittest.TestCase):
 
@@ -134,24 +176,24 @@ class TestMultiStressor(unittest.TestCase):
         assert "stressng: stress-ng --cpu 0 --taskset" in result.stdout
 
     def test_multi_stressor_default_workers(self):
-        """Tests that the default workers is 0"""
+        """Tests that the default workers is 0 for multi-stressor"""
         result = subprocess.run(
-            ["./rteval-cmd", "--stressng-stressors", "cpu,vm","-d","5","--measurement-module","timerlat"],
+            ["./rteval-cmd", "--stressng-stressors", "cpu, vm","-d","5","--measurement-module","timerlat"],
             capture_output=True,
             text=True
         )
         assert result.returncode == 0
-        assert "stressng: stress-ng --cpu 0 --vm 0 --taskset" in result.stdout
+        assert "stressng: stress-ng --cpu 0 --vm 0" in result.stdout
 
     def test_multi_stressor_set_workers(self):
         """Tests that multiple stressors with a set number of workers passes correctly"""
         result = subprocess.run(
-            ["./rteval-cmd", "--stressng-stressors", "cpu,vm", "--stressng-workers", "2","-d","5","--measurement-module","timerlat"],
+            ["./rteval-cmd", "--stressng-stressors", "cpu, vm","--stressng-workers","2","-d","5","--measurement-module","timerlat"],
             capture_output=True,
             text=True
         )
         assert result.returncode == 0
-        assert "stressng: stress-ng --cpu 2 --vm 2 --taskset" in result.stdout
+        assert "stressng: stress-ng --cpu 2 --vm 2" in result.stdout
 
 class TestWorkloadPrepareCpuset(unittest.TestCase):
     """
-- 
2.55.0

