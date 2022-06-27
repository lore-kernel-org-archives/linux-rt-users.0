Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3946C43334
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Jun 2022 09:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbiF0JvR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Jun 2022 05:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbiF0JvQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Jun 2022 05:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47AF36337
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Jun 2022 02:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656323474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ODcJ6zydXCy0RZ8g5fZRHZR+hlMipts1TZGkhFsZ1LY=;
        b=MbdD3LdQEdvi74VvdPkm8Ch9uIHisXGyrr9JhKOG0YJyahnbm+QYZpS4aeTMOT9mt7ten1
        OnAgoQcNXeGyy8rg90jORnjUgyfe3V7Mfi/pyNqZjG0HKD+Y3XOtYa2N3S65e6Cf0F3FC4
        s5VpQqNG6SX2fLFMxfDEGEcgdVPCFxw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-c2eIgeO9PEW3q5v7hp47tA-1; Mon, 27 Jun 2022 05:51:13 -0400
X-MC-Unique: c2eIgeO9PEW3q5v7hp47tA-1
Received: by mail-qk1-f197.google.com with SMTP id bi36-20020a05620a31a400b006a79f0706e5so9618852qkb.2
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Jun 2022 02:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODcJ6zydXCy0RZ8g5fZRHZR+hlMipts1TZGkhFsZ1LY=;
        b=8GujteaemwoRNJ2lUv+bx8h8+vYvVN4zyDw80oWzI2IdYjjYPA0RB5KIDurI06UiIv
         LiJpts9bz4/9r3D5jReeSlzuhWsvUSTQ6rSg5qMEW/LSQehl4LwGoFAOEHm069QqfXSF
         8QDfu6J3HUJekLM/QhKa8ztglQq6fFHk+VpzsAseKRkcVJCEtsfHezhy+5csdfiFQw8Z
         Yar8KuQB+d/oeepjgdOiqeFTZNA3wWgZyzcR8f4u3AzAnj0XtzQlJyiFgNemtWLeqHRC
         nWyLCjmQHk1+caiYRAhZdOWu7dJR9ugj7tgFVRIBNHObhoJ+j/fNxqoGJP1Ab0v/f9p7
         JdCA==
X-Gm-Message-State: AJIora/HvL59KYLGwLHippqXnxHUFy1Rxmha6K+I/4kvWjnxCxVjmP7g
        iagm6VbUXR+ovSZJhbJbE49X2XYyZByIu93wPl6H8nG0ou2qzmvtqdf96XwyRwJsTyTcAMcTf3B
        sFb7sF4+rV+0pUfa7zqfPWPvCnTc=
X-Received: by 2002:a05:622a:1992:b0:319:cb47:b3a4 with SMTP id u18-20020a05622a199200b00319cb47b3a4mr3868105qtc.472.1656323472742;
        Mon, 27 Jun 2022 02:51:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vstaH0LIoUtcaZsCgkerz4macwKXsk/gMfm6Al+4zrfGHkmD/MM84XZGxlVYeWOoxVFH6+bA==
X-Received: by 2002:a05:622a:1992:b0:319:cb47:b3a4 with SMTP id u18-20020a05622a199200b00319cb47b3a4mr3868086qtc.472.1656323472424;
        Mon, 27 Jun 2022 02:51:12 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.54.194])
        by smtp.gmail.com with ESMTPSA id p11-20020a05622a00cb00b00316d7f9ebaesm7262444qtw.3.2022.06.27.02.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:51:11 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] linux/wait: Fix __wait_event_hrtimeout for RT/DL tasks
Date:   Mon, 27 Jun 2022 11:50:51 +0200
Message-Id: <20220627095051.42470-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Changes to hrtimer mode (potentially made by __hrtimer_init_sleeper on
PREEMPT_RT) are not visible to hrtimer_start_range_ns, thus not
accounted for by hrtimer_start_expires call paths. In particular,
__wait_event_hrtimeout suffers from this problem as we have, for
example:

fs/aio.c::read_events
  wait_event_interruptible_hrtimeout
    __wait_event_hrtimeout
      hrtimer_init_sleeper_on_stack <- this might "mode |= HRTIMER_MODE_HARD"
                                       on RT if task runs at RT/DL priority
        hrtimer_start_range_ns
          WARN_ON_ONCE(!(mode & HRTIMER_MODE_HARD) ^ !timer->is_hard)
          fires since the latter doesn't see the change of mode done by
          init_sleeper

Fix it by making __wait_event_hrtimeout call hrtimer_sleeper_start_expires,
which is aware of the special RT/DL case, instead of hrtimer_start_range_ns.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

---
This is a continuation of discussion happened at
https://lore.kernel.org/lkml/YqnygxNWOztakt8+@localhost.localdomain/
"[RT] WARNING at hrtimer_start_range_ns"
---
 include/linux/wait.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 851e07da2583..58cfbf81447c 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -544,10 +544,11 @@ do {										\
 										\
 	hrtimer_init_sleeper_on_stack(&__t, CLOCK_MONOTONIC,			\
 				      HRTIMER_MODE_REL);			\
-	if ((timeout) != KTIME_MAX)						\
-		hrtimer_start_range_ns(&__t.timer, timeout,			\
-				       current->timer_slack_ns,			\
-				       HRTIMER_MODE_REL);			\
+	if ((timeout) != KTIME_MAX) {						\
+		hrtimer_set_expires_range_ns(&__t.timer, timeout,		\
+					current->timer_slack_ns);		\
+		hrtimer_sleeper_start_expires(&__t, HRTIMER_MODE_REL);		\
+	}									\
 										\
 	__ret = ___wait_event(wq_head, condition, state, 0, 0,			\
 		if (!__t.task) {						\
-- 
2.36.1

