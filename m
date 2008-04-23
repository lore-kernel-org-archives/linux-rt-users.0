From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] sched: fix RT task-wakeup logic
Date: Wed, 23 Apr 2008 08:54:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0804230853450.23815@gandalf.stny.rr.com>
References: <20080423111313.4981.37345.stgit@novell1.haskins.net>
 <20080423111329.4981.88455.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>,
	Dmitry Adamushko <dmitry.adamushko@gmail.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:37280 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbYDWMyS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Apr 2008 08:54:18 -0400
In-Reply-To: <20080423111329.4981.88455.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 23 Apr 2008, Gregory Haskins wrote:

> Dmitry Adamushko pointed out a logic error in task_wake_up_rt() where we
> will always evaluate to "true".  You can find the thread here:
>
> http://lkml.org/lkml/2008/4/22/296
>
> In reality, we only want to try to push tasks away when a wake up request is
> not going to preempt the current task.  So lets fix it.
>
> Note: We introduce test_tsk_need_resched() instead of open-coding the flag
> check so that the merge-conflict with -rt should help remind us that we
> may need to support NEEDS_RESCHED_DELAYED in the future, too.
>
> Signed-off-by: Gregory Haskins <ghaskins@novell.com>
> CC: Dmitry Adamushko <dmitry.adamushko@gmail.com>
> CC: Ingo Molnar <mingo@elte.hu>
> CC: Steven Rostedt <rostedt@goodmis.org>

Acked-by: Steven Rostedt <srostedt@redhat.com>

-- Steve

