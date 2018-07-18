From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Date: Wed, 18 Jul 2018 12:36:57 +0200
Message-ID: <20180718103657.zyqinxambp5n3tv6@linutronix.de>
References: <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <1531519424.23898.68.camel@gmx.de>
 <20180718092741.pah2lubzo2a7tkmu@linutronix.de>
 <1531909728.6904.84.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531909728.6904.84.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-07-18 12:28:48 [+0200], Mike Galbraith wrote:
> > Okay, so you did not test this because you can't compile.
> 
> Nope, the running kernel, the one that is doing the segfaulting etc,
> has the patches applied.
> 
> It is exhibiting that symptom because those patches do not cure this
> symptom, one which I verified to be present in virgin 4.14-rt as well. 
> The pseudo-patch I sent, disabling preemption where it is assumed to be
> disabled instead, does cure it.  With preemption so disabled, I can
> beat on affected kernels (>=4.14-rt) as long as I like.

ah. so gcc shows the problem instead gcc explodes with the patch
applied. Okay. Let me stare at this a little more…

> This particular 48 core Cavium is very slow, maybe that makes it easier
> to reproduce, dunno.  According to pipe-test, the thing is essentially
> a dozen RPi super-glued together.  pipe-test pinned to a single core
> can only context switch at ~40KHz with PREEMPT_RT, or ~90 with
> NOPREEMPT, comparable to measurement done in real deal RPi.
> 
> 	-Mike

Sebastian
