Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F4EFA3747
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 Oct 2022 15:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiJaPvT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 31 Oct 2022 11:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiJaPvQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 31 Oct 2022 11:51:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A0811C35
        for <linux-rt-users@vger.kernel.org>; Mon, 31 Oct 2022 08:51:15 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667231474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxrLsNaCxmjh7zZfTWjtpgN2DnX1GSZaFz3TRuacpbE=;
        b=SmwwEh0XOIYw2Zsxj1Nw9n8nkUjD2reFodM89fadMQd33k94gV1iZyUVlGp80pMw+IaOUv
        3y+FH/YBWYCQ5ZhI8oN+ANP1ze6HST1x8oQnJ9OHoJGe+xYitEckZpFHgjMDXpynaPSJtW
        RHbs/z5I1cAcPYppFXIoUpGYYmIZvnB0eUBPH8RQtki7Fv5ESjtRNCgU1VgFzfMFXty5kd
        5L9GhQqUisWdJpolbkgYFG0wMg/QzKYqRH2RtyKp6gYTRfJupzxxpLr1NYAUuXgdpyqszY
        LQHo5bMwwPfnbpvTnaOCsyk84Imki+y0W81sAf64kOdbB6nSEDVT07qjEydrOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667231474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxrLsNaCxmjh7zZfTWjtpgN2DnX1GSZaFz3TRuacpbE=;
        b=ljqZr8y5/vqNljyk44Vo1CyvnNCUjmsQD46GmzsqehmukYqdzQ19AnwSKAjTT9dukhrlLn
        H/1O0eKBY28Xa5Ag==
To:     Daniel Wagner <wagi@monom.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        homas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: [PATCH RT 3/3] timers: Don't block on ->expiry_lock for TIMER_IRQSAFE timers
Date:   Mon, 31 Oct 2022 16:50:06 +0100
Message-Id: <20221031155006.1651995-4-bigeasy@linutronix.de>
In-Reply-To: <20221031155006.1651995-1-bigeasy@linutronix.de>
References: <20221024105416.nflnrqhmzsyqqdzz@carbon.lan>
 <20221031155006.1651995-1-bigeasy@linutronix.de>
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

[ bigeasy: Dropping that lockdep_assert_preemption_enabled() check in
           backport ]

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201103190937.hga67rqhvknki3tp@linutronix.=
de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/timer.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 603985720f547..8c7bfcee9609a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1304,7 +1304,7 @@ static void del_timer_wait_running(struct timer_list =
*timer)
 	u32 tf;
=20
 	tf =3D READ_ONCE(timer->flags);
-	if (!(tf & TIMER_MIGRATING)) {
+	if (!(tf & (TIMER_MIGRATING | TIMER_IRQSAFE))) {
 		struct timer_base *base =3D get_timer_base(tf);
=20
 		/*
@@ -1388,6 +1388,15 @@ int del_timer_sync(struct timer_list *timer)
 	 */
 	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
=20
+	/*
+	 * Must be able to sleep on PREEMPT_RT because of the slowpath in
+	 * del_timer_wait_running().
+	 */
+#if 0
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(timer->flags & TIMER_IRQSAFE))
+		lockdep_assert_preemption_enabled();
+#endif
+
 	do {
 		ret =3D try_to_del_timer_sync(timer);
=20
--=20
2.37.2

