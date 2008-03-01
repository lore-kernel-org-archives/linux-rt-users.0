From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 4/6] Preempt-RCU: Implementation
Date: Sat, 1 Mar 2008 16:07:38 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0803011602300.30335@gandalf.stny.rr.com>
References: <20071213170348.GA25981@in.ibm.com> <20071213171658.GE25981@in.ibm.com>
 <200802290534.57040.zippel@linux-m68k.org> <20080229045328.GA18687@linux.vnet.ibm.com>
 <Pine.LNX.4.64.0802291330590.2723@scrub.home> <20080301193903.GC15887@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Roman Zippel <zippel@linux-m68k.org>, ego@in.ibm.com,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Ted Tso <tytso@us.ibm.com>, dvhltc@us.ibm.com,
	Oleg Nesterov <oleg@tv-sign.ru>,
	Andrew Morton <akpm@linux-foundation.org>, bunk@kernel.org,
	Josh Triplett <josh@freedesktop.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762591AbYCAVHw@vger.kernel.org>
In-Reply-To: <20080301193903.GC15887@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Sat, 1 Mar 2008, Paul E. McKenney wrote:
> Is this what you had in mind?  I don't have any way to test on a
> system not supporting CONFIG_PREEMPT, but seems to work on x86.
>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> ---
>
>  init/Kconfig           |   34 +++-------------------------------
>  kernel/Kconfig.preempt |   15 +++++++++++++++
>  2 files changed, 18 insertions(+), 31 deletions(-)
>
> diff -urpNa -X dontdiff linux-2.6.25-rc3/init/Kconfig linux-2.6.25-rc3-preempt_rcu/init/Kconfig
> --- linux-2.6.25-rc3/init/Kconfig	2008-02-26 16:58:42.000000000 -0800
> +++ linux-2.6.25-rc3-preempt_rcu/init/Kconfig	2008-03-01 11:30:59.000000000 -0800
> @@ -860,38 +860,10 @@ source "block/Kconfig"
>  config PREEMPT_NOTIFIERS
>  	bool
>
> -choice
> -	prompt "RCU implementation type:"
> -	default CLASSIC_RCU
> -	help
> -	  This allows you to choose either the classic RCU implementation
> -	  that is designed for best read-side performance on non-realtime
> -	  systems, or the preemptible RCU implementation for best latency
> -	  on realtime systems.  Note that some kernel preemption modes
> -	  will restrict your choice.
> -
> -	  Select the default if you are unsure.
> -
>  config CLASSIC_RCU
> -	bool "Classic RCU"
> +	def_bool !PREEMPT_RCU
>  	help
>  	  This option selects the classic RCU implementation that is
>  	  designed for best read-side performance on non-realtime
> -	  systems.

Actually Paul, you don't need to make this an "option". Simply the default
if PREEMPT_RCU is not selected. In otherwords, no prompt.

	config CLASSIC_RCU
	  bool
	  depends on !PREEMPT_RCU
	  default y

Then, have the PREEMPT_RCU defined down below (as you already did), and
have it be the only option. That is, you can have normal RCU or select
to have PREEMPT_RCU.

If the user selects PREEMPT_RCU, CLASSIC_RCU will be unselected.

-- Steve

> -
> -	  Say Y if you are unsure.
> -
> -config PREEMPT_RCU
> -	bool "Preemptible RCU"
> -	depends on PREEMPT
> -	help
> -	  This option reduces the latency of the kernel by making certain
> -	  RCU sections preemptible. Normally RCU code is non-preemptible, if
> -	  this option is selected then read-only RCU sections become
> -	  preemptible. This helps latency, but may expose bugs due to
> -	  now-naive assumptions about each RCU read-side critical section
> -	  remaining on a given CPU through its execution.
> -
> -	  Say N if you are unsure.
> -
> -endchoice
> +	  systems.  Classic RCU is the default.  Note that the
> +	  PREEMPT_RCU symbol is used to select/deselect this option.
> diff -urpNa -X dontdiff linux-2.6.25-rc3/kernel/Kconfig.preempt linux-2.6.25-rc3-preempt_rcu/kernel/Kconfig.preempt
> --- linux-2.6.25-rc3/kernel/Kconfig.preempt	2008-02-26 16:58:42.000000000 -0800
> +++ linux-2.6.25-rc3-preempt_rcu/kernel/Kconfig.preempt	2008-03-01 11:35:39.000000000 -0800
> @@ -52,8 +52,23 @@ config PREEMPT
>
>  endchoice
>
> +config PREEMPT_RCU
> +	bool "Preemptible RCU"
> +	depends on PREEMPT
> +	default n
> +	help
> +	  This option reduces the latency of the kernel by making certain
> +	  RCU sections preemptible. Normally RCU code is non-preemptible, if
> +	  this option is selected then read-only RCU sections become
> +	  preemptible. This helps latency, but may expose bugs due to
> +	  now-naive assumptions about each RCU read-side critical section
> +	  remaining on a given CPU through its execution.
> +
> +	  Say N if you are unsure.
> +
>  config RCU_TRACE
>  	bool "Enable tracing for RCU - currently stats in debugfs"
> +	depends on PREEMPT_RCU
>  	select DEBUG_FS
>  	default y
>  	help
>
