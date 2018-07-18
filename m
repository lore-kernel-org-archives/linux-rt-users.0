From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Date: Wed, 18 Jul 2018 11:27:41 +0200
Message-ID: <20180718092741.pah2lubzo2a7tkmu@linutronix.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
 <20180522131004.3012953c@gandalf.local.home>
 <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <1531519424.23898.68.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531519424.23898.68.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-07-14 00:03:44 [+0200], Mike Galbraith wrote:
> > This seems to make work (crypto chacha20-neon + cyclictest). I have no
> > EFI so I have no clue if saving SIMD while calling to EFI works.
> 
> All is not well on cavium test box.  I'm seeing random errors ala...
> 
> ./include/linux/fs.h:3137:11: internal compiler error: Segmentation fault
> ./include/linux/bio.h:175:1: internal compiler error: in grokdeclarator, at c/c-decl.c:7023
> 
> ...during make -j96 (2*cpus) kbuild.  Turns out 4.14-rt has this issue
> as well, which is unsurprising if it's related to fpsimd woes.  Box
> does not exhibit the issue with NONRT kernels, PREEMPT or NOPREEMPT.
> 
> To file under FWIW, arm64 configured SLE15-RT, 4.12 based kernel
> containing virgin @stable arch/arm64/kernel/fpsimd.c, does not exhibit
> the problem. (relevant? dunno, it may be unrelated to fpsimd.c).

Okay, so you did not test this because you can't compile. But the
"internal compiler error" is usually something the gcc folks are
interested in :)

> 	-Mike

Sebastian
