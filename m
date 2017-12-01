From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH RT] arm*: disable NEON in kernel mode
Date: Fri, 1 Dec 2017 17:58:45 +0000
Message-ID: <20171201175844.GT22781@e103592.cambridge.arm.com>
References: <20171130142216.GB12606@linutronix.de>
 <20171130143028.GA1351@linutronix.de>
 <20171201104331.GB1612@linutronix.de>
 <20171201134506.GF1612@linutronix.de>
 <20171201141827.yip6pl3tt7kxzek7@lakrids.cambridge.arm.com>
 <20171201143648.GK1612@linutronix.de>
 <24FDBFF1-8351-46FC-885A-6B6F972F4C6C@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <24FDBFF1-8351-46FC-885A-6B6F972F4C6C@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Dec 01, 2017 at 03:03:35PM +0000, Ard Biesheuvel wrote:
> 
> l
> > On 1 Dec 2017, at 14:36, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > 
> >> On 2017-12-01 14:18:28 [+0000], Mark Rutland wrote:
> >> [Adding Ard, who wrote the NEON crypto code]
> >> 
> >>> On Fri, Dec 01, 2017 at 02:45:06PM +0100, Sebastian Andrzej Siewior wrote:
> >>> +arm folks, to let you know
> >>> 
> >>>> On 2017-12-01 11:43:32 [+0100], To linux-rt-users@vger.kernel.org wrote:
> >>>> NEON in kernel mode is used by the crypto algorithms and raid6 code.
> >>>> While the raid6 code looks okay, the crypto algorithms do not: NEON
> >>>> is enabled on first invocation and may allocate/free/map memory before
> >>>> the NEON mode is disabled again.
> >> 
> >> Could you elaborate on why this is a problem?
> >> 
> >> I guess this is because kernel_neon_{begin,end}() disable preemption?
> >> 
> >> ... is this specific to RT?
> > 
> > It is RT specific, yes. One thing are the unbounded latencies since
> > everything in this preempt_disable section can take time depending on
> > the size of the request.
> > The other thing is code like in
> >  arch/arm64/crypto/aes-ce-ccm-glue.c:ccm_encrypt()
> > 
> > where within this preempt_disable() section skcipher_walk_done() is
> > invoked. That function can allocate/free/map memory which is okay for
> > !RT but is not for RT. I tried to break those loops for x86 [0] and I
> > simply didn't had the time to do the same for ARM. I am aware that
> > store/restore of the NEON registers (as SSE and AVX) is expensive and
> > doing a lot of operations in one go is desired.
> 
> I wouldn’t mind fixing the code instead. We never disable the neon,
> but only stack the contents of the registers the first time, and
> unstack them only before returning to userland (with the exception of
> nested neon use in softirq context). When this code was introduced,
> we always stacked/unstacked the whole register file eagerly every
> time.

+1, at least for arm64.  I don't see a really compelling reason for
holding kernel-mode NEON around memory management now that we have a
strict save-once-restore-lazily model.

This may not work so well for arm though -- I haven't looked at that
code for a while.


If there is memory manamement in any core loop, you already lost
the performance battle, and an extra
kernel_neon_end()+kernel_neon_begin() may not be that catastrophic.

[...]

Cheers
---Dave
