Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391B3386567
	for <linux-rt-users@vger.kernel.org>; Tue, 29 Sep 2026 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790709570; cv=none; b=dN0Ydq7mrQ0VUSSwLrsOC0UG1z+zAMoaAiD54v04KpHAaXRztoH/52cZbBiM6gsGPh7iUnjN/cCYOe5lzuZfz4hh3/THawczWlpdZNviq05qGEw2yKCHO/6rJKGzLd+626Xjn3l5OrZhFHRc51vMgmKuQKcc5387UJ4FIV+jvrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790709570; c=relaxed/simple;
	bh=15dgtYPfRZT03zySmwyCRmTqXg7B5XzKCPPldn9CHEw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=teR/CSmJMwQK3WZu7aHg1nekEI3zQOsFJ7b3jjKyuhsg3N1FA/9bovpviYE7Ped5Q7hDH2bI6//khqgBPZpwvjmX/Z9jOz1VuEe8nOZ46Ghcd/E1/ZY/wK3GI7n0QIWF5jyIcX2Yu1djtYvr8P9QMEkv/XsXL8dem9aLSDP7yj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cjpCkf1Q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QEDMk9jO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjpCkf1Q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEDMk9jO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790709567;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=xtICPWUNj0B+nJ9T7BlyCcEyMlCVD6+EkFimMWdbMCg=;
	b=cjpCkf1QthkBaT9amwBF4R0kE3ikN/Iom9EnFWrool4YCvGzPRqPrRWcuZax6kq6RB1KAN
	tWyzlAO+WrnGgpKfDEEXcR29ThmDXQVVBNji5rV3sfoD4r1DmpdSQYFZyzLzoi4/t8oNEv
	7EHLRQUrpFEHcObAyeFlCyJVyBhg/Zk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-iU-p9LoaPk-RgRbd5PYNLA-1; Tue, 29 Sep 2026 15:19:25 -0400
X-MC-Unique: iU-p9LoaPk-RgRbd5PYNLA-1
X-Mimecast-MFC-AGG-ID: iU-p9LoaPk-RgRbd5PYNLA_1790709565
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9175cbd3beaso44180776d6.0
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Sep 2026 12:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790709565; x=1791314365; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xtICPWUNj0B+nJ9T7BlyCcEyMlCVD6+EkFimMWdbMCg=;
        b=QEDMk9jO2dphwG7Xzle6v7bLEukbH4hxxFT3465j5asGoGpD7+PTe7xSwLasmduHnZ
         kXOIiuLSIsSNMxh6TPXB0zNDA1p5cpe+uqD8P0mT2BLomhJlA24fhYWd10xGaETjGM6f
         jhpCi9z+80l8NJROGBiwxvv8Hb/WuCqEdseK4/7dVYUS1/Q7x3s27SXqwVH7EWvp6c3e
         Wdcf54lmV6FwaKPj2cXY4t0mtpQiP6ymGRW5TBpd6cNd06QZW18Le2pq8gkldKK6wp6c
         n8X2uCitzc0UBvAKQalN8MIfdr/723utFZMw+099gvdkY/SI860wVJPY8w4RUnKg0xPH
         nTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790709565; x=1791314365;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xtICPWUNj0B+nJ9T7BlyCcEyMlCVD6+EkFimMWdbMCg=;
        b=YDZOhmi6sCwBWwyj8XUpe62t1apAROcWkRzPHyEcyPxG5NzVVQXQ0rqUbMhn7UXomR
         xfx6YSSwVa2IMFF6GvgGNo9Jz1IrdMKQu0a2guKwV6BF7PWuhketkWdEbX5QoIpyaTdJ
         jougAOQx/N00Iiiw/yRmDn0mQV3Z7WtoYWIq7qTe5IsQMkQv7zzFHfs8XH/FuswyE9gU
         Z30xQnw8q4gzROZ+40d25mYIA9XJbRifSTXgJQZrZle5Dl9zHu8tsFfBUHYlejsfoj50
         HdZrCzF03PkJ5FMfOjoRcTJuZurRf/EzHmEcdc221myd92fMiT7LkKxU0ZHui5mWd1/a
         u76Q==
X-Gm-Message-State: AFuF++mAfr/m2HFj9M2COAVxkig+BpM5c9IXK/izAHG6Y4Vjk0qnFxpA
	wp2Vmo6WMgTUts539kN/TWJbmrCQGLG5y04Bt8RGrDq9c8ouhzKAdArwKfoTWzTNncmo+beZ3jF
	Qc0a/8Ilszcbkvpxgl4toIAWTqXfKV2AM/6q6pWa5CDlUlymNv0qV8LdRifbiUhaeLJt5w5bOh0
	8mghAyrcYzXckf5ApcNgsq5tIK/AtY5DrA6rvw3B3tYMs2isB92FVb
X-Gm-Gg: AYBFou26j2Zom1f2HYvcmMDmVibhEwUgHEovEe2GwJ1ssdR3faQeTxzDugIFjLTQ/lB
	uuWsfaFdjA4iLh3xDKv762MYTfDJGReTJ86ADCy8BNtbbSZ8blmW441a0M2wrBx703uGr9k+Rjh
	d19dxmlFRp6Gwu3xIJKA33mA1oXy/l6Sp0Y7F8oxUBOzgwQcursQ3QuS1myN7wumCokQKSxC0mF
	YLFsSchs+MyNe74zjwAF+jvpzbj6Z2s9rjuhDUv6ioyIzoIPxtu1yvjhNS7uAcNLfcu1fzmGrnI
	aww/MSEs/2d/krcBcqJO6HJksLXy4BDwf+XNkKgY+FN2udWDfFF9wjsJQWd/Kauv4GJZ5qevQSh
	Cp5/xvVmxopQMw6kUybJJBhQnBkA78aD8Qg==
X-Received: by 2002:ad4:5d66:0:b0:917:848a:43de with SMTP id 6a1803df08f44-91799a5b83bmr2545886d6.8.1790709565130;
        Tue, 29 Sep 2026 12:19:25 -0700 (PDT)
X-Received: by 2002:ad4:5d66:0:b0:917:848a:43de with SMTP id 6a1803df08f44-91799a5b83bmr2545316d6.8.1790709564566;
        Tue, 29 Sep 2026 12:19:24 -0700 (PDT)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917987e1439sm2381696d6.21.2026.09.29.12.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 12:19:24 -0700 (PDT)
Date: Tue, 29 Sep 2026 15:19:19 -0400
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v1] rteval: Added multi stressor support
Message-ID: <arwPN52esmki-k_f@fedora>
Reply-To: sansshar@redhat.com
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Added the ability for rteval to take multiple stressors in one
command. The syntax works as follows:

--stressng-stressor cpu --stressng-stressor vm --stressng-workers 2
will use 2 workers for each  stressor (in this case cpu and vm)

--stressng-stressors cpu,vm --stressng-workers 2
will use 2 workers for each stressor as in the above example

The second option exists to allow the user to access multiple
stressors in an easier way.

The tests/test_stressng file has also been updated to reflect
these changes.

Signed-off-by: Sana Sharma <sansshar@redhat.com>
---
 rteval/modules/__init__.py       |  3 +-
 rteval/modules/loads/stressng.py | 59 ++++++++++++++++++++++++--------
 tests/test_stressng.py           |  7 ++--
 3 files changed, 49 insertions(+), 20 deletions(-)

diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index 183efd8..a89d452 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -356,6 +356,7 @@ reference from the first import"""
             for (o, s) in list(opts.items()):
                 descr = 'descr' in s and s['descr'] or ""
                 metavar = 'metavar' in s and s['metavar'] or None
+                action = 'action' in s and s['action'] or 'store'
 
                 try:
                     default = cfg and getattr(cfg, o) or None
@@ -369,7 +370,7 @@ reference from the first import"""
 
                 grparser.add_argument(f'--{shortmod}-{o}',
                                          dest=f"{shortmod}___{o}",
-                                         action='store',
+                                         action=action,
                                          help='%s%s' % (descr,
                                                         default and ' (default: %s)' % default or ''),
                                          default=default,
diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index 564e798..24dd7a2 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 """ Module containing class Stressng to manage stress-ng as an rteval load """
+import argparse
 import os
 import os.path
 import time
@@ -12,6 +13,32 @@ from rteval.systopology import SysTopology
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
+            continue
+
+    if invalid:
+        raise ValueError(f"Invalid stress-ng stressors: {', '.join(invalid)}. "
+                        f"Run 'stress-ng --stressors' to see valid options.")
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
@@ -47,10 +66,14 @@ class Stressng(CommandLineLoad):
         self.__nullfp = None
         self.args = None
         " Only run this module if the user specifies an stressor "
-        if self.cfg.stressor is not None:
+        if (hasattr(self.cfg, 'stressor') and self.cfg.stressor is not None):
+            setattr(self.cfg, 'stressors', list(self.cfg.stressor))
+            self._donotrun = False
+        elif (hasattr(self.cfg, 'stressors') and self.cfg.stressors is not None):
             self._donotrun = False
         else:
             self._donotrun = True
+
         # When this module runs, other load modules should not
         self.set_exclusive()
 
@@ -74,10 +97,10 @@ class Stressng(CommandLineLoad):
 
         # stress-ng is only run if the user specifies an stressor
         self.args = ['stress-ng']
-        validate_stressor(self.cfg.stressor)
-        self.args.append(f'--{str(self.cfg.stressor)}')
-        if self.cfg.workers is not None:
-            self.args.append(self.cfg.workers) #default is 0
+        stressors = validate_stressors(self.cfg.stressors)
+        workers = str(self.cfg.workers)  # defaults to '0'
+        for stressor in stressors:
+            self.args.extend([f'--{stressor}', workers])
         if self.cfg.timeout is not None:
             self.args.append('--timeout')
             self.args.append(self.cfg.timeout)
@@ -164,8 +187,14 @@ def ModuleParameters():
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
index 6211fb3..29291e6 100644
--- a/tests/test_stressng.py
+++ b/tests/test_stressng.py
@@ -41,15 +41,14 @@ class TestValidateStressor(unittest.TestCase):
            return_value=['cpu', 'vm'])
     def test_valid_passes(self, _):
         """Test that a valid stressor is accepted"""
-        stressng.validate_stressor('cpu')   # should not raise
+        stressng.validate_stressors('cpu, vm')   # should not raise
 
     @patch('rteval.modules.loads.stressng.get_valid_stressors',
            return_value=['cpu', 'vm'])
     def test_invalid_exits(self, _):
         """Test that an invalid stressor is rejected"""
-        with self.assertRaises(SystemExit) as cm:
-            stressng.validate_stressor('bogus')
-        self.assertEqual(cm.exception.code, 1)
+        with self.assertRaises(ValueError):    
+            stressng.validate_stressors('bogus')
 
 def main():
     """Run the test suite"""
-- 
2.54.0


-- 
Sana Sharma <sansshar@redhat.com>

