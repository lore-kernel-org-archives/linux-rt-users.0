Return-Path: <SRS0=ditW=EI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F3BC00A89
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Nov 2020 18:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78FDF21D91
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Nov 2020 18:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cVo3BJKU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="99By+gzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgKBSE5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:04:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60382 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgKBSE4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Nov 2020 13:04:56 -0500
Date:   Mon, 2 Nov 2020 19:04:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604340294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8zxe2VpCl+4ulM95gT5m8YzcwkgDVFKpA0yZGoqeNQo=;
        b=cVo3BJKUHazeFdBR/BN8jHA9sylKi0chB5WAT20tIfDSpTcfh4Ol4mNoEyn6BpKVX+fU/R
        b8/C5eWNY8EnCgXb0Vq0PTOwnfqUzlvxw890gvDNool9/skmWTevStevQYg4OrGWBV/cdC
        J/9vOOd1D2ilj8RIf3NCBezLikE/Y1BS/te4tseOdmNjbm0fPOjugNZPbcbZMHnSRLDqzn
        bpFR31jTAukOjizqlMeFPkrzN2QtW1wxzwv50qJv6t3FnP1Qa71eebamqDxiErqZQDT6Tb
        yeqM7RqO3VYlAi2AoV1V2ng79QA0Eb3VHQsqf6snOgYQjPlme+ysdT8jhIsQtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604340294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8zxe2VpCl+4ulM95gT5m8YzcwkgDVFKpA0yZGoqeNQo=;
        b=99By+gzwOC4gm8jydVRMYhV2mLmSq6BkKFx4aNkhS0yr3PyW8aqnE7mHh4UfnhryU/eJIW
        JOqMWGoLL7/TDBDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexander Fyodorov <halcy@yandex.ru>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] ptrace: fix ptrace_unfreeze_traced() race with rt-lock
Message-ID: <20201102180453.zfifjmpbnsvacr54@linutronix.de>
References: <20201102155001.GA18313@redhat.com>
 <20201102162514.GA18631@redhat.com>
 <20201102163411.izhdlegaifq544l2@linutronix.de>
 <20201102170132.GA32111@redhat.com>
 <20201102173059.ib4au7ia5vyynn6l@linutronix.de>
 <20201102174130.GA18984@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102174130.GA18984@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-02 18:41:31 [+0100], Oleg Nesterov wrote:
> Sorry, I don't understand. If it was not clear, let me repeat that I know
> nothing about kernel-rt.

That is why I said, if you don't want to continue just complain and
leave it to me. Also, I could explain things if you want me to.

> On 11/02, Sebastian Andrzej Siewior wrote:
> > On 2020-11-02 18:01:33 [+0100], Oleg Nesterov wrote:
> >
> > > So it seems I should send V2 which uses raw_spin_(un)lock_irq().
> > >
> > > Or even _irqsave() like ptrace_freeze_traced() does? Although this looks
> > > confusing, exactly because ptrace_freeze_traced() calls task_is_traced()
> > > which does raw_spin_lock_irq().
> >
> > Urgh. Judging from
> >  release_task()
> >  -> write_lock_irq(&tasklist_lock);
> >  -> ptrace_release_task();
> >     -> ptrace_unlink();
> >        -> __ptrace_unlink();
> >          -> task_is_traced().
> >
> > it will break on !RT so irqsave is indeed needed.
> 
> Why?
> 
> task_is_traced() does raw_spin_lock_irq() under ifdef(CONFIG_PREEMPT_RT).

That is correct. So it is not broken after all.
So basically ptrace_freeze_traced() is okay but ptrace_unfreeze_traced()
needs the same treatment.

task_is_traced() acquires/drops the PI-lock and the inner of
ptrace_freeze_traced() does the same but needs to be done only for RT.

How much of that do find acceptable with your upstream hat on?

> Oleg.

Sebastian
