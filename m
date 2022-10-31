Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C33ECAAA1
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 Oct 2022 15:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiJaPvR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 31 Oct 2022 11:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiJaPvQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 31 Oct 2022 11:51:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3F311C2A
        for <linux-rt-users@vger.kernel.org>; Mon, 31 Oct 2022 08:51:15 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667231473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+v02lFGBTQ/aBIKxjP7ZtUbYkSoXI9MAMtdSPSmn7Q=;
        b=11JQffDEU8S/QWowg13N46bAeq0t/aYUOzgEaMnaF5oAWTEOFwbej8v/dIsJBJj/xuV5Dz
        FymMjP74K62P1H3YnBS+WOIahEluuIeMsQQ7UBW9uH8XvesPImIYWtH6ZTMcawusMIA3fO
        8bKkXvfAZrpl5Uv0cIicm18GsFpYyIVB9qOUkAYCAwsmD2IyV3GumabRBplzWAw1cmv2fi
        044fj0427rCA5kImQYZpmaT6VMhx5lqPvXlKeWtrACLLjwC8E4vGsluYrJ5HJukFeZwoYA
        o7F9ECbnPrgaVx31K+8lY9TIndWmykVRZA3BcuRCL4iuxBVU/Ir4fmrsQ2vZhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667231473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+v02lFGBTQ/aBIKxjP7ZtUbYkSoXI9MAMtdSPSmn7Q=;
        b=UTePXVVp0dqot0WAoIMjF6HmWnbMW6nDBMrjFPk0Cjz8vW0EDyu86LLBZzbxbktFdoGTV1
        0sn461WOTed7aZBg==
To:     Daniel Wagner <wagi@monom.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        homas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: [PATCH RT 2/3] timers: Move clearing of base::timer_running under base:: Lock
Date:   Mon, 31 Oct 2022 16:50:05 +0100
Message-Id: <20221031155006.1651995-3-bigeasy@linutronix.de>
In-Reply-To: <20221031155006.1651995-1-bigeasy@linutronix.de>
References: <20221024105416.nflnrqhmzsyqqdzz@carbon.lan>
 <20221031155006.1651995-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Upstream commit bb7262b295472eb6858b5c49893954794027cd84

syzbot reported KCSAN data races vs. timer_base::timer_running being set to
NULL without holding base::lock in expire_timers().

This looks innocent and most reads are clearly not problematic, but
Frederic identified an issue which is:

 int data =3D 0;

 void timer_func(struct timer_list *t)
 {
    data =3D 1;
 }

 CPU 0                                            CPU 1
 ------------------------------                   --------------------------
 base =3D lock_timer_base(timer, &flags);           raw_spin_unlock(&base->=
lock);
 if (base->running_timer !=3D timer)                call_timer_fn(timer, fn=
, baseclk);
   ret =3D detach_if_pending(timer, base, true);    base->running_timer =3D=
 NULL;
 raw_spin_unlock_irqrestore(&base->lock, flags);  raw_spin_lock(&base->lock=
);

 x =3D data;

If the timer has previously executed on CPU 1 and then CPU 0 can observe
base->running_timer =3D=3D NULL and returns, assuming the timer has complet=
ed,
but it's not guaranteed on all architectures. The comment for
del_timer_sync() makes that guarantee. Moving the assignment under
base->lock prevents this.

For non-RT kernel it's performance wise completely irrelevant whether the
store happens before or after taking the lock. For an RT kernel moving the
store under the lock requires an extra unlock/lock pair in the case that
there is a waiter for the timer, but that's not the end of the world.

Reported-by: syzbot+aa7c2385d46c5eba0b89@syzkaller.appspotmail.com
Reported-by: syzbot+abea4558531bae1ba9fe@syzkaller.appspotmail.com
Fixes: 030dcdd197d7 ("timers: Prepare support for PREEMPT_RT")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/87lfea7gw8.fsf@nanos.tec.linutronix.de
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/timer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index b859ecf6424bd..603985720f547 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1282,8 +1282,10 @@ static inline void timer_base_unlock_expiry(struct t=
imer_base *base)
 static void timer_sync_wait_running(struct timer_base *base)
 {
 	if (atomic_read(&base->timer_waiters)) {
+		raw_spin_unlock_irq(&base->lock);
 		spin_unlock(&base->expiry_lock);
 		spin_lock(&base->expiry_lock);
+		raw_spin_lock_irq(&base->lock);
 	}
 }
=20
@@ -1458,14 +1460,14 @@ static void expire_timers(struct timer_base *base, =
struct hlist_head *head)
 		if (timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn);
-			base->running_timer =3D NULL;
 			raw_spin_lock(&base->lock);
+			base->running_timer =3D NULL;
 		} else {
 			raw_spin_unlock_irq(&base->lock);
 			call_timer_fn(timer, fn);
+			raw_spin_lock_irq(&base->lock);
 			base->running_timer =3D NULL;
 			timer_sync_wait_running(base);
-			raw_spin_lock_irq(&base->lock);
 		}
 	}
 }
--=20
2.37.2

