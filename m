Return-Path: <SRS0=GyRq=5E=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45990C4332B
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Mar 2020 09:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A3E20753
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Mar 2020 09:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgCSJZ4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Mar 2020 05:25:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60077 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgCSJZ4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Mar 2020 05:25:56 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jErQq-0004NV-Su; Thu, 19 Mar 2020 10:25:40 +0100
Date:   Thu, 19 Mar 2020 10:25:40 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        Scott Wood <swood@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-rt-users@vger.kernel.org, rcu <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: RCU use of swait
Message-ID: <20200319092540.gpgzx2qao3r4okql@linutronix.de>
References: <20200305003526.GA20601@paulmck-ThinkPad-P72>
 <20200305081135.yg7wryd3hrqzocrm@linutronix.de>
 <CAEXW_YSiKrT50mTR1a4tB5x_jQzZKnuAo6JY-Vc5w7r=XLv+OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEXW_YSiKrT50mTR1a4tB5x_jQzZKnuAo6JY-Vc5w7r=XLv+OA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-03-18 20:47:18 [-0400], Joel Fernandes wrote:
> In RCU, there are some truly-atomic code sections containing an
> swake_upXX() call, which would be considered atomic also on
> PREEMPT_RT, one example is:
> 
> rcu_core() contains an local_irq_{save,restore}() section.
> 
>         /* No grace period and unregistered callbacks? */
>         if (!rcu_gp_in_progress() &&
>             rcu_segcblist_is_enabled(&rdp->cblist) && !offloaded) {
>                 local_irq_save(flags);
>                 if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
>                         rcu_accelerate_cbs_unlocked(rnp, rdp);
>                 local_irq_restore(flags);
>         }
> 
> And rcu_accelerate_cbs_unlocked(rnp, rdp) calls rcu_gp_kthread_wake()
> which does an swake_up_one(), so I think we will have to leave it as
> swake_up() the way it is.

There is also this:
irq_exit()
 rcu_irq_exit()
  rcu_nmi_exit_common(true);
   rcu_prepare_for_idle()
    if (rcu_segcblist_pend_cbs(&rdp->cblist))
      rcu_gp_kthread_wake()
       swake_up_one(&rcu_state.gp_wq);

So I *think* this is another one.

> thanks,
> 
>  - Joel

Sebastian
