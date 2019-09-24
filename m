Return-Path: <SRS0=UEZv=XT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89F2C432C1
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Sep 2019 16:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5068214AF
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Sep 2019 16:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388583AbfIXQfV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:35:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387614AbfIXQfU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Sep 2019 12:35:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 57B41C04B302;
        Tue, 24 Sep 2019 16:35:20 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B720E10016EB;
        Tue, 24 Sep 2019 16:35:16 +0000 (UTC)
Message-ID: <b05494c96c039c348c0d3cb93d92fc1b77fe1dab.camel@redhat.com>
Subject: Re: [PATCH RT v3 3/5] sched: migrate_dis/enable: Use rt_invol_sleep
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Date:   Tue, 24 Sep 2019 11:35:16 -0500
In-Reply-To: <20190924160554.5esplbmnzm4q4tew@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
         <20190911165729.11178-4-swood@redhat.com>
         <20190917075943.qsaakyent4dxjkq4@linutronix.de>
         <779eddcc937941e65659a11b1867c6623a2c8890.camel@redhat.com>
         <404575720cf24765e66020f15ce75352f08a0ddb.camel@redhat.com>
         <20190923175233.yub32stn3xcwkaml@linutronix.de>
         <20190924112155.rxeyksetgqmer3pg@linutronix.de>
         <55dc19fcc44b2e658b71f68206306c8310335564.camel@redhat.com>
         <20190924152514.enzeuoo5a6o3mgqu@linutronix.de>
         <1a2234884e55e5ee6df5f32f828a99c1b248933f.camel@redhat.com>
         <20190924160554.5esplbmnzm4q4tew@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 24 Sep 2019 16:35:20 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2019-09-24 at 18:05 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-09-24 10:47:36 [-0500], Scott Wood wrote:
> > When the stop machine finishes it will do a wake_up_process() via
> > complete().  Since this does not pass WF_LOCK_SLEEPER, saved_state will
> > be
> > cleared, and you'll have TASK_RUNNING when you get to other_func() and
> > schedule(), regardless of whether CPU1 sends wake_up() -- so this change
> > doesn't actually accomplish anything.
> 
> True, I completely missed that part.
> 
> > While as noted in the other thread I don't think these spurious wakeups
> > are
> > a huge problem, we could avoid them by doing stop_one_cpu_nowait() and
> > then
> > schedule() without messing with task state.  Since we're stopping our
> > own
> > cpu, it should be guaranteed that the stopper has finished by the time
> > we
> > exit schedule().
> 
> I remember loosing a state can be a problem. Lets say it is not "just"
> TASK_UNINTERRUPTIBLE -> TASK_RUNNING which sounds harmless but it is
> __TASK_TRACED and you lose it as part of unlocking siglock.

OK, sounds like stop_one_cpu_nowait() is the way to go then.

-Scott


