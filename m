Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77F4C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jan 2022 18:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiAMScT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Jan 2022 13:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiAMScS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Jan 2022 13:32:18 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81569C061574
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Jan 2022 10:32:18 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c19so8171278qtx.3
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Jan 2022 10:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tG2QxnrtIHvZCBDM9ZBRXd4l4PUQ8iz5xODVPIlPM/4=;
        b=if72D4g2Ir78Y81qaY1cyJmYbSkVBWkVTRrTDdtlWgQxeHLHUT+cXSrx6+hgdphk8F
         OFoELO2DWMKwwrz9Hih41TEpUbkbZy4XNCM9HoFThpNUlBmje6POgmgsWRQt+QyIht71
         JfSYtRwnWqinn5JqfzUqfDIn/5LDXhAURpifXXb28gy8NYt2MgeBd/Ses2kMjek1aK2j
         FZxS9KbuClDf8tLLek5NlGliRkDnMozEVon75tyheJexpLvKNlHFlAxKm6JzpzWAIa0v
         qtKFuZV9/PueLBrVSVHQ4l3Wb/Ku6eR2QJUAm/wGoyv2+aVGxmMYjqXc0VglZOQXn9pM
         BokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=tG2QxnrtIHvZCBDM9ZBRXd4l4PUQ8iz5xODVPIlPM/4=;
        b=iLbBiYD2lPXad0DfiCKKevWv35GUnGILA+z/YS1AL7KbJPQPZWNaaoUttGH5ddJe7z
         pH6hCp2vNeFoPfYQQ5MHnx446R6H3zIk1VfShdTwQ6QS605mjdMuXWbbKR0dM4BS13Et
         S1vr/cyvVXnJYRz5OOOF1X9C00Wd8qplkgHZnKmsH8EvEJHYOxtZTZIlNYudRC8farnc
         cbEkF/jgbHgAzPFuofP+J6OX36L8eBs2DJpTukyuwwOz8rwrRmTQX8hC33/sQpR1hcG+
         KKucyeH6x2sbg8n2taxqQ0K6+W3jLdGkSCklHbGumZxOEfPxZRanmsTFzuA0NPyZTIsF
         KI6g==
X-Gm-Message-State: AOAM5333RceKO9EXV+0LW1cz9a0abuOnLa0H3agI80DksC/OWL/RiwU6
        KcTR1yrpjaZHXT2gzk0KOktFCkrXPHg=
X-Google-Smtp-Source: ABdhPJxVi7t0MUXsWMzub12ouVXgl1ECtOSL8k9n7Sm0xSKpujf3hA+3DwX0OCgXeP2/PfrnmqaOSg==
X-Received: by 2002:a05:622a:281:: with SMTP id z1mr4724502qtw.477.1642098737412;
        Thu, 13 Jan 2022 10:32:17 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id y16sm2043111qki.41.2022.01.13.10.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 10:32:17 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Don't run hackbench by default on low memory systems
Date:   Thu, 13 Jan 2022 13:31:56 -0500
Message-Id: <20220113183156.165953-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

commit cb8263770e4f5834a43db6be8ffb55ffd7f876c9
Changed rteval to allow running on low memory systems by default because
on some machines, such as certain Arm boards, it isn't a problem.

However, on our automated testing systems it is causing problems.

This patch disables running hackbench by default on a low memory system.
In order to allow people to run on a lowmem system where this isn't a
problem, this patch also creates the option
--hackbench-runlowmem=True|False

A user who wants hackbench to run in rteval on a low memory system, only
needs to specify

--hackbench-runlowmem=True

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/loads/hackbench.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
index 21a803b8a3cd..ddd1378bac75 100644
--- a/rteval/modules/loads/hackbench.py
+++ b/rteval/modules/loads/hackbench.py
@@ -39,6 +39,7 @@ from rteval.systopology import SysTopology
 
 class Hackbench(CommandLineLoad):
     def __init__(self, config, logger):
+        self.__cfg = config
         CommandLineLoad.__init__(self, "hackbench", config, logger)
 
     def _WorkloadSetup(self):
@@ -56,7 +57,11 @@ class Hackbench(CommandLineLoad):
 
         ratio = float(mem) / float(self.num_cpus)
         if ratio < 0.75:
-            self._log(Log.WARN, "Low memory system (%f GB/core)!" % ratio)
+            if self.__cfg.runlowmem:
+                self._log(Log.WARN, "Low memory system (%f GB/core)!" % ratio)
+            else:
+                self._log(Log.WARN, "Low memory system (%f GB/core)! Not running hackbench" % ratio)
+                self._donotrun = True
 
         sysTop = SysTopology()
         # get the number of nodes
@@ -198,6 +203,9 @@ def ModuleParameters():
     return {"jobspercore": {"descr": "Number of working threads per CPU core",
                             "default": 5,
                             "metavar": "NUM"},
+            "runlowmem": {"descr": "Run hackbench on machines where low memory is detected",
+                            "default": False,
+                            "metavar": "True|False"}
             }
 
 
-- 
2.31.1

