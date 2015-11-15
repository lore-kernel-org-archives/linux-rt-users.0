From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RT PATCH] sched: rt: fix two possible deadlocks in
 push_irq_work_func
Date: Sun, 15 Nov 2015 09:15:27 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1511150914240.3761@nanos>
References: <1447469598-31876-1-git-send-email-yanjiang.jin@windriver.com> <20151113232512.53df431f@gandalf.local.home> <5646BB4A.50307@windriver.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2083429900-1447575328=:3761"
Cc: Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
	bigeasy@linutronix.de, peterz@infradead.org,
	linux-kernel@vger.kernel.org, jinyanjiang@gmail.com,
	stable-rt@vger.kernel.org, linux-rt-users@vger.kernel.org
To: yjin <yanjiang.jin@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5646BB4A.50307@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2083429900-1447575328=:3761
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 14 Nov 2015, yjin wrote:
> On 2015年11月14日 12:25, Steven Rostedt wrote:
> > On Sat, 14 Nov 2015 10:53:18 +0800
> > <yanjiang.jin@windriver.com> wrote:
> > 
> > > From: Yanjiang Jin <yanjiang.jin@windriver.com>
> > > 
> > > This can only happen in RT kernel due to run_timer_softirq() calls
> > > irq_work_tick() when CONFIG_PREEMPT_RT_FULL is enabled as below:
> > > 
> > > static void run_timer_softirq(struct softirq_action *h)
> > > {
> > > ........
> > > if defined(CONFIG_IRQ_WORK) && defined(CONFIG_PREEMPT_RT_FULL)
> > >          irq_work_tick();
> > > endif
> > > ........
> > > }
> > > 
> > > Use raw_spin_{un,}lock_irq{save,restore} in push_irq_work_func() to
> > > prevent following potentially deadlock scenario:
> > Ug. No, the real fix is that the irq work is to be run from hard
> > interrupt context.
> But if so, we shouldn't call irq_work_tick() in run_timer_softirq(), right?

The work is marked IRQ_WORK_HARD_IRQ so it should be run from hard irq
context. We only run the work, which is not marked IRQ_WORK_HARD_IRQ
from the softirq on RT.
 
Thanks,

	tglx
--8323329-2083429900-1447575328=:3761--
