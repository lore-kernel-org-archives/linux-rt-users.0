Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D53C19F2B
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Aug 2022 20:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbiHCUle (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Aug 2022 16:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238558AbiHCUld (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Aug 2022 16:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94E905C377
        for <linux-rt-users@vger.kernel.org>; Wed,  3 Aug 2022 13:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659559291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1l0/AJoFsP3eH+p7vjvqXph6ZGCBZcpSP9GF3j1PB0k=;
        b=aRCJU4AwxpIggVKINJlIcHFtwDwF3ysvn133ZC3JEXQ9WV+2rMAlkL19gCsK51e6lWm8Pd
        4OIaV7yAcoylSrFU3gRiawyNlDevJEI/2FRVQFSLbu0VVuyFvQGs5o7TDWd676KSn6onT2
        fmFra4RdtJpyNtaSDhr+xyh/4HzkPp8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-I7Hn6qHfM0Ovi_1P-sPoQQ-1; Wed, 03 Aug 2022 16:41:30 -0400
X-MC-Unique: I7Hn6qHfM0Ovi_1P-sPoQQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75B5C101A588
        for <linux-rt-users@vger.kernel.org>; Wed,  3 Aug 2022 20:41:30 +0000 (UTC)
Received: from magodse.remote.csb (unknown [10.2.16.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB8031121314;
        Wed,  3 Aug 2022 20:41:29 +0000 (UTC)
From:   Manasi Godse <magodse@redhat.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, lleshchi@redhat.com,
        kcarcia@redhat.com, magodse@redhat.com
Subject: [PATCH] rteval: restrict kernel source download with invalid file extensions
Date:   Wed,  3 Aug 2022 13:41:22 -0700
Message-Id: <20220803204122.1091137-1-magodse@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If the user inputs an extension other than tar.xz or tar.gz to the -S or --source-download option, the
program should exit.

Signed-off-by: Manasi Godse <magodse@redhat.com>
---
 rteval-cmd | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rteval-cmd b/rteval-cmd
index c1a68bd5133b..e4a6bcb223da 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -275,6 +275,10 @@ if __name__ == '__main__':
                 major_version = re.search(r"\d{1,2}", kernel_prefix).group(0)
                 url = "https://kernel.org/pub/linux/kernel/v" + major_version + ".x/"
 
+            file_ext = rtevcfg.srcdownload.split(kernel_prefix)[-1]
+
+            if file_ext and file_ext not in ('.tar.xz', '.tar.gz'):
+                sys.exit("Invalid file extension for the kernel source. Exiting")
 
             if rtevcfg.srcdownload.endswith(".gz") or 'rc' in rtevcfg.srcdownload:
                 rtevcfg.srcdownload = "linux-" + kernel_prefix + ".tar.gz"
-- 
2.31.1

