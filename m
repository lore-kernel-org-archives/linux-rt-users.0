From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Date: Tue, 9 Oct 2018 12:51:12 +0200
Message-ID: <20181009105112.bhqlrabdt5ae5qmm@linutronix.de>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181009092434.26221-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-10-09 11:24:26 [+0200], Juri Lelli wrote:
> The main concerns I have with the current approach is that, being based
> on mutex.c, it's both
> 
>  - not linked with futexes
>  - not involving "legacy" priority inheritance (rt_mutex.c)
> 
> I believe one of the main reasons Peter started this on mutexes is to
> have better coverage of potential problems (which I can assure everybody
> it had). I'm not yet sure what should we do moving forward, and this is
> exactly what I'd be pleased to hear your opinions on.

wasn't the idea that once it works to get rid of rt_mutex?

Sebastian
