Return-Path: <SRS0=wj13=XW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37E9C4360C
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Sep 2019 16:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B3421841
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Sep 2019 16:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfI0Qkc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Sep 2019 12:40:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfI0Qkb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Sep 2019 12:40:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6C6B190C01F;
        Fri, 27 Sep 2019 16:40:30 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD20110013A7;
        Fri, 27 Sep 2019 16:40:25 +0000 (UTC)
Message-ID: <9a4cc499e6de4690c682c03c0c880363fe3c9307.camel@redhat.com>
Subject: Re: [PATCH RT 5/8] sched/deadline: Reclaim cpuset bandwidth in
 .migrate_task_rq()
From:   Scott Wood <swood@redhat.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Fri, 27 Sep 2019 11:40:25 -0500
In-Reply-To: <20190927081141.GB31660@localhost.localdomain>
References: <20190727055638.20443-1-swood@redhat.com>
         <20190727055638.20443-6-swood@redhat.com>
         <20190927081141.GB31660@localhost.localdomain>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Fri, 27 Sep 2019 16:40:31 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2019-09-27 at 10:11 +0200, Juri Lelli wrote:
> Hi Scott,
> 
> On 27/07/19 00:56, Scott Wood wrote:
> > With the changes to migrate disabling, ->set_cpus_allowed() no longer
> > gets deferred until migrate_enable().  To avoid releasing the bandwidth
> > while the task may still be executing on the old CPU, move the
> > subtraction
> > to ->migrate_task_rq().
> > 
> > Signed-off-by: Scott Wood <swood@redhat.com>
> > ---
> >  kernel/sched/deadline.c | 67 +++++++++++++++++++++++-------------------
> > -------
> >  1 file changed, 31 insertions(+), 36 deletions(-)
> > 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index c18be51f7608..2f18d0cf1b56 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1606,14 +1606,42 @@ static void yield_task_dl(struct rq *rq)
> >  	return cpu;
> >  }
> >  
> > +static void free_old_cpuset_bw_dl(struct rq *rq, struct task_struct *p)
> > +{
> > +	struct root_domain *src_rd = rq->rd;
> > +
> > +	/*
> > +	 * Migrating a SCHED_DEADLINE task between exclusive
> > +	 * cpusets (different root_domains) entails a bandwidth
> > +	 * update. We already made space for us in the destination
> > +	 * domain (see cpuset_can_attach()).
> > +	 */
> > +	if (!cpumask_intersects(src_rd->span, p->cpus_ptr)) {
> > +		struct dl_bw *src_dl_b;
> > +
> > +		src_dl_b = dl_bw_of(cpu_of(rq));
> > +		/*
> > +		 * We now free resources of the root_domain we are migrating
> > +		 * off. In the worst case, sched_setattr() may temporary
> > fail
> > +		 * until we complete the update.
> > +		 */
> > +		raw_spin_lock(&src_dl_b->lock);
> > +		__dl_sub(src_dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
> > +		raw_spin_unlock(&src_dl_b->lock);
> > +	}
> > +}
> > +
> >  static void migrate_task_rq_dl(struct task_struct *p, int new_cpu
> > __maybe_unused)
> >  {
> >  	struct rq *rq;
> >  
> > -	if (p->state != TASK_WAKING)
> > +	rq = task_rq(p);
> > +
> > +	if (p->state != TASK_WAKING) {
> > +		free_old_cpuset_bw_dl(rq, p);
> 
> What happens if a DEADLINE task is moved between cpusets while it was
> sleeping? Don't we miss removing from the old cpuset if the task gets
> migrated on wakeup?

In that case set_task_cpu() is called by ttwu after setting state to
TASK_WAKING.  I guess it could be annoying if the task doesn't wake up for a
long time and therefore doesn't release the bandwidth until then.

-Scott


