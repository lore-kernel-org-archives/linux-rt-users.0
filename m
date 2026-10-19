Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442809;
	b=lGv9AO4EdMya109ZtmPh05SfjoIBUq+UI6xVsqfVK0czb4TaVsJO4PzaRlq0jiFLYZcf
	 AFwqgIDcx+HppfYzqU9yLqAJIfOlKefFFv3h+NQVY2hmkFHD+ffk7Fdl1p5/XNwPW431A
	 KxpDQ219Y9w7K8TTqRQzYZ0caUtY3ZxX6nrBRHLS0ta9nYejTMTRAd1qtxJqfMpbGVpLb
	 BXyO4gJlCW4WZUF3an3FoXgnIfo2dbGVfvwxJNsEADCKpqEuwaM0R5jB7cXXxdjHwdrVm
	 us0aMGMIZtmJAtroqhUFNjLhbHGBZ0jwE1g5yBsikGv0FfGjknp9YdqKG2SSte8MHPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442809;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=bM20uSiTHrKKMY3I/NFfosSQOn3laT2wHvTED4Cf/Us=;
	b=lBzto3d48dsTTf3AOX0HlEB3zmPvzoOh3YQUshoOS3DWhqRLbiJCF3ZA8n8k3WzXDK2q
	 bPlUDxEXqkn6ttYH617DUQVf9I9h+p8x89S5JPwp4iInFe3lvKhc7CAGrCqisrnT+ZTGy
	 3B0JY4QI5dQwl4/Tif5XDX4YDeva/UWPZEtSHFAbOkSvBkC+FzcHzR6393KcIaDm0QT9v
	 +U+zCttYWupwiz6ARgLqSupMEfSxzn06B7XtzsUNEJaoY4CZMSV9Uz+iII16QuwMpkOx/
	 6iL2H1MjYiE6XhwWJ1ASi0jHSLZFucue2QC5YAT1wtNvi/j/qCqlWV+KPvc9F8grMEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eiBLZF2T;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MnKPhF+R;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A11C606A31E
	for <linux-rt-users@vger.kernel.org>; Mon, 19 Oct 2026 20:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A11C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eiBLZF2T;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MnKPhF+R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792442808;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=bM20uSiTHrKKMY3I/NFfosSQOn3laT2wHvTED4Cf/Us=;
	b=eiBLZF2TBeB9swCtQbpGtybFm6vxCluciyoNGboE/Lo2oIQT3bYpV8zFvxEvoBWDjwLqvI
	Nz7dFznj0n0DLsoJ90ADpShI4cfuwQPa067akVaU3HWGB89dlqLc9wGwypTOKj8ifzFh6w
	nqIak4919X4CGYNLfrLPWyAk4oavaT0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-EHIa_ARMNmOY0Wa_QOt1Hg-1; Mon, 19 Oct 2026 20:46:46 +0000
X-MC-Unique: EHIa_ARMNmOY0Wa_QOt1Hg-1
X-Mimecast-MFC-AGG-ID: EHIa_ARMNmOY0Wa_QOt1Hg_1792442806
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5363b06bcb2so64261411cf.2
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Oct 2026 13:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792442806; x=1793047606; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bM20uSiTHrKKMY3I/NFfosSQOn3laT2wHvTED4Cf/Us=;
        b=MnKPhF+RYyKr3UhMtzlbWSWwWKzMKkzSSOoNTioyamGfHmzYh42sycnpaLz03J9YD0
         LTuZZCiGA0fjI+lt9+L0ouz0TBHjPUH+jqiPpj5ZGvLEQwpFaj0225Snq94rjwOpia9i
         Iqlmh7SV6RYYpHKcB3ke+XgQNZyi1PDyK/rNON1c9OTIsilSvS41SP/Pl7+s9GealQv0
         3f+vQrdt8saVoZdn++MV3FoO5kb6f313LonhuQL55gM+USg8kmEpFB+EURnUQkHNAzWn
         Qn+SDcd62jBFpmsJ8DQxCwUoXOUy2YRA5fqEcj6taj+HXRrbRMZgB1l6YUjACZuPXLEj
         JeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792442806; x=1793047606;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bM20uSiTHrKKMY3I/NFfosSQOn3laT2wHvTED4Cf/Us=;
        b=KQdu0iFNrK+b8p6sp096o8EQXz563NlyWlHE4LFE9fY747w3XED1kv0+dv7OlXGKkB
         SK9KrzNjdvRjsxxPvCGp0GjtCrnJowLr9duCVfH3TmNGewbPRRoJiEAr4CncggDSY7Is
         qPFE8EdyMHh9Hcljvww5oFQ3jrKqTHGcNeCDd/JAgZVzfgx7JJ8qEJ8Bjja1b8P3Pxfp
         /U4wooBnBY1a2PNkBDi1lJfYylsh6M4Qy3EsC2qVp223GHQq08VnrqsmCYDU5753V0Ye
         mC4YhoHiKPQXJHKdQseWhCK/XQU6adA8VirbO3NjlMov8gw+jL/EwacECsX36IHWO6tG
         QK+w==
X-Gm-Message-State: AFq9FYLw0OsKjCkmi7OvpQEGA2RJfQMbECAU1HGDvTgUTXQwCPYBv67R
	WN03jb4xofxxSwqKyaqbQKRGylGpT9iG+n/wCGfM6xvAeQk8Xg+Cqn0eV2bQW6V4dYyvau87ayQ
	326MCrUjUXpF9MjrWkdCqie38IVCSGgJztuXVhdCbYd4DNuRYpUMvsfCvLTYAF38anGaeckhzDe
	gv0JRkKsjdGOhLcRsNmj9rcyorM46y5cDUGO4tf+rkicJiQJv7nLQi
X-Gm-Gg: AYBFou0uR2wdIpr3PZ76tWefaEkpeZ55Nrm77AIxxAm0j8eOi5DqdXNCPA6h8qU3UKJ
	Dlv+mJ0Cyy+46aIKW1Fk0Sxgq5r5Jf5jGoB8wZ5ZVusaMeUd+Wk4jv56+oNuRDdJVIH3uI8GyCf
	j8VqyOEM/vBLN/U+rYan/nnHYlLIIIIz9+o9KVcItGIlSBjFzhcDm/0I0bbwIvB19cgDw2NXL5P
	wD/E9VwmQA2hy1lVLi2UhQ7pYPhI2zih0C51xpGxVc9EclcXq6BcgYYtKokDFzPrWiKWJJxx8RY
	bOHX1bSm8Rvc83XAJN6sESeivNdCvYyrKcD3i5WA0UjCrTaceLzApN2tQFBJx+Ib2aMchc9yymh
	z+NzShC0jZuqh8KTFwtr5Bx1a/PNJjhVG9A==
X-Received: by 2002:a05:622a:2293:b0:535:a5fc:3b55 with SMTP id d75a77b69052e-53646037941mr134532691cf.65.1792442806213;
        Mon, 19 Oct 2026 13:46:46 -0700 (PDT)
X-Received: by 2002:a05:622a:2293:b0:535:a5fc:3b55 with SMTP id d75a77b69052e-53646037941mr134532261cf.65.1792442805459;
        Mon, 19 Oct 2026 13:46:45 -0700 (PDT)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c040cff98sm5829676d6.33.2026.10.19.13.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:46:44 -0700 (PDT)
Date: Mon, 19 Oct 2026 16:46:40 -0400
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v1] rteval: Fixed hardcoded paths in class
 TestCpusetManagerCLIIntegration
Message-ID: <ataBsDgEsnq-WTfe@fedora>
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

This patch makes 2 changes to the tests/test_cpusetmanager.py file
1. The hardcoded paths introduced in commit 6227294897b7 ("rteval:
Add --housekeeping-isolated flag") have been made generic
2. The os.path.dirname invocation has been replaced with a more
modern pathlib module since I was importing it for the fix.

Signed-off-by: Sana Sharma <sansshar@redhat.com>
---
 tests/test_cpusetmanager.py | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tests/test_cpusetmanager.py b/tests/test_cpusetmanager.py
index 3f1c4b4..f3f8c55 100644
--- a/tests/test_cpusetmanager.py
+++ b/tests/test_cpusetmanager.py
@@ -13,10 +13,10 @@ import os
 import sys
 import subprocess
 import tempfile
+from pathlib import Path
 
 # Add parent directory to path for imports
-sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
-
+sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
 from rteval.cpusetmanager import CpusetManager
 from rteval import cpuset
 from rteval.Log import Log
@@ -209,6 +209,8 @@ class TestCpusetManagerHousekeepingPartitions(unittest.TestCase):
 class TestCpusetManagerCLIIntegration(unittest.TestCase):
     """Test rteval-cmd integration with --housekeeping-isolated"""
 
+    srcdir = str(Path(__file__).resolve().parent.parent.parent)
+
     def setUp(self):
         """Clean up before each test"""
         try:
@@ -226,7 +228,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_housekeeping_isolated_requires_cpusets(self):
         """Test that --housekeeping-isolated requires --cpusets"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd',
+            [sys.executable,  f"{self.srcdir}/rteval/rteval-cmd",
              '--housekeeping', '0-1', '--housekeeping-isolated',
              '--duration', '1', '--onlyload'],
             capture_output=True,
@@ -241,7 +243,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_measurement_member_requires_cpusets(self):
         """Test that --measurement-member requires --cpusets"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd',
+            [sys.executable,  f"{self.srcdir}/rteval/rteval-cmd",
              '--measurement-member',
              '--duration', '1', '--onlyload'],
             capture_output=True,
@@ -256,7 +258,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_measurement_member_help_text(self):
         """Test that --measurement-member appears in help"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd', '--help'],
+            [sys.executable,  f"{self.srcdir}/rteval/rteval-cmd", '--help'],
             capture_output=True,
             text=True
         )
@@ -270,7 +272,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_loads_cpuset_requires_cpusets(self):
         """Test that --loads-cpuset requires --cpusets"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd',
+            [sys.executable,  f"{self.srcdir}/rteval/rteval-cmd",
              '--loads-cpuset',
              '--duration', '1', '--onlyload'],
             capture_output=True,
@@ -285,7 +287,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_loads_cpuset_help_text(self):
         """Test that --loads-cpuset appears in help"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd', '--help'],
+            [sys.executable,  f"{self.srcdir}/rteval/rteval-cmd", '--help'],
             capture_output=True,
             text=True
         )
@@ -299,7 +301,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_housekeeping_isolated_requires_housekeeping(self):
         """Test that --housekeeping-isolated requires --housekeeping"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd',
+            [sys.executable,  f"{self.srcdir}/rteval/rteval-cmd",
              '--cpusets', '--housekeeping-isolated',
              '--duration', '1', '--onlyload'],
             capture_output=True,
@@ -314,7 +316,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_housekeeping_isolated_help_text(self):
         """Test that --housekeeping-isolated appears in help"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd', '--help'],
+            [sys.executable,  f"{self.srcdir}/rteval/rteval-cmd", '--help'],
             capture_output=True,
             text=True
         )
@@ -328,7 +330,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_housekeeping_help_text_accuracy(self):
         """Test that --housekeeping help text is accurate (no longer says 'isolated CPUs')"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd', '--help'],
+            [sys.executable,  f"{self.srcdir}/rteval/rteval-cmd", '--help'],
             capture_output=True,
             text=True
         )
-- 
2.54.0


-- 
Sana Sharma <sansshar@redhat.com>

