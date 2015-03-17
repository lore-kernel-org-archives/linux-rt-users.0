From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH RT 26/39] scheduling while atomic in cgroup code
Date: Tue, 17 Mar 2015 16:10:11 -0400
Message-ID: <20150317201010.GB26043@windriver.com>
References: <20150312191307.081068717@goodmis.org>
 <20150312191411.381735145@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>,
	Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150312191411.381735145@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

[[PATCH RT 26/39] scheduling while atomic in cgroup code] On 12/03/2015 (Thu 15:13) Steven Rostedt wrote:

> 3.14.34-rt32-rc1 stable review patch.
> If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Mike Galbraith <umgwanakikbuti@gmail.com>
> 
> mm, memcg: make refill_stock() use get_cpu_light()

This looks like only 1/2 of Mike's original patch:

https://lkml.org/lkml/2014/6/21/11 

I suspect that is because 3.18 could only use 1/2 of it, and based on
the SOB lines, this is backported from 3.18.

The other half applies to 3.14 -- testing in progress; not sure about
the 3.10-rt and earlier....

P.
--

> 
> Nikita reported the following memcg scheduling while atomic bug:
> 
> Call Trace:
> [e22d5a90] [c0007ea8] show_stack+0x4c/0x168 (unreliable)
> [e22d5ad0] [c0618c04] __schedule_bug+0x94/0xb0
> [e22d5ae0] [c060b9ec] __schedule+0x530/0x550
> [e22d5bf0] [c060bacc] schedule+0x30/0xbc
> [e22d5c00] [c060ca24] rt_spin_lock_slowlock+0x180/0x27c
> [e22d5c70] [c00b39dc] res_counter_uncharge_until+0x40/0xc4
> [e22d5ca0] [c013ca88] drain_stock.isra.20+0x54/0x98
> [e22d5cc0] [c01402ac] __mem_cgroup_try_charge+0x2e8/0xbac
> [e22d5d70] [c01410d4] mem_cgroup_charge_common+0x3c/0x70
> [e22d5d90] [c0117284] __do_fault+0x38c/0x510
> [e22d5df0] [c011a5f4] handle_pte_fault+0x98/0x858
> [e22d5e50] [c060ed08] do_page_fault+0x42c/0x6fc
> [e22d5f40] [c000f5b4] handle_page_fault+0xc/0x80
> 
> What happens:
> 
>    refill_stock()
>       get_cpu_var()
>       drain_stock()
>          res_counter_uncharge()
>             res_counter_uncharge_until()
>                spin_lock() <== boom
> 
> Fix it by replacing get/put_cpu_var() with get/put_cpu_light().
> 
> Cc: stable-rt@vger.kernel.org
> Reported-by: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
> Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  mm/memcontrol.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index fa54408b66b2..be24d2d186fa 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2512,14 +2512,17 @@ static void __init memcg_stock_init(void)
>   */
>  static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
> -	struct memcg_stock_pcp *stock = &get_cpu_var(memcg_stock);
> +	struct memcg_stock_pcp *stock;
> +	int cpu = get_cpu_light();
> +
> +	stock = &per_cpu(memcg_stock, cpu);
>  
>  	if (stock->cached != memcg) { /* reset if necessary */
>  		drain_stock(stock);
>  		stock->cached = memcg;
>  	}
>  	stock->nr_pages += nr_pages;
> -	put_cpu_var(memcg_stock);
> +	put_cpu_light();
>  }
>  
>  /*
> -- 
> 2.1.4
> 
> 
