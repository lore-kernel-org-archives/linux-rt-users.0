From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] PREEMPT_RT: sched/rr, sched/fair: defer CFS scheduler
 put_prev_task()
Date: Thu, 26 Oct 2017 04:41:12 +0200
Message-ID: <1508985672.5772.46.camel@gmx.de>
References: <1508970403-19912-1-git-send-email-amartin@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Allen Martin <amartin@nvidia.com>, mingo@kernel.org,
        tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:52104 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751973AbdJZCl1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Oct 2017 22:41:27 -0400
In-Reply-To: <1508970403-19912-1-git-send-email-amartin@nvidia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2017-10-25 at 15:26 -0700, Allen Martin wrote:
> Defer calling put_prev_task() on a CFS task_struct when there is a
> pending RT task to run.  Instead wait until the next
> pick_next_task_fair() and do the work there.

Which donates execution time of the rt class task to the fair class
task, mucking up fairness.  Nogo.  To make that work, you'd have to at
least squirrel away the time, but..

> The put_prev_task() call for a SCHED_OTHER task is currently a source
> of non determinism in the latency of scheduling a SCHED_FIFO task.
> This results in a priority inversion as the CFS scheduler is updating
> load average and balancing the rq rbtree while the SCHED_FIFO task is
> waiting to run.

How can determinism really be improved by adding fast path cycles to
move other fast path cycles from one fast path spot to another fast
path spot?  What prevents an rt task from trying to arrive while those
merely relocated cycles are executing?

To make cycles cease and desist negatively affecting determinism, you
have to make those cycles become an invariant, best version thereof
being they become an invariant zero.  Xenomai (co-kernel) tries to get
closer to that optimal zero by making the entire kernel that fair class
lives in go the hell away when rt wants to run, which drops average rt
latency quite a bit, but worst case remained about the same in my light
testing, rendering it's numbers the same as yours.. prettier on
average, but not really any more deterministic.

	-Mike
