From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] just rename call_rcu_bh instead of making it a macro
Date: Wed, 26 Sep 2007 16:17:24 -0700
Message-ID: <20070926231724.GE10544@linux.vnet.ibm.com>
References: <1190830667.20235.5.camel@localhost.localdomain>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:49526 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845AbXIZXR0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2007 19:17:26 -0400
Content-Disposition: inline
In-Reply-To: <1190830667.20235.5.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Sep 26, 2007 at 02:17:47PM -0400, Steven Rostedt wrote:
> Seems that I found a box that has a config that passes call_rcu_bh as a
> function pointer (see net/sctp/sm_make_chunk.c), so declaring the
> call_rcu_bh has a macro function isn't good enough.
> 
> This patch makes it just another name of call_rcu for rcupreempt.

Looks good!

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Index: linux-2.6.23-rc8-rt1/include/linux/rcupreempt.h
> ===================================================================
> --- linux-2.6.23-rc8-rt1.orig/include/linux/rcupreempt.h
> +++ linux-2.6.23-rc8-rt1/include/linux/rcupreempt.h
> @@ -42,9 +42,14 @@
>  #include <linux/cpumask.h>
>  #include <linux/seqlock.h>
> 
> -#define rcu_qsctr_inc(cpu)
> -#define rcu_bh_qsctr_inc(cpu)
> -#define call_rcu_bh(head, rcu) call_rcu(head, rcu)
> +#define rcu_qsctr_inc(cpu)	do { } while (0)
> +#define rcu_bh_qsctr_inc(cpu)	do { } while (0)
> +/*
> + * Someone might want to pass call_rcu_bh as a function pointer.
> + * So this needs to just be a rename and not a macro function.
> + *  (no parentheses)
> + */
> +#define call_rcu_bh		 call_rcu
> 
>  extern void __rcu_read_lock(void);
>  extern void __rcu_read_unlock(void);
> 
> 
