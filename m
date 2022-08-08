Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E729FC25B08
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Aug 2022 12:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242678AbiHHM4y (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Aug 2022 08:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242693AbiHHM4o (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Aug 2022 08:56:44 -0400
Received: from mail.infraroot.at (mail.infraroot.at [54.37.73.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2351F5F4B
        for <linux-rt-users@vger.kernel.org>; Mon,  8 Aug 2022 05:56:41 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at (unknown [82.150.214.1])
        by mail.infraroot.at (Postfix) with ESMTPSA id 23BC6416AC;
        Mon,  8 Aug 2022 14:56:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.infraroot.at 23BC6416AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infraroot.at;
        s=default; t=1659963400;
        bh=1Azd6iH8LnHKlev57mvjVBS8lXK05mIFDM2SiXHsJz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ehC2xHVqaI0fsnQtEBDira8265Gxb49JW8tCJUBZ20gwhOZ6BkKbP4d6rHGDCLwM6
         J4ufifZuHxKjsSc+8h9iAiEKEo1c2P1fSiVqyMaI3sdIGSuk2K8GMNdnWXSqC/Xkax
         WtQODFrS+D+X0rDEqKFbb+yOmNqcuhpgStL/O+tY=
From:   David Oberhollenzer <goliath@infraroot.at>
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de, richard@nod.at,
        joseph.salisbury@canonical.com,
        David Oberhollenzer <goliath@infraroot.at>
Subject: [PATCH v2 10/10] Allow MEMCG on PREEMPT_RT
Date:   Mon,  8 Aug 2022 14:56:02 +0200
Message-Id: <20220808125602.97747-11-goliath@infraroot.at>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808125602.97747-1-goliath@infraroot.at>
References: <20220808125602.97747-1-goliath@infraroot.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

With these backported, it is safe to use MEMCG again:
0001-mm-memcg-Revert-mm-memcg-optimize-user-context-objec.patch
0002-mm-memcg-Disable-threshold-event-handlers-on-PREEMPT.patch
0003-mm-memcg-Protect-per-CPU-counter-by-disabling-preemp.patch
0004-mm-memcg-Opencode-the-inner-part-of-obj_cgroup_uncha.patch
0005-mm-memcg-Protect-memcg_stock-with-a-local_lock_t.patch
0006-mm-memcg-Disable-migration-instead-of-preemption-in-.patch
0007-mm-memcg-Add-missing-counter-index-which-are-not-upd.patch
0008-mm-memcg-Add-a-comment-regarding-the-release-obj.patch
0009-mm-memcg-Only-perform-the-debug-checks-on-PREEMPT_RT.patch

Signed-off-by: David Oberhollenzer <goliath@infraroot.at>
---
 init/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 160f836f81c7..1646c25f6ec5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -943,7 +943,6 @@ config PAGE_COUNTER
 
 config MEMCG
 	bool "Memory controller"
-	depends on !PREEMPT_RT
 	select PAGE_COUNTER
 	select EVENTFD
 	help
-- 
2.37.1

