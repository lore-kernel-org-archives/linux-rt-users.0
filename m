Return-Path: <SRS0=UrLp=EJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB39C2D0A3
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Nov 2020 16:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FD62064C
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Nov 2020 16:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W8ExDg+V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ozu2f61X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgKCQpt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 Nov 2020 11:45:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43280 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbgKCQpt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Nov 2020 11:45:49 -0500
Date:   Tue, 3 Nov 2020 17:45:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604421947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cHozy6g5LYXQ08RrRgJQLNAo8l13nP3TaZlZgwSotpk=;
        b=W8ExDg+Vblrt8yH1pzCu2iJeV8QvJkE4hc1SwIWlPb9irenOOl+fBjpbq87sEfEEZCs/KX
        Sx8Y8pBr3eCvbA93NBn9QsY6Jt30tOHTNe5XioFHe1Vm6Gb2UtZo9vAFYSIsZq8MyUWVrY
        v3Px+xCKH+1hKfM+luj8Ywz8UL2UTIvdi2Cy0qzMaz0lhtM8l7erkVD0VFBarNfrLfEp8k
        wPPbFb6aD7gjq39IsIPTy74wgmDdnWnBHWr/qYnVAESmiByBFbPA3PnH1bWJi503+ulVqA
        P6dkRUKLH2ncw+lYvC/N0/uAw0KsbNdI+Lg013TiLBOV+AJjPOKCJV6j8i8a8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604421947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cHozy6g5LYXQ08RrRgJQLNAo8l13nP3TaZlZgwSotpk=;
        b=Ozu2f61XzUaiCOubLbvLCyNdM48bDv86oaMMkBmerVIJMgP0/lgst06S4EQln4LEDzltRo
        QmuBMc3rzZNpq/Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexander Fyodorov <halcy@yandex.ru>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] ptrace: fix ptrace_unfreeze_traced() race with rt-lock
Message-ID: <20201103164545.l3anns65zp2mxajz@linutronix.de>
References: <20201102155001.GA18313@redhat.com>
 <20201102174241.7llgokeh6cjzb7d3@linutronix.de>
 <20201103113748.GA23992@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201103113748.GA23992@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-11-03 12:37:49 [+0100], Oleg Nesterov wrote:
> On 11/02, Sebastian Andrzej Siewior wrote:
> >
> > On 2020-11-02 16:50:01 [+0100], Oleg Nesterov wrote:
> > >
> > >  static void ptrace_unfreeze_traced(struct task_struct *task)
> > >  {
> > > -	if (task->state != __TASK_TRACED)
> > > -		return;
> > > +	bool frozen = true;
> >
> > Is this okay for !PREEMPT_RT or is this considered as an important
> > fast-path on !PREEMPT_RT?
> 
> I do not know how can ptrace_unfreeze_traced() check both ->state and
> ->saved_state lockless.
> 
> If it is possible then task_is_traced() can avoid pi_lock too?

Now we can't. That lock is the only thing that guarantees consistent
state.

> OK, I'll send V2 in a minute.
> 
> > This `saved_state' is only used for RT so it might make sense to avoid
> > the PI-lock on non-RT.
> 
> The same is true for ptrace_freeze_traced(), we can probably add ifdef's
> but I am not sure this makes sense...

Okay. Then we keep it as it for now.

> Oleg.

Sebastian
