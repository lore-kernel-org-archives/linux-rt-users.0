Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05923C4CECD
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 14:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E05214AF
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 14:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfIQOgY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:36:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbfIQOgY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 10:36:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 283433B46C;
        Tue, 17 Sep 2019 14:36:24 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2821E19C4F;
        Tue, 17 Sep 2019 14:36:23 +0000 (UTC)
Message-ID: <26dbecfee2c02456ddfda3647df1bcd56d9cc520.camel@redhat.com>
Subject: Re: [PATCH RT v3 5/5] rcutorture: Avoid problematic critical
 section nesting on RT
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Date:   Tue, 17 Sep 2019 09:36:22 -0500
In-Reply-To: <20190917100728.wnhdvmbbzzxolef4@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
         <20190911165729.11178-6-swood@redhat.com>
         <20190912221706.GC150506@google.com>
         <500cabaa80f250b974409ee4a4fca59bf2e24564.camel@redhat.com>
         <20190917100728.wnhdvmbbzzxolef4@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 17 Sep 2019 14:36:24 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2019-09-17 at 12:07 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-09-16 11:55:57 [-0500], Scott Wood wrote:
> > On Thu, 2019-09-12 at 18:17 -0400, Joel Fernandes wrote:
> > > On Wed, Sep 11, 2019 at 05:57:29PM +0100, Scott Wood wrote:
> > > > rcutorture was generating some nesting scenarios that are not
> > > > reasonable.  Constrain the state selection to avoid them.
> > > > 
> > > > Example #1:
> > > > 
> > > > 1. preempt_disable()
> > > > 2. local_bh_disable()
> > > > 3. preempt_enable()
> > > > 4. local_bh_enable()
> > > > 
> > > > On PREEMPT_RT, BH disabling takes a local lock only when called in
> > > > non-atomic context.  Thus, atomic context must be retained until
> > > > after
> > > > BH
> > > > is re-enabled.  Likewise, if BH is initially disabled in non-atomic
> > > > context, it cannot be re-enabled in atomic context.
> > > > 
> > > > Example #2:
> > > > 
> > > > 1. rcu_read_lock()
> > > > 2. local_irq_disable()
> > > > 3. rcu_read_unlock()
> > > > 4. local_irq_enable()
> > > 
> > > If I understand correctly, these examples are not unrealistic in the
> > > real
> > > world unless RCU is used in the scheduler.
> > 
> > I hope you mean "not realistic", at least when it comes to explicit
> > preempt/irq disabling rather than spinlock variants that don't disable
> > preempt/irqs on PREEMPT_RT.
> 
> We have:
> - local_irq_disable() (+save)
> - spin_lock()
> - local_bh_disable()
> - preempt_disable()
> 
> On non-RT you can (but should not) use the counter part of the function
> in random order like:
> 	local_bh_disable();
> 	local_irq_disable();
> 	local_bh_enable();
> 	local_irq_enable();

Actually even non-RT will assert if you do local_bh_enable() with IRQs
disabled -- but the other combinations do work, and are used some places via
spinlocks.  If they are used via direct calls to preempt_disable() or
local_irq_disable() (or via raw spinlocks), then that will not go away on RT
and we'll have a problem.

> The non-RT will survive this. On RT the counterpart functions have to be
> used in reverse order:
> 	local_bh_disable();
> 	local_irq_disable();
> 	local_irq_enable();
> 	local_bh_enable();
> 
> or the kernel will fall apart.
> 
> Since you _can_ use it in random order Paul wants to test that the
> random use of those function does not break RCU in any way. Since they
> can not be used on RT in random order it has been agreed that we keep
> the test for !RT but disable it on RT.

For now, yes.  Long term it would be good to keep track of when
preemption/irqs would be disabled on RT, even when running a non-RT debug
kernel, and assert when bad things are done with it (assuming an RT-capable
arch).  Besides detecting these fairly unusual patterns, it could also
detect earlier the much more common problem of nesting a non-raw spinlock
inside a raw spinlock or other RT-atomic context.

-Scott


