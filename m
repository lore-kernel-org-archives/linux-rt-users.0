From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Date: Tue, 9 Oct 2018 11:44:41 +0200
Message-ID: <20181009094441.GI5663@hirez.programming.kicks-ass.net>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@redhat.com, rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181009092434.26221-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Oct 09, 2018 at 11:24:26AM +0200, Juri Lelli wrote:
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

Well that, and mutex was 'simple', I didn't have to go rip out all the
legacy PI crud.

If this all ends up working well, the solution is 'simple' and we can
simply copy mutex to rt_mutex or something along those lines if we want
to keep the distinction between them. Alternatively we simply delete
rt_mutex.

Thanks for reviving this.. it's been an 'interesting' year and a half
since I wrote all this and I've really not had time to work on it.
