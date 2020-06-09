Return-Path: <SRS0=w7Cs=7W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973C4C433DF
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 20:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6823D2076A
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 20:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uAiroSBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbgFIUDd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgFIUDc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Jun 2020 16:03:32 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DFBC05BD1E;
        Tue,  9 Jun 2020 13:03:31 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id v3so15421oot.1;
        Tue, 09 Jun 2020 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pt0DPLBpPkPb8xYKYcZPNtFaSRjSBZPXqgtNpIMmDh0=;
        b=uAiroSBv1gLnKdbZUEyupBr7lgsYb7M/vRhN2cfhjUKvRDBDE/zmbEA9xBTI1iuoAW
         X6g314P0frYFreZ2U1Vewsjxalb2kCF8CnTqxxRh5yBqrER1VAyxOWRsXPBxMqDEbNtW
         7xPO/ggNfcr80yQPFPlaeGVBCgg5HfZWljeGrWm66EnOVDbe5MCYJUamTAB+85mh8EV4
         e0uQhnECuDBsPL6+iw1UJCKguOXLChw8EF5IwuIZfM92CGsfK+ySg7itmbzqO/RHuxDa
         MsO4CIsyxYesXRwgQrf4jTo1AT3cK1qNpc7lGcE7zAw9HegXos08/OZLX6z2Qjm9sCXA
         YzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pt0DPLBpPkPb8xYKYcZPNtFaSRjSBZPXqgtNpIMmDh0=;
        b=Yj/sGhsJRB3GejTFTbT3v+/TIVa436N0f7CmaXlL1JD5YUhxeXUR4SP3mwbt5LHFO6
         1xWCk6BChym9nCZCCVe3W5jpA0fjv4EiVwrwdlxqSfifSPfardqVG4oQcX6EdxCgYGrp
         70jzoWIhv80bTNUiIbqH3T25eD9geD9kBzRlLLUSMGKijTeKGoBcwbwvzPwR8uH/WG9M
         +ihnhBKC40nQAUpN4l4cb8pJhnN+Y1aufWx2C73f+neFIHqgtikrsBsr4Dca725VdaRR
         oZfrvIl3UAUjhYsAn/WtsQt4gImC6g2Z0kaxPuL6y3kU1gg1271q+Q1M4WbzKcAiKzUL
         gCZA==
X-Gm-Message-State: AOAM532jzKIEJRmfn6H8t9Vdladp1R7L6qKO1ZL2FF+4DzFj0R1pMZsG
        68u22lyssHwpDo00+zimc8Bw9Sp1tSyuXCczhdI=
X-Google-Smtp-Source: ABdhPJwvRWOKzbf+DKVU8juNuXBGC7MEAwHZMPL+F9ZVDiWOBRsus8puDwqu5SfEy378bJmVu8/EiR20yZkdUXHvy9E=
X-Received: by 2002:a4a:6c0d:: with SMTP id q13mr5977631ooc.50.1591733010983;
 Tue, 09 Jun 2020 13:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <6d4c92b28c54d8ca687c29043562de943a373547.1587675252.git.zanussi@kernel.org>
 <CAGi-RUKn6k98H5v9kw7je1MChb4+Uq8EGhKO0nuXNMBy9M1_qw@mail.gmail.com>
 <b5026121af44601e4318479194357fdb956982f6.camel@kernel.org>
 <20200609154741.5kesuvl7txz4s3yu@linutronix.de> <e288ef193f743782df48667b6b03122bd025119f.camel@kernel.org>
 <20200609163446.efp76qbjzkbtl7nk@linutronix.de> <D6892A4E-18F7-4EB7-BA09-BD4DF9079BDE@gmail.com>
 <34E6C220-A85B-4296-AB8E-62DE6D9DC561@gmail.com> <20200609164213.bshzpfuqgioyvtpm@linutronix.de>
 <61D63A44-E3D9-4E7F-BE08-B887C078F445@gmail.com> <20200609171043.vhvms7lowffqm6e4@linutronix.de>
 <50AE5644-D046-4043-8A70-204D0BFEB67F@gmail.com> <aee4ed8bdd405c1e0e964fef6d57f410267aa25a.camel@kernel.org>
In-Reply-To: <aee4ed8bdd405c1e0e964fef6d57f410267aa25a.camel@kernel.org>
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Tue, 9 Jun 2020 23:03:19 +0300
Message-ID: <CAGi-RUJ+JB972uv4DnNRNCxRyGrjP_nNNhbnZG6AyyW_ampbqw@mail.gmail.com>
Subject: Re: [PATCH RT 1/2] tasklet: Address a race resulting in double-enqueue
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Zhang Xiao <xiao.zhang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jun 9, 2020 at 8:20 PM Tom Zanussi <zanussi@kernel.org> wrote:
>
> Hi Ramon,
>
> On Tue, 2020-06-09 at 20:14 +0300, Ramon Fried wrote:
> >
> > On June 9, 2020 8:10:43 PM GMT+03:00, Sebastian Andrzej Siewior <
> > bigeasy@linutronix.de> wrote:
> > > On 2020-06-09 20:07:06 [+0300], Ramon Fried wrote:
> > > > Indeed
> > > >  I'm truly sorry, I thought our crash kernel is configured as RT
> > > > as
> > >
> > > well.
> > > > so, as I understand, if I build the RT kernel without preempt
> > > > enabled
> > >
> > > I can hit this bug?
> > >
> > > Don't worry, I should have been better with the details in the log.
> > >
> > > So you should _always_ hit the warning/bug if you compile a kernel
> > > without SMP and RT. If you enable one of these then everything
> > > should
> > > be
> > > fine.
> >
> > Would there be a fix for that?
>
> I haven't tested the fix yet, but can you try the below patch and see
> if it fixes your broken case?
>
> [PATCH] tasklet: Fix UP case for tasklet CHAINED state
>
> commit 62d0a2a30cd0 (tasklet: Address a race resulting in
> double-enqueue) addresses a problem that can result in a tasklet being
> enqueued on two cpus at the same time by combining the RUN flag with a
> new CHAINED flag, and relies on the combination to be present in order
> to zero it out, which can never happen on (!SMP and !PREEMPT_RT_FULL)
> because the RUN flag is SMP/PREEMPT_RT_FULL-only.
>
> So make sure the above commit is only applied for the SMP ||
> PREEMPT_RT_FULL case.
>
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/softirq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 73dae64bfc9c..9bad7a16dc61 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -947,10 +947,12 @@ static void __tasklet_schedule_common(struct
> tasklet_struct *t,
>          * is locked before adding it to the list.
>          */
>         if (test_bit(TASKLET_STATE_SCHED, &t->state)) {
> +#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
>                 if (test_and_set_bit(TASKLET_STATE_CHAINED, &t->state))
> {
>                         tasklet_unlock(t);
>                         return;
>                 }
> +#endif
>                 t->next = NULL;
>                 *head->tail = t;
>                 head->tail = &(t->next);
> @@ -1044,7 +1046,11 @@ static void tasklet_action_common(struct
> softirq_action *a,
>  again:
>                 t->func(t->data);
>
> +#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
>                 while (cmpxchg(&t->state, TASKLET_STATEF_RC, 0) !=
> TASKLET_STATEF_RC) {
> +#else
> +               while (!tasklet_tryunlock(t)) {
> +#endif
>                         /*
>                          * If it got disabled meanwhile, bail out:
>                          */
> --
> 2.17.1
>
>
Tested-By: Ramon Fried <rfried.dev@gmail.com>

Working, thanks a lot.
