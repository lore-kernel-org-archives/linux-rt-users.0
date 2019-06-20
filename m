Return-Path: <SRS0=3DPx=UT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B1EC43613
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 21:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89671206BA
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 21:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfFTVn5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:43:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfFTVn5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Jun 2019 17:43:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18651A6E13;
        Thu, 20 Jun 2019 21:43:57 +0000 (UTC)
Received: from ovpn-117-83.phx2.redhat.com (ovpn-117-83.phx2.redhat.com [10.3.117.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0DD219C5B;
        Thu, 20 Jun 2019 21:43:53 +0000 (UTC)
Message-ID: <70a4c99c4f8f310b017755a3d0aa08eb68f0e48b.camel@redhat.com>
Subject: Re: [RFC PATCH RT 4/4] rcutorture: Avoid problematic critical
 section nesting
From:   Scott Wood <swood@redhat.com>
To:     paulmck@linux.ibm.com
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 20 Jun 2019 16:43:53 -0500
In-Reply-To: <20190620211826.GX26519@linux.ibm.com>
References: <20190619011908.25026-1-swood@redhat.com>
         <20190619011908.25026-5-swood@redhat.com>
         <20190620211826.GX26519@linux.ibm.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 20 Jun 2019 21:43:57 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2019-06-20 at 14:18 -0700, Paul E. McKenney wrote:
> On Tue, Jun 18, 2019 at 08:19:08PM -0500, Scott Wood wrote:
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
> > 
> > If the thread is preempted between steps 1 and 2,
> > rcu_read_unlock_special.b.blocked will be set, but it won't be
> > acted on in step 3 because IRQs are disabled.  Thus, reporting of the
> > quiescent state will be delayed beyond the local_irq_enable().
> > 
> > Example #3:
> > 
> > 1. preempt_disable()
> > 2. local_irq_disable()
> > 3. preempt_enable()
> > 4. local_irq_enable()
> > 
> > If need_resched is set between steps 1 and 2, then the reschedule
> > in step 3 will not happen.
> > 
> > Signed-off-by: Scott Wood <swood@redhat.com>
> 
> OK for -rt, but as long as people can code those sequences without getting
> their wrists slapped, RCU needs to deal with it.  So I cannot accept
> this in mainline at the current time.  Yes, I will know when it is safe
> to accept it when rcutorture's virtual wrist gets slapped in mainline.
> Why did you ask?  ;-)

Hence the "TODO: Document restrictions and add debug checks for invalid
sequences". :-)

> But I have to ask...  With this elaboration, is it time to make this a
> data-driven state machine?  Or is the complexity not yet to the point
> where that would constitute a simplification?

Perhaps... Making the entire sequence visible to the constraint enforcement
would also allow relaxing some of the constraints that currently have to
assume the worst regarding what happened before the most recent state.

-Scott


