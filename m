Return-Path: <SRS0=UEZv=XT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E92C432C1
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Sep 2019 15:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030F521655
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Sep 2019 15:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbfIXPrl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:47:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388100AbfIXPrl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Sep 2019 11:47:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE33E1DA3;
        Tue, 24 Sep 2019 15:47:40 +0000 (UTC)
Received: from ovpn-117-172.phx2.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 659B760BFB;
        Tue, 24 Sep 2019 15:47:37 +0000 (UTC)
Message-ID: <1a2234884e55e5ee6df5f32f828a99c1b248933f.camel@redhat.com>
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
Date:   Tue, 24 Sep 2019 10:47:36 -0500
In-Reply-To: <20190924152514.enzeuoo5a6o3mgqu@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
         <20190911165729.11178-4-swood@redhat.com>
         <20190917075943.qsaakyent4dxjkq4@linutronix.de>
         <779eddcc937941e65659a11b1867c6623a2c8890.camel@redhat.com>
         <404575720cf24765e66020f15ce75352f08a0ddb.camel@redhat.com>
         <20190923175233.yub32stn3xcwkaml@linutronix.de>
         <20190924112155.rxeyksetgqmer3pg@linutronix.de>
         <55dc19fcc44b2e658b71f68206306c8310335564.camel@redhat.com>
         <20190924152514.enzeuoo5a6o3mgqu@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Tue, 24 Sep 2019 15:47:41 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2019-09-24 at 17:25 +0200, Sebastian Andrzej Siewior wrote:
> On 2019-09-24 08:53:43 [-0500], Scott Wood wrote:
> > As I pointed out in the "[PATCH RT 6/8] sched: migrate_enable: Set state
> > to
> > TASK_RUNNING" discussion, we can get here inside the rtmutex code (e.g.
> > from
> > debug_rt_mutex_print_deadlock) where saved_state is already holding
> > something -- plus, the waker won't have WF_LOCK_SLEEPER and therefore
> > saved_state will get cleared anyway.
> 
> So let me drop the saved_state pieces and get back to it once I get to
> the other thread (which you replied and I didn't realised until now).
> 
> Regarding the WF_LOCK_SLEEPER part. I think this works as expected.
> Imagine:
> 
> CPU0						CPU1
> spin_lock();
> set_current_state(TASK_UNINTERRUPTIBLE);
> …
> spin_unlock()
>  -> migrate_enable();
>    -> stop_one_cpu();				<-- A)
> other_func();					<-- B)
> schedule();
> 
> So. With only CPU0 we enter schedule() with TASK_UNINTERRUPTIBLE because
> the state gets preserved with the change I added (which is expected).
> If CPU1 sends a wake_up() at A) then the saved_state gets overwritten
> and we enter schedule() with TASK_RUNNING. Same happens if it is sent at
> B) point which is outside of any migrate/spin lock related code. 
> 
> Was this clear or did I miss the point?

When the stop machine finishes it will do a wake_up_process() via
complete().  Since this does not pass WF_LOCK_SLEEPER, saved_state will be
cleared, and you'll have TASK_RUNNING when you get to other_func() and
schedule(), regardless of whether CPU1 sends wake_up() -- so this change
doesn't actually accomplish anything.

While as noted in the other thread I don't think these spurious wakeups are
a huge problem, we could avoid them by doing stop_one_cpu_nowait() and then
schedule() without messing with task state.  Since we're stopping our own
cpu, it should be guaranteed that the stopper has finished by the time we
exit schedule().

-Scott


