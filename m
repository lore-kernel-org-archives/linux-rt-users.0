Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B36CCA489
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jul 2022 13:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbiGZNgE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jul 2022 09:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbiGZNgC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jul 2022 09:36:02 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD1D63D4
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 06:36:01 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id p5so47652ilg.9
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 06:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uSSZlyvSWtDYuuZ6mC2C001+sqIbu1SZaoZLYVdrke8=;
        b=lAF2jeNXxvOd9w/Zk6PLHoexc7b4JQ2AYMZvw6/+cYfRyrTxCyKVLwBp+ohpmLIp3W
         O/WWQd3UxASq6eWAGa/TI12Te2q68upEu+l6ZIbFO+O1F+Dsc4RtYGkuMpSd2HtuOTN/
         hsc1gvY/eJeL8HrqiykhEi76trdUGm8WEhRVkLP6sohObVBW8Ktarzdwsl3K4RJfXqhS
         z209Qq3eWH5I6lyYuP/AzjUbXXDJ9wmCvDgWfwpathq38S/SThS7cwXL4A/jRwNNvj7n
         2sJn7nnRNJ4f4FVZNfhkkHAwVwORuM+UoG6gf8DCSQXaJGObD+v+lgId5EBuqBQqB+GD
         MUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uSSZlyvSWtDYuuZ6mC2C001+sqIbu1SZaoZLYVdrke8=;
        b=54ngzvmvLXSccxNPmRQ+vhJQwt2pqA0MKZpVTj3H21iTdphxn1300ta1uPaIX45RYz
         HHX5xnVSfOpus94CEmxu7rSqSP40MR9ewCKoNG0l8mp6DFggUvHj9r9+JNyXwfM/lf5B
         F0oOigToaZiqKwGJjAWR0Y7XGAA9FYpLcdC+9jnHtdYzq0lQBn9DUV/MM8QF9msMZUMX
         58hONkQ+J6HU4nu15pdJEb84hiuy2DbwNOOXhEY2TSqpgFD7lqPwnvSXYipOuKN3Nr7S
         TIx5CNcS8T5wvZ/16rH0M/TUnICrRPxfb19CMCq+l2PSKzFkr/oRXQ/Dqt9b0mP66gjd
         wzNw==
X-Gm-Message-State: AJIora9z6Co0PcHCCM/f4LFHw8WmRxnSGPQ3p8dSIgYyDSVYtbKxVLZd
        iE+/zQtfCmO54fZN3PeRjqgxkCftQRA=
X-Google-Smtp-Source: AGRyM1tWlugfQIIYEib07fLaAjC/2/IOKFzUdbG5aWMMUtCbtKwbSjsIM0Az16zJbBm/bTz35jUIRA==
X-Received: by 2002:a92:8748:0:b0:2d9:3f81:d0b7 with SMTP id d8-20020a928748000000b002d93f81d0b7mr6466509ilm.310.1658842560547;
        Tue, 26 Jul 2022 06:36:00 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-180.dsl.bell.ca. [184.147.143.180])
        by smtp.gmail.com with ESMTPSA id e42-20020a02212a000000b00339ceeec5edsm6617760jaa.12.2022.07.26.06.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:36:00 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Manasi Godse <magodse@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 6/6] rteval: Make use of systopology instead of misc in cyclictest
Date:   Tue, 26 Jul 2022 09:35:35 -0400
Message-Id: <20220726133535.10824-7-jkacur@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220726133535.10824-1-jkacur@redhat.com>
References: <20220726133535.10824-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- Make use of systopology instead of misc in cyclictest
- Use f-strings instead of regular strings
- Use "with" for an open

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 67 +++++++++++++-----------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 4c8d510c4a34..9e7f4ba25eab 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -35,7 +35,10 @@ import math
 import libxml2
 from rteval.Log import Log
 from rteval.modules import rtevalModulePrototype
-from rteval.misc import expand_cpulist, online_cpus, cpuinfo
+from rteval.misc import cpuinfo
+from rteval.systopology import CpuList, SysTopology
+
+expand_cpulist = CpuList.expand_cpulist
 
 class RunData:
     '''class to keep instance data from a cyclictest run'''
@@ -58,14 +61,14 @@ class RunData:
         self._log = logfnc
 
     def __str__(self):
-        retval = "id:         %s\n" % self.__id
-        retval += "type:       %s\n" % self.__type
-        retval += "numsamples: %d\n" % self.__numsamples
-        retval += "min:        %d\n" % self.__min
-        retval += "max:        %d\n" % self.__max
-        retval += "stddev:     %f\n" % self.__stddev
-        retval += "mad:        %f\n" % self.__mad
-        retval += "mean:       %f\n" % self.__mean
+        retval = f"id:         {self.__id}\n"
+        retval += f"type:       {self.__type}\n"
+        retval += f"numsamples: {self.__numsamples}\n"
+        retval += f"min:        {self.__min}\n"
+        retval += f"max:        {self.__max}\n"
+        retval += f"stddev:     {self.__stddev}\n"
+        retval += f"mad:        {self.__mad}\n"
+        retval += f"mean:       {self.__mean}\n"
         return retval
 
     def get_max(self):
@@ -98,12 +101,12 @@ class RunData:
         # only have 1 (or none) set the calculated values
         # to zero and return
         if self.__numsamples <= 1:
-            self._log(Log.DEBUG, "skipping %s (%d samples)" % (self.__id, self.__numsamples))
+            self._log(Log.DEBUG, f"skipping {self.__id} ({self.__numsamples} samples)")
             self.__mad = 0
             self.__stddev = 0
             return
 
-        self._log(Log.INFO, "reducing %s" % self.__id)
+        self._log(Log.INFO, f"reducing {self.__id}")
         total = 0
         keys = list(self.__samples.keys())
         keys.sort()
@@ -198,6 +201,7 @@ class RunData:
 
 
 class Cyclictest(rtevalModulePrototype):
+    """ measurement module for rteval """
     def __init__(self, config, logger=None):
         rtevalModulePrototype.__init__(self, 'measurement', 'cyclictest', logger)
         self.__cfg = config
@@ -214,9 +218,12 @@ class Cyclictest(rtevalModulePrototype):
         if self.__cfg.cpulist:
             self.__cpulist = self.__cfg.cpulist
             self.__cpus = expand_cpulist(self.__cpulist)
+            # Only include online cpus
+            self.__cpus = CpuList(self.__cpus).cpulist
+            self.__cpus = [str(c) for c in self.__cpus]
             self.__sparse = True
         else:
-            self.__cpus = online_cpus()
+            self.__cpus = SysTopology().online_cpus_str()
             # Get the cpuset from the environment
             cpuset = os.sched_getaffinity(0)
             # Convert the elements to strings
@@ -241,12 +248,12 @@ class Cyclictest(rtevalModulePrototype):
         self.__cyclicdata['system'] = RunData('system',
                                               'system', self.__priority,
                                               logfnc=self._log)
-        self.__cyclicdata['system'].description = ("(%d cores) " % self.__numcores) + info['0']['model name']
+        self.__cyclicdata['system'].description = (f"({self.__numcores} cores) ") + info['0']['model name']
 
         if self.__sparse:
-            self._log(Log.DEBUG, "system using %d cpu cores" % self.__numcores)
+            self._log(Log.DEBUG, f"system using {self.__numcores} cpu cores")
         else:
-            self._log(Log.DEBUG, "system has %d cpu cores" % self.__numcores)
+            self._log(Log.DEBUG, f"system has {self.__numcores} cpu cores")
         self.__started = False
         self.__cyclicoutput = None
         self.__breaktraceval = None
@@ -273,30 +280,30 @@ class Cyclictest(rtevalModulePrototype):
 
 
     def _WorkloadPrepare(self):
-        self.__interval = 'interval' in self.__cfg and '-i%d' % int(self.__cfg.interval) or ""
+        self.__interval = 'interval' in self.__cfg and f'-i{int(self.__cfg.interval)}' or ""
 
         self.__cmd = ['cyclictest',
                       self.__interval,
                       '-qmu',
-                      '-h %d' % self.__buckets,
-                      "-p%d" % int(self.__priority),
+                      f'-h {self.__buckets}',
+                      f"-p{int(self.__priority)}",
                       ]
         if self.__sparse:
-            self.__cmd.append('-t%d' % self.__numcores)
-            self.__cmd.append('-a%s' % self.__cpulist)
+            self.__cmd.append(f'-t{self.__numcores}')
+            self.__cmd.append(f'-a{self.__cpulist}')
         else:
             self.__cmd.append('-t')
             self.__cmd.append('-a')
 
         if 'threads' in self.__cfg and self.__cfg.threads:
-            self.__cmd.append("-t%d" % int(self.__cfg.threads))
+            self.__cmd.append(f"-t{int(self.__cfg.threads)}")
 
         # Should have either breaktrace or threshold, not both
         if 'breaktrace' in self.__cfg and self.__cfg.breaktrace:
-            self.__cmd.append("-b%d" % int(self.__cfg.breaktrace))
+            self.__cmd.append(f"-b{int(self.__cfg.breaktrace)}")
             self.__cmd.append("--tracemark")
         elif self.__cfg.threshold:
-            self.__cmd.append("-b%d" % int(self.__cfg.threshold))
+            self.__cmd.append(f"-b{int(self.__cfg.threshold)}")
 
         # Buffer for cyclictest data written to stdout
         self.__cyclicoutput = tempfile.SpooledTemporaryFile(mode='w+b')
@@ -307,17 +314,16 @@ class Cyclictest(rtevalModulePrototype):
             # Don't restart cyclictest if it is already runing
             return
 
-        self._log(Log.DEBUG, "starting with cmd: %s" % " ".join(self.__cmd))
+        self._log(Log.DEBUG, f'starting with cmd: {" ".join(self.__cmd)}')
         self.__nullfp = os.open('/dev/null', os.O_RDWR)
 
         debugdir = self.__get_debugfs_mount()
         if 'breaktrace' in self.__cfg and self.__cfg.breaktrace and debugdir:
             # Ensure that the trace log is clean
             trace = os.path.join(debugdir, 'tracing', 'trace')
-            fp = open(os.path.join(trace), "w")
-            fp.write("0")
-            fp.flush()
-            fp.close()
+            with open(os.path.join(trace), "w") as fp:
+                fp.write("0")
+                fp.flush()
 
         self.__cyclicoutput.seek(0)
         try:
@@ -380,7 +386,7 @@ class Cyclictest(rtevalModulePrototype):
             try:
                 index = int(vals[0])
             except:
-                self._log(Log.DEBUG, "cyclictest: unexpected output: %s" % line)
+                self._log(Log.DEBUG, f"cyclictest: unexpected output: {line}")
                 continue
 
             for i, core in enumerate(self.__cpus):
@@ -420,8 +426,7 @@ class Cyclictest(rtevalModulePrototype):
 
         # Let the user know if max latency overshot the number of buckets
         if self.__cyclicdata["system"].get_max() > self.__buckets:
-            self._log(Log.ERR, "Max latency(%dus) exceeded histogram range(%dus). Skipping statistics" %
-                      (self.__cyclicdata["system"].get_max(), self.__buckets))
+            self._log(Log.ERR, f'Max latency({self.__cyclicdata["system"].get_max()}us) exceeded histogram range({self.__buckets}us). Skipping statistics')
             self._log(Log.ERR, "Increase number of buckets to avoid lost samples")
             return rep_n
 
-- 
2.37.1

