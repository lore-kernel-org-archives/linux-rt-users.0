Return-Path: <SRS0=oduH=TC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033D0C04AAA
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFA62085A
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556825686;
	bh=YJ6NDJ4NbtvCPJRn3Z5cYLQmH73TgYJJAeBtmRZ8rRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=LViSVPG1FpcX0D6jD+fQ6kGLV4lzHmdl/DMZW/9fFpz/ksUy/h9Gi21AkEetQCtR5
	 RiY3PER9rOK024QjKr9zWU3TO39t8eWMTiQhvXGpYATwIZZTBePSpzqEJVKk1q9HHp
	 IdQhqGSKNTIIQMVLS3IuR7feF2Gx5g8rlbQNDCbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfEBTeq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 May 2019 15:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbfEBTep (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 May 2019 15:34:45 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B2E42087F;
        Thu,  2 May 2019 19:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556825685;
        bh=YJ6NDJ4NbtvCPJRn3Z5cYLQmH73TgYJJAeBtmRZ8rRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=aS6jxLQg34Pwu97aTh7K6+ItlChukUud1Zp2+XjuxwNI2C38p8vYiJW222jBTUIRQ
         MHKZi0IP4e2HBy9uJklclRCnTAwZOrMOwLHDS9qZuKdFhGUvn8hzCn6xLp5PrTRBkp
         UKVQJs7AL6pgk1GK1v6r3NYW8I0dkPs/Vd8xLbcc=
From:   Tom Zanussi <zanussi@kernel.org>
To:     wagi@monom.org
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH 10/10] announce-srt-rc: Add tarball links
Date:   Thu,  2 May 2019 14:34:09 -0500
Message-Id: <6c56689c9aee9a9ca965c6f6152bef4c9b24e328.1556825097.git.tom.zanussi@linux.intel.com>
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

There should be links in the cover letter pointing to the rc release
tarballs just as for any other release, so add them.

This also adds the -rc{new_tag_rc} suffix added by the previous patch
in the series.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 announce-srt-rc.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/announce-srt-rc.txt b/announce-srt-rc.txt
index ca08c4c..89b69d9 100644
--- a/announce-srt-rc.txt
+++ b/announce-srt-rc.txt
@@ -15,6 +15,19 @@ final release is.
 If all goes well, this patch will be converted to the next main
 release on {release_date}.
 
+To build {new_version} directly, the following patches should be applied:
+
+  https://www.kernel.org/pub/linux/kernel/v{major}.x/linux-{major}.{minor}.tar.xz
+
+  https://www.kernel.org/pub/linux/kernel/v{major}.x/patch-{major}.{minor}.{patch}.xz
+
+  https://www.kernel.org{prj_dir}/patch-{new_version}.patch.xz
+
+
+You can also build from {old_version} by applying the incremental patch:
+
+  https://www.kernel.org{prj_dir}/incr/patch-{old_version}-rt{new_tag_rt}-rc{new_tag_rc}.patch.xz
+
 Enjoy,
 
 -- Daniel
-- 
2.14.1

