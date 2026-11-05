Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906344;
	b=mGjgz638pC8XvzmnHVwwxS8BKWGbouA64t0ewUDDmZxStuYcF+LGSTn/+xiF6+T/UR/5
	 37eVx1c8eTqALdsHTzvjcph3cS4jcLjxa2p1A5rFboHPq5+qCg+a3URLEEQKvkr9DWthj
	 MHqpHrevq45s4bpE+Bjn1Qq5rD60Eh8Q0tv+TFhFDJody/wDNsiV+jn5kyOuFKU0UyEPr
	 Z9bdd/M5q3omZ+RTC7X9+MBcXvK+rtXCuN0PjmFGJrAaEj2aRADSWLDz9tCJnu4mm0ZqJ
	 w6/V9EZl0afabwCskVMV+5din9NE2g1TUB3dmfiJMn9P54670I3FV3ZrYen3JhAEOsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906344;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=sCP9OVvGuR6l2KfTzs6YZOIcb6kM3priKNdcZ14AZ3U=;
	b=2ezDHm/UuU5ilTCHdhnvrGac9HF5OA3P0dJ+G/gRVtLJshQ/RfiQxS4Sm2v0GMI11HBo
	 CO10/Lx5fOtTrd00wFRN+NeJ5jMFgyO1A6cpAD+xShhnRWnH4muHNlrX4SVe835uvlONw
	 RrIvpxW40BqYLHxqYOh27ZoIr2QEH1M1eLA8tmCx8+O7eN898jtUkNlcLRw3WMkZRe8sr
	 dmZWv31Z3NJRVZsmVSHFgOzPM6OGqOYGZ7gBBG2Sb7DC2LyvjwAN1tnG6T6StXmSqnoRq
	 TS127EsmAXmdf9FPkD9mOfHhL/yfoxCwhHDUEB57xI/bUz6m6Yi6xxfL8J/WllpIsAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cG6tjOB8;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=a3bVHTfo;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4762B606A31B
	for <linux-rt-users@vger.kernel.org>; Thu,  5 Nov 2026 19:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4762B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cG6tjOB8;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=a3bVHTfo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793906343;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=sCP9OVvGuR6l2KfTzs6YZOIcb6kM3priKNdcZ14AZ3U=;
	b=cG6tjOB85tYjHHqTTq4iknWcwjrzkI+uTvuzjnO1J7bTgxxNB20Z4wgHBZ+/sROhR8Xifj
	9KZYYMbhbWZMgUunq+I6HnI6hQyxQGZFmDelGScKiUT/3dWZPKBbkfGy1+70PWgZvFpLpB
	2ojqIhD16OXAxmSi7aPsvqAtBGa6DW0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-4ypiowpjOFq88dlnL0otXQ-1; Thu, 05 Nov 2026 14:19:01 -0500
X-MC-Unique: 4ypiowpjOFq88dlnL0otXQ-1
X-Mimecast-MFC-AGG-ID: 4ypiowpjOFq88dlnL0otXQ_1793906341
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b18d691d54so40089157b3.3
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Nov 2026 11:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793906341; x=1794511141; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sCP9OVvGuR6l2KfTzs6YZOIcb6kM3priKNdcZ14AZ3U=;
        b=a3bVHTfoDInZDc6M3dGD6BFEqy+dFFlZ09iSMPRDp7A3EH/7rSyFG17RniG/O5Bbbl
         WnjYotcEfc6YlUFuvVuyMTPverUIbAlDyabGzITnuL0tKJ+wp6Ib18vbkxWdOvwP/D01
         /E05gFK5/Yo3fKqHSfHnQFb4nJPmN7/Ijj//M3xGj8wWU1iQNHwOhQ4NjWLCjZhi7Ti8
         9hif5r3/0db7dUvyCiE/uB+NP8dOAPoG0VbUW00/E3Vitzk4/gNdQ1Nr62x+kIbLv1PS
         0dQ8j3ufyhqUr6Ei4X04KPcmsIka1nyjBcYNf3ByEuH10IX+WPz50EVoE/pn0+elm9Bs
         +LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793906341; x=1794511141;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sCP9OVvGuR6l2KfTzs6YZOIcb6kM3priKNdcZ14AZ3U=;
        b=SWm7bivuUYv3y1sZVpJ1jG6AMnsxN1uir8abtCaq2B6WghBVbY9HgLabYHsy0nvv3y
         bcegdCjvUF9++EGReQ0XDyFyZL28fb+Ti0cYZ3qbFx+DS6ewlO85ljCG32KFpUIDHdsY
         hCYo2rNd+8y4UfyIQsNm8LhuBb8vXcTFi8cDDPOKx0AHlf8jnNE0ZPHVHP5WceJ9lzPY
         nV9MAuhEHn5XM1RkZ2QmubA3bzoNVxGJ3JJL8dc/SZx6moMSAnE/lTmGyTsoCXn7Vgxa
         8mvcypjFSCD1DpeDs18Bhh4VmQgLND882PC31O8WQCiYoMdT8Z2LM0NdGCGaQSoxpqBq
         G6FA==
X-Gm-Message-State: APuU4Z84BB7ph3qJ55zDbVGhn1M504L3ADoHTxPtLzrC935nTnAZ6qzP
	hBUZS/yHEFSIddRnH0HXE3QG1faVIIsN4bRG8id7c33iZM5drSW9aiRlar2QuH4tzlxq4/RenL3
	OypoXazRUq6jQPbHJbxUwiIdtVFQPw/OWVjIjowPOhN6zyetIBddjQYi4gVaAig9Ag16spzWNbx
	RDvSzuEBgF2y0K8dMik66p+F2cVF4g4cuHlg43KgkNHfgNcEeNA6+1pGo=
X-Gm-Gg: AYBFou2MKB8GN1UBy3F1KercbR9STBubS0OPrdzj2Ubs2JXQYQ6FNqACJgvniG7ApW7
	tOZHIaenWvNjz+cBFNfyRyDoDa3JfleHUfEhc5ye9tij9FX26vB5bA0FlaDq+qMUMn8RbJjtF4M
	N6Hafb+WWHOS1KR6dVczbNhgMjwUvaXvuKrgmszQQVdSdZ2nb/FXqtr6yTZaalXdun1eXBugcsR
	ekzl4wJfkXK1RoJRcX2P9cFs2zqFtmkFmivWN+wyfSbaRYNUw6Pzx8WCxtYN0jEtat70zOzl01Y
	+b1ciTthgz0yL0xLxCM1HH9/p5bUH+SvbOHXvW6uGi1bYIMFS1yUan4YU/yUWbMZtLOBEFqkT22
	QejbPrH1h65JlUin2qOCZQmSWMk/9jfQg8tPbiYAIXo/KfFBjb3zTCe+lETZ/9PSzMnTiL/KuQl
	y6k8bnnQ==
X-Received: by 2002:a05:690c:dd4:b0:8b0:a37a:b1d with SMTP id 00721157ae682-8b2b66fb17amr120752297b3.24.1793906341135;
        Thu, 05 Nov 2026 11:19:01 -0800 (PST)
X-Received: by 2002:a05:690c:dd4:b0:8b0:a37a:b1d with SMTP id 00721157ae682-8b2b66fb17amr120752227b3.24.1793906340569;
        Thu, 05 Nov 2026 11:19:00 -0800 (PST)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f770cc6sm2266287b3.9.2026.11.05.11.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:19:00 -0800 (PST)
Date: Thu, 5 Nov 2026 14:18:59 -0500
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v3] rteval: Fixed hardcoded paths in class
 TestCpusetManagerCLIIntegration
Message-ID: <auzWo66c2JavzMBW@sansshar-thinkpadp1gen4i.boston.csb>
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
Since v2, the spacing error has been fixed and the srcdir has een
changes so that its defined only once.

 tests/test_cpusetmanager.py | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tests/test_cpusetmanager.py b/tests/test_cpusetmanager.py
index 3f1c4b4..3da042d 100644
--- a/tests/test_cpusetmanager.py
+++ b/tests/test_cpusetmanager.py
@@ -13,10 +13,11 @@ import os
 import sys
 import subprocess
 import tempfile
+from pathlib import Path
 
 # Add parent directory to path for imports
-sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
-
+srcdir = str(Path(__file__).resolve().parent.parent)
+sys.path.insert(0, srcdir)
 from rteval.cpusetmanager import CpusetManager
 from rteval import cpuset
 from rteval.Log import Log
@@ -209,6 +210,8 @@ class TestCpusetManagerHousekeepingPartitions(unittest.TestCase):
 class TestCpusetManagerCLIIntegration(unittest.TestCase):
     """Test rteval-cmd integration with --housekeeping-isolated"""
 
+    srcdir = str(Path(__file__).resolve().parent.parent)
+
     def setUp(self):
         """Clean up before each test"""
         try:
@@ -226,7 +229,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_housekeeping_isolated_requires_cpusets(self):
         """Test that --housekeeping-isolated requires --cpusets"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd',
+            [sys.executable, f"{self.srcdir}/rteval-cmd",
              '--housekeeping', '0-1', '--housekeeping-isolated',
              '--duration', '1', '--onlyload'],
             capture_output=True,
@@ -241,7 +244,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_measurement_member_requires_cpusets(self):
         """Test that --measurement-member requires --cpusets"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd',
+            [sys.executable, f"{self.srcdir}/rteval-cmd",
              '--measurement-member',
              '--duration', '1', '--onlyload'],
             capture_output=True,
@@ -256,7 +259,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_measurement_member_help_text(self):
         """Test that --measurement-member appears in help"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd', '--help'],
+            [sys.executable, f"{self.srcdir}/rteval-cmd", '--help'],
             capture_output=True,
             text=True
         )
@@ -270,7 +273,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_loads_cpuset_requires_cpusets(self):
         """Test that --loads-cpuset requires --cpusets"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd',
+            [sys.executable, f"{self.srcdir}/rteval-cmd",
              '--loads-cpuset',
              '--duration', '1', '--onlyload'],
             capture_output=True,
@@ -285,7 +288,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_loads_cpuset_help_text(self):
         """Test that --loads-cpuset appears in help"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd', '--help'],
+            [sys.executable, f"{self.srcdir}/rteval-cmd", '--help'],
             capture_output=True,
             text=True
         )
@@ -299,7 +302,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_housekeeping_isolated_requires_housekeeping(self):
         """Test that --housekeeping-isolated requires --housekeeping"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd',
+            [sys.executable, f"{self.srcdir}/rteval-cmd",
              '--cpusets', '--housekeeping-isolated',
              '--duration', '1', '--onlyload'],
             capture_output=True,
@@ -314,7 +317,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_housekeeping_isolated_help_text(self):
         """Test that --housekeeping-isolated appears in help"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd', '--help'],
+            [sys.executable, f"{self.srcdir}/rteval-cmd", '--help'],
             capture_output=True,
             text=True
         )
@@ -328,7 +331,7 @@ class TestCpusetManagerCLIIntegration(unittest.TestCase):
     def test_housekeeping_help_text_accuracy(self):
         """Test that --housekeeping help text is accurate (no longer says 'isolated CPUs')"""
         result = subprocess.run(
-            [sys.executable, '/home/jkacur/src/rteval/rteval-cmd', '--help'],
+            [sys.executable, f"{self.srcdir}/rteval-cmd", '--help'],
             capture_output=True,
             text=True
         )
-- 
2.55.0

