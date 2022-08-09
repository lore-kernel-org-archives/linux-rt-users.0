Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95342C3F6B0
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Aug 2022 21:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiHIVsM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Aug 2022 17:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiHIVsE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Aug 2022 17:48:04 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9646BD4B
        for <linux-rt-users@vger.kernel.org>; Tue,  9 Aug 2022 14:48:03 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id j11so9579440qvt.10
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Aug 2022 14:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=wax0Qh2i9cmRbR+qhApAzMKszwnqe1C+RijtB+ahDH0=;
        b=MjX6E+E39h5I8RMF2QSvc+S6u20+ycip+SeekciBvo64kgztgBh3ZQrnGi2HyxatnV
         STVj8rei60yjVl2VGNJZ6vhTgOgFJnD71TgyrNQMWdUAL5v3IRnk2opzFxBN9gMKHOJN
         QsWxJ9l9uClZlyEbLwztRx7re/ZKVJUaN3Rc8qWDfbhj9krpX1fIyxWoJ6gWkQIZJpdU
         d2mKfMx+uouxV6IRRztJaykxshoXdBRJ+t1d8wQf3Jw9ZI/RErX0myIXbFhD9AtqB2Iy
         cb9dYuoInZ5uUyRBNV2khqhyBneh5QRuy1evMyD+3ZXakEWCTIumcwy2Er+OPZEN6J+b
         Is6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=wax0Qh2i9cmRbR+qhApAzMKszwnqe1C+RijtB+ahDH0=;
        b=HGKkhd6SmIQeQ/pTAGEVrX9Cj5Rk/dlZWXWEvI4Gd5kmsKXEbzR5TN9IhOVVrlSUk9
         A1Hbh7LZAVNxuT6mhDhCfeUr4V8BAunEIHknbL2s8zjejrnsTZAAxKiWuPxTJxW5pO31
         RIXlHAJkn58SFMuA7SCMy6gQI4ZE9b6EItjkincKvghUlBO9KkAbxI8sd361S31XDEjY
         aRNz4zEUm5Ya+anNbJ5KZcT2b1B2L/sQf/bqSkC7Fx9yVpcPqlR/HlV50V2CtGr9huuD
         gR+HHbPEYC1Mu4jTJqkA9aAFDv054fgUPqjbGKwBAcPFmYwQbKZmbdDzvUAs6l/doDyv
         65Hg==
X-Gm-Message-State: ACgBeo2l6WWS4WvltdgZ3apIt4AMPs6Mmwp5BH3Rgy71uE6tJvP5+Qtz
        VhkHDHShMMXLjrbcI6Be6KbagTjRQuI=
X-Google-Smtp-Source: AA6agR6zKeEhv196j3CPIAeSEuArNJBPDROgZLLrzcOR8D795jxXq8Ed9c0AqdYfneVlw7YoZnSLRg==
X-Received: by 2002:a0c:df82:0:b0:474:97e5:4951 with SMTP id w2-20020a0cdf82000000b0047497e54951mr21633206qvl.96.1660081682097;
        Tue, 09 Aug 2022 14:48:02 -0700 (PDT)
Received: from fionn.redhat.com ([142.189.102.90])
        by smtp.gmail.com with ESMTPSA id w13-20020ac843cd000000b00342f844e30fsm4894859qtn.31.2022.08.09.14.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 14:48:01 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Manasi Godse <gmanasi13@gmail.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Allow user to enter compressed cpu-lists, fix reporting
Date:   Tue,  9 Aug 2022 17:47:30 -0400
Message-Id: <20220809214730.406975-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Allow user to enter compressed cpu-lists (short form),
that is 0-4 instead of 0,1,2,3,4

Fix reporting, make sure that early reports consider offline cpus
For example
If the user specifies

su -c './rteval-cmd   -d5s --loads-cpulist=2-4 --measurement-cpulist=0,9-11'

but cpu3 has been turned off, then we should see the following

started 3 loads on cores 2,4
started measurement threads on cores 0,9-11

and not
started 3 loads on cores 2-4

So, to summarize the changes here
1. Allow user to input compressed cpulists
2. Fix reporting using the shortened form of the cpulists as well
3. Adds the method online_cpulist(self, cpulist) to SysTopology that
returns the same list after removing offline cpus
4. converts one print to an f-string for --only-loads
5. Adds some more DEBUG messages

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd            | 37 +++++++++++++++++++++++++++----------
 rteval/systopology.py |  6 +++++-
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index 13fd5c6950b9..6a928362828f 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -49,10 +49,11 @@ from rteval import RtEval, rtevalConfig
 from rteval.modules.loads import LoadModules
 from rteval.modules.measurement import MeasurementModules
 from rteval.version import RTEVAL_VERSION
-from rteval.systopology import CpuList, SysTopology
+from rteval.systopology import CpuList, SysTopology, collapse_cpulist
 from rteval.modules.loads.kcompile import ModuleParameters
 
 compress_cpulist = CpuList.compress_cpulist
+expand_cpulist = CpuList.expand_cpulist
 
 def summarize(repfile, xslt):
     """ Summarize an already existing XML report """
@@ -199,6 +200,11 @@ def parse_options(cfg, parser, cmdargs):
 
     return cmd_args
 
+def remove_offline(cpulist):
+    """ return cpulist in collapsed compressed form with only online cpus """
+    tmplist = expand_cpulist(cpulist)
+    tmplist = SysTopology().online_cpulist(tmplist)
+    return collapse_cpulist(tmplist)
 
 
 if __name__ == '__main__':
@@ -322,17 +328,29 @@ if __name__ == '__main__':
             sys.exit(0)
 
 
-        # if we only specified one set of cpus (loads or measurement)
-        # default the other to the inverse of the specified list
         ldcfg = config.GetSection('loads')
         msrcfg = config.GetSection('measurement')
+        if ldcfg.cpulist and msrcfg.cpulist:
+            ldcfg.cpulist = remove_offline(ldcfg.cpulist)
+            msrcfg.cpulist = remove_offline(msrcfg.cpulist)
+        # if we only specified one set of cpus (loads or measurement)
+        # default the other to the inverse of the specified list
         if not ldcfg.cpulist and msrcfg.cpulist:
-            invlist = SysTopology().invert_cpulist(msrcfg.cpulist)
-            ldcfg.cpulist = compress_cpulist(invlist)
+            tmplist = expand_cpulist(msrcfg.cpulist)
+            tmplist = SysTopology().invert_cpulist(tmplist)
+            ldcfg.cpulist = compress_cpulist(tmplist)
+            msrcfg.cpulist = remove_offline(msrcfg.cpulist)
         if not msrcfg.cpulist and ldcfg.cpulist:
-            invlist = SysTopology().invert_cpulist(ldcfg.cpulist)
-            msrcfg.cpulist = compress_cpulist(invlist)
-
+            tmplist = expand_cpulist(ldcfg.cpulist)
+            tmplist = SysTopology().invert_cpulist(tmplist)
+            msrcfg.cpulist = compress_cpulist(tmplist)
+            ldcfg.cpulist = remove_offline(ldcfg.cpulist)
+
+        if ldcfg.cpulist:
+            logger.log(Log.DEBUG, f"loads cpulist: {ldcfg.cpulist}")
+        # if --onlyload is specified msrcfg.cpulist is unused
+        if msrcfg.cpulist and not rtevcfg.onlyload:
+            logger.log(Log.DEBUG, f"measurement cpulist: {msrcfg.cpulist}")
         logger.log(Log.DEBUG, f"workdir: {rtevcfg.workdir}")
 
         # if --summarize was specified then just parse the XML, print it and exit
@@ -374,8 +392,7 @@ if __name__ == '__main__':
             # No reports will be created.
             loadmods.Start()
             nthreads = loadmods.Unleash()
-            logger.log(Log.INFO, "Started %i load threads - will run for %f seconds" % (
-                nthreads, rtevcfg.duration))
+            logger.log(Log.INFO, f"Started {nthreads} load threads - will run for {rtevcfg.duration} seconds")
             logger.log(Log.INFO, "No measurements will be performed, due to the --onlyload option")
             time.sleep(rtevcfg.duration)
             loadmods.Stop()
diff --git a/rteval/systopology.py b/rteval/systopology.py
index ce8d02cf7318..26332c30bb0e 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -329,7 +329,11 @@ class SysTopology:
 
     def invert_cpulist(self, cpulist):
         """ return a list of online cpus not in cpulist """
-        return [c for c in self.online_cpus_str() if c not in cpulist]
+        return [c for c in self.online_cpus() if c not in cpulist]
+
+    def online_cpulist(self, cpulist):
+        """ return a list of online cpus in cpulist """
+        return [c for c in self.online_cpus() if c in cpulist]
 
 if __name__ == "__main__":
 
-- 
2.37.1

