Return-Path: <SRS0=I6ff=4W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83CAC3F2D7
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Mar 2020 08:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B1621556
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Mar 2020 08:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgCEILx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:11:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49387 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgCEILx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Mar 2020 03:11:53 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j9lbT-0000kj-Bb; Thu, 05 Mar 2020 09:11:35 +0100
Date:   Thu, 5 Mar 2020 09:11:35 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, tglx@linutronix.de, swood@redhat.com,
        williams@redhat.com, juri.lelli@redhat.com,
        linux-rt-users@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Subject: Re: RCU use of swait
Message-ID: <20200305081135.yg7wryd3hrqzocrm@linutronix.de>
References: <20200305003526.GA20601@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200305003526.GA20601@paulmck-ThinkPad-P72>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-03-04 16:35:26 [-0800], Paul E. McKenney wrote:
> Hello!
Hi Paul,

> Or is there some other reason why {S,}RCU needs to use swait that I
> am forgetting?

swait can be used in hardirq-context (on RT) that is in a section within
local_irq_save() / raw_spin_lock() and so.
wait on the hand uses spinlock_t which can not be used in this context.
So if you have no users which fall into that category then you could
move back to wait.h.

> 							Thanx, Paul
Sebastian
