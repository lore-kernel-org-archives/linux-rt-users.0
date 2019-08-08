Return-Path: <SRS0=QXCx=WE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C03C0650F
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B4A218BA
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565294000;
	bh=aHv2LDiaGN7dEQiNuFUXYzjr+42/lR/ICUScbvMgjZE=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=pZCnhuA8NxAChZJeu7hOfd6T3pXQBlUdjWNyzIR1GVRqkrxbzjV8kyVgQe//W545+
	 PSytbAT/AOkU8f7p6KNUNkaTjZZhRp0PrXrFervr6qf9/orYm1tQ8B9VBGrt61di3F
	 ZRIabHifni07ebWs6+s3tMWAgXUZBTgIu+CNNPNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404467AbfHHTxS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404353AbfHHTxQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:16 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5773A218B0;
        Thu,  8 Aug 2019 19:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565293996;
        bh=aHv2LDiaGN7dEQiNuFUXYzjr+42/lR/ICUScbvMgjZE=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=qRwYvhYQnb7Je8j2HVjxJydJ5BQhQeewfuvHP64AfiIS4ALF3n3k+nAwR1TvP7UxO
         hLwxo+fTyElm9vAQ8dzH68nls1ocxGI2bIbNaU5HA2vm7KGQ/cIahA2Ih4g4OnsdiQ
         5z4kw5bZfv30m7KTQxIGAYmN8wEXl2wC2HGQWjic=
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
Subject: [PATCH RT 07/19] locking/lockdep: Don't complain about incorrect name for no validate class
Date:   Thu,  8 Aug 2019 14:52:35 -0500
Message-Id: <6a31ace7aff17a469ea5f390c8b2ae61695b7159.1565293934.git.zanussi@kernel.org>
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


[ Upstream commit 978315462d3ea3cf6cfacd34c563ec1eb02a3aa5 ]

It is possible to ignore the validation for a certain lock by using:

	lockdep_set_novalidate_class()

on it. Each invocation will assign a new name to the class it created
for created __lockdep_no_validate__. That means that once
lockdep_set_novalidate_class() has been used on two locks then
class->name won't match lock->name for the first lock triggering the
warning.

So ignore changed non-matching ->name pointer for the special
__lockdep_no_validate__ class.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/20190517212234.32611-1-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/locking/lockdep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e576d234f3ea..f194de27123d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -719,7 +719,8 @@ look_up_lock_class(struct lockdep_map *lock, unsigned int subclass)
 			 * Huh! same key, different name? Did someone trample
 			 * on some memory? We're most confused.
 			 */
-			WARN_ON_ONCE(class->name != lock->name);
+			WARN_ON_ONCE(class->name != lock->name &&
+				     lock->key != &__lockdep_no_validate__);
 			return class;
 		}
 	}
-- 
2.14.1

