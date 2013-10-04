From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2] rt: Don't call schedule_work_on in preemption
 disabled context
Date: Fri, 4 Oct 2013 17:46:16 +0200
Message-ID: <20131004154616.GJ19953@linutronix.de>
References: <1379365759-5743-1-git-send-email-yang.shi@windriver.com>
 <1379365759-5743-2-git-send-email-yang.shi@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, paul.gortmaker@windriver.com
To: Yang Shi <yang.shi@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54756 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754729Ab3JDPqT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 11:46:19 -0400
Content-Disposition: inline
In-Reply-To: <1379365759-5743-2-git-send-email-yang.shi@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Yang Shi | 2013-09-16 14:09:18 [-0700]:

>---
> mm/memcontrol.c |    5 ++++-
> 1 files changed, 4 insertions(+), 1 deletions(-)
>
>diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>index 82a187a..9f7cc0f 100644
>--- a/mm/memcontrol.c
>+++ b/mm/memcontrol.c
>@@ -2453,8 +2453,11 @@ static void drain_all_stock(struct mem_cgroup *root_memcg, bool sync)
> 		if (!test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
> 			if (cpu == curcpu)
> 				drain_local_stock(&stock->work);
>-			else
>+			else {
>+				preempt_enable();
> 				schedule_work_on(cpu, &stock->work);
>+				preempt_disable();
>+			}
> 		}

What ensures that you don't switch CPUs between preempt_enable() &
preempt_disable() and is curcpu != smp_processor_id() ?

What about removing the get_cpu() & put_cpu() calls (and the shortcut)?

> 	}
> 	put_cpu();

Sebastian
