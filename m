Return-Path: <SRS0=WTR/=7R=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3D9C433DF
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Jun 2020 20:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B495D2075B
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Jun 2020 20:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591303882;
	bh=YRLu2BNhuwpZ6SjE4TzntQ4u3Bgaxnd3eBiCxZcAUhU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=vLWUgyG+kITUkWn3R/xDffVXSaXHmIacOthjCTG5lvgtybTgB0oylkMf+J/7vl0FU
	 UBl8aAIgY3RIRxUTCeUTFsjbXlJkJX1NnEyPoFi2lEp2Sw31Kk9uZTPRd96/olT2bO
	 oiF3C3wpnnh3qtfNJGeW2lkvSVMHK6jVM3z3pIFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgFDUvS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:51:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729348AbgFDUvS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Jun 2020 16:51:18 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A1E0206C3;
        Thu,  4 Jun 2020 20:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591303876;
        bh=YRLu2BNhuwpZ6SjE4TzntQ4u3Bgaxnd3eBiCxZcAUhU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lkgQGNxTyVPf0362K+MAdALMAB5K4TvX2qFmR7Aim1cp8S2+zn77DIPq3tP7VKGy8
         54F5P3e2h3EewrchMmTbWcuXhlYBj9GR4Nc4j0lhhWfKTemHP8V9LbhzT4E7KxEo6Q
         dtuSQuTY6qZQYL2AIqKYrq8JppCCi0+9qF/wJxxA=
Message-ID: <b5026121af44601e4318479194357fdb956982f6.camel@kernel.org>
Subject: Re: [PATCH RT 1/2] tasklet: Address a race resulting in
 double-enqueue
From:   Tom Zanussi <zanussi@kernel.org>
To:     Ramon Fried <rfried.dev@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Zhang Xiao <xiao.zhang@windriver.com>
Date:   Thu, 04 Jun 2020 15:51:14 -0500
In-Reply-To: <CAGi-RUKn6k98H5v9kw7je1MChb4+Uq8EGhKO0nuXNMBy9M1_qw@mail.gmail.com>
References: <cover.1587675252.git.zanussi@kernel.org>
         <6d4c92b28c54d8ca687c29043562de943a373547.1587675252.git.zanussi@kernel.org>
         <CAGi-RUKn6k98H5v9kw7je1MChb4+Uq8EGhKO0nuXNMBy9M1_qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Ramon,

On Thu, 2020-06-04 at 19:04 +0300, Ramon Fried wrote:
> On Thu, Apr 23, 2020 at 11:55 PM <zanussi@kernel.org> wrote:
> > 
> > From: Zhang Xiao <xiao.zhang@windriver.com>
> > 
> > v4.19.115-rt49-rc1 stable review patch.
> > If anyone has any objections, please let me know.
> > 
> > -----------
> > 
> > 
> > The kernel bugzilla has the following race condition reported:
> > 
> > CPU0                    CPU1            CPU2
> > ------------------------------------------------
> > test_set SCHED
> >  test_set RUN
> >    if SCHED
> >     add_list
> >     raise
> >     clear RUN
> > <softirq>
> > test_set RUN
> > test_clear SCHED
> >  ->func
> >                         test_set SCHED
> > tasklet_try_unlock ->0
> > test_clear SCHED
> >                                         test_set SCHED
> >  ->func
> > tasklet_try_unlock ->1
> >                                         test_set RUN
> >                                         if SCHED
> >                                         add list
> >                                         raise
> >                                         clear RUN
> >                         test_set RUN
> >                         if SCHED
> >                          add list
> >                          raise
> >                          clear RUN
> > 
> > As a result the tasklet is enqueued on both CPUs and run on both
> > CPUs. Due
> > to the nature of the list used here, it is possible that further
> > (different) tasklets, which are enqueued after this double-enqueued
> > tasklet, are scheduled on CPU2 but invoked on CPU1. It is also
> > possible
> > that these tasklets won't be invoked at all, because during the
> > second
> > enqueue process the t->next pointer is set to NULL - dropping
> > everything
> > from the list.
> > 
> > This race will trigger one or two of the WARN_ON() in
> > tasklet_action_common().
> > The problem is that the tasklet may be invoked multiple times and
> > clear
> > SCHED bit on each invocation. This makes it possible to enqueue the
> > very same tasklet on different CPUs.
> > 
> > Current RT-devel is using the upstream implementation which does
> > not
> > re-run tasklets if they have SCHED set again and so it does not
> > clear
> > the SCHED bit multiple times on a single invocation.
> > 
> > Introduce the CHAINED flag. The tasklet will only be enqueued if
> > the
> > CHAINED flag has been set successfully.
> > If it is possible to exchange the flags (CHAINED | RUN) -> 0 then
> > the
> > tasklet won't be re-run. Otherwise the possible SCHED flag is
> > removed
> > and the tasklet is re-run again.
> > 
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=61451
> > Not-signed-off-by: Zhang Xiao <xiao.zhang@windriver.com>
> > [bigeasy: patch description]
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> > ---
> >  include/linux/interrupt.h | 5 ++++-
> >  kernel/softirq.c          | 6 +++++-
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> > index 97d9ba26915e..a3b5edb26bc5 100644
> > --- a/include/linux/interrupt.h
> > +++ b/include/linux/interrupt.h
> > @@ -579,12 +579,15 @@ enum
> >  {
> >         TASKLET_STATE_SCHED,    /* Tasklet is scheduled for
> > execution */
> >         TASKLET_STATE_RUN,      /* Tasklet is running (SMP only) */
> > -       TASKLET_STATE_PENDING   /* Tasklet is pending */
> > +       TASKLET_STATE_PENDING,  /* Tasklet is pending */
> > +       TASKLET_STATE_CHAINED   /* Tasklet is chained */
> >  };
> > 
> >  #define TASKLET_STATEF_SCHED   (1 << TASKLET_STATE_SCHED)
> >  #define TASKLET_STATEF_RUN     (1 << TASKLET_STATE_RUN)
> >  #define TASKLET_STATEF_PENDING (1 << TASKLET_STATE_PENDING)
> > +#define TASKLET_STATEF_CHAINED (1 << TASKLET_STATE_CHAINED)
> > +#define TASKLET_STATEF_RC      (TASKLET_STATEF_RUN |
> > TASKLET_STATEF_CHAINED)
> > 
> >  #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
> >  static inline int tasklet_trylock(struct tasklet_struct *t)
> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index 25bcf2f2714b..73dae64bfc9c 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -947,6 +947,10 @@ static void __tasklet_schedule_common(struct
> > tasklet_struct *t,
> >          * is locked before adding it to the list.
> >          */
> >         if (test_bit(TASKLET_STATE_SCHED, &t->state)) {
> > +               if (test_and_set_bit(TASKLET_STATE_CHAINED, &t-
> > >state)) {
> > +                       tasklet_unlock(t);
> > +                       return;
> > +               }
> >                 t->next = NULL;
> >                 *head->tail = t;
> >                 head->tail = &(t->next);
> > @@ -1040,7 +1044,7 @@ static void tasklet_action_common(struct
> > softirq_action *a,
> >  again:
> >                 t->func(t->data);
> > 
> > -               while (!tasklet_tryunlock(t)) {
> > +               while (cmpxchg(&t->state, TASKLET_STATEF_RC, 0) !=
> > TASKLET_STATEF_RC) {
> >                         /*
> >                          * If it got disabled meanwhile, bail out:
> >                          */
> > --
> > 2.17.1
> > 
> 
> Hi, This patch introduced a regression in our kernel
> (v4.19.124-rt53-rebase), It occurs when we're jumping to crush kernel
> using kexec, in the initialization of the emmc driver.
> I'm still debugging the root cause, but I thought of mentioning this
> in the mailing list if you have any idea why this could occur.
> The issue doesn't happen on normal boot, only when I specifically
> crash the kernel into the crash kernel.
> Thanks,
> Ramon.

I'm not very familiar with crashing the kernel into the crash kernel. 
Can you explain in enough detail how to set things up to reproduce this
and how to trigger it?  Does it happen every time? 

From looking at the backtrace, it's hitting the WARN_ON() in the
cmpxchg() loop below, because TASKLET_STATE is just
TASKLET_STATE_CHAINED.

It seems that the only way to turn off TASKLET_STATE_CHAINED is via
this cmpxchg(), but TASKLET_STATE_RUN can be independently turned off
elsewhere (tasklet_unlock() and tasklet_tryunlock()), so if that
happens and this loop is hit, you could loop until loops runs out and
hit this warning.

                while (cmpxchg(&t->state, TASKLET_STATEF_RC, 0) != TASKLET_STATEF_RC) {
                        /*                                                      
                         * If it got disabled meanwhile, bail out:              
                         */
                        if (atomic_read(&t->count))
                                goto out_disabled;
                        /*                                                      
                         * If it got scheduled meanwhile, re-execute            
                         * the tasklet function:                                
                         */
                        if (test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
                                goto again;
                        if (!--loops) {
                                printk("hm, tasklet state: %08lx\n", t->state);
                                WARN_ON(1);
                                tasklet_unlock(t);
                                break;
                        }
                }

But I don't know why it would happen just in this special case (crash
kernel, and what's different about that?) and not with a normal boot.

Thanks,

Tom

> 
> [    0.546142] macb 2b00000.eth1 eth1: Cadence GEM rev 0x00070200 at
> 0x02b00000 irq 16 (00:28:f8:b7:a0:40)
> [    0.548041] sdhci: Secure Digital Host Controller Interface driver
> [    0.548042] sdhci: Copyright(c) Pierre Ossman
> [    0.548044] sdhci-pltfm: SDHCI platform and OF driver helper
> [    0.580588] mmc0: SDHCI controller on 2200000.sdhci
> [2200000.sdhci]
> using ADMA 64-bit
> [    0.605753] hm, tasklet state: 00000008
> [    0.605757] ------------[ cut here ]------------
> [    0.605763] WARNING: CPU: 0 PID: 1 at ../kernel/softirq.c:1061
> 0xa80000080282649c
> [    0.605771] CPU: 0 PID: 1 Comm: swapper Not tainted
> 4.19.124.eyeq5_ssnt-local-rt53-07819-g3519e8cf4110 #4
> [    0.605774] Stack : 0000000000000000 0000000000000018
> a80000080340bd40 0000000002d40000
> [    0.605780]         a80000080340be70 0000000000000000
> 0000000000000000 000000000000007e
> [    0.605785]         0000000000000000 0000000000000001
> 0000000000000001 0000000002d30000
> [    0.605790]         0000000000000000 a800000802b2a688
> 0000000002d30000 0000000002d30000
> [    0.605795]         0000000000000000 0000000000000000
> a80000080282649c a800000802b6cf28
> [    0.605799]         0000000000000009 0000000000000425
> 0000000000000000 0000000000000007
> [    0.605804]         0000000002d30000 0000000002d30000
> 0000000000000000 a800000802d20000
> [    0.605809]         a800000803430000 a80000080340bd40
> a800000802d284c0 a80000080280a6c4
> [    0.605813]         0000000000000000 0000000000000000
> 0000000000000000 0000000000000000
> [    0.605818]         0000000000000000 a80000080280a6c8
> 0000000000000000 a800000802823b0c
> [    0.605823]         ...
> [    0.605825] Call Trace:
> [    0.605830] [<a800000802b2a688>] 0xa800000802b2a688
> [    0.605833] [<a80000080282649c>] 0xa80000080282649c
> [    0.605835] [<a80000080280a6c4>] 0xa80000080280a6c4
> [    0.605838] [<a80000080280a6c8>] 0xa80000080280a6c8
> [    0.605840] [<a800000802823b0c>] 0xa800000802823b0c
> [    0.605842] [<a80000080282649c>] 0xa80000080282649c
> [    0.605845] [<a800000802b30394>] 0xa800000802b30394
> [    0.605847] [<a8000008029cd2ec>] 0xa8000008029cd2ec
> [    0.605850] [<a800000802805490>] 0xa800000802805490
> [    0.605851]
> [    0.605854] ---[ end trace 293afee709e91e0b ]---
> [    0.607548] stn8500_serial 800000.uart: detected port #0
> [    0.607576] stn8500_serial 800000.uart: uartclk 125000000
> [    0.607605] 800000.uart: ttyST0 at MMIO 0x800000 (irq = 46,
> base_baud = 7812500) is a stn8500
> [    0.610303] stn8500_serial 900000.uart: detected port #1
> [    0.610324] stn8500_serial 900000.uart: uartclk 125000000
> [    0.611564] 900000.uart: ttyST1 at MMIO 0x900000 (irq = 46,
> base_baud = 7812500) is a stn8500
> [    0.614645] stn8500_serial a00000.uart: detected port #2
> [    0.614891] stn8500_serial a00000.uart: uartclk 125000000
> [    0.614919] a00000.uart: ttyST2 at MMIO 0xa00000 (irq = 46,
> base_baud = 7812500) is a stn8500
> [    0.614930] stn8500_serial a00000.uart: console setup on port #2 :
> uartclk 125000000 115207-n-8-n
> [    0.615943] console [ttyST2] enabled
> [    0.615945] bootconsole [stn8500] disabled
> [    0.620959] Freeing unused kernel memory: 1324K
> [    0.620965] This architecture does not have kernel memory
> protection.
> [    0.620967] Run /init as init process
> [    0.710641] random: dd: uninitialized urandom read (512 bytes
> read)

