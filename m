Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482514;
	b=IGD+u/7iscdohYRnU2bGlENEfgtpTJkxQLTPoB2EhxlVEZYh2/yOVi5jd566ODH0gzUe
	 K3sA46kwDeP9em9zXwZi7Xq43N0TUkJbCle+Rs/lJ8QOHRf00Yyq0Q2VP/u99CQw8Tjka
	 ntIbdjg0z8oxFPWouL3wWAcIlGG1H16sPBHeHTqQTeOn4MdPB0r+z8o+9J4ZkEfqa0G8F
	 zbSM3ar9+NAvUJq8YZfNF1I2k6MplxtvpDtTUAUUcFaMDiuFU7LEYW3+27EeenINQSSd3
	 zUYEnnYNnDnvWywsx+osN0/s63hOZtVznza96htqT0HS/zJ/76qFv/3k7GldlmTGD6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OgVqSMBGOVMUYvqNnmu95lv0KVWuufF22cTHU/JcPYA=;
	b=Tt+z/9FQBbh2hT5na5AwnQkNgQVvmZwcpQeLqoeZTgof4lwv8ZnDIORpNhvkaAcRvhhT
	 fZj6q9wJ+dNhMv2IXooi7bDWxppDCokJvPsEOhMdtL1YwZ2x+swoJ6XKyilsG1wlKtE28
	 HmYWrrA0ZDXLfVcY17F4c9PWJZcX1DRCY8Tf6wxsSQkDGMYlRipPwCvx3vnhYu/iDcRYO
	 ZFJL3x5TwFyAGVg1LzlM+11OBZDgNWlAwd/pXDDttncIxeWLhz+SZpcZBHj+uMyPbA9Lg
	 xu24HIAtWLXreSZoU/ECaXr3c/kw+jeBakWcIb2mHXYbJY+JNM1TrQ3eJIXaQyTrqkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vRfG00nD;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E7F606A32D
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Nov 2026 01:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3E7F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vRfG00nD
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-9211efaca89so48539996d6.3
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Nov 2026 17:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795482512; x=1796087312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OgVqSMBGOVMUYvqNnmu95lv0KVWuufF22cTHU/JcPYA=;
        b=vRfG00nDWTO5IK386ZxyNP/9BOoe/hB3xE+hYDMPFdoLPP9OvbSQpJp1x/Rm5EoSYr
         4SRlYF5K1RQXlbdOBE8g8Dz5kfkEHqlnEbHNg+TcJYX7pEqmFaOqmbL46gXSFikpMxWH
         D3l8ZyJnPw4/+310X5l0sjoYTUNhH2cJceo9dfh+em0HFnTWuETUFSukXIDiIEKZDYZr
         1DzEwQjCHaV0uaSks+7wINK7R24E6HRNnbbYcpWDhQiVLBfunGSGroT5J01QH1OReZxL
         tV5AstOP++3uBWJDFQLtwkETOYqZIh6m9XWL2G0i2EAIUxEdmwgleaN1cHFW/BQW3aKH
         w5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795482512; x=1796087312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OgVqSMBGOVMUYvqNnmu95lv0KVWuufF22cTHU/JcPYA=;
        b=nb6LCLOAHe1gVK4N0aNxWfwcLqtZShFKCXJH+lbxYrBqSHc0jR1n51oJJt3XOZeJ+8
         4+3GNGgE12mec4TaAR7CQRxT+49s3e1cfGRnxOHFb4DwMfMSFonlmcs1IEPl6CzXLLri
         x0QzBHfYjXBOdLZXqEzt+1e60JZz6DC77m1TNAYBNB0PQtL2E3ZAqtQtoSTOHIEJuxRs
         gANPA0VGZ4A3eMNkrahfsiO4MmKHmSV3NuJJsdsRasMLKUXTcpPyCQGoSgj3Oov0oiSS
         EG1jZ2RaYUnRnxIW6rjMOZfXnY6NKWv9388JxSDmtYkAS4EN6Fnwfln1ZhGzNu2a833O
         ANyw==
X-Gm-Message-State: APuU4Z8QXB1EOw3ZpgMsqbNKidpguz20tXQwf0Vaf7CzHPVIY7RCfk87
	JIgzfnniVwbNEIRHdEB9QL7L0CD64yMvgwIQWzXgynRnzLLDK3jvgIFJD1iyxg==
X-Gm-Gg: AZFdTZcJcuvgqgYvMu+SoNb90To15qDX3SWlOjWPyQkL25SN8wpAmsBpepnsjV6+WHU
	dI3eu5HeBxVumz0beN6Q6TB/25fkNDWU0tCfFl6rvHPSLxMOtfoewCrwqdUzzo4Z/GjEfqhMXKJ
	ulJJFfHY3WlWZ6RZ4X9Dv9s4+EBc/q4S515trom0OX4II6HKGLJ+hxpTNm+LnOIR1RO73kcKF5V
	hkS+OvSrusWIYVneKl1yxPwsUJ9gOoSo0K1f5zXDf46wXZZ9HArMInN9pWpkRQKgzwbCU9jgH70
	lTOWQQ5tIuFVwFyv/kn6t9F+UoCpIAyvXYKP4r3qhMbVwmWtHdkqxiS99YBCYtSJlRfLsuuz/bz
	+19CT7jroouzVclLzu7jOa5Lv8Xf8El6qRtHFP0KsaXIeCPgLne5Pf6G0AYCJkWiZAtzK10PJ+G
	A2tg8rujofM7ZuMLB47a2UIvDBpwcUYgyylf8GDQfBqqqw6VhnJFDr3oli/7v6F4OJm3KI7IrUd
	IvTI8hYHTT9NZn22i9R/ZX+CoXY6htc8PflLGv154Yz0CD7EpFck618H86f7avnTiLRtBoU5/mj
	y4uhXymADov4luBZQ5ZF7k0ekcBv8nzpismMl+Y99D2rga3LRtYxZ1hn67PDn8Rd0RCqYDPM5xK
	6uaGCcSIVOTzWxJZwc/nh9BloQKEL01zqpstp
X-Received: by 2002:a05:6214:3107:b0:921:404d:f460 with SMTP id 6a1803df08f44-921404e1bc5mr192142186d6.23.1795482512511;
        Mon, 23 Nov 2026 17:08:32 -0800 (PST)
Received: from jkacur-thinkpadp1gen8.rmtcaon.csb ([70.53.46.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d14d1sm120624806d6.18.2026.11.23.17.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:08:31 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 2/6] rteval: Test stressng opt-out and arg building
Date: Mon, 23 Nov 2026 20:07:44 -0500
Message-ID: <f6f99c3466f7b64c77eaf4a446f75a82a56ea69d.1795478784.git.jkacur@redhat.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795478784.git.jkacur@redhat.com>
References: <cover.1795478784.git.jkacur@redhat.com>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing stressng tests only exercise the module-level functions
get_valid_stressors() and validate_stressors(). Both the opt-out decision
in Stressng.__init__() and the stress-ng command-line construction in
_WorkloadPrepare() were untested, which is how recent regressions shipped
green.

Add tests that drive the Stressng class itself, built from a real
rtevalCfgSection (not a mock) so they follow the same path rteval-cmd
uses. A make_stressng() helper disables logging and points build/report
dirs at a temp dir so construction has no side effects, and the
arg-building tests patch SysTopology for a deterministic topology.

Coverage:
 - _donotrun must stay True when no stressor was requested, even though
   'workers' always carries its "0" default from argparse;
 - --stressng-stressors and repeated --stressng-stressor both opt in;
 - negative and non-integer worker counts opt out rather than being
   passed to stress-ng;
 - _WorkloadPrepare() must not place a None in self.args when no worker
   count is set (it would crash the " ".join() in _WorkloadTask());
 - each stressor gets its own flag with the worker count.

These encode the intended behaviour and guard against regressions. Three of
them pin the opt-out and arg-building defects that earlier revisions of the
multi-stressor series shipped; all pass on the current tree.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/test_stressng.py | 128 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/tests/test_stressng.py b/tests/test_stressng.py
index 9da3bcb984e0..e9c0701569e5 100644
--- a/tests/test_stressng.py
+++ b/tests/test_stressng.py
@@ -3,12 +3,54 @@
 # Copyright 2026 Sana Sharma <sansshar@redhat.com>
 """ Unit tests for the new stressng input validation """
 
+import os
 import sys
+import shutil
+import tempfile
 import subprocess
 import unittest
 from unittest.mock import patch, MagicMock
 sys.path.insert(0,'.')
 from rteval.modules.loads import stressng
+from rteval.rtevalConfig import rtevalConfig
+from rteval.Log import Log
+
+
+_TEST_TMPDIRS = []
+
+
+def _cleanup_test_tmpdirs():
+    while _TEST_TMPDIRS:
+        shutil.rmtree(_TEST_TMPDIRS.pop(), ignore_errors=True)
+
+
+def make_stressng(**opts):
+    """Build a Stressng instance from a real rtevalCfgSection.
+
+    Mirrors how rteval-cmd wires up the module: a genuine config section
+    (not a mock), with logging disabled and build/report dirs pointed at a
+    temp dir so construction has no side effects on the tree.  'workers'
+    defaults to '0' here to match ModuleParameters()'s default, which
+    argparse applies on every real run.  Pass workers=None explicitly to
+    model a run where the value was never set.  Caller is responsible for
+    patching get_valid_stressors().
+    """
+    tmp = tempfile.mkdtemp(prefix="rteval-test-stressng-")
+    section = {
+        'stressor': None,
+        'stressors': None,
+        'workers': '0',
+        'timeout': None,
+        'logging': False,
+        'builddir': tmp,
+        'reportdir': tmp,
+        'cpulist': '0-1',
+    }
+    section.update(opts)
+    _TEST_TMPDIRS.append(tmp)
+    cfg = rtevalConfig(logger=Log())
+    cfg.AppendConfig('stressng', section)
+    return stressng.Stressng(cfg.GetSection('stressng'), Log())
 
 class TestGetValidStressors(unittest.TestCase):
     """Test suite for the function get_valid_stressors"""
@@ -51,6 +93,92 @@ class TestValidateStressor(unittest.TestCase):
             stressng.validate_stressors('bogus')
         self.assertEqual(cm.exception.code, 1)
 
+class TestDonotrun(unittest.TestCase):
+    """Whether the module opts in/out of running via _donotrun.
+
+    stressng is listed in the default [loads] config and is exclusive, so a
+    wrong _donotrun does not just misfire stressng - it disables kcompile
+    and hackbench too.  It must opt out whenever no stressor was requested,
+    regardless of the always-present 'workers' default.
+    """
+
+    @patch('rteval.modules.loads.stressng.get_valid_stressors',
+           return_value=['cpu', 'vm'])
+    def test_no_stressor_opts_out_despite_workers_default(self, _):
+        """No stressor + default workers='0' must leave _donotrun True"""
+        mod = make_stressng(stressor=None, stressors=None, workers='0')
+        self.assertTrue(mod._donotrun)
+
+    @patch('rteval.modules.loads.stressng.get_valid_stressors',
+           return_value=['cpu', 'vm'])
+    def test_stressors_string_opts_in_and_validates(self, _):
+        """--stressng-stressors cpu,vm runs and is validated to a list"""
+        mod = make_stressng(stressors='cpu,vm', workers='0')
+        self.assertFalse(mod._donotrun)
+        self.assertEqual(mod.cfg.stressors, ['cpu', 'vm'])
+
+    @patch('rteval.modules.loads.stressng.get_valid_stressors',
+           return_value=['cpu', 'vm'])
+    def test_stressor_append_opts_in(self, _):
+        """Repeated --stressng-stressor (action='append') runs"""
+        mod = make_stressng(stressor=['cpu', 'vm'], workers='0')
+        self.assertFalse(mod._donotrun)
+
+    @patch('rteval.modules.loads.stressng.get_valid_stressors',
+           return_value=['cpu', 'vm'])
+    def test_negative_workers_rejected(self, _):
+        """A negative worker count must opt out, not be passed to stress-ng"""
+        mod = make_stressng(stressor=['cpu'], workers='-1')
+        self.assertTrue(mod._donotrun)
+
+    @patch('rteval.modules.loads.stressng.get_valid_stressors',
+           return_value=['cpu', 'vm'])
+    def test_noninteger_workers_rejected(self, _):
+        """A non-integer worker count must opt out"""
+        mod = make_stressng(stressor=['cpu'], workers='abc')
+        self.assertTrue(mod._donotrun)
+
+    def tearDown(self):
+        _cleanup_test_tmpdirs()
+
+
+class TestArgBuilding(unittest.TestCase):
+    """_WorkloadPrepare() builds the stress-ng command line correctly."""
+
+    def _prepare(self, mod):
+        """Run _WorkloadPrepare() with a deterministic, fake topology."""
+        with patch('rteval.modules.loads.stressng.SysTopology') as systop:
+            systop.return_value.getnodes.return_value = ['0']
+            systop.return_value.getcpus.return_value = [0, 1]
+            mod._WorkloadPrepare()
+        return mod.args
+
+    @patch('rteval.modules.loads.stressng.get_valid_stressors',
+           return_value=['cpu', 'vm'])
+    def test_multi_stressor_with_workers(self, _):
+        """Each stressor gets its own flag with the worker count"""
+        mod = make_stressng(stressor=['cpu', 'vm'], workers='2')
+        args = self._prepare(mod)
+        self.assertIn('--cpu', args)
+        self.assertIn('--vm', args)
+        # worker count follows each stressor flag
+        self.assertEqual(args[args.index('--cpu') + 1], '2')
+        self.assertEqual(args[args.index('--vm') + 1], '2')
+
+    @patch('rteval.modules.loads.stressng.get_valid_stressors',
+           return_value=['cpu', 'vm'])
+    def test_no_workers_leaves_no_none_in_args(self, _):
+        """workers=None must not inject a None into argv (crashes join/Popen)"""
+        mod = make_stressng(stressor=['cpu'], workers=None)
+        args = self._prepare(mod)
+        self.assertNotIn(None, args)
+        # _WorkloadTask does " ".join(self.args); it must not raise
+        " ".join(args)
+
+    def tearDown(self):
+        _cleanup_test_tmpdirs()
+
+
 def main():
     """Run the test suite"""
     unittest.main(verbosity=2)
-- 
2.56.1

