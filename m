From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH RT 0/2] Add PINNED_HARD mode to hrtimers
Date: Wed, 20 Feb 2019 08:47:51 +0100
Message-ID: <20190220074751.GJ21785@localhost.localdomain>
References: <20190214133716.10187-1-juri.lelli@redhat.com>
 <20190219171905.qrpr5uurayfqbehp@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        bristot@redhat.com, williams@redhat.com
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190219171905.qrpr5uurayfqbehp@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 19/02/19 18:19, Sebastian Andrzej Siewior wrote:
> On 2019-02-14 14:37:14 [+0100], Juri Lelli wrote:
> > Hi,
> Hi,
> 
> > Now, I'm sending this and an RFC, as I'm wondering if the first behavior
> > is actually what we want, and it is not odd at all for reasons that are
> > not evident to me at the moment. In this case this posting might also
> > function as a question: why we need things to work as they are today?
> 
> There is /proc/sys/kernel/timer_migration which should disable this but
> I think you know that already.
> 
> So this is a NO_HZ feature. Basically try to move all the timers to a
> designated CPU so all others can deep idle while one CPU does the work.
> Ideally you have no timer which is pending / will expire if you go idle.
> And then, once the timer fires the housekeeping CPU does the work so
> chances are that the CPU, that programmed the timer, may remain idle.

Right.

> In this case you prepare the wakeup and then wake the CPU anyway. There
> should be no downside to this unless the housekeeping CPU is busy and in
> irq-off regions which would increase the latency. Also in case of
> 	cyclictest -d0
> 
> the one CPU would have to process all timers. So the latency will be
> worse compared to every CPU does its own wakeup. And on RT you probably
> do not want to do deep idle anyway.

Mmm, right. But, still very much dependent on the workload, I understand
you are saying? So, no one size fits all solution.

Thanks,

- Juri
