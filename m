Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B475434F255
	for <linux-rt-users@vger.kernel.org>; Thu, 10 Sep 2026 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053598; cv=none; b=XBeU5BrT9LN3cIn/wRjcJfZmx2/UwUgNu3xW4QLzIBA/yEhc7P/XEh0pwfyOQ+dEP4wfq/fxcwhijAAK2GD4FLbS44Eysbtf+XDz/IwNCvSunO+e7WtztQn7SgOSJWuNF08RNeqow//JX0Lfp7bjpsiV79bjVC8m7ozN++b4SiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053598; c=relaxed/simple;
	bh=EwIUycKhrfXkx8BVFLI2CtfSetYx0yAU5AGYO72HP3I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LeQXSXmsfm39zh9uTMgyERoAl0f91PS8AZcE6vkBOrzRFZEbkbPkruhowRKJfgSPXv4C5QrEPHeR1h6YAFnXRA5upsv7T8JmTRI6FcEHdsxhkB69cB0Kgu1xt4lMrXDptM98pyUDHAmG+8CnQS2a6wLSKBQQbW6bIxh1AJg+ius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VQIvxbQA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5EcMzdS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQIvxbQA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5EcMzdS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789053590;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=u/yHhWjCq2rrwP6P2z6DAVbxUtWCyNjj9uN5UZUtQGo=;
	b=VQIvxbQA2z+EL7dMMEhrWK30y3jI9tv0HwP+ZqjGB/aTw3M5BYc/xjUJFu1k1BlDgBAVJ2
	twYP351FSWgn31Z4h7xISUOw/NdcrKzIyTkhQiWDGIDOdvyG2bMuxhklaN7xVlHDfDMHgG
	V7spCEY/vl3pb5cwJWyK25e7iuxVSpw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-1YBhT-UpNB2zbq2K1Bu7dw-1; Thu, 10 Sep 2026 11:19:48 -0400
X-MC-Unique: 1YBhT-UpNB2zbq2K1Bu7dw-1
X-Mimecast-MFC-AGG-ID: 1YBhT-UpNB2zbq2K1Bu7dw_1789053588
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5308a3825deso79836911cf.2
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Sep 2026 08:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789053588; x=1789658388; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/yHhWjCq2rrwP6P2z6DAVbxUtWCyNjj9uN5UZUtQGo=;
        b=C5EcMzdSMtD4cizDBB23myFjZ0Cr3k2iyugQ5blakB172gRRiHOr8NgF30ZuW22RZK
         xZC9E7mGzQL6oyPkyKfBs3nuQSGakfq2W1XwCPy/QZqIni3NojbpAkVXQAg2T88lEr0x
         VOfkK7PP/QbAP4/vkoAje6H/0nXqx3kvHKb3TJifr89Iz/UaSKnpe/SW7kn0Kjz52zcu
         CXDLnDBNxTvDCPdV/dIQ/nWsn+5B3ZA7slZfYOueYnrJBeh/nBUBLfI2XUBW2q0EpemQ
         lHgHjaUbEpWVw9aQaydtvxYUr8V9zTj4AjqbizGS0alUIEDtQDLMbMiz5leLVTnRiJKr
         JjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789053588; x=1789658388;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u/yHhWjCq2rrwP6P2z6DAVbxUtWCyNjj9uN5UZUtQGo=;
        b=l421ModTvqr7u8hEC0vDC1hTUNNm7r6E/l5yJUuIjY+9sXlbvuTcy+uqfYK6cycYcs
         RmNveKmxuvvoyu9fKwR+K92/ibhJlaoME6/U0HnQbWBvEwjeiL+jyuDnhp2vQhPzipq7
         PgyuutKb5Ob9KHmhLsrYb8irhtCXEtUxLQQ7ya4sJdfZI013DMk6ld+0Cj08BszNjLq3
         zI+rsFpA/21K9FbbZUZsiA3Hi9SJFaIoylbscaiR59gkwU3xHNjGvcI9kLHEnTrhVdrZ
         SZ3GcKF2HKdjOzXZkq/JnrPD5VWNXMJaBwvcsCkJtWTclM0WyGNg1NaOzbnpRKKMrGmo
         T3VA==
X-Gm-Message-State: AFuF++me3MLXPgx8L500KJDHqZiLlYob1ll9Bon5aBrbeCSMIzkll7Gg
	TsO+fbGadBmXX0XR3hStJHYYNbVWewGf4oG7vnicyvDmJfKm/pjZ1eqaEgYP4yKWtDAhSGG3YOW
	35t7AkWpBtSc9RE/DwQPnUOCyVVWUq9116Tsg5tTTH+Twty720bKeh+blctZ5lS13tdDlGOU1QX
	V2Foxgy5yRwY9UXVmZyRhlVaSPrdQ2xs7hPsrmgdK3bZICh16nj8OS
X-Gm-Gg: AYBFou1sUmr365T5qCsGCDSmliowqRptGSEFuOqWQnBcOND+SEQatHVLe0dTp0Neec8
	wXWqEFlBZuUms9eAOgz7Qs3JpG2hYOXt2XClxlV3gwXK9UR+AVrBSYSD55fkCQSacqgapiGBodA
	dqrMeydQbGbE7jsLf3a1jVHa6bG6HnJKbMAXBEqhduDpSzDtWQzeBKTmFdKC7XvsscTX7YHeoGD
	K+bmZ3LZVfcsS08vJ1bI60y6ao+O2v65IH5ftzmiuPmQn7NPyHdUzUzrudZMWdXKIyXGcYYTMlt
	FMfIi45Uvw0O+WEZzEhu3//aXyMc2BwV1xepFnkcrsjTbZ/AjgYyKHyRKpf9qBupHvQc5PDXj7f
	IHiZtW29vsD/NvqVA3lPMQdoxtadit8Cgds0=
X-Received: by 2002:a05:622a:8c15:b0:530:b2e2:2f9 with SMTP id d75a77b69052e-530b2e237fbmr90887421cf.59.1789053588108;
        Thu, 10 Sep 2026 08:19:48 -0700 (PDT)
X-Received: by 2002:a05:622a:8c15:b0:530:b2e2:2f9 with SMTP id d75a77b69052e-530b2e237fbmr90886731cf.59.1789053587612;
        Thu, 10 Sep 2026 08:19:47 -0700 (PDT)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530a2fdcf8esm57318061cf.8.2026.09.10.08.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 08:19:47 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:19:46 -0400
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v1] rteval: Added unit tests for stress-ng validation
 functions
Message-ID: <aqLKkrKSpkUt2OQ3@fedora>
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
code paths added in commit aecc7c6e47d4b6b47108fabcf79be75a86ababe8
which added stressor validation to the stress-ng load.

Signed-off-by: Sana Sharma <sansshar@redhat.com
---
 Makefile                     |  6 +++++-
 tests/loads/test_stressng.py | 39 ++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 tests/loads/test_stressng.py

diff --git a/Makefile b/Makefile
index 869d42d..3612fc0 100644
--- a/Makefile
+++ b/Makefile
@@ -59,7 +59,11 @@ sysreport:
 unit-tests:
 	@echo "Running unit tests..."
 	./tests/run_tests.sh

+stressng-unit-tests:	
+	@echo "Running stress-ng unit tests..."
+	$(PYTHON) -m unittest tests/loads/test_stressng.py
+	
 mcp-tests:
 	@echo "Running MCP server tests..."
 	@echo "These tests require rteval result files to be present"
diff --git a/tests/loads/test_stressng.py b/tests/loads/test_stressng.py
new file mode 100644
index 0000000..6072c37
--- /dev/null
+++ b/tests/loads/test_stressng.py
@@ -0,0 +1,39 @@
+import sys, os, subprocess, unittest
+from unittest.mock import patch, MagicMock
+#sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
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

