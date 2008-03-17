From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] fix misplaced mb() in rcu_enter/exit_nohz()
Date: Mon, 17 Mar 2008 14:09:06 +1100
Message-ID: <200803171409.08148.nickpiggin@yahoo.com.au>
References: <20080317010821.GA29875@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org, mingo@elte.hu, ego@in.ibm.com,
	dipankar@in.ibm.com, tytso@us.ibm.com, dvhltc@us.ibm.com,
	oleg@tv-sign.ru, akpm@linux-foundation.org, josh@freedesktop.org,
	tglx@linutronix.de, niv@us.ibm.com
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754146AbYCQFfO@vger.kernel.org>
In-Reply-To: <20080317010821.GA29875@linux.vnet.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Monday 17 March 2008 12:08, Paul E. McKenney wrote:
> Hello!
>
> In the process of writing up the mechanical proof of correctness for the
> dynticks/preemptable-RCU interface, I noticed misplaced memory barriers
> in rcu_enter_nohz() and rcu_exit_nohz().  This patch puts them in the
> right place and adds a comment.  The key thing to keep in mind is that
> rcu_enter_nohz() is -exiting- the mode that can legally execute RCU
> read-side critical sections.  The memory barrier must be between any
> potential RCU read-side critical sections and the increment of the per-CPU
> dynticks_progress_counter, and thus must come -before- this increment.
> And vice versa for rcu_exit_nohz().
>
> The locking in the scheduler is probably saving us for the moment.
>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> ---
>
>  rcupreempt.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff -urpNa -X dontdiff linux-2.6.25-rc6/include/linux/rcupreempt.h
> linux-2.6.25-rc6-rcu_nohz-fix/include/linux/rcupreempt.h ---
> linux-2.6.25-rc6/include/linux/rcupreempt.h	2008-03-16 17:45:16.000000000
> -0700 +++
> linux-2.6.25-rc6-rcu_nohz-fix/include/linux/rcupreempt.h	2008-03-16
> 17:59:24.000000000 -0700 @@ -87,15 +87,15 @@ DECLARE_PER_CPU(long,
> dynticks_progress_
>
>  static inline void rcu_enter_nohz(void)
>  {
> +	mb(); /* CPUs seeing ++ must see prior RCU read-side crit sects */
>  	__get_cpu_var(dynticks_progress_counter)++;
>  	WARN_ON(__get_cpu_var(dynticks_progress_counter) & 0x1);
> -	mb();
>  }
>
>  static inline void rcu_exit_nohz(void)
>  {
> -	mb();
>  	__get_cpu_var(dynticks_progress_counter)++;
> +	mb(); /* CPUs seeing ++ must see subsequent RCU read-side crit sects */
>  	WARN_ON(!(__get_cpu_var(dynticks_progress_counter) & 0x1));
>  }

Can you make these smp_mb() as well?

Thanks,
Nick
