From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RT] arm*: disable NEON in kernel mode
Date: Fri, 1 Dec 2017 18:14:58 +0100
Message-ID: <20171201171458.3a2acsltiq54gvuu@hirez.programming.kicks-ass.net>
References: <20171130142216.GB12606@linutronix.de>
 <20171130143028.GA1351@linutronix.de>
 <20171201104331.GB1612@linutronix.de>
 <20171201134506.GF1612@linutronix.de>
 <20171201141827.yip6pl3tt7kxzek7@lakrids.cambridge.arm.com>
 <20171201143648.GK1612@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Rutland <mark.rutland@arm.com>,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        ard.biesheuvel@linaro.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171201143648.GK1612@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Dec 01, 2017 at 03:36:48PM +0100, Sebastian Andrzej Siewior wrote:
> On 2017-12-01 14:18:28 [+0000], Mark Rutland wrote:
> > [Adding Ard, who wrote the NEON crypto code]
> > 
> > On Fri, Dec 01, 2017 at 02:45:06PM +0100, Sebastian Andrzej Siewior wrote:
> > > +arm folks, to let you know
> > > 
> > > On 2017-12-01 11:43:32 [+0100], To linux-rt-users@vger.kernel.org wrote:
> > > > NEON in kernel mode is used by the crypto algorithms and raid6 code.
> > > > While the raid6 code looks okay, the crypto algorithms do not: NEON
> > > > is enabled on first invocation and may allocate/free/map memory before
> > > > the NEON mode is disabled again.
> > 
> > Could you elaborate on why this is a problem?
> > 
> > I guess this is because kernel_neon_{begin,end}() disable preemption?
> > 
> > ... is this specific to RT?
> 
> It is RT specific, yes. One thing are the unbounded latencies since
> everything in this preempt_disable section can take time depending on
> the size of the request.

Well, PREEMPT cares about that too.
