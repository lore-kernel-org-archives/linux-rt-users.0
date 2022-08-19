Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C447C32772
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Aug 2022 09:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348133AbiHSJZD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348136AbiHSJY7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Aug 2022 05:24:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AC5F2CB9;
        Fri, 19 Aug 2022 02:24:58 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660901093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4dQn43Rkz+KTHmLlfq4c2cNRUWSBSi8YMEA4SfF9LJI=;
        b=gnqwEegGCKtfSteUolVmAsB39Vg8hf5KPtnOrgV9Il+O9ayErdYdjcj7ueGsazx+x80oTT
        7XDxZ11FbiAMUc6xrRnrtvD81xG9QuvjnFTrg9Gb2JLuLR6DtyG2xgzh3GaCTPAYOiigrk
        h9ZMpkvUhjyyCwraslTXQsodb0s7Ys797ifH3K8J3fKu0fzYa/8zbBWjmuKPLmpO2ucXBE
        02ghQ5QMElEXAE9fqDxb/arc3mehySAFYEiHURyIsuhzj1pzMPsvSDRkojfbZaEAIJh87V
        6NbxgOTLi4IvP+PZMuLG/I/5XvTqMeOpI2ZG8/F6TJuqnBvf3ykqn5ZDvN29Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660901093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4dQn43Rkz+KTHmLlfq4c2cNRUWSBSi8YMEA4SfF9LJI=;
        b=9UujoHcjfmRbwMXxZVKmCzlNdmopSd9ZF3zl5KiRNXUv/p+fTHyxgKX3amuxoLc6SQacjE
        5HB+4z6Hfw03WFCA==
To:     Mark Gross <markgross@kernel.org>
Cc:     linux-rt-users@vger.kernel.org, stable-rt@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 6/9] timers: Don't block on ->expiry_lock for TIMER_IRQSAFE timers
Date:   Fri, 19 Aug 2022 11:24:43 +0200
Message-Id: <20220819092446.980320-7-bigeasy@linutronix.de>
In-Reply-To: <20220819092446.980320-1-bigeasy@linutronix.de>
References: <20220819092446.980320-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Upstream commit c725dafc95f1b37027840aaeaa8b7e4e9cd20516

PREEMPT_RT does not spin and wait until a running timer completes its
callback but instead it blocks on a sleeping lock to prevent a livelock in
the case that the task waiting for the callback completion preempted the
callback.

This cannot be done for timers flagged with TIMER_IRQSAFE. These timers can
be canceled from an interrupt disabled context even on RT kernels.

The expiry callback of such timers is invoked with interrupts disabled so
there is no need to use the expiry lock mechanism because obviously the
callback cannot be preempted even on RT kernels.

Do not use the timer_base::expiry_lock mechanism when waiting for a running
callback to complete if the timer is flagged with TIMER_IRQSAFE.

Also add a lockdep assertion for RT kernels to validate that the expiry
lock mechanism is always invoked in preemptible context.

[bigeasy: The logic in v4.9 is slightly different but the outcome is the
   same as we must not sleep while waiting for the irqsafe timer to
   complete. The IRQSAFE timer can not be preempted.
   The "lockdep annotation" is not available and has been replaced with
   might_sleep()]

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201103190937.hga67rqhvknki3tp@linutronix.=
de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/timer.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 613139c7538eb..401917af2abcf 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1179,9 +1179,9 @@ EXPORT_SYMBOL_GPL(add_timer_on);
 static void wait_for_running_timer(struct timer_list *timer)
 {
 	struct timer_base *base;
-	u32 tf =3D timer->flags;
+	u32 tf =3D READ_ONCE(timer->flags);
=20
-	if (tf & TIMER_MIGRATING)
+	if (tf & (TIMER_MIGRATING | TIMER_IRQSAFE))
 		return;
=20
 	base =3D get_timer_base(tf);
@@ -1312,6 +1312,13 @@ int del_timer_sync(struct timer_list *timer)
 	 * could lead to deadlock.
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
+	/*
+	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
+	 * del_timer_wait_running().
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(timer->flags & TIMER_IRQSAFE))
+		might_sleep();
+
 	for (;;) {
 		int ret =3D try_to_del_timer_sync(timer);
 		if (ret >=3D 0)
--=20
2.37.2

