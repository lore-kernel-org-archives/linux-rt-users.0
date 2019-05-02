Return-Path: <SRS0=oduH=TC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52ACC43219
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8B120B7C
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556825682;
	bh=GPppa0GCUy/09hMn8CMWG4OZzn4fjnni4AEl7E7bKTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=IPNFjhsQYKRHUth1GG4dOFV8Ln1nmqsE5t2uhOadMKnETmvBWuCt0X//pFsCW3SRI
	 T0SP6idfL3QKR170YE25WXt7priKPq/t6Jui5LUetWUOZ5Ba/b2pYjFi9sl8cotZ4R
	 Q2DvInWMC+bjxHjgTu2G09FJXhFdmNURLG3VtaFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfEBTem (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 May 2019 15:34:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfEBTel (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 May 2019 15:34:41 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E58932085A;
        Thu,  2 May 2019 19:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556825681;
        bh=GPppa0GCUy/09hMn8CMWG4OZzn4fjnni4AEl7E7bKTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=wAcUZJUEhLDRC1exCW+qIhpiM7zQWhMmlLkqi3bRwgs2R5uKqw8J+cDbbx6frON3F
         qqoX2fgaE7C+jpRfcizjpG7JmQur9FOpFm5Qk0evNgmlZSOf7j94sLJ2++pp7hjG+D
         eghELF1sAbeauVcBjWJmA3WhM15MWUdadtkKPOJY=
From:   Tom Zanussi <zanussi@kernel.org>
To:     wagi@monom.org
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH 06/10] announce-srt: Remove {major}.{minor} from upload paths
Date:   Thu,  2 May 2019 14:34:05 -0500
Message-Id: <9a13b033176c5e5d966f97a303ca81c8458662dd.1556825097.git.tom.zanussi@linux.intel.com>
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

Because PRJ_DIR already has the major.minor in the path, adding the
explicit {major}.{minor} after {prj_dir} duplicates that and creates
invalid links, so remove it.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 announce-srt.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/announce-srt.txt b/announce-srt.txt
index 631f942..912affe 100644
--- a/announce-srt.txt
+++ b/announce-srt.txt
@@ -20,12 +20,12 @@ Or to build {new_version} directly, the following patches should be applied:
 
   https://www.kernel.org/pub/linux/kernel/v4.x/patch-{major}.{minor}.{patch}.xz
 
-  https://www.kernel.org{prj_dir}/{major}.{minor}/patch-{new_version}.patch.xz
+  https://www.kernel.org{prj_dir}/patch-{new_version}.patch.xz
 
 
 You can also build from {old_version} by applying the incremental patch:
 
-  https://www.kernel.org{prj_dir}/{major}.{minor}/incr/patch-{old_version}-rt{new_tag_rt}.patch.xz
+  https://www.kernel.org{prj_dir}/incr/patch-{old_version}-rt{new_tag_rt}.patch.xz
 
 Enjoy!
    Daniel
-- 
2.14.1

