Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19978C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Jul 2022 16:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbiGGQUE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 Jul 2022 12:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiGGQUD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Jul 2022 12:20:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0C725EAF;
        Thu,  7 Jul 2022 09:20:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46F2FB82124;
        Thu,  7 Jul 2022 16:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9377DC3411E;
        Thu,  7 Jul 2022 16:19:58 +0000 (UTC)
Date:   Thu, 7 Jul 2022 12:19:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Keeping <john@metanate.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched/core: Always flush pending blk_plug
Message-ID: <20220707121956.0ab19fd8@gandalf.local.home>
In-Reply-To: <20220707143902.529938-1-john@metanate.com>
References: <20220707143902.529938-1-john@metanate.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu,  7 Jul 2022 15:39:02 +0100
John Keeping <john@metanate.com> wrote:

> Here the kworker is waiting on msdos_sb_info::s_lock which is held by
> tar which is in turn waiting for a buffer which is locked waiting to be
> flushed, but this operation is plugged in the kworker.
> 
> The lock is a normal struct mutex, so tsk_is_pi_blocked() will always
> return false on !RT and thus the behaviour changes for RT.
> 
> It seems that the intent here is to skip blk_flush_plug() in the case
> where a non-preemptible lock (such as a spinlock) has been converted to
> a rtmutex on RT, which is the case covered by the SM_RTLOCK_WAIT
> schedule flag.  But sched_submit_work() is only called from schedule()
> which is never called in this scenario, so the check can simply be
> deleted.
> 
> Looking at the history of the -rt patchset, in fact this change was
> present from v5.9.1-rt20 until being dropped in v5.13-rt1 as it was part
> of a larger patch [1] most of which was replaced by commit b4bfa3fcfe3b
> ("sched/core: Rework the __schedule() preempt argument").
> 

Nice investigation.

So basically what you are saying is that commit b4bfa3fcfe3b was the
implementation of [1], but left out the removal of the tsk_is_pi_blocked(),
and that what you are seeing is the problem that is described in [1].

Can you add this in the change log:

"As described in [1]:

   The schedule process must distinguish between blocking on a regular
   sleeping lock (rwsem and mutex) and a RT-only sleeping lock (spinlock
   and rwlock):
   - rwsem and mutex must flush block requests (blk_schedule_flush_plug())
     even if blocked on a lock. This can not deadlock because this also
     happens for non-RT.
     There should be a warning if the scheduling point is within a RCU read
     section.

   - spinlock and rwlock must not flush block requests. This will deadlock
     if the callback attempts to acquire a lock which is already acquired.
     Similarly to being preempted, there should be no warning if the
     scheduling point is within a RCU read section.

and with the tsk_is_pi_blocked() in the scheduler path, we hit the first
issue."

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
