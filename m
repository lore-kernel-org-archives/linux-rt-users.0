Return-Path: <SRS0=q9Sf=WY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CE9C3A5A1
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Aug 2019 09:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6614217F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Aug 2019 09:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfH1J1n (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:27:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46220 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfH1J1n (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Aug 2019 05:27:43 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i2uEt-0006qQ-MY; Wed, 28 Aug 2019 11:27:39 +0200
Date:   Wed, 28 Aug 2019 11:27:39 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Scott Wood <swood@redhat.com>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 2/3] sched: migrate_enable: Use sleeping_lock to
 indicate involuntary sleep
Message-ID: <20190828092739.46mrffvzjv6v3de5@linutronix.de>
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-3-swood@redhat.com>
 <20190823162024.47t7br6ecfclzgkw@linutronix.de>
 <433936e4c720e6b81f9b297fefaa592fd8a961ad.camel@redhat.com>
 <20190824031014.GB2731@google.com>
 <20190826152523.dcjbsgyyir4zjdol@linutronix.de>
 <20190826162945.GE28441@linux.ibm.com>
 <20190827092333.jp3darw7teyyw67g@linutronix.de>
 <20190827155306.GF26530@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190827155306.GF26530@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-27 08:53:06 [-0700], Paul E. McKenney wrote:
> > > On the other hand, within a PREEMPT=n kernel, the call to schedule()
> > > would split even an rcu_read_lock() critical section.  Which is why I
> > > asked earlier if sleeping_lock_inc() and sleeping_lock_dec() are no-ops
> > > in !PREEMPT_RT_BASE kernels.  We would after all want the usual lockdep
> > > complaints in that case.
> > 
> > sleeping_lock_inc() +dec() is only RT specific. It is part of RT's
> > spin_lock() implementation and used by RCU (rcu_note_context_switch())
> > to not complain if invoked within a critical section.
> 
> Then this is being called when we have something like this, correct?
> 
> 	DEFINE_SPINLOCK(mylock); // As opposed to DEFINE_RAW_SPINLOCK().
> 
> 	...
> 
> 	rcu_read_lock();
> 	do_something();
> 	spin_lock(&mylock); // Can block in -rt, thus needs sleeping_lock_inc()
> 	...
> 	rcu_read_unlock();
> 
> Without sleeping_lock_inc(), lockdep would complain about a voluntary
> schedule within an RCU read-side critical section.  But in -rt, voluntary
> schedules due to sleeping on a "spinlock" are OK.
> 
> Am I understanding this correctly?

Everything perfect except that it is not lockdep complaining but the
WARN_ON_ONCE() in rcu_note_context_switch().

> 
> 							Thanx, Paul

Sebastian
