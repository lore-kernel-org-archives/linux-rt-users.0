Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981502;
	b=AWH1XLscGQv8j0rl8+helqp73GN53bQcYz5TgrlaIHyoUymXFZ8uhvHx+i7XBnY2a/kZ
	 p9AYpPA8pI1bWWYlAHRaCxsvNXp5RiYw+0RcYKgUgyx4IN4MYPp1x0erqywy4afPtR7lc
	 N2AVYDQE3qAjJXnfBVah/ZHpbdg5lnd+LbQ4ovdvQRzHZLbtvsmlARIOfgMGG6AFtIoas
	 os69pIe9C/Ia1qB9OJPLN4OewCRWk2eQeUaYNQunUu/g+iKRoplILR01BU8eh22JIDrK6
	 FXQSosl3yhJqgreUMCxs/FetO/KayOd4j4Y704DxDIDPg1oCnIbP2owy/AlQ/lKsxgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981502;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=fZeBT8rNamMQaoIm+evs8KHDsbhBEbxangCyKUrqVG0=;
	b=0PbXJFkxmITBzc2mcFYx1YfX5FtWs3zyWniOWZegKC4BDSAIbqJ8bGh/wcCJ5uuOu9jX
	 KeNmE6N0wsECs+soqKE2bYIPLVMotdJfwmAlD45BU3q5QT0VRwVdrrmKRI61IgR8eD0Ch
	 /EXoeY5ZtaWLh9DkL/q6fmrEzGpLMbzQpj0M/f6hI50AhaRcSouLPaISAXWrj6ac9tx56
	 0RePaTXW5gSYRoNe7f1tDarJsv+ERG5IyOAdv2FhdOCcKfQEIlNP3enQ1o3eJJ3K8QmRU
	 pdfNMLNgXh6BkZINcAQLKJZarYhxXtqLwwC/tfSaC7HGKcp0B2rjf1i47S4M/2Ic2BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SfcH+eIS;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZAGUiHxY;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1222606A32C
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Nov 2026 16:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1222606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SfcH+eIS;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZAGUiHxY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793981500;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=fZeBT8rNamMQaoIm+evs8KHDsbhBEbxangCyKUrqVG0=;
	b=SfcH+eISAqPmKVRifzVPFTkNE86kCJK0KbDWLCBUIuwg1QefdRAVX9GFBjohBPXFHqV7kR
	tyvPWFHzBzwYMuEBDMi1jrC4pLHbh+NVKln0HfH582KV5VIHAVqr4KhRaXKA1DzidE5hBC
	gd/hyxWzQOGARPQW53dkgFtvhlt7/UQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-khea5-zPO9mnV0M-t0L9sw-1; Fri, 06 Nov 2026 11:11:39 -0500
X-MC-Unique: khea5-zPO9mnV0M-t0L9sw-1
X-Mimecast-MFC-AGG-ID: khea5-zPO9mnV0M-t0L9sw_1793981499
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb93c874bso376010285a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Nov 2026 08:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793981499; x=1794586299; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fZeBT8rNamMQaoIm+evs8KHDsbhBEbxangCyKUrqVG0=;
        b=ZAGUiHxYK7mFblUJIyX5x3pNeX9k6IPZjmJmtoAnBD1Q6X51t7tfz4pYIdZJrOwBNx
         Auq5oFo8lwAcDJPEkrcuIACsFVP8b8mLYteO18fx/izlBnlCGpLtINbSprYDN46N3FVp
         8V/8svcyFZWVDNwYuLI+cRvwBxnRlRvwF1tg7dXvwDUDViY7hIUoQ3Y9PP0B/7L+PznW
         4MHoECYlh9di74WCV4NDCu/GtpsAEaArG4L2OSx2KMBMb10/X+FFUdQutYKeW//zziBg
         6mHLOUdCZ35Zd7Rn/n5hllomwfr2UCNP/bHJyJatG9mTf3IeqjissYDvboQYUeDa5262
         YKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981499; x=1794586299;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fZeBT8rNamMQaoIm+evs8KHDsbhBEbxangCyKUrqVG0=;
        b=2fExcPMwx0CtXwFjVPaf6+wUwoTIYrGuxJSRZvxh/OtIPLqqJgZPktMJAgqWlmAIoL
         kADggMZgn/bWUdCo4xNQ/Um+OMTGiSkTqWZAVsqGHX23JGEjAQw4YCHeNdKPndIXiL8+
         YeViUhZfsa7Vsul/ThYoyG1va6VsY2kgXj2ujoxSZ5jXiqd06ySMjsgSEKKEu873UBEP
         XOeqobgjCQVy/mzE7HQ3nUmJkq1JiqF1Hm/Ex+rD6Hahrkl7N/oNEMpblblJ4KO6MwiA
         swTMkjnz3QaM1SmEdnoMGVAregp8L64BKKNSE8YJ7RcwCsVEcfFEasOrv7TU6KkrfyHR
         Y2Qw==
X-Gm-Message-State: APuU4Z/Pi+xC0pRd57Ya2urcwqe6n2U4iSxViz8HbY/sTW4FvRyjP6Tv
	ccRbqFhxLqoVimXjCvwI9es7saLfY/7nt25z8mfyzdKwi2OV5NR6NrkvdMSqF9VsRMPSWPZpJTO
	emH683PxjFUnmdtKWWyludGj4ohrVZs7uKexuaa0jXe2so59yGDQ4KXTs12MUKJYn/kLjS3rV4M
	LU7KYNyZ+k5a8Z/HaTITcKA8PGB9V8mgWaIL1U7xy/iEES2+PAhouuuS8=
X-Gm-Gg: AYBFou3w/zhr8M+/QS1g568QThdBLdd9zEUnqJd4PrRbxtPXzc6cZg4Eif7rS6XHYSo
	nXxalUxV9GeQ1+UhD3zZ1eQFB6PQS3rxtMQrwQhJHsIkeE0YCHjtyZr5029AEqfWmF6PGMn++Xd
	T70cZ0RGwO0omsxBa3kmX3u8kOmBZq+Oi3BVXk1MfPBmTEo6qVkIIDKZgRnuhUHJCnbDvQ1u0gv
	HxVNMGjLgUojFOK+xcZKwZTZ/H1YWjhpPpmpsAYmOPkBuVyWuzcc8Qf/IKl4QUu1fv/DJaJztCm
	mkr5qRqU5hL9uCVimzTfX3q3i0/UFuOKk+o8y7dGHpWMc+RPOrNFsTVxDLbpkS0+RhKXjWXzSKF
	c/SAkOYOIGNsyWk1zm7FIKz2m32t74sJw2MkkMMrwo+q2OpzeP7ZRgTKcwiUiJ0uZjyLgzk/bfu
	UuLNHB5g==
X-Received: by 2002:a05:620a:44c2:b0:93e:e111:2778 with SMTP id af79cd13be357-945e16a5acdmr980221485a.14.1793981498960;
        Fri, 06 Nov 2026 08:11:38 -0800 (PST)
X-Received: by 2002:a05:620a:44c2:b0:93e:e111:2778 with SMTP id af79cd13be357-945e16a5acdmr980213785a.14.1793981498292;
        Fri, 06 Nov 2026 08:11:38 -0800 (PST)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6ab9ba7sm23594756d6.40.2026.11.06.08.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:11:37 -0800 (PST)
Date: Fri, 6 Nov 2026 11:11:33 -0500
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v3] rteval: Added multi stressor support
Message-ID: <au38NVNsrCvMozbX@sansshar-thinkpadp1gen4i.boston.csb>
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
Fixed a small logic error in v2 where putting in --stressng-stressor
would return the warning of stressor and stressors both being invoked

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
index 564e798..a3f8d6f 100644
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
+        if (self.cfg.stressors is not None and self.cfg.stressor is not None):
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

