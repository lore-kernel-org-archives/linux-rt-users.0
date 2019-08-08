Return-Path: <SRS0=QXCx=WE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC4FC0650F
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3E2218CA
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565294002;
	bh=73AVpHgx7hvxDRDi7Z0/fC6HMg6y1Q9UwJjkg/W9oYA=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=A/4/fB+t4X3XZPHuhstCveV4kQn1aCVFG0z5rVaRNcBiQW3WBEpk1PrWjP5Yzs56B
	 q5uQ0Iv65RbzQrzwr5qwgXTKDvIMCSdbf5fSlUMWT6To+m7uWfCp7NgzGiPzaL+es/
	 a4LnxPn1MdPuX8hrUPM6y9vaQ0mjqb5RyGmsGzLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404490AbfHHTxU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404477AbfHHTxS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:18 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A69C2189E;
        Thu,  8 Aug 2019 19:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565293998;
        bh=73AVpHgx7hvxDRDi7Z0/fC6HMg6y1Q9UwJjkg/W9oYA=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=0Oyl98DroSKmDk8bq8egRVbugDa8qfldToI4dKvq/Mcah4i2U3uEUqgUHqpU8JMFI
         ZAOnUa5wDZZs1eLsE1sg2B6olnlKQulk0NVqPBrda6WNnO92gfrQFCY45JAKfygnXr
         z1ei7C+jLtSe12HnrM3EclVt1OgjOHtyESavotOA=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 09/19] rcu: Don't allow to change rcu_normal_after_boot on RT
Date:   Thu,  8 Aug 2019 14:52:37 -0500
Message-Id: <3761f1e54b904b2c8c7ce4132456a72d7ac9978c.1565293934.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.137-rt65-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit c6c058c10577815a2491ce661876cff00a4c3b15 ]

On RT rcu_normal_after_boot is enabled by default.
Don't allow to disable it on RT because the "expedited rcu" would
introduce latency spikes.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/rcu/update.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 2006a09680aa..307592810f6b 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -67,7 +67,9 @@ module_param(rcu_expedited, int, 0);
 extern int rcu_normal; /* from sysctl */
 module_param(rcu_normal, int, 0);
 static int rcu_normal_after_boot = IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
+#ifndef CONFIG_PREEMPT_RT_FULL
 module_param(rcu_normal_after_boot, int, 0);
+#endif
 #endif /* #ifndef CONFIG_TINY_RCU */
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-- 
2.14.1

