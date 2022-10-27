Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13509FA3740
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Oct 2022 15:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbiJ0PWw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Oct 2022 11:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbiJ0PWd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Oct 2022 11:22:33 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB76EDEE3
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Oct 2022 08:22:32 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id e15so1812630iof.2
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Oct 2022 08:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rBA/GU+4L4A3h5kAK0ky226YrLRBMcekezAPQPWq4Kc=;
        b=g6Th7uR4iV7QVtBUg6EKIvq8ldO/z8nircRH6PGMvhjOnLn+QYp+2DTqbLASIZRPzG
         AiOTCfHjP1LHttbDfG6mg6M8aDIR92X/idIXdt46yR5rw+PGa8Bc9hVDigXddHfedl2l
         UOiWwDsvoJAZidSpFquGHP2WQ84YDh5RWDjy8Hy/zRaqCE/Wzs4klryHh/KHVsN9TOj2
         SRfAgFcZ4LNM+tfiRIsuLOfSp0boedlq7SK4iAWLUVSYQlXqamOZUCA1aA7bVmK/T2Oj
         MnIWVUPnaI2rttV8L6m6Kx2iO/nFpSp+7SIqC2YgJRdiqmQAN4oudVWnC3iVpF3pAPkW
         ictw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBA/GU+4L4A3h5kAK0ky226YrLRBMcekezAPQPWq4Kc=;
        b=KT4L9Esq2E5+1bd/+vYwK/+5nQ+15O5DAg99Ea/jxdgLayqqYe0NCfwvClZQ4WFmfQ
         WzajaQrdN1ypbWODbk9H2RuB46kdrvpr0EhWRjxbih8gi6w640aQMVYhO0emZL2iapLL
         IqMgw78VngDWN8LtZGFTh4GgzrOuk7Uw0WpAB6Z63Q5pgojAjRR/sl63cpVk4NcXp3cA
         w/t0pyChRMxDNwSi5fBYCeXsaIdOmiVA6GvjE0OxvTZIB9RGVxh4rOfTxrGBs3fSaHDy
         +hKdrB8TCeXTOdOIY6E8Oo7BwRDrZBMZ1tdPoEGob63P7g10UgCl3DgtQG0XYa6Bg6ow
         h8Qg==
X-Gm-Message-State: ACrzQf18kj+NRZyZpuzM+zoWUsJPAPVkkWoe4MATi/S36UW+OoduEkGX
        RRw9pP7cTAdjfcHhrooPLpG/ZXKS9PY=
X-Google-Smtp-Source: AMsMyM7QNbGDSVwILNjqtkBv0F9h/l+G5aHx0twgjLf2cef3hs6JZxTLpwZ5H0MnFo1L782PogkC3Q==
X-Received: by 2002:a05:6638:300e:b0:35a:ab7a:4509 with SMTP id r14-20020a056638300e00b0035aab7a4509mr32553537jak.82.1666884151158;
        Thu, 27 Oct 2022 08:22:31 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-08-184-147-142-10.dsl.bell.ca. [184.147.142.10])
        by smtp.gmail.com with ESMTPSA id o15-20020a056602124f00b006bca2c3cbe9sm689212iou.2.2022.10.27.08.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 08:22:29 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Don't attempt to get DMIinfo if there are dmi warnings
Date:   Thu, 27 Oct 2022 11:22:14 -0400
Message-Id: <20221027152214.15238-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If the python module dmidecode is available, but produces warnings,
you can get a traceback. This happens on some arm boxes,
as shown in the traceback below.

Fix this by treating any warnings that are not listed in the
ignorable warnings as if dmi info is not available.

Also add logging to dmi.ProcessWarnings()

./rteval-cmd -d10s
** DMI WARNING ** /sys/firmware/efi/systab: SMBIOS entry point missing
got system topology: 1 node system (4 cores per node)
rteval run on 5.19.16-200.fc36.aarch64 started at Fri Oct 21 16:11:51 2022
started 3 loads on 4 cores
started measurement threads on 4 cores
Run duration: 10.0 seconds
stopping run at Fri Oct 21 16:13:26 2022
Traceback (most recent call last):
  File "/root/src/rteval/./rteval-cmd", line 402, in <module>
    ec = rteval.Measure()
  File "/root/src/rteval/rteval/__init__.py", line 286, in Measure
    self._report(measure_start, self.__rtevcfg.xslt_report)
  File "/root/src/rteval/rteval/rtevalReport.py", line 76, in _report
    self.__xmlreport.AppendXMLnodes(self._sysinfo.MakeReport())
  File "/root/src/rteval/rteval/sysinfo/__init__.py", line 69, in MakeReport
    report_n.addChild(dmi.DMIinfo.MakeReport(self))
  File "/root/src/rteval/rteval/sysinfo/dmi.py", line 111, in MakeReport
    dmiqry = xmlout.convert_libxml2_to_lxml_doc(self.__dmixml.QuerySection('all'))
  File "/usr/lib64/python3.10/site-packages/dmidecode.py", line 64, in QuerySection
    ret = libxml2.xmlDoc( _obj = xmlapi(query_type='s',
RuntimeError: [src/dmidecodemodule.c:331] Error decoding DMI data

** COLLECTED WARNINGS **
/sys/firmware/efi/systab: SMBIOS entry point missing
** END OF WARNINGS **

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd                 |  4 ++--
 rteval/sysinfo/__init__.py |  2 +-
 rteval/sysinfo/dmi.py      | 34 +++++++++++++++++++++-------------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index 6a928362828f..1e6a7fc86baa 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -210,8 +210,6 @@ def remove_offline(cpulist):
 if __name__ == '__main__':
     from rteval.sysinfo import dmi
 
-    dmi.ProcessWarnings()
-
     # set LD_BIND_NOW to resolve shared library symbols
     # note: any string will do, nothing significant about 'rteval'
 
@@ -261,6 +259,8 @@ if __name__ == '__main__':
                 | (rtevcfg.debugging and Log.DEBUG)
         logger.SetLogVerbosity(loglev)
 
+        dmi.ProcessWarnings(logger=logger)
+
         # Load modules
         loadmods = LoadModules(config, logger=logger)
         measuremods = MeasurementModules(config, logger=logger)
diff --git a/rteval/sysinfo/__init__.py b/rteval/sysinfo/__init__.py
index bb1d00810856..5767e5b7f6fe 100644
--- a/rteval/sysinfo/__init__.py
+++ b/rteval/sysinfo/__init__.py
@@ -49,7 +49,7 @@ class SystemInfo(KernelInfo, SystemServices, dmi.DMIinfo, CPUtopology,
         NetworkInfo.__init__(self, logger=logger)
 
         # Parse initial DMI decoding errors
-        dmi.ProcessWarnings()
+        dmi.ProcessWarnings(logger=logger)
 
         # Parse CPU info
         CPUtopology._parse(self)
diff --git a/rteval/sysinfo/dmi.py b/rteval/sysinfo/dmi.py
index 5965c128c093..83f347623b58 100644
--- a/rteval/sysinfo/dmi.py
+++ b/rteval/sysinfo/dmi.py
@@ -1,6 +1,7 @@
 #
 #   Copyright 2009 - 2013   Clark Williams <williams@redhat.com>
 #   Copyright 2009 - 2013   David Sommerseth <davids@redhat.com>
+#   Copyright 2022          John Kacur <jkacur@redhat.com>
 #
 #   This program is free software; you can redistribute it and/or modify
 #   it under the terms of the GNU General Public License as published by
@@ -34,14 +35,19 @@ from rteval import rtevalConfig
 
 try:
     import dmidecode
-    dmidecode_loaded = True
+    dmidecode_avail = True
 except ModuleNotFoundError:
-    dmidecode_loaded = False
+    dmidecode_avail = False
 
-def ProcessWarnings():
+def set_dmidecode_avail(val):
+    """ Used to set global variable dmidecode_avail from a function """
+    global dmidecode_avail
+    dmidecode_avail = val
+
+def ProcessWarnings(logger=None):
     """ Process Warnings from dmidecode """
 
-    if not dmidecode_loaded:
+    if not dmidecode_avail:
         return
 
     if not hasattr(dmidecode, 'get_warnings'):
@@ -62,7 +68,8 @@ def ProcessWarnings():
 
         # All other warnings will be printed
         if len(warnline) > 0:
-            print(f"** DMI WARNING ** {warnline}")
+            logger.log(Log.DEBUG, f"** DMI WARNING ** {warnline}")
+            set_dmidecode_avail(False)
 
     dmidecode.clear_warnings()
 
@@ -70,11 +77,11 @@ def ProcessWarnings():
 class DMIinfo:
     '''class used to obtain DMI info via python-dmidecode'''
 
-    def __init__(self, logger):
-        self.__version = '0.5'
+    def __init__(self, logger=None):
+        self.__version = '0.6'
 
-        if not dmidecode_loaded:
-            logger.log(Log.DEBUG|Log.WARN, "No dmidecode module found, ignoring DMI tables")
+        if not dmidecode_avail:
+            logger.log(Log.DEBUG, "DMI info unavailable, ignoring DMI tables")
             self.__fake = True
             return
 
@@ -127,14 +134,15 @@ def unit_test(rootdir):
                 self.__dict__[k] = self.config[k]
 
     try:
-        ProcessWarnings()
+        log = Log()
+        log.SetLogVerbosity(Log.DEBUG|Log.INFO)
+
+        ProcessWarnings(logger=log)
         if os.getuid() != 0:
             print("** ERROR **  Must be root to run this unit_test()")
             return 1
 
-        log = Log()
-        log.SetLogVerbosity(Log.DEBUG|Log.INFO)
-        d = DMIinfo(log)
+        d = DMIinfo(logger=log)
         dx = d.MakeReport()
         x = libxml2.newDoc("1.0")
         x.setRootElement(dx)
-- 
2.37.3

