Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249934;
	b=zC0qCR0jzzrZDLhZKV1Ialntug8RjdqUmgfLlol97D4dG2e3iRrq/nRPJjH2xxFTr/Vx
	 dfWX0YW4kAtctLS3RS3MeKpYALrntdtWHNWOE/DZRjGh/S25gjDIc4sooaPxjEanKi2be
	 KQ5uy3H6fxcDgP7g3/yRjpiBf9IwtKZiDSe+SN8fWTQlOfi6ZISrJYJ6l7fgt22ewuP6Q
	 1GQY9ykC1VIqZD7Q/a1TzbulSzU6FsDbkoijuh30Bev+MedDa0hTCniV1QGK/90Kt7ucG
	 GokAX+zgiVQJhfEC2uGvr2GnBBPzrVoIKmZCvfS8qrhBRFf8D9m4NBQIXBz8/9v5rWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249934;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=pSqum1gjSHyKgFJcvVz0649cYAAwpDXkPUFJYAxFkqU=;
	b=KbaM9JLvLr/ettHXDZ9hVMM7nc+HX5aIzqlC+uOAvsaJMvKnD1YbPbOm/hjRlPyTAHJY
	 27JvTRci3mZx9dfcWE/dm6kFlcgKruKg+iKMoAmrsHEXTyPQ4wSTdCZ4Oq/jdFSj+Q+b+
	 te6IxyQtad6hdt9boQTGvMHq0V7npx6g5DB8NJhZyTUvAu0dcudg1XmB76GRgacVgtXB3
	 SomoCdvICvFofKS1hwYDlRf6GlBHB87prbASNMM1fmCR4LwXSJkqMe5eGO0yP0+l3bSbq
	 aZEi4llkgvqROG4nQHR7VB7FDn1+I4A311wMXqqgh5hguBNRqtYjjuOmwJpLaqVj7XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VM3yZdP6;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=A4MQycKP;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AEF606A31C
	for <linux-rt-users@vger.kernel.org>; Mon,  9 Nov 2026 18:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0AEF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VM3yZdP6;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=A4MQycKP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794249932;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=pSqum1gjSHyKgFJcvVz0649cYAAwpDXkPUFJYAxFkqU=;
	b=VM3yZdP6zEis5uT6AQn43vkmeHZLWDQ5fBkmaFmsyn+PcnmMMimQxYeU8v84qzK7D4DIiG
	2D+j7/Tkcbgi51zY6wQJ/BGOPWMZzg4ys9bL+FRutOusdVKQ4GUB9C0AYPlAOg1wycfick
	Hr8R7zaPWx+oL3XOs3uu4ej73oyYQRg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636--SylVen-PqiSXqj-72wHoQ-1; Mon, 09 Nov 2026 13:45:31 -0500
X-MC-Unique: -SylVen-PqiSXqj-72wHoQ-1
X-Mimecast-MFC-AGG-ID: -SylVen-PqiSXqj-72wHoQ_1794249930
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-54e98c9e752so30974111cf.2
        for <linux-rt-users@vger.kernel.org>; Mon, 09 Nov 2026 10:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794249930; x=1794854730; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pSqum1gjSHyKgFJcvVz0649cYAAwpDXkPUFJYAxFkqU=;
        b=A4MQycKPMR2ylltCx47iIu0GjDPIRq6KvZY1sry457Xw7ezbS5kIkZWfABstdPHlLa
         DLBt4gQmnCLlJYMLOFk33jGr76C75vSB01vu6wHDDWoo2ytKFOQGFS1h5iaRwlEnneBd
         FXYLlTkZuJw0L08gTQEimZgaEbo28QHem72rokyStUobqjHRE1f5waUynFUeLu+WFn9H
         rnQN7oDxfIN0wCAMJLZ6eZ7dWczejYWngHcb5FCp+awPqLGtaxCWZgm6+jBRwcX8cP0E
         Y1WrCtyegxkyjQfqTQJ23spu3FlNsDuOu0fXGe3g7IvleAAa8tWJrVPmUZ+oVqoKtyA6
         AsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794249930; x=1794854730;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pSqum1gjSHyKgFJcvVz0649cYAAwpDXkPUFJYAxFkqU=;
        b=omLML2pOtmzaWEqfIoprIpm4+ue7nU98dfimQQvWHyIEfzgINrDl6WKr8T4JUwuLv+
         pqPjNLOryyvKzTMvmCBzyeOQX7r2FHHZiUjDxK1J7FrCL48hEACxkHuOB0CI68rKfTkk
         xEm0+CBZ4PRINqwPDo09TxZDhhY330wNNFUcq0GJRBvomoGh1DpgmtxyHD9eyhPrNbkg
         CRUgRl+nJiLsVrm4RMrxNS++I0hIpYqF7udjUw65vScgrHKELtpJsUyVAPboX25GAIqW
         Ekp+FweVgAKBQciDmwogjfj2SpefUE2Ab21MAVZ6rS9vjZZG9XZPE3Ektgb8P5ABfaSd
         6xcQ==
X-Gm-Message-State: APuU4Z+pJjcKkMzyCpvcqfTe409aF4B5R1ZgX7F3i0uVZrG8whMiDlrt
	LRh6TjpnqLSfs0Jftd56Yn16E31sc2eRkzVk1HKTnh6SEwnGcVUDV8IzD7o6zItlZKHlt7hvlah
	Dm9vM/plcBxtwGScBNGOt7jBhbohFJqsGZLDV7pgoAQX9wcVIBzxtnsAzhJpg/1U/nQ61Tlvk0X
	vSAxK9ejwceZiHw2llc7IH43DfOGMpkRWB7zHYdToziEu2RRqFF0bXOiZ42Q==
X-Gm-Gg: AYBFou1aYV2J4DRF7UCtepAOOO59GXhPlaK1tQBFr+oBgZBeM1Vvzb38J5UgXA4PH5p
	Ico2NtwEK30ODJPm+y08PfNpmt4owA9b0izeXpiYzS/3fzLopgxOAtTKzgJg35/FH2dGJ+o3ung
	YFcYfJgkaYfxsblPuKUPIF2vGnLrXxNF1irdQnAUD70DYvRWbNcLgmw8ClT3qwpPHk9rxQov7TJ
	trBNzqTqnREm4PzyS9PmSUlBr6OSIplll5gBCTSdRrogpD/fQF70tmD0YLBkuA4VxgFv3CnoAsC
	nIi4DOo1HKvR4tGLdwUFtP05VDZJKysiFc9Pvo0cCcrbMLV011MBgULjoL2JcPJHmqXtiU0a9eZ
	Udb+JsuMR1Z9PWI3oIAxJNvYFGpP6VKyX741uYIxQ2IwrNS5sUEueiSpyhAyHhHXSNySPggaqQh
	qzf6o8UA==
X-Received: by 2002:a05:622a:5512:b0:536:4df9:d95a with SMTP id d75a77b69052e-55529f6f869mr2552731cf.40.1794249929701;
        Mon, 09 Nov 2026 10:45:29 -0800 (PST)
X-Received: by 2002:a05:622a:5512:b0:536:4df9:d95a with SMTP id d75a77b69052e-55529f6f869mr2552131cf.40.1794249928910;
        Mon, 09 Nov 2026 10:45:28 -0800 (PST)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04f89c1sm2249416d6.23.2026.11.09.10.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:45:28 -0800 (PST)
Date: Mon, 9 Nov 2026 13:45:27 -0500
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com, darwi@linutronix.de
Subject: [PATCH v4] rteval: Added multi stressor support
Message-ID: <avIUxy2lpHlwtb4L@sansshar-thinkpadp1gen4i.boston.csb>
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
Fixed the commit message to use imperative language and reverted some
changes from v3 (added back the sys.exit in validate stressors and the
workers is not None check)

 rteval/modules/__init__.py       |  4 +--
 rteval/modules/loads/stressng.py | 62 ++++++++++++++++++++++++--------
 tests/test_stressng.py           |  4 +--
 3 files changed, 51 insertions(+), 19 deletions(-)

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
index 564e798..c586965 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -12,6 +12,32 @@ from rteval.systopology import SysTopology
 from rteval.cpulist_utils import CpuList
 from rteval.cpuset import cpuset_preexec
 
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
+        print(f"Invalid stress-ng stressor: '{" ".join(invalid)}'. "
+               f"Run 'stress-ng --stressors' to see valid options.")
+        sys.exit(1)
+    return stressors
+
 def get_valid_stressors():
     """Query stress-ng for list of valid stressor names."""
     try:
@@ -25,14 +51,6 @@ def get_valid_stressors():
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
@@ -46,11 +64,18 @@ class Stressng(CommandLineLoad):
         self.__err = None
         self.__nullfp = None
         self.args = None
+        " Warn if both stressor and stressors are invoked "
+        if (self.cfg.stressors is not None and self.cfg.stressor is not None):
+            self._log(Log.WARN,"In cases where stressng-stressor and stressng-stressors are both invoked, rteval will choose only stressors")
         " Only run this module if the user specifies an stressor "
-        if self.cfg.stressor is not None:
+        if (self.cfg.stressors is not None):
+            self._donotrun = False
+        elif (self.cfg.stressor is not None):
+            setattr(self.cfg, 'stressors', list(self.cfg.stressor))
             self._donotrun = False
         else:
             self._donotrun = True
+
         # When this module runs, other load modules should not
         self.set_exclusive()
 
@@ -74,10 +99,11 @@ class Stressng(CommandLineLoad):
 
         # stress-ng is only run if the user specifies an stressor
         self.args = ['stress-ng']
-        validate_stressor(self.cfg.stressor)
-        self.args.append(f'--{str(self.cfg.stressor)}')
-        if self.cfg.workers is not None:
-            self.args.append(self.cfg.workers) #default is 0
+        stressors = validate_stressors(self.cfg.stressors)
+        if workers is not None:
+            workers = str(self.cfg.workers)  # defaults to '0'
+        for stressor in stressors:
+            self.args.extend([f'--{stressor}', workers])
         if self.cfg.timeout is not None:
             self.args.append('--timeout')
             self.args.append(self.cfg.timeout)
@@ -164,8 +190,14 @@ def ModuleParameters():
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

