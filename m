Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E63449DB92
	for <linux-rt-users@vger.kernel.org>; Mon, 14 Sep 2026 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409348; cv=none; b=hxRfYeTjZw0OAqL1fo5Yh2VCrfHlbiYtMPLrzlNDnWqsVKcftgCOPY3dGo+Acq0qUrBWiahWQEC2V1b7SHyssWHBskxxuKM1MdvAV/0WtDRKOFBIjgK/TS6KcEaisXA8fgFHW/c3t9ZX9L+L4DL946ncyL3QIEWI+9zmpN8rXhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409348; c=relaxed/simple;
	bh=baElRRe+tvplEyXu+T7lBznBmVWCyJ2S164tKfzD7PY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ccydseotCpNA7jicrDCrEyX03VAZDuL58A7ceKEDIAYBabAVozMIZt0Sah2n95TUoLa+qOW4HQFiKSeVsTRxcV1aHG1L4XiQQFQ5NuAWlNS23g9OuyoQHW3fik2SXADzdLu2vcU4O0BNhQxFEYDdOm42eta7LILe6SSzYr22lZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fY2IT4E0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fH/Fdit7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fY2IT4E0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fH/Fdit7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789409342;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=Q3kaF6i1Vh6frgNR348bHwQreBSQfwtNWErXzM3TCkQ=;
	b=fY2IT4E0AUnNhSLY0vuOwZ1xnbJPpUuAHSA/QvH7c4OV7LPOXuv1jQ+BDtbBLegUciasFc
	p7KaOaOvddrIEZW0EUeMMnS5dR3dPI9FG/xmWXqdeL54UvNSBVUACv/ynZarmIirzs866V
	uYkPopNZjhLT2pO2g8ROHhKXAcbCwIQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-BZR7CxwlN6K2SQa8x6Wtcg-1; Mon, 14 Sep 2026 14:09:01 -0400
X-MC-Unique: BZR7CxwlN6K2SQa8x6Wtcg-1
X-Mimecast-MFC-AGG-ID: BZR7CxwlN6K2SQa8x6Wtcg_1789409341
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a082c014aso27278385a.0
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Sep 2026 11:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789409341; x=1790014141; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q3kaF6i1Vh6frgNR348bHwQreBSQfwtNWErXzM3TCkQ=;
        b=fH/Fdit7V/U27Dw7qDWLF2zUzN16XEatj0QcypPmjb1E58s++2+yn33LY48eIk4w2p
         KOFp9aNuS9E7h9F/OIknldU1yINrTDSLQt/dAEiUQvUIqXggN7mu7+f5lkbqclHMXtdd
         XzDfEGs05DmTpziQM40yMkOKBUOR1zVra3nI4gK6UQKQXMr0mrE4mYcduLpywQS4die5
         SwSEOCube9ez/HvN0WRtsm4vJ+EhoCMeZ6U1+unkabltslH8TEacPehqumZi6tzaeMjk
         O8skOCyoKvuTCMRgoswNAkT9wwDdhVndNaVvquSgRU9uuoZG2sF4fJmqxKI70pnzb0PM
         //7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789409341; x=1790014141;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q3kaF6i1Vh6frgNR348bHwQreBSQfwtNWErXzM3TCkQ=;
        b=M9nY11RjiI6hJiovN9GEEh9uwpJAnbWIP+MFdsvnX8eM+/BZL+BPuBe9ggh9lJNlMc
         pSh3LzV067uzK62F/Xfg4bAreM/W8AQ/PLTDK6c8yXnzeAtfccJRpg5swzTCUL2/uoOU
         /rZ9EDJtptkYrC7LbLxr9yye1l/9rdFkk8CgCX2pdoCPUtMakatjKoXFnpfa2IrE/HJI
         9/KblYcx1albdtauCDVe6zyzC0zna0jKeXr1Gn/vX13xEfUWl10+4jDBnCPHCMA0n1gF
         FPZy475QMnQWYEvdhApVl6kRxiMGF0nXRl1oyscrhmRc4Wew15zcT9lHt3n5qLNGbtBn
         T9uQ==
X-Gm-Message-State: AFuF++kTwwW+PZ5grQrmCSIEDJyw06Kc3InRwWx68Xpi2CwKUKjV0Xcq
	1rMZUZAJWsDoFaXHNw0Kv0xUIPQLl/X2SDX5YMFVb0f6tnO0eZrJEmj8RC2nj7fTN7D14CBWToy
	kwMexdlmB/Bw49UtYDA6cBOW0BUsVS/2agNb16JsKeEaWwLFed/R4Z2Jh22ML8Y00sV+Tax4inL
	1MUN2lb3lSupCT27lSkn/XMugkkPagv8A1lfQc9mMgQTbN+Tnu+P1m
X-Gm-Gg: AYBFou3c/U/HW8rxGrO1F6e52qV/J6X1ulxY5Ijm/siAhu7pn4qbHLjc5pPjv2l6HsT
	uG+DdbIhBahUMAja/lfMHQM8ku1+0fs2ZWGCJbtsKwtFEKL6sUP2tbzKWn4RJA22g6hUjyfQuZr
	kYmwDM3kYsw6BL99HPzawLmDUeoqHafregF7Md9R7cX4RtAiLK56rjYDLJGB5EoDbga7g/XqNxo
	WOQG1FxRuTA9qsy9m2lpTIqI+9qhVhd/5oGvnFEI52PTlBbWuh97yenLBy2yk+AD9yiHrO9e9rY
	pLKl+iq+J9kDtKDSjhLzpwFzaVRkOd7Yz/KsEUtlyOX7TO9qWz89aDVARGpeaC0xy7mmRyn/FOC
	sKPSArchkBP2hQsKBnpA8c+Vn5QMhp4JbyEc=
X-Received: by 2002:a05:620a:268d:b0:93a:5f0:618e with SMTP id af79cd13be357-93a3464abd5mr79047385a.11.1789409340607;
        Mon, 14 Sep 2026 11:09:00 -0700 (PDT)
X-Received: by 2002:a05:620a:268d:b0:93a:5f0:618e with SMTP id af79cd13be357-93a3464abd5mr79042485a.11.1789409340054;
        Mon, 14 Sep 2026 11:09:00 -0700 (PDT)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80471a3sm1047718185a.22.2026.09.14.11.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 11:08:59 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:08:55 -0400
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v4] rteval: Added unit tests for stress-ng validation
 functions
Message-ID: <aqg4N_eb0qE3Mrbd@fedora>
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
v4 of this patch changed the commit sha in the commit message to
be compliant with style requirements and removed main.
---
 tests/test_stressng.py | 53 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 tests/test_stressng.py

diff --git a/tests/test_stressng.py b/tests/test_stressng.py
new file mode 100644
index 0000000..ba21c7d
--- /dev/null
+++ b/tests/test_stressng.py
@@ -0,0 +1,53 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2026 Sana Sharma <sansshar@redhat.com>
+
+""" Unit tests for the new stressng input validation """
+
+import sys
+import subprocess
+import unittest
+from unittest.mock import patch, MagicMock
+
+sys.path.insert(0, '.')
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
-- 
2.54.0


-- 
Sana Sharma <sansshar@redhat.com>

