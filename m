Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482512;
	b=EFJNtkAnlmNaBlyfQW8836aRZc6KK75hCT6mkNUG9+yo/BrlxQaw0RGGPOgx+kPE0Wgg
	 lXjp7m7N9z9+POyFSMYB6C7hxQNKL4j9Pty70Iel8siQo1d7Ob1a2vPHy4BwDYgLKQ5XK
	 bogLIgHmddYuunfYYIRG5IKko16qvcyDIX0TavIYHrE+vFWZuKWO+Tmy9emX/TROaiyO7
	 dueE/0+WhP7aUH3ahgO6NuAEO16JuPIiq0/TKHurHD6xqAOKBpf6Rt/kX8UW39rJvjphB
	 3K3uMXw1CDuxxFX/3Ue0Do4p+Fp0VPKzCbpqLE9x3WSmKErvZ0pg4CX8EUhTImGaLpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eoqwj65XKovFwDofv3kVdu/5R8xBCaittbSS0B34Krk=;
	b=qjnGvPPVdo60aH4+rhYcI+V2ZYnZCAuVHxhdFCCu6kcQitpNPDSA6/4IG7w+25mACewS
	 GYeJM27Oz6db/ux/JH7rNJjY6/2m6Yrrn/T6aeNCHuVquH5+5/vynFn6jC6o8TAKIhaCu
	 RraujLq8InI1tLPhPggq3SYU0sCpGq1nuKxtq3RIpX7y7Ixz3l87FgVyZc1FQiONDZ9Nk
	 Bk0ENO3BooiO0nNL5xHMAjl9uEXVVAy+mW8iFs6LmSkPwZU92vt75MfvmDhamiZ3uRyUx
	 xHXH0FU4W0zMzXf6ed/cpvZ0rP3+WwSyC6aRda/y2n9kR5JG/O9W5+Bgf3MYjWghQBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aGccVAzp;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB9F606A32D
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Nov 2026 01:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEB9F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aGccVAzp
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-55d360ca878so35915561cf.2
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Nov 2026 17:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795482511; x=1796087311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eoqwj65XKovFwDofv3kVdu/5R8xBCaittbSS0B34Krk=;
        b=aGccVAzpsd+wyUOISfODHTy9C3CYVd3Qs754IETYhRGIwkcVD559yBnRZVDlM9u7ZI
         XtKAC5rCKjbQvn/4FoddLxE01F3VnPaMsWEpuE63/MI+Aw6dyGglOPD/PEG7pL7nvzKv
         Avld2NaYt/TW8mxWLyzfRs7CC6u1yNxhEMsUDOqyVKmOiD6kUqZ4KgVTmttcT6m1WSSK
         q6P+hjcNZY3Kixh1E/cloW7tVu07ql319oLRV2DZVthzJrWimWPICDkhundR0CayBwsS
         hybaE1AP29KCoEw81aUuFLfCTG/S2D858DlhzE1a0mJBD/VLrzpO6RbslzdL6v35qXUx
         d4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795482511; x=1796087311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eoqwj65XKovFwDofv3kVdu/5R8xBCaittbSS0B34Krk=;
        b=TLcNdknq1JE4NA0GgIhfb+73OMzk2e0eq2jyzo69Pph5D7dG4S+4HVgL2GR/pbtjNp
         1DYf6qqeNdoU9ix9NWD4B1SeevsfHdO72vBkxI+KuYdrws3uH8wErjwZe1gRoQCRMtpC
         EA5sl6DGy82zuGLa+ogACMEki+S48fJeWhScWs+3vzMM/yprP97G5fx81Z4XMf51+6kJ
         +MMW8+2dUx3bFPnYFfQ3HzepYNH6pIBO+hKnmNjs82bo7gt01GCpzDA5+8zlZoev1nwF
         egCrA8o/xiZnknnKRQNqdrB22pONvbjwhibApcMI8S4L/6rWiJA4Pf32ZN8f6pr5JXot
         P5fw==
X-Gm-Message-State: APuU4Z8PSqH+dJItSw/jZeWpEAKyFz2SDlpnr49Yk8PjW4vbxV3iX7qh
	hqWE815A3PffE+LlRatKSHyOUYhGKHNnBoJd/Ux2YWN1NWPe3YQd7a0AHEW01Q==
X-Gm-Gg: AZFdTZcNG7oGdwNQYk59tfUuf7zlvNW+17GssIk6pf57WSOkVn653MYUafJH1Ppkf3b
	wqbBp42c3doU0Iww3BynACojCvxJYAnAileM+FPXWGRh+e3EQv3Pl5XUjnN4Gd1va16LnUTKo+K
	mtkQghEPpSN2Z7kDXMyCP48HBAzogJjWEARI44faysdI90Do0Rss4NSo2gluPGeEkjNISJdaONn
	yJ8w7YS195uYcUR849PGnFC4Fs7slRHFzofLhCv8Z2iBzkoPvYL7fC2fCiPmaqm8k9GKdFP37Fh
	pSY7dayN3Wq/AY8xgr6zL5fgQF5NMYDXhw711xkBUT2a/AjvyeFM390tS+2mclxKJ6d8gr6J8Rx
	7mLIHQXM6mtUn1JSr57v143u+pDjPyKShqjg6+3VItNjKHvYvfwBsij+J0HPSsUa3JseJE69/7z
	PmkuJL5tc2COg5O4XwDq8/s4bC9fRAx/FKb56fe5BJqIE0CCa3B+m1+87TTXJ61rWTa3wGfdtda
	gLiLw+l4PqWRAjH71rZPoloDoNRd9RbAbJwB09H/2o26zuAzcQ+9kEiqBA5V0m3uDd78+dCwXTn
	2w8CC+K5BJICluticoM1Sfx9oYMpdo/ElUoGqeWm2aUdo9R8Ied6MDY4zNJpZzQJ/UAJLLDFs86
	RgPMWs0NT6CAXQtuskYGnVQYT3spE3OW9f8g9
X-Received: by 2002:a05:622a:1aaa:b0:55d:3721:872e with SMTP id d75a77b69052e-55d76b34525mr233668641cf.69.1795482510780;
        Mon, 23 Nov 2026 17:08:30 -0800 (PST)
Received: from jkacur-thinkpadp1gen8.rmtcaon.csb ([70.53.46.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d14d1sm120624806d6.18.2026.11.23.17.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:08:30 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 1/6] rteval: Add multi stressor support
Date: Mon, 23 Nov 2026 20:07:43 -0500
Message-ID: <21fad1bba20a5d86154d0a10719b9d99891c2c2e.1795478784.git.jkacur@redhat.com>
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

From: Sana Sharma <sansshar@redhat.com>

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
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/__init__.py       |  4 +-
 rteval/modules/loads/stressng.py | 79 +++++++++++++++++++++++++-------
 tests/test_stressng.py           |  4 +-
 3 files changed, 67 insertions(+), 20 deletions(-)

diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index 183efd8ef813..abd88b6ecfc5 100644
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
index 564e7988b328..479248875fae 100644
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
index 6211fb36a42f..9da3bcb984e0 100644
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
2.56.1

