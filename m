Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263E3C25B06
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Aug 2022 00:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiHEAc1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Aug 2022 20:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiHEAc0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Aug 2022 20:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 174BC422C6
        for <linux-rt-users@vger.kernel.org>; Thu,  4 Aug 2022 17:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659659544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ce9DnjvYAAdy073dEfR9uR1kOQaeXq84FyW2hxkuQog=;
        b=JYAeqPNrx9tpHqgqnVQpLSRLOEuHSTSeexu+tW2Nf7+FdWiLNmGT2unKooJlpYb3HGJxsc
        gk/D0qEugsXfyOZgYpulSGpy11XFDNbjV84tl0z9S+cfa70LYqAXzF45/LAxKrXF7o7pqC
        Zw1JYYMOwsq6+4d8Jmcgz1p0k1zXce8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-QW9SQjqHNC6rIgp3PCXXGQ-1; Thu, 04 Aug 2022 20:32:23 -0400
X-MC-Unique: QW9SQjqHNC6rIgp3PCXXGQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D847885A581;
        Fri,  5 Aug 2022 00:32:22 +0000 (UTC)
Received: from magodse.remote.csb (unknown [10.2.16.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2165F492C3B;
        Fri,  5 Aug 2022 00:32:22 +0000 (UTC)
From:   Manasi Godse <magodse@redhat.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, lleshchi@redhat.com,
        kcarcia@redhat.com, magodse@redhat.com, gmanasi13@gmail.com
Subject: [PATCH] rteval: enhancement to --kcompile-source option for kernel tarball
Date:   Thu,  4 Aug 2022 17:32:19 -0700
Message-Id: <20220805003219.1248947-1-magodse@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The --kcompile-source option is enhanced such that it can find the
kernel source tarballs using the values as 'linux-5.18.1' , '5.18.1',
'linux-5.18.1.tar.xz' This eliminates the need to type the entire
source filename as a value to the option. The enhancement will look for
the tarballs in the loadsource directory.

Signed-off-by: Manasi Godse <magodse@redhat.com>
---
 rteval/modules/loads/kcompile.py | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 6dd8d940f8b3..7d78d0ff9cae 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -166,16 +166,33 @@ class Kcompile(CommandLineLoad):
             raise rtevalRuntimeError(self, \
                 f"error removing builddir ({self.buildir}) (ret={ret})")
 
+    def _find_tarball(self):
+       # If the user specifies the full kernel name, check if available
+        tarfile = os.path.join(self.srcdir, self._cfg.source)
+        if os.path.exists(tarfile):
+            return tarfile
+
+        if 'rc' in self._cfg.source:
+            tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\-[a-z]*\d{1,2}", self._cfg.source).group(0)
+        else:
+            tarfile_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}", self._cfg.source).group(0)
+
+        # either a tar.xz or tar.gz might exist. Check for both.
+        xz_file = os.path.join(self.srcdir,"linux-" + tarfile_prefix + ".tar.xz" )
+        gz_file = os.path.join(self.srcdir,"linux-" + tarfile_prefix + ".tar.gz" )
+        if os.path.exists(xz_file):
+            return xz_file
+        elif os.path.exists(gz_file):
+            return gz_file
+        raise rtevalRuntimeError(self, f"tarfile {tarfile} does not exist!")
+
     def _WorkloadSetup(self):
         if self._donotrun:
             return
 
         # find our source tarball
         if self._cfg.source:
-            tarfile = os.path.join(self.srcdir, self._cfg.source)
-            if not os.path.exists(tarfile):
-                raise rtevalRuntimeError(self, f" tarfile {tarfile} does not exist!")
-            self.source = tarfile
+            self.source = self._find_tarball()
             kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}\.*\d{1,2}", self.source).group(0)
         else:
             tarfiles = glob.glob(os.path.join(self.srcdir, f"{DEFAULT_KERNEL_PREFIX}*"))
-- 
2.31.1

