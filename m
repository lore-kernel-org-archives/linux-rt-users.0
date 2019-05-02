Return-Path: <SRS0=oduH=TC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049C3C43219
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBDB20B7C
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556825684;
	bh=0p9vpueg6HSRNsP+lsUNOwKtRsI9snXJHKqpcf1Pwyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=d79M2IjULG97TsRt5H6vZ2mEVx6YLt4i7JHsBW6/CuZ3yBta71Nb9r4yxhC9atezp
	 T4EcA3HxbhYJUvuVYPIHN5XS6AETjuh+E7RIl8HCrLTDDh/iWV0N3oXq3ELGxey2Wz
	 d6/Ja9clQ3i36wqKGAlu8uHhl6z0XS/nxkp7PYuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfEBTeo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 May 2019 15:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfEBTen (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 May 2019 15:34:43 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07B932085A;
        Thu,  2 May 2019 19:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556825683;
        bh=0p9vpueg6HSRNsP+lsUNOwKtRsI9snXJHKqpcf1Pwyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=XdyJ/OOFefqOIRk95/OEM1LyIVRThLfku+pa5O571gwu+lBlpalV3yy3RgMFARF7s
         428bB3MTOz+xL4phqJI8+H+r4XARbLP+3spL+fOyTqsHpMbeQ0UheftSR5dC1WuhoO
         sn1kYFaPDu1lrGckhqz4bI7MPnmIeIZTxb5KKV2E=
From:   Tom Zanussi <zanussi@kernel.org>
To:     wagi@monom.org
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH 08/10] srt_announce: Add "new_tag_rc" for rc incremental releases
Date:   Thu,  2 May 2019 14:34:07 -0500
Message-Id: <079e8afaeddbeb5ba46b25d99c690063642119f2.1556825097.git.tom.zanussi@linux.intel.com>
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

For rc releases, the filename generated for the incremental release
ends with -rt{new_tag_rt}-rc{new_tag_rc}.patch.xz rather than just
-rt{new_tag_rt}.patch.xz, so we need to make new_tag_rc available for
that.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 srt_announce.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/srt_announce.py b/srt_announce.py
index a1985cd..cbaa3f3 100644
--- a/srt_announce.py
+++ b/srt_announce.py
@@ -55,7 +55,8 @@ def cover_letter_replacements(config, ctx):
          "new_version" : ctx.new_short_tag,
          "old_version" : ctx.old_short_tag,
          "prj_dir" : config['PRJ_DIR'],
-         "new_tag_rt" : ctx.new_tag.rt }
+         "new_tag_rt" : ctx.new_tag.rt,
+         "new_tag_rc" : ctx.new_tag.rc }
     return r
 
 def write_rc_cover_letter(config, ctx):
-- 
2.14.1

