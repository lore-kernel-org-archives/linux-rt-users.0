Return-Path: <SRS0=BA5Y=SK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC10C10F14
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C267320879
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554750935;
	bh=R898RYWcfSbMLiskJxSelNaT1b9QJrsjBRQJ9a/G1hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=huo+pQKWGhBj8opHSoNy2ZOMi9bTYAPAUvKAetv8ih6yg12NrsD5cecHVP6yQYm/H
	 20ZznaNaeHdtQJJy2DCdrr6bbBx29t0Cs06WG1g2rLfgnA3hXWyW9aeGobC+GbNLhi
	 Z4NWxjQkfa7Om/zwP7o0XUB9rdu4Pwe43ch3rr1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfDHTPa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbfDHTO1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Apr 2019 15:14:27 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3604421841;
        Mon,  8 Apr 2019 19:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554750867;
        bh=R898RYWcfSbMLiskJxSelNaT1b9QJrsjBRQJ9a/G1hM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=HFh+kiafDG/mf/W36s1NG89PYymL+GFp0LjgzAvpLl5UhZFUN3P/zvHcHihdltxtU
         /kDPeX2eiFUEDRgs8x6FxLZYNAtD7zTvpGwgXYVQCfg9QHUV6pQ59CRxM//omd1ZUg
         r9caF9UQwDgev3y8BisWtkPi3F+FAw9zmho3FaM0=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com, amartin@nvidia.com
Subject: [PATCH 05/13] rtmutex/rwlock: preserve state like a sleeping lock
Date:   Mon,  8 Apr 2019 14:14:07 -0500
Message-Id: <784bd79865718c40cd2564db00f430ae6ac014da.1554737688.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.14.109-rt58-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 4a1bf9e54a013d55ab156cb462c68054cb52ee2d ]

The rwlock is spinning while acquiring a lock. Therefore it must become
a sleeping lock on RT and preserve its task state while sleeping and
waiting for the lock to become available.

Reported-by: Joe Korty <Joe.Korty@concurrent-rt.com>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/locking/rwlock-rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rwlock-rt.c b/kernel/locking/rwlock-rt.c
index f2e155b2c4a8..c3b91205161c 100644
--- a/kernel/locking/rwlock-rt.c
+++ b/kernel/locking/rwlock-rt.c
@@ -128,7 +128,7 @@ void __sched __read_rt_lock(struct rt_rw_lock *lock)
 	 * That would put Reader1 behind the writer waiting on
 	 * Reader2 to call read_unlock() which might be unbound.
 	 */
-	rt_mutex_init_waiter(&waiter, false);
+	rt_mutex_init_waiter(&waiter, true);
 	rt_spin_lock_slowlock_locked(m, &waiter, flags);
 	/*
 	 * The slowlock() above is guaranteed to return with the rtmutex is
-- 
2.14.1

