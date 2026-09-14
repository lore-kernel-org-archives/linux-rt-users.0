Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA59A3C1D63
	for <linux-rt-users@vger.kernel.org>; Mon, 14 Sep 2026 19:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789414478; cv=none; b=c6H7KPY+HODsK36HEgjeExowbwjdefk+hSDd59Ye379bzAZkLW2KhQh3LDNldbB+oiP3cdk4s0fU7KSsMUOmnaTIBP1H9pkAWZ+AfptdFFbJPsK6KJ9ylEmEkkN2WDl4lVomQNiJ3zchfTH3E0GEuQ51ps5cOp+nuU9mo62AuFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789414478; c=relaxed/simple;
	bh=JTzZv1w//4GYCisWzyZ/1eHvFAgAa+vR2CeoXE1sXWY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OYoHgfQBVcVxrsl5QwleEsQdyTAK8TSoxARqaPiL9KCGWH7cy/8qf1pmSD8Ee9rYQAG81oOPJm6yZVMuf3BJ95+sXf6WF51HKaSJt6ukUuJBbwdbYbdfmzgrHUjIh7ObryBsEpBznG2X1vgxJW1y2EryCMFAfRgRrv51N8eqQr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xyk8Ndrr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aReXtfM5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xyk8Ndrr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aReXtfM5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789414475;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=YEqq/8XQ28oktgG5rt4XCqy6t+2Jh+5tZtOFRmfdctE=;
	b=Xyk8NdrrW+O3OJbn1TOslni0WZwc50raHjbd4ns4M/qcTQ6Ogn0VIaPNBJ6I17SYHImplc
	w3ePv95vUFLCs1TkfZiUz1v7VeSeOHHn3aSkxY3d/xWwRdQmUcmo4r5U+cZo437RDisJ9j
	zmTnCB9MhEolY29fwighPUl6eHMHVkM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-VQfCJSiANiSr6NkxIXn1HA-1; Mon, 14 Sep 2026 15:34:34 -0400
X-MC-Unique: VQfCJSiANiSr6NkxIXn1HA-1
X-Mimecast-MFC-AGG-ID: VQfCJSiANiSr6NkxIXn1HA_1789414473
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51a8b0a08d2so69563851cf.0
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Sep 2026 12:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789414473; x=1790019273; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YEqq/8XQ28oktgG5rt4XCqy6t+2Jh+5tZtOFRmfdctE=;
        b=aReXtfM5JzYyj3lLrU3EWcJ/YExM/3MonNK2AV74hypaFIT2MsM11SUXGM3v7YG/HU
         CZC5LiZFOyvGeQmDMkatUWC13nJRcPb3CwU2NGNsLcrnjhWR9Gwv0Z3I7bojuSD/nMxW
         S3MkzOUZJkGHyOoWCUkJDkM4k/+Tp/I4/LDG1p20dfvYtO7lbn3nPFWGMXJXKtb+A0aT
         mQhEn744wIArbUeZ24hoXfaD6659BEqd+0/v50INBKjDvw7E5w10SX4xhkxWhRmY+gUg
         nyDWFk4LX8IqO7+/MI9AdLhNLOh6b5HDiym3z5pJKrTP7BxbbjvpYSv4Vvo3OG4iBhNL
         e6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789414473; x=1790019273;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YEqq/8XQ28oktgG5rt4XCqy6t+2Jh+5tZtOFRmfdctE=;
        b=fxBbpcmhhI9jsVYev8l4sFjh9wHe4WZL4IOZp8D8+9/8n3/p3b47hNrimvXqtZZMXP
         Jzthv5+YlHiJVt13tjs3uRtfTbVQyiZ4e8MTFwZBP1NM+hkWoNzt3qfqNJDeBEObeUYp
         WMKFKxqoU+IHgbJjfDwlCs5PyyHlaf8AJaIQ4Bu8V9ZCVVZbjFvT+bCp1rIs+pvHKbOX
         0igMNW5n4zJLTcHqnpJ8NxwxaLla6fuSyC6a1i+y5M2MzXSk2aRd7ZvoOsB7WdY9BHDu
         LgMAazb17VPWM6t99BKT9Z13GchprVJq/VwOKjAOQJnGPj8A1qjitCrleC+npd7QyIQV
         weZg==
X-Gm-Message-State: AFuF++muUKNJ7TdK1/YZhuzua/etHxaFfCyxkO7tU5ooJXstkuDHnrUa
	RpncrkurcaeNRhYqaUMXqs6jDUHEzhYUVA+SJG14UV8OXMqCnGe5j0mdHu7kOyaDPAtlVxX60b1
	FP6pUYf4DujOwKe6soDjwWsFyvVAtbFGTh5IAxwH7eYRY0eFyNb0ix+iFXGFh47EHHmkq3Qigt5
	ci5S3r7TN3OmmyAkVmQC5mSPixgPKsWS7We9G5Zr13/my1IYFpa9Qb
X-Gm-Gg: AYBFou3XU3Nqf6YQiZdtKhoHfgx98uPPQvDz0BY6OgUBWPh2ZPKIJpwglIGRrXbYGyP
	yPXsmgh5zM7IywEf/L6bsHA/fI/zEb3kryOLHlmOa1Xd47W0xPezzwX4Bh3bO5rITYxXUlSolKe
	1DbaVPOVqwvRIGafM1D+7bKALh0AST/R+MlfrD/S1FfjgN9/mgfnJq6PAxq9+UgSYPBfiCYzHZs
	j232rD3e5F5JymqczYojRch6MDzOV8cerbvq1ye+zfHildonpr7tBH9S/xEv+wOxw/58bROSejq
	1qPu/hoTxPh2UdaPgjdjKI/3KYYvXET3FRNjIi3aVUqNzoIQ3tlnOgAjF7dKw5XDmZG6UNsQ1dD
	iM+D5T00g9BmkJN5YALdsUcj213dQOr7BaPA=
X-Received: by 2002:a05:622a:1304:b0:530:f4d4:6b9b with SMTP id d75a77b69052e-5310cf48a77mr67825181cf.15.1789414473392;
        Mon, 14 Sep 2026 12:34:33 -0700 (PDT)
X-Received: by 2002:a05:622a:1304:b0:530:f4d4:6b9b with SMTP id d75a77b69052e-5310cf48a77mr67824271cf.15.1789414472738;
        Mon, 14 Sep 2026 12:34:32 -0700 (PDT)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45adbfsm103177966d6.13.2026.09.14.12.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 12:34:32 -0700 (PDT)
Date: Mon, 14 Sep 2026 15:34:27 -0400
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v5] rteval: Added unit tests for stress-ng validation
Message-ID: <aqhMQ9dwr2N_C6VJ@fedora>
Reply-To: sansshar@redhat.com
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Used the python unittest capability to add tests that check the
code paths added in commit aecc7c6e47d4 ("rteval: Adding stressor
validation for stress-ng").

Signed-off-by: Sana Sharma <sansshar@redhat.com>

---
v5 of this patch re-added main because taking it out was a mistake
that stopped the code from running.

---
 tests/test_stressng.py | 54 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 tests/test_stressng.py

diff --git a/tests/test_stressng.py b/tests/test_stressng.py
new file mode 100644
index 0000000..e0445c8
--- /dev/null
+++ b/tests/test_stressng.py
@@ -0,0 +1,54 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+Copyright 2026 Sana Sharma <sansshar@redhat.com>
+""" Unit tests for the new stressng input validation """
+
+import sys
+import subprocess
+import unittest
+from unittest.mock import patch, MagicMock
+sys.path.insert(0,'.')
+from rteval.modules.loads import stressng
+
+class TestGetValidStressors(unittest.TestCase):
+    """Test suite for the function get_valid_stressors"""
+
+    @patch('rteval.modules.loads.stressng.subprocess.run')
+    def test_parses_stressor_list(self, mock_run):
+        """Tests that the function works for multiple correct inputs"""
+        mock_run.return_value = MagicMock(stdout="cpu vm matrix\n")
+        self.assertEqual(stressng.get_valid_stressors(), ['cpu', 'vm', 'matrix'])
+
+    @patch('rteval.modules.loads.stressng.subprocess.run',
+           side_effect=FileNotFoundError)
+    def test_not_installed_exits(self, _):
+        """Tests that the program exits correctly if stress-ng is not installed"""
+        with self.assertRaises(SystemExit) as cm:
+            stressng.get_valid_stressors()
+        self.assertEqual(cm.exception.code, 1)
+
+    @patch('rteval.modules.loads.stressng.subprocess.run',
+           side_effect=subprocess.CalledProcessError(1, 'stress-ng'))
+    def test_query_failure_exits(self, _):
+        """Tests that the program exits correctly if the query attempt fails"""
+        with self.assertRaises(SystemExit):
+            stressng.get_valid_stressors()
+
+class TestValidateStressor(unittest.TestCase):
+    """Test suite for the function validate_stressor"""
+
+    @patch('rteval.modules.loads.stressng.get_valid_stressors',
+           return_value=['cpu', 'vm'])
+    def test_valid_passes(self, _):
+        """Tests that the function works for correct inputs"""
+        stressng.validate_stressor('cpu')   # should not raise
+
+    @patch('rteval.modules.loads.stressng.get_valid_stressors',
+           return_value=['cpu', 'vm'])
+    def test_invalid_exits(self, _):
+        """Tests that the function exits properly for incorrect inputs"""
+        with self.assertRaises(SystemExit) as cm:
+            stressng.validate_stressor('bogus')
+        self.assertEqual(cm.exception.code, 1)
+
+if __name__ == '__main__':
+    unittest.main()
-- 
2.54.0


-- 
Sana Sharma <sansshar@redhat.com>

