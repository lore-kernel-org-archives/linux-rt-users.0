Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FA7C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jul 2022 13:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbiGZNgC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jul 2022 09:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiGZNgB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jul 2022 09:36:01 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81D960C5
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 06:35:59 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id p5so47624ilg.9
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 06:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2/qtN6BIeOnh1bM6TTw6a3D+af46WOeS1mJ6M97g0Eg=;
        b=oWm4GNYhQZj1G0EzKFgj4nbeAlnWFlUUvCl5hLFiZXHLpi2iramVUJ9iMFh73r+kVU
         B4Hz6fLVypg7wvSeYHpgABL+ZZPdun1ocoAwTCzoyHPwzoTXv5ncuXClt1RSKEW+RwSu
         lIi0GHvv6/3GYHL5w+VmrO49vZ9Nt60oUU43LNhlN41F/HCiwGpJpw/VS3q09kZkNBGp
         tSLkBdBkBq8hGenNTT/GnBaHb9zjzWPgOurJAgcgN2AMHjoIBPIWHWl7OTyt4jJPTRpj
         y6da0oRgorgyAi+SUCHLc7O5J0NpkLmkdl9hAlWeN/o70LbTiakxScZk42jAfDXqCSkV
         UpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2/qtN6BIeOnh1bM6TTw6a3D+af46WOeS1mJ6M97g0Eg=;
        b=V5Vw5VSkPjDISE3bpMCRdjqxAy9qsMxPoZlikMZ1usDS/t4WI/UUyKOIzuIPmWwLxI
         Kksi09ANMFuYpMSi1iP0hM+xc5v0LlhfGhYV/Dw+RoRQXGQ//VlGEpcsGjfoqmTqDJ27
         3d4io/w765LnXBrOVCqT0VUWlmO3MQEHSJOfTN7u8MM5w9Y9fnvPldd0cbTuun7DLMiS
         uQHhH41eWMkSFDQ72rPUanC+RI4FY+lFIrAFytGtO6ckQly3nApsdBHeVm6DbskPWMIb
         T1OppzGOu7RWIGMM+J6bJ5NBdfUbm2YQ4RqMxxPtMeim6goWqi0pUsWWC0UNjtpcMAdc
         NmMw==
X-Gm-Message-State: AJIora+rrSUDl9dlzchC06Nnps2mfplsbIxV+X0dE1ui1psB6+jUf0QX
        7h9immgIZl0vRM8YghrvozVMbKYYlXw=
X-Google-Smtp-Source: AGRyM1t9v+mqMLhxUFRkuKr49cXxEnGENY6+PZ7UH3ScdVPaurORXdiqZb6TJ7VWuUEoUfoZfOZXNQ==
X-Received: by 2002:a92:b11:0:b0:2dd:e68:76dc with SMTP id b17-20020a920b11000000b002dd0e6876dcmr6950072ilf.70.1658842559002;
        Tue, 26 Jul 2022 06:35:59 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-180.dsl.bell.ca. [184.147.143.180])
        by smtp.gmail.com with ESMTPSA id e42-20020a02212a000000b00339ceeec5edsm6617760jaa.12.2022.07.26.06.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:35:58 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Manasi Godse <magodse@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/6] rteval: Make use of systopology instead of misc in kcompile
Date:   Tue, 26 Jul 2022 09:35:33 -0400
Message-Id: <20220726133535.10824-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220726133535.10824-1-jkacur@redhat.com>
References: <20220726133535.10824-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- make use of systopology instead of misc in kcompile
- use f-strings where necessary
- Change """ to comment style # when not a docstring
- Add docstrings to functions
- Use python in (0, -2) for readability

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/loads/kcompile.py | 86 +++++++++++++++++---------------
 1 file changed, 46 insertions(+), 40 deletions(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 2c93c794fe75..4a8659c042e6 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -33,8 +33,10 @@ import subprocess
 from rteval.modules import rtevalRuntimeError
 from rteval.modules.loads import CommandLineLoad
 from rteval.Log import Log
-from rteval.misc import expand_cpulist, compress_cpulist
-from rteval.systopology import SysTopology
+from rteval.systopology import CpuList, SysTopology
+
+expand_cpulist = CpuList.expand_cpulist
+compress_cpulist = CpuList.compress_cpulist
 
 DEFAULT_KERNEL_PREFIX = "linux-5.18"
 
@@ -48,21 +50,21 @@ class KBuildJob:
         self.logger = logger
         self.binder = None
         self.builddir = os.path.dirname(kdir)
-        self.objdir = "%s/node%d" % (self.builddir, int(node))
+        self.objdir = f"{self.builddir}/node{int(node)}"
 
         if not os.path.isdir(self.objdir):
             os.mkdir(self.objdir)
 
         if os.path.exists('/usr/bin/numactl') and not cpulist:
-            """ Use numactl """
-            self.binder = 'numactl --cpunodebind %d' % int(self.node)
+            # Use numactl
+            self.binder = f'numactl --cpunodebind {int(self.node)}'
             self.jobs = self.calc_jobs_per_cpu() * len(self.node)
         elif cpulist:
-            """ Use taskset """
+            # Use taskset
             self.jobs = self.calc_jobs_per_cpu() * len(cpulist)
-            self.binder = 'taskset -c %s' % compress_cpulist(cpulist)
+            self.binder = f'taskset -c {compress_cpulist(cpulist)}'
         else:
-            """ Without numactl calculate number of jobs from the node """
+            # Without numactl calculate number of jobs from the node
             self.jobs = self.calc_jobs_per_cpu() * len(self.node)
 
         self.runcmd = f"make O={self.objdir} -C {self.kdir} -j{self.jobs}"
@@ -72,56 +74,61 @@ class KBuildJob:
             self.runcmd = self.binder + " " + self.runcmd
             self.cleancmd = self.binder + " " + self.cleancmd
 
-        self.log(Log.DEBUG, "node %d: jobs == %d" % (int(node), self.jobs))
+        self.log(Log.DEBUG, f"node {int(node)}: jobs == {self.jobs}")
         self.log(Log.DEBUG, f"cleancmd = {self.cleancmd}")
-        self.log(Log.DEBUG, "node%d kcompile command: %s" \
-                % (int(node), self.runcmd))
+        self.log(Log.DEBUG, f"node{int(node)} kcompile command: {self.runcmd}")
 
     def __str__(self):
         return self.runcmd
 
     def log(self, logtype, msg):
+        """ starting logging for the kcompile module """
         if self.logger:
-            self.logger.log(logtype, "[kcompile node%d] %s" % (int(self.node), msg))
+            self.logger.log(logtype, f"[kcompile node{int(self.node)}] {msg}")
 
     def calc_jobs_per_cpu(self):
+        """ Calculate the number of kcompile jobs to do """
         mult = 2
-        self.log(Log.DEBUG, "calulating jobs for node %d" % int(self.node))
+        self.log(Log.DEBUG, f"calulating jobs for node {int(self.node)}")
         # get memory total in gigabytes
         mem = int(self.node.meminfo['MemTotal']) / 1024.0 / 1024.0 / 1024.0
         # ratio of gigabytes to #cores
         ratio = float(mem) / float(len(self.node))
-        if ratio < 1.0:
-            ratio = 1.0
-        if ratio < 1.0 or ratio > 2.0:
+        ratio = max(ratio, 1.0)
+        if ratio > 2.0:
             mult = 1
-        self.log(Log.DEBUG, "memory/cores ratio on node %d: %f" % (int(self.node), ratio))
-        self.log(Log.DEBUG, "returning jobs/core value of: %d" % int(ratio) * mult)
+        self.log(Log.DEBUG, f"memory/cores ratio on node {int(self.node)}: {ratio}")
+        self.log(Log.DEBUG, f"returning jobs/core value of: {int(ratio) * mult}")
         return int(int(ratio) * int(mult))
 
     def clean(self, sin=None, sout=None, serr=None):
-        self.log(Log.DEBUG, "cleaning objdir %s" % self.objdir)
+        """ Runs command to clean any previous builds and configure kernel """
+        self.log(Log.DEBUG, f"cleaning objdir {self.objdir}")
         subprocess.call(self.cleancmd, shell=True,
                         stdin=sin, stdout=sout, stderr=serr)
 
     def run(self, sin=None, sout=None, serr=None):
-        self.log(Log.INFO, "starting workload on node %d" % int(self.node))
-        self.log(Log.DEBUG, "running on node %d: %s" % (int(self.node), self.runcmd))
+        """ Use Popen to launch a kcompile job """
+        self.log(Log.INFO, f"starting workload on node {int(self.node)}")
+        self.log(Log.DEBUG, f"running on node {int(self.node)}: {self.runcmd}")
         self.jobid = subprocess.Popen(self.runcmd, shell=True,
                                       stdin=sin, stdout=sout, stderr=serr)
 
     def isrunning(self):
+        """ Query whether a job is running, returns True or False """
         if self.jobid is None:
             return False
         return self.jobid.poll() is None
 
     def stop(self):
+        """ stop a kcompile job """
         if not self.jobid:
             return True
         return self.jobid.terminate()
 
 
 class Kcompile(CommandLineLoad):
+    """ class to compile the kernel as an rteval load """
     def __init__(self, config, logger):
         self.buildjobs = {}
         self.config = config
@@ -150,14 +157,14 @@ class Kcompile(CommandLineLoad):
     def _remove_build_dirs(self):
         if not os.path.isdir(self.builddir):
             return
-        self._log(Log.DEBUG, "removing kcompile directories in %s" % self.builddir)
+        self._log(Log.DEBUG, f"removing kcompile directories in {self.builddir}")
         null = os.open("/dev/null", os.O_RDWR)
         cmd = ["rm", "-rf", os.path.join(self.builddir, "kernel*"),
                os.path.join(self.builddir, "node*")]
         ret = subprocess.call(cmd, stdin=null, stdout=null, stderr=null)
         if ret:
             raise rtevalRuntimeError(self, \
-                "error removing builddir (%s) (ret=%d)" % (self.builddir, ret))
+                f"error removing builddir ({self.buildir}) (ret={ret})")
 
     def _WorkloadSetup(self):
         if self._donotrun:
@@ -167,15 +174,15 @@ class Kcompile(CommandLineLoad):
         if self._cfg.source:
             tarfile = os.path.join(self.srcdir, self._cfg.source)
             if not os.path.exists(tarfile):
-                raise rtevalRuntimeError(self, " tarfile %s does not exist!" % tarfile)
+                raise rtevalRuntimeError(self, f" tarfile {tarfile} does not exist!")
             self.source = tarfile
             kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}", self.source).group(0)
         else:
-            tarfiles = glob.glob(os.path.join(self.srcdir, "%s*" % DEFAULT_KERNEL_PREFIX))
+            tarfiles = glob.glob(os.path.join(self.srcdir, f"{DEFAULT_KERNEL_PREFIX}*"))
             if tarfiles:
                 self.source = tarfiles[0]
             else:
-                raise rtevalRuntimeError(self, " no kernel tarballs found in %s" % self.srcdir)
+                raise rtevalRuntimeError(self, f" no kernel tarballs found in {self.srcdir}")
             kernel_prefix = DEFAULT_KERNEL_PREFIX
         self._log(Log.DEBUG, f"kernel_prefix = {kernel_prefix}")
 
@@ -190,15 +197,15 @@ class Kcompile(CommandLineLoad):
             self._extract_tarball()
             names = os.listdir(self.builddir)
             for d in names:
-                self._log(Log.DEBUG, "checking %s" % d)
+                self._log(Log.DEBUG, f"checking {d}")
                 if d.startswith(kernel_prefix):
                     kdir = d
                     break
         if kdir is None:
             raise rtevalRuntimeError(self, "Can't find kernel directory!")
         self.mydir = os.path.join(self.builddir, kdir)
-        self._log(Log.DEBUG, "mydir = %s" % self.mydir)
-        self._log(Log.DEBUG, "systopology: %s" % self.topology)
+        self._log(Log.DEBUG, f"mydir = {self.mydir}")
+        self._log(Log.DEBUG, f"systopology: {self.topology}")
         self.jobs = len(self.topology)
         self.args = []
 
@@ -217,10 +224,10 @@ class Kcompile(CommandLineLoad):
         for node, cpus in self.cpus.items():
             if not cpus:
                 self.nodes.remove(node)
-                self._log(Log.DEBUG, "node %s has no available cpus, removing" % node)
+                self._log(Log.DEBUG, f"node {node} has no available cpus, removing")
 
         for n in self.nodes:
-            self._log(Log.DEBUG, "Configuring build job for node %d" % int(n))
+            self._log(Log.DEBUG, f"Configuring build job for node {int(n)}")
             self.buildjobs[n] = KBuildJob(self.topology[n], self.mydir, \
                 self.logger, self.cpus[n] if self.cpulist else None)
             self.args.append(str(self.buildjobs[n])+";")
@@ -249,7 +256,7 @@ class Kcompile(CommandLineLoad):
                 ret = subprocess.call(cmd, stdin=null, stdout=out, stderr=err)
                 if ret:
                     # give up
-                    raise rtevalRuntimeError(self, "kcompile setup failed: %d" % ret)
+                    raise rtevalRuntimeError(self, f"kcompile setup failed: {ret}")
         except KeyboardInterrupt as m:
             self._log(Log.DEBUG, "keyboard interrupt, aborting")
             return
@@ -280,15 +287,14 @@ class Kcompile(CommandLineLoad):
     def _WorkloadTask(self):
         for n in self.nodes:
             if not self.buildjobs[n]:
-                raise RuntimeError("Build job not set up for node %d" % int(n))
+                raise RuntimeError(f"Build job not set up for node {int(n)}")
             if self.buildjobs[n].jobid is None or self.buildjobs[n].jobid.poll() is not None:
                 # A jobs was started, but now it finished. Check return code.
                 # -2 is returned when user forced stop of execution (CTRL-C).
                 if self.buildjobs[n].jobid is not None:
-                    if self.buildjobs[n].jobid.returncode != 0 and self.buildjobs[n].jobid.returncode != -2:
-                        raise RuntimeError("kcompile module failed to run (returned %d), please check logs for more detail" \
-                            % self.buildjobs[n].jobid.returncode)
-                self._log(Log.INFO, "Starting load on node %d" % n)
+                    if self.buildjobs[n].jobid.returncode not in (0, -2):
+                        raise RuntimeError(f"kcompile module failed to run (returned {self.buildjobs[n].jobid.returncode}), please check logs for more detail")
+                self._log(Log.INFO, f"Starting load on node {n}")
                 self.buildjobs[n].run(self.__nullfd, self.__outfd, self.__errfd)
 
     def WorkloadAlive(self):
@@ -296,8 +302,8 @@ class Kcompile(CommandLineLoad):
         for n in self.nodes:
             if self.buildjobs[n].jobid.poll() is not None:
                 # Check return code (see above).
-                if self.buildjobs[n].jobid.returncode != 0 and self.buildjobs[n].jobid.returncode != -2:
-                    raise RuntimeError("kcompile module failed to run (returned %d), please check logs for more detail" % self.buildjobs[n].jobid.returncode)
+                if self.buildjobs[n].jobid.returncode not in (0, -2):
+                    raise RuntimeError(f"kcompile module failed to run (returned {self.buildjobs[n].jobid.returncode}), please check logs for more detail")
                 return False
 
         return True
@@ -310,7 +316,7 @@ class Kcompile(CommandLineLoad):
         self._log(Log.DEBUG, "out of stopevent loop")
         for n in self.buildjobs:
             if self.buildjobs[n].jobid.poll() is None:
-                self._log(Log.DEBUG, "stopping job on node %d" % int(n))
+                self._log(Log.DEBUG, f"stopping job on node {int(n)}")
                 self.buildjobs[n].jobid.terminate()
                 self.buildjobs[n].jobid.wait()
                 del self.buildjobs[n].jobid
-- 
2.37.1

