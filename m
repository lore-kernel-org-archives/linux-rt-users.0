From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT v2] x86/mce: Defer mce wakeups to threads for
 PREEMPT_RT
Date: Thu, 02 May 2013 10:33:19 -0400
Message-ID: <1367505199.30667.132.camel@gandalf.local.home>
References: <1365705214.9609.58.camel@gandalf.local.home>
	 <20130426084137.GC20927@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Mauro Carvalho Chehab <mchehab@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130426084137.GC20927@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2013-04-26 at 10:41 +0200, Sebastian Andrzej Siewior wrote:
> * Steven Rostedt | 2013-04-11 14:33:34 [-0400]:
> 
> >As wait queue locks are notorious for long hold times, we can not
> >convert them to raw_spin_locks without causing issues with -rt. But
> >Thomas has created a "simple-wait" structure that uses raw spin locks
> >which may have been a good fit.
> >
> >Unfortunately, wait queues are not the only issue, as the mce_notify_irq
> >also does a schedule_work(), which grabs the workqueue spin locks that
> >have the exact same issue.
> 
> mce_notify_irq() can use simple_waitqueue, no?

Yeah, and I went down that path.

But it also schedules work, which has the issue.

> The other issue is that mce_report_event() is scheduling a per-cpu
> workqueue (mce_schedule_work) in case of a memory fault. This has the
> same issue.

Yeah, that looks like it can be an issue too. I wonder if we can use the
same thread and use flags check what to do. Atomically set the flag for
the function to perform, and then have the thread clear it before doing
the function and only go to sleep when all flags are cleared.

-- Steve
