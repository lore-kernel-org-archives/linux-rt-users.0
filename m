Return-Path: <SRS0=2ve0=XL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FB9C4CECD
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Sep 2019 16:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789BC20678
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Sep 2019 16:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbfIPQ4F (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:56:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbfIPQ4F (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Sep 2019 12:56:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 078A318CB8E2;
        Mon, 16 Sep 2019 16:56:05 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C9E75D9DC;
        Mon, 16 Sep 2019 16:55:58 +0000 (UTC)
Message-ID: <500cabaa80f250b974409ee4a4fca59bf2e24564.camel@redhat.com>
Subject: Re: [PATCH RT v3 5/5] rcutorture: Avoid problematic critical
 section nesting on RT
From:   Scott Wood <swood@redhat.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Date:   Mon, 16 Sep 2019 11:55:57 -0500
In-Reply-To: <20190912221706.GC150506@google.com>
References: <20190911165729.11178-1-swood@redhat.com>
         <20190911165729.11178-6-swood@redhat.com>
         <20190912221706.GC150506@google.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Mon, 16 Sep 2019 16:56:05 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2019-09-12 at 18:17 -0400, Joel Fernandes wrote:
> On Wed, Sep 11, 2019 at 05:57:29PM +0100, Scott Wood wrote:
> > rcutorture was generating some nesting scenarios that are not
> > reasonable.  Constrain the state selection to avoid them.
> > 
> > Example #1:
> > 
> > 1. preempt_disable()
> > 2. local_bh_disable()
> > 3. preempt_enable()
> > 4. local_bh_enable()
> > 
> > On PREEMPT_RT, BH disabling takes a local lock only when called in
> > non-atomic context.  Thus, atomic context must be retained until after
> > BH
> > is re-enabled.  Likewise, if BH is initially disabled in non-atomic
> > context, it cannot be re-enabled in atomic context.
> > 
> > Example #2:
> > 
> > 1. rcu_read_lock()
> > 2. local_irq_disable()
> > 3. rcu_read_unlock()
> > 4. local_irq_enable()
> 
> If I understand correctly, these examples are not unrealistic in the real
> world unless RCU is used in the scheduler.

I hope you mean "not realistic", at least when it comes to explicit
preempt/irq disabling rather than spinlock variants that don't disable
preempt/irqs on PREEMPT_RT.

> > If the thread is preempted between steps 1 and 2,
> > rcu_read_unlock_special.b.blocked will be set, but it won't be
> > acted on in step 3 because IRQs are disabled.  Thus, reporting of the
> > quiescent state will be delayed beyond the local_irq_enable().
> 
> Yes, with consolidated RCU this can happen but AFAIK it has not seen to be
> a
> problem since deferred QS reporting will happen take care of it, which can
> also happen from subsequent rcu_read_unlock_special().

The defer_qs_iw_pending stuff isn't in 5.2-rt.  Still, given patch 4/5 (and
special.b.deferred_qs on mainline) this shouldn't present a deadlock concern
(letting the test run a bit now to double check) so this patch could
probably be limited to the "example #1" sequence.

> > For now, these scenarios will continue to be tested on non-PREEMPT_RT
> > kernels, until debug checks are added to ensure that they are not
> > happening elsewhere.
> 
> Are you seeing real issues that need this patch? It would be good to not
> complicate rcutorture if not needed.

rcutorture crashes on RT without this patch (in particular due to the
local_bh_disable misordering).

-Scott


