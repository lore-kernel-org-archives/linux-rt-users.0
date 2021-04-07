Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0871C433ED
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Apr 2021 18:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 654AB61168
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Apr 2021 18:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355413AbhDGSsr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Apr 2021 14:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355406AbhDGSsq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Apr 2021 14:48:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0443961245;
        Wed,  7 Apr 2021 18:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617821316;
        bh=/uEboQWa0N23boTspbR+ct5lTQeEVJSbhuaoJrqyxI0=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=bWoFf+sKVq4IhgvNGVDUPUB8fa2vJzur0j9p5omzAJ+pJllcYZHpXcuDUybz9yF6X
         BachtVlWwmh2UK6AR3R8USbtq5JYI+NYisqFPiJ6U5Uza4nU7yH4ntN7yJHbnROqw3
         lfswXmLxQQzXEbUJwkg/zJqwJzNs7ycoHjIBKomWv5c+KwvI0UKByxAiYNuKuqiDor
         cl2jSBR7nOht/GvzeS6JoJKmc6hq7wLFdIda4mPThrJ8PnvnEUCzdZ2zVvivCJW5S/
         K9Gfl05QAunBH7iwgHrVkZwU5i7LVzaemDtVmmJa2CF3EdEE6BFSJlKQ6jT0uHdrp3
         4GvCIfPe58+UA==
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 1/2] mm: slub: Don't resize the location tracking cache on PREEMPT_RT
Date:   Wed,  7 Apr 2021 13:48:32 -0500
Message-Id: <53a3ad9181bcdb62d4be6d521d6aeb490eb77e7f.1617821301.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1617821301.git.zanussi@kernel.org>
References: <cover.1617821301.git.zanussi@kernel.org>
In-Reply-To: <cover.1617821301.git.zanussi@kernel.org>
References: <cover.1617821301.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v5.4.109-rt56-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 87bd0bf324f4c5468ea3d1de0482589f491f3145 ]

The location tracking cache has a size of a page and is resized if its
current size is too small.
This allocation happens with disabled interrupts and can't happen on
PREEMPT_RT.
Should one page be too small, then we have to allocate more at the
beginning. The only downside is that less callers will be visible.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 mm/slub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 1815e28852fe..0d78368d149a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4647,6 +4647,9 @@ static int alloc_loc_track(struct loc_track *t, unsigned long max, gfp_t flags)
 	struct location *l;
 	int order;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && flags == GFP_ATOMIC)
+		return 0;
+
 	order = get_order(sizeof(struct location) * max);
 
 	l = (void *)__get_free_pages(flags, order);
-- 
2.17.1

