Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7F8C4CED0
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 09:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49DB21897
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 09:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfIQJcI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 05:32:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41075 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfIQJcI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 05:32:08 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iA9pv-0008Su-Ah; Tue, 17 Sep 2019 11:31:51 +0200
Date:   Tue, 17 Sep 2019 11:31:51 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Scott Wood <swood@redhat.com>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>, rcu@vger.kernel.org
Subject: Re: [PATCH RT v3 4/5] rcu: Disable use_softirq on PREEMPT_RT
Message-ID: <20190917093151.7duyhvrax7hq43le@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
 <20190911165729.11178-5-swood@redhat.com>
 <20190912213843.GA150506@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190912213843.GA150506@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-09-12 17:38:43 [-0400], Joel Fernandes wrote:
> > The prohibition on use_softirq should be able to be dropped once RT gets
> > the latest RCU code, but the question of what use_softirq should default
> > to on PREEMPT_RT remains.
> > 
> > v3: Use IS_ENABLED

I'm going to pick it up.

> Out of curiosity, does PREEMPT_RT use the NOCB callback offloading? If no,
> should it use it? IIUC, that does make the work the softirq have to do less
> work since the callbacks are executed in threaded context.

It can use it, it is recommended to do so and to move those threads out
of the CPU(s) that are dedicated for RT workload. But then there are
those with a single CPU.

> If yes, can RT tolerate use_softirq=false and what could a realistic softirq
> running/completion time be that PREEMPT_RT can tolerate? I guess that can be
> answered by running rcuperf on PREEMPT_RT with a NOCB configuration and
> measuring softirq worst-case start/completion times.

It depends. RT as of now. The softirq can be preempted this includes the
RCU softirq. That means that a wakeup of a high priority RT task can
preempt the RCU softirq. So this might not be an issue.
the softirq takes a global per-CPU lock which means we can only have one
softirq vector running at a time (we used to have the possibility of
multiple vectors running in parallel but that is gone now). So this
enforces the behaviour we have in !RT as of today.  If you rely on
"timely" executed softirq then long running RCU-softirq might be bad for
you. But so is everything else that might cause long running softirqs.

What I don't know is how RCU-boosting and preempted softirq works.

> I could run these tests myself but I am vacation for the next week or so.
> 
> thanks,
> 
>  - Joel

Sebastian
