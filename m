Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BB5C4CEC9
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 17:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518EE20862
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 17:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbfIQRG0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 13:06:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57223 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbfIQRG0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 13:06:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05D29C08E2A2;
        Tue, 17 Sep 2019 17:06:26 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B189A5D9D5;
        Tue, 17 Sep 2019 17:06:08 +0000 (UTC)
Message-ID: <0af37d2ec77e3a3c2d8ba5adbe9aab4170dc13e4.camel@redhat.com>
Subject: Re: [PATCH RT 8/8] sched: Lazy migrate_disable processing
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Tue, 17 Sep 2019 12:06:08 -0500
In-Reply-To: <20190917165026.pv3neijrpxrszdzo@linutronix.de>
References: <20190727055638.20443-1-swood@redhat.com>
         <20190727055638.20443-9-swood@redhat.com>
         <20190917165026.pv3neijrpxrszdzo@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 17 Sep 2019 17:06:26 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2019-09-17 at 18:50 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-07-27 00:56:38 [-0500], Scott Wood wrote:
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 885a195dfbe0..0096acf1a692 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -939,17 +893,34 @@ static int takedown_cpu(unsigned int cpu)
> >  	 */
> >  	irq_lock_sparse();
> >  
> > -#ifdef CONFIG_PREEMPT_RT_FULL
> > -	__write_rt_lock(cpuhp_pin);
> > +#ifdef CONFIG_PREEMPT_RT_BASE
> > +	WARN_ON_ONCE(takedown_cpu_task);
> > +	takedown_cpu_task = current;
> > +
> > +again:
> > +	for (;;) {
> > +		int nr_pinned;
> > +
> > +		set_current_state(TASK_UNINTERRUPTIBLE);
> > +		nr_pinned = cpu_nr_pinned(cpu);
> > +		if (nr_pinned == 0)
> > +			break;
> > +		schedule();
> > +	}
> 
> we used to have cpuhp_pin which ensured that once we own the write lock
> there will be no more tasks that can enter a migrate_disable() section
> on this CPU. It has been placed fairly late to ensure that nothing new
> comes in as part of the shutdown process and that it flushes everything
> out that is still in a migrate_disable() section.
> Now you claim that once the counter reached zero it never increments
> again. I would be happier if there was an explicit check for that :)

I don't claim that.  A check is added in take_cpu_down() to see whether it
went back up, and if so, exit with EAGAIN.  If *that* check succeeds, it
can't go back up because it's in stop machine, and any tasks will get
migrated to another CPU before they can run again.  There's also a WARN in
migrate_tasks() if somehow a migrate-disabled task does get encountered.

> There is no back off and flush mechanism which means on a busy CPU (as
> in heavily lock contended by multiple tasks) this will wait until the
> CPU gets idle again.

Not really any different from the reader-biased rwlock that this replaces...

-Scott


