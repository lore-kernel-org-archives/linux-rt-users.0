Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93078C001B0
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Aug 2023 09:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjHJJCT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 10 Aug 2023 05:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjHJJCS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Aug 2023 05:02:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCD42127
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Aug 2023 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691658091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8PBGc6IebAkMokCkxGkYct3L2/n6z7WyIZUJS4hofmk=;
        b=CdrwzlvWj0aRNWOq7yLDKFW8VT1SqKYC5Bui/uLCj43WbJ/EKF3Vq2ilOdbIHduWckdQPt
        5bAax66FF8lNsbcEqR51BhlW2Dio4qkEBbHjvJqDkxlEJqJdBtqSkur/4ED+D0IMaLQauw
        Urb+r+6ALIZ01fLFc0zRdPDH879/3kM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-NF-kjuIpNIK4XtCfhk1tlQ-1; Thu, 10 Aug 2023 05:01:30 -0400
X-MC-Unique: NF-kjuIpNIK4XtCfhk1tlQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0B6328237C4
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Aug 2023 09:01:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55A3A492C13;
        Thu, 10 Aug 2023 09:01:29 +0000 (UTC)
From:   Tomas Glozar <tglozar@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/3] rteval: Add run_on_isolcpus option to measurements
Date:   Thu, 10 Aug 2023 11:01:22 +0200
Message-ID: <20230810090123.151924-3-tglozar@redhat.com>
In-Reply-To: <20230810090123.151924-1-tglozar@redhat.com>
References: <20230810090123.151924-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add option --measurement-run-on-isolcpus for the user to specify to
include isolcpus in the default cpulist (without --measurement-cpulist).

A default value might also be specified in rteval.conf:
[measurement]
run-on-isolcpus: true

Note that values different from true evaluate as false.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval/modules/measurement/__init__.py | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
index 0e395be..2472b43 100644
--- a/rteval/modules/measurement/__init__.py
+++ b/rteval/modules/measurement/__init__.py
@@ -146,7 +146,15 @@ measurement profiles, based on their characteristics"""
 
     def SetupModuleOptions(self, parser):
         "Sets up all the measurement modules' parameters for the option parser"
-        self.__container.SetupModuleOptions(parser, self.__cfg)
+        grparser = self.__container.SetupModuleOptions(parser, self.__cfg)
+
+        # Set up options specific for measurement module group
+        grparser.add_argument("--measurement-run-on-isolcpus",
+                              dest="measurement___run_on_isolcpus",
+                              action="store_true",
+                              default=self.__cfg.GetSection("measurement").setdefault("run-on-isolcpus", False).lower()
+                                      == "true",
+                              help="Include isolated CPUs in default cpulist")
 
 
     def Setup(self, modparams):
@@ -157,9 +165,10 @@ measurement profiles, based on their characteristics"""
 
         modcfg = self.__cfg.GetSection("measurement")
         cpulist = modcfg.cpulist
+        run_on_isolcpus = modcfg.run_on_isolcpus
 
         for (modname, modtype) in modcfg:
-            if modtype.lower() == 'module':  # Only 'module' will be supported (ds)
+            if isinstance(modtype, str) and modtype.lower() == 'module':  # Only 'module' will be supported (ds)
                 # Extract the measurement modules info
                 modinfo = self.__container.ModuleInfo(modname)
 
@@ -179,6 +188,7 @@ measurement profiles, based on their characteristics"""
                 # Setup this imported module inside the appropriate measurement profile
                 self.__cfg.AppendConfig(modname, modparams)
                 self.__cfg.AppendConfig(modname, {'cpulist':cpulist})
+                self.__cfg.AppendConfig(modname, {'run-on-isolcpus':run_on_isolcpus})
                 mp.Setup(modname)
 
         del self.__container
@@ -190,11 +200,12 @@ measurement profiles, based on their characteristics"""
         # Get the reports from all meaurement modules in all measurement profiles
         rep_n = libxml2.newNode("Measurements")
         cpulist = self.__cfg.GetSection("measurement").cpulist
+        run_on_isolcpus = self.__cfg.GetSection("measurement").run_on_isolcpus
         if cpulist:
             # Convert str to list and remove offline cpus
             cpulist = CpuList(cpulist).cpulist
         else:
-            cpulist = SysTop().default_cpus()
+            cpulist = SysTop().online_cpus() if run_on_isolcpus else SysTop().default_cpus()
         rep_n.newProp("measurecpus", collapse_cpulist(cpulist))
 
         for mp in self.__measureprofiles:
-- 
2.41.0

