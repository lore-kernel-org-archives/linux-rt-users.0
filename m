Return-Path: <SRS0=wgqT=ZL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96831C432C0
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Nov 2019 14:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6974E222DC
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Nov 2019 14:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574174803;
	bh=2hYwDaOAC8NJb3N2Uev+UDnLERgikC64fkVnnqY/s2s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=LmZt38Em7nh1I3KX98P1NY70r8xXB6JQ3ZTZ12X9VQZLEJmCNw7OjYKOXoUYwRd9V
	 Dqy4WiYS67ulg9Mpa8fRZgC0rsTplrohepwFdN+DNoI3qhA7lOXi5eyYD8mdczoH3e
	 horaCMW4h1N8JMQqYQnojTN0cJ1Zan7bUKK8yJ0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfKSOqn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:46:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfKSOqm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Nov 2019 09:46:42 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9D69222D1;
        Tue, 19 Nov 2019 14:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574174802;
        bh=2hYwDaOAC8NJb3N2Uev+UDnLERgikC64fkVnnqY/s2s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sSzNxTMgU/Tfp2rAj7lKTlJxa7Y4Ut+tXUhN5bX7QTk6wm1SJWkS/4XEogasqw0za
         Ac1QKEe8AWfik5lzqBogpXEIZukQ0u1HrMKpkcolk6eDq4OGHXG40rCUrNtEw/K9S1
         mN7Cbch+YmYiI4T55eS671CACC5MwOQ8AgE03as8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 95A2A3520B06; Tue, 19 Nov 2019 06:46:41 -0800 (PST)
Date:   Tue, 19 Nov 2019 06:46:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT] locking: Make spinlock_t and rwlock_t a RCU section
 on RT
Message-ID: <20191119144641.GV2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191119084640.wgsxghvc62mxlqc3@linutronix.de>
 <20191119092149.06fd8f87@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119092149.06fd8f87@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Nov 19, 2019 at 09:21:49AM -0500, Steven Rostedt wrote:
> On Tue, 19 Nov 2019 09:46:40 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On !RT a locked spinlock_t and rwlock_t disables preemption which
> > implies a RCU read section. There is code that relies on that behaviour.
> > 
> > Add an explicit RCU read section on RT while a sleeping lock (a lock
> > which would disables preemption on !RT) acquired.
> 
> I know that there was some work to merge the RCU flavors of
> rcu_read_lock and rcu_read_lock_sched, I'm assuming this depends on
> that behavior. That is, a synchronize_rcu() will wait for all CPUs to
> schedule and all grace periods to finish, which means that those using

s/grace periods/RCU readers/, but yes.

> rcu_read_lock() and those using all CPUs to schedule can be
> interchangeable. That is, on !RT, it's likely that rcu_read_lock()
> waiters will end up waiting for all CPUs to schedule, and on RT, this
> makes it where those waiting for all CPUs to schedule, will also wait
> for all rcu_read_lock()s grace periods to finish. If that's the case,
> then this change is fine. But it depends on that being the case, which
> it wasn't in older kernels, and we need to be careful about backporting
> this.

Right in one.  Backporting across the RCU flavor consolidation change
must be done with care.

							Thanx, Paul
