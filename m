Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DD0388862
	for <linux-rt-users@vger.kernel.org>; Tue,  2 Jun 2026 20:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433240; cv=none; b=hyDrfLZvWgCc0NzUE2eD43RPu72kb+3G2Mg7jE961xt9hvnI6Y/SdMJG/Gi+I9c0vpcSOKf2qNCOT3hzjxBgVwSBeLBkAT7HQPE6ez/JAGptmJt5Zh0D3jVIfiRnMSfH7MI2a0LzdoPTiX47pOc8klJmckYF1mhdFj8v+kOXLyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433240; c=relaxed/simple;
	bh=czqch0D9snQEM+75IyCJiiN7YIJFphMEdQ2NubgAkRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F7Q614LbGb2SKZfomyaJjDSq6YViTcG5y00pMua3YjDwvqh/wzNaOSAvy8n0gaWNQL/UnLx+M9W4513dWfXgORxMKsZq3jaRh8VrW3zAA3fMoN5n0vwsFLhHz2B8NXArrWUpHCgYJzJnVhEfN+6Z5Y2QIjXN/fWHGaTRKULkygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4FZ0ns+; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4FZ0ns+"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9157b94a07aso138482085a.0
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Jun 2026 13:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780433238; x=1781038038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Xcu6tj5yE6jHQhycsqoDtGTQEqMWHty6STpyfILO0es=;
        b=C4FZ0ns+x9O8JEHTxkJqODKUSU9o7JanKE8f//aQsU3oBJjfNhK1FYEWUlVwTTIl/s
         iOw4b44NcrEAYpesBhCxjxmlqivdq1r4ONchPt+gY0vyHk80WSHW/tDybDtUc3M3m14p
         BkYA28psKmqTeu8GqftGSZdgnu+RDevx8DdvSfOlLNSOCT2stIleSVGLI6ZdDL+454LH
         UG6Qt8iuH63VmBwz4Dchjo4N8sT0QlTegAPoYwfbDI7utpoGyTWgw/PusAtuu92zte7y
         ONu0+/0z9sbm6ZqeMeVH2YFUEwgOwiRqDwDoBBD1QCohAEPoEbrxK4uCHbLd26LKCWld
         gACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433238; x=1781038038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xcu6tj5yE6jHQhycsqoDtGTQEqMWHty6STpyfILO0es=;
        b=tGKbpMY/zJ7t42IsIVnI1qvxGYbk1jFRIHGiCPNfF9Koj7ezB+6htPkSlqbelWpjp3
         oDZ6Zj/TVrDsWkcYgPkfUkrdFUpdobB5ar/nYtIBx/K8xJscAM62CmTn2L8uvebP9Pg4
         JlytPdaCjkfhepjhWH8/uTvro6SbAaWsuQKF4TCyNlgRuSEag/89ymBrjdKHMLhC3Sn7
         9e8f81FHAnXTmcYr0tJhaOTWevLLoh86aj+vVXC2Whyy87hbIMkjCqaRcZYr8xp2CNud
         7Onpygg6f2++MyjOgYMPllyi0p8pGullMm7lpm9SW5bU4ujGtD2FI19x62aov5mmHeCK
         nB5g==
X-Gm-Message-State: AOJu0YwfNM6aX/n5flLPvXV9TMClj5qny7YBUJfOH8hnp6CrZAkGJeBW
	nNxDayJooDOsQDKymRXn/wlMlrLkre1q59PRyyI9n3dgB9Tkrr/FTcbpD4+Ozg==
X-Gm-Gg: Acq92OEGB3w4LaFqI0qvIKRq0iSe4ewqdzCk8lHlv3oCjh8QR8M7I5m7D4ce+yhrx3J
	KBskieZn/xEd1XiIcl7t14zmC1nEKFkUVjh4fqohfyNePgMjZyG+bXzkUJk3y2h6r8Wt8L0o33X
	+IUNZPnVaP04YW6w8jhWAVflczBd1BK+AMkAr72cgrAJjv5XGxQ29ZOKEAfKIfwTp7n71PtzSPL
	JAAxwxp/tLDNJ5SC8YKrmkcZ98YJXLnHaqFHk/SC5KXf9m1H4p+Qlm+iEOkHJUPv46+RIsX+5/G
	X7inU6pY/6IfqHqjtO9chbRqd4jQ9c2TW/UdMM8pNdYevBjYpBtAeoN4DSw7xmRhrZ6kROWZ2uY
	N2NIzmbCnpTyCqwAHiepOiBB9RVOu2y4SJ0WRoxHKpfkz5ALGhcKEr+nIkjvp9r+Iq4U/PeFS81
	Dbrd9e+q0darmXtNsy6h34Oxej1P+Mc2oGh6Z9ZUSxHHvM90Ahrxla7wt0Xuabh4QB3OIXleyiL
	JYIeNQ1QORD8Tr0YGEjzIUzKAMEmcddBf4pSRid
X-Received: by 2002:a05:620a:4cb:b0:915:6d33:5207 with SMTP id af79cd13be357-9158a7aa817mr85468485a.30.1780433237609;
        Tue, 02 Jun 2026 13:47:17 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a21f871sm50291385a.12.2026.06.02.13.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:47:17 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 1/2] rteval: Add -L/--logging support to timerlat measurement module
Date: Tue,  2 Jun 2026 16:47:01 -0400
Message-ID: <20260602204702.227969-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements file logging for the timerlat measurement module, matching
the functionality available in load modules like hackbench and kcompile.

When rteval is run with the -L/--logging flag, timerlat will now save
rtla timerlat's stdout and stderr to files in workdir/logs/:
- timerlat.stdout - raw output from rtla timerlat hist
- timerlat.stderr - any error messages from rtla

This is useful for:
- Debugging new rtla versions with different output formats
- Investigating parsing issues
- Understanding rtla behavior when things go wrong

Changes:
- Add _logging config flag (default: False)
- Add __reportdir config to locate logs directory
- Add __open_logfile() helper method (uses O_RDWR to support read+write)
- Conditionally use real log files vs temp files in _WorkloadPrepare()
- Handle reading from both file descriptors and temp files in _WorkloadCleanup()
- Close files appropriately based on type (os.close vs .close())
- Conditional seek only for temp files (file descriptors start at position 0)

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/timerlat.py | 54 +++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index 2172f6ece520..03faa08639d5 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -189,6 +189,10 @@ class Timerlat(rtevalModulePrototype):
         self.__cpus = [str(c) for c in expand_cpulist(self.__cpulist)]
         self.__numcores = len(self.__cpus)
 
+        # Logging configuration
+        self._logging = self.__cfg.setdefault('logging', False)
+        self.__reportdir = self.__cfg.setdefault('reportdir', os.getcwd())
+
         # Has tracing been triggered
         self.__stoptrace = False
         # This stores the output from rtla
@@ -218,6 +222,12 @@ class Timerlat(rtevalModulePrototype):
         self._log(Log.DEBUG, f"system using {self.__numcores} cpu cores")
         self.set_latency_test()
 
+    def __open_logfile(self, name):
+        """Open a log file in the reportdir/logs directory"""
+        logdir = os.path.join(self.__reportdir, "logs")
+        if not os.path.exists(logdir):
+            os.makedirs(logdir)
+        return os.open(os.path.join(logdir, name), os.O_CREAT|os.O_RDWR|os.O_TRUNC)
 
     def _WorkloadSetup(self):
         self.__timerlat_process = None
@@ -250,8 +260,14 @@ class Timerlat(rtevalModulePrototype):
                 self.__cmd.append(f'-t={self.__cfg.trace}')
 
         self._log(Log.DEBUG, f'self.__cmd = {self.__cmd}')
-        self.__timerlat_out = tempfile.SpooledTemporaryFile(mode='w+b')
-        self.__timerlat_err = tempfile.SpooledTemporaryFile(mode='w+b')
+
+        # Setup output files - use actual log files if logging enabled, otherwise temp files
+        if self._logging:
+            self.__timerlat_out = self.__open_logfile("timerlat.stdout")
+            self.__timerlat_err = self.__open_logfile("timerlat.stderr")
+        else:
+            self.__timerlat_out = tempfile.SpooledTemporaryFile(mode='w+b')
+            self.__timerlat_err = tempfile.SpooledTemporaryFile(mode='w+b')
 
 
     def _WorkloadTask(self):
@@ -260,8 +276,11 @@ class Timerlat(rtevalModulePrototype):
 
         self._log(Log.DEBUG, f'starting with cmd: {" ".join(self.__cmd)}')
 
-        self.__timerlat_out.seek(0)
-        self.__timerlat_err.seek(0)
+        # Seek to beginning - only needed for temp files, file descriptors start at position 0
+        if not self._logging:
+            self.__timerlat_out.seek(0)
+            self.__timerlat_err.seek(0)
+
         self.__timerlat_process = subprocess.Popen(self.__cmd,
                                                    stdout=self.__timerlat_out,
                                                    stderr=self.__timerlat_err,
@@ -308,14 +327,26 @@ class Timerlat(rtevalModulePrototype):
         # Parse histogram output - use try/finally to ensure _setFinished() is always called
         # This prevents hangs if parsing fails due to partial output (RHEL-140898)
         try:
-            self.__timerlat_out.seek(0)
+            # Read output - handle both file descriptors and temp files
+            if self._logging:
+                # For file descriptors, read the entire file content
+                os.lseek(self.__timerlat_out, 0, os.SEEK_SET)
+                output_data = os.read(self.__timerlat_out, 10*1024*1024)  # Read up to 10MB
+                output_lines = output_data.decode('utf-8', errors='replace').splitlines(keepends=True)
+            else:
+                # For temp files, use seek and iterate
+                self.__timerlat_out.seek(0)
+                output_lines = self.__timerlat_out
 
             blocking_thread_detected = False
             softirq_interference_detected = False
             irq_interference_detected = False
 
-            for line in self.__timerlat_out:
-                line = bytes.decode(line)
+            for line in output_lines:
+                if isinstance(line, bytes):
+                    line = bytes.decode(line)
+                elif not isinstance(line, str):
+                    line = str(line)
 
                 # Skip any blank lines
                 if not line:
@@ -474,8 +505,13 @@ class Timerlat(rtevalModulePrototype):
             self._setFinished()
             self.__started = False
 
-            self.__timerlat_err.close()
-            self.__timerlat_out.close()
+            # Close output files - method differs for file descriptors vs temp files
+            if self._logging:
+                os.close(self.__timerlat_out)
+                os.close(self.__timerlat_err)
+            else:
+                self.__timerlat_out.close()
+                self.__timerlat_err.close()
 
     def MakeReport(self):
         rep_n = libxml2.newNode('timerlat')
-- 
2.54.0

