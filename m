Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0257C11F65
	for <linux-rt-users@archiver.kernel.org>; Wed, 30 Jun 2021 17:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C491B6147E
	for <linux-rt-users@archiver.kernel.org>; Wed, 30 Jun 2021 17:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhF3Rqc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 30 Jun 2021 13:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhF3Rqb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 30 Jun 2021 13:46:31 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ABBC061756
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Jun 2021 10:44:02 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p15so6317308ybe.6
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Jun 2021 10:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kM5uu7n1YsQZ08tF+iIDBBWafMEeJEVgJ/QHVdlCYQc=;
        b=djLh0mYadK/XBFHwIP0yRqMbfdB/8mXgVsipSfHKNXglBhIDHOdNOGwFbypMF/wfL8
         ElkEJzKuqZ1MMXZ6+UpEp62v3Prrchf1DrZN057GvZeh4KjKZWcB2UR3I3FmAX9uTsHL
         orbwqft1SL5Zr8osWpRZv/ARk0Fr+OccK6EMiq1czwQPgSW/JyFW32efj9e5TfeOWwr/
         i5HDXQnpueWZqOHfR6mfcML+ngCMRFWCqQY1IkANo2MEAsZcN5YfO4ELgFsgUoVG5jWF
         tV4xHC8F8ys9pM++wlBABATH47pMDBkxcT/BuIa91WUJzVp+UoG0jjkbUciszj4iGULc
         T/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kM5uu7n1YsQZ08tF+iIDBBWafMEeJEVgJ/QHVdlCYQc=;
        b=kzWB9Dc4hmdG3KmNLO9LpxV+gqVEYy2FPsIlNgvHRB1Fq717noDhS5fHSiBY2SgE6z
         EN5cSexx0MQMIj0GfY8Tnf3xx5FjQb8uvkRfbS7wVwB6cFjnsv/bCXCylAo9ebjkNaSX
         0EHEnaBxMICLlCVBklhuO/WlF0QnmqDecpV7PK/vh5pbt9pV77gwG9bQylMZSplZTQn+
         IFII8oecgw69QFhkAzUgRwxJGbbAvT1CjFhh3bRnW+tVrVL+qhWz7j0/sDMB/HROQfQ1
         yA15fu76RbMW9sIgRvfSH163zKviY4S+iJTz5QbLOQDnqyq7RX90eetaZ3uLqaOwaJaS
         ncsQ==
X-Gm-Message-State: AOAM531CY8+p0mmcZ9PNbAVppAzOH2nAcgXSTMCKKx6GLyWofOd1C/wj
        GpJa3GNWREmeCVdhrGqxxVm6sw781//41ao81/uykE5f/5oROMOI
X-Google-Smtp-Source: ABdhPJxbQs2jjCluwglaZGseTAFYI8WMeM+hZ5jpb4CijU1hAwRhe7i5vZenaxR1lqlVH1nMQUBSazzxCu+vUPleARM=
X-Received: by 2002:a25:8093:: with SMTP id n19mr49330181ybk.414.1625075041836;
 Wed, 30 Jun 2021 10:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210610125945.558872-1-nsaenzju@redhat.com> <20210610125945.558872-2-nsaenzju@redhat.com>
In-Reply-To: <20210610125945.558872-2-nsaenzju@redhat.com>
From:   Alison Chaiken <achaiken@aurora.tech>
Date:   Wed, 30 Jun 2021 10:43:50 -0700
Message-ID: <CAFzL-7vZTxQst-wZCUsp289gMqtMNar4woXoYQC2wN+ssypbRQ@mail.gmail.com>
Subject: Re: [RFC 2/2] timers: Make sure irq_work is handled when no pending timers
To:     nsaenzju@redhat.com
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        frederic@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        mtosatti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jun 10, 2021 at 6:00 AM Nicolas Saenz Julienne
<nsaenzju@redhat.com> wrote:
> PREEMPT_RT systems defer most irq_work handling into the timer softirq.
> This softirq is only triggered when a timer is expired, which adds some
> delay to the irq_work handling. It's a price PREEMPT_RT systems are
> willing to pay in exchange for less IRQ noise.
>
> This works fine for the majority of systems, but there's a catch. What
> if no timer is ever armed after an irq_work is queued. This has been
> observed on nohz_full CPUs while running oslat. The lack of armed timers
> prevents a pending irq_work to run. Which in turn prevents the nohz code
> from fully stopping the tick.

In https://lore.kernel.org/linux-rt-users/162093721042.5649.1489711837264906533.git-patchwork-notify@kernel.org/T/#u,
Jakub Kicinski noted:
> Another thing while I have your attention - ____napi_schedule() does
> __raise_softirq_irqoff() which AFAIU does not wake the ksoftirq thread.
> On non-RT we get occasional NOHZ warnings when drivers schedule napi
> from process context, but on RT this is even more of a problem, right?
> ksoftirqd won't run until something else actually wakes it up?

It seems to me that Nicolas Saenz Julienne's solution which raises the
TIMER softirq might result in the same problem, as doing so might not
wake ksoftirqd and result in local_softirq_pending but for TIMER
rather than NET_RX.   Is this correct?

Why NET_RX softirq shows up as 08 in local_softirq_pending is itself a
bit unclear.     It appears to derive from __ARCH_IRQ_STAT, which
means that 08 is NET_RX on x86_64 but perhaps not on other processors.
  Is this correct?   The naive expectation that the number printed by
the message is in keeping with softirq_to_name[] is any event
obviously wrong.

Thanks,
Alison Chaiken
Aurora Innovation
