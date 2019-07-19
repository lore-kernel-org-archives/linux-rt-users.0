Return-Path: <SRS0=OCQz=VQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA79C76195
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Jul 2019 21:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1964F2184E
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Jul 2019 21:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389073AbfGSVug (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Jul 2019 17:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388774AbfGSVt7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Jul 2019 17:49:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E390D218A5;
        Fri, 19 Jul 2019 21:49:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hoalK-00084e-0y; Fri, 19 Jul 2019 17:49:58 -0400
Message-Id: <20190719214957.919918275@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 19 Jul 2019 17:49:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>, tom.zanussi@linux.intel.com
Subject: [PATCH RT 12/16] Revert "futex: workaround migrate_disable/enable in different
 context"
References: <20190719214931.700049248@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.19.59-rt24-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit a71221d81cc4873891ae44f3aa02df596079b786 ]

Drop the RT fixup, the futex code will be changed to avoid the need for
the workaround.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/futex.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 1d9423914bf4..54ffc25183ed 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2875,14 +2875,6 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
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
@@ -2891,7 +2883,6 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	 */
 	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current);
 	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
-	migrate_enable();
 
 	if (ret) {
 		if (ret == 1)
@@ -3040,21 +3031,11 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
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
2.20.1


