Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D7AC00144
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Jul 2022 01:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbiG0BNR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jul 2022 21:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiG0BNP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jul 2022 21:13:15 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F73A12A9A
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 18:13:14 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e69so12598253iof.5
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 18:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VhVlbGVj1uQpopx6jwA72A6b122fTsBMg74Qxkns5r4=;
        b=Gb7HkYFmUaDpo+XcJVSwI67H2tYljda23mbeB1PX3a5ckdR5ivs980YzHahunmIj/V
         yuH/TGbzbo3pwVciknT1PzDqbJJg+nsAXRIEhs3SFxu5PuU9+le72Pa1YGaYR8XAtryb
         8+WIGNjPsq9gUpGl0oHk3bUXtMSXjPWkix29iOk9k3uEeZOsV1O8dk2MqCatGPPC7IQz
         uw0R3hHIJiH5j6i6+3NOH4iStdualAfrczRsxvCOHzl7SHP04CRYi8Fdxh6IRxKqe6Cd
         zizzsQendmZbLAj3ekLMSSGAZrfL9thbWImedvsJ/faRmoLan9zrxAjYeNUdbNxVzhOC
         78RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=VhVlbGVj1uQpopx6jwA72A6b122fTsBMg74Qxkns5r4=;
        b=OeoTTTLcWsc5nHJ3DzJ4t+ml7+gScNA+o72VIOze0LdWwvvsHVEIed90pC1EZvoqXV
         txdEpRl/7U0kz9DiJ1a4xwIoTn4/LzTJ8zEheMuqyhw6InvF0ZfdVA3XmiumYmhO+pPs
         8o5y/cWjtSbABDXbSJQjpCIoyAB9QTM+5ZURDUW6wxa9UpY0NxZxij9yBzz6NlbdnFFm
         mF8siddACmxk02k6fbKsjD3GrK8rV5EPLYiOJSCdmhYVkhUyBnNCO1CF+Jk8bV8aD+fA
         wsxroP9oRwhu6x8uwRSNlvFLgbK93DUS5yDKo8kuiT78l0P80HMDuMgyNIQm4OjHK/lx
         wDsQ==
X-Gm-Message-State: AJIora97oz9TAgIWYlpiXSq0xnvd8CiB4DSB+BXHd4lUZ0CAj9EGJ9ED
        dR7UkGOaEJraCfHPveIMTLf8h+XzsFM=
X-Google-Smtp-Source: AGRyM1sOqZ0PrL8PM4+sMMrwzcqziHK5HKVEHruvnLoitOoPZHGXQtU2ea2HV69reyXWC9C3sbNpiw==
X-Received: by 2002:a05:6638:2596:b0:33f:8e41:a3b6 with SMTP id s22-20020a056638259600b0033f8e41a3b6mr7996197jat.266.1658884393219;
        Tue, 26 Jul 2022 18:13:13 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-180.dsl.bell.ca. [184.147.143.180])
        by smtp.gmail.com with ESMTPSA id cs11-20020a056638470b00b0033ed273345bsm7317405jab.96.2022.07.26.18.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 18:13:12 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Manasi Godse <magodse@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH V2 2/6] rteval: Make use of systopology instead of misc in hackbench
Date:   Tue, 26 Jul 2022 21:12:01 -0400
Message-Id: <20220727011202.158917-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- Make use of systopology instead of misc in hackbench
- Add a module docstring
- Make use of f-strings

Signed-off-by: John Kacur <jkacur@redhat.com>
- Add missing "f" from f-string in __starton in hackbench.py
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/loads/hackbench.py | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
index ddd1378bac75..538f60f00282 100644
--- a/rteval/modules/loads/hackbench.py
+++ b/rteval/modules/loads/hackbench.py
@@ -24,6 +24,7 @@
 #   including keys needed to generate an equivalently functional executable
 #   are deemed to be part of the source code.
 #
+""" Load module - run the hackbench program from rt-tests ad a load """
 
 import sys
 import os
@@ -34,8 +35,9 @@ import errno
 from signal import SIGKILL
 from rteval.modules.loads import CommandLineLoad
 from rteval.Log import Log
-from rteval.misc import expand_cpulist
-from rteval.systopology import SysTopology
+from rteval.systopology import CpuList, SysTopology
+
+expand_cpulist = CpuList.expand_cpulist
 
 class Hackbench(CommandLineLoad):
     def __init__(self, config, logger):
@@ -46,7 +48,7 @@ class Hackbench(CommandLineLoad):
         if self._donotrun:
             return
 
-        'calculate arguments based on input parameters'
+        # calculate arguments based on input parameters
         (mem, units) = self.memsize
         if units == 'KB':
             mem = mem / (1024.0 * 1024.0)
@@ -58,9 +60,9 @@ class Hackbench(CommandLineLoad):
         ratio = float(mem) / float(self.num_cpus)
         if ratio < 0.75:
             if self.__cfg.runlowmem:
-                self._log(Log.WARN, "Low memory system (%f GB/core)!" % ratio)
+                self._log(Log.WARN, f"Low memory system ({ratio} GB/core)!")
             else:
-                self._log(Log.WARN, "Low memory system (%f GB/core)! Not running hackbench" % ratio)
+                self._log(Log.WARN, f"Low memory system ({ratio} GB/core)! Not running hackbench")
                 self._donotrun = True
 
         sysTop = SysTopology()
@@ -85,7 +87,7 @@ class Hackbench(CommandLineLoad):
         for node, cpus in list(self.cpus.items()):
             if not cpus:
                 self.nodes.remove(node)
-                self._log(Log.DEBUG, "node %s has no available cpus, removing" % node)
+                self._log(Log.DEBUG, f"node {node} has no available cpus, removing")
 
         # setup jobs based on the number of cores available per node
         self.jobs = biggest * 3
@@ -95,7 +97,7 @@ class Hackbench(CommandLineLoad):
         self.__multinodes = False
         if len(self.nodes) > 1:
             self.__multinodes = True
-            self._log(Log.INFO, "running with multiple nodes (%d)" % len(self.nodes))
+            self._log(Log.INFO, f"running with multiple nodes ({len(self.nodes)})")
             if os.path.exists('/usr/bin/numactl') and not self.cpulist:
                 self.__usenumactl = True
                 self._log(Log.INFO, "using numactl for thread affinity")
@@ -121,7 +123,7 @@ class Hackbench(CommandLineLoad):
 
         self.tasks = {}
 
-        self._log(Log.DEBUG, "starting loop (jobs: %d)" % self.jobs)
+        self._log(Log.DEBUG, f"starting loop (jobs: {self.jobs})")
 
         self.started = False
 
@@ -135,14 +137,14 @@ class Hackbench(CommandLineLoad):
         else:
             args = self.args
 
-        self._log(Log.DEBUG, "starting on node %s: args = %s" % (node, args))
+        self._log(Log.DEBUG, f"starting on node {node}: args = {args}")
         p = subprocess.Popen(args,
                              stdin=self.__nullfp,
                              stdout=self.__out,
                              stderr=self.__err)
         if not p:
-            self._log(Log.DEBUG, "hackbench failed to start on node %s" % node)
-            raise RuntimeError("hackbench failed to start on node %s" % node)
+            self._log(Log.DEBUG, f"hackbench failed to start on node {node}")
+            raise RuntimeError(f"hackbench failed to start on node {node}")
         return p
 
     def _WorkloadTask(self):
@@ -181,7 +183,7 @@ class Hackbench(CommandLineLoad):
 
         for node in self.nodes:
             if node in self.tasks and self.tasks[node].poll() is None:
-                self._log(Log.INFO, "cleaning up hackbench on node %s" % node)
+                self._log(Log.INFO, f"cleaning up hackbench on node {node}")
                 self.tasks[node].send_signal(SIGKILL)
                 if self.tasks[node].poll() is None:
                     time.sleep(2)
@@ -213,7 +215,3 @@ def ModuleParameters():
 def create(config, logger):
     return Hackbench(config, logger)
 
-# TODO: The following test is broken
-#if __name__ == '__main__':
-#    h = Hackbench(params={'debugging':True, 'verbose':True})
-#    h.run()
-- 
2.37.1

