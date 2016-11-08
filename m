From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Tue, 8 Nov 2016 17:51:33 +0100
Message-ID: <20161108165133.GI3117@twins.programming.kicks-ass.net>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
 <20161108115958.GO3142@twins.programming.kicks-ass.net>
 <20161108090740.4226ffc9@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45838 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933255AbcKHQvg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Nov 2016 11:51:36 -0500
Content-Disposition: inline
In-Reply-To: <20161108090740.4226ffc9@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Nov 08, 2016 at 09:07:40AM -0500, Steven Rostedt wrote:
> On Tue, 8 Nov 2016 12:59:58 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > No, none of this stands a chance of being accepted.
> > 
> > This is making bad code worse.
> 
> Peter,
> 
> Instead of a flat out rejection, can you please provide some
> constructive criticism to let those that are working on this know what
> would be accepted? And what their next steps should be.
> 
> There's obviously a problem with the current code, what steps do you
> recommend to fix it?

You really should already know this.

As stands the current rt cgroup code (and all this throttling code) is a
giant mess (as in, its not actually correct from a RT pov). We should
not make it worse by adding random hacks to it.

The right way to to about doing this is by replacing it with something
better; like the proposed DL server for FIFO tasks -- which is entirely
non-trivial as well, see existing discussion on that.

I'm not entirely sure what this patch was supposed to fix, but it could
be running CFS tasks with higher priority than RT for a window, instead
of throttling RT tasks. This seems fairly ill specified, but something
like that could easily done with an explicit or slack time DL server for
CFS tasks.


