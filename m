From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched: fix race in schedule
Date: Tue, 11 Mar 2008 09:40:35 +0100
Message-ID: <1205224835.8514.183.camel@twins>
References: <47D57770.50909@ct.jp.nec.com> <1205174197.8514.159.camel@twins>
	 <47D593A5.5060906@ct.jp.nec.com> <1205181256.6241.320.camel@lappy>
	 <47D5EA9C.1040404@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, hpj@urpla.net,
	stable <stable@kernel.org>,
	Dmitry Adamushko <dmitry.adamushko@gmail.com>
To: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:46806 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbYCKIko (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Mar 2008 04:40:44 -0400
In-Reply-To: <47D5EA9C.1040404@ct.jp.nec.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2008-03-10 at 19:12 -0700, Hiroshi Shimamoto wrote:
> Peter Zijlstra wrote:
> > On Mon, 2008-03-10 at 13:01 -0700, Hiroshi Shimamoto wrote:
> > 
> >> thanks, your patch looks nice to me.
> >> I had focused setprio, on_rq=0 and running=1 situation, it makes me to
> >> fix these functions.
> >> But one point, I've just noticed. I'm not sure on same situation against
> >> sched_rt. I think the pre_schedule() of rt has chance to drop rq lock.
> >> Is it OK?
> > 
> > Ah, you are quite right, that'll teach me to rush out a patch just
> > because dinner is ready :-). 
> > 
> > How about we submit the following patch for mainline and CC -stable to
> > fix .23 and .24:
> > 
> 
> Unfortunately, I encountered similar panic with this patch on -rt.
> I'll look into this, again. I might have missed something...
> 
> Unable to handle kernel NULL pointer dereference at 0000000000000128 RIP:
>  [<ffffffff802297f5>] pick_next_task_fair+0x2d/0x42

:-(

OK, so that means I'm not getting it.

So what does your patch do that mine doesn't?

It removes the dependency of running (=task_current()) from on_rq
(p->se.on_rq).

So how can a current task not be on the runqueue?

Only sched.c:dequeue_task() and sched_fair.c:account_entity_dequeue()
set on_rq to 0, the only one changing rq->curr is schedule().

So the only scheme I can come up with is that we did dequeue p (on_rq ==
0), but we didn't yet schedule so rq->curr == p.

Is this how you ended up with your previuos analysis that it must be due
to a hole introduced by double_lock_balance()?

Because now we can seemingly call deactivate_task() and put_prev_task()
in non-atomic fashion, but by placing the put_prev_task() before the
load balance calls we should avoid doing that.

So what else is going on... /me puzzled



