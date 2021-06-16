Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1C1C48BE8
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Jun 2021 07:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4940613B9
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Jun 2021 07:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhFPHTk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Jun 2021 03:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231652AbhFPHTe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Jun 2021 03:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623827848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lLZDycoV/qxz011Ton2G0ZYUPSbvpU9BHAMi71xG/DA=;
        b=f/W62D6+T4bj+XPdM/7NDLhfV982XvxOVJI0oimfVjZw379W0Xrna0Nzd1mUGsCJ3nCSWI
        H4ag+X/QHEAK2spMpq/ud48pbl1gOPs+fJ0z5epPOn7XHzrPhbgHf+YDS7uMUcGWZw6pC7
        JNl+N4H/HNTteM/0qmCXsVu9PcAo8BI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-8toe-KCCNGmlToMfbKd4lQ-1; Wed, 16 Jun 2021 03:17:27 -0400
X-MC-Unique: 8toe-KCCNGmlToMfbKd4lQ-1
Received: by mail-ed1-f71.google.com with SMTP id z16-20020aa7d4100000b029038feb83da57so518506edq.4
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Jun 2021 00:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLZDycoV/qxz011Ton2G0ZYUPSbvpU9BHAMi71xG/DA=;
        b=axZwOlTWXT+dsYsjLvSe4BDtG3etv9wGv6i30hsudWtHyhPzEXrprjuo7j3LaRFYn/
         aZbnvIon6Ub5Vl4UZKfQ3WpIE2UnHaxuH9Rudq5Q1rxBFhCFJayy2punRZoMPzIchlg5
         +Sk0zCypwQZ8FAiYTNG29zZn9lfyo7NhfBFbh0fx1cjnCyeCZEXV/rsDdbHaC/XRkoss
         l/y2IOju42s6cAd0pcfFtWEy0ONIM2vQv7tqs8ASiX4b/krLYyznqVB/HPvPlOx73Acs
         9w/HkTisA/V1Gghtl96PYLpSNVBkXL1H7cZnPpgFhAz62zWP3sZ/YL2P+j6w1E6rrv3j
         FDzw==
X-Gm-Message-State: AOAM5335AHSd7EPLju+kIlNQcTymrjy6OvGSwHAr054+QLeD297ftzQQ
        v9UYj6iTWo+yIJroJbEW0+fIGwMD3L9nX+ve+hZ8wu2fLogoBFRvk1z3zxzpWCO1yX54Zs5K6Ti
        dgYjG4zUNXOgeAffxVzRQ0s/dIss=
X-Received: by 2002:a05:6402:26c2:: with SMTP id x2mr2512747edd.124.1623827845928;
        Wed, 16 Jun 2021 00:17:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9t//qbp7oYBvXWmt1+a4qRPLp/Bn5SnTVKNGNemMf7kUuMZ1IfgjJi4BjjW8dyFn84FZupA==
X-Received: by 2002:a05:6402:26c2:: with SMTP id x2mr2512732edd.124.1623827845787;
        Wed, 16 Jun 2021 00:17:25 -0700 (PDT)
Received: from localhost.localdomain.hub ([151.29.48.4])
        by smtp.gmail.com with ESMTPSA id lu21sm968074ejb.31.2021.06.16.00.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 00:17:24 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     bigeasy@linutronix.de, tglx@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH RT v2 2/2] time/hrtimer: Embed hrtimer mode into hrtimer_sleeper
Date:   Wed, 16 Jun 2021 09:17:05 +0200
Message-Id: <20210616071705.166658-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616071705.166658-1-juri.lelli@redhat.com>
References: <20210616071705.166658-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Changes to hrtimer mode (potentially made by __hrtimer_init_sleeper() on
PREEMPT_RT are not visible to do_nanosleep(), and thus not accounted for
by hrtimer_start_expires() call path.

Embed hrtimer mode into hrtimer_sleeper struct, so that the same mode is
used by code following hrtimer_sleeper initialization.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/hrtimer.h |  1 +
 kernel/time/hrtimer.c   | 11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index bca9402a1030..7573823d91d9 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -138,6 +138,7 @@ struct hrtimer {
 struct hrtimer_sleeper {
 	struct hrtimer timer;
 	struct task_struct *task;
+	enum hrtimer_mode mode;
 };
 
 #ifdef CONFIG_64BIT
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f64954d5c8f8..badcfb6e19aa 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1848,6 +1848,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 	__hrtimer_init(&sl->timer, clock_id, mode);
 	sl->timer.function = hrtimer_wakeup;
 	sl->task = current;
+	sl->mode = mode;
 }
 
 /**
@@ -1884,19 +1885,19 @@ int nanosleep_copyout(struct restart_block *restart, struct timespec64 *ts)
 	return -ERESTART_RESTARTBLOCK;
 }
 
-static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mode)
+static int __sched do_nanosleep(struct hrtimer_sleeper *t)
 {
 	struct restart_block *restart;
 
 	do {
 		set_current_state(TASK_INTERRUPTIBLE);
-		hrtimer_sleeper_start_expires(t, mode);
+		hrtimer_sleeper_start_expires(t, t->mode);
 
 		if (likely(t->task))
 			freezable_schedule();
 
 		hrtimer_cancel(&t->timer);
-		mode = HRTIMER_MODE_ABS;
+		t->mode = HRTIMER_MODE_ABS;
 
 	} while (t->task && !signal_pending(current));
 
@@ -1927,7 +1928,7 @@ static long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
 	hrtimer_init_sleeper_on_stack(&t, restart->nanosleep.clockid,
 				      HRTIMER_MODE_ABS);
 	hrtimer_set_expires_tv64(&t.timer, restart->nanosleep.expires);
-	ret = do_nanosleep(&t, HRTIMER_MODE_ABS);
+	ret = do_nanosleep(&t);
 	destroy_hrtimer_on_stack(&t.timer);
 	return ret;
 }
@@ -1946,7 +1947,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
 	hrtimer_set_expires_range_ns(&t.timer, rqtp, slack);
-	ret = do_nanosleep(&t, mode);
+	ret = do_nanosleep(&t);
 	if (ret != -ERESTART_RESTARTBLOCK)
 		goto out;
 
-- 
2.31.1

