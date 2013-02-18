From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: RCU?: Scheduling while atomic with 3.4.23-rt33
Date: Mon, 18 Feb 2013 12:16:41 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302181214250.22263@ionos>
References: <4738617.pBMCEJ5E3K@dabox>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4738617.pBMCEJ5E3K@dabox>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 18 Feb 2013, Tim Sander wrote:
> Here is a transtribed backtrace for easier reading:
> c0010fac t dump_backtrace
> c022c188 T dump_stack
> c022c71c t __schedule_bug
> c022fb28 t __schedule
> c0230644 t rt_spin_lock_slowlock
> c0230ba8 T rt_spin_lock
> c003a9b8 T __wake_up
> c0052a44 t invoke_rcu_callbacks
> c0053764 T rcu_check_callbacks
> c0026060 T update_process_times

That's due to CONFIG_TINY_PREEMPT_RCU=y. That's a known issue, which
has been fixed in 3.6-rt.

Steven, could you backport that to 3.2/3.4 please ?

Thanks,

	tglx
