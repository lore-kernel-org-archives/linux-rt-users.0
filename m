From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Date: Wed, 11 Jul 2018 09:33:46 -0400
Message-ID: <20180711093346.782af07a@gandalf.local.home>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
        <20180522131004.3012953c@gandalf.local.home>
        <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
        <20180522132429.6f1dcf92@gandalf.local.home>
        <20180522173333.aawadhkcekzvrswp@linutronix.de>
        <20180711092555.268adf7f@gandalf.local.home>
        <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 11 Jul 2018 15:31:57 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2018-07-11 09:25:55 [-0400], Steven Rostedt wrote:
> > Did you decide to create a local_lock_bh(lock) function? I don't see it.
> > 
> > And should this be backported to 4.14-rt too? You state you saw this in
> > 4.16-rt, but did you start doing something different then, or did the
> > kernel change?  
> 
> I wanted to re-evaluate the whole situation here but didn't get to it
> yet.

Thanks, I wont add this then.

-- Steve
