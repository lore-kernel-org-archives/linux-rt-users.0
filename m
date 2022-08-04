Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9DCC19F21
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Aug 2022 19:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbiHDT2g (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Aug 2022 15:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239523AbiHDT2d (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Aug 2022 15:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 997976D54F
        for <linux-rt-users@vger.kernel.org>; Thu,  4 Aug 2022 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659641311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IvR+5TlrfQkDYbLmmbA0paEW0grD/fC8Rn212sSVlw4=;
        b=ErIzsWbA5F40tH/TV9+2+6gJUOWj4HtmJpCqxHk/fRhE00BjeEPy5EPZD/UFMc4ODOtEJj
        LVxxpLCQXoPhY5hchFOxqbQyouNo1pqXUPAqf4gs+e14vImFQpsstC7hm1X+v55qsFTSBp
        rKcuw1+0wdyoeh5lezf7nRpLdbfKSTc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-6HUIXnVYNgacPGx3Ij-qUA-1; Thu, 04 Aug 2022 15:28:28 -0400
X-MC-Unique: 6HUIXnVYNgacPGx3Ij-qUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D41D85A584;
        Thu,  4 Aug 2022 19:28:28 +0000 (UTC)
Received: from magodse.remote.csb (unknown [10.2.17.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E01714152E0;
        Thu,  4 Aug 2022 19:28:27 +0000 (UTC)
From:   Manasi Godse <magodse@redhat.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, lleshchi@redhat.com,
        kcarcia@redhat.com, magodse@redhat.com, gmanasi13@gmail.com
Subject: [PATCH] rteval: fix regex in kcompile to calculate patch number for kernel prefix
Date:   Thu,  4 Aug 2022 12:28:25 -0700
Message-Id: <20220804192825.1207283-1-magodse@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Updated the regular expression to find the kernel prefix of the source
file. If there are kernel source files with the same major.minor version
but different patch numbers, kcompile would pick up the first one that
is listed based on the kernel prefix and ignore the patch number.
Example: linux-5.17.11.tar.xz and linux-5.17.13.tar.xz. If 5.17.13 had
to be tested, kcompile could pick up linux-5.17.11.tar.xz

Signed-off-by: Manasi Godse <magodse@redhat.com>
---
 rteval/modules/loads/kcompile.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 4a8659c042e6..6dd8d940f8b3 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -176,7 +176,7 @@ class Kcompile(CommandLineLoad):
             if not os.path.exists(tarfile):
                 raise rtevalRuntimeError(self, f" tarfile {tarfile} does not exist!")
             self.source = tarfile
-            kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}", self.source).group(0)
+            kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}\.*\d{1,2}", self.source).group(0)
         else:
             tarfiles = glob.glob(os.path.join(self.srcdir, f"{DEFAULT_KERNEL_PREFIX}*"))
             if tarfiles:
-- 
2.31.1

