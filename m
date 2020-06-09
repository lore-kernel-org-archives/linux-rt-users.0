Return-Path: <SRS0=w7Cs=7W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A1EC433E0
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 20:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6920B20734
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 20:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591733390;
	bh=Z2/fnK9LL0DpVRZP9Cg5Sb7qxz/55TZUDxbsHUPmAOM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=fEuFKFrnnI9TJxwSQFR4WOUiF2IZpG2X/DEQcBUu0GM4uHgO/EE40YQb8zix4dn98
	 HQQoN8auvhj3JcZ3T/S36mNH35XTEuc1SsrG2utxDq8zaaszm5/4mASm9Bml6t1pz/
	 0LRP9husLgQoQWkK2mFdTBS3H39OgtbxgAGTASMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732949AbgFIUJq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731802AbgFIUJn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Jun 2020 16:09:43 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 285062072F;
        Tue,  9 Jun 2020 20:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591733383;
        bh=Z2/fnK9LL0DpVRZP9Cg5Sb7qxz/55TZUDxbsHUPmAOM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=e3C93VkpYaNPwLelHjMTqDdQLVW/JeMB2tgcHO+zlYIGFtkFzbw0u5RrYDZoUrBQB
         w1+dEcESNOxT8D6VyQCIppRzELKzThKQpSDVOFHDjsGqM4edfPld1fPBT/pft7Iwc5
         BlN9N0NCry9z8Vs6lE7dHCKkCIXjHwNcxfan7nuQ=
Message-ID: <b9bc5dd4d233cd42d34cf1d64a7228c0abb14c13.camel@kernel.org>
Subject: Re: [PATCH RT 1/2] tasklet: Address a race resulting in
 double-enqueue
From:   Tom Zanussi <zanussi@kernel.org>
To:     Ramon Fried <rfried.dev@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Zhang Xiao <xiao.zhang@windriver.com>
Date:   Tue, 09 Jun 2020 15:09:41 -0500
In-Reply-To: <CAGi-RUJ+JB972uv4DnNRNCxRyGrjP_nNNhbnZG6AyyW_ampbqw@mail.gmail.com>
References: <6d4c92b28c54d8ca687c29043562de943a373547.1587675252.git.zanussi@kernel.org>
         <CAGi-RUKn6k98H5v9kw7je1MChb4+Uq8EGhKO0nuXNMBy9M1_qw@mail.gmail.com>
         <b5026121af44601e4318479194357fdb956982f6.camel@kernel.org>
         <20200609154741.5kesuvl7txz4s3yu@linutronix.de>
         <e288ef193f743782df48667b6b03122bd025119f.camel@kernel.org>
         <20200609163446.efp76qbjzkbtl7nk@linutronix.de>
         <D6892A4E-18F7-4EB7-BA09-BD4DF9079BDE@gmail.com>
         <34E6C220-A85B-4296-AB8E-62DE6D9DC561@gmail.com>
         <20200609164213.bshzpfuqgioyvtpm@linutronix.de>
         <61D63A44-E3D9-4E7F-BE08-B887C078F445@gmail.com>
         <20200609171043.vhvms7lowffqm6e4@linutronix.de>
         <50AE5644-D046-4043-8A70-204D0BFEB67F@gmail.com>
         <aee4ed8bdd405c1e0e964fef6d57f410267aa25a.camel@kernel.org>
         <CAGi-RUJ+JB972uv4DnNRNCxRyGrjP_nNNhbnZG6AyyW_ampbqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2020-06-09 at 23:03 +0300, Ramon Fried wrote:
> On Tue, Jun 9, 2020 at 8:20 PM Tom Zanussi <zanussi@kernel.org>
> wrote:
> > 
> > Hi Ramon,
> > 
> > On Tue, 2020-06-09 at 20:14 +0300, Ramon Fried wrote:
> > > 
> > > On June 9, 2020 8:10:43 PM GMT+03:00, Sebastian Andrzej Siewior <
> > > bigeasy@linutronix.de> wrote:
> > > > On 2020-06-09 20:07:06 [+0300], Ramon Fried wrote:
> > > > > Indeed
> > > > >  I'm truly sorry, I thought our crash kernel is configured as
> > > > > RT
> > > > > as
> > > > 
> > > > well.
> > > > > so, as I understand, if I build the RT kernel without preempt
> > > > > enabled
> > > > 
> > > > I can hit this bug?
> > > > 
> > > > Don't worry, I should have been better with the details in the
> > > > log.
> > > > 
> > > > So you should _always_ hit the warning/bug if you compile a
> > > > kernel
> > > > without SMP and RT. If you enable one of these then everything
> > > > should
> > > > be
> > > > fine.
> > > 
> > > Would there be a fix for that?
> > 
> > I haven't tested the fix yet, but can you try the below patch and
> > see
> > if it fixes your broken case?
> > 
> > [PATCH] tasklet: Fix UP case for tasklet CHAINED state
> > 
> > commit 62d0a2a30cd0 (tasklet: Address a race resulting in
> > double-enqueue) addresses a problem that can result in a tasklet
> > being
> > enqueued on two cpus at the same time by combining the RUN flag
> > with a
> > new CHAINED flag, and relies on the combination to be present in
> > order
> > to zero it out, which can never happen on (!SMP and
> > !PREEMPT_RT_FULL)
> > because the RUN flag is SMP/PREEMPT_RT_FULL-only.
> > 
> > So make sure the above commit is only applied for the SMP ||
> > PREEMPT_RT_FULL case.
> > 
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> > ---
> >  kernel/softirq.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index 73dae64bfc9c..9bad7a16dc61 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -947,10 +947,12 @@ static void __tasklet_schedule_common(struct
> > tasklet_struct *t,
> >          * is locked before adding it to the list.
> >          */
> >         if (test_bit(TASKLET_STATE_SCHED, &t->state)) {
> > +#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
> >                 if (test_and_set_bit(TASKLET_STATE_CHAINED, &t-
> > >state))
> > {
> >                         tasklet_unlock(t);
> >                         return;
> >                 }
> > +#endif
> >                 t->next = NULL;
> >                 *head->tail = t;
> >                 head->tail = &(t->next);
> > @@ -1044,7 +1046,11 @@ static void tasklet_action_common(struct
> > softirq_action *a,
> >  again:
> >                 t->func(t->data);
> > 
> > +#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
> >                 while (cmpxchg(&t->state, TASKLET_STATEF_RC, 0) !=
> > TASKLET_STATEF_RC) {
> > +#else
> > +               while (!tasklet_tryunlock(t)) {
> > +#endif
> >                         /*
> >                          * If it got disabled meanwhile, bail out:
> >                          */
> > --
> > 2.17.1
> > 
> > 
> 
> Tested-By: Ramon Fried <rfried.dev@gmail.com>
> 
> Working, thanks a lot.

OK, great, thanks for testing and reporting this.

Tom

