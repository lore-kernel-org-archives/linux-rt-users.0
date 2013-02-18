From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: RCU?: Scheduling while atomic with 3.4.23-rt33
Date: Mon, 18 Feb 2013 10:32:54 -0500
Message-ID: <1361201574.23152.156.camel@gandalf.local.home>
References: <4738617.pBMCEJ5E3K@dabox>
	 <alpine.LFD.2.02.1302181214250.22263@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Tim Sander <tim.sander@hbm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1302181214250.22263@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2013-02-18 at 12:16 +0100, Thomas Gleixner wrote:
> On Mon, 18 Feb 2013, Tim Sander wrote:
> > Here is a transtribed backtrace for easier reading:
> > c0010fac t dump_backtrace
> > c022c188 T dump_stack
> > c022c71c t __schedule_bug
> > c022fb28 t __schedule
> > c0230644 t rt_spin_lock_slowlock
> > c0230ba8 T rt_spin_lock
> > c003a9b8 T __wake_up
> > c0052a44 t invoke_rcu_callbacks
> > c0053764 T rcu_check_callbacks
> > c0026060 T update_process_times
> 
> That's due to CONFIG_TINY_PREEMPT_RCU=y. That's a known issue, which
> has been fixed in 3.6-rt.
> 
> Steven, could you backport that to 3.2/3.4 please ?
> 

I'm currently trying to get -rt up with the latest stable releases (Greg
is too damn fast). I'll add this in an -rc later today if I get a
chance. Otherwise it may have to wait till next week, or perhaps I can
work on it while at ELC (I leave tomorrow). Keynotes are always a good
time to get tedious tasks done online.

-- Steve
