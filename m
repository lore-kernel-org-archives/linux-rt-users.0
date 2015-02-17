From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [v3.10-rt / v3.12-rt] scheduling while atomic in cgroup code
Date: Tue, 17 Feb 2015 10:28:32 +0100
Message-ID: <20150217092832.GC26177@linutronix.de>
References: <53A50218.6020506@dev.rtsoft.ru>
 <1403338188.6766.6.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>,
	linux-rt-users@vger.kernel.org,
	'Alexey Lugovskoy' <lugovskoy@dev.rtsoft.ru>,
	Konstantin Kholopov <kkholopov@dev.rtsoft.ru>,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1403338188.6766.6.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Mike Galbraith | 2014-06-21 10:09:48 [+0200]:

>--- a/mm/memcontrol.c
>+++ b/mm/memcontrol.c
>@@ -2398,16 +2398,18 @@ static bool consume_stock(struct mem_cgr
> {
> 	struct memcg_stock_pcp *stock;
> 	bool ret = true;
>+	int cpu;
> 
> 	if (nr_pages > CHARGE_BATCH)
> 		return false;
> 
>-	stock = &get_cpu_var(memcg_stock);
>+	cpu = get_cpu_light();
>+	stock = &per_cpu(memcg_stock, cpu);
> 	if (memcg == stock->cached && stock->nr_pages >= nr_pages)
> 		stock->nr_pages -= nr_pages;
> 	else /* need to call res_counter_charge */
> 		ret = false;
>-	put_cpu_var(memcg_stock);
>+	put_cpu_light();
> 	return ret;
> }

I am not taking this chunk. That preempt_disable() is lower weight
and there is nothing happening that does not work with it.

>@@ -2457,14 +2459,17 @@ static void __init memcg_stock_init(void
>  */
> static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> {
>-	struct memcg_stock_pcp *stock = &get_cpu_var(memcg_stock);
>+	struct memcg_stock_pcp *stock;
>+	int cpu = get_cpu_light();
>+
>+	stock = &per_cpu(memcg_stock, cpu);
> 
> 	if (stock->cached != memcg) { /* reset if necessary */
> 		drain_stock(stock);
> 		stock->cached = memcg;
> 	}

I am a little more worried that drain_stock() could be called more than
once on the same CPU.
- memcg_cpu_hotplug_callback() doesn't disable preemption
- drain_local_stock() doesn't as well

so maybe it doesn't matter.

> 	stock->nr_pages += nr_pages;
>-	put_cpu_var(memcg_stock);
>+	put_cpu_light();
> }

Sebastian
