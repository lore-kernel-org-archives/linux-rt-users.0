From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: [PATCH 0/3] sched: newidle and RT wake-buddy fixes
Date: Mon, 30 Jun 2008 11:16:55 -0600
Message-ID: <4868DCC7.BA47.005A.0@novell.com>
References: <20080627202444.3829.21595.stgit@lsg.lsg.lab.novell.com>
 <20080630131511.GA7506@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <rostedt@goodmis.org>, <peterz@infradead.org>, <npiggin@suse.de>,
	<linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: "Ingo Molnar" <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sinclair.provo.novell.com ([137.65.248.137]:52122 "EHLO
	sinclair.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbYF3RXz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jun 2008 13:23:55 -0400
In-Reply-To: <20080630131511.GA7506@elte.hu>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>>> On Mon, Jun 30, 2008 at  9:15 AM, in message <20080630131511.GA7506@elte.hu>,
Ingo Molnar <mingo@elte.hu> wrote: 

> * Gregory Haskins <ghaskins@novell.com> wrote:
> 
>> Hi Ingo,
>>   The following patches apply to linux-tip/sched/devel and enhance the
>> performance of the kernel (specifically in PREEMPT_RT, though they do
>> not regress mainline performance as far as I can tell).  They offer
>> somewhere between 50-100% speedups in netperf performance, depending
>> on the test.
> 
> -tip testing found this boot hang:

I may have found the issue:  It looks like the hunk that initially disables interrupts in load_balance_newidle() was inadvertently applied to load_balance() instead during the
merge to linux-tip.  If you fold the following patch into my original patch, it should set
things right again.

-----

sched: fix merge problem with newidle enhancement patch

From: Gregory Haskins <ghaskins@novell.com>

commit cc8160c56843201891766660e3816d2e546c1b17 introduces a locking
enhancement for newidle.  However, one hunk misapplied to load_balance
instead of load_balance_newidle.  This fixes the issue.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/sched.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index f35d73c..f36406f 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -3459,15 +3459,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 
 	cpus_setall(*cpus);
 
-	schedstat_inc(sd, lb_count[CPU_NEWLY_IDLE]);
-
-	/*
-	 * We are in a preempt-disabled section, so dropping the lock/irq
-	 * here simply means that other cores may acquire the lock,
-	 * and interrupts may occur.
-	 */
-	spin_unlock_irq(&this_rq->lock);
