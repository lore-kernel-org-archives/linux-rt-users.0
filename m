Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908726;
	b=Z8qSyyFDMKxSXj4yTHT5Wx04TUFGV1Sqym/uTV1UwebgIT7zV9EqAU0py5qM8WZs810/
	 9VbRKBhmP5P8hk5vwsdwzTxIFVa1dlauZG615jb+3ETO0VV7exjx/m3IQ8DEclGW+qE9Z
	 xByhtuaIAqly0dW97LVCfY76rQbnYTadmw1uec3gZ1UCWj6JodLAA6Gza2q9Pa9k+9BWJ
	 VRuu2MnYaPD0WMNAnAH2Pg3kxpzl8UEN3qZZnxFMTGeBwVdOvSDz6dlEdsEECI1l5ZtQc
	 WRkR/U56ILE+FPygq0MaGVYNifEvepGnewBcFLyTpM5Nci7GaNecU2EbjT7D8AnV+xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908726;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=7RxPWEc+KuJASn+fWd41gY8hBHhuT8p88pNFFU+zD1w=;
	b=Qz/3Zg2skedbSJeY5uWH72snWHnEejLkCXjr+S/FDaj/HRhwm6PTUQrJ5NAXN7cCjv4G
	 vpD+a2bOkfJCLNoH7AxKoOW37q3ehTpNVfmUWuiOPyx2/sSty072IZHexQXqKVZPr6mSQ
	 2RXIyFdbsTOrsDWzE57/uE7++ThliL5ev/0/zV8j3DRmKqvwG7OhURt/k6pcG5flwBKEL
	 CkD/P09WyiwGoyM2E+BKjA3Kx0q49coXD65YU7GFn/1X3T1GDZa18SDa8Nw+lLSZOM0oA
	 7v3Uu9eAjou6vsw5po7wg3hcSqKUuHbXYRy8qUPfXz6AVv2FJozWVoCLowz4QhA7A7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TERfh+nK;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YalFmlhp;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DF3606A6D7
	for <linux-rt-users@vger.kernel.org>; Thu,  5 Nov 2026 19:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7DF3606A6D7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TERfh+nK;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YalFmlhp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793908724;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=7RxPWEc+KuJASn+fWd41gY8hBHhuT8p88pNFFU+zD1w=;
	b=TERfh+nKo9lA+wExScn+I3FzpaB1UWRHJL2jda8ItmDTPm7tzfEpN2xTwVpVrYDQocSgH7
	sLBb8xeC7eC6a8AQ1kCFR3M/7RemUiUhGTnNG/anQVzYXQdCWOfGlKyKJt6/ECBu0FX96M
	rc2iYs9hVDZd6TBSGRDAonFd2eg+fbg=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-eFIzeTHfO2mia7LNmy3l6g-1; Thu, 05 Nov 2026 14:58:43 -0500
X-MC-Unique: eFIzeTHfO2mia7LNmy3l6g-1
X-Mimecast-MFC-AGG-ID: eFIzeTHfO2mia7LNmy3l6g_1793908723
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-88322409239so36062497b3.1
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Nov 2026 11:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793908723; x=1794513523; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7RxPWEc+KuJASn+fWd41gY8hBHhuT8p88pNFFU+zD1w=;
        b=YalFmlhp/7o2BET4cO7psIyhfJDckzwEvDfM9enP05RkHEUJUiwLDN9oumnInxB+hZ
         urq3vR5ZcXGuVwc+0fYXrmQuCcjszwCwPB0dqpA+xZQX9koSzKHAxMJj5xhrGHuaf2+d
         Obpne6XroD7pq0cihh8g5c32li5f5XYagjHN3QiayEIUEw5CMfYBy20TIaU9OJssjFM9
         v6MznrKnYb8qe6l/U9LmC67YBjONz3CAK8ujbzMpogVbg5TWNA+7T0a/FzXBOpItYA4I
         mF4aOH9MZhDGNhCK855l0Dx6/PrVdJIf6Dnjskfuv7Ask0zF+G8ZtgVvS5O22wOIRrvE
         rQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793908723; x=1794513523;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7RxPWEc+KuJASn+fWd41gY8hBHhuT8p88pNFFU+zD1w=;
        b=05vMlSWSKPTmeZURtlvtGTalJsJrZk7zppfiMMV1NbUGyGk1+H07d9jjhEo+kVu/b1
         926LfiGUu9xHywQebTS9d+lGzRirGeCOrkEfttuUBGZsFLIpotR1l4gDVhc32/O5Wlhb
         kgwtJ7F3S/MrQ9KhsweyeKQMX8o2zOTBScmIB0TS1qtY0y3WWbFvMWYm4c9NlYmaNqqG
         AgBDyR24zL3o1z/pVFGZqfoyTaOcXLIaLQ1QEwxgCUPFt23UYJFk+cVZ4HMevDWr5HRJ
         uyEA7vbei20vBQ1PFRGdFNdjPn4FR7L8XHWJbERCGli/uvkylTnpucLYwQxlZKtZHjHn
         tiOw==
X-Gm-Message-State: APuU4Z8V5Hr9mBztgWMmKhVD/LYmteV8LaIIJdCBV5O85wYBF0iNFzqm
	PYPm/Vtvk/8O3K9DICi+MFWORUjICgZ5+4GAtDQQOwN42HFptcKmas9DHe0JEwxc1khHgQIBDiB
	iq4e4kwjB6LeAjlg/8RL2AytfR8vfQhq6n8d6e+69PdrIBw7smoOvw4vS3U0GYSJ+sv/2Sr0rqX
	y66L28Pmsm/imEjPgxn234i9cp1auu+TXmuMYeJsqz42iYg14vv+ibzdg=
X-Gm-Gg: AYBFou1fQXST7rKK0QAxhLAZXwKFz8jzs33Fznp5qpvhXP5t2C83yKw6IngrE0CVA1W
	gEtYzgFFXdC2NOx7qYHg756Nmt1roKXOJMSlxHfngU1OOgRyBO+hSN6MNSgnqrqV3Tq6zGEoDs0
	FCsLR5h7QR12iJETFnjhvatfa9DWHHD5xM31mLvMleerry8am/XqVFPGSAp33zR8Fq04RwKB5sh
	dP+3SADrs0SDHq1hOVkAifoEBP/hP3XW43RDRxtU46uFAlByjxm19+d1VrHv+ENdSfZEMsOr8+X
	xPdkQb1fXokU80HWdxGT1ok3+xnmgNiFWb+wVt/uFny0ePnyjEvehVQVBnVjdiAUAYpeY9TGvP/
	J3iJwyhE3cJ2nWJmC9UYpa9lUrquE5cU91OohzIHrmU3nH+gu6BwjG2hfwvTvd6FXyO/CD/aG5s
	ECqpVYdg==
X-Received: by 2002:a05:690c:39d:b0:8a8:8456:a96a with SMTP id 00721157ae682-8b341960176mr397897b3.28.1793908722626;
        Thu, 05 Nov 2026 11:58:42 -0800 (PST)
X-Received: by 2002:a05:690c:39d:b0:8a8:8456:a96a with SMTP id 00721157ae682-8b341960176mr397647b3.28.1793908722080;
        Thu, 05 Nov 2026 11:58:42 -0800 (PST)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f3c9730sm3497147b3.0.2026.11.05.11.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:58:41 -0800 (PST)
Date: Thu, 5 Nov 2026 14:58:37 -0500
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v2] rteval: Added multi stressor support
Message-ID: <auzf7RDoKWQI9mvP@sansshar-thinkpadp1gen4i.boston.csb>
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
Since v1, the extraneous import has been deleted and stressors now takes
precedence over stressor in case both are supplied and a warning is
generated in this case.
 rteval/modules/__init__.py       |  4 +--
 rteval/modules/loads/stressng.py | 62 ++++++++++++++++++++++++--------
 tests/test_stressng.py           |  7 ++--
 3 files changed, 52 insertions(+), 21 deletions(-)

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
index 564e798..83f9914 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -6,12 +6,39 @@ import time
 import subprocess
 import signal
 import sys
+import warnings
 from rteval.modules.loads import CommandLineLoad
 from rteval.Log import Log
 from rteval.systopology import SysTopology
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
@@ -46,11 +65,18 @@ class Stressng(CommandLineLoad):
         self.__err = None
         self.__nullfp = None
         self.args = None
+        " Warn if both stressor and stressors are invoked "
+        if (hasattr(self.cfg, 'stressors') and hasattr(self.cfg, 'stressor')):
+            warnings.warn("In cases where stressng-stressor and stressng-stressors are both invoked, rteval will choose only stressors")
         " Only run this module if the user specifies an stressor "
-        if self.cfg.stressor is not None:
+        if (hasattr(self.cfg, 'stressors') and self.cfg.stressors is not None):
+            self._donotrun = False
+        elif (hasattr(self.cfg, 'stressor') and self.cfg.stressor is not None):
+            setattr(self.cfg, 'stressors', list(self.cfg.stressor))
             self._donotrun = False
         else:
             self._donotrun = True
+
         # When this module runs, other load modules should not
         self.set_exclusive()
 
@@ -74,10 +100,10 @@ class Stressng(CommandLineLoad):
 
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
index 6211fb3..5961ee2 100644
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
2.55.0

