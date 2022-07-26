Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2DDC43334
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jul 2022 13:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbiGZNgD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jul 2022 09:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbiGZNgB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jul 2022 09:36:01 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B281F6354
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 06:36:00 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id l24so11169932ion.13
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 06:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Mw1yZaGpjmabRTA/vSIcoZD9lSEnSd7ow5ifReFqBQ=;
        b=mBKY2WFiskhYPRc6BkRqeVJzoWm9rCE0iGsQtX/YWe8FWNuj4GKIbsFytcqxGzDcHP
         ds3wDRbDwtwHGbLBdzHoh81E1TjtEScD/ftc5jMc0PxRDx3V8zr4SG7ltfn/MSvAbRog
         3iD78o2MXMGG+zZXpu1HX+Zt/e/mYP1fPBQqeCqfR97sXApVuzKZED3qejsvBd/+Aajz
         1tfZKUv9tFXhE01QidinHPrKQ8k26BeZhyVUvL49He96fPhQ1V83i/0WBKlA3d8nexzp
         8atnQF92akUNgY5SSJ7GhfcnMSkguREJxMxBFAEEgWxmRG2n0DS+esoKnD5gSK0unuYe
         uRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0Mw1yZaGpjmabRTA/vSIcoZD9lSEnSd7ow5ifReFqBQ=;
        b=7Ww7E/NVBfsixwDiftFMEgVn2cGOsxwpkUu3GN5/7ZYFa98rrs7J5RTfJWS6stctZo
         DLyPQt3lVAsP9pn0liXWndVq//QDbJKS/QUMJY52s6LBR11lJERfpAExm2NqmDpF2QRz
         2hfYpyHNEO7ZTU0GvEwSwg9QBDO/yAYoGhZfTjDU9qaAtlFNK5YfPNJ9xdn9JoR4evvm
         MhbTNkluE4l/9GWMm5AAnYMI89j51ibWK7Jlcn+OUWH9hYHTFPmTA1fbsaLx6IFeRhso
         J4SaiwdTWOxlRpZOD0Wr+31VJFeNmvFLoE/na7W/pSJec93hNT4gWvt0plyPl9gadLAs
         OfNQ==
X-Gm-Message-State: AJIora9hEmH54gGERsiij7Xx/h+LusFgyM3mS6b+wtBkz17i0alj//GP
        SbQrDcn1A6L6fxPXezi3XMbyNhU7Adg=
X-Google-Smtp-Source: AGRyM1vUejkjekr1P0U1iLk8kjj3cZbXpFjIsRomNUd4VxAnK0ubz4Fsr9a/mCTiCSQtvpxryHlsLA==
X-Received: by 2002:a05:6638:4194:b0:33f:4795:5c68 with SMTP id az20-20020a056638419400b0033f47955c68mr6625717jab.193.1658842559761;
        Tue, 26 Jul 2022 06:35:59 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-180.dsl.bell.ca. [184.147.143.180])
        by smtp.gmail.com with ESMTPSA id e42-20020a02212a000000b00339ceeec5edsm6617760jaa.12.2022.07.26.06.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:35:59 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Manasi Godse <magodse@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 5/6] rteval: Make use of systopology instead of misc in stressng module
Date:   Tue, 26 Jul 2022 09:35:34 -0400
Message-Id: <20220726133535.10824-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220726133535.10824-1-jkacur@redhat.com>
References: <20220726133535.10824-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- rteval: Make use of systopology instead of misc in stressng module
- make use of f-strings instead of regular strings

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/loads/stressng.py | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index fe97189d3816..287f4e232d17 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -6,8 +6,9 @@ import subprocess
 import signal
 from rteval.modules.loads import CommandLineLoad
 from rteval.Log import Log
-from rteval.misc import expand_cpulist
-from rteval.systopology import SysTopology
+from rteval.systopology import CpuList, SysTopology
+
+expand_cpulist = CpuList.expand_cpulist
 
 class Stressng(CommandLineLoad):
     " This class creates a load module that runs stress-ng "
@@ -27,7 +28,7 @@ class Stressng(CommandLineLoad):
             self._donotrun = False
         else:
             self._donotrun = True
-        """ When this module runs, other load modules should not """
+        # When this module runs, other load modules should not
         self._exclusive = True
 
     def _WorkloadSetup(self):
@@ -50,7 +51,7 @@ class Stressng(CommandLineLoad):
 
         # stress-ng is only run if the user specifies an option
         self.args = ['stress-ng']
-        self.args.append('--%s' % str(self.cfg.option))
+        self.args.append(f'--{str(self.cfg.option)}')
         if self.cfg.arg is not None:
             self.args.append(self.cfg.arg)
         if self.cfg.timeout is not None:
@@ -73,11 +74,11 @@ class Stressng(CommandLineLoad):
         for node, cpu in cpus.items():
             if not cpu:
                 nodes.remove(node)
-                self._log(Log.DEBUG, "node %s has no available cpus, removing" % node)
+                self._log(Log.DEBUG, f"node {node} has no available cpus, removing")
         if self.cpulist:
             for node in nodes:
                 cpulist = ",".join([str(n) for n in cpus[node]])
-                self.args.append('--taskset %s' % cpulist)
+                self.args.append(f'--taskset {cpulist}')
 
     def _WorkloadTask(self):
         """ Kick of the workload here """
@@ -85,7 +86,7 @@ class Stressng(CommandLineLoad):
             # Only start the task once
             return
 
-        self._log(Log.DEBUG, "starting with %s" % " ".join(self.args))
+        self._log(Log.DEBUG, f'starting with {" ".join(self.args)}')
         try:
             self.process = subprocess.Popen(self.args,
                                             stdout=self.__out,
-- 
2.37.1

