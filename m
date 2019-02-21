From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH RT 0/2] Add PINNED_HARD mode to hrtimers
Date: Thu, 21 Feb 2019 09:46:59 +0100
Message-ID: <20190221084659.GK21785@localhost.localdomain>
References: <20190214133716.10187-1-juri.lelli@redhat.com>
 <20190219171905.qrpr5uurayfqbehp@linutronix.de>
 <20190220074751.GJ21785@localhost.localdomain>
 <20190220153055.dt7vm47c2auove3d@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        bristot@redhat.com, williams@redhat.com
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190220153055.dt7vm47c2auove3d@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 20/02/19 16:30, Sebastian Andrzej Siewior wrote:
> On 2019-02-20 08:47:51 [+0100], Juri Lelli wrote:
> > > In this case you prepare the wakeup and then wake the CPU anyway. There
> > > should be no downside to this unless the housekeeping CPU is busy and in
> > > irq-off regions which would increase the latency. Also in case of
> > > 	cyclictest -d0
> > > 
> > > the one CPU would have to process all timers. So the latency will be
> > > worse compared to every CPU does its own wakeup. And on RT you probably
> > > do not want to do deep idle anyway.
> > 
> > Mmm, right. But, still very much dependent on the workload, I understand
> > you are saying? So, no one size fits all solution.
> 
> Now that I slept over it, I think it makes sense from RT point of view
> to always pin the timer. I'm not sure if we want to swap the sysctl or
> make the PINNED change like you suggested.

My thinking was that it would be nice to be able to discern between
timers coming from RT and !RT tasks so that the latter can be migrated
to housekeeping CPUs, leaving potentially isolated CPUs to deal with the
former only.

Not sure we can achieve this "best of both worlds" policy any way we set
the sysctl default to be.

Thanks,

- Juri
