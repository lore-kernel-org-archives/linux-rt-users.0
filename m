Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B6BC433FE
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Dec 2020 18:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4508723106
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Dec 2020 18:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390678AbgLKQzh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Dec 2020 11:55:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36370 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgLKQyv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Dec 2020 11:54:51 -0500
Date:   Fri, 11 Dec 2020 17:54:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607705649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=wqiJZ+SPDQ20wuyDH/db+MsQd86+dZyfcNIEWC10y9Y=;
        b=0Rwy6z06TLrVWRIvt3S0lNcf+ZLfJq3myHUsPdVw0+cWzoBpiAgXL2RRlQIKJLCg+B9Bkk
        t9xvZRGw+Y/959AFrvcsplTG/vEo12Eeynrgx8GLzPpIMOrjB9iwg01FCQIhoL14ubCMTd
        nBDQBGmS/AmlP5mkBQz7it0rZwj1AJ8AyTZlKd7/y8NHujUMhs6Uir9qQmoLePIACG8CpM
        ahaApgFtOiRf8jM9huR5Ws2af3buakvUptr4lfYTTCCIKBg4Mlt8VwssK3eTSx5hKvvdT9
        /NK+FrEG/Hd5tV0H5j4ouWwliSrpwlfnE40fjFysOMEkHgRUXmUL3Yt1DbOaMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607705649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=wqiJZ+SPDQ20wuyDH/db+MsQd86+dZyfcNIEWC10y9Y=;
        b=Ibi/Ab93EYBAik4yyUSpkf3g4oPM5OAYJz3WSC7DS+HVEa4qmGUS0Al1ICdoz8bDRr+ejn
        XnXqeeV65l3WiFAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.10-rc7-rt16
Message-ID: <20201211165407.bzrgqnz7tftqti2v@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.10-rc7-rt16 patch set. 

Changes since v5.10-rc7-rt15:

  - Drop hrtimer-Allow-raw-wakeups-during-boot.patch. It is not needed
    since another change came in.

  - Assign timer_base::timer_running with base::lock held. Reported by
    syzbot, patched by Thomas Gleixner.

Known issues
     - None.

The delta patch against v5.10-rc7-rt15 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10-rc7-rt15-rt16.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.10-rc7-rt16

The RT patch against v5.10-rc7 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10-rc7-rt16.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-5.10-rc7-rt16.tar.xz

Sebastian

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b8111d3e7d68f..02f43f663ad5a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1823,7 +1823,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 	 * expiry.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-		if ((task_is_realtime(current) && !(mode & HRTIMER_MODE_SOFT)) || system_state != SYSTEM_RUNNING)
+		if (task_is_realtime(current) && !(mode & HRTIMER_MODE_SOFT))
 			mode |= HRTIMER_MODE_HARD;
 	}
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 7c4ac329711b4..b6477db234e6a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1263,8 +1263,10 @@ static inline void timer_base_unlock_expiry(struct timer_base *base)
 static void timer_sync_wait_running(struct timer_base *base)
 {
 	if (atomic_read(&base->timer_waiters)) {
+		raw_spin_unlock_irq(&base->lock);
 		spin_unlock(&base->expiry_lock);
 		spin_lock(&base->expiry_lock);
+		raw_spin_lock_irq(&base->lock);
 	}
 }
 
@@ -1455,14 +1457,14 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 		if (timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, baseclk);
-			base->running_timer = NULL;
 			raw_spin_lock(&base->lock);
+			base->running_timer = NULL;
 		} else {
 			raw_spin_unlock_irq(&base->lock);
 			call_timer_fn(timer, fn, baseclk);
+			raw_spin_lock_irq(&base->lock);
 			base->running_timer = NULL;
 			timer_sync_wait_running(base);
-			raw_spin_lock_irq(&base->lock);
 		}
 	}
 }
diff --git a/localversion-rt b/localversion-rt
index 18777ec0c27d4..1199ebade17b4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt15
+-rt16
