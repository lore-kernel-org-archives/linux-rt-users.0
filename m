Return-Path: <SRS0=kQBB=2D=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA09C43603
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Dec 2019 08:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D2C22527
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Dec 2019 08:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfLMIOc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:14:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47565 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfLMIOc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Dec 2019 03:14:32 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ifg5k-0006op-LD; Fri, 13 Dec 2019 09:14:28 +0100
Date:   Fri, 13 Dec 2019 09:14:28 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT] sched: migrate_enable: Busy loop until the migration
 request is completed
Message-ID: <20191213081428.mw6bqjg6m7djwhby@linutronix.de>
References: <20191212112717.2tzoqbe3xeknoyvs@linutronix.de>
 <30ab713901ef0e1f23c1ca387373788a4a73639f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <30ab713901ef0e1f23c1ca387373788a4a73639f.camel@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-12-13 00:44:22 [-0600], Scott Wood wrote:
> > @@ -8239,7 +8239,10 @@ void migrate_enable(void)
> >  		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
> >  				    &arg, &work);
> >  		__schedule(true);
> > -		WARN_ON_ONCE(!arg.done && !work.disabled);
> > +		if (!work.disabled) {
> > +			while (!arg.done)
> > +				cpu_relax();
> > +		}
> 
> We should enable preemption while spinning -- besides the general badness
> of spinning with it disabled, there could be deadlock scenarios if
> multiple CPUs are spinning in such a loop.  Long term maybe have a way to
> dequeue the no-longer-needed work instead of waiting.

Hmm. My plan was to use per-CPU memory and spin before the request is
enqueued if the previous isn't done yet (which should not happen™).
Then we could remove __schedule() here and rely on preempt_enable()
doing that. With that change we wouldn't care about migrate-disable
level vs preempt-disable level and could drop the hacks we have in futex
code for instance (where we have an extra migrate_disable() in advance
so they are later balanced). 

> -Scott

Sebastian
