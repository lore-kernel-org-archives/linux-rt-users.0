Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77798430CE7
	for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789158893; cv=none; b=EZLboZNFEBZEh5yY2Fr1cuMl07zgN4jRBpTadU8B34hrQyRukPQk+jHtveRpUfrMkTl2Q7CPQ8YiVl2NJX11tioAVbC1orLw86XCoqSTsIc0OKHyHPc7KROdMtvVCDjUXbEpiY191c4UVRjWuRWwwLebxglxloX/9g2CnM1E2d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789158893; c=relaxed/simple;
	bh=vHfFBfUTK7RdTpm8UrsuI2s83TZTqpbuagrfiJLu1Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U92yFguLchMPyRo/Wjn+MO4WuFdwQc+BI3PA8WclbkNk5fFPf7oTto1kMRDYRvAfE/NsW9xKYg9d6Uyn8L5ptWL8JvdV5hwBKg2IAU8bW4x51nypsyvHnyDq1ET7t4US13nQsSgJQwnAzdYP3tSfIOH7EkBNrW2RuGhnvPFkhIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1bgdpms; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q/oiAr7K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1bgdpms";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q/oiAr7K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789158890;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=GwfERLlJHsN9IXOuVIZ4iWWsJzT6b+H2bQx9d5xtleQ=;
	b=P1bgdpms8R9iZIhGT7LQ2mcHMfCncN+jyZTgwsQkOFaQufz/RCFF3G33RzVgWCSZrg+ap7
	is1SzuN38sg/5o7k1CNyw0gCppLo3rRQ3H2/5UaFpXfx9UcJkfZ1vt5jscSv4zmK0i+ou9
	tqizW5O7X4TFgFYH6xCaTSfG6BcZpFg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-bbLyAL0LMzaX8hebgXARuw-1; Fri, 11 Sep 2026 16:34:49 -0400
X-MC-Unique: bbLyAL0LMzaX8hebgXARuw-1
X-Mimecast-MFC-AGG-ID: bbLyAL0LMzaX8hebgXARuw_1789158888
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c26012cd0so25318481cf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Sep 2026 13:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789158888; x=1789763688; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GwfERLlJHsN9IXOuVIZ4iWWsJzT6b+H2bQx9d5xtleQ=;
        b=q/oiAr7KV9TQWFQUdpEuNCG5S7fl3Y/TFQbuu8KkpMoZGUnYhlMUI98Ylwi+KqE8mJ
         LOoYyHTPnqBQWJzXKmwddOrOkKm0DCB8hzDOSThGE5VptHoBd4vb0MiDiMAMvrTq/W8X
         ZKkIaXmSyP5MwJL5tZT4gaUIpecLzNucBZCBkiAvYGZ49Eo/xIgXG216NQ5QPI/gHb2+
         YxHyuZGSZu70GDFCh/h3qa8fvm07az8brkSwFZICwj4UAeeq71JgIyHhGL2uVf6y37pJ
         BJyw7Gii4dCx3qx9khbx+0JPtUgNl+LezcLlwrYi+KcOwr0fT5SdRouGSH1M2GxGwyr/
         QHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789158888; x=1789763688;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GwfERLlJHsN9IXOuVIZ4iWWsJzT6b+H2bQx9d5xtleQ=;
        b=IoDJHNUOINrgwPEkXi3nncb6zuLYmVfgVTSZnKV0vihBy22XcsseNNJIjkmS6jmL98
         BJcLnNB6WVyUC58dagUI+vksAZXghXMbQavjLbb2g+6r//kEiTBurqUJExJ01/pmx6ux
         eOih7dBeWRDSm/LpECCbhXtbQvU5agip4pGPmu8DhjakXVZDctd9MEwDNQFYjAfSlYP6
         6ZKmqiCJa/FT7aLMT8J0CCYUicp34f7KPbHVLLNWMe5aHaFxZNpJc+BOPmoHR1rvT2qm
         m7NsEuaPvr7m30rHXPjnHElx/G/ORoB8iriv9JShdxWG08HHffltRDf9FwWaQdCoGZDQ
         dIHw==
X-Gm-Message-State: AFuF++nQ2l2bexYAwIdIXTEnsneQvTJ1I0GzxMSHhAF0/6ywSMK0el0L
	U4LkX5YQ5Ygf8c5gpiqz4qCyT/53nzoO2FKG27rrrQo8g/TWnGezGp+M7hml92fw7y6WkWDVau0
	slsDBMX1gakXbbJIJ5E1OkdGK/ZCs8RXRbtRgPh/bWzbX2J/qeERcxlbO8VDj3VJ9RVpMR/drpR
	ULitWz2QOVWkmZolBfoQ6LJxuUWDhZ+9KDR6A0PohYXFflFy7qQOKE
X-Gm-Gg: AYBFou1dWggAFaOReCs9tUbBMLjpx1LR+n6tl6Ohai+gI97hx2jz2sJ8h9cBbdqOmS0
	2hw/OKWZ781TdXot8CyJpOwz0dQpSIj6GK9gVuDW31Ppdqp8iJmMzjfogLcdNivbV/YEgnfHfrc
	UJ7fWMmYB8COBKZENFV+qpNhOYSWhiv7c64MpJEpuYN3dOTujsZUDjIew+ylbMi1t4CC99GRiw+
	Va2zgXrGetLmL/Ti7bIeokP+IoWTFm/sdIUEeNgZxEaRlMclIZlfdn75qw/McDNZ+dqNub/EqvF
	HfPegl1GISFquLR4FLnBZUEdiM04a/97a6uICLXiULUGBGay/Jmq91nT0jAQVGqus3A6zBspmEQ
	z3QQIVvP1pkEghsasfeLn1A0ZVzgWJJBi9mg=
X-Received: by 2002:a05:622a:6203:b0:530:b2e4:d5a1 with SMTP id d75a77b69052e-530c878d6bamr83887171cf.60.1789158888276;
        Fri, 11 Sep 2026 13:34:48 -0700 (PDT)
X-Received: by 2002:a05:622a:6203:b0:530:b2e4:d5a1 with SMTP id d75a77b69052e-530c878d6bamr83886621cf.60.1789158887663;
        Fri, 11 Sep 2026 13:34:47 -0700 (PDT)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca489107sm28345421cf.14.2026.09.11.13.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:34:47 -0700 (PDT)
Date: Fri, 11 Sep 2026 16:34:40 -0400
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v2] rteval: Added unit tests for stress-ng validation
Message-ID: <aqRl4ImQ--RS_HBG@fedora>
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
code paths added in commit aecc7c6e47d4 which added stressor
validation to the stress-ng load.

Signed-off-by: Sana Sharma <sansshar@redhat.com>

---
v2 of this patch gets rid of the unnecessary Makefile changes
by changing the unit-test location so it gets automatically
discovered. I also changed the commit sha in the commit
message to be compliant with style requirements.

 tests/test_stressng.py | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 tests/test_stressng.py

diff --git a/tests/test_stressng.py b/tests/test_stressng.py
new file mode 100644
index 0000000..a4302f6
--- /dev/null
+++ b/tests/test_stressng.py
@@ -0,0 +1,39 @@
+import sys, os, subprocess, unittest
+from unittest.mock import patch, MagicMock
+sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
+from rteval.modules.loads import stressng
+
+class TestGetValidStressors(unittest.TestCase):
+    @patch('rteval.modules.loads.stressng.subprocess.run')
+    def test_parses_stressor_list(self, mock_run):
+        mock_run.return_value = MagicMock(stdout="cpu vm matrix\n")
+        self.assertEqual(stressng.get_valid_stressors(), ['cpu', 'vm', 'matrix'])
+
+    @patch('rteval.modules.loads.stressng.subprocess.run',
+           side_effect=FileNotFoundError)
+    def test_not_installed_exits(self, _):
+        with self.assertRaises(SystemExit) as cm:
+            stressng.get_valid_stressors()
+        self.assertEqual(cm.exception.code, 1)
+
+    @patch('rteval.modules.loads.stressng.subprocess.run',
+           side_effect=subprocess.CalledProcessError(1, 'stress-ng'))
+    def test_query_failure_exits(self, _):
+        with self.assertRaises(SystemExit):
+            stressng.get_valid_stressors()
+
+class TestValidateStressor(unittest.TestCase):
+    @patch('rteval.modules.loads.stressng.get_valid_stressors',
+           return_value=['cpu', 'vm'])
+    def test_valid_passes(self, _):
+        stressng.validate_stressor('cpu')   # should not raise
+
+    @patch('rteval.modules.loads.stressng.get_valid_stressors',
+           return_value=['cpu', 'vm'])
+    def test_invalid_exits(self, _):
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

