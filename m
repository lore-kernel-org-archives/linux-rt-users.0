Return-Path: <SRS0=4xIy=WT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEFFC3A5A2
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 19:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C29122CEC
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 19:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391565AbfHWT2v (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Aug 2019 15:28:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbfHWT2v (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Aug 2019 15:28:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 225788AB25C;
        Fri, 23 Aug 2019 19:28:51 +0000 (UTC)
Received: from ovpn-117-150.phx2.redhat.com (ovpn-117-150.phx2.redhat.com [10.3.117.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82BF8600C1;
        Fri, 23 Aug 2019 19:28:47 +0000 (UTC)
Message-ID: <433936e4c720e6b81f9b297fefaa592fd8a961ad.camel@redhat.com>
Subject: Re: [PATCH RT v2 2/3] sched: migrate_enable: Use sleeping_lock to
 indicate involuntary sleep
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Date:   Fri, 23 Aug 2019 14:28:46 -0500
In-Reply-To: <20190823162024.47t7br6ecfclzgkw@linutronix.de>
References: <20190821231906.4224-1-swood@redhat.com>
         <20190821231906.4224-3-swood@redhat.com>
         <20190823162024.47t7br6ecfclzgkw@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Fri, 23 Aug 2019 19:28:51 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2019-08-23 at 18:20 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-08-21 18:19:05 [-0500], Scott Wood wrote:
> > Without this, rcu_note_context_switch() will complain if an RCU read
> > lock is held when migrate_enable() calls stop_one_cpu().
> > 
> > Signed-off-by: Scott Wood <swood@redhat.com>
> > ---
> > v2: Added comment.
> > 
> > If my migrate disable changes aren't taken, then pin_current_cpu()
> > will also need to use sleeping_lock_inc() because calling
> > __read_rt_lock() bypasses the usual place it's done.
> > 
> >  include/linux/sched.h    | 4 ++--
> >  kernel/rcu/tree_plugin.h | 2 +-
> >  kernel/sched/core.c      | 8 ++++++++
> >  3 files changed, 11 insertions(+), 3 deletions(-)
> > 
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7405,7 +7405,15 @@ void migrate_enable(void)
> >  			unpin_current_cpu();
> >  			preempt_lazy_enable();
> >  			preempt_enable();
> > +
> > +			/*
> > +			 * sleeping_lock_inc suppresses a debug check for
> > +			 * sleeping inside an RCU read side critical section
> > +			 */
> > +			sleeping_lock_inc();
> >  			stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
> > +			sleeping_lock_dec();
> 
> this looks like an ugly hack. This sleeping_lock_inc() is used where we
> actually hold a sleeping lock and schedule() which is okay. But this
> would mean we hold a RCU lock and schedule() anyway. Is that okay?

Perhaps the name should be changed, but the concept is the same -- RT-
specific sleeping which should be considered involuntary for the purpose of
debug checks.  Voluntary sleeping is not allowed in an RCU critical section
because it will break the critical section on certain flavors of RCU, but
that doesn't apply to the flavor used on RT.  Sleeping for a long time in an
RCU critical section would also be a bad thing, but that also doesn't apply
here.

-Scott


