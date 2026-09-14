Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189413DFC6D
	for <linux-rt-users@vger.kernel.org>; Mon, 14 Sep 2026 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394384; cv=none; b=MTKRznqyQDJgf6mXfd+brGimwCBdz6dG3776LO7+P7b8J1RN4UxYUpFs7v1YkY4HFFYMZOAr9ImW5JSCgQ8REFVJMhE9tuGR2HhWw/3H9J7qXht/RP+m5bNN1YH+Yfmeyd2H3LQsTI44tOrhrHlakS+vLQ4WkuO3m8R0ei6eJ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394384; c=relaxed/simple;
	bh=maTjEWthkW1fRrOsJ5IfKWd0c58etLL+ggFmCNgEMEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MJLBfloO4wp8tvDJ4lSJMK9Y+hFQ/4CvDDjqtSgbGKXyKXrRoA0aAo3O8SvkS9MX53cZXlFGNjJiZ2gLcFY3CrnFEHe9ZZgm5ZMRJrWh66SMJLvmdFyexXA5q4TyeaLgIyGXhXujads3Akm7819bP5j6ARlRdDiYKGwltiha++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qw1L+1Ds; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJbQbbop; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qw1L+1Ds";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJbQbbop"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789394381;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=GwiHIyOyGny02WGuYhShsjFdoH9AQ3rqUvdNM+16BtU=;
	b=Qw1L+1Ds2mozAJ5sTXFE98e52ThvLM4bbRZQMVXd21obZnXLPjDouqOemd/YvjnorakOBc
	PlC/HdRb8MGKtZ5F2bBAW0IxwQbrGYrcgGwYg/4hOLTvg+ZjYbcBEFFC3S1p6mJTYn4Frc
	wbf0MYQz2Mn4vWDVMQq/rz53avBjNfw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-frTPUyHhPZOHPVeQ5mySNg-1; Mon, 14 Sep 2026 09:59:40 -0400
X-MC-Unique: frTPUyHhPZOHPVeQ5mySNg-1
X-Mimecast-MFC-AGG-ID: frTPUyHhPZOHPVeQ5mySNg_1789394380
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a183a0e93so224450585a.1
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Sep 2026 06:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789394380; x=1789999180; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GwiHIyOyGny02WGuYhShsjFdoH9AQ3rqUvdNM+16BtU=;
        b=jJbQbbopr7V3sgKQoEVDGlR8bFxqkxzGGr8i7lg2MlO1NhRD0+36rWVPsXlJ+kJppE
         V3mzxlPk4Ywvmafrerl94EMKcRTu7r5pqvFk44fRlb7mRBkcOOPnu5eiLGIZM7h4TmwQ
         mWbUKlI7oOefl7v/MG5yckrkhMUx1hdupuZWB3R5KC6VFSlcymlkxpkGKkXdV0Fm9D+J
         ubiEa/JO9nmcwgR3ZedXBw2IlX7gwampota8b2q6D1WaW+Y/rygMi9H84Fb0rZyjLxtO
         M0k2tydC56zLv+vvfF3oxT/LSKP9E1swY3egaFktWAnq9Rl60kdP5H7q7xZAVNiSQaA8
         2bmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789394380; x=1789999180;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GwiHIyOyGny02WGuYhShsjFdoH9AQ3rqUvdNM+16BtU=;
        b=qc+JBFuirD/28mR8aG7O+2A2qJl05dQfGzvZO12fbM4+zvNd7zl5fBUpA6KwNJgOHf
         Bp8QPtuSUirzZfc1rWJrTA45JSfBYeKRD6slB7aLOdUE27gy/XRY17EuQ5Q7H4gPdQMl
         Hmzc4PgHNUzNJ7+HjA6ucg9co/uQ6Zu1iAiMfoeTr/eksIgK8k0pkdooTiBmrUKUQgHb
         KEfXPsQk9qlbt6v2RbNXl4WJxIfRjYgNZqD6Mu7wWxdKYwunykZ4kmQvdjCvZmk/GlK2
         5oUDLKuZwhFtmq3HPoUPBN0a8yEQLtjlUV2dMfZ1yfisSPyZdg7TAejuOuys2ZnaCTQu
         tYTQ==
X-Gm-Message-State: AFuF++lDrJhEnJ5x1Nd2bbf0u+2cND5TaAZsbM1x4XbbIxrVA4m1hKZe
	nedEf2rUC9h5i0my9hAI2OU9hYs9Sy6nGfW0OpKcQFBCQPQdqkuDHfHdsmxclqDGMz6uffkKteE
	jUswQ+yoYhSMQd50LG1oIsZI0qG8FzSjyYVtYLwQpCwfdsNNF6K10QXpZD3QeXvgxC0uhOzze2c
	vShWYcxxroUmc+S2d5FWs5tRuus4wMUU+C4YSXRNvBsgXPNOmnoRYA
X-Gm-Gg: AYBFou0D0E3JGpksUKPA+gsI7hhOwilDYdeBbLYmCwvyZQXH4H8LUX//9KwQwjPdy9V
	rDj5fNr1T55CEoKwq3Iu4NonhmWKnYez5HPCjUscaTmI2kvHopIgPRzppqESV2eG7vxW4FoQ2cb
	aEp/jofMREzie6coyWBk4gesdmsB3KHpq5xzji7/lO1PkPLbfwFRX25+KAO/TFkahsOvJsrJG5e
	q4+b/mGxl4WpIIgbpdfSnc5On8Oln3hzMpjuGunKxyvPpJz0Aj7Sm/RVx5kXFd0f5hHxfVDRuds
	EnE/6TUUiwnoLd6MmW7Z922ojMbh9qpJpqeuQyE88SfQddnTTa0xEVV63Tf1d+8kGlGGzb/bt5K
	2XQJ8/Tfn/jtRN/vvnQSEvT8dmkR90PWFQkI=
X-Received: by 2002:a05:620a:170b:b0:92e:7383:4a93 with SMTP id af79cd13be357-93a299bba09mr69091585a.35.1789394379559;
        Mon, 14 Sep 2026 06:59:39 -0700 (PDT)
X-Received: by 2002:a05:620a:170b:b0:92e:7383:4a93 with SMTP id af79cd13be357-93a299bba09mr69085585a.35.1789394378992;
        Mon, 14 Sep 2026 06:59:38 -0700 (PDT)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93a2d4514c7sm131612885a.28.2026.09.14.06.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:59:38 -0700 (PDT)
Date: Mon, 14 Sep 2026 09:59:33 -0400
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v3] rteval: Added unit tests for stress-ng validation
Message-ID: <aqf9xfUiTADVvM-9@fedora>
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
code paths added in commit aecc7c6e47d4 (rteval: Adding stressor
validation for stress-ng).

Signed-off-by: Sana Sharma <sansshar@redhat.com>

---
v3 of this patch changed the commit sha in the commit message to
be compliant with style requirements and added comments describing
the test functionswq
---
 tests/test_stressng.py | 55 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 tests/test_stressng.py

diff --git a/tests/test_stressng.py b/tests/test_stressng.py
new file mode 100644
index 0000000..497bf54
--- /dev/null
+++ b/tests/test_stressng.py
@@ -0,0 +1,55 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2026 Sana Sharma <sansshar@redhat.com>
+""" Unit tests for the new stressng input validation """
+
+import sys
+import os
+import subprocess
+sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
+from rteval.modules.loads import stressng
+import unittest
+from unittest.mock import patch, MagicMock
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

