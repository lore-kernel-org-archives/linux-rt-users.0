Return-Path: <SRS0=wgqT=ZL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA62C432C0
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Nov 2019 14:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE04222D3
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Nov 2019 14:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfKSOVy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:21:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfKSOVv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Nov 2019 09:21:51 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4A87222A9;
        Tue, 19 Nov 2019 14:21:50 +0000 (UTC)
Date:   Tue, 19 Nov 2019 09:21:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH RT] locking: Make spinlock_t and rwlock_t a RCU section
 on RT
Message-ID: <20191119092149.06fd8f87@gandalf.local.home>
In-Reply-To: <20191119084640.wgsxghvc62mxlqc3@linutronix.de>
References: <20191119084640.wgsxghvc62mxlqc3@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 19 Nov 2019 09:46:40 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On !RT a locked spinlock_t and rwlock_t disables preemption which
> implies a RCU read section. There is code that relies on that behaviour.
> 
> Add an explicit RCU read section on RT while a sleeping lock (a lock
> which would disables preemption on !RT) acquired.

I know that there was some work to merge the RCU flavors of
rcu_read_lock and rcu_read_lock_sched, I'm assuming this depends on
that behavior. That is, a synchronize_rcu() will wait for all CPUs to
schedule and all grace periods to finish, which means that those using
rcu_read_lock() and those using all CPUs to schedule can be
interchangeable. That is, on !RT, it's likely that rcu_read_lock()
waiters will end up waiting for all CPUs to schedule, and on RT, this
makes it where those waiting for all CPUs to schedule, will also wait
for all rcu_read_lock()s grace periods to finish. If that's the case,
then this change is fine. But it depends on that being the case, which
it wasn't in older kernels, and we need to be careful about backporting
this.

-- Steve


> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
