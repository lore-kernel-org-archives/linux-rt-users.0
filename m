Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1515EB64D7
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jun 2023 20:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjF1Up6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jun 2023 16:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjF1Up4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jun 2023 16:45:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C39210E
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 13:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687985099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KIhfrDqiwnlUYbpa+03QY/wU9276Ag/eUC2PKn7iOLY=;
        b=giIlexEzuA+itBOK979oztRDk2wbxnG2C5yvPkyzs/n4AaYcRA/hccipREWNW999xntH2J
        RndmJflxEw0o/SgvPqf7ybXytS1gRGBtGFoFfb229WRI0Unp19Q60L2q94OQmCXNpuMpyN
        vKIyu9PMTY7dBJG8ot7mcigYWEXsJwg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482--rqmpchMPRaP9LylJbg70w-1; Wed, 28 Jun 2023 16:44:56 -0400
X-MC-Unique: -rqmpchMPRaP9LylJbg70w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88A4980027F
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 20:44:56 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CA2F2166B25;
        Wed, 28 Jun 2023 20:44:56 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2 2/3] rteval: fixed comments
Date:   Wed, 28 Jun 2023 16:44:42 -0400
Message-Id: <20230628204441.640374-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

rteval-cmd: fixed typo
__init__.py, rtevalConfig: changed comments to use argparse instead of
optparse

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval-cmd                 | 2 +-
 rteval/modules/__init__.py | 4 ++--
 rteval/rtevalConfig.py     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index ae94bd98cc11..1f2ea08ef4ff 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -183,7 +183,7 @@ def parse_options(cfg, parser, cmdargs):
             ind = cmdargs.index('--summarize')
         cmd_args = cmdargs[ind+1:]
         cmdargs = cmdargs[:ind+1]
-    # if -H/--raw-histogram is specified, add the files to be summarized to cmd_args, and add -Z to cmd_opts
+    # if -H/--raw-histogram is specified, add the files to be summarized to cmd_args, and add -H to cmd_opts
     elif (sys.argv.count('-H')+sys.argv.count('--raw-histogram')) > 0:
         try:
             ind = cmdargs.index('-H')
diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index 253e72abf8aa..794135d277b5 100644
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
+        "Sets up argparse based argument groups for the loaded modules"
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
-- 
2.39.3

