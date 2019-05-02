Return-Path: <SRS0=oduH=TC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD639C04AA9
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CC920B7C
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556825683;
	bh=qrjTco9q1ACaYdsLr2KZ02/DCQfpos4OmQvja/xkfvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=RHKxxYWEne605292EF2x5FSWXyia8MGIbfon0OdShfWG3whAyoO96RiIJCElY6taA
	 rcI52Mvjxfat5Nbf1oRS0qGndMeCiZiTVqG11akukwz6W7YdV2U1bQwTs7oduvsOFg
	 0Xf8BpoORYmGJTaQvHElWumFT0dft4DLI7nB9kZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEBTen (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 May 2019 15:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfEBTem (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 May 2019 15:34:42 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2B37205F4;
        Thu,  2 May 2019 19:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556825682;
        bh=qrjTco9q1ACaYdsLr2KZ02/DCQfpos4OmQvja/xkfvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=CHqBHDl/O7UO58T4w/upGuG9eO5TOvs6ZNZNb+747KaDwWu7QFWvpQBt733N1odte
         fEFIc0GPX/27+Y8mC5gn5eF3gkVJYy6KGgUJv4qRX09LfEGo1qYeH8regEc6zqIx2I
         /2olS8nWpWridAZJMbza/91qBg/SEpz5EGQq1ZZ4=
From:   Tom Zanussi <zanussi@kernel.org>
To:     wagi@monom.org
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH 07/10] srt_upload: Upload incremental update patch to prj_dir/incr, not prj_dir/older
Date:   Thu,  2 May 2019 14:34:06 -0500
Message-Id: <ef11936a413bda1391cce0b0ab4cd3bcc765bf24.1556825097.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1556825097.git.tom.zanussi@linux.intel.com>
References: <cover.1556825097.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1556825097.git.tom.zanussi@linux.intel.com>
References: <cover.1556825097.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

The incremental patch should be uploaded to prj_dir/incr - currently
it's being uploaded to prj_dir/older, which also results in a broken
link in the generated cover letter.

This fix assumes the incremental file name is at position 2 in the
file list, which the other code in srt_upload also assumes.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 srt_upload.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/srt_upload.py b/srt_upload.py
index 54da282..500f412 100644
--- a/srt_upload.py
+++ b/srt_upload.py
@@ -39,13 +39,18 @@ def upload(config, ctx):
 
     path = config['PRJ_DIR']
     older_path = path + '/' + 'older'
+    incr_path = path + '/' + 'incr'
 
     kup = ['kup']
 
-    for f in ctx.get_files():
+    for i, f in enumerate(ctx.get_files()):
         basename = os.path.splitext(f)[0]
-        kup.extend(['put', basename + '.xz', basename + '.sign',
-                    older_path + '/', '--'])
+        if i == 2:
+            kup.extend(['put', basename + '.xz', basename + '.sign',
+                        incr_path + '/', '--'])
+        else:
+            kup.extend(['put', basename + '.xz', basename + '.sign',
+                        older_path + '/', '--'])
 
     # skip incr_file
     for f in ctx.get_files()[:2]:
-- 
2.14.1

