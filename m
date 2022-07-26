Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92169CCA47E
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jul 2022 13:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238795AbiGZNgA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jul 2022 09:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiGZNf7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jul 2022 09:35:59 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D0C60C5
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 06:35:58 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id o2so3232027iof.8
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 06:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPo0GMNJQL5+9gR0ByVooqTrE5pNbtAkTZ6XMx9bVh0=;
        b=i7PDgxvogpiNC+2ecHMjjIb8I99O/g3DHmMr1zbTg89NhmR3rEIecxFgLoYEaPiVJ9
         +UNXNh3u617+v87atbFNDLEMz0P5ZWSUrHm0Uc3Ljoz+C2sg5RJFSBZxZoBdOnFG3kZv
         VOtGpq0/YCmaau+Ija9i1p4VOiHgeLBe/5DYlBvhyzxEmmYleM27pk2Q0zWocfcjXrKO
         7mLdP08HeEWokVCin/hKCHZIQNqvBC2udCdMqlZupCDPl1pd6u1+lB6Kt/shmpwmtR0m
         7sg21cUNnErDEWJxL69JDCxJWP5NN0YX3/4+EtmibXqx7uf/WF4h2wrcgTsCTPCVEi6I
         csVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JPo0GMNJQL5+9gR0ByVooqTrE5pNbtAkTZ6XMx9bVh0=;
        b=A0TCyujJ+ngfd0k92ym0HpFK4MAqhvIJYIVI5we97rC+eTGxJ+qbamdnLCRXFQ86bx
         Ix1ZZ5zJRZA3YzIrjySm0Qt1qrvObH7zpdIR9CPRVtDmHzGzz6YBkyFH+TQ8qMWkvsh7
         kqBsDqJOoMitCVqaa84ECoeDFFVjK745MLwVLHsMnlzuHmWYcVfxxgBJNwCkh7t5COAD
         Yc2G2BgMwGsMv5E7hc5wCwZjVcZzdYF7TynrgtUkCRqf1vUlU/mbBYTdNmN6NNrvwZ6T
         hOluDs0nbzCG39DTKp4KP3w41HLurUNfUAHYD4bL2mwlzT2tjCfRhSPBnPkKdblZPv9m
         X4dA==
X-Gm-Message-State: AJIora/yo0qN4YyUTS9Rfpmh8DlbuqsO2MXbwG70Qo7ZFK6MhIGFam0u
        H3mtMJfyDwawNRgYiXcH0O9iKpGR7hE=
X-Google-Smtp-Source: AGRyM1tvCRAQytm8QrvBirg1k8RTxS3Df+OLx5Hif7+OMVVy906u81peCNPyyAQWCegl+jm5Ls7qgQ==
X-Received: by 2002:a6b:ba44:0:b0:67b:cf5d:4deb with SMTP id k65-20020a6bba44000000b0067bcf5d4debmr5997140iof.183.1658842557593;
        Tue, 26 Jul 2022 06:35:57 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-180.dsl.bell.ca. [184.147.143.180])
        by smtp.gmail.com with ESMTPSA id e42-20020a02212a000000b00339ceeec5edsm6617760jaa.12.2022.07.26.06.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:35:57 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Manasi Godse <magodse@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/6] rteval: Make use of systopology instead of misc in rteval-cmd
Date:   Tue, 26 Jul 2022 09:35:31 -0400
Message-Id: <20220726133535.10824-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220726133535.10824-1-jkacur@redhat.com>
References: <20220726133535.10824-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- convert rteval-cmd to use methods / functions in systopology instead of misc.
- strings converted to f-strings

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index c1a68bd5133b..24ff5df76883 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -33,6 +33,7 @@
 #   including keys needed to generate an equivalently functional executable
 #   are deemed to be part of the source code.
 #
+""" Main module of the rteval program """
 
 import sys
 import os
@@ -48,9 +49,11 @@ from rteval import RtEval, rtevalConfig
 from rteval.modules.loads import LoadModules
 from rteval.modules.measurement import MeasurementModules
 from rteval.version import RTEVAL_VERSION
-from rteval.misc import invert_cpulist, compress_cpulist
+from rteval.systopology import CpuList, SysTopology
 from rteval.modules.loads.kcompile import ModuleParameters
 
+compress_cpulist = CpuList.compress_cpulist
+
 def summarize(repfile, xslt):
     """ Summarize an already existing XML report """
     isarchive = False
@@ -60,7 +63,7 @@ def summarize(repfile, xslt):
         try:
             t = tarfile.open(repfile)
         except:
-            print("Don't know how to summarize %s (tarfile open failed)" % repfile)
+            print(f"Don't know how to summarize {repfile} (tarfile open failed)")
             return
         element = None
         for f in t.getnames():
@@ -68,7 +71,7 @@ def summarize(repfile, xslt):
                 element = f
                 break
         if element is None:
-            print("No summary.xml found in tar archive %s" % repfile)
+            print(f"No summary.xml found in tar archive {repfile}")
             return
         tmp = tempfile.gettempdir()
         t.extract(element, path=tmp)
@@ -172,7 +175,7 @@ def parse_options(cfg, parser, cmdargs):
 
     (cmd_opts, cmd_args) = parser.parse_args(args=cmdargs)
     if cmd_opts.rteval___version:
-        print(("rteval version %s" % RTEVAL_VERSION))
+        print(f"rteval version {RTEVAL_VERSION}")
         sys.exit(0)
 
     if cmd_opts.rteval___duration:
@@ -320,11 +323,13 @@ if __name__ == '__main__':
         ldcfg = config.GetSection('loads')
         msrcfg = config.GetSection('measurement')
         if not ldcfg.cpulist and msrcfg.cpulist:
-            ldcfg.cpulist = compress_cpulist(invert_cpulist(msrcfg.cpulist))
+            invlist = SysTopology().invert_cpulist(msrcfg.cpulist)
+            ldcfg.cpulist = compress_cpulist(invlist)
         if not msrcfg.cpulist and ldcfg.cpulist:
-            msrcfg.cpulist = compress_cpulist(invert_cpulist(ldcfg.cpulist))
+            invlist = SysTopology().invert_cpulist(ldcfg.cpulist)
+            msrcfg.cpulist = compress_cpulist(invlist)
 
-        logger.log(Log.DEBUG, "workdir: %s" % rtevcfg.workdir)
+        logger.log(Log.DEBUG, f"workdir: {rtevcfg.workdir}")
 
         # if --summarize was specified then just parse the XML, print it and exit
         if rtevcfg.summarize or rtevcfg.rawhistogram:
@@ -343,22 +348,18 @@ if __name__ == '__main__':
             print("Must be root to run rteval!")
             sys.exit(-1)
 
-        logger.log(Log.DEBUG, '''rteval options:
-     workdir: %s
-     loaddir: %s
-     reportdir: %s
-     verbose: %s
-     debugging: %s
-     logging:  %s
-     duration: %f
-     sysreport: %s''' % (
-         rtevcfg.workdir, rtevcfg.srcdir,
-         rtevcfg.reportdir, rtevcfg.verbose,
-         rtevcfg.debugging, rtevcfg.logging,
-         rtevcfg.duration, rtevcfg.sysreport))
+        logger.log(Log.DEBUG, f'''rteval options:
+     workdir: {rtevcfg.workdir}
+     loaddir: {rtevcfg.srcdir}
+     reportdir: {rtevcfg.reportdir}
+     verbose: {rtevcfg.verbose}
+     debugging: {rtevcfg.debugging}
+     logging:  {rtevcfg.logging}
+     duration: {rtevcfg.duration}
+     sysreport: {rtevcfg.sysreport}''')
 
         if not os.path.isdir(rtevcfg.workdir):
-            raise RuntimeError("work directory %s does not exist" % rtevcfg.workdir)
+            raise RuntimeError(f"work directory {rtevcfg.workdir} does not exist")
 
 
         rteval = RtEval(config, loadmods, measuremods, logger)
@@ -378,7 +379,7 @@ if __name__ == '__main__':
         else:
             # ... otherwise, run the full measurement suite with loads
             ec = rteval.Measure()
-            logger.log(Log.DEBUG, "exiting with exit code: %d" % ec)
+            logger.log(Log.DEBUG, f"exiting with exit code: {ec}")
 
         sys.exit(ec)
     except KeyboardInterrupt:
-- 
2.37.1

