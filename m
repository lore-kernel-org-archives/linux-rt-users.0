Return-Path: <SRS0=Uj5H=WW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7445AC3A59F
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Aug 2019 17:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FC02184D
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Aug 2019 17:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbfHZRt2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 26 Aug 2019 13:49:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbfHZRt2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Aug 2019 13:49:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCEB58AE40;
        Mon, 26 Aug 2019 17:49:27 +0000 (UTC)
Received: from ovpn-116-73.phx2.redhat.com (ovpn-116-73.phx2.redhat.com [10.3.116.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98C71196AE;
        Mon, 26 Aug 2019 17:49:22 +0000 (UTC)
Message-ID: <72c2da8695f622b8962ac43e3571107382969555.camel@redhat.com>
Subject: Re: [PATCH RT v2 2/3] sched: migrate_enable: Use sleeping_lock to
 indicate involuntary sleep
From:   Scott Wood <swood@redhat.com>
To:     paulmck@linux.ibm.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Date:   Mon, 26 Aug 2019 12:49:22 -0500
In-Reply-To: <20190826162945.GE28441@linux.ibm.com>
References: <20190821231906.4224-1-swood@redhat.com>
         <20190821231906.4224-3-swood@redhat.com>
         <20190823162024.47t7br6ecfclzgkw@linutronix.de>
         <433936e4c720e6b81f9b297fefaa592fd8a961ad.camel@redhat.com>
         <20190824031014.GB2731@google.com>
         <20190826152523.dcjbsgyyir4zjdol@linutronix.de>
         <20190826162945.GE28441@linux.ibm.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 26 Aug 2019 17:49:27 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2019-08-26 at 09:29 -0700, Paul E. McKenney wrote:
> On Mon, Aug 26, 2019 at 05:25:23PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-08-23 23:10:14 [-0400], Joel Fernandes wrote:
> > > On Fri, Aug 23, 2019 at 02:28:46PM -0500, Scott Wood wrote:
> > > > On Fri, 2019-08-23 at 18:20 +0200, Sebastian Andrzej Siewior wrote:
> > > > > this looks like an ugly hack. This sleeping_lock_inc() is used
> > > > > where we
> > > > > actually hold a sleeping lock and schedule() which is okay. But
> > > > > this
> > > > > would mean we hold a RCU lock and schedule() anyway. Is that okay?
> > > > 
> > > > Perhaps the name should be changed, but the concept is the same --
> > > > RT-
> > > > specific sleeping which should be considered involuntary for the
> > > > purpose of
> > > > debug checks.  Voluntary sleeping is not allowed in an RCU critical
> > > > section
> > > > because it will break the critical section on certain flavors of
> > > > RCU, but
> > > > that doesn't apply to the flavor used on RT.  Sleeping for a long
> > > > time in an
> > > > RCU critical section would also be a bad thing, but that also
> > > > doesn't apply
> > > > here.
> > > 
> > > I think the name should definitely be changed. At best, it is super
> > > confusing to
> > > call it "sleeping_lock" for this scenario. In fact here, you are not
> > > even
> > > blocking on a lock.
> > > 
> > > Maybe "sleeping_allowed" or some such.
> > 
> > The mechanism that is used here may change in future. I just wanted to
> > make sure that from RCU's side it is okay to schedule here.
> 
> Good point.
> 
> The effect from RCU's viewpoint will be to split any non-rcu_read_lock()
> RCU read-side critical section at this point.  This alrady happens in a
> few places, for example, rcu_note_context_switch() constitutes an RCU
> quiescent state despite being invoked with interrupts disabled (as is
> required!).  The __schedule() function just needs to understand (and does
> understand) that the RCU read-side critical section that would otherwise
> span that call to rcu_node_context_switch() is split in two by that call.
> 
> However, if this was instead an rcu_read_lock() critical section within
> a PREEMPT=y kernel, then if a schedule() occured within stop_one_task(),
> RCU would consider that critical section to be preempted.  This means
> that any RCU grace period that is blocked by this RCU read-side critical
> section would remain blocked until stop_one_cpu() resumed, returned,
> and so on until the matching rcu_read_unlock() was reached.  In other
> words, RCU would consider that RCU read-side critical section to span
> the call to stop_one_cpu() even if stop_one_cpu() invoked schedule().
> 
> On the other hand, within a PREEMPT=n kernel, the call to schedule()
> would split even an rcu_read_lock() critical section.  Which is why I
> asked earlier if sleeping_lock_inc() and sleeping_lock_dec() are no-ops
> in !PREEMPT_RT_BASE kernels.  We would after all want the usual lockdep
> complaints in that case.

migrate_enable() is PREEMPT_RT_BASE-specific -- this code won't execute at
all with PREEMPT=n.

-Scott


