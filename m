Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA26478E25
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2026 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475551; cv=none; b=rlJs3LTHRJgernsR1lmz5JJvXV9zF6yMnuEEXBRVEWpuajGkGExjUO5Q+04Hro8RdU9H8YKL+54CFpu0pv3WaTL0eZ8vzRnBbSjyz82LJ8/PhbRjTynd6jC82Tq/8xK9UusobS5otBo5Igd0G68C3QSK0focHGc/dowIOwtc45E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475551; c=relaxed/simple;
	bh=SsQZ+HKEv7SKp8ljJGj5Bp1OVwUkL2NioJdHK8/FopU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pm5IjaIZchmkuLgfqXUCG/kFv8e31ycespoh/9443V9eJj02Fp841+8b+uDWlCpr/4YtIesNSyvgYls6LIZiV8hGHGdu386K/6uQ3ywj1KV2DI/f8cPjJd5blP0XNRXOFe958Sy/n+6R6QLpr1yEZJi2xjc+x1eEfBMQEHJ21/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1AsZv9e; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YO7FuwO1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1AsZv9e";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YO7FuwO1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789475548;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=Muiuuo/67Cg76U/RB4wYtGvnL5FITkNka4oNai90a/Q=;
	b=J1AsZv9eWLwCRhVROmP2TODmbyagbqDrucmdmFfFYFD0w7ZOWmgHty1K6KwCdIwXt+Xdw+
	daXLm9xqB/B0Kg+8c823edeJeaWSpMYFZCsL0W/3rD/cY+mzakd8MfuWtlwzGw+NHo2m1m
	NxMKUuOZLrSSXRE3KjcrPug8gqe3hdc=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-KKFFtEnkMraI1sAwvleEAw-1; Tue, 15 Sep 2026 08:32:27 -0400
X-MC-Unique: KKFFtEnkMraI1sAwvleEAw-1
X-Mimecast-MFC-AGG-ID: KKFFtEnkMraI1sAwvleEAw_1789475546
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-79630cb8723so550834137.0
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2026 05:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789475546; x=1790080346; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Muiuuo/67Cg76U/RB4wYtGvnL5FITkNka4oNai90a/Q=;
        b=YO7FuwO1fG6MI6Hf3JWqWSSWT1lGqTf7N4+oqV0yMEp1ws2M0BwZLjlApG2dTkWE4K
         NGNbIxl9UYz2FuLZ4pvPB/8E1O6hZHXMouxcZEcEkRB4cRi+If5MdU+NKKpAcDDjbKV/
         2/UDSX+udIQnwai1n1OZnQ7dQWzBLThd6dPSe7MYydnL9tYpqy4AQQT0d4Gm29sQwFFC
         f9i3k3g/ywmnWUoQDdIJQF4ep3HxTQXHz4lCdAZ4PqVbULLj9hP67SsI9WZ0ZaVYBhHU
         k+1FoGee8zizMkSld7OTfUVybDmp8WzqfewX4ZhBVIkeVEUL/82Vm765LkFPc7zB4UaT
         YiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789475546; x=1790080346;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Muiuuo/67Cg76U/RB4wYtGvnL5FITkNka4oNai90a/Q=;
        b=xumfM3pdkMOo2uRbWMpf1tI0RUcqZImIXkLs5uDvf3bMm3/DBh2mnXIhreaJ9XAE22
         Ml8tKSfP4KYfneJXZpji2VPJ4Z1cLmtcZTos+ktu2uCY3mgrRAfWrMzs2hS5U26kXjsU
         nDyhAeG0YnCmFz14yPsWPxpAaeHVcBvEiFhHORi4sunFMYUlBT2vj3qAvGOZV1JAhad5
         hN6XwVKNta6LuTBkWrAnJsaqWBAyEgnG0tTktxtY9taH12ekCY+WN8xhCbZ4nVubmK/P
         M4K962UA/0O7zolI9wUHW+kLPGvrvKFoZAQ0Eb3rnq/9Vy6VIITsdnNBDCCCL4UwBwUj
         9xrg==
X-Gm-Message-State: AFuF++nWCtv40mJlo8F6aJJshkBc39A7DXCbJKCVa9D+82XZkSKrAQic
	2EhLmrdPjogLPoi39PbOl08J3VP/VZ+RlGR3872r2dtyGW0UGl7gUKr5Pyt+B1t31HCXgrprlwi
	OyBOEEBLJAcduI1EWoJGU2J0Yk2uG16dO+SuuO9R0fUjGLdXauoK+p0D8MtN3CVFCXVtdjniDSb
	AKvEgn+JDoOS8pkRFYYXZo3KN6GPhiXwhI/D2jN1Yl4fmfPi3YfShd
X-Gm-Gg: AYBFou061jL8N8MNciGeKxULWIuUnYlompV+RD06FKLYXzwo9GVA02Z1Y+RvdH7woT8
	y6v+Dm7UMgBIwsoIY5+72YEHFUWrOtyn9Mwk5LAAU5hx7N3VfqYPacbMjKx9LN6b5Wfzy/h8+qE
	PQEfEkFe3DKJ9gfB3vzqQ1G8zwrMxAuiacWmwLCsfuup/T6qomOvNtgX8LDUIQxdexdLqgMBhvA
	oYgjCOKU8p6S1shTdS8zCosJaoQoKA+3nwPzJ0D0JmoD+2L3Wzt9t3Oh3lcV71eBag+PIURuZBM
	lHZkUAEhaSO7JMSZkWbXzAeSsuDhfoKaAdmne0/q3GxRaocpL7QrNFYlwJxoGjz51ZWR0HXeG4Q
	Px6TyblcVSZxSEDyfkV0VwhZcEEe3Wt+wVxY=
X-Received: by 2002:a05:6102:3706:b0:79c:2e36:a2e8 with SMTP id ada2fe7eead31-79c2e36a8bbmr6228637137.5.1789475543032;
        Tue, 15 Sep 2026 05:32:23 -0700 (PDT)
X-Received: by 2002:a05:6102:3706:b0:79c:2e36:a2e8 with SMTP id ada2fe7eead31-79c2e36a8bbmr6225296137.5.1789475518848;
        Tue, 15 Sep 2026 05:31:58 -0700 (PDT)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45ab71sm117193266d6.12.2026.09.15.05.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:31:58 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:31:54 -0400
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v6] rteval: Added unit tests for stress-ng validation
Message-ID: <aqk6ur3jcn5tFD11@fedora>
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
 tests/test_stressng.py | 55 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 tests/test_stressng.py

diff --git a/tests/test_stressng.py b/tests/test_stressng.py
new file mode 100644
index 0000000..ac1a3b7
--- /dev/null
+++ b/tests/test_stressng.py
@@ -0,0 +1,55 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2026 Sana Sharma <sansshar@redhat.com>
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

