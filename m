Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C694AC001B0
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Aug 2023 09:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbjHKJxX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Aug 2023 05:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjHKJxW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Aug 2023 05:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26E22D52
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Aug 2023 02:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691747565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JIBQNdn5gJw9CfPBmwfXP8HD/eN8kJoHKJNetKw23pk=;
        b=I8P+ny20Hq2PmfUYcISWzjNTebLgtjexaDbTLz8LK1XFwbbfRd8xePlGFIzIKE7txp/k4v
        nCD93fTKZPYKoGay3TPJszgZ4ks//6q94M575o/4yIPKJukmLIM8uXC+dvo3TPMRoGw8OB
        NZgbR2jTSuZafVrlFRNVGeBIFdG44aE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-1hMbateMMJuDMnJmpZtIDg-1; Fri, 11 Aug 2023 05:52:43 -0400
X-MC-Unique: 1hMbateMMJuDMnJmpZtIDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 801941C07547
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Aug 2023 09:52:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D99082026D4B;
        Fri, 11 Aug 2023 09:52:42 +0000 (UTC)
From:   Tomas Glozar <tglozar@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 1/3] rteval: Allow arguments specific to module group
Date:   Fri, 11 Aug 2023 11:52:26 +0200
Message-ID: <20230811095228.200772-2-tglozar@redhat.com>
In-Reply-To: <20230811095228.200772-1-tglozar@redhat.com>
References: <20230811095228.200772-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

