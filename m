Return-Path: <SRS0=doyN=BX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87412C433DF
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 01:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FBF621775
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 01:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgHMBp5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Aug 2020 21:45:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgHMBp5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Aug 2020 21:45:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C38A7208A9;
        Thu, 13 Aug 2020 01:45:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1k62JX-00750f-QF; Wed, 12 Aug 2020 21:45:55 -0400
Message-ID: <20200813014555.694818878@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 12 Aug 2020 21:45:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        stable-rt@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH RT 3/6] Bluetooth: Acquire sk_lock.slock without disabling interrupts
References: <20200813014534.833107526@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.4.54-rt33-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit e6da0edc24eecef2f6964d92fa9044e1821deace ]

There was a lockdep which led to commit
   fad003b6c8e3d ("Bluetooth: Fix inconsistent lock state with RFCOMM")

Lockdep noticed that `sk->sk_lock.slock' was acquired without disabling
the softirq while the lock was also used in softirq context.
Unfortunately the solution back then was to disable interrupts before
acquiring the lock which however made lockdep happy.
It would have been enough to simply disable the softirq. Disabling
interrupts before acquiring a spinlock_t is not allowed on PREEMPT_RT
because these locks are converted to 'sleeping' spinlocks.

Use spin_lock_bh() in order to acquire the `sk_lock.slock'.

Cc: stable-rt@vger.kernel.org
Reported-by: Luis Claudio R. Goncalves <lclaudio@uudg.org>
Reported-by: kbuild test robot <lkp@intel.com> [missing unlock]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 net/bluetooth/rfcomm/sock.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 90bb53aa4bee..2c27aa2acf1c 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -64,15 +64,13 @@ static void rfcomm_sk_data_ready(struct rfcomm_dlc *d, struct sk_buff *skb)
 static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 {
 	struct sock *sk = d->owner, *parent;
-	unsigned long flags;
 
 	if (!sk)
 		return;
 
 	BT_DBG("dlc %p state %ld err %d", d, d->state, err);
 
-	local_irq_save(flags);
-	bh_lock_sock(sk);
+	spin_lock_bh(&sk->sk_lock.slock);
 
 	if (err)
 		sk->sk_err = err;
@@ -93,8 +91,7 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 		sk->sk_state_change(sk);
 	}
 
-	bh_unlock_sock(sk);
-	local_irq_restore(flags);
+	spin_unlock_bh(&sk->sk_lock.slock);
 
 	if (parent && sock_flag(sk, SOCK_ZAPPED)) {
 		/* We have to drop DLC lock here, otherwise
-- 
2.28.0


