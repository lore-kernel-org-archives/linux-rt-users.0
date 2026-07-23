Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB4A37998C
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Jul 2026 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836092; cv=none; b=eNxmyUXg2EuNYC4+1SOlYNbcdKT7KNlzaAKwN8SGpW+gi6uO+W8Q0yG8MsHSE5fgsh/Z5TcCh3ZPTJ5H7e/wozrTNmBagD6gtpys0c930S6XEJIpgiZRyariyMmgxRVcTLerwv54ABYh3qwm97bYgFUOPXvH3MH7K36Uu6VrDSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836092; c=relaxed/simple;
	bh=oYOt843yd2zObd4vQWWuiR34gBqCPx2NSTKge4HRriw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNDiwkYeyf9UqHUC532G958o+3b2uwzMiteTNG6LS+upZ4xPeo3KVDN1H1WrOlM8MDthz5xdd4UWqayuL76Bc5SDpUQJrs71Ky3v28CZUA4Co11A6pPQPHiBhliSd9oRPaYQFzXxAxJCtS9O0iltn9+1Sru55RBHQfJaJEeCado=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlBJBm7L; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlBJBm7L"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c928bf172so10120751cf.3
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jul 2026 12:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784836082; x=1785440882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uBgj2xq+UyLuHzh4C8/C4mG2ycDnUWvCu/IOOCMdzEI=;
        b=RlBJBm7L7GRnBdkj6kuN3RcuVe8RWQYmB7h8NFP1x27sExk0R5sMzQsUWYbwZj7crt
         jvS1SR+iiA4IZnY/O1s24e1u665ArGilPFNmfEQrOp9hCITWO5nQFj/LBdi5stc24F6K
         0laHKVo5dJNH07qVnQiG77dageAj0g65Oao6Aqjk+amWPMtpzAXMCH0ohOS43HO/8xXI
         8fcaOtyGKJMdo+4mUwTbq+0qKIcuzrPB3I2pw9pXY68f61nOj/UraaceRHEyCzJhUYU0
         JolfL+LTvKHVyabgtA6e5PDokthWuJxpyVc9cH2QZeE9XZMcdHcf/TWeRXPzwNq91EJc
         SMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784836082; x=1785440882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uBgj2xq+UyLuHzh4C8/C4mG2ycDnUWvCu/IOOCMdzEI=;
        b=a2WVxhVw2dRrBrVkpeldZBehcNRxTxmWMbEhDsXYSxRhSk5Y8VZpr3wfzkq7llR6C0
         ZSIGWIoBksafZ3211M0LyzeLZmguUBrI+mKm/RkRVwkQ/MJ7+etOFx8tT4Fp/9xvVzvK
         3kMmj8thTzrhA2zZUOpg0U5hVubQMwCEjjMM2YP4riSnLofot+AuaOJ1I9zNvsc6irmh
         lccDpltxw1ysCjoDST1rTJfxt7UzkWAFmy9fCWEBLgCmVsy2R4evh30hlSWnIIhHg8F8
         xgj6UDQqB8IcMd0sm0A4M6WtWubSBg4etCazd6jwW6zyBAi1WP9uB2bzL9ZZfyRj56Bz
         kMGA==
X-Gm-Message-State: AOJu0YyyFwFu5zDnwl5A1sO8N6oA81A+r1fWHr7n165Ir6Ne/3Z8WwqS
	ASwzoqbjY5Y0iwo+PsYPUItBMAz6uEYZZ3V4m8FV0pqXlyaEuGHgS2JQ/m594A==
X-Gm-Gg: AR+sD10JDByB4sPtyW+2pWwdxfbZKji33MGbc3CL/Zk6FbfEJ2SDVtzizB6tXmpKEb1
	9coQj/7724AT/fTD9W2txrfP+apOkHhcS5iHcrKa+w2Z2xOLQOm22nQCtSOMYFV/LG3kFiFfB2g
	yBXGnBOeb1wCYfJyT5/yaFJD6B5N9Ne/2R7gUbEDfDuHcsUR9RVyohpjNJ70CMHzpxCHu8GVEQb
	rpbe/1OPUn78UvurDVbL1tn+fi1iP0A0EQOuuJLfxg0SF0g2F53nhgbCMKOjmbW0f90vCa06jk6
	06G7FUkM/UAHbJ2TiJJ8kuuF7/XU3nefs+R75l8LF1HvR0UbfXIz+BGc68aYFi9kzxm7fSF1uIC
	+1dazpwmpzjoC/UAQT0D1QgS7HOx4M09m6EvkD08sZ/CQpqpLHTUpV3vHIYUq/rE9e9XpewcTqs
	fcp1bV9fElYiCqZQr/A1EG/r4lvHYkb1NVhFaUAX/RK7mQVldXDQVguYTDEK/1E0+5idQmoti1w
	f32pB5FdvxALxvkKzXce1KGz/EM8/fYrEDg1y36AFb1qywiDmaZpFtTS4Wb
X-Received: by 2002:a05:622a:a15:b0:51c:19af:6341 with SMTP id d75a77b69052e-5283de60320mr42994291cf.36.1784836082371;
        Thu, 23 Jul 2026 12:48:02 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-09-174-95-68-136.dsl.bell.ca. [174.95.68.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d0c4f3b8sm41402321cf.9.2026.07.23.12.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:48:01 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH] rteval: Fix measurement module cpuset migration and debug logging
Date: Thu, 23 Jul 2026 15:47:46 -0400
Message-ID: <20260723194751.625088-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723194751.625088-1-jkacur@redhat.com>
References: <20260723194751.625088-1-jkacur@redhat.com>
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

