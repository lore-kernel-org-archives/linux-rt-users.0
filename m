Return-Path: <SRS0=c0v5=6H=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A92C54FD0
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 19:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD3020704
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 19:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKe0J2TD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgDWTcA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgDWTb7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Apr 2020 15:31:59 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C49C09B042
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Apr 2020 12:31:59 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v26so315564qto.0
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Apr 2020 12:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:subject:message-id:mime-version
         :content-disposition;
        bh=YKftKgNX490h5J6DCjJ7rkb56cP4gz1Un9OVKW83hmI=;
        b=eKe0J2TDiQCZNkSHrKiGxBZrYuIxCRj1BLr+uHI9DJNfluro+smO1pex+ZMeQgaw+9
         aGjTQ2DsZQbkv83INJ/b8xBtwWUm8NAJBnJqiRZoYyIaQzG9J5CPcBKMoCzTjWtIwJTi
         AR7uRH3mMy7lJzTijvdhFUPcVPS/j4OF5+yQZdn7+uzi26dgOjEkaC8qvHgVmtctLhCn
         ZKEZ8Kx1WqKjOg0Kbzb1sSztL5b412Y7PlI6jVT5j8DwwE6CnGwWUJDoUz1EEwrRtRQ5
         ndYg5E5j3Lm3dsr3EoYqKpHqDNMouUImMUavzhftIPHUaXI0H8iBtynMvj+02jtT+UC1
         y3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:subject:message-id
         :mime-version:content-disposition;
        bh=YKftKgNX490h5J6DCjJ7rkb56cP4gz1Un9OVKW83hmI=;
        b=m+4eOJSzi+lOluyARHkJk3P0AKxZVrvRJlj0wcDh9IDtEFCRMSHsVrqFguzZ3FaAMb
         m7pRawm64m3EK4hwAdefO/cu3wnBF30eHAJrzGv0xIisDe7oNPmEhF1m+VyzLgRdY7cX
         m7wwnBjFy6napVQECWpuB8dJk3/y8HqomBTqbJSwDTAbGLVYh5Kb7Y7SL+i3Fxw8MCI3
         qtB7Yc1gPlVYxpr9pz/hOlxZGVV0IspTeVX6hrG/NLItz+ALwnoSAmSWcTa85k97nrnu
         sNxkyNNFUqxOoktzTkvXDUF3kdYhyBOCmk/9Pt5bhsf45q/v/D4TruA2+lbE6hhw7Kmz
         relQ==
X-Gm-Message-State: AGi0Pua4AXjqnLAfc9vUFLJFtRf6ZBcNZOQgyU+wnU3HsYqFao0B5bHv
        IwdBrTShkN9IQtD6of+nGjM18y30
X-Google-Smtp-Source: APiQypKpkWe1a5RX/eEx191cxiAZ4ib1nOr38huM98JBQ37pNTmInMiLeLLSHY2XM3Ye+TylYNBkfw==
X-Received: by 2002:ac8:735a:: with SMTP id q26mr5700141qtp.233.1587670318847;
        Thu, 23 Apr 2020 12:31:58 -0700 (PDT)
Received: from lclaudio.dyndns.org ([191.177.186.218])
        by smtp.gmail.com with ESMTPSA id p10sm2240763qtu.14.2020.04.23.12.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 12:31:58 -0700 (PDT)
From:   "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
X-Google-Original-From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 05B9A3C0172; Thu, 23 Apr 2020 16:31:55 -0300 (-03)
Date:   Thu, 23 Apr 2020 16:31:55 -0300
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: [PATCH v5.6.4-rt3] rfcomm/bluetooth: avoid disabling interrupts on RT
Message-ID: <20200423193155.GD75343@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The current code in rfcomm_sk_state_change() calls:

	local_irq_save(flags);
	bh_lock_sock(sk);

As bh_lock_sock translates into a spin_lock() operation, the following BUG is
triggered on PREEMPT_RT:

[  277.573392] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:973
[  277.573399] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 2234, name: krfcommd
[  277.573401] INFO: lockdep is turned off.
[  277.573402] irq event stamp: 0
[  277.573403] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[  277.573407] hardirqs last disabled at (0): [<ffffffff910ed9df>] copy_process+0x7cf/0x2100
[  277.573412] softirqs last  enabled at (0): [<ffffffff910ed9df>] copy_process+0x7cf/0x2100
[  277.573414] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  277.573416] CPU: 1 PID: 2234 Comm: krfcommd Tainted: G        W         5.6.4.lockdep-rt3 #3
[  277.573419] Hardware name: Hewlett-Packard p7-1512/2ADA, BIOS 8.15 02/05/2013
[  277.573420] Call Trace:
[  277.573427]  dump_stack+0x8f/0xd0
[  277.573434]  ___might_sleep.cold+0xf5/0x109
[  277.573441]  rt_spin_lock+0x88/0xc0
[  277.573447]  ? rfcomm_sk_state_change+0x55/0x190 [rfcomm]
[  277.573455]  rfcomm_sk_state_change+0x55/0x190 [rfcomm]
[  277.573462]  rfcomm_run+0x1340/0x18f0 [rfcomm]
[  277.573471]  ? do_wait_intr_irq+0xc0/0xc0
[  277.573478]  ? _raw_spin_unlock_irqrestore+0x41/0x90
[  277.573484]  kthread+0x106/0x140
[  277.573488]  ? rfcomm_check_accept+0x90/0x90 [rfcomm]
[  277.573492]  ? kthread_park+0x90/0x90
[  277.573496]  ret_from_fork+0x3a/0x50

Pairing a bluetooth device is enough to trigger the BUG.

Replacing local_irq_save()/bh_lock_sock() by spin_lock_bh() keeps the semantics
and does the right thing under PREEMPT_RT.

Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index b4eaf21360ef..f894dc14bad0 100644
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
