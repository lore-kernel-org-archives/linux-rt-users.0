Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FA3EB64DA
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jun 2023 19:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjF1Twm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jun 2023 15:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230238AbjF1Twk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jun 2023 15:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687981910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQDsbU/n3tCG6RtFC98Vc+fP3EPWbLyiDcXj5WCNqhA=;
        b=W+dj6eKdLMAdgGR/ZstlcNTpxP59GNQme2Zc1ctXwt5qigjhLA57K49ksrx4HXgD+yi7ru
        3hByCmLdIZb+od+wUFaO+EFLrX9bsMAnXuI9JrNJB0Fw38/UvaBh3xiGr6qhnKMYa880sx
        tvWLqP7AKjNyXTTGqn4dP8LRkxtmqfM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-VedHNXe3PO2lUIRbpCb_MQ-1; Wed, 28 Jun 2023 15:51:48 -0400
X-MC-Unique: VedHNXe3PO2lUIRbpCb_MQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DCCF185A792
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 19:51:48 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED6A5F5CDF;
        Wed, 28 Jun 2023 19:51:47 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH 2/3] rteval: fixed comments
Date:   Wed, 28 Jun 2023 15:51:44 -0400
Message-Id: <20230628195145.636652-3-ashelat@redhat.com>
In-Reply-To: <20230628195145.636652-1-ashelat@redhat.com>
References: <20230628195145.636652-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

rteval-cmd: fixed typo
__init__.py, rtevalConfig: changed comments to use argparse instead of
optparse
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

