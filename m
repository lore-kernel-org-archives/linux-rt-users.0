Return-Path: <SRS0=UrLp=EJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9FDC2D0A3
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Nov 2020 11:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16B2216C4
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Nov 2020 11:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODAH/K+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgKCLh7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 Nov 2020 06:37:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728512AbgKCLh7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Nov 2020 06:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604403477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2vIP5e0ifEcHU2LWKix5dpKLX0JnnHF8NJWqpXR4zio=;
        b=ODAH/K+PMHCsZS7qWdpTs9oUadEO1PNRteCCBEsl2pSVbraP5HhvX0hqzJ9cq7py1JSXYa
        rNShQvqqPbWteUzw6YXCWeRifz5wV9HcER7VfFZhYBsfCNZ5WFFgXieqrrG1ZdDVgDD7oe
        17dycdEt8EiHEdy71MzNg3LAwgvgPvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-df7isMlCMUa62MeR45LGXg-1; Tue, 03 Nov 2020 06:37:54 -0500
X-MC-Unique: df7isMlCMUa62MeR45LGXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16DC01009E27;
        Tue,  3 Nov 2020 11:37:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.6])
        by smtp.corp.redhat.com (Postfix) with SMTP id C81CE5B4B6;
        Tue,  3 Nov 2020 11:37:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  3 Nov 2020 12:37:52 +0100 (CET)
Date:   Tue, 3 Nov 2020 12:37:49 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexander Fyodorov <halcy@yandex.ru>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] ptrace: fix ptrace_unfreeze_traced() race with rt-lock
Message-ID: <20201103113748.GA23992@redhat.com>
References: <20201102155001.GA18313@redhat.com>
 <20201102174241.7llgokeh6cjzb7d3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102174241.7llgokeh6cjzb7d3@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 11/02, Sebastian Andrzej Siewior wrote:
>
> On 2020-11-02 16:50:01 [+0100], Oleg Nesterov wrote:
> >
> >  static void ptrace_unfreeze_traced(struct task_struct *task)
> >  {
> > -	if (task->state != __TASK_TRACED)
> > -		return;
> > +	bool frozen = true;
>
> Is this okay for !PREEMPT_RT or is this considered as an important
> fast-path on !PREEMPT_RT?

I do not know how can ptrace_unfreeze_traced() check both ->state and
->saved_state lockless.

If it is possible then task_is_traced() can avoid pi_lock too?

> >  	WARN_ON(!task->ptrace || task->parent != current);
> >
> > @@ -207,12 +206,19 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
> >  	 * Recheck state under the lock to close this race.
> >  	 */
> >  	spin_lock_irq(&task->sighand->siglock);
> > -	if (task->state == __TASK_TRACED) {
> > -		if (__fatal_signal_pending(task))
> > -			wake_up_state(task, __TASK_TRACED);
> > -		else
> > -			task->state = TASK_TRACED;
> > -	}
> > +
> > +	raw_spin_lock(&task->pi_lock);
>
> I think this got mentioned in the other emails but this requires irqsave
> because the above (siglock) does not disable interrupts on RT.

OK, I'll send V2 in a minute.

> This `saved_state' is only used for RT so it might make sense to avoid
> the PI-lock on non-RT.

The same is true for ptrace_freeze_traced(), we can probably add ifdef's
but I am not sure this makes sense...

Oleg.

