Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53B4C32772
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Aug 2022 19:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiHWT4B (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Aug 2022 15:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbiHWTzm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Aug 2022 15:55:42 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D3180518
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Aug 2022 12:03:44 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id i7so11019299qka.13
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Aug 2022 12:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=kunqeaQZ2D9hWYIQLgeWxtN7Etq1eJH0l5JSlRIRIs0=;
        b=k6Iqdi3m4GxxftNBlEa00/jqvo49r7xpejzsCaakOOWINKSclIUXtDqh+HQbDu5Fxa
         4Uwk7NO9yBJu0nFvw5Cd0/oPYiypMSqlymjZylehEnSnCpsCMFObkpVU2141k/Txng3G
         IYEgdpaxWrng9EKa/9rmdULuKtKEHNPX6Y/lEUm40fSjqcGQ0w9G/tzwLsU8bDfWKWmE
         QwetmzS6w+8Aoa2J2RYfAJZWcSgt7iZHIA3foM4jlYX6EFTQukNDV3nllJncYoLeEkZT
         YmAu5RaadlSQEsQdZ+3+o0iTgNF1TrFr5VcKAWiB4UGQWrHi3YrirqLhdjROeotGPd+F
         CLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=kunqeaQZ2D9hWYIQLgeWxtN7Etq1eJH0l5JSlRIRIs0=;
        b=ggprOanBz0yx3Rn4vrgecrD02HFjcIfDFut6vhucu+YsMw+taMiP1sb4VBxrOolPjy
         HPYma5jLKKWWxsY54aEm6G5NVCMPGMsAPaHbbeqfaKo5bOk5RuZWaN/0MZYo4CAL8RbW
         i4qjRNFRWp77ElV2q5kg8O8Ziqv05+PTaAUy9dcdN04fpzL2zRx5SBqHYwdueoFlDhYU
         GtNLCuEFn7AQeQ4L9qgrvFoe5wmDAP7L+j4fhF8Y8fi5oU6e6+/t3zdydHbj9X8gBOfy
         qAJbx8Mf2wqiIiZcBNKMK6BZiRIIaaCcy+H5l6O6QCCEA+2+iZPXG0DxJ6HHvUeo8EKC
         45ug==
X-Gm-Message-State: ACgBeo1UTuCFtfMETA2YkM9rpetl2zLCVLtxTSQPJ2rTg36bB4y6KvkN
        rxgbku1gEZF3yehDSIIyLIIP1+xt6BU=
X-Google-Smtp-Source: AA6agR7SbQ1X06fKMtkxUm/Dts9lmDMYGx4zr/b1KWZycKeEshghGAnRoUpXz+53v8y+FisBEakUJw==
X-Received: by 2002:a05:620a:1111:b0:6bb:604e:9d3d with SMTP id o17-20020a05620a111100b006bb604e9d3dmr17134020qkk.61.1661281422937;
        Tue, 23 Aug 2022 12:03:42 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-08-184-147-142-147.dsl.bell.ca. [184.147.142.147])
        by smtp.gmail.com with ESMTPSA id d22-20020ac86696000000b00342e86b3bdasm11158155qtp.12.2022.08.23.12.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 12:03:42 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Fix "DMI WARNING" when not running as root
Date:   Tue, 23 Aug 2022 15:03:29 -0400
Message-Id: <20220823190329.61326-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

In some cases it is not necessary to run as root, for example when
running -Z (--summarize) to summarize an existing report.

In such cases we do not want to see the message:
** DMI WARNING ** Failed to open memory buffer (/dev/mem): Permission denied

The fix here surpresses that message.

In addition:
- the unused "config" option to DMIinfo.__init__ is removed
- A few strings are converted to f-strings
- "with" is used to open the xsltfile

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/sysinfo/__init__.py |  6 ++---
 rteval/sysinfo/dmi.py      | 45 +++++++++++++++++++-------------------
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/rteval/sysinfo/__init__.py b/rteval/sysinfo/__init__.py
index 0436ebb350d9..a4359382f006 100644
--- a/rteval/sysinfo/__init__.py
+++ b/rteval/sysinfo/__init__.py
@@ -42,7 +42,7 @@ class SystemInfo(KernelInfo, SystemServices, dmi.DMIinfo, CPUtopology,
         self.__logger = logger
         KernelInfo.__init__(self, logger=logger)
         SystemServices.__init__(self, logger=logger)
-        dmi.DMIinfo.__init__(self, config, logger=logger)
+        dmi.DMIinfo.__init__(self, logger=logger)
         CPUtopology.__init__(self)
         OSInfo.__init__(self, logger=logger)
         cmdlineInfo.__init__(self, logger=logger)
@@ -80,8 +80,8 @@ if __name__ == "__main__":
     cfg.installdir = "."
     si = SystemInfo(cfg, logger=l)
 
-    print("\tRunning on %s" % si.get_base_os())
-    print("\tNUMA nodes: %d" % si.mem_get_numa_nodes())
+    print(f"\tRunning on {si.get_base_os()}")
+    print(f"\tNUMA nodes: {si.mem_get_numa_nodes()}")
     print("\tMemory available: %03.2f %s\n" % si.mem_get_size())
 
     print("\tServices: ")
diff --git a/rteval/sysinfo/dmi.py b/rteval/sysinfo/dmi.py
index 80cf3c723b36..5965c128c093 100644
--- a/rteval/sysinfo/dmi.py
+++ b/rteval/sysinfo/dmi.py
@@ -1,6 +1,4 @@
 #
-#   dmi.py - class to wrap DMI Table information
-#
 #   Copyright 2009 - 2013   Clark Williams <williams@redhat.com>
 #   Copyright 2009 - 2013   David Sommerseth <davids@redhat.com>
 #
@@ -24,6 +22,7 @@
 #   including keys needed to generate an equivalently functional executable
 #   are deemed to be part of the source code.
 #
+""" dmi.py class to wrap DMI Table Information """
 
 import sys
 import os
@@ -52,16 +51,18 @@ def ProcessWarnings():
     if warnings is None:
         return
 
+    ignore1  = '/dev/mem: Permission denied'
+    ignore2 = 'No SMBIOS nor DMI entry point found, sorry.'
+    ignore3 = 'Failed to open memory buffer (/dev/mem): Permission denied'
+    ignore = (ignore1, ignore2, ignore3)
     for warnline in warnings.split('\n'):
         # Ignore these warnings, as they are "valid" if not running as root
-        if warnline == '/dev/mem: Permission denied':
-            continue
-        if warnline == 'No SMBIOS nor DMI entry point found, sorry.':
+        if warnline in ignore:
             continue
 
         # All other warnings will be printed
         if len(warnline) > 0:
-            print("** DMI WARNING ** %s" % warnline)
+            print(f"** DMI WARNING ** {warnline}")
 
     dmidecode.clear_warnings()
 
@@ -69,8 +70,7 @@ def ProcessWarnings():
 class DMIinfo:
     '''class used to obtain DMI info via python-dmidecode'''
 
-    # TODO: Remove unnecessary config
-    def __init__(self, config, logger):
+    def __init__(self, logger):
         self.__version = '0.5'
 
         if not dmidecode_loaded:
@@ -83,22 +83,24 @@ class DMIinfo:
 
         self.__xsltparser = self.__load_xslt('rteval_dmi.xsl')
 
-    def __load_xslt(self, fname):
-        xsltfile = None
+    @staticmethod
+    def __load_xslt(fname):
+        xsltf = None
         if os.path.exists(fname):
-            xsltfile = open(fname, "r")
-        elif rtevalConfig.default_config_search([fname], os.path.isfile):
-            xsltfile = open(rtevalConfig.default_config_search([fname], os.path.isfile), "r")
-
-        if xsltfile:
-            xsltdoc = lxml.etree.parse(xsltfile)
-            ret = lxml.etree.XSLT(xsltdoc)
-            xsltfile.close()
+            xsltf = fname
+        else:
+            xsltf = rtevalConfig.default_config_search([fname], os.path.isfile)
+
+        if xsltf:
+            with open(xsltf, "r") as xsltfile:
+                xsltdoc = lxml.etree.parse(xsltfile)
+                ret = lxml.etree.XSLT(xsltdoc)
             return ret
 
         raise RuntimeError(f'Could not locate XSLT template for DMI data ({fname})')
 
     def MakeReport(self):
+        """ Add DMI information to final report """
         rep_n = libxml2.newNode("DMIinfo")
         rep_n.newProp("version", self.__version)
         if self.__fake:
@@ -113,7 +115,7 @@ class DMIinfo:
         return rep_n
 
 def unit_test(rootdir):
-    """ unit_test for dmi.py, looks a little crufty! """
+    """ unit_test for dmi.py """
 
     class UnittestConfigDummy:
         def __init__(self, rootdir):
@@ -132,15 +134,14 @@ def unit_test(rootdir):
 
         log = Log()
         log.SetLogVerbosity(Log.DEBUG|Log.INFO)
-        cfg = UnittestConfigDummy(rootdir)
-        d = DMIinfo(cfg, log)
+        d = DMIinfo(log)
         dx = d.MakeReport()
         x = libxml2.newDoc("1.0")
         x.setRootElement(dx)
         x.saveFormatFileEnc("-", "UTF-8", 1)
         return 0
     except Exception as e:
-        print("** EXCEPTION: %s" % str(e))
+        print(f"** EXCEPTION: {str(e)}")
         return 1
 
 if __name__ == '__main__':
-- 
2.37.2

