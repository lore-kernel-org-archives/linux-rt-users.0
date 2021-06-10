Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5537FC47094
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Jun 2021 13:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39AF9613F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Jun 2021 13:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhFJNCB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230312AbhFJNCB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Jun 2021 09:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623330004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z5uqP51uk3C11Cld3jXZFlBxREiwxRsplZrk/STOJXg=;
        b=B56C/dsokyzVjWMBPFg1zOclNULBai+6ylo2IVbMaNkylOz9rv6KNEMh+xsPtRywHfxPsX
        tOOYeh4xHxoGMdOg34eZkxviPH5OBK79rCT4Ukr+Wh7qN0lbEWTZfELAh0cxrhhGpKO/FK
        prpZ/wl/eljQ4MBe01HGmC0aYhdoBJg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-Wb_r3rZHOheIORUX8ZTTMQ-1; Thu, 10 Jun 2021 09:00:03 -0400
X-MC-Unique: Wb_r3rZHOheIORUX8ZTTMQ-1
Received: by mail-wr1-f69.google.com with SMTP id k25-20020a5d52590000b0290114dee5b660so858969wrc.16
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Jun 2021 06:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z5uqP51uk3C11Cld3jXZFlBxREiwxRsplZrk/STOJXg=;
        b=K6+zYKTZBgXusZtBquF5+cd4K9FbaVtoFWWZnfAK1ZbRGKnzWyoiA2AzwC/ytPvF55
         Ij13nNzmRPFx1iolMznM98xRKmrzZ0g5SqzOZrkTG5g5cNrgZzrzOf1f7ms8Gdx5JW29
         zZqK7ChMuW5GoDYPeaeLkw5rPZTlEkNdBNLEY32/+k5Zaso2Z8UsjQd+aHHqKYCBYJXy
         JQsy9bOYS9XFSHad7ACyMQ7tQ1PehRTCG9gF5KzpT5tHA9KbgnK3r15yuC3wLaSe+SYY
         pYF73BBmNhzObJD38VAScu/l0UsQmr1/JjGf+biGNOMKsbhWxGaBIxRCZBwLp5cRLUBL
         Y/Nw==
X-Gm-Message-State: AOAM5326yh9FNtv7nji74z09AXrffMfsPcAQCd4UWZqHDxe0gNzk01rt
        B1HzaWeGzELUHq8BWgbwxMVBRdD14Rs9hKAmR3SmH9kcvGLV6yZXJB+M6H5y2fSOuF1yNm9geLL
        F8Htc9bVAh4P24Q8XX1w//pHLu+ao1xWEbNfquGFscjTyll3xAZGwbxuHDd5kutUT6bgyBquZY4
        Z5mA4=
X-Received: by 2002:adf:e950:: with SMTP id m16mr5336490wrn.249.1623330000585;
        Thu, 10 Jun 2021 06:00:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweBHVzExV0YJcOlLzyXsneGWIyenn+jgP5CqAGPm0H+njULN5MpnLdao9JSc1ARDzKVwPbYw==
X-Received: by 2002:adf:e950:: with SMTP id m16mr5336471wrn.249.1623330000344;
        Thu, 10 Jun 2021 06:00:00 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:3d14:2800:933d:abfc:d8e4:637f])
        by smtp.gmail.com with ESMTPSA id p6sm3623615wrf.51.2021.06.10.05.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 06:00:00 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-rt-users@vger.kernel.org, frederic@kernel.org
Cc:     tglx@linutronix.de, mtosatti@redhat.com,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [RFC 2/2] timers: Make sure irq_work is handled when no pending timers
Date:   Thu, 10 Jun 2021 14:59:45 +0200
Message-Id: <20210610125945.558872-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610125945.558872-1-nsaenzju@redhat.com>
References: <20210610125945.558872-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

PREEMPT_RT systems defer most irq_work handling into the timer softirq.
This softirq is only triggered when a timer is expired, which adds some
delay to the irq_work handling. It's a price PREEMPT_RT systems are
willing to pay in exchange for less IRQ noise.

This works fine for the majority of systems, but there's a catch. What
if no timer is ever armed after an irq_work is queued. This has been
observed on nohz_full CPUs while running oslat. The lack of armed timers
prevents a pending irq_work to run. Which in turn prevents the nohz code
from fully stopping the tick.

To avoid this situation introduce new logic in run_local_timers(). The
timer softirq will be triggered when an irq_work is pending but no
timers have been armed. This situation is only possible in PREEMPT_RT
systems, so make the code conditional to it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---

NOTE: All in all, this is the best I could think of with my limited
      timers knowledge. A bigger hammer would be to unanimously trigger
      the softirq if irq_work_needs_cpu(). But I get the feeling this is
      something we want to avoid.

 kernel/time/timer.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 2d7d68296a3b..7611673cb172 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1771,6 +1771,28 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
 }
 
+#ifdef CONFIG_PREEMPT_RT
+static inline bool irq_work_needs_softirq(struct timer_base *base)
+{
+	/*
+	 * Neither bases have armed timers and an irq_work is pending. Since we
+	 * can't predict whether a timer will be armed in the future, request
+	 * the timer softirq to be triggered.
+	 */
+	if (!base->pending &&
+	    (IS_ENABLED(CONFIG_NO_HZ_COMMON) && !(base + 1)->pending) &&
+	    irq_work_needs_cpu())
+		return true;
+
+	return false;
+}
+#else
+static inline bool irq_work_needs_softirq(struct timer_base *base)
+{
+	return false;
+}
+#endif
+
 /*
  * Called by the local, per-CPU timer interrupt on SMP.
  */
@@ -1779,6 +1801,10 @@ static void run_local_timers(void)
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
 	hrtimer_run_queues();
+
+	if (irq_work_needs_softirq(base))
+		goto raise;
+
 	/* Raise the softirq only if required. */
 	if (time_before(jiffies, base->next_expiry)) {
 		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON))
@@ -1788,6 +1814,8 @@ static void run_local_timers(void)
 		if (time_before(jiffies, base->next_expiry))
 			return;
 	}
+
+raise:
 	raise_softirq(TIMER_SOFTIRQ);
 }
 
-- 
2.31.1

