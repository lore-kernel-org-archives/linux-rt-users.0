Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B09CCA483
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Jul 2022 11:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiGLLqQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Jul 2022 07:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiGLLqN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Jul 2022 07:46:13 -0400
Received: from mail.infraroot.at (mail.infraroot.at [54.37.73.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD308B1963
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Jul 2022 04:46:10 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at (unknown [82.150.214.1])
        by mail.infraroot.at (Postfix) with ESMTPSA id 3F10640AAE;
        Tue, 12 Jul 2022 13:22:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.infraroot.at 3F10640AAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infraroot.at;
        s=default; t=1657624969;
        bh=VdWRuWrJvrHCpkbnZjaLP6hbNsoyeYZS7k+p3f9yklY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ysbH0rrGXCO38zWbhjnTm55K6eCfXQDn0Ko6erY7XxJhZ/5zH/IGGWlWsdUiOM58H
         hStWYnRUubgCWIcXWi6OnA4hmWDJzICzB9zjkF60i7QGPYQYVfPMbnM7YThRCW464a
         IADFaL3G8F9jzFWR8bNtVvY3un5nSanp7Mn+WBCI=
From:   David Oberhollenzer <goliath@infraroot.at>
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de, richard@nod.at,
        David Oberhollenzer <goliath@infraroot.at>
Subject: [PATCH 4/4] Allow MEMCG on PREEMPT_RT
Date:   Tue, 12 Jul 2022 13:22:38 +0200
Message-Id: <20220712112238.18824-5-goliath@infraroot.at>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712112238.18824-1-goliath@infraroot.at>
References: <20220712112238.18824-1-goliath@infraroot.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

With these backported, it is safe to use MEMCG again:
mm/memcg: Add a local_lock_t for IRQ and TASK object.
mm/memcg: Protect per-CPU counter by disabling preemption on PREEMPT_RT where needed.
mm/memcg: Disable threshold event handlers on PREEMPT_RT

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
2.36.1

