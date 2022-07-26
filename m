Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED45FCCA489
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jul 2022 13:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbiGZNgB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jul 2022 09:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiGZNgA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jul 2022 09:36:00 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21E925EF
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 06:35:58 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id v185so11165042ioe.11
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 06:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gBBoiwCwGvq6uV4fk7sgyse6ec8E0fOuJ+OlMEDFM74=;
        b=RrbfkP72PF+VPiVcp4kquJtU+wLOi9Ldl1s/U1d6PekNax1/k+r9iJrM59ml9uklhd
         9aGmTq/zIo1EAMkN2raQ0b2fns1yqfQOU71ICrfWE3Pk1qmXjc+boHNIMM00tnO0mIIa
         EJHuOl0HMORsTSbT9ksgGxRbDB187omzn7QhK48kwLkTH/t40O3V8pRrObn1hP9Uagji
         PYGjbEQr4rWiXGR/jPAWzItyial9WDb9/k4/9brD8b0mClutFS1lDdv48GybVF8evUrw
         PQfm2PNYn3fNGU8pO53H9/94FlP0K8VklGF79ssQadjFwSUSZgu67s2BIS5va8y4dYg5
         JKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gBBoiwCwGvq6uV4fk7sgyse6ec8E0fOuJ+OlMEDFM74=;
        b=idd8OGqiGP4g3w5x5wxwK9NlHHtkimtwRh5iyvYR9IYPcK8qs0L8Ej2VsFZ6E6hvEv
         TL0C8q/NPcthjk6arvrAzyk+UfGKf1LAlcLchBu7wUwHcGnK4MJP/WQc1ZCqAHcssC7C
         pY2rymKwr/eJW8ZUyPvPkkTrRJOfpgMshqjQ99pdR+fHkUMpNOUXUCQEQFSUrRT8ZFdu
         62aMz43jKyzdkaC5aegeFqJcfv/WOQi8QV2VE4Mf9Unrnstg6qgJKMTkO1UFACLxbWmP
         Yly3ovtEVcDGXPRTMezUL3lv/dEqKxWpXRzPK3eqbVea03kL3MtD5LPTs95FkgOnSptO
         oxhw==
X-Gm-Message-State: AJIora+Et1iyRPv+2TslohxtdI5/XMAocmDh+MlSCdebpisB6oA+YsJ3
        JRaOVRwFi21PHLTSxsEx2v6FusKxDbw=
X-Google-Smtp-Source: AGRyM1uk20k3FZ13mB4mz9S8rCkETL/UMVFaYFsi7nLrxev2ey8JWgIBeAcB+csYplZYxJgnTRWqSQ==
X-Received: by 2002:a05:6638:d52:b0:341:40ca:b21f with SMTP id d18-20020a0566380d5200b0034140cab21fmr7155706jak.35.1658842558279;
        Tue, 26 Jul 2022 06:35:58 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-180.dsl.bell.ca. [184.147.143.180])
        by smtp.gmail.com with ESMTPSA id e42-20020a02212a000000b00339ceeec5edsm6617760jaa.12.2022.07.26.06.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:35:58 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Manasi Godse <magodse@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/6] rteval: Make use of systopology instead of misc in hackbench
Date:   Tue, 26 Jul 2022 09:35:32 -0400
Message-Id: <20220726133535.10824-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220726133535.10824-1-jkacur@redhat.com>
References: <20220726133535.10824-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- Make use of systopology instead of misc in hackbench
- Add a module docstring
- Make use of f-strings

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/loads/hackbench.py | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
index ddd1378bac75..45bcd546e3b3 100644
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
+        self._log(Log.DEBUG, "starting on node node{}: args = {args}")
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

