Return-Path: <SRS0=QXCx=WE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BC3C433FF
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4822D218BC
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565293999;
	bh=c1ssD/JpmDSoxjjPFn4KxCrYFahLskpnqkX549wisuU=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=0n7/ASm0Xa1DkD0UqHz9t7KpOu94YD19ApBA8dGY7Pu5J5VvFdXJKEKx15zimn724
	 /omXsaf3pgEej/3OCa1DvtHXjfd8MJ+hOP0vDkFBtVxzJHZjq//Ypm+M/l94CFHOfN
	 ZtAcXzkzdttBigWAY1ZRnoieCNr2kFwNhblHLRZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404457AbfHHTxR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404421AbfHHTxQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:16 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61A19218A3;
        Thu,  8 Aug 2019 19:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565293995;
        bh=c1ssD/JpmDSoxjjPFn4KxCrYFahLskpnqkX549wisuU=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=x2vKq/90KlvieQoztnf8yQ/AuVtGqbGtlTyDhiEZ7i74uf3tPvr08xjKH2uz3YSYa
         3rpJc+BYZpUW2BdE4Kz/DSr405LQJlrWfRGShUM9djneLKM+MYv6Zxz9oSnQoaJ5JA
         idEEnYP8/+qwhG/KTGsbmvXpz4ZjhjJo5LTDBPBM=
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
Subject: [PATCH RT 06/19] sched/completion: Fix a lockup in wait_for_completion()
Date:   Thu,  8 Aug 2019 14:52:34 -0500
Message-Id: <8985311afa3c64a083d12c8460c582873d09aeef.1565293934.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

v4.14.137-rt65-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit f0837746a7e258abb35e65defc432ca66786347f ]

Consider following race:

  T0                    T1                       T2
  wait_for_completion()
   do_wait_for_common()
    __prepare_to_swait()
     schedule()
                        complete()
                         x->done++ (0 -> 1)
                         raw_spin_lock_irqsave()
                         swake_up_locked()       wait_for_completion()
                          wake_up_process(T0)
                          list_del_init()
                         raw_spin_unlock_irqrestore()
                                                  raw_spin_lock_irq(&x->wait.lock)
  raw_spin_lock_irq(&x->wait.lock)                x->done != UINT_MAX, 1 -> 0
                                                  raw_spin_unlock_irq(&x->wait.lock)
                                                  return 1
   while (!x->done && timeout),
   continue loop, not enqueued
   on &x->wait

Basically, the problem is that the original wait queues used in
completions did not remove the item from the queue in the wakeup
function, but swake_up_locked() does.

Fix it by adding the thread to the wait queue inside the do loop.
The design of swait detects if it is already in the list and doesn't
do the list add again.

Cc: stable-rt@vger.kernel.org
Fixes: a04ff6b4ec4ee7e ("completion: Use simple wait queues")
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[bigeasy: shorten commit message ]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/sched/completion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 0fe2982e46a0..ac6d5efcd6ff 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -80,12 +80,12 @@ do_wait_for_common(struct completion *x,
 	if (!x->done) {
 		DECLARE_SWAITQUEUE(wait);
 
-		__prepare_to_swait(&x->wait, &wait);
 		do {
 			if (signal_pending_state(state, current)) {
 				timeout = -ERESTARTSYS;
 				break;
 			}
+			__prepare_to_swait(&x->wait, &wait);
 			__set_current_state(state);
 			raw_spin_unlock_irq(&x->wait.lock);
 			timeout = action(timeout);
-- 
2.14.1

