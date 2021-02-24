Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BB7C433E6
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Feb 2021 02:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4554664EBA
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Feb 2021 02:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhBXCSg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Feb 2021 21:18:36 -0500
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:42824 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhBXCSd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Feb 2021 21:18:33 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 11O2GLhw004324; Wed, 24 Feb 2021 11:16:22 +0900
X-Iguazu-Qid: 34tMScsDBAHSEpch6c
X-Iguazu-QSIG: v=2; s=0; t=1614132981; q=34tMScsDBAHSEpch6c; m=zAzlEpJHbaSRYuLhFOc8/DLIQiuTts9deS/tqnJ84uE=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1513) id 11O2GKKH036514
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Feb 2021 11:16:21 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id B623E1000BA;
        Wed, 24 Feb 2021 11:16:20 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 11O2GKtB008762;
        Wed, 24 Feb 2021 11:16:20 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     John Kacur <jkacur@redhat.com>
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, dwagner@suse.de,
        "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org, binh1.tranhai@toshiba.co.jp,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: [rteval PATCH v2 1/3] rteval: cyclictest.py: Update logic to get core description
Date:   Wed, 24 Feb 2021 11:16:01 +0900
X-TSB-HOP: ON
Message-Id: <20210224021603.446274-2-punit1.agrawal@toshiba.co.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210224021603.446274-1-punit1.agrawal@toshiba.co.jp>
References: <20210224021603.446274-1-punit1.agrawal@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Certain architectures such as arm and arm64 don't have a "model name"
in /proc/cpuinfo but provide other identifying information such as
implementer, architecture, variant, part, revision, etc..

Add a function 'get_cpumodel()' that takes the per-core dictionary
constructed from /proc/cpuinfo and uses the available data to
construct the CPU description. Update the users of "model name" to use
the newly added function.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 rteval/misc.py                           | 24 +++++++++++++++++++++++-
 rteval/modules/measurement/cyclictest.py |  8 +++++---
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/rteval/misc.py b/rteval/misc.py
index 0dd361f..c3ca354 100644
--- a/rteval/misc.py
+++ b/rteval/misc.py
@@ -79,6 +79,28 @@ def cpuinfo():
         info[core][key] = val
     return info
 
+# Pass the per-core dictionary that is part of the dictionary returned
+# by cpuinfo()
+def get_cpumodel(core_info):
+    desc = info[core].get('model name', '')
+    if not desc:
+        # On Arm (both 32 and 64 bit), 'CPU Implementer' is always
+        # present. Return 'unknown' otherwise
+        if 'CPU Implementer' not in info[core]:
+            desc = 'unknown'
+            break
+
+        implementor = core_info.get('CPU implementer', '')
+        architecture = core_info.get('CPU architecture', '')
+        variant = core_info.get('CPU variant', '')
+        part = core_info.get('CPU part', '')
+        revision = core_info.get('CPU revision', '')
+
+        desc = 'Implementor: %s Architecture: %s Variant: %s Part: %s Revision: %s' \
+            % (implementor, architecture, variant, part, revision)
+
+    return desc
+
 if __name__ == "__main__":
 
     info = cpuinfo()
@@ -86,4 +108,4 @@ if __name__ == "__main__":
     for i in idx:
         print("%s: %s" % (i, info[i]))
 
-    print("0: %s" % (info['0']['model name']))
+    print("0: %s" % (get_cpumodel(info['0'])))
diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 232bd6b..c9e1dfb 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -34,7 +34,7 @@ import math
 import libxml2
 from rteval.Log import Log
 from rteval.modules import rtevalModulePrototype
-from rteval.misc import expand_cpulist, online_cpus, cpuinfo
+from rteval.misc import expand_cpulist, online_cpus, cpuinfo, get_cpumodel
 
 class RunData:
     '''class to keep instance data from a cyclictest run'''
@@ -217,13 +217,15 @@ class Cyclictest(rtevalModulePrototype):
         for core in self.__cpus:
             self.__cyclicdata[core] = RunData(core, 'core', self.__priority,
                                               logfnc=self._log)
-            self.__cyclicdata[core].description = info[core]['model name']
+            self.__cyclicdata[core].description = get_cpumodel(info[core])
+            if self.__cyclicdata[core].description == 'unknown':
+                self._log(Log.INFO, "Unknown model for core %d" % core)
 
         # Create a RunData object for the overall system
         self.__cyclicdata['system'] = RunData('system',
                                               'system', self.__priority,
                                               logfnc=self._log)
-        self.__cyclicdata['system'].description = ("(%d cores) " % self.__numcores) + info['0']['model name']
+        self.__cyclicdata['system'].description = ("(%d cores) " % self.__numcores) + get_cpumodel(info['0'])
 
         if self.__sparse:
             self._log(Log.DEBUG, "system using %d cpu cores" % self.__numcores)
-- 
2.30.0

