Return-Path: <SRS0=YHoI=WX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B25C3A5A3
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Aug 2019 09:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0360A217F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Aug 2019 09:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfH0JXh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:23:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43013 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbfH0JXh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Aug 2019 05:23:37 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i2XhN-0000lq-DZ; Tue, 27 Aug 2019 11:23:33 +0200
Date:   Tue, 27 Aug 2019 11:23:33 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Scott Wood <swood@redhat.com>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 2/3] sched: migrate_enable: Use sleeping_lock to
 indicate involuntary sleep
Message-ID: <20190827092333.jp3darw7teyyw67g@linutronix.de>
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-3-swood@redhat.com>
 <20190823162024.47t7br6ecfclzgkw@linutronix.de>
 <433936e4c720e6b81f9b297fefaa592fd8a961ad.camel@redhat.com>
 <20190824031014.GB2731@google.com>
 <20190826152523.dcjbsgyyir4zjdol@linutronix.de>
 <20190826162945.GE28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190826162945.GE28441@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-26 09:29:45 [-0700], Paul E. McKenney wrote:
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

Okay. So I read this as invoking schedule() at this point is okay. 
Looking at this again, this could also happen on a PREEMPT=y kernel if
the kernel decides to preempt a task within a rcu_read_lock() section
and put it back later on another CPU.

> However, if this was instead an rcu_read_lock() critical section within
> a PREEMPT=y kernel, then if a schedule() occured within stop_one_task(),
> RCU would consider that critical section to be preempted.  This means
> that any RCU grace period that is blocked by this RCU read-side critical
> section would remain blocked until stop_one_cpu() resumed, returned,
> and so on until the matching rcu_read_unlock() was reached.  In other
> words, RCU would consider that RCU read-side critical section to span
> the call to stop_one_cpu() even if stop_one_cpu() invoked schedule().

Isn't that my example from above and what we do in RT? My understanding
is that this is the reason why we need BOOST on RT otherwise the RCU
critical section could remain blocked for some time.

> On the other hand, within a PREEMPT=n kernel, the call to schedule()
> would split even an rcu_read_lock() critical section.  Which is why I
> asked earlier if sleeping_lock_inc() and sleeping_lock_dec() are no-ops
> in !PREEMPT_RT_BASE kernels.  We would after all want the usual lockdep
> complaints in that case.

sleeping_lock_inc() +dec() is only RT specific. It is part of RT's
spin_lock() implementation and used by RCU (rcu_note_context_switch())
to not complain if invoked within a critical section.

> Does that help, or am I missing the point?
> 
> 							Thanx, Paul
Sebastian
