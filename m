Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3220C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Sep 2021 18:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C6561038
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Sep 2021 18:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242809AbhIWSzD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Sep 2021 14:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242714AbhIWSzD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Sep 2021 14:55:03 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C94C061574
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2021 11:53:31 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id i132so25355713qke.1
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2021 11:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eSfY9tyCvA1diFxtvnN6igHK1tRaPBpA5Bj6ZxKjZyw=;
        b=o4p1vO0z6LI69QeH2CNIM/Pqt5RpyvyZBXTN7QKvxuO6Vgov7JCsP2nHx553KOHIND
         z6UdD9zJOaj0pWTh+LdMA0kPCjumZbRmlBX4gOYFzf+j0cmDlOubv/gO8G5X4qiwhzeB
         x/BKMJmMkpat3ZfRKuRDXFhDidsP1MsxXbrJU1HPxVypGrH4W5jBpgu51VxsnwR5RwE9
         4udn2J56b+BxZmxH+/tu2/f6O/t3hilg90wGHDj0GxdTCuMfdzRYUN/P+mPgxBP1XeRK
         WqbD+B0q8vQP5HCI0OnIJ79R1CKBB6Y7O2QRN9/2HeDARSIOtfzxLjK476rwd3onzP/u
         UwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eSfY9tyCvA1diFxtvnN6igHK1tRaPBpA5Bj6ZxKjZyw=;
        b=N6owrMGmfDRtkmlZq+R3kj/Y4gzrOI/CG71qG6V1HVEPKn6rbuXrllZD2myOrkaGyT
         wbJ0od3JTo/YBdnQK0vR/GpgTSFnSx7bYgKp4HDqFs5dvazl6N14sCfj2gy2R1sXMIPl
         xujV+gShwv5cx8dJqcVMrIxWgPcPkp4WpzvnMvqzgt0aH1YB8Ijs+/FwZRmm9JPMSv7U
         oIAnlnf9B9Q40w1v3wq9DdfNNd5fU/zNe1bhc+eWOeRTpyQ2HCgNB6hEWguhw3Bi9MWC
         esRzvwpUr6OVmgM8aJ5GqrdWgDE0i1gGcB6Hy6qszOHFDVP5LGZUtshnBmXuGxdfOP5b
         4deQ==
X-Gm-Message-State: AOAM5335/6oG0yYPDdt8mvFkfhnIa9BtrRvzm9AmmFB2c0CdneaVAack
        JImxnrLJs8HrM/eIqw5IoFZUuvjWn+o=
X-Google-Smtp-Source: ABdhPJx7yg6UvjhtxSjXMfKUKikcNyZklKH1u/6YudnUramnHYgK/TQ5d2thd1zHsMOoqjuqjEWPpg==
X-Received: by 2002:a37:681:: with SMTP id 123mr6338608qkg.508.1632423210427;
        Thu, 23 Sep 2021 11:53:30 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-06-184-147-140-75.dsl.bell.ca. [184.147.140.75])
        by smtp.gmail.com with ESMTPSA id az6sm4672089qkb.70.2021.09.23.11.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 11:53:30 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] rteval: Make donotrun work correctly in load modules
Date:   Thu, 23 Sep 2021 14:53:18 -0400
Message-Id: <20210923185319.1216575-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923185319.1216575-1-jkacur@redhat.com>
References: <20210923185319.1216575-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

hackbench and kcompile don't correctly adhere to the donotrun variable
which is inherited class rtevalModulePrototype. If the variable is set
after the modules are loaded, although the modules do not run, some
threading accounting still occurs which causes problems on shutdown of
rteval.

Fix in the methods in hackbench and kcompile where this is relevant, by
checking the variable before the method runs.

While we are at it fix a few other things
- change len(threading.enumerate()) to threading.active_count()
- Fix a spelling typo

This patch is in preparation for a patch to allow stress-ng to run as a
load module without running other modules.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/__init__.py                | 4 ++--
 rteval/modules/loads/__init__.py  | 2 +-
 rteval/modules/loads/hackbench.py | 3 +++
 rteval/modules/loads/kcompile.py  | 9 +++++++++
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/rteval/__init__.py b/rteval/__init__.py
index 5faed23bc927..22af8e85d5aa 100644
--- a/rteval/__init__.py
+++ b/rteval/__init__.py
@@ -208,7 +208,7 @@ class RtEval(rtevalReport):
             report_interval = int(self.__rtevcfg.report_interval)
             if with_loads:
                 self._loadmods.Unleash()
-                nthreads = len(threading.enumerate())
+                nthreads = threading.active_count()
             else:
                 nthreads = None
             self.__logger.log(Log.INFO, "Waiting 30 seconds to let load modules settle down")
@@ -233,7 +233,7 @@ class RtEval(rtevalReport):
                                       "Measurement threads did not use the full time slot. Doing a controlled stop.")
 
                 if with_loads:
-                    if len(threading.enumerate()) < nthreads:
+                    if threading.active_count() < nthreads:
                         raise RuntimeError("load thread died!")
 
                 if not load_avg_checked:
diff --git a/rteval/modules/loads/__init__.py b/rteval/modules/loads/__init__.py
index 9a942f454536..2c2105efa964 100644
--- a/rteval/modules/loads/__init__.py
+++ b/rteval/modules/loads/__init__.py
@@ -106,7 +106,7 @@ class LoadModules(RtEvalModules):
         "Loads and imports all the configured modules"
 
         for m in modcfg:
-            # hope to eventually have different kinds but module is only on
+            # hope to eventually have different kinds but module is only one
             # for now (jcw)
             if m[1].lower() == 'module':
                 self._LoadModule(m[0])
diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
index 2fb90c1946a5..21a803b8a3cd 100644
--- a/rteval/modules/loads/hackbench.py
+++ b/rteval/modules/loads/hackbench.py
@@ -42,6 +42,9 @@ class Hackbench(CommandLineLoad):
         CommandLineLoad.__init__(self, "hackbench", config, logger)
 
     def _WorkloadSetup(self):
+        if self._donotrun:
+            return
+
         'calculate arguments based on input parameters'
         (mem, units) = self.memsize
         if units == 'KB':
diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 8d08a3d44302..ec85b75f38b5 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -158,6 +158,9 @@ class Kcompile(CommandLineLoad):
                 "error removing builddir (%s) (ret=%d)" % (self.builddir, ret))
 
     def _WorkloadSetup(self):
+        if self._donotrun:
+            return
+
         # find our source tarball
         if 'tarball' in self._cfg:
             tarfile = os.path.join(self.srcdir, self._cfg.tarfile)
@@ -219,6 +222,9 @@ class Kcompile(CommandLineLoad):
 
 
     def _WorkloadBuild(self):
+        if self._donotrun:
+            return
+
         null = os.open("/dev/null", os.O_RDWR)
         if self._logging:
             out = self.open_logfile("kcompile-build.stdout")
@@ -293,6 +299,9 @@ class Kcompile(CommandLineLoad):
 
 
     def _WorkloadCleanup(self):
+        if self._donotrun:
+            return
+
         self._log(Log.DEBUG, "out of stopevent loop")
         for n in self.buildjobs:
             if self.buildjobs[n].jobid.poll() is None:
-- 
2.31.1

