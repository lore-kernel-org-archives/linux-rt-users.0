Return-Path: <SRS0=OCyy=U3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C24C4321A
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jun 2019 19:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC70B20828
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jun 2019 19:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfF1Th3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Jun 2019 15:37:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfF1Th3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Jun 2019 15:37:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C89477E426;
        Fri, 28 Jun 2019 19:37:28 +0000 (UTC)
Received: from ovpn-116-138.phx2.redhat.com (ovpn-116-138.phx2.redhat.com [10.3.116.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D68360BEC;
        Fri, 28 Jun 2019 19:37:25 +0000 (UTC)
Message-ID: <6787428b6647a228b4259968ac3d2ea89b10628a.camel@redhat.com>
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
Date:   Fri, 28 Jun 2019 14:37:24 -0500
In-Reply-To: <20190628005257.GM26519@linux.ibm.com>
References: <20190619011908.25026-5-swood@redhat.com>
         <20190620211826.GX26519@linux.ibm.com>
         <20190621163821.rm2rhsnvfo5tnjul@linutronix.de>
         <20190621235955.GK26519@linux.ibm.com>
         <20190626110847.2dfdf72c@gandalf.local.home>
         <8462f30720637ec0da377aa737d26d2cad424d36.camel@redhat.com>
         <20190627180007.GA27126@linux.ibm.com>
         <5f4b1e594352ee776c4ccbe2760fee3a72345434.camel@redhat.com>
         <20190627205051.GE26519@linux.ibm.com>
         <4dc801b715baae4a87043fed20f682409446bb09.camel@redhat.com>
         <20190628005257.GM26519@linux.ibm.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 28 Jun 2019 19:37:28 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2019-06-27 at 17:52 -0700, Paul E. McKenney wrote:
> On Thu, Jun 27, 2019 at 05:46:27PM -0500, Scott Wood wrote:
> > On Thu, 2019-06-27 at 13:50 -0700, Paul E. McKenney wrote:
> > > If by IPI-to-self you mean the IRQ work trick, that isn't implemented
> > > across all architectures yet, is it?
> > 
> > Right... smp_send_reschedule() has wider coverage, but even then there's
> > some hardware that just can't do it reasonably (e.g. pre-APIC x86).
> 
> Except that smp_send_reschedule() won't do anything unless the scheduler
> things something needs to be done, as it its wake list is non-empty.
> Which might explain why Peter Zijlstra didn't suggest it.

The wake list stuff is separate from the original purpose of the IPI, which
is to hit the need_resched check on IRQ exit.  When that happens, the
scheduler will call into RCU, even if it doesn't change threads.  

> > So I guess the options are:
> > 
> > 1. Accept that such hardware might experience delayed grace period
> > completion in certain configurations,
> > 2. Have such hardware check for need_resched in local_irq_enable() (not
> > nice
> > if sharing a kernel build with hardware that doesn't need it), or
> > 3. Forbid the sequence (enforced by debug checks).  Again, this would
> > only
> > prohibit rcu_read_lock()/local_irq_disable()/rcu_read_unlock()/
> > local_irq_enable() *without* preempt disabling around the IRQ-disabled
> > region.
> 
> 4. If further testing continues to show it to be reliable, continue
> using the scheme in -rcu.

If the testing isn't done on machines that can't do the IPI then it's
basically option #1.  FWIW I don't think option #1 is unreasonable given
that we're talking about very old and/or specialized hardware, and we're
only talking about delays, not a crash (maybe limit the ability to use
nohz_full on such hardware?).  Of course if it turns out people are actually
trying to run (modern versions of) RT on such hardware, that might be
different. :-)

> 5. Use a short-duration hrtimer to get a clean environment in short
> order.  Yes, the timer might fire while preemption and/or softirqs
> are disabled, but then the code can rely on the following
> preempt_enable(), local_bh_enable(), or whatever.  This condition
> should be sufficiently rare to avoid issues with hrtimer overhead.

Yeah, I considered that but was hesitant due to overhead -- at least in the
case of the example I gave (pre-APIC x86), arming a oneshot timer is pretty
slow.  Plus, some hardware might entirely lack one-shot timer capability.

> 6. Use smp_call_function_single() to IPI some other poor slob of a
> CPU, which then does the same back.  Non-waiting version in both
> cases, of course.

I was assuming any hardware that can't do smp_send_reschedule() is not SMP.

> 
> Probably others as well.
> 
> > > Why not simply make rcutorture cyheck whether it is running in a
> > > PREEMPT_RT_FULL environment and avoid the PREEMPT_RT_FULL-unfriendly
> > > testing only in that case?
> > > 
> > > And should we later get to a place where the PREEMPT_RT_FULL-
> > > unfriendly
> > > scenarios are prohibited across all kernel configurations, then the
> > > module
> > > parameter can be removed.  Again, until we know (as opposed to
> > > suspect)
> > > that these scenarios really don't happen, mainline rcutorture must
> > > continue testing them.
> > 
> > Yes, I already acknowledged that debug checks detecting the sequences
> > should
> > come before the test removal
> 
> OK, good to hear.  As you may have noticed, I was getting the impression
> that you might have changed your mind on this point.  ;-)
> 
> >                              (including this patch as an RFC at this
> > point
> > was mainly meant as a demonstration of what's needed to get rcutorture
> > to
> > pass), but it'd be nice to have some idea of whether there would be
> > opposition to the concept before coding up the checks.  I'd rather not
> > continue the state of "these sequences can blow up on RT and we don't
> > know
> > if they exist or not" any longer than necessary.  Plus, only one of the
> > sequences is exclusively an RT issue (though it's the one with the worst
> > consequences).
> 
> Steve Rostedt's point about enlisting the aid of lockdep seems worth
> looking into.

Sure.  I was just concerned by the "Linus was against enforcing this in the
past" comment and was hoping for more details.

-Scott


