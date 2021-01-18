Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52070C433E6
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Jan 2021 20:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C4A22D2A
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Jan 2021 20:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388988AbhARKkS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Jan 2021 05:40:18 -0500
Received: from mo-csw-fb1115.securemx.jp ([210.130.202.174]:42076 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388521AbhARJRD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Jan 2021 04:17:03 -0500
X-Greylist: delayed 834 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jan 2021 04:17:02 EST
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1115) id 10I92sqq013900; Mon, 18 Jan 2021 18:02:54 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 10I90n09027149; Mon, 18 Jan 2021 18:00:49 +0900
X-Iguazu-Qid: 2wGqsXjpvXBKuhIulU
X-Iguazu-QSIG: v=2; s=0; t=1610960449; q=2wGqsXjpvXBKuhIulU; m=+Na5srjnQXJHihItUyanulP+p1oAGM70hByVfekN4No=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1111) id 10I90mHu014495;
        Mon, 18 Jan 2021 18:00:48 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 10I90m5J022084;
        Mon, 18 Jan 2021 18:00:48 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 10I90lVI007798;
        Mon, 18 Jan 2021 18:00:48 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     jkacur@redhat.com
Cc:     binh1.tranhai@toshiba.co.jp,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>,
        dwagner@suse.de, linux-rt-users@vger.kernel.org
Subject: Some issues running rteval on arm64, arm and i386
Date:   Mon, 18 Jan 2021 18:00:46 +0900
X-TSB-HOP: ON
Message-ID: <877doa1uwx.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi John,

We ran into a few issues when trying to run rteval on arm64, arm and
i386.

A few of the assumptions in rteval don't hold true on these systems.

    1. On arm64, there is no 'model name' in /proc/cpuinfo. See attached
       sample output from qemu arm64. I verified the same behaviour on
       an arm64 board we have as well.

    2. Also, the build target for the kernel on arm64 is "Image" of
       "bzImage". Rather than use different targets per-architecture it
       maybe better to drop it all together. Do you see any downsides?

The attached patches[1][2] gets things moving with regards to Issues 1
and 2 locally but I am not sure that's the best solution - especially
for "cpuinfo".

    3. Both arm and i386 do not provide "numa" nodes in sysfs. This
       causes rteval to complain "No valid nodes found in
       /sys/devices/system/node"

       Is this requirement planned to be relaxed - it'll be really
       useful to be able to use rteval on these architectures.

Thanks,
Punit


--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=cpuinfo-arm64.txt
Content-Description: arm64 cpuinfo

processor	: 0
BogoMIPS	: 125.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd08
CPU revision	: 3

processor	: 1
BogoMIPS	: 125.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd08
CPU revision	: 3

processor	: 2
BogoMIPS	: 125.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd08
CPU revision	: 3

processor	: 3
BogoMIPS	: 125.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd08
CPU revision	: 3


--=-=-=
Content-Type: text/x-diff
Content-Disposition: attachment;
 filename=0001-rteval-cyclictest.py-Make-model-name-optional.patch
Content-Description: Make model name optional

From 684b785cd0d1e75d922200fb93cd83bcd225097e Mon Sep 17 00:00:00 2001
From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Date: Mon, 18 Jan 2021 17:51:12 +0900
Subject: [PATCH 1/2] rteval: cyclictest.py: Make 'model name' optional

Certain architectures such as arm64 don't have a "model name" in
/proc/cpuinfo. Relax the requirement to include the model name in the
description to allow running rteval on such machines.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 rteval/modules/measurement/cyclictest.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 232bd6b..afe87f7 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -217,13 +217,13 @@ class Cyclictest(rtevalModulePrototype):
         for core in self.__cpus:
             self.__cyclicdata[core] = RunData(core, 'core', self.__priority,
                                               logfnc=self._log)
-            self.__cyclicdata[core].description = info[core]['model name']
+            self.__cyclicdata[core].description = info[core].get('model name', '')
 
         # Create a RunData object for the overall system
         self.__cyclicdata['system'] = RunData('system',
                                               'system', self.__priority,
                                               logfnc=self._log)
-        self.__cyclicdata['system'].description = ("(%d cores) " % self.__numcores) + info['0']['model name']
+        self.__cyclicdata['system'].description = ("(%d cores) " % self.__numcores) + info['0'].get('model name', '')
 
         if self.__sparse:
             self._log(Log.DEBUG, "system using %d cpu cores" % self.__numcores)
-- 
2.29.2


--=-=-=
Content-Type: text/x-diff
Content-Disposition: attachment;
 filename=0002-rteval-cyclictest.py-Make-build-targets-architecture.patch
Content-Description: Drop kernel build targets

From 8095a27755bcad4542ae98bc3fd80d2ec2ef46fe Mon Sep 17 00:00:00 2001
From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Date: Mon, 18 Jan 2021 17:53:52 +0900
Subject: [PATCH 2/2] rteval: cyclictest.py: Make build targets architecture
 independent

Not all kernel archiectures provide the "bzImage" target, e.g., arm64
provides "Image" which generates an uncompressed kernel binary.

Instead of going down the path of customizing build targets
per-architecture, let's drop them altogether. The default kernel
target should build the kernel and modules on all architectures
anyways.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 rteval/modules/loads/kcompile.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 326f1ae..e747b9f 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -58,7 +58,7 @@ class KBuildJob:
         else:
             self.jobs = self.calc_jobs_per_cpu() * len(self.node)
         self.log(Log.DEBUG, "node %d: jobs == %d" % (int(node), self.jobs))
-        self.runcmd = "%s make O=%s -C %s -j%d bzImage modules" \
+        self.runcmd = "%s make O=%s -C %s -j%d" \
                 % (self.binder, self.objdir, self.kdir, self.jobs)
         self.cleancmd = "%s make O=%s -C %s clean allmodconfig" \
                 % (self.binder, self.objdir, self.kdir)
-- 
2.29.2


--=-=-=--
