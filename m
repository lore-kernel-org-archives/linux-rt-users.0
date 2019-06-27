Return-Path: <SRS0=/7Cv=U2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAD5C004E6
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Jun 2019 20:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B617B208E3
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Jun 2019 20:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfF0UQQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Jun 2019 16:16:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfF0UQQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Jun 2019 16:16:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B88C2308A953;
        Thu, 27 Jun 2019 20:16:13 +0000 (UTC)
Received: from ovpn-116-138.phx2.redhat.com (ovpn-116-138.phx2.redhat.com [10.3.116.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62A5D5C643;
        Thu, 27 Jun 2019 20:16:10 +0000 (UTC)
Message-ID: <5f4b1e594352ee776c4ccbe2760fee3a72345434.camel@redhat.com>
Subject: Re: [RFC PATCH RT 4/4] rcutorture: Avoid problematic critical
 section nesting
From:   Scott Wood <swood@redhat.com>
To:     paulmck@linux.ibm.com
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 27 Jun 2019 15:16:09 -0500
In-Reply-To: <20190627180007.GA27126@linux.ibm.com>
References: <20190619011908.25026-1-swood@redhat.com>
         <20190619011908.25026-5-swood@redhat.com>
         <20190620211826.GX26519@linux.ibm.com>
         <20190621163821.rm2rhsnvfo5tnjul@linutronix.de>
         <20190621235955.GK26519@linux.ibm.com>
         <20190626110847.2dfdf72c@gandalf.local.home>
         <8462f30720637ec0da377aa737d26d2cad424d36.camel@redhat.com>
         <20190627180007.GA27126@linux.ibm.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 27 Jun 2019 20:16:15 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2019-06-27 at 11:00 -0700, Paul E. McKenney wrote:
> On Wed, Jun 26, 2019 at 11:49:16AM -0500, Scott Wood wrote:
> > On Wed, 2019-06-26 at 11:08 -0400, Steven Rostedt wrote:
> > > On Fri, 21 Jun 2019 16:59:55 -0700
> > > "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> > > 
> > > > I have no objection to the outlawing of a number of these sequences
> > > > in
> > > > mainline, but am rather pointing out that until they really are
> > > > outlawed
> > > > and eliminated, rcutorture must continue to test them in mainline.
> > > > Of course, an rcutorture running in -rt should avoid testing things
> > > > that
> > > > break -rt, including these sequences.
> > > 
> > > We should update lockdep to complain about these sequences. That would
> > > "outlaw" them in mainline. That is, after we clean up all the current
> > > sequences in the code. And we also need to get Linus's approval of
> > > this
> > > as I believe he was against enforcing this in the past.
> > 
> > Was the opposition to prohibiting some specific sequence?  It's only
> > certain
> > misnesting scenarios that are problematic.  The rcu_read_lock/
> > local_irq_disable restriction can be dropped with the IPI-to-self added
> > in
> > Paul's tree.  Are there any known instances of the other two (besides
> > rcutorture)?
> 
> Given the failure scenario Sebastian Siewior reported today, there
> apparently are some, at least when running threaded interrupt handlers.

That's the rcu misnesting, which it looks like we can allow with the IPI-to-
self; I was asking about the other two.  I suppose if we really need to, we
could work around preempt_disable()/local_irq_disable()/preempt_enable()/
local_irq_enable() by having preempt_enable() do an IPI-to-self if
need_resched is set and IRQs are disabled.  The RT local_bh_disable()
atomic/non-atomic misnesting would be more difficult, but I don't think
impossible.  I've got lazy migrate disable working (initially as an attempt
to deal with misnesting but it turned out to give a huge speedup as well;
will send as soon as I take care of a loose end in the deadline scheduler);
it's possible that something similar could be done with the softirq lock
(and given that I saw a slowdown when that lock was introduced, it may also
be worth doing just for performance).

BTW, it's not clear to me whether the failure Sebastian saw was due to the
bare irq disabled version, which was what I was talking about prohibiting
(he didn't show the context that was interrupted).  The version where
preempt is disabled (with or without irqs being disabled inside the preempt
disabled region) definitely happens and is what I was trying to address with
patch 3/4.

-Scott


