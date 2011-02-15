From: Frank Rowand <frank.rowand@gmail.com>
Subject: Re: Interrupt Bottom Half Scheduling
Date: Tue, 15 Feb 2011 10:40:17 -0800
Message-ID: <4D5AC891.9000705@am.sony.com>
References: <AANLkTimGobdGMgnc8bVJTvYtH4Tjn2ZVmroeFA2s06WD@mail.gmail.com>	<AANLkTimGvJWgeEXHFdVBJCidL8ctbAxKJZ8V9KeMxRUX@mail.gmail.com>	<AANLkTinpxPMVPCw0ND_1t1orEHaYBRfEfruv1v0rws-b@mail.gmail.com>	<AANLkTimvEy8VE5564CWLeDMHLV8cVBmor8weJos8+ovU@mail.gmail.com> <AANLkTikCXF8BY+gh3P0kZPuUFvSp80acF8kH5CRmykRQ@mail.gmail.com> <4D5AC80F.1090205@am.sony.com>
Reply-To: frank.rowand@am.sony.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Peter LaDow <petela@gocougs.wsu.edu>,
	Frank Rowand <frank.rowand@gmail.com>,
	linux-rt-users@vger.kernel.org
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:43862 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994Ab1BOSkU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Feb 2011 13:40:20 -0500
Received: by pxi15 with SMTP id 15so68124pxi.19
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Feb 2011 10:40:20 -0800 (PST)
In-Reply-To: <4D5AC80F.1090205@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/15/11 10:38, Frank Rowand wrote:

> try_to_wake_up() is in the scheduler code (kernel/sched.c), but it is
> not "the scheduler".  If the task is not already running,
> try_to_wake_up() will put the task on the run queue and set it's state
> to TASK_RUNNING.  If the priority of the newly woken thread was higher
> than the current thread, then the newly woken thread would preempt
> current.  If a preemption occurred, then TIF_NEED_RESCHED is set.

Oops, I slipped into using "thread" instead of "task".  Just substitue
"task" for each occurance of "thread" in that paragraph.

> The actual "schedule" will occur on the exit path of the interrupt
> only if TIF_NEED_RESCHED is set (see the call of preempt_schedule_irq()).
