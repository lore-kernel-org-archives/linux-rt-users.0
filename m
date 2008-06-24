From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] sched: enable interrupts and drop rq-lock
	duringnewidle balancing
Date: Tue, 24 Jun 2008 14:24:59 +0200
Message-ID: <1214310299.4351.27.camel@twins>
References: <20080623225645.31515.36393.stgit@lsg.lsg.lab.novell.com>
	 <20080623230440.31515.97377.stgit@lsg.lsg.lab.novell.com>
	 <1214302405.4351.21.camel@twins>  <4860BB14.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, rostedt@goodmis.org, tglx@linutronix.de,
	David Bahi <DBahi@novell.com>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:46844 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbYFXMZR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Jun 2008 08:25:17 -0400
In-Reply-To: <4860BB14.BA47.005A.0@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2008-06-24 at 07:15 -0600, Gregory Haskins wrote:
> >>> On Tue, Jun 24, 2008 at  6:13 AM, in message <1214302405.4351.21.camel@twins>,
> Peter Zijlstra <peterz@infradead.org> wrote: 
> > On Mon, 2008-06-23 at 17:04 -0600, Gregory Haskins wrote:
> >> We do find_busiest_groups() et. al. without locks held for normal balancing,
> >> so lets do it for newidle as well.  It will allow other cpus to make
> >> forward progress (against our RQ) while we try to balance and allow 
> >> some interrupts to occur.
> > 
> > Is running f_b_g really that expensive? 
> 
> According to our oprofile data, yes.  I speculate that it works out that way because most newidle
> attempts result in "no imbalance".  But we were spending ~60%+ time in find_busiest_groups()
> because of all the heavy-context switching that goes on in PREEMPT_RT.  So while f_b_g() is
> probably cheaper than double-lock/move_tasks(), the ratio of occurrence is off the charts in
> comparison. Prior to this patch, those occurrences were preempt-disabled/irq-disabled/rq->lock critical
> sections.
> 
> So while it is not clear if f_b_g() is the actual cost, it is a convenient (and legal, afaict) place to
> deterministically reduce the rq->lock scope.  Additionally, doing so measurably helps
> performance, so I think its a win.  Without this patch you have to hope the double_lock releases
> this_rq, and even so were not checking for the NEEDS_RESCHED. 

See, having had this information in the changelog to begin with would
have helped ;-)



