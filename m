Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795033054;
	b=CswnZKh1aOTp0+mPQkBO+x+WnuSBSAK7VMGckVeddTohJZhj8BA5PV4j1yJmKzQDyECb
	 WIbcoGOcuGNmgEoe3EkyryVRx6uuv+esT7E8P23FZdOaeQZd2nYlKEaSIvA+OJnFcKg+v
	 egF5Te/9w1K+HDMQ2b1paJLzKrLo/1ltRnVB7C7np52bVuzlftLNUdcIustOgpCh6nrXP
	 8YvwTJ5cP0nJaZWScqri7KDwrUheOtL/oGGmC9QoLjQ9PoN+h3dpqR/ECbKo56EpqUrZv
	 +x6ZKVUUf8sQtEGhVZxryAvMi5X/MekAUQfasWUajk8mbEtBh+uGCKW5rGVEcl6lWqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033054;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=lnT+eInUnTPWFUQ5l3uFUIr9/okHk1HtSYw/hG+65jw=;
	b=xEuydDkWOjIDtT7tVnm4VFyeNE9K3X7CwsKy83hrZuDxclumU+tSrQXMu7PK60X5T0GT
	 ZMaKWNqrIC9nUDratMW++nBl9wd7lDL1fO90rV0kYaKdunioAJbvd15cy82KkibyfEKsR
	 eIzqvNY7RfnHLFhSK/MaB1JZBfUnMU7tfyIE2FQTzYWmB52EPpnyH5s9sbfMz63jpxnuo
	 3+jnlNDdPimGi/Z9DaKF3qgJTJ/shySf7pHOrdqVcBpD+eEg336uBTgETiKRtKQXp4sbj
	 r8AvhU2+GnVzVXeiSatQJdmjLjDJZQ2kdiAAxbwx6nEzbcS+8ShAv0B2vmrwUrU8HWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PEiorq5u;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CPTRyJHu;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B92C606A331
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Nov 2026 20:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B92C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PEiorq5u;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CPTRyJHu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795033052;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=lnT+eInUnTPWFUQ5l3uFUIr9/okHk1HtSYw/hG+65jw=;
	b=PEiorq5uiDHeNqN3Zq6OoER4fa2s7zN+5H2ZfFPvqt1qd8Cg1ASczcIcfU9VQ1YV/ZIiet
	T2N8sqE55kOD2nxpf64PrOg5WXMYPJk+9CYhywpkIUjAjC+PX9eCm2MFqzytESYPI6+shv
	IwjLAvUOsqmGYmieF/hXGhUIjh4bWM4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-wfsjxRV1PBOtXXtSsAnJeg-1; Wed, 18 Nov 2026 15:17:31 -0500
X-MC-Unique: wfsjxRV1PBOtXXtSsAnJeg-1
X-Mimecast-MFC-AGG-ID: wfsjxRV1PBOtXXtSsAnJeg_1795033051
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91c6c1e082bso3812506d6.0
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Nov 2026 12:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795033050; x=1795637850; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lnT+eInUnTPWFUQ5l3uFUIr9/okHk1HtSYw/hG+65jw=;
        b=CPTRyJHuEL1bEZY0JzpwnvRX+BqvxCd1KBvSjh/k8k6s8pnw5d4S8DdwbEtYuCF/WR
         3tNDr6EGSB//0KFqox5CvNwgPdFs517vov9CHTc5/1eR6xZmFg0wycy8N8SM+4vIy2Nu
         WmqozOWZ/xGWD8OSyCkmcgb1kpJ/03AmqwF7V0fMTLyZLNNgzrYu54ISp2MIEt5AOiUa
         noQo3D+MJJFRjoHMRcHUsohZucAj2diXynJ9Hlz96bteEsHJbZP2qkaLmkMZcFqEdUf9
         VeGFfW7fUxUO6KkKH7rebbpQvPjUg69lHnNH7nsBMhZ1fkYOuHGBbulxu0dOAgZAb+3X
         tf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795033050; x=1795637850;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lnT+eInUnTPWFUQ5l3uFUIr9/okHk1HtSYw/hG+65jw=;
        b=TuHCw25P7z5J7jkwm4K8lbdyYenDHcaeQPkuqjg00zUUobDQgWXVCHYz39GxCRy4Nm
         z5IblbRnXidT9SE7ZPCys6W86RtlI9tMvz6LhGQRyPzLLNYw1wYwayFWtO065JMZzsVK
         r10nxDuNEhbecdTCDNG7tcYCrxpgisLhqTI4wB01SYwj2NV/NrBwyDxOA40dqdOZjeRP
         ojNMMMGtvpwUoNJrGJAgIQPwo0ZLu3JATPA+y2r3cLrSfWLO5PlmdtI8+R3o/6t+UBZt
         zmKyndD2Ck4h8RdngJGZSBzFOf0b3sA9J4njttkEwcNHGd+Z2k0djINFYO8lDPWOqzjw
         eZlA==
X-Gm-Message-State: APuU4Z8+GuRSh1cDGq98ljygooDv1F5KdgIqoxtIDtSToVZK1VhwIX/N
	9HT9bSR/XPshbmtCdBU/O4cYLM6V1Wm3sYEoveU9S207UQRYXRPXBeHmckcauH7Dl820ST7aB0n
	H2KDsvnQ2ylSUpF8v1WhYwRfobuCXyZrMK//8AeSdiJnmA5a/QhYIPvFKUc6RgHaMrmXYbs0WHc
	aE4oxiJabnrHA2OzZ4h03xFFkgYSRPYiYRnGoF9YV14oTphu6d2cE2
X-Gm-Gg: AZFdTZfDFFOqKf7wuzIUVq0K/xCMWK5rXE2ZftmjXfGpcgptAShT8T+3PmMaUOd1IcP
	OtaSoIPsthYfcyoadTg+tRErSZXlFIE0YRW7Z7J+lX7zA2TkE+xsqlbvUwd515WxgvZANqRhVah
	/PTLLEO5Nd+T+stcky1CkNo/22lemVvY1C+pE/y9Uh+XoCXaHJS3BekckC/R/LQqUC16Z7ttZre
	kNgARMrlj7DqcUmnmQtVrG8QBMB0vm/brIi2HkN1KMvQTvs6TklHxMD4ELXf9jlhRJhOGxeGpQM
	h2m8QDmlI/USJD8ol7wFG5PLKTf2fLcADmnyp0DAuHK7O5FmOFFj2ButldE00Y0vIKN/AvymzGz
	KDFE06EuLxjWmP/aQX+mHUOpsRNJyP0MdiPIGoxBD4fY=
X-Received: by 2002:a05:6214:29c9:b0:91f:11be:e245 with SMTP id 6a1803df08f44-9212437b051mr9646876d6.9.1795033050420;
        Wed, 18 Nov 2026 12:17:30 -0800 (PST)
X-Received: by 2002:a05:6214:29c9:b0:91f:11be:e245 with SMTP id 6a1803df08f44-9212437b051mr9646296d6.9.1795033049663;
        Wed, 18 Nov 2026 12:17:29 -0800 (PST)
Received: from localhost ([98.150.74.58])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921149f894csm30363866d6.4.2026.11.18.12.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 12:17:29 -0800 (PST)
Date: Wed, 18 Nov 2026 15:17:23 -0500
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v6] rteval: Add multi stressor support
Message-ID: <av4H07RjbncE9ti5@sansshar-thinkpadp1gen4i.boston.csb>
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

Add the ability for rteval to take multiple stressors in one
command to improve interface. The syntax works as follows:

--stressng-stressor cpu --stressng-stressor vm --stressng-workers 2
will use 2 workers for each  stressor (in this case cpu and vm)

--stressng-stressors cpu,vm --stressng-workers 2
will use 2 workers for each stressor as in the above example

The second option exists to allow the user to access multiple
stressors in an easier way.

Update the tests/test_stressng file to reflect these changes.

Signed-off-by: Sana Sharma <sansshar@redhat.com>
---
 rteval/modules/__init__.py       |  4 +-
 rteval/modules/loads/stressng.py | 79 +++++++++++++++++++++++++-------
 tests/test_stressng.py           |  4 +-
 3 files changed, 67 insertions(+), 20 deletions(-)

diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index 183efd8..abd88b6 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -6,7 +6,6 @@
 import time
 from datetime import datetime
 import threading
-import argparse
 import libxml2
 from rteval.Log import Log
 from rteval.rtevalConfig import rtevalCfgSection
@@ -356,6 +355,7 @@ reference from the first import"""
             for (o, s) in list(opts.items()):
                 descr = 'descr' in s and s['descr'] or ""
                 metavar = 'metavar' in s and s['metavar'] or None
+                action = 'action' in s and s['action'] or 'store'
 
                 try:
                     default = cfg and getattr(cfg, o) or None
@@ -369,7 +369,7 @@ reference from the first import"""
 
                 grparser.add_argument(f'--{shortmod}-{o}',
                                          dest=f"{shortmod}___{o}",
-                                         action='store',
+                                         action=action,
                                          help='%s%s' % (descr,
                                                         default and ' (default: %s)' % default or ''),
                                          default=default,
diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index 564e798..4792488 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -12,6 +12,33 @@ from rteval.systopology import SysTopology
 from rteval.cpulist_utils import CpuList
 from rteval.cpuset import cpuset_preexec
 
+
+def validate_stressors(stressor_list):
+    """Validate multiple stressor names.
+
+    Args:
+        stressor_list: stressor names to validate, either as a list
+                       (from repeated --stressng-stressor) or a
+                       comma-separated string (from --stressng-stressors)
+
+    Raises:
+        ValueError: If any stressor is invalid
+    """
+    valid = get_valid_stressors()
+    if isinstance(stressor_list, str):
+        stressor_list = stressor_list.split(",")
+    stressors = [word.strip() for word in stressor_list]
+    invalid = []
+    for stressor in stressors:
+        if stressor not in valid:
+            invalid.append(stressor)
+
+    if invalid:
+        print(f"Invalid stress-ng stressor: '{' '.join(invalid)}'. "
+               f"Run 'stress-ng --stressors' to see valid options.")
+        sys.exit(1)
+    return stressors
+
 def get_valid_stressors():
     """Query stress-ng for list of valid stressor names."""
     try:
@@ -25,14 +52,6 @@ def get_valid_stressors():
         print(f"Failed to query stress-ng stressors: {e}")
         sys.exit(1)
 
-def validate_stressor(stressor_name):
-    """Validate a single stressor name against stress-ng's available stressors."""
-    valid = get_valid_stressors()
-    if stressor_name not in valid:
-        print(f"Invalid stress-ng stressor: '{stressor_name}'. "
-              f"Run 'stress-ng --stressors' to see valid options.")
-        sys.exit(1)
-
 class Stressng(CommandLineLoad):
     " This class creates a load module that runs stress-ng "
     def __init__(self, config, logger):
@@ -46,11 +65,31 @@ class Stressng(CommandLineLoad):
         self.__err = None
         self.__nullfp = None
         self.args = None
+        " Warn if both stressor and stressors are invoked "
+        if (self.cfg.stressors is not None and self.cfg.stressor is not None):
+            self._log(Log.WARN,"In cases where stressng-stressor and stressng-stressors are both invoked, rteval will choose only stressors")
         " Only run this module if the user specifies an stressor "
-        if self.cfg.stressor is not None:
-            self._donotrun = False
+        if (self.cfg.stressors is not None):
+            requested = self.cfg.stressors
+        elif (self.cfg.stressor is not None):
+            requested = list(self.cfg.stressor)
         else:
+            requested = None
+
+        if requested is None:
             self._donotrun = True
+        else:
+            self.cfg.stressors = validate_stressors(requested)
+            self._donotrun = False
+
+        if self.cfg.workers is not None:
+            try:
+                 if int(self.cfg.workers) < 0:
+                    raise ValueError
+            except (ValueError, TypeError):
+                self._log(Log.WARN,"Stress-ng workers must be an int >= 0")
+                self._donotrun = True
+
         # When this module runs, other load modules should not
         self.set_exclusive()
 
@@ -74,10 +113,12 @@ class Stressng(CommandLineLoad):
 
         # stress-ng is only run if the user specifies an stressor
         self.args = ['stress-ng']
-        validate_stressor(self.cfg.stressor)
-        self.args.append(f'--{str(self.cfg.stressor)}')
-        if self.cfg.workers is not None:
-            self.args.append(self.cfg.workers) #default is 0
+        stressors = self.cfg.stressors
+        workers = self.cfg.workers
+        for stressor in stressors:
+            self.args.append(f'--{stressor}')
+            if workers is not None:
+                self.args.append(workers)
         if self.cfg.timeout is not None:
             self.args.append('--timeout')
             self.args.append(self.cfg.timeout)
@@ -164,8 +205,14 @@ def ModuleParameters():
     """ Commandline options for Stress-ng """
     return {
         "stressor": {
-            "descr": "stressor name (eg. vm, cpu)",
-            "metavar": "STRESSOR"
+            "descr": "stressor to run; repeat the flag to run several in parallel "
+                     "(e.g., --stressng-stressor cpu --stressng-stressor vm)",
+            "action": "append",
+            "metavar": "NAME"
+        },
+        "stressors": {
+            "descr": "comma-separated stressors to run in parallel (e.g., cpu,vm,io)",
+            "metavar": "LIST"
         },
         "workers": {
             "descr": "number of workers(default: 0 = one per CPU)",
diff --git a/tests/test_stressng.py b/tests/test_stressng.py
index 6211fb3..9da3bcb 100644
--- a/tests/test_stressng.py
+++ b/tests/test_stressng.py
@@ -41,14 +41,14 @@ class TestValidateStressor(unittest.TestCase):
            return_value=['cpu', 'vm'])
     def test_valid_passes(self, _):
         """Test that a valid stressor is accepted"""
-        stressng.validate_stressor('cpu')   # should not raise
+        stressng.validate_stressors('cpu, vm')   # should not raise
 
     @patch('rteval.modules.loads.stressng.get_valid_stressors',
            return_value=['cpu', 'vm'])
     def test_invalid_exits(self, _):
         """Test that an invalid stressor is rejected"""
         with self.assertRaises(SystemExit) as cm:
-            stressng.validate_stressor('bogus')
+            stressng.validate_stressors('bogus')
         self.assertEqual(cm.exception.code, 1)
 
 def main():
-- 
2.56.0

