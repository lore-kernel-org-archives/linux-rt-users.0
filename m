Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3B3C433FE
	for <linux-rt-users@archiver.kernel.org>; Sun,  6 Nov 2022 19:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiKFTSD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 6 Nov 2022 14:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKFTSC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 6 Nov 2022 14:18:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0757EB86F
        for <linux-rt-users@vger.kernel.org>; Sun,  6 Nov 2022 11:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667762181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qn5y3u3/A/UxINn8Ja/EbGQ0rxaYx0gZzHYxr6g0Ods=;
        b=BnbHTX8GOFWJjQ2QQSlmdlHnP9iWR+/dpuxlbjTMU5sy+Pgap6cnsVABFYzu2gySLStVvp
        HTdZYD+/jr7IMyezKrC+yEZWlofvRvdPJmC8C+9GeusSsW7hy70NGq5gMElg+Pw3VXD5WG
        6wZmBVpgRDMjEuynxUs6+aRU+NoY/9I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-Ulfwq2NcNyOd4U1KotidTQ-1; Sun, 06 Nov 2022 14:16:18 -0500
X-MC-Unique: Ulfwq2NcNyOd4U1KotidTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96ACA8001B8;
        Sun,  6 Nov 2022 19:16:17 +0000 (UTC)
Received: from localhost (unknown [10.22.32.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A1F3140EBF3;
        Sun,  6 Nov 2022 19:16:17 +0000 (UTC)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Mark Gross <markgross@kernel.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 2/4] timers: Move clearing of base::timer_running under base:: Lock
Date:   Sun,  6 Nov 2022 16:16:10 -0300
Message-Id: <20221106191612.21730-3-lgoncalv@redhat.com>
In-Reply-To: <20221106191612.21730-1-lgoncalv@redhat.com>
References: <20221106191612.21730-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

v4.14.298-rt141-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Upstream commit bb7262b295472eb6858b5c49893954794027cd84

syzbot reported KCSAN data races vs. timer_base::timer_running being set to
NULL without holding base::lock in expire_timers().

This looks innocent and most reads are clearly not problematic, but
Frederic identified an issue which is:

 int data = 0;

 void timer_func(struct timer_list *t)
 {
    data = 1;
 }

 CPU 0                                            CPU 1
 ------------------------------                   --------------------------
 base = lock_timer_base(timer, &flags);           raw_spin_unlock(&base->lock);
 if (base->running_timer != timer)                call_timer_fn(timer, fn, baseclk);
   ret = detach_if_pending(timer, base, true);    base->running_timer = NULL;
 raw_spin_unlock_irqrestore(&base->lock, flags);  raw_spin_lock(&base->lock);

 x = data;

If the timer has previously executed on CPU 1 and then CPU 0 can observe
base->running_timer == NULL and returns, assuming the timer has completed,
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
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 kernel/time/timer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 316cac30366f..c112f5edfc5a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1233,8 +1233,10 @@ static inline void timer_base_unlock_expiry(struct timer_base *base)
 static void timer_sync_wait_running(struct timer_base *base)
 {
 	if (atomic_read(&base->timer_waiters)) {
+		raw_spin_unlock_irq(&base->lock);
 		spin_unlock(&base->expiry_lock);
 		spin_lock(&base->expiry_lock);
+		raw_spin_lock_irq(&base->lock);
 	}
 }
 
@@ -1413,14 +1415,14 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 		    timer->flags & TIMER_IRQSAFE) {
 			raw_spin_unlock(&base->lock);
 			call_timer_fn(timer, fn, data);
-			base->running_timer = NULL;
 			raw_spin_lock(&base->lock);
+			base->running_timer = NULL;
 		} else {
 			raw_spin_unlock_irq(&base->lock);
 			call_timer_fn(timer, fn, data);
+			raw_spin_lock_irq(&base->lock);
 			base->running_timer = NULL;
 			timer_sync_wait_running(base);
-			raw_spin_lock_irq(&base->lock);
 		}
 	}
 }
-- 
2.38.1

