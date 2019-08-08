Return-Path: <SRS0=QXCx=WE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F02C32754
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746B72184E
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565294036;
	bh=AIfkfa0RiDwi8ziRsTnzeTUvsZcK6ySrFmUB+ps5abo=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=bpvBLB+fmmLhcWzkA+SYfz9c4gK6DaZ37U5v8bOQPOzYTZ/7yErky8ZLd0rH8laSa
	 Y8UL4a0jqgHniFI52LpqwmJF0HNBlmbnheqHKGNZUK14jpDk2e99qur0z6PLSODWme
	 rO39ElQtSTiyIf0Qg2x+bPKLgB3Kf3ze4OMlzjV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404546AbfHHTxY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404353AbfHHTxY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:24 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2470F218D8;
        Thu,  8 Aug 2019 19:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565294003;
        bh=AIfkfa0RiDwi8ziRsTnzeTUvsZcK6ySrFmUB+ps5abo=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=EhUgKWvGEXIRayAJuuhowmEyW61Gk+qvgWiA05mmgSnaDMcRWdiJZE0lVeo3mYXud
         61u4+pdHAz6hd6lLxsTwkeK3IWW8KkCeVmDX6MecP67WVfC/207AFKr8DSvGkZZ2Tb
         pQ0pmT11x9zoyJZZbxIQNxvEnNv20A9wknukKHew=
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
Subject: [PATCH RT 15/19] Revert "futex: workaround migrate_disable/enable in different context"
Date:   Thu,  8 Aug 2019 14:52:43 -0500
Message-Id: <6c551bd14ae69ce8bb8c99cf9d4cd0bafd3015ca.1565293935.git.zanussi@kernel.org>
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


[ Upstream commit a71221d81cc4873891ae44f3aa02df596079b786 ]

Drop the RT fixup, the futex code will be changed to avoid the need for
the workaround.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>

 Conflicts:
	kernel/futex.c
---
 kernel/futex.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index cb7e212fba0f..ec90130cd809 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2893,14 +2893,6 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	 * before __rt_mutex_start_proxy_lock() is done.
 	 */
 	raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
-	/*
-	 * the migrate_disable() here disables migration in the in_atomic() fast
-	 * path which is enabled again in the following spin_unlock(). We have
-	 * one migrate_disable() pending in the slow-path which is reversed
-	 * after the raw_spin_unlock_irq() where we leave the atomic context.
-	 */
-	migrate_disable();
-
 	spin_unlock(q.lock_ptr);
 	/*
 	 * __rt_mutex_start_proxy_lock() unconditionally enqueues the @rt_waiter
@@ -2909,7 +2901,6 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	 */
 	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current);
 	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
-	migrate_enable();
 
 	if (ret) {
 		if (ret == 1)
@@ -3058,21 +3049,11 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		 * rt_waiter. Also see the WARN in wake_futex_pi().
 		 */
 		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
-		/*
-		 * Magic trickery for now to make the RT migrate disable
-		 * logic happy. The following spin_unlock() happens with
-		 * interrupts disabled so the internal migrate_enable()
-		 * won't undo the migrate_disable() which was issued when
-		 * locking hb->lock.
-		 */
-		migrate_disable();
 		spin_unlock(&hb->lock);
 
 		/* drops pi_state->pi_mutex.wait_lock */
 		ret = wake_futex_pi(uaddr, uval, pi_state);
 
-		migrate_enable();
-
 		put_pi_state(pi_state);
 
 		/*
-- 
2.14.1

