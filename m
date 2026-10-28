Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211689;
	b=nm1O8V4+7G0Qk4VNoVi5Gyot6KS66jUZTsE38wuGJS1dzPJdmcgVVIUxwTl4mi/tvey0
	 cpPEx0S1lVUphOt5Gf1o1MkZw9vxpNTw8938GhiAiorcitidXFtvCrLOjIHXxKqYqcc+3
	 DBkCqpPCCmqX40dY07Q4JDmn7ZYT9au0WPgNCl9yymWgxij4HMopWaq3recvCsfC1ET6V
	 Wld7XHKk98rPBRznuRahvXba8wzbpRf9dmmXf1DEQNCRPd+s/rgBS1LeavGSbQCfGlAfR
	 qoycwayEVsnGktXCbkaJ+cNpuXzVIVghYAIQK0opQI1BIKUCEsr2qLfX/dkWZOmkwQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211689;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=quBec+SEg0zWygF6OwyCsVBCnhl7fjng1h6QeupMzC0=;
	b=Vyi7sHyz4s1+XkQ+LKSY1Pen3vq+SKU/fPZVqaZqMo8Fo6YWqYRz45mvwN/NFD36AOlC
	 vbLoCTim6X5cK/9opML61E5tMoGnmb/1CiXVoL/I1AdFyOFjLiyf2Wu6vv9ajzzqZ2KxD
	 //00P4pstdakTqtF9DybT7PYOqoXnMJr3ndtaTTepYrFyjGN55pvOyvA4VOdSqg0AX5L1
	 YjAwSqUG3NNPr1ILVn2qiv2KnBn+gdI42jy7TpswNO6nl1nv8DqdkPA90h3mhKjgxPv4k
	 WPCXdp6yzGtrh+aDf3mI1rV/uavvpA8fKc+HnMiuHyBRyK0l3n2EO1EDLvZQu0tHNgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ix8PdgUA;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lZcy+4rS;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA4A606A322
	for <linux-rt-users@vger.kernel.org>; Wed, 28 Oct 2026 18:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FA4A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ix8PdgUA;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lZcy+4rS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793211687;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=quBec+SEg0zWygF6OwyCsVBCnhl7fjng1h6QeupMzC0=;
	b=Ix8PdgUAZLtxN3GjgJVK8bAuLxM6p16XI38JC0b+TqrQ9h0k0wAYaMe1n8iNHzbwRrOEBM
	iaH462EVt9Oq04yPp2ecjF9fzkQ7XksY2H7CF1rJW/ilxzMmXlUH6J0ruJBI0hKFubiSzX
	DPi3RLzyFRW1At6GxN8uSWBNfIFQMXs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-0jONRP4QO961ZxVX12inig-1; Wed, 28 Oct 2026 14:21:20 -0400
X-MC-Unique: 0jONRP4QO961ZxVX12inig-1
X-Mimecast-MFC-AGG-ID: 0jONRP4QO961ZxVX12inig_1793211679
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-917baea8e5dso24002126d6.3
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Oct 2026 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793211679; x=1793816479; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=quBec+SEg0zWygF6OwyCsVBCnhl7fjng1h6QeupMzC0=;
        b=lZcy+4rSaqMvew/ZhP9BuUQlpxiIdOJ8st9XcDglezEcIJQYbKr4Z598wFl/sTdrB7
         7E/hEaTNj5ioRklBUTHklGHyN5J/PSsYQIAqQ/9E6EsXUVgFPv2ipXBdNJU6pe1XyoI8
         eqDzQ7PG0/9yZimUsNpFQkwXn/ZruYAOuQGygyunkudaXpqSeb4oorlhxDDtAD1JlMEc
         BzSlNcfjufTBIfI+AYLpSZMjc6/f6+ux6JpFPtqXBywDij3J4gpZw0dNY1J28NeHy7HN
         w7o0V6ecT3QqPd5i2rlsXNA2oKa++QKiv43dIn5R53UhlLdInNmTUF4qX3pcQmyXXW3D
         GyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793211679; x=1793816479;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=quBec+SEg0zWygF6OwyCsVBCnhl7fjng1h6QeupMzC0=;
        b=DYDdr4HI9WkoablZcSI9oN6C7Ny+IKfY4stHyOZK0jjAQKQ5Z8brYLrsuiBBFsUchF
         YuKbe+vcaWcUhYRYGxvD/Mei7y/kOPfsuLisxtGBDlWfBy1TMaA88UIvFRQDcNeYQcDp
         r0VvttWLYtC/SYo4X22oFh5o2wksBRVt79kco/avlRCt7o9CzEex1Me3WriR7UHtp0zn
         hYL/KWK38+XkYiHJUsujRsFIPhjbxWOUc0f4TdoqMEW7Mx/pBKHk7OB98FEZiua2CWOZ
         RhUb/Ui0FggNdTrYmVFEWypemlsxHQ3kOjHoiNCGdTWFzFSuSmQ4GUUjvfb0Xhhi5lOS
         n2YA==
X-Gm-Message-State: AFq9FYLQr8uhThoJWgBNjZS5Fv9amzUbySOzidia9NO5UGy3/s3IXZuJ
	e+IbyCM8yUD4eZa+LCVeH4Gb+nBcF50y9ulvd94LphYn2rfRbOt5uPyYUwwq5Eo7KLD/xLs25Mu
	mYmlLfd/P0jCNGznl5oksz2amk2E1mtXIqI86npXksU/tZMiaHK+Y05swoedPlaDc0qBqcHBWEe
	+EkVsYqfUzItrBxK2K6EcQpX1CGCe5lcwcJ+0ok98MSP1tvXe5fguD5rw=
X-Gm-Gg: AYBFou3Gkur7uDVuheQy7ogHrIfEGFoowzk/Tv//7okFFT799CvlwR1d68MxurIgYS3
	qBklnYpr2mm8O17bCgDA5C4LqzmXu6OsYao/4/9ZaETN6Drrvc6W0igxfYC23fMqfBCgOtKha3Z
	YRy5BPSnLH8xZ2kXTPqFz9vdAp5jxTxuQFyB68wK2Vlch1a0YWNmdGUGBy53Ix3TViD7mfqNJnN
	YKcdiG5plT7UDI2feazKplPqnJKxQ+0sODrigWksnMlLliZDWerFZi+9qHs8s0JVHoHSXxxTta2
	QH8Flg+XeZtDlDx1FxjHlrAaFjS/wAt5kZD+eDtCgA9EIV2ov/NBQuNVUYksYaCalUcYZMNa/fK
	EyF/VJXpyLUbzr8QlEicbFBI2MqUuJvFmAqhaJ2uWw2+BgaTGQfvCcqXe6KWwCwq+PxXC2mXDoU
	+/kQFvlSQ=
X-Received: by 2002:a05:622a:1c0e:b0:535:84e7:5a76 with SMTP id d75a77b69052e-53fcc9bbebemr57702831cf.59.1793211679232;
        Wed, 28 Oct 2026 11:21:19 -0700 (PDT)
X-Received: by 2002:a05:622a:1c0e:b0:535:84e7:5a76 with SMTP id d75a77b69052e-53fcc9bbebemr57702341cf.59.1793211678511;
        Wed, 28 Oct 2026 11:21:18 -0700 (PDT)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394f7cdfsm111372191cf.10.2026.10.28.11.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:21:18 -0700 (PDT)
Date: Wed, 28 Oct 2026 14:21:13 -0400
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v2] rteval: Fixed hardcoded paths in class
 TestCpusetManagerCLIIntegration
Message-ID: <auI9GfqN-g0YtJhD@fedora>
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
Changes since v1: Fixed assumption that the repo will be named
rteval.

 tests/test_cpusetmanager.py | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tests/test_cpusetmanager.py b/tests/test_cpusetmanager.py
index 3f1c4b4..1f9789a 100644
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
 
+    srcdir = str(Path(__file__).resolve().parent.parent)
+
     def setUp(self):
         """Clean up before each test"""
         try:
@@ -226,7 +228,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_housekeeping_isolated_requires_cpusets(self):
         """Test that --housekeeping-isolated requires --cpusets"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd',
+            [sys.executable,  f"{self.srcdir}/rteval-cmd",
              '--housekeeping', '0-1', '--housekeeping-isolated',
              '--duration', '1', '--onlyload'],
             capture_output=True,
@@ -241,7 +243,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_measurement_member_requires_cpusets(self):
         """Test that --measurement-member requires --cpusets"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd',
+            [sys.executable,  f"{self.srcdir}/rteval-cmd",
              '--measurement-member',
              '--duration', '1', '--onlyload'],
             capture_output=True,
@@ -256,7 +258,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_measurement_member_help_text(self):
         """Test that --measurement-member appears in help"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd', '--help'],
+            [sys.executable,  f"{self.srcdir}/rteval-cmd", '--help'],
             capture_output=True,
             text=True
         )
@@ -270,7 +272,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_loads_cpuset_requires_cpusets(self):
         """Test that --loads-cpuset requires --cpusets"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd',
+            [sys.executable,  f"{self.srcdir}/rteval-cmd",
              '--loads-cpuset',
              '--duration', '1', '--onlyload'],
             capture_output=True,
@@ -285,7 +287,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_loads_cpuset_help_text(self):
         """Test that --loads-cpuset appears in help"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd', '--help'],
+            [sys.executable,  f"{self.srcdir}/rteval-cmd", '--help'],
             capture_output=True,
             text=True
         )
@@ -299,7 +301,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_housekeeping_isolated_requires_housekeeping(self):
         """Test that --housekeeping-isolated requires --housekeeping"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd',
+            [sys.executable,  f"{self.srcdir}/rteval-cmd",
              '--cpusets', '--housekeeping-isolated',
              '--duration', '1', '--onlyload'],
             capture_output=True,
@@ -314,7 +316,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_housekeeping_isolated_help_text(self):
         """Test that --housekeeping-isolated appears in help"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd', '--help'],
+            [sys.executable,  f"{self.srcdir}/rteval-cmd", '--help'],
             capture_output=True,
             text=True
         )
@@ -328,7 +330,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_housekeeping_help_text_accuracy(self):
         """Test that --housekeeping help text is accurate (no longer says 'isolated CPUs')"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd', '--help'],
+            [sys.executable,  f"{self.srcdir}/rteval-cmd", '--help'],
             capture_output=True,
             text=True
         )
-- 
2.54.0


-- 
Sana Sharma <sansshar@redhat.com>

