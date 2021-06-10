Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE15C48BD1
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Jun 2021 13:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA52613DE
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Jun 2021 13:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhFJNCB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230153AbhFJNCA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Jun 2021 09:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623330003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=I22vQVb/zbb8RGd4i8mqG/15RAizB0sQcCdNo+kxdtc=;
        b=CBICXaEtcDQn8URPluzX5B7JC9ypaaV+26L6tdmfJTl64FAoWnl96PaUrT4zBqJjuQ/r5p
        BahrAQwSsV6QWkQxO5cBCap7Nnb6ymYDoK6VW9stEr5dfbj0HavLFapUt9+CS+wksq6nRc
        Ewqb+GRqaAzd1SsnGenfQvgOC/WDOgM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-Od8WHfSqPuyIC5oXzjOrLg-1; Thu, 10 Jun 2021 09:00:01 -0400
X-MC-Unique: Od8WHfSqPuyIC5oXzjOrLg-1
Received: by mail-wr1-f70.google.com with SMTP id s8-20020adff8080000b0290114e1eeb8c6so843133wrp.23
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Jun 2021 06:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I22vQVb/zbb8RGd4i8mqG/15RAizB0sQcCdNo+kxdtc=;
        b=LXPwefgbkAYY1uP+v4uKF5yjHivbRHWO9/S93YiD8HXyBmo8m4tZbDhEzV/v2JT9Do
         dp09aH9qMzjoDIKQUGXEW9pyOjEJty3NaE5ujrdz1p47AabcYNj7ORklJFGHMSt3sIoY
         4COKfjKe29GR3FWQbhWFA0k4Tu7pJ8L+Hp4RY3JBy2mOpIDaVpoD8bIzPKoF3PvAA09v
         8S+dgNpdI45uQTqV/SasvzGkDrcuTN6W+7m1HyEy3IpzDpBOr6Wxz9eno9FqF+MA9OYs
         QJL+O3RLQ5cGsl3iSWfxEU0Ii+fNsnCrYe64gtK8pK7LOS0/ejqQTt8wmL2vlxUdwGil
         BJSg==
X-Gm-Message-State: AOAM532ugd+QUOdhW+so3V4QzeEXR0axBStpnZMZMK0tcV9f8Yw1aAI1
        xP97zzlM3YxHlovAC4kKk+kp0n9/6VNnZ7OfqpMlIODoJx02qZZuXdATMXRNGXIfvfm2AGLgudv
        Vqev/ZY7zlKMSmiPH6WhIS61BSMEDtVJlabRqUAIlSenFJLGTfetZ2Th7bsrFu4jSJ87BUGHgLV
        v23XE=
X-Received: by 2002:a05:6000:551:: with SMTP id b17mr5307538wrf.32.1623329999936;
        Thu, 10 Jun 2021 05:59:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBsh6Ss44tlc5bWZ2BoYoiZN6+SPxpSCaCiuL6HObk+t3x4HLarFcVoY+xaCbNIsdHHvXDNg==
X-Received: by 2002:a05:6000:551:: with SMTP id b17mr5307521wrf.32.1623329999770;
        Thu, 10 Jun 2021 05:59:59 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:3d14:2800:933d:abfc:d8e4:637f])
        by smtp.gmail.com with ESMTPSA id p6sm3623615wrf.51.2021.06.10.05.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 05:59:59 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-rt-users@vger.kernel.org, frederic@kernel.org
Cc:     tglx@linutronix.de, mtosatti@redhat.com,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [RFC 1/2] timers: Add pending timer bool in struct timer_base
Date:   Thu, 10 Jun 2021 14:59:44 +0200
Message-Id: <20210610125945.558872-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

We need to efficiently check whether a timer base has no pending events.
So introduce a new variable in struct timer_base to do so.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 kernel/time/timer.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4f7602724f9a..2d7d68296a3b 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -201,6 +201,7 @@ struct timer_base {
 #ifdef CONFIG_PREEMPT_RT
 	spinlock_t		expiry_lock;
 	atomic_t		timer_waiters;
+	bool			pending;
 #endif
 	unsigned long		clk;
 	unsigned long		next_expiry;
@@ -596,6 +597,9 @@ static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
 		 */
 		base->next_expiry = bucket_expiry;
 		base->next_expiry_recalc = false;
+#ifdef CONFIG_PREEMPT_RT
+		base->pending = true;
+#endif
 		trigger_dyntick_cpu(base, timer);
 	}
 }
@@ -1598,6 +1602,9 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 	}
 
 	base->next_expiry_recalc = false;
+#ifdef CONFIG_PREEMPT_RT
+	base->pending = (next != base->clk + NEXT_TIMER_MAX_DELTA);
+#endif
 
 	return next;
 }
@@ -1966,6 +1973,9 @@ int timers_prepare_cpu(unsigned int cpu)
 		base->clk = jiffies;
 		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
 		base->is_idle = false;
+#ifdef CONFIG_PREEMPT_RT
+		base->pending = false;
+#endif
 	}
 	return 0;
 }
-- 
2.31.1

