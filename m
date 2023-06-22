Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BE4EB64DC
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Jun 2023 16:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjFVQn5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Jun 2023 12:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjFVQny (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Jun 2023 12:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D3D1FFC
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Jun 2023 09:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687452180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A33Ej04FGAu0etSd+hryTpTGHnVi9qHtpwd7NvG9luI=;
        b=gz01464GOd02M0fwn4Qj6HMlY+Ax0arIlk08W8qcKhm7zkqz2U5BN3yX6XAV1uq/cgXvtW
        lgnhXQi9XHpjqSYFCdYF7El5jgswM3ApYacwaLdPvf9TxCQiRjHnuMdkv6/cNWOag74iO6
        UZ4DCDnQ7do24vKAbuCaYP9ZoE6MPoA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-nAJEFVYeO2WjOEPwFfkwlg-1; Thu, 22 Jun 2023 12:42:57 -0400
X-MC-Unique: nAJEFVYeO2WjOEPwFfkwlg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17C8B3C1411E
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Jun 2023 16:42:54 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.9.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A0B22017DC6;
        Thu, 22 Jun 2023 16:42:53 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     kcarcia@redhat.com, Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH] rteval: Changed files to use argparse library instead of optparse
Date:   Thu, 22 Jun 2023 12:42:21 -0400
Message-Id: <20230622164221.248271-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Replaced optparse.OptionParser() with argparse.ArgumentParser() and optparse.add_options() with argparse.add_arguments().
Added/changed code to assign the cmd_opts and cmd_args variables in rteval-cmd correctly to get the -Z/--summarize and
-H/--raw-histogram working correctly.
Note: the rteval/server files haven't been tested since server is
disabled.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval-cmd                  | 88 ++++++++++++++++++++++---------------
 rteval/modules/__init__.py  | 12 +++--
 rteval/rtevalConfig.py      |  4 +-
 server/rteval_testserver.py | 11 ++---
 server/unittest.py          |  8 ++--
 5 files changed, 70 insertions(+), 53 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index cbba9cd2e451..96854e05f746 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -40,7 +40,7 @@ import os
 import time
 import re
 import shutil
-import optparse
+import argparse
 import tempfile
 import requests
 import lxml.etree
@@ -115,55 +115,55 @@ def parse_options(cfg, parser, cmdargs):
     # thus they are prefixed with 'rteval___'.
     # See rteval/rtevalConfig::UpdateFromOptionParser() method for more info
     #
-    parser.add_option("-d", "--duration", dest="rteval___duration",
-                      type="string", default=rtevcfg.duration, metavar="DURATION",
-                      help="specify length of test run (default: %default)")
-    parser.add_option("-v", "--verbose", dest="rteval___verbose",
+    parser.add_argument("-d", "--duration", dest="rteval___duration",
+                      type=str, default=rtevcfg.duration, metavar="DURATION",
+                      help=f"specify length of test run (default: {rtevcfg.duration})")
+    parser.add_argument("-v", "--verbose", dest="rteval___verbose",
                       action="store_true", default=rtevcfg.verbose,
-                      help="turn on verbose prints (default: %default)")
-    parser.add_option("-q", "--quiet", dest="rteval___quiet",
+                      help=f"turn on verbose prints (default: {rtevcfg.verbose})")
+    parser.add_argument("-q", "--quiet", dest="rteval___quiet",
                       action="store_true", default=rtevcfg.quiet,
-                      help="turn on quiet mode (default: %default)")
-    parser.add_option("-w", "--workdir", dest="rteval___workdir",
-                      type="string", default=rtevcfg.workdir, metavar="DIRECTORY",
-                      help="top directory for rteval data (default: %default)")
-    parser.add_option("-l", "--loaddir", dest="rteval___srcdir",
-                      type="string", default=rtevcfg.srcdir, metavar="DIRECTORY",
-                      help="directory for load source tarballs (default: %default)")
-    parser.add_option("-i", "--installdir", dest="rteval___installdir",
-                      type="string", default=rtevcfg.installdir, metavar="DIRECTORY",
-                      help="place to locate installed templates (default: %default)")
-    parser.add_option("-s", "--sysreport", dest="rteval___sysreport",
+                      help=f"turn on quiet mode (default: {rtevcfg.quiet})")
+    parser.add_argument("-w", "--workdir", dest="rteval___workdir",
+                      type=str, default=rtevcfg.workdir, metavar="DIRECTORY",
+                      help=f"top directory for rteval data (default: {rtevcfg.workdir})")
+    parser.add_argument("-l", "--loaddir", dest="rteval___srcdir",
+                      type=str, default=rtevcfg.srcdir, metavar="DIRECTORY",
+                      help=f"directory for load source tarballs (default: {rtevcfg.srcdir})")
+    parser.add_argument("-i", "--installdir", dest="rteval___installdir",
+                      type=str, default=rtevcfg.installdir, metavar="DIRECTORY",
+                      help=f"place to locate installed templates (default: {rtevcfg.installdir})")
+    parser.add_argument("-s", "--sysreport", dest="rteval___sysreport",
                       action="store_true", default=rtevcfg.sysreport,
-                      help='run sysreport to collect system data (default: %default)')
-    parser.add_option("-D", '--debug', dest='rteval___debugging',
+                      help=f'run sysreport to collect system data (default: {rtevcfg.sysreport})')
+    parser.add_argument("-D", '--debug', dest='rteval___debugging',
                       action='store_true', default=rtevcfg.debugging,
-                      help='turn on debug prints (default: %default)')
+                      help=f'turn on debug prints (default: {rtevcfg.debugging})')
     #parser.add_option("-X", '--xmlrpc-submit', dest='rteval___xmlrpc',
     #                  action='store', default=rtevcfg.xmlrpc, metavar='HOST',
     #                  help='Hostname to XML-RPC server to submit reports')
     #parser.add_option("-P", "--xmlrpc-no-abort", dest="rteval___xmlrpc_noabort",
     #                  action='store_true', default=False,
     #                  help="Do not abort if XML-RPC server do not respond to ping request");
-    parser.add_option("-Z", '--summarize', dest='rteval___summarize',
+    parser.add_argument("-Z", '--summarize', dest='rteval___summarize',
                       action='store_true', default=False,
                       help='summarize an already existing XML report')
-    parser.add_option("-H", '--raw-histogram', dest='rteval___rawhistogram',
+    parser.add_argument("-H", '--raw-histogram', dest='rteval___rawhistogram',
                       action='store_true', default=False,
                       help='Generate raw histogram data for an already existing XML report')
-    parser.add_option("-f", "--inifile", dest="rteval___inifile",
-                      type='string', default=None, metavar="FILE",
+    parser.add_argument("-f", "--inifile", dest="rteval___inifile",
+                      type=str, default=None, metavar="FILE",
                       help="initialization file for configuring loads and behavior")
-    parser.add_option("-a", "--annotate", dest="rteval___annotate",
-                      type="string", default=None, metavar="STRING",
+    parser.add_argument("-a", "--annotate", dest="rteval___annotate",
+                      type=str, default=None, metavar="STRING",
                       help="Add a little annotation which is stored in the report")
-    parser.add_option("-L", "--logging", dest="rteval___logging",
+    parser.add_argument("-L", "--logging", dest="rteval___logging",
                       action='store_true', default=False,
                       help='log the output of the loads in the report directory')
-    parser.add_option("-O", "--onlyload", dest="rteval___onlyload",
+    parser.add_argument("-O", "--onlyload", dest="rteval___onlyload",
                       action='store_true', default=False,
                       help="only run the loads (don't run measurement threads)")
-    parser.add_option("-V", "--version", dest="rteval___version",
+    parser.add_argument("-V", "--version", dest="rteval___version",
                       action='store_true', default=False,
                       help='print rteval version and exit')
     # if the -S/--source-download option doesn't include the version, set version to default
@@ -177,15 +177,33 @@ def parse_options(cfg, parser, cmdargs):
             sys.argv.insert(ind+1, ModuleParameters()["source"]["default"].replace(".tar.xz", ""))
         cmdargs.append(sys.argv[ind+1])
 
-    parser.add_option("-S", "--source-download", dest="rteval___srcdownload",
-                        type="string", default=None, metavar="KERNEL_VERSION",
+    parser.add_argument("-S", "--source-download", dest="rteval___srcdownload",
+                        type=str, default=None, metavar="KERNEL_VERSION",
                         help='download a source kernel from kernel.org and exit (if no version is provided, downloads default kernel)')
 
 
     if not cmdargs:
         cmdargs = ["--help"]
 
-    (cmd_opts, cmd_args) = parser.parse_args(args=cmdargs)
+    # if -Z/--summarize is specified, add the files to be summarized to cmd_args, and add -Z to cmd_opts
+    cmd_args = []
+    if (sys.argv.count('-Z')+sys.argv.count('--summarize')) > 0:
+        try:
+            ind = cmdargs.index('-Z')
+        except ValueError:
+            ind = cmdargs.index('--summarize')
+        cmd_args = cmdargs[ind+1:]
+        cmdargs = cmdargs[:ind+1]
+    # if -H/--raw-histogram is specified, add the files to be summarized to cmd_args, and add -Z to cmd_opts
+    elif (sys.argv.count('-H')+sys.argv.count('--raw-histogram')) > 0:
+        try:
+            ind = cmdargs.index('-H')
+        except ValueError:
+            ind = cmdargs.index('--raw-histogram')
+        cmd_args = cmdargs[ind+1:]
+        cmdargs = cmdargs[:ind+1]
+    cmd_opts = parser.parse_args(args=cmdargs)
+
     if cmd_opts.rteval___version:
         print(f"rteval version {RTEVAL_VERSION}")
         sys.exit(0)
@@ -207,7 +225,7 @@ def parse_options(cfg, parser, cmdargs):
         cmd_opts.rteval___duration = float(v) * mult
 
     # Update the config object with the parsed arguments
-    cfg.UpdateFromOptionParser(parser)
+    cfg.UpdateFromOptionParser(cmd_opts)
 
     return cmd_args
 
@@ -277,7 +295,7 @@ if __name__ == '__main__':
         measuremods = MeasurementModules(config, logger=logger)
 
         # parse command line options
-        parser = optparse.OptionParser()
+        parser = argparse.ArgumentParser()
         loadmods.SetupModuleOptions(parser)
         measuremods.SetupModuleOptions(parser)
         cmd_args = parse_options(config, parser, sys.argv[1:])
diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index d52dd597186a..253e72abf8aa 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -25,7 +25,7 @@
 import time
 from datetime import datetime
 import threading
-import optparse
+import argparse
 import libxml2
 from rteval.Log import Log
 from rteval.rtevalConfig import rtevalCfgSection
@@ -294,12 +294,11 @@ the information provided by the module"""
     def SetupModuleOptions(self, parser, config):
         """Sets up a separate optptarse OptionGroup per module with its supported parameters"""
 
-        grparser = optparse.OptionGroup(parser, "Group Options for %s modules" % self.__modtype)
-        grparser.add_option('--%s-cpulist' % self.__modtype,
+        grparser = parser.add_argument_group("Group Options for %s modules" % self.__modtype)
+        grparser.add_argument('--%s-cpulist' % self.__modtype,
                             dest='%s___cpulist' % self.__modtype, action='store', default="",
                             help='CPU list where %s modules will run' % self.__modtype,
                             metavar='LIST')
-        parser.add_option_group(grparser)
 
         for (modname, mod) in list(self.__modsloaded.items()):
             opts = mod.ModuleParameters()
@@ -313,7 +312,7 @@ the information provided by the module"""
                 # Ignore if a section is not found
                 cfg = None
 
-            grparser = optparse.OptionGroup(parser, "Options for the %s module" % shortmod)
+            grparser = parser.add_argument_group("Options for the %s module" % shortmod)
             for (o, s) in list(opts.items()):
                 descr = 'descr' in s and s['descr'] or ""
                 metavar = 'metavar' in s and s['metavar'] or None
@@ -328,14 +327,13 @@ the information provided by the module"""
                     default = 'default' in s and s['default'] or None
 
 
-                grparser.add_option('--%s-%s' % (shortmod, o),
+                grparser.add_argument('--%s-%s' % (shortmod, o),
                                     dest="%s___%s" % (shortmod, o),
                                     action='store',
                                     help='%s%s' % (descr,
                                                    default and ' (default: %s)' % default or ''),
                                     default=default,
                                     metavar=metavar)
-            parser.add_option_group(grparser)
 
 
     def InstantiateModule(self, modname, modcfg, modroot=None):
diff --git a/rteval/rtevalConfig.py b/rteval/rtevalConfig.py
index 41f1a567720f..ec14a13adcd9 100644
--- a/rteval/rtevalConfig.py
+++ b/rteval/rtevalConfig.py
@@ -286,11 +286,11 @@ class rtevalConfig:
         return self.__config_files.__contains__(fname)
 
 
-    def UpdateFromOptionParser(self, parser):
+    def UpdateFromOptionParser(self, cmd_opts):
         "Parse through the command line options and update the appropriate config settings"
 
         last_sect = None
-        for sk, v in sorted(vars(parser.values).items()):
+        for sk, v in sorted(vars(cmd_opts).items()):
             # optparse key template: {sectionname}___{key}
             k = sk.split('___')
             if k[0] != last_sect:
diff --git a/server/rteval_testserver.py b/server/rteval_testserver.py
index 3f0c3c73733c..6cac85bcfe52 100644
--- a/server/rteval_testserver.py
+++ b/server/rteval_testserver.py
@@ -31,6 +31,7 @@ import signal
 from xmlrpc.server import SimpleXMLRPCServer
 from xmlrpc.server import SimpleXMLRPCRequestHandler
 from optparse import OptionParser
+import argparse
 
 import xmlrpc_API1
 from Logger import Logger
@@ -110,16 +111,16 @@ rtevalserver = None
 #
 
 if __name__ == '__main__':
-    parser = OptionParser(version="%prog v0.1")
+    parser = argparse.ArgumentParser(version="%prog v0.1")
 
-    parser.add_option("-L", "--listen", action="store", dest="listen", default=LISTEN,
+    parser.add_argument("-L", "--listen", action="store", dest="listen", default=LISTEN,
                       help="Which interface to listen to [default: %default]", metavar="IPADDR")
-    parser.add_option("-P", "--port", action="store", type="int", dest="port", default=PORT,
+    parser.add_argument("-P", "--port", action="store", type="int", dest="port", default=PORT,
                       help="Which port to listen to [default: %default]",  metavar="PORT")
-    parser.add_option("-l", "--log", action="store", dest="logfile", default=None,
+    parser.add_argument("-l", "--log", action="store", dest="logfile", default=None,
                       help="Where to log requests.", metavar="FILE")
 
-    (options, args) = parser.parse_args()
+    options = parser.parse_args()
 
     logger = Logger(options.logfile, "RTeval")
     rtevalserver = RTevald(options, logger)
diff --git a/server/unittest.py b/server/unittest.py
index 4d53f46590ce..7dcdef08c098 100644
--- a/server/unittest.py
+++ b/server/unittest.py
@@ -1,5 +1,5 @@
 import sys, threading, time, signal, libxml2
-from optparse import OptionParser
+import argparse
 from rteval_testserver import RTevald
 from Logger import Logger
 
@@ -14,10 +14,10 @@ class ServerThread(threading.Thread):
         self.port = port
         self.log = Logger('unit-test-server.log','rteval-xmlrpc-testsrv')
 
-        parser = OptionParser()
-        parser.add_option("-L", "--listen", action="store", dest="listen", default="127.0.0.1",
+        parser = argparse.ArgumentParser()
+        parser.add_argument("-L", "--listen", action="store", dest="listen", default="127.0.0.1",
                           help="Which interface to listen to [default: %default]", metavar="IPADDR")
-        parser.add_option("-P", "--port", action="store", type="int", dest="port", default=self.port,
+        parser.add_argument("-P", "--port", action="store", type="int", dest="port", default=self.port,
                           help="Which port to listen to [default: %default]",  metavar="PORT")
 
         (options, args) = parser.parse_args()
-- 
2.39.3

