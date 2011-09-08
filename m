From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] sched, rt: fix migrate_enable() thinko
Date: Thu, 08 Sep 2011 06:58:45 +0200
Message-ID: <1315457925.10591.3.camel@marge.simson.net>
References: <1313232790.25267.7.camel@twins>
	 <1314108763.6689.4.camel@marge.simson.net>  <4E68243C.7000404@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: frank.rowand@am.sony.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E68243C.7000404@am.sony.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2011-09-07 at 19:11 -0700, Frank Rowand wrote:

> Fix compile error for CONFIG_SMP=n

Guilty as charged you honor.

Acked-by: Mike Galbraith <efault@gmx.de>

> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> ---
>  kernel/sched_debug.c |    2 	2 +	0 -	0 !
>  1 file changed, 2 insertions(+)
> 
> Index: b/kernel/sched_debug.c
> ===================================================================
> --- a/kernel/sched_debug.c
> +++ b/kernel/sched_debug.c
> @@ -235,7 +235,9 @@ void print_rt_rq(struct seq_file *m, int
>  	P(rt_throttled);
>  	PN(rt_time);
>  	PN(rt_runtime);
> +#ifdef CONFIG_SMP
>  	P(rt_nr_migratory);
> +#endif
>  
>  #undef PN
>  #undef P
> 
