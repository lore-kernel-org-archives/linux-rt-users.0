From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 2/4] Revert "timers: do not raise softirq
 unconditionally"
Date: Thu, 19 Mar 2015 09:17:09 +0100
Message-ID: <1426753029.4168.80.camel@gmail.com>
References: <20150317163541.080310081@goodmis.org>
	 <20150317163617.218582800@goodmis.org>
	 <20150317163551.3093b6c2@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150317163551.3093b6c2@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2015-03-17 at 16:35 -0400, Steven Rostedt wrote:
> On Tue, 17 Mar 2015 12:35:43 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > 3.10.70-rt75-rc2 stable review patch.
> > If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> 
> Here's the missing change log for this revert. I'll go back and add it
> in:
> 
> 
> An issue arisen that if a rt_mutex (spin_lock converted to a mutex
> in PREEMPT_RT) is taken in hard interrupt context, it could cause
> a false deadlock detection and trigger a BUG_ON() from the return
> value of task_blocks_on_rt_mutex() in rt_spin_lock_slowlock().
> 
> The problem is this:
> 
>     CPU0			CPU1
>     ----			----
>   spin_lock(A)
> 				spin_lock(A)
> 			[ blocks, but spins as owner on
> 			  CPU 0 is running ]
> 
> 				<interrupt>
> 					spin_trylock(B)
> 					[ succeeds ]
> 
>   spin_lock(B)
>   <blocks>
> 
> Now the deadlock detection triggers and follows the locking:
> 
>   Task X (on CPU0) blocked on spinlock B owned by task Y on
>   CPU1 (via the interrupt taking it with a try lock)
> 
>   The owner of B (Y) is blocked on spin_lock A (still spinning)
>   A is owned by task X (self). DEADLOCK detected! BUG_ON triggered.
> 
> This was caused by the code to try to not raise softirq unconditionally
> to allow NO_HZ_FULL to work. Unfortunately, reverting that patch causes
> NO_HZ_FULL to break again, but that's still better than triggering
> a BUG_ON().


(aw crap, let's go shopping)... so why is the one in timer.c ok?

	-Mike
