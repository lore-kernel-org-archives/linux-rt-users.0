From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH RT 0/2] Add PINNED_HARD mode to hrtimers
Date: Wed, 20 Feb 2019 16:30:56 +0100
Message-ID: <20190220153055.dt7vm47c2auove3d@linutronix.de>
References: <20190214133716.10187-1-juri.lelli@redhat.com>
 <20190219171905.qrpr5uurayfqbehp@linutronix.de>
 <20190220074751.GJ21785@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        bristot@redhat.com, williams@redhat.com
To: Juri Lelli <juri.lelli@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190220074751.GJ21785@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2019-02-20 08:47:51 [+0100], Juri Lelli wrote:
> > In this case you prepare the wakeup and then wake the CPU anyway. There
> > should be no downside to this unless the housekeeping CPU is busy and in
> > irq-off regions which would increase the latency. Also in case of
> > 	cyclictest -d0
> > 
> > the one CPU would have to process all timers. So the latency will be
> > worse compared to every CPU does its own wakeup. And on RT you probably
> > do not want to do deep idle anyway.
> 
> Mmm, right. But, still very much dependent on the workload, I understand
> you are saying? So, no one size fits all solution.

Now that I slept over it, I think it makes sense from RT point of view
to always pin the timer. I'm not sure if we want to swap the sysctl or
make the PINNED change like you suggested.
 
> Thanks,
> 
> - Juri

Sebastian
