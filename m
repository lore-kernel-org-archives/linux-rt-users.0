Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ABCEB64DC
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jun 2023 21:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjF1V6n (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jun 2023 17:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjF1V6k (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jun 2023 17:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B8226B7
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 14:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687989473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=f73iKQ8oknHVQAXx+9lX0M2BGZl9bM4axPbqe5LpIhM=;
        b=THpJvzLinRfVe0bpG08IbYJK06UeyHCGBjnq76pLGo275qLlZ5hkAOonCT8Mg2gxTQv9D1
        90cYTo54d1/tZP5NZ73PsdYhppd1NqXqF3KkhOdZRaUq6DkmquKASv0hQCX9/6My0+4DcO
        G5ADsNuxgFEsnVSPqPf0WIMVdDRo2EA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-JTR3fevFOIeapdBhiJFdqA-1; Wed, 28 Jun 2023 17:57:51 -0400
X-MC-Unique: JTR3fevFOIeapdBhiJFdqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AE821C04B59
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 21:57:51 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74D13111F3B0;
        Wed, 28 Jun 2023 21:57:51 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     kcarcia@redhat.com, Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH 1/1] Fixed bug in kcompile where run would fail if kcompile-source version had the form x.y instead of x.y.z
Date:   Wed, 28 Jun 2023 17:57:31 -0400
Message-Id: <20230628215730.738234-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Fixed bug in kcompile where run would fail if kcompile-source version
had the form x.y instead of x.y.z

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval/modules/loads/kcompile.py | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 35ee5cbbb52d..445575fb137a 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -175,8 +175,11 @@ class Kcompile(CommandLineLoad):
         if 'rc' in self._cfg.source:
             tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\-[a-z]*\d{1,2}", self._cfg.source).group(0)
         else:
-            tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}", self._cfg.source).group(0)
-
+            try:
+                tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}", self._cfg.source).group(0)
+            except AttributeError:
+                # if the kernel version has the form x.x instead of x.x.x
+                tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}", self._cfg.source).group(0)
         # either a tar.xz or tar.gz might exist. Check for both.
         xz_file = os.path.join(self.srcdir,"linux-" + tarfile_prefix + ".tar.xz" )
         gz_file = os.path.join(self.srcdir,"linux-" + tarfile_prefix + ".tar.gz" )
@@ -193,7 +196,11 @@ class Kcompile(CommandLineLoad):
         # find our source tarball
         if self._cfg.source:
             self.source = self._find_tarball()
-            kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}\.*\d{1,2}", self.source).group(0)
+            try:
+                kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}\.*\d{1,2}", self.source).group(0)
+            except AttributeError:
+                # if the kernel version has the form x.x instead of x.x.x
+                kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}", self.source).group(0)
         else:
             tarfiles = glob.glob(os.path.join(self.srcdir, f"{DEFAULT_KERNEL_PREFIX}*"))
             if tarfiles:
-- 
2.39.3

