From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [patch]  sched,rt: __always_inline preemptible_lazy()
Date: Mon, 22 Feb 2016 05:03:05 +0100
Message-ID: <1456113785.3706.5.camel@gmail.com>
References: <00a501d16d22$30045140$900cf3c0$@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: 'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>,
	'Thomas Gleixner' <tglx@linutronix.de>,
	'LKML' <linux-kernel@vger.kernel.org>,
	'linux-rt-users' <linux-rt-users@vger.kernel.org>
To: Hillf Danton <hillf.zj@alibaba-inc.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33801 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587AbcBVEDI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 21 Feb 2016 23:03:08 -0500
In-Reply-To: <00a501d16d22$30045140$900cf3c0$@alibaba-inc.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2016-02-22 at 11:36 +0800, Hillf Danton wrote:
> > 
> > homer: # nm kernel/sched/core.o|grep preemptible_lazy
> > 00000000000000b5 t preemptible_lazy
> > 
> > echo wakeup_rt > current_tracer ==> Welcome to infinity.
> > 
> > Signed-off-bx: Mike Galbraith <umgwanakikbuti@gmail.com>
> > ---
> 
> Fat finger?

Yeah, my fingers don't take direction all that well.

> BTW, would you please make a better description of the
> problem this patch is trying to address/fix?

Ok, I thought it was clear what happens.

sched,rt: __always_inline preemptible_lazy()

Functions called within a notrace function must either also be
notrace or be inlined, lest recursion blow the stack.

homer: # nm kernel/sched/core.o|grep preemptible_lazy
00000000000000b5 t preemptible_lazy

echo wakeup_rt > current_tracer ==> Welcome to infinity.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 kernel/sched/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3469,7 +3469,7 @@ static void __sched notrace preempt_sche
  * set by a RT task. Oterwise we try to avoid beeing scheduled out as long as
  * preempt_lazy_count counter >0.
  */
-static int preemptible_lazy(void)
+static __always_inline int preemptible_lazy(void)
 {
 	if (test_thread_flag(TIF_NEED_RESCHED))
 		return 1;
