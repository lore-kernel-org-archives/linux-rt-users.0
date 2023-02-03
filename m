Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605ABC61DA4
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Feb 2023 21:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjBCVQA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Feb 2023 16:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjBCVPs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Feb 2023 16:15:48 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC05A702C
        for <linux-rt-users@vger.kernel.org>; Fri,  3 Feb 2023 13:15:36 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id m12so7046146qth.4
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Feb 2023 13:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=eLosuRYpUTaeFkEBYxygIhJoipDce+CSjeoPL1e0mss=;
        b=C6K2oYlj7KJYCgTiljFiciHUzR9wISmsTIgiwJELx7JUNNolMq6ZWOe/hdKndFlOJU
         HgB1vY96JXoF7HfnZ+/+O1c81INw+Xf+NbRSKpl9CL50l9XDPIqtMzDkiaCLs8MKXbAp
         fojO2FUgeTFzC9JLiVnewxmma+BhgmU4PTLb9s+MHuRMFDOG2p9kutIFXWsvpC5em61J
         nK+uBPydhHsRGuAW5k2b6WefmVzLtDOma6K6bjtWsU6MTdhMd0asFE0jRamv6LOQIqVy
         bLPIoan44K9CGX6upxYxEKhLhFSN1FDJhR3jCG9DSqGTAO04EbGr90ljmSjULDRqmp4l
         Qafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLosuRYpUTaeFkEBYxygIhJoipDce+CSjeoPL1e0mss=;
        b=TlYWb2QL9AghYBB6J/kyjZRdOttmAdCvDZtsYotW8wIv8sTElhXnjHKI/m7hwcQ/O2
         zhr38X/4TVCA+C+jPjUK/yAuIilDNdIRn+RW1sfcSpQpvbUrsjPdivTLbGzh7+hmiiB4
         n8eD9uEdzcVI/kXXAkTE0ZX8Zm0hRIv/2yCqjj2RaZyn/gNMxrcwu/HoVZchbJzvPZCz
         Yc0TfJpVlTrzMmelWPLM3lM3zK46740hiVVC0gGxrpJ1FaJeXd1++qF8V7f5HNrk1zQ0
         W7Sf6W4pYOjyn3qpElUcIoECy5CXuwnGaLDa7K80UQRC0LXnf+/EX5Z9pFqWuUg+4htb
         SnLA==
X-Gm-Message-State: AO0yUKXC+ZANuTmRGgIO9tfcjYmEct6LEnONvRAzG74R2ajFke7bcx7V
        /MjXc5Bvz3RVLTTyN10I4ytRMcjvzW4=
X-Google-Smtp-Source: AK7set9ll57rzSON65tml/V0ozFuk/w953xR47H6uZhg86NHvcpQrl01EyFA3BBeMufCffKTqpuDug==
X-Received: by 2002:ac8:4e90:0:b0:3b6:9c63:5ca1 with SMTP id 16-20020ac84e90000000b003b69c635ca1mr23047284qtp.43.1675458934897;
        Fri, 03 Feb 2023 13:15:34 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id br15-20020a05620a460f00b00706bc44fda8sm2531004qkb.79.2023.02.03.13.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:15:33 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/8] rteval: rteval/__init__.py: Convert regular strings to f-strings
Date:   Fri,  3 Feb 2023 16:15:20 -0500
Message-Id: <20230203211527.71181-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Convert regular strings to f-strings in __init__.py

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/__init__.py | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/rteval/__init__.py b/rteval/__init__.py
index 22af8e85d5aa..d8127425febe 100644
--- a/rteval/__init__.py
+++ b/rteval/__init__.py
@@ -59,7 +59,7 @@ def sig_handler(signum, frame):
         stopsig_received = True
         print("*** stop signal received - stopping rteval run ***")
     else:
-        raise RuntimeError("SIGNAL received! (%d)" % signum)
+        raise RuntimeError(f"SIGNAL received! ({signum})")
 
 class RtEval(rtevalReport):
     def __init__(self, config, loadmods, measuremods, logger):
@@ -96,10 +96,10 @@ class RtEval(rtevalReport):
             self.__mailer = None
 
         if not os.path.exists(self.__rtevcfg.xslt_report):
-            raise RuntimeError("can't find XSL template (%s)!" % self.__rtevcfg.xslt_report)
+            raise RuntimeError(f"can't find XSL template ({self.__rtevcfg.xslt_report})!")
 
         # Add rteval directory into module search path
-        sys.path.insert(0, '%s/rteval' % sysconfig.get_python_lib())
+        sys.path.insert(0, f'{sysconfig.get_python_lib()}/rteval')
 
         # Initialise the report module
         rtevalReport.__init__(self, self.__version,
@@ -110,8 +110,7 @@ class RtEval(rtevalReport):
             self.__xmlrpc = rtevalXMLRPC(self.__rtevcfg.xmlrpc, self.__logger, self.__mailer)
             if not self.__xmlrpc.Ping():
                 if not self.__rtevcfg.xmlrpc_noabort:
-                    print("ERROR: Could not reach XML-RPC server '%s'.  Aborting." % \
-                        self.__rtevcfg.xmlrpc)
+                    print(f"ERROR: Could not reach XML-RPC server '{self.__rtevcfg.xmlrpc}'.  Aborting.")
                     sys.exit(2)
                 else:
                     print("WARNING: Could not ping the XML-RPC server.  Will continue anyway.")
@@ -174,8 +173,7 @@ class RtEval(rtevalReport):
 
         measure_start = None
         (with_loads, run_parallel) = measure_profile.GetProfile()
-        self.__logger.log(Log.INFO, "Using measurement profile [loads: %s  parallel: %s]" % (
-            with_loads, run_parallel))
+        self.__logger.log(Log.INFO, f"Using measurement profile [loads: {with_loads}  parallel: {run_parallel}]")
         try:
             nthreads = 0
 
@@ -183,23 +181,23 @@ class RtEval(rtevalReport):
             if with_loads:
                 self._loadmods.Start()
 
-            print("rteval run on %s started at %s" % (os.uname()[2], time.asctime()))
+            print(f"rteval run on {os.uname()[2]} started at {time.asctime()}")
             onlinecpus = self._sysinfo.cpu_getCores(True)
             cpulist = self._loadmods._cfg.GetSection("loads").cpulist
             if cpulist:
-                print("started %d loads on cores %s" % (self._loadmods.ModulesLoaded(), cpulist), end=' ')
+                print(f"started {self._loadmods.ModulesLoaded()} loads on cores {cpulist}", end=' ')
             else:
-                print("started %d loads on %d cores" % (self._loadmods.ModulesLoaded(), onlinecpus), end=' ')
+                print(f"started {self._loadmods.ModulesLoaded()} loads on {onlinecpus} cores", end=' ')
             if self._sysinfo.mem_get_numa_nodes() > 1:
-                print(" with %d numa nodes" % self._sysinfo.mem_get_numa_nodes())
+                print(f" with {self._sysinfo.mem_get_numa_nodes()} numa nodes")
             else:
                 print("")
             cpulist = self._measuremods._MeasurementModules__cfg.GetSection("measurement").cpulist
             if cpulist:
-                print("started measurement threads on cores %s" % cpulist)
+                print(f"started measurement threads on cores {cpulist}")
             else:
-                print("started measurement threads on %d cores" % onlinecpus)
-            print("Run duration: %s seconds" % str(self.__rtevcfg.duration))
+                print(f"started measurement threads on {onlinecpus} cores")
+            print(f"Run duration: {str(self.__rtevcfg.duration)} seconds")
 
             # start the cyclictest thread
             measure_profile.Start()
@@ -219,7 +217,7 @@ class RtEval(rtevalReport):
             # wait for time to expire or thread to die
             signal.signal(signal.SIGINT, sig_handler)
             signal.signal(signal.SIGTERM, sig_handler)
-            self.__logger.log(Log.INFO, "waiting for duration (%s)" % str(self.__rtevcfg.duration))
+            self.__logger.log(Log.INFO, f"waiting for duration ({str(self.__rtevcfg.duration)})")
             stoptime = (time.time() + float(self.__rtevcfg.duration))
             currtime = time.time()
             rpttime = currtime + report_interval
@@ -246,7 +244,7 @@ class RtEval(rtevalReport):
                     left_to_run = stoptime - currtime
                     self.__show_remaining_time(left_to_run)
                     rpttime = currtime + report_interval
-                    print("load average: %.2f" % self._loadmods.GetLoadAvg())
+                    print(f"load average: {self._loadmods.GetLoadAvg():.2f}")
                 currtime = time.time()
 
             self.__logger.log(Log.DEBUG, "out of measurement loop")
@@ -265,7 +263,7 @@ class RtEval(rtevalReport):
             if with_loads:
                 self._loadmods.Stop()
 
-        print("stopping run at %s" % time.asctime())
+        print(f"stopping run at {time.asctime()}")
 
         # wait for measurement modules to finish calculating stats
         measure_profile.WaitForCompletion()
-- 
2.39.0

