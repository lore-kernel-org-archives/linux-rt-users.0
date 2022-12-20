Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A042C4332F
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Dec 2022 17:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiLTRLW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Dec 2022 12:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiLTRK7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Dec 2022 12:10:59 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4912DC5
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Dec 2022 09:10:57 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o12so13029255pjo.4
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Dec 2022 09:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRFWK6w5Cy23e8XWT1rWbDLN91A4EEYHoS5gC9uHUWw=;
        b=byb0eseT4pcRW7S1BedH8qClZpIZ/t1ewezDb5xRPr2nNpYMyTy7+iiI819WXurMX9
         9xv2F5V8ypRxyfEHgBkAC5bKHMb5v7MNGLZ+0pzO8ZYD8/BnQLcypHHj9+tqdHyVUkJY
         LUkx7dQJKfaRr1cHjB9EVB5TTv2igixjA78VN7hDpweg/AeHGxEXq7XkmtT+nop/9hIN
         OFuv2GXqlGcR1/FE18gKxF12JDHQVlVT+ImihF/4a4CILJtg4Y7QaWeRb+et/42zjhus
         0HHPTXnPGVUP5/3cX5WyUiIvZX9gQd3CxEt6+tcAw9QrdoMMK6Jr7CHOeCLv7ix7UJcL
         bxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRFWK6w5Cy23e8XWT1rWbDLN91A4EEYHoS5gC9uHUWw=;
        b=jUn4+QLSr7p69HSc8DUgZ3X8pmtYi1bdWdmL2AokF4nid0jVTakDiUEuarEspc4kBi
         Xi6VARt7JJ15ow3kCHJCFm3DcJkXUX/qKGhi0xuyVUSAMFQ1pggmpFjZpGgA+Pk5PwP+
         CYQJfA0aED4kKDYrTawM2Xd+9CvbaMQF3XLgzy223e+h/8Md4sr/d9K7RQVGyESZCmVy
         YT0eW/ncMvMNPsq1nWeSvam0U/uCZBhv1nhvz+vVatXRUe+gaUEkCvwa+GiDyIPbN4R4
         ESrcfSSDAJEeQQB8QZsc+I69YGwO7l8/hz9V4akDl6STYtQT25y7STD2tISTipjvLlIB
         PZiw==
X-Gm-Message-State: AFqh2koS42APJE1By0EsFtsH+pgW8OYwuh8FG+wNTVzrlVA60wVJJ+/R
        GphZRFyLiYjzxEcPbdTk1lyw7Dymzlc3ruw9n0BScQ==
X-Google-Smtp-Source: AMrXdXsALyFNjPlFG4yf3lODzR8YQRjaaupV8Exb4GUM16lEM67mrUbJLzgTaW82cCAQqC1FoplqXzbCU+2Xwheo+Hg=
X-Received: by 2002:a17:90b:17d0:b0:219:d33d:4689 with SMTP id
 me16-20020a17090b17d000b00219d33d4689mr2035693pjb.233.1671556256903; Tue, 20
 Dec 2022 09:10:56 -0800 (PST)
MIME-Version: 1.0
References: <20221208075604.811710-1-junxiao.chang@intel.com> <BN9PR11MB5370BA8A506EB8519DC879C1ECEA9@BN9PR11MB5370.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5370BA8A506EB8519DC879C1ECEA9@BN9PR11MB5370.namprd11.prod.outlook.com>
From:   Alison Chaiken <achaiken@aurora.tech>
Date:   Tue, 20 Dec 2022 09:10:45 -0800
Message-ID: <CAFzL-7t4AxR-8j6_JP-MQPOqw-tjq6Ds5MTgy4bgRUCK7Ga8bQ@mail.gmail.com>
Subject: Re: [PATCH] softirq: wake up ktimer thread in softirq context
To:     "Chang, Junxiao" <junxiao.chang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Peh, Hock Zhang" <hock.zhang.peh@intel.com>,
        Glenn Elliott <glenn@aurora.tech>,
        Rami Jaber <rjaber@aurora.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Dec 20, 2022 at 2:44 AM Chang, Junxiao <junxiao.chang@intel.com> wr=
ote:
> Any comment? This patch is for 6.1-rt, issue could be reproduced with 5.1=
9-rt kernel as well.

In

https://lore.kernel.org/linux-rt-users/CAFzL-7v-NSFKAsyhxReEES7bMomSTwYyrZs=
cnjbkydEP3CTXmQ@mail.gmail.com/

we reported an occasional problem with an x86 system entering a deep C
state even though timers were pending.   Perhaps your patch would
prevent this transition.

> This issue is easier to reproduced when there is heavy network workload w=
hich introduces a lot of softirq events. If hrtimer interrupt is triggered =
in softirq context, with current RT kernel, it will not wake up ktimers thr=
ead which handles hrtimer event because in function __irq_exit_rcu, "in_int=
errupt()" is true:
>
> static inline void __irq_exit_rcu(void)
> {
> ...
>         preempt_count_sub(HARDIRQ_OFFSET);
>         if (!in_interrupt()) {
>                 if (local_softirq_pending())
>                         invoke_softirq();
>
>                 if (IS_ENABLED(CONFIG_PREEMPT_RT) && local_pending_timers=
())
>                         wake_timersd();
>         }
> ...
> }
>

Isn't removing the check for IS_ENABLED(CONFIG_PREEMPT_RT) inadvisable?

> Then ktimers threads stays in sleep state, hrtimer function will not be c=
alled although hrtimer interrupt has been triggered. Ktimers thread might b=
e woken up in next timer interrupt which introduces long delay.
>
> Any comments are welcome.
>
> Regards,
> Junxiao

-- Alison Chaiken
Aurora Innovation


 -----Original Message-----
> From: Chang, Junxiao <junxiao.chang@intel.com>
> Sent: Thursday, December 8, 2022 3:56 PM
> To: linux-kernel@vger.kernel.org
> Cc: linux-rt-users@vger.kernel.org; bigeasy@linutronix.de; tglx@linutroni=
x.de; rostedt@goodmis.org; Chang, Junxiao <junxiao.chang@intel.com>; Peh, H=
ock Zhang <hock.zhang.peh@intel.com>
> Subject: [PATCH] softirq: wake up ktimer thread in softirq context
>
> Occiaionally timer interrupt might be triggered in softirq context, ktime=
r thread should be woken up with RT kernel, or else ktimer thread might sta=
y in sleep state although timer interrupt has been triggered.
>
> This change fixes a latency issue that timer handler is delayed for more =
than 4ms in network related test.
>
> Fixes: 2165d27554e8 ("softirq: Use a dedicated thread for timer wakeups."=
)
> Reported-by: Peh, Hock Zhang <hock.zhang.peh@intel.com>
> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
> ---
>  kernel/softirq.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/softirq.c b/kernel/softirq.c index ab1fe34326bab..34a=
e39e4a3d10 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -664,13 +664,10 @@ static inline void __irq_exit_rcu(void)  #endif
>         account_hardirq_exit(current);
>         preempt_count_sub(HARDIRQ_OFFSET);
> -       if (!in_interrupt()) {
> -               if (local_softirq_pending())
> -                       invoke_softirq();
> -
> -               if (IS_ENABLED(CONFIG_PREEMPT_RT) && local_pending_timers=
())
> -                       wake_timersd();
> -       }
> +       if (!in_interrupt() && local_softirq_pending())
> +               invoke_softirq();
> +       if (!(in_nmi() || in_hardirq()) && local_pending_timers())
> +               wake_timersd();
>
>         tick_irq_exit();
>  }
> --
> 2.25.1
>
