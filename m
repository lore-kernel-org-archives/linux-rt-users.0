From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] 4.4-rc6-rt1
Date: Sat, 16 Jan 2016 14:23:22 +0100
Message-ID: <1452950602.13755.9.camel@gmail.com>
References: <20151223225755.GA21121@linutronix.de>
	 <20151231102441.581ce1e1@sluggy.hsv.redhat.com>
	 <1451632781.9800.22.camel@gmail.com> <20160113175845.GK29964@linutronix.de>
	 <20160114141744.GB17776@linutronix.de>
	 <1452781751.3460.102.camel@gmail.com>
	 <alpine.DEB.2.11.1601141528550.3575@nanos>
	 <1452783422.3611.8.camel@gmail.com>
	 <alpine.DEB.2.11.1601141606260.3575@nanos>
	 <1452787507.15549.16.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38433 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbcAPNX1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 16 Jan 2016 08:23:27 -0500
In-Reply-To: <1452787507.15549.16.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2016-01-14 at 17:05 +0100, Mike Galbraith wrote:

> This is virgin -rt1 modulo fixlet applied to v4.4.0, built with the
> .config from v4.4.0 that built it (modulo RT_FULL) rebuilding itself
> via make -j8.
> 
> homer:/root # vmstat 10
> procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
>  0  1      0 14742988 179832 680792    0    0   634    25  326 1196  2  1 89  8  0
>  8  0      0 14476084 179848 701632    0    0   814   525 2421 12314 11  1 87  1  0
>  8  0      0 14483232 179864 712656    0    0   165  1628 2404 12320 11  1 87  1  0
>  8  0      0 14493336 180008 727836    0    0   141   762 2328 11306 11  1 87  0  0
>  8  0      0 14456436 180024 738356    0    0   159  1478 2336 11939 11  1 87  0  0
> 
> Way too idle, taking forever.

It now being the weekend...

sched: Disable default set_cpus_allowed() method during update_migrate_disable().

update_migrate_disable() calls class::set_cpus_allowed(), when that method
is set_cpus_allowed_common(), writing to ->cpus_allowed defeats the intent
of migrate_disable(), permanently disabling migration instead.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 kernel/sched/core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1205,6 +1205,8 @@ static int migration_cpu_stop(void *data
  */
 void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask)
 {
+	if (__migrate_disabled(p))
+		return;
 	cpumask_copy(&p->cpus_allowed, new_mask);
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
