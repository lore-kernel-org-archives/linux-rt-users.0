Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F64DC0015E
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jun 2023 17:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjFWRwm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 13:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjFWRwk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Jun 2023 13:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA052133
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Jun 2023 10:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687542712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9G435Az6PmEiUXiub2CMWN2uzfIqzTxiiP6/bYZYA4=;
        b=LUZT/cASCsUfd90b1bjboWfi+eceN1Zps50kI5N3jDXpzv+Rs8kTTnzessw1YCCnArJ895
        WdK6T9PJejn1FO9GrRK7anND3DVOBnqS0z/EHQWeaQANU2Dc8NUpFzhQdtQZ/UtJvoGIHA
        D3C11G2dhNKA6IUM6VDZ1qNkuHvlBvo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-YnZzBc5WOnSAv46oTRgj4w-1; Fri, 23 Jun 2023 13:51:51 -0400
X-MC-Unique: YnZzBc5WOnSAv46oTRgj4w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30FFC3803919
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Jun 2023 17:51:51 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.18.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CD29C57961;
        Fri, 23 Jun 2023 17:51:51 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     kcarcia@redhat.com, Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2 2/3] Fixed bug in the --source-download option in rteval-cmd
Date:   Fri, 23 Jun 2023 13:50:49 -0400
Message-Id: <20230623175049.492763-2-ashelat@redhat.com>
In-Reply-To: <20230623175049.492763-1-ashelat@redhat.com>
References: <20230623175049.492763-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

rteval-cmd: Fixed a bug in rteval-cmd which was causing the -S
option to throw an error when a kernel version was specified.
Also edited comments, and removed excess code.
__init__.py, rtevalConfig.py: Edited comments and strings for accuracy.
remove_rtevalrun: Replaced optparse for argparse. Edited
comments to specify argparse instead of optparse.
rtevak_testserver.py: deleted excess code

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval-cmd                  | 12 ++++++++++--
 rteval/modules/__init__.py  |  4 ++--
 rteval/rtevalConfig.py      |  2 +-
 server/remove_rtevalrun     | 16 ++++++++--------
 server/rteval_testserver.py |  1 -
 5 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index 70996acce626..19efd1d0b296 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -166,7 +166,7 @@ def parse_options(cfg, parser, cmdargs):
     parser.add_argument("-V", "--version", dest="rteval___version",
                       action='store_true', default=False,
                       help='print rteval version and exit')
-    parser.add_argument("-S", "--source-download", dest="rteval___srcdownload",
+    parser.add_argument("-S", "--source-download", nargs='*', dest="rteval___srcdownload",
                         type=str, default=None, metavar="KERNEL_VERSION",
                         help='download a source kernel from kernel.org and exit')
 
@@ -183,7 +183,7 @@ def parse_options(cfg, parser, cmdargs):
             ind = cmdargs.index('--summarize')
         cmd_args = cmdargs[ind+1:]
         cmdargs = cmdargs[:ind+1]
-    # if -H/--raw-histogram is specified, add the files to be summarized to cmd_args, and add -Z to cmd_opts
+    # if -H/--raw-histogram is specified, add the files to be summarized to cmd_args, and add -H to cmd_opts
     elif (sys.argv.count('-H')+sys.argv.count('--raw-histogram')) > 0:
         try:
             ind = cmdargs.index('-H')
@@ -191,8 +191,16 @@ def parse_options(cfg, parser, cmdargs):
             ind = cmdargs.index('--raw-histogram')
         cmd_args = cmdargs[ind+1:]
         cmdargs = cmdargs[:ind+1]
+
     cmd_opts = parser.parse_args(args=cmdargs)
 
+    # if no kernel version was provided for --source-download, set version to default
+    if (sys.argv.count('-S')+sys.argv.count('--source-download')) > 0:
+        if cmd_opts.rteval___srcdownload == []:
+            cmd_opts.rteval___srcdownload = ModuleParameters()["source"]["default"].replace(".tar.xz", "")
+        else:
+            cmd_opts.rteval___srcdownload = cmd_opts.rteval___srcdownload[0]
+
     if cmd_opts.rteval___version:
         print(f"rteval version {RTEVAL_VERSION}")
         sys.exit(0)
diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index 253e72abf8aa..e32d6fd9545d 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -292,7 +292,7 @@ the information provided by the module"""
 
 
     def SetupModuleOptions(self, parser, config):
-        """Sets up a separate optptarse OptionGroup per module with its supported parameters"""
+        """Sets up a separate argparse ArgumentGroup per module with its supported parameters"""
 
         grparser = parser.add_argument_group("Group Options for %s modules" % self.__modtype)
         grparser.add_argument('--%s-cpulist' % self.__modtype,
@@ -451,7 +451,7 @@ class RtEvalModules:
         return self.__modules.GetModulesList()
 
     def SetupModuleOptions(self, parser):
-        "Sets up optparse based option groups for the loaded modules"
+        "Sets up argparse based option groups for the loaded modules"
         return self.__modules.SetupModuleOptions(parser, self._cfg)
 
     def GetNamedModuleObject(self, modname):
diff --git a/rteval/rtevalConfig.py b/rteval/rtevalConfig.py
index ec14a13adcd9..d0115a052324 100644
--- a/rteval/rtevalConfig.py
+++ b/rteval/rtevalConfig.py
@@ -291,7 +291,7 @@ class rtevalConfig:
 
         last_sect = None
         for sk, v in sorted(vars(cmd_opts).items()):
-            # optparse key template: {sectionname}___{key}
+            # argparse key template: {sectionname}___{key}
             k = sk.split('___')
             if k[0] != last_sect:
                 # If the section name changed, retrieve the section variables
diff --git a/server/remove_rtevalrun b/server/remove_rtevalrun
index cee699e27c9f..7d83f71ea644 100755
--- a/server/remove_rtevalrun
+++ b/server/remove_rtevalrun
@@ -29,7 +29,7 @@
 
 import sys
 import getpass
-from optparse import OptionParser
+from argparse import ArgumentParser
 from database import Database
 
 def do_delete(dbc, table, rterid):
@@ -45,20 +45,20 @@ def do_delete(dbc, table, rterid):
 
 
 if __name__ == '__main__':
-    parser = OptionParser(version="%prog v0.1")
+    parser = ArgumentParser(version="%prog v0.1")
 
-    parser.add_option("-H", "--host", action="store", dest="dbhost", default="localhost",
+    parser.add_argument("-H", "--host", action="store", dest="dbhost", default="localhost",
                       help="Database server to connect to (default: %default)",
                       metavar="HOST")
-    parser.add_option("-p", "--port", action="store", dest="dbport", default="5432",
+    parser.add_argument("-p", "--port", action="store", dest="dbport", default="5432",
                       help="Database server port to use (default: %default)", metavar="PORT")
-    parser.add_option("-U", "--user", action="store", dest="dbuser", default="rtevaladmin",
+    parser.add_argument("-U", "--user", action="store", dest="dbuser", default="rtevaladmin",
                       help="Database user to connect as (default: %default)", metavar="USERNAME")
-    parser.add_option("-d", "--database", action="store", dest="dbname", default="rteval",
+    parser.add_argument("-d", "--database", action="store", dest="dbname", default="rteval",
                       help="Database to use (default: %default)", metavar="DATABASE")
-    parser.add_option("-r", "--rterid", action="store", dest="rterid", default=None,
+    parser.add_argument("-r", "--rterid", action="store", dest="rterid", default=None,
                       help="rteval run id to remove from the database", metavar="INTEGER")
-    (opts, args) = parser.parse_args()
+    opts = parser.parse_args()
 
     if opts.rterid is None:
         print "%s:  Missing --rterid value" % sys.argv[0]
diff --git a/server/rteval_testserver.py b/server/rteval_testserver.py
index 6cac85bcfe52..c7f9ce954b21 100644
--- a/server/rteval_testserver.py
+++ b/server/rteval_testserver.py
@@ -30,7 +30,6 @@ import sys
 import signal
 from xmlrpc.server import SimpleXMLRPCServer
 from xmlrpc.server import SimpleXMLRPCRequestHandler
-from optparse import OptionParser
 import argparse
 
 import xmlrpc_API1
-- 
2.39.3

