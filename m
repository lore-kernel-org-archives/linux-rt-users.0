Return-Path: <SRS0=ditW=EI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A164EC388F2
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Nov 2020 17:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E2AB20786
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Nov 2020 17:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfbBvsd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbgKBRBq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Nov 2020 12:01:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726613AbgKBRBq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Nov 2020 12:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604336505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IOeFBlogZX1FCLAK7gr3a7Wr+E+Qpm7NSyM2UbPYRcA=;
        b=KfbBvsd7ARr//kV8i/QOSbsT88roDjHtz+iEnXQ9S29+Soa5S/h18ldgtvP6uLVyqEnfF+
        coYVCLO3GFpyNQDTMWkT7L41ZSRgP4d3mz56hsT3ZMmbP/EYDFSUixUXHy6J8GonMBvfw9
        tZUxpsW/4dS4L1dtZbn9/BwRwhtefPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-NYQSgJUcM6WkjqJwSnW9kg-1; Mon, 02 Nov 2020 12:01:39 -0500
X-MC-Unique: NYQSgJUcM6WkjqJwSnW9kg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80A6B57053;
        Mon,  2 Nov 2020 17:01:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id 55B375B4D6;
        Mon,  2 Nov 2020 17:01:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  2 Nov 2020 18:01:37 +0100 (CET)
Date:   Mon, 2 Nov 2020 18:01:33 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexander Fyodorov <halcy@yandex.ru>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] ptrace: fix ptrace_unfreeze_traced() race with rt-lock
Message-ID: <20201102170132.GA32111@redhat.com>
References: <20201102155001.GA18313@redhat.com>
 <20201102162514.GA18631@redhat.com>
 <20201102163411.izhdlegaifq544l2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201102163411.izhdlegaifq544l2@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 11/02, Sebastian Andrzej Siewior wrote:
>
> On 2020-11-02 17:25:14 [+0100], Oleg Nesterov wrote:
> > On 11/02, Oleg Nesterov wrote:
> > >
> > >  	spin_lock_irq(&task->sighand->siglock);
> > > -	if (task->state == __TASK_TRACED) {
> > > -		if (__fatal_signal_pending(task))
> > > -			wake_up_state(task, __TASK_TRACED);
> > > -		else
> > > -			task->state = TASK_TRACED;
> > > -	}
> > > +
> > > +	raw_spin_lock(&task->pi_lock);
> >
> > but perhaps it should be raw_spin_lock_irq() ?
> >
> > I know nothing about kernel-rt, however it seems that spin_lock_irq()
> > from include/linux/spinlock_rt.h doesn't disable irqs?
>
> I don't exactly how much breaks when we turn siglock into a
> raw_spinlock_t but there is a memory allocation in __send_signal() which
> is a no no.
>
> There is task_is_traced() which looks under the PI lock for the task
> state to be sure (we a few of those). I haven't looked at the patch yet…

So it seems I should send V2 which uses raw_spin_(un)lock_irq().

Or even _irqsave() like ptrace_freeze_traced() does? Although this looks
confusing, exactly because ptrace_freeze_traced() calls task_is_traced()
which does raw_spin_lock_irq().

Oleg.

