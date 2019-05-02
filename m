Return-Path: <SRS0=oduH=TC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E858C04AA9
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DBA2087F
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556825681;
	bh=Yi3helDf42TRJw99yhHO1NSB9C/7VRffgj9D7y0q3M4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=rq35sGD1ubDWrodT4a3xLeQudDRREoy7aMHw3/D/gvWlCdDwszjW3DlB23Q45SUot
	 AbLf/0QQ1l9yaqAZQVclSbpIDWfM4RgucZcSJOhjSr/rVOGYl8RGsRkLYkW9HjdfeW
	 ewVToFs8JDhlpnhBDRLArpy6Ttl/Y/cX5UtAwVu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfEBTel (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 May 2019 15:34:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfEBTek (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 May 2019 15:34:40 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3824205F4;
        Thu,  2 May 2019 19:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556825680;
        bh=Yi3helDf42TRJw99yhHO1NSB9C/7VRffgj9D7y0q3M4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ZgKEnSW30/TqMo5OfLNQ99eQb46pbKwCyviDLmRNvbl6MCrXouR3EqI/Jzrc4xBpg
         so02cf+TITobaw1do6F6pCrbI/DCRTJtW0Ug6Sdrawz+aR35nPqc5YiBObinG5oFgr
         4n2EE00LNJ8f9CGdmqw/G5tDSXY49x+gLrgaIelg=
From:   Tom Zanussi <zanussi@kernel.org>
To:     wagi@monom.org
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH 05/10] srt_create: Use old_tag.base, not old_tag, to create patch for rc
Date:   Thu,  2 May 2019 14:34:04 -0500
Message-Id: <c31af8e200692bd87b13d51128a4acf84250e175.1556825097.git.tom.zanussi@linux.intel.com>
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

Doing the diff between old_tag and new_tag just produces another
incremental diff instead of the expected rt patch plus including the
rc patches e.g.

  srt create v3.18.138-rt115 v3.18.138-rt116-rc1

should create the diff between the base v3.18.138 and
v3.18.138-rt116-rc1 and not between v3.18.138-rt115 and
v3.18.138-rt116-rc1.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 srt_create.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/srt_create.py b/srt_create.py
index 90d1e1b..04833fe 100644
--- a/srt_create.py
+++ b/srt_create.py
@@ -64,7 +64,7 @@ def create(config, ctx):
             os.makedirs(d)
 
     if ctx.new_tag.is_rc:
-        create_patch_file(ctx.old_tag, str(ctx.new_tag), ctx.new_fln_patch)
+        create_patch_file(ctx.old_tag.base, str(ctx.new_tag), ctx.new_fln_patch)
         create_series(ctx.old_tag, ctx.new_tag, ctx.new_dir_series)
     else:
         create_patch_file(ctx.new_tag.base, str(ctx.new_tag), ctx.new_fln_patch)
-- 
2.14.1

