Return-Path: <SRS0=oduH=TC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B9FC43219
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7F92085A
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556825686;
	bh=PT2UNay8JQ2ngBdYleeOpIR5sTKkU+SRuTIuGeCXWA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=YUiyolJ1xjL7MXgX9QOOAbekKpzIOaO6meFDzS5kKA32d+lyoDfD/Vz6dX7JfVKM1
	 0M3QQg6nKV8zIoTMcynOYTi5Rz1fxi/huhRzldpnvKKWfDHnnCYOYqYBRNKADiQLZq
	 AverRJIWQRFUvKCwNgxbcjhr2iG4al6NYP3AvSCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfEBTep (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 May 2019 15:34:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfEBTeo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 May 2019 15:34:44 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E40F205F4;
        Thu,  2 May 2019 19:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556825684;
        bh=PT2UNay8JQ2ngBdYleeOpIR5sTKkU+SRuTIuGeCXWA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=dvQW0oVdQ/KLXHOcX1B6VKuoRuOWXFXh6MCudW3F4VIE2slZ4orvZSQ1kp/bZtKF4
         aapTAEdRLyIm2tNyffhs+pGFKq6rChsp9imhgxb8FZwe7YAkA/UhDNLsWMj8L+fdlw
         l2Ngcycmq71zO4RpsKctbuA5+ZJGm1aerslG4M94=
From:   Tom Zanussi <zanussi@kernel.org>
To:     wagi@monom.org
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH 09/10] announce-srt: Remove explicit v4.x from upload paths
Date:   Thu,  2 May 2019 14:34:08 -0500
Message-Id: <19147fc96ac212ffea86aded76ccdaaaf879bbbd.1556825097.git.tom.zanussi@linux.intel.com>
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

Other major kernel versions are still being maintained (3.x) or will
be soon maintained (5.x) so remove the explicit v4.x from the paths.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 announce-srt.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/announce-srt.txt b/announce-srt.txt
index 912affe..4b0950d 100644
--- a/announce-srt.txt
+++ b/announce-srt.txt
@@ -16,9 +16,9 @@ You can get this release via the git tree at:
 
 Or to build {new_version} directly, the following patches should be applied:
 
-  https://www.kernel.org/pub/linux/kernel/v4.x/linux-{major}.{minor}.tar.xz
+  https://www.kernel.org/pub/linux/kernel/v{major}.x/linux-{major}.{minor}.tar.xz
 
-  https://www.kernel.org/pub/linux/kernel/v4.x/patch-{major}.{minor}.{patch}.xz
+  https://www.kernel.org/pub/linux/kernel/v{major}.x/patch-{major}.{minor}.{patch}.xz
 
   https://www.kernel.org{prj_dir}/patch-{new_version}.patch.xz
 
-- 
2.14.1

