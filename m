Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426929;
	b=B0WHGPYrwVuSQzKTzUZv/LMG4bU8Oiyn7v5WMMmK/Tz7G4hIp3GeVu4Jro3sdenwIH0I
	 hA6cF5lG1T8s0UwnVzGFqQws2hs9FyNztPxucoZMfbTynX0QcYSJXwaOxx/0femqIKc17
	 970G17y1uhujlfsa4UZMPoALCXnN4qI6x8oN+nZfuSOiHNpdDueUGX2u82rbGF8eE96u5
	 cGv3aO4U7Cp3MummzLsPgygb7QExKZqROIjAwIFBYAxq10FAOIijw3QynZIIDGkqp9uQL
	 M9rS5FcanFLD/sv+R8gWpuNyById0zU8y69PDcVeJ05wRUf27ehoczoVNZccXWQnAYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426929;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=crtnoGY+nCOaAobJdOXOox8pAfq8GQjfKtLjwKWPQsw=;
	b=NqE4r2zlQ+1FTv2J2PrRSZFNDMx26wI8tMmPErYHPo0jNsv5iuGK0XgaIX8Q0HcKkfcu
	 IKB+CwGSkf9ESSbkZ/a3R/ZqkmTMqDoQwVPmuHXe4A3bNt/Gmvz5/zK+S3g5vnJRHFfYG
	 2YiNAUiA60pGPZis9UZb8GbkzlELZbaDoI2ZdEb5q3PdtTsybMP3JLJdZUeySQgQl2HkK
	 ToArTWaiJlZbr93nvL9er7Yv3G78VVBoqQQ0uFYdg5k62CouFC9UN3o3XDSemM9eHZdoO
	 sHS8l03wCxeOBO+7cDUfjVOXELO3Z4B/1dQ6dLVD2V1Y2VEL64IKpX15AUQSACvlFHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TeCyx1VX;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EStr2xj3;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD3E606A31C
	for <linux-rt-users@vger.kernel.org>; Wed, 11 Nov 2026 19:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD3E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TeCyx1VX;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EStr2xj3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794426928;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=crtnoGY+nCOaAobJdOXOox8pAfq8GQjfKtLjwKWPQsw=;
	b=TeCyx1VXIJSOjiDiksdlOgnpad7S/xs0hlC6py8ocVBwh6s4MXwVQfNknWp+GBGkjC5Hm0
	wmazJw0UneDtjP+Pmo8pwjfNZU4Nb5hHcbQw3xM6wTNQMVJ+tCT6FpbH5K0Pn1tjiqh1vn
	QE6NtYxynX9TfvDhURXZ6PTaKmGSoO8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-9d7DStwyOcSFCCAPbiywJw-1; Wed, 11 Nov 2026 14:55:26 -0500
X-MC-Unique: 9d7DStwyOcSFCCAPbiywJw-1
X-Mimecast-MFC-AGG-ID: 9d7DStwyOcSFCCAPbiywJw_1794426926
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91edde88d16so47952346d6.1
        for <linux-rt-users@vger.kernel.org>; Wed, 11 Nov 2026 11:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794426926; x=1795031726; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=crtnoGY+nCOaAobJdOXOox8pAfq8GQjfKtLjwKWPQsw=;
        b=EStr2xj3p6K5ngSMF1YVbwQQlO9oThvXtKhW/iXf00R/coalOXS7TDrBLDLzuPQvJ3
         w5xQAP+XCA9+QQyH2SsccJ0wM7HgyvuM1PhxzPmPhPUGNZfaExXALclvL4NSjsUSzoOB
         ys37zmP7tTx1GaMgFA1Ucf4nEIgtEk9yWlYpFkOD18MeyJpNvfhf4Y58OGZcOWIpo1jr
         b5EMSvIeewZ2kMBvMhSVsSDW0VsCwBJ4NiaBNADBuqXLfvPnVfTR1+qJoraSiDqXIFMN
         2gYiGmRWg1VGpKlsABW+Vbb1dsrPIn6mvDSV9Invd2rpiJdnDnDycKqQSTNREZ7vuwNq
         jQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794426926; x=1795031726;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=crtnoGY+nCOaAobJdOXOox8pAfq8GQjfKtLjwKWPQsw=;
        b=HOI2Uw2wTOlQ2jDxc0yZE2h8lGftshiBgDI/CuaVNTNS3wv8jkdw5f634uRSoQGu4f
         iYK1pLWxOYbpUAc/d+eg3jHbEVFV2CtLzl9dg8Cchkluvi75ZsJy9LiFrJiNfY4JbGbg
         GiXOIZriqvs6vm+7xIR/L5Cj84y9FwRoj7+SImye0llA8BFwcxGxsmxK3arNK2N4DjiG
         xEbwIG7ANnLomEus2yKajjbjzFbT/UrPOs4zBtg+cWDKW4RQro+ExuPndHdK9eKkk2q+
         bsPLZiT5np2qQfjFaxpjXVEDs1vl06fmXt30i1vAzzT/iH6bkzADYKpDDvMvyCXg1vxW
         LHcQ==
X-Gm-Message-State: APuU4Z8+0Bdl31bJYWIjhTmXnwh4Qp9lPSup9wPvF+UVftdzxaLwcRff
	2IqnzNp5JyqII4HiE35ayVC/Nz0gdFWz/QROU9hWrdcqmOog1VmiXQNYu6+OcUokDbiV9QFknjw
	c8v7rCRU5RpDmSA7FsJJEfjp3FlBzns+C5a1bcedtCrY6NUxhmpeU1+VS6d/prne3J/VSLUGFf4
	J9EzJMgjm1tAAkTkfLdO0aU6kgtAZLFv0KN41J09fSywKm5lmwt3yw3SM=
X-Gm-Gg: AYBFou2cWR5y+i4HwiAW0ZOT3jFjvdUe3qVZfuHGkUF0tSGi6wTV7/p//nT335kjjSG
	XOF88OG4qcSnNkUJVfOV4RcBCPZmpH7mJvDEFKjkil2LeK5bkmMFcGc51zGpni3RkvvojzNiZml
	+bL7/67N2+eajDcZa2kAjb9ZhRMPJVvP7D2bTFQtwdI5YZ7dz9nC/Tb4o2mcHcsz2+p2tzQLDlv
	5qOVALytrc9bp3n1IRLl5kNe/3qq7oLGqtuWoKty2Z/ulGH8YUco6sDqolKKRLP2kHXWFuZTge4
	Xd1ksarTY+7Ne8zi90wW/Q9Mi+5s7A42vevg1azxXf/kaY0Ux7wndPYL8TS31mo0Oft2Yhs1F++
	V2mCUfI1VrPjpEYWF10Wz0s882HRSy16VVwsWK8u/kh3sJXuHyJJCGUlshdp4xzbBKycAlJhx5u
	MroSN9B5A=
X-Received: by 2002:a05:6214:2623:b0:91e:9469:1b91 with SMTP id 6a1803df08f44-91f0418dc2emr58182706d6.50.1794426925738;
        Wed, 11 Nov 2026 11:55:25 -0800 (PST)
X-Received: by 2002:a05:6214:2623:b0:91e:9469:1b91 with SMTP id 6a1803df08f44-91f0418dc2emr58181986d6.50.1794426924920;
        Wed, 11 Nov 2026 11:55:24 -0800 (PST)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f046e42a7sm27162406d6.31.2026.11.11.11.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:55:23 -0800 (PST)
Date: Wed, 11 Nov 2026 14:55:14 -0500
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v5] rteval: Add multi stressor support
Message-ID: <avTIInVsSYe4YhSa@sansshar-thinkpadp1gen4i.boston.csb>
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
index 564e798..dd71387 100644
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
@@ -46,11 +65,33 @@ class Stressng(CommandLineLoad):
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
+                val = int(self.cfg.workers)
+                if val >= 0:
+                    workers = str(val)
+                    self._donotrun = False
+            except (ValueError, TypeError):
+                self._log(Log.WARN,"Stress-ng workers must be an int >= 0")
+                self._donotrun = True
+
         # When this module runs, other load modules should not
         self.set_exclusive()
 
@@ -74,10 +115,10 @@ class Stressng(CommandLineLoad):
 
         # stress-ng is only run if the user specifies an stressor
         self.args = ['stress-ng']
-        validate_stressor(self.cfg.stressor)
-        self.args.append(f'--{str(self.cfg.stressor)}')
-        if self.cfg.workers is not None:
-            self.args.append(self.cfg.workers) #default is 0
+        stressors = self.cfg.stressors
+        workers = self.cfg.workers
+        for stressor in stressors:
+            self.args.extend([f'--{stressor}', workers])
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

