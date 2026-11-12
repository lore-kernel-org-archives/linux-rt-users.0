Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510551;
	b=UvXErpUbCx115LAblb6IzZPi4NMecZkfp1ji8JDPaEhGHPyZaR0BGdDNxjyB5Flt+IF3
	 XvJIC/anHrwhrFacvIhsetLJM3YikAtVuXta83372p7cIUgMkfu5EKrJD6IG3B2GYlvjB
	 MR4lUs68XB0gg1BqL6sJvW/eHbPzi+V2EtI2dPBXMUZ/yDZSbtNHY2hgNBN4x4X7bUual
	 HNJKgfM7ra5nLfaUHkYdWjZbs/u8KHgdRjBpMqg974GtBvciKEeVjdARLeLtiCzEq7Mwg
	 Go68egFpp0LVHbvIFIc29w0N5OBCwRUYiWEeHWIVzZ4AHy/vfq3jWRhhUObM68HwG8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hCHxl0oz5ddh/GC3Erx/5wdIyySlOAUBoBlpbSXA63c=;
	b=GVGigkJuIJi7iYQ7gkHNU+DNSNhIKKNDCwe2855kzglQ5RdWcvV/HlSl113wBuZkq4PC
	 D9H9DE1kWxL023yQ+27rrKdaQgVEt3soAMcvs+VnZk/6bs7mCnXxPsQ3KT/eOsGlwwBwe
	 P09hDVdfCNnwKKbgMg9i8AlxIHR6EiBOXWkizbc68WUGGzlphvScGx0mRy2CS9p8FADol
	 samDH9Nh/SGnKqcxaUOeMpKgoVJAPzxQmRp5Yq79ef+kd1gs7OpbGzd1/itMFXainq7yw
	 8zg2tl6JyQl7vG2gKhWLqvKmF8IJHhcrIH3z6wYtgx+xB+G6euUtx4l4cdRdS1NlK/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r2a076BM;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B184606A31C
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Nov 2026 19:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B184606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r2a076BM
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53644b28706so571971cf.3
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Nov 2026 11:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794510550; x=1795115350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hCHxl0oz5ddh/GC3Erx/5wdIyySlOAUBoBlpbSXA63c=;
        b=r2a076BMk0kHHI0ZYJpdBFrmGok92S+azLF1HAF1jxuf9ZMVNBOG7BI4b+rR6H3lcT
         HKBZsqaRaJV8oK24KrxMxt/IULNbhqeLRNJ5pCVoUm7Q3LtkfFgtV354YRwWGPcJDsZF
         rHOsWnYW868duMxOMki5NAqZhjS41lf8qdMYwcy8dZ4dCXu+vwt40PHBWJKn+RGwo65Q
         c67ECeklb/7G7hm/H8XEyOTPgnHu05dvdur7A3taaaC637K7N8uLUaxM5iWd6hCe9Of4
         54uACbjtrzs0GnlRa7mQMoA5pYkAD3xUkKem4kmSkDwRqhPZsPW8lkWlO24l0+AoAroE
         dh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794510550; x=1795115350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hCHxl0oz5ddh/GC3Erx/5wdIyySlOAUBoBlpbSXA63c=;
        b=kKG3RN4ABbsRbnio2AAjN1kpr4FLQgSwm2JHXtEHbGMbHXaZNQ34fS2Xz08MBcEkOo
         IKWbkIQT+LrmgE2t4WaP1+1EnEln+RWPbdAKVW53ZLdKxFiJogKtufTyEHJLSrJPoGtD
         lREh3zo/6Z2VeGchB8RLdExFdAB49TxRNQiHC1NcDo/WuW19bOx3srX1HDVzX+M2MA/m
         YZ0n7aqC6lk5QEhNYvtrGNyjc1KxEff18p5Ue/i411Qftw+Ds+cnYYZQQ1VWa3sJHu0D
         ycy96a/v7w79RK4lhBpZRGzeFoP7zqMBEFdsAsB09Yh3bDvDXLj3Pab8/N6nZ+S3aAMC
         DCrA==
X-Gm-Message-State: APuU4Z97hOLpI5LURJCa6NEljdgSTMBTTEu6lHMe7K1xUjRzAbmnZixI
	GwYK+oLaEnczZ3G3j4nUvrpo0lc6LDGJQNu3PBrP2ZNkLoVZW0WCG3it
X-Gm-Gg: AYBFou2njofrN+99V2nDD6y4befWrxQgkQyutyVmlujpxUuURXXTEX1TEqvDF1v87Sk
	CsJugE09K6Oa4+K/mt9LoxKOoxYJa59wqV1gyZDbkx/zbhYkLtP6pX4RafovilN03snIL5at+Bc
	sENgeoSiMkkl32GMUTV+za6eNxvCiX73Wt2XuST1nyWtpFAYaOQsl86t36F71Ppf4qo8gTdVclI
	5u+LCPj99a7eP2GK84pQZal8ToQq/jJRYpBMyZ2n1esruf3vavFUIXO69xrSKlUFqVr2ZNmVXQy
	QgWwrys/1L4BgfFwmoC/rEFEAyoy4IJp0QC4l7pOcwS5Y/VD9zGGtFZOCntbhNLK716T8Af849c
	+LRyOt4Qev4Jo8mfMNo7UM+cLRxVSagoPRE4fUVix8PTGIcwtXXtPjfuHN3NWwFgEs8rvviGtl6
	RTLuxwVHKFa804tG4C3Q8q6iHx3ugrH+epu2biDOCJGMdYYLzJyPiVhUtwwDwBpFR4sZKeyi7Wz
	CTt2gf/t30vrbOlwe32khPu/9YV0c2Vy4ECP/qHrnYQWiLnf4wkwbJCu47vVG6W/HA1+WO3f9wK
	3nySOrMROkidMATUyLmV2za3xaAnY8EPTgT1nEXrfn1NguWdZX5MEfWrvdgHXEXTdAb4FTD6luF
	NBtwW+vdQvB3b450=
X-Received: by 2002:ac8:5744:0:b0:559:deea:e963 with SMTP id d75a77b69052e-55ac4987605mr6616561cf.8.1794510549862;
        Thu, 12 Nov 2026 11:09:09 -0800 (PST)
Received: from fionn.redhat.corp ([70.53.46.49])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad15eb7basm1552311cf.26.2026.11.12.11.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:09:09 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Sana Sharma <sansshar@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	darwi@linutronix.de
Subject: [PATCH] rteval: Test stressng opt-out and arg building
Date: Thu, 12 Nov 2026 14:08:55 -0500
Message-ID: <20261112190855.71686-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <avTIInVsSYe4YhSa@sansshar-thinkpadp1gen4i.boston.csb>
References: <avTIInVsSYe4YhSa@sansshar-thinkpadp1gen4i.boston.csb>
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

These encode the intended behaviour and serve as acceptance criteria;
three of them fail against the current multi-stressor series and pin the
outstanding defects.

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
2.56.0

