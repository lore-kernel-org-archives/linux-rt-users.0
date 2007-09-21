From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC 1/9] RCU: Split API to permit multiple RCU
	implementations
Date: Fri, 21 Sep 2007 00:14:56 -0400
Message-ID: <20070921041456.GA15697@goodmis.org>
References: <20070910183004.GA3299@linux.vnet.ibm.com> <20070910183208.GA3819@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	mingo@elte.hu, akpm@linux-foundation.org, dipankar@in.ibm.com,
	josht@linux.vnet.ibm.com, tytso@us.ibm.com, dvhltc@us.ibm.com,
	tglx@linutronix.de, a.p.zijlstra@chello.nl, bunk@kernel.org,
	ego@in.ibm.com, oleg@tv-sign.ru, srostedt@redhat.com
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:35411 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbXIUEPD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Sep 2007 00:15:03 -0400
Content-Disposition: inline
In-Reply-To: <20070910183208.GA3819@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Sep 10, 2007 at 11:32:08AM -0700, Paul E. McKenney wrote:

[nitpick and two part mail ]

> 
> diff -urpNa -X dontdiff linux-2.6.22/include/linux/rcuclassic.h linux-2.6.22-a-splitclassic/include/linux/rcuclassic.h
> --- linux-2.6.22/include/linux/rcuclassic.h	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.22-a-splitclassic/include/linux/rcuclassic.h	2007-08-22 14:42:23.000000000 -0700
> @@ -0,0 +1,149 @@

[snip]

> +		local_bh_enable(); \
> +	} while (0)
> +
> +#define __synchronize_sched() synchronize_rcu()
> +
> +extern void __rcu_init(void);
> +extern void rcu_check_callbacks(int cpu, int user);
> +extern void rcu_restart_cpu(int cpu);
> +extern long rcu_batches_completed(void);
> +extern long rcu_batches_completed_bh(void);
> +

> +#endif /* __KERNEL__ */
> +#endif /* __LINUX_RCUCLASSIC_H */
> diff -urpNa -X dontdiff linux-2.6.22/include/linux/rcupdate.h linux-2.6.22-a-splitclassic/include/linux/rcupdate.h
> --- linux-2.6.22/include/linux/rcupdate.h	2007-07-08 16:32:17.000000000 -0700
> +++ linux-2.6.22-a-splitclassic/include/linux/rcupdate.h	2007-07-19 14:02:36.000000000 -0700

[snip]

>   */
> -#define synchronize_sched() synchronize_rcu()
> +#define synchronize_sched() __synchronize_sched()
>  
> -extern void rcu_init(void);
> -extern void rcu_check_callbacks(int cpu, int user);
> -extern void rcu_restart_cpu(int cpu);
> -extern long rcu_batches_completed(void);
> -extern long rcu_batches_completed_bh(void);

Why is rcu_batches_completed and rcu_batches_completed_bh moved from
rcupdate.h to rcuclassic.h?

[ continued ...]

-- Steve
