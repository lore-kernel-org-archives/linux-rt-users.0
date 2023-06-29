Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF219EB64D9
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jun 2023 20:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjF2Uqf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Jun 2023 16:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjF2Uqe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Jun 2023 16:46:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F95A2695
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Jun 2023 13:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688071542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/OJDkBRlePxxLpqXIjWbhpT49wLcZeg8nf3RNWWpS08=;
        b=E8xTgDJus+OTTasglPx49ycA6+B3qD4tQKgxFSf0xd5VZQBwcyJP1nPDqw85IPHc1rQEvN
        yBujr//LPARhyclPd6xAcR2cUm8XHftTo3ZSVuZxhNuukEh5FgHxK6W1YbaOQApRquD7bl
        pDVn/Ma/071x5QF9N0W/Bc7sr0jRPdg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-HpywEywNMyKOAcKqnodR9w-1; Thu, 29 Jun 2023 16:45:41 -0400
X-MC-Unique: HpywEywNMyKOAcKqnodR9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8FFF104458A
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Jun 2023 20:45:40 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.32.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0EFFF5CD2;
        Thu, 29 Jun 2023 20:45:40 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     kcarcia@redhat.com, Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2] Fixed bug in kcompile where run would fail if kcompile-source version had the form x.y instead of x.y.z
Date:   Thu, 29 Jun 2023 16:45:38 -0400
Message-Id: <20230629204538.888970-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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
index 35ee5cbbb52d..a1f5614dbd3b 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -175,7 +175,7 @@ class Kcompile(CommandLineLoad):
         if 'rc' in self._cfg.source:
             tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\-[a-z]*\d{1,2}", self._cfg.source).group(0)
         else:
-            tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}", self._cfg.source).group(0)
+            tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}" + "|" + r"\d{1,2}\.\d{1,3}", self._cfg.source).group(0)
 
         # either a tar.xz or tar.gz might exist. Check for both.
         xz_file = os.path.join(self.srcdir,"linux-" + tarfile_prefix + ".tar.xz" )
@@ -193,7 +193,7 @@ class Kcompile(CommandLineLoad):
         # find our source tarball
         if self._cfg.source:
             self.source = self._find_tarball()
-            kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}\.*\d{1,2}", self.source).group(0)
+            kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}\.*\d{1,2}" + "|" + r"linux-\d{1,2}\.\d{1,3}", self.source).group(0)
         else:
             tarfiles = glob.glob(os.path.join(self.srcdir, f"{DEFAULT_KERNEL_PREFIX}*"))
             if tarfiles:
-- 
2.39.3

