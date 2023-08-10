Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074F0C04A94
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Aug 2023 09:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjHJJCV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 10 Aug 2023 05:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjHJJCU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Aug 2023 05:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CFE211F
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Aug 2023 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691658090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JIBQNdn5gJw9CfPBmwfXP8HD/eN8kJoHKJNetKw23pk=;
        b=Khj/bN6ujC6KfdP3qYFIhl/zSVxGWgUjLsSCxiklqxIqbJ3oGJHpbZ677ikNp/dTVYQbtB
        f5eqHVEsKdzsd8JAZ8eekx5AYmIODIeAXaYAGpP/0RwuGt3kMMsjm4DGjW6fi7UnBqBqcF
        uf/8ShRnsX4o3i4k8DcHquLN9zKOVxk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-tiNCEFv8Mqqy8spIW5j8ZQ-1; Thu, 10 Aug 2023 05:01:29 -0400
X-MC-Unique: tiNCEFv8Mqqy8spIW5j8ZQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BFEA185A792
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Aug 2023 09:01:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77F7D492C13;
        Thu, 10 Aug 2023 09:01:28 +0000 (UTC)
From:   Tomas Glozar <tglozar@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 1/3] rteval: Allow arguments specific to module group
Date:   Thu, 10 Aug 2023 11:01:21 +0200
Message-ID: <20230810090123.151924-2-tglozar@redhat.com>
In-Reply-To: <20230810090123.151924-1-tglozar@redhat.com>
References: <20230810090123.151924-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Return grparser from ModuleContainer.SetupModuleOptions, which allows it
to be used to setup additional options in *Modules class.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval/modules/__init__.py | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index 794135d..f4fd160 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -312,7 +312,7 @@ the information provided by the module"""
                 # Ignore if a section is not found
                 cfg = None
 
-            grparser = parser.add_argument_group("Options for the %s module" % shortmod)
+            modgrparser = parser.add_argument_group("Options for the %s module" % shortmod)
             for (o, s) in list(opts.items()):
                 descr = 'descr' in s and s['descr'] or ""
                 metavar = 'metavar' in s and s['metavar'] or None
@@ -327,13 +327,15 @@ the information provided by the module"""
                     default = 'default' in s and s['default'] or None
 
 
-                grparser.add_argument('--%s-%s' % (shortmod, o),
-                                    dest="%s___%s" % (shortmod, o),
-                                    action='store',
-                                    help='%s%s' % (descr,
-                                                   default and ' (default: %s)' % default or ''),
-                                    default=default,
-                                    metavar=metavar)
+                modgrparser.add_argument('--%s-%s' % (shortmod, o),
+                                         dest="%s___%s" % (shortmod, o),
+                                         action='store',
+                                         help='%s%s' % (descr,
+                                                        default and ' (default: %s)' % default or ''),
+                                         default=default,
+                                         metavar=metavar)
+
+            return grparser
 
 
     def InstantiateModule(self, modname, modcfg, modroot=None):
-- 
2.41.0

