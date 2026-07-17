Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954B5345CDD
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Jul 2026 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784329196; cv=none; b=GonvwlHxyNZOr+8m0p6xhqfv0GZO/cJfhrmbX68FJaVcAVkfY47CZk2GKpX4odz5m70PiSWyuNodJB/TpPfflMVxDcT3+h1GhTNZAOuSSwlDIF6sL9PNLtyqtyCgRPo+IwoVYMbovdtuGyPAYaydGBL9/u9P9qX19cIxQhxkkdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784329196; c=relaxed/simple;
	bh=oYOt843yd2zObd4vQWWuiR34gBqCPx2NSTKge4HRriw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QmcpOV3GyYSqWHmDVPdowopxRhFPx9Tgam2DR31pKIFwFyh2lGf8Nf+IYyRMH7eIcPfUaM790paog/XOGaedY57KlDkXHA+nkrLMhh6iBJaYRAY+oVUf+HFxrxGXfjii0S9LnEu9Qz1t7EgvkO88IGaiPcOKAU4pkpV4pL7v2PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtbbH49Z; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtbbH49Z"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c8e2e39easo77383631cf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Jul 2026 15:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784329193; x=1784933993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uBgj2xq+UyLuHzh4C8/C4mG2ycDnUWvCu/IOOCMdzEI=;
        b=MtbbH49Zd5lKauCHH2qckcz/1vtfy+xPhtfRyUZHGop0TeM4mUUSyLa1dkre3QTpH1
         ggv0VfVnFMOxxCXIv41XYEhqKsrX12UVRDBHWVtG+PBh1JUjLxGDP5oKZWzGpux0Y3MC
         6ImkATE2Lrh6eU9TbcmqS3fBCDqwBCcySMdUTFYjO6P4bNg0MziC/O2CSacdxAU2Gbuf
         /Rr7w0+YJhp4c7b2G4R0urMklwz0Ob9mlV7Q+qbllMxN0s1POHfYlALBuLgHLKMGPUth
         ZIkeiXQtq4NddIJBjex+ayTJp0n8gg5lQHSmc5DTPqxYEZhc7l937eRl8+Ao1xdzthRC
         vPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784329193; x=1784933993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uBgj2xq+UyLuHzh4C8/C4mG2ycDnUWvCu/IOOCMdzEI=;
        b=sI/i6nUcvaGDI07jDVw1eiNqiapif3YQj8tzQwe2oLdXtqRn561kPb0l7dEOhyyCg5
         56Zucv4N+HoOLdfjDFUtHCFZwmCockmVderXLm578lG7oTFYPWhns3lpzm1mOQfqWOG5
         Vlllxna9IfnKCWFKBn5CJZeG3xAiYuhaaspyXmeQiDmLmRurMoVOLeBFj62kGoG1BvO9
         Zp7MpE+ZMDAyWRSFkLIFEGVfMcMNZaV67vDsWTmQm848Y2snIOwbs0onWlQdMro+EfDA
         HHVTZhe4jzHqeRXMCAVbooSXpLowslplZj5bQCUgEfRrabT3CfLmjWO167JX02/uNgqk
         I4Rw==
X-Gm-Message-State: AOJu0YxtwIuofa3s17IrL3C2bYL7q8reEy867s+cTi7ogSfor0M9D1nt
	Ympbh1f6dFxuHLqXIaR4ObYFIQRzJ6uf5QMcgIejQBsu1pxqmr5k/+abS/Jm6g==
X-Gm-Gg: AfdE7cmoZpIeZLnyf1B6SXJ3g0O5bt6kfbv7v0dH/SldSltpsvN+0+nJnT16+E+tZiH
	Rv95+l3U5jMhJP29xjsBQjobDWTjJBB/STPZGsuJq6ULcRS/4M7rRLnPdSWKSmXGECPmE2gpGnf
	3DRHGUWw9Vzj4T89MngkDRVpiIJHm47BXHy2o3n7lU04S/PBNSgSOLa6U2AyWZwXpl35iU+rvkA
	gOo0XRQxXJVrRY+dqM0QaZLVga29ycflKCziaDSjTqwa6ghZOFSlKY2SQlVExgV+QcbV9m+Mpda
	crs4xEapC1yrSmwtVgtcPPRn0kgSik4+kxM5Dj3DMYZDdeL0zXvh2b1EovNlsULg4odR684/b0u
	VlbtUskRZqENu7/tobGLrvAOw1DH3MmAD/kwFp1G+Zv+/cOcZF8Mp6qNiQtRC1EyrN0stWxZtEB
	gT/7Z8YPiJ09QIxFkAurBNlZkZbxZy8qm/6LSlStOBffwe0uwKtWbbqZnLSNptfoL21ZjG
X-Received: by 2002:a05:622a:155:b0:51c:1b22:b84c with SMTP id d75a77b69052e-5213ee77fa4mr46704761cf.60.1784329193344;
        Fri, 17 Jul 2026 15:59:53 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90778567f14sm28197836d6.14.2026.07.17.15.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 15:59:52 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH] rteval: Fix measurement module cpuset migration and debug logging
Date: Fri, 17 Jul 2026 18:59:37 -0400
Message-ID: <20260717225937.728351-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fixes two issues:

1. Cpuset migration disrupting measurement module initialization

Problem:
When using --cpusets, measurement modules (timerlat/cyclictest) were
launched in the root cgroup, then migrated to the measurement cpuset
after a 0.5s delay. This mid-startup migration disrupted per-CPU
thread initialization, causing some CPUs to fail initialization.
Symptoms included missing CPUs in output and zero samples collected.

Solution:
- Pass the measurement cpuset path to measurement modules before Start()
- Use subprocess preexec_fn to move child process into cpuset before exec
- Both timerlat and cyclictest now launch inside the cpuset from the start
- Fix is defensive: only activates when cpusets are configured
- Works correctly both with and without --cpusets flag

Files changed:
- rteval/__init__.py: Pass cpuset path to measurement modules
- rteval/modules/measurement/timerlat.py: Launch inside cpuset via preexec_fn
- rteval/modules/measurement/cyclictest.py: Launch inside cpuset via preexec_fn

2. Excessive debug logging from hackbench

Problem:
hackbench logs at DEBUG level every time it restarts (continuous loop),
flooding debug output with thousands of identical messages.

Solution:
- Add 'initial' parameter to __starton() method
- Only log at DEBUG level for first startup
- Subsequent restarts don't spam debug log

Files changed:
- rteval/modules/loads/hackbench.py: Add initial parameter to reduce logging

Tested with:
- timerlat with cpusets (5 CPUs, 45M+ samples)
- cyclictest with cpusets (5 CPUs, 15M+ samples)
- timerlat without cpusets (16 CPUs, 142M+ samples)

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/__init__.py                       | 14 ++++++++++++++
 rteval/modules/loads/hackbench.py        | 10 ++++++----
 rteval/modules/measurement/cyclictest.py | 17 ++++++++++++++++-
 rteval/modules/measurement/timerlat.py   | 17 ++++++++++++++++-
 4 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/rteval/__init__.py b/rteval/__init__.py
index 6e49889a6d67..b6d3c39a4b6a 100644
--- a/rteval/__init__.py
+++ b/rteval/__init__.py
@@ -174,6 +174,20 @@ class RtEval(rtevalReport):
                 print(f"started measurement threads on {onlinecpus} cores")
             print(f"Run duration: {str(self.__rtevcfg.duration)} seconds")
 
+            # Pass cpuset path to measurement modules so they can launch inside the cpuset
+            if self._cpuset_manager and self._cpuset_manager.measurement_cpuset:
+                cpuset_path = self._cpuset_manager.measurement_cpuset._cpuset_path
+                for (modname, mod) in self._measuremods._RtEvalModules__modules:
+                    # Try to find the config attribute - modules use self.__cfg (name-mangled)
+                    cfg = None
+                    for attr in ['_cfg', f'_{mod.__class__.__name__}__cfg']:
+                        if hasattr(mod, attr):
+                            cfg = getattr(mod, attr)
+                            break
+                    if cfg:
+                        cfg.cpuset_path = cpuset_path
+                        self.__logger.log(Log.DEBUG, f"Set cpuset_path for {modname}: {cpuset_path}")
+
             self._measuremods.Start()
 
             # Unleash the loads and measurement threads
diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
index 946a2adc2e57..20ebbbc4617c 100644
--- a/rteval/modules/loads/hackbench.py
+++ b/rteval/modules/loads/hackbench.py
@@ -110,7 +110,7 @@ class Hackbench(CommandLineLoad):
 
         self.started = False
 
-    def __starton(self, node):
+    def __starton(self, node, initial=False):
         if self.__multinodes or self.cpulist:
             if self.__usenumactl:
                 args = ['numactl', '--cpunodebind', str(node)] + self.args
@@ -120,7 +120,9 @@ class Hackbench(CommandLineLoad):
         else:
             args = self.args
 
-        self._log(Log.DEBUG, f"starting on node {node}: args = {args}")
+        # Only log initial startup at DEBUG level to avoid spam
+        if initial:
+            self._log(Log.DEBUG, f"starting on node {node}: args = {args}")
         p = subprocess.Popen(args,
                              stdin=self.__nullfp,
                              stdout=self.__out,
@@ -137,7 +139,7 @@ class Hackbench(CommandLineLoad):
         # just do this once
         if not self.started:
             for n in self.nodes:
-                self.tasks[n] = self.__starton(n)
+                self.tasks[n] = self.__starton(n, initial=True)
             self.started = True
             return
 
@@ -145,7 +147,7 @@ class Hackbench(CommandLineLoad):
             try:
                 if self.tasks[n].poll() is not None:
                     self.tasks[n].wait()
-                    self.tasks[n] = self.__starton(n)
+                    self.tasks[n] = self.__starton(n, initial=False)
             except OSError as e:
                 if e.errno != errno.ENOMEM:
                     raise e
diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index a1bf0d2d7324..eee315d270f8 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -302,10 +302,25 @@ class Cyclictest(rtevalModulePrototype):
         if not self._logging:
             self.__cyclicoutput.seek(0)
 
+        # If cpuset is configured, launch process inside the cpuset
+        # This is critical for cyclictest - migrating it mid-startup disrupts initialization
+        preexec_fn = None
+        if hasattr(self.__cfg, 'cpuset_path') and self.__cfg.cpuset_path:
+            def move_to_cpuset():
+                """Move child process into cpuset before exec"""
+                try:
+                    cpuset_procs = os.path.join(self.__cfg.cpuset_path, 'cgroup.procs')
+                    with open(cpuset_procs, 'w') as f:
+                        f.write(str(os.getpid()))
+                except Exception:
+                    pass  # Fail silently - parent will attempt migration as fallback
+            preexec_fn = move_to_cpuset
+
         self.__cyclicprocess = subprocess.Popen(self.__cmd,
                                                 stdout=self.__cyclicoutput,
                                                 stderr=self.__nullfp,
-                                                stdin=self.__nullfp)
+                                                stdin=self.__nullfp,
+                                                preexec_fn=preexec_fn)
         self.__started = True
 
     def WorkloadAlive(self):
diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index 7f592ea697af..418f1ba151af 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -285,10 +285,25 @@ class Timerlat(rtevalModulePrototype):
             self.__timerlat_out.seek(0)
             self.__timerlat_err.seek(0)
 
+        # If cpuset is configured, launch process inside the cpuset
+        # This is critical for timerlat - migrating it mid-startup disrupts initialization
+        preexec_fn = None
+        if hasattr(self.__cfg, 'cpuset_path') and self.__cfg.cpuset_path:
+            def move_to_cpuset():
+                """Move child process into cpuset before exec"""
+                try:
+                    cpuset_procs = os.path.join(self.__cfg.cpuset_path, 'cgroup.procs')
+                    with open(cpuset_procs, 'w') as f:
+                        f.write(str(os.getpid()))
+                except Exception:
+                    pass  # Fail silently - parent will attempt migration as fallback
+            preexec_fn = move_to_cpuset
+
         self.__timerlat_process = subprocess.Popen(self.__cmd,
                                                    stdout=self.__timerlat_out,
                                                    stderr=self.__timerlat_err,
-                                                   stdin=None)
+                                                   stdin=None,
+                                                   preexec_fn=preexec_fn)
         self.__started = True
 
     def WorkloadAlive(self):
-- 
2.55.0

