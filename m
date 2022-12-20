Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0A5C4167B
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Dec 2022 19:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbiLTT2s (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Dec 2022 14:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiLTT2p (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Dec 2022 14:28:45 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292D518B04
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Dec 2022 11:28:44 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id n3so9173098pfq.10
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Dec 2022 11:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fw9L5PvlNhgs+JU2B0gJjvTGtwLaSX/j7LO3d6/4JY8=;
        b=Nipo4cnzMxjM1/fF09J/PrpMEG8avkMefOHZlj18R9gW0gTj1AZ8Qb0RyOCaNdG4p+
         CcHh7BjLg5GwE+bx0knNlcCJHM9gVqSifHrVkweaczs1u0db9nybsaqBYyzpPxxRsV0s
         SSWX3FFx9MrZQpdLTcyEDB9D1rRLIfMC7JH1tFi4u+g3LKfcDE/AyLT58EpcAlx47TVQ
         gQRzva+qOSHZydPP6K5D34lqFz5DPBN/fJuKSN4r93uFVNvBmjNN4lPPRIXgiyg7lWfR
         bk+jx84BDcqLvMwc7Dd3LmCJcEbG9VyM0+5E3uEcKZXdB2mTdV0Sb8bsj9WGLNaF4K68
         OOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fw9L5PvlNhgs+JU2B0gJjvTGtwLaSX/j7LO3d6/4JY8=;
        b=XZu0qstcOR1qT5nIKMLccQqRJ3NUCkRI7cwo1gSNcTWI6Fqhey92spDfnU3W3jnfW4
         nB34FNMhRYAoDxnIsrFphMoe+6XdR18YVlpfM5iOdWt/v+7mH0H9nZ6dpYEfsTodlxJw
         DirEq0lPcSayq61xoC0ZSr8kgR6mdlQRBFay6j3mb8PFv2gT1ugosSAqRTbzVpNH77YS
         RT5ea+rpns/wVPbvtaHMUw09Oe/PRO965vDrsg32UwS9QfJQnfMPBbh4RpTRaNU0jhVB
         l/fNI24mtNf+TUMGRP1ZyF83CrnA5ORjC3W62jF1zantyqO0hK68eVi4dLGIqLlwC+NO
         +5Tg==
X-Gm-Message-State: ANoB5pkQ60dK8VNc8nGyd8tcLIep7t8yKs1MIWswY9L98owNe/eDGz6C
        eK6hBKuySe5jeZOM1+5AGnWsCKJM3IXRl1R4BZrDWQ==
X-Google-Smtp-Source: AA0mqf6SVtpMM9XV/eQmt2Iqi2rbv60D+oVR221wTvytqK2tZLK4mXx1rTadFFKz5PuLWX6DJu+A7oUPDU6n26ly/dU=
X-Received: by 2002:a63:5a57:0:b0:478:ee2f:aad5 with SMTP id
 k23-20020a635a57000000b00478ee2faad5mr8671104pgm.545.1671564523605; Tue, 20
 Dec 2022 11:28:43 -0800 (PST)
MIME-Version: 1.0
References: <20221208075604.811710-1-junxiao.chang@intel.com>
 <BN9PR11MB5370BA8A506EB8519DC879C1ECEA9@BN9PR11MB5370.namprd11.prod.outlook.com>
 <Y6H4zqr8bObRFE1g@linutronix.de>
In-Reply-To: <Y6H4zqr8bObRFE1g@linutronix.de>
From:   Alison Chaiken <achaiken@aurora.tech>
Date:   Tue, 20 Dec 2022 11:28:32 -0800
Message-ID: <CAFzL-7t+Lq3ZJk90w=75yP++DbD1TGo16GRZkDzUNCyKpUH1TA@mail.gmail.com>
Subject: Re: [PATCH] softirq: wake up ktimer thread in softirq context
To:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Cc:     "Chang, Junxiao" <junxiao.chang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Peh, Hock Zhang" <hock.zhang.peh@intel.com>,
        Glenn Elliott <glenn@aurora.tech>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-12-20 10:44:07 [+0000], Chang, Junxiao wrote:
> > Any comment? This patch is for 6.1-rt, issue could be reproduced with 5.19-rt kernel as well.

On Tue, Dec 20, 2022 at 10:03 AM bigeasy@linutronix.de
<bigeasy@linutronix.de> wrote:
> Thanks for the ping. I did see the initial email and I didn't get to it
> yet. I need to re-test, confirm and then apply.
> The ktimer patch is not in v5.15 and this is currently the latest one
> maintained by the stable team. I don't know which one will be the
> following LTS kernel but this one needs to have this addressed. The
> v5.19 is not receiving any updates.

We backported the timersd patch to 5.15, where is where we have
observed the C-state transition despite pending timers.    The
reported trace sequence does show that __do_softirq() starts just
before the hrtimer_interrupt when the problem occurs:

When the timers are delayed, the trouble appears to begin when the
hrtimer_interrupt results in execution of hrtimer_run_queues() instead
of raise_hrtimer_softirq():
 <userspace>-13534   [007] 16947.069504: enqueue_hrtimer
          <idle>-0       [007] 16947.069547:
hrtimer_next_event_without: 16947.067643167
          <idle>-0       [007] 16947.069553: enqueue_hrtimer
          <idle>-0       [007] 16947.069567: enqueue_hrtimer
          <idle>-0       [007] 16947.069575:
hrtimer_next_event_without: 16947.067643167
          <idle>-0       [007] 16947.069579: enqueue_hrtimer
          <idle>-0       [007] 16947.078270: hrtimer_interrupt
          <idle>-0       [007] 16947.078278: hrtimer_run_queues.
          <idle>-0       [007] 16947.078300: enqueue_hrtimer
       ktimers/7-80      [007] 16947.078308: __do_softirq
     ksoftirqd/7-81      [007] 16947.078338: ksoftirqd_should_run 0
          <idle>-0       [007] 16947.078361:
hrtimer_next_event_without: 16947.067643167
          <idle>-0       [007] 16947.079323: hrtimer_interrupt
          <idle>-0       [007] 16947.079328: hrtimer_run_queues.
          <idle>-0       [007] 16947.079334: enqueue_hrtimer
     ksoftirqd/7-81      [007] 16947.079359: ksoftirqd_should_run 128
     ksoftirqd/7-81      [007] 16947.079360: __do_softirq
     ksoftirqd/7-81      [007] 16947.079361: hrtimer_interrupt
     ksoftirqd/7-81      [007] 16947.079361: raise_hrtimer_softirq.
     ksoftirqd/7-81      [007] 16947.079364: ksoftirqd_should_run 0
          <idle>-0       [007] 16947.079375:
hrtimer_next_event_without: 9223372036854775807
          <idle>-0       [007] 16947.079376:
tick_nohz_get_sleep_length: 86.838 ms
          <idle>-0       [007] 16947.079378: enqueue_hrtimer

Note the bogus value printed by hrtimer_next_event_without().

> Given the current timing, I will look into this in January.
>
> > Regards,
> > Junxiao
>
> Sebastian

-- Alison Chaiken
Aurora Innovation
