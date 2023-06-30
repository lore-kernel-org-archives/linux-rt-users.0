Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEFDEB64D7
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jun 2023 17:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjF3RL1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 13:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjF3RLZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jun 2023 13:11:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BC1125
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 10:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688145034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fytHE9ygmZrlEauJDuUZMerny+qJ3gyCuRyH/lWI0ow=;
        b=HOcUqVyUlIma6dnwry73ZpExUCMOB+GNzPmf0yBr12ilEOTFPw/LixGL3fcL3LlBpm+MKn
        zupzUtYYf2OMnvDX0boLS9iUKFBvJunAF/kExprHnKLrziEg4p8axvG4cOO4tW42n2tiFw
        KJY6kmVKLt1mkCLAcCoGEhKhVdt8xuo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-hCDcjHYhPGCMYKAJWBOWzg-1; Fri, 30 Jun 2023 13:10:33 -0400
X-MC-Unique: hCDcjHYhPGCMYKAJWBOWzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1F8B2808B22
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Jun 2023 17:10:32 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.32.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8562B40C2071;
        Fri, 30 Jun 2023 17:10:32 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     kcarcia@redhat.com, Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v3 1/2] Fixed bug in kcompile where run would fail if kcompile-source version had the form x.y instead of x.y.z
Date:   Fri, 30 Jun 2023 13:10:17 -0400
Message-Id: <20230630171017.1072241-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Fixed bug in kcompile where run would fail if kcompile-source version
had the form x.y instead of x.y.z

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval/modules/loads/kcompile.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 35ee5cbbb52d..92442468febf 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -175,7 +175,7 @@ class Kcompile(CommandLineLoad):
         if 'rc' in self._cfg.source:
             tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\-[a-z]*\d{1,2}", self._cfg.source).group(0)
         else:
-            tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}", self._cfg.source).group(0)
+            tarfile_prefix = re.search(r"(\d{1,2}\.\d{1,3}\.\d{1,3})|(\d{1,2}\.\d{1,3})", self._cfg.source).group(0)
 
         # either a tar.xz or tar.gz might exist. Check for both.
         xz_file = os.path.join(self.srcdir,"linux-" + tarfile_prefix + ".tar.xz" )
@@ -193,7 +193,7 @@ class Kcompile(CommandLineLoad):
         # find our source tarball
         if self._cfg.source:
             self.source = self._find_tarball()
-            kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}\.*\d{1,2}", self.source).group(0)
+            kernel_prefix = re.search(r"(linux-\d{1,2}\.\d{1,3}\.\d{1,3})|(linux-\d{1,2}\.\d{1,3})", self.source).group(0)
         else:
             tarfiles = glob.glob(os.path.join(self.srcdir, f"{DEFAULT_KERNEL_PREFIX}*"))
             if tarfiles:
-- 
2.39.3

