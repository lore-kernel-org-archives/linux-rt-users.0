From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RT PATCH] sched: rt: fix two possible deadlocks in
 push_irq_work_func
Date: Sun, 15 Nov 2015 09:26:14 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1511150925040.3761@nanos>
References: <1447469598-31876-1-git-send-email-yanjiang.jin@windriver.com> <20151113232512.53df431f@gandalf.local.home> <5646BB4A.50307@windriver.com> <alpine.DEB.2.11.1511150914240.3761@nanos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
	bigeasy@linutronix.de, peterz@infradead.org,
	linux-kernel@vger.kernel.org, jinyanjiang@gmail.com,
	stable-rt@vger.kernel.org, linux-rt-users@vger.kernel.org
To: yjin <yanjiang.jin@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1511150914240.3761@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 15 Nov 2015, Thomas Gleixner wrote:
> On Sat, 14 Nov 2015, yjin wrote:
> > > > Use raw_spin_{un,}lock_irq{save,restore} in push_irq_work_func() to
> > > > prevent following potentially deadlock scenario:
> > > Ug. No, the real fix is that the irq work is to be run from hard
> > > interrupt context.
> > But if so, we shouldn't call irq_work_tick() in run_timer_softirq(), right?
> 
> The work is marked IRQ_WORK_HARD_IRQ so it should be run from hard irq
> context. We only run the work, which is not marked IRQ_WORK_HARD_IRQ
> from the softirq on RT.

Which does not happen on MIPS as it uses the generic
arch_irq_work_has_interrupt() implementation which returns 'false'.

Thanks,

	tglx
