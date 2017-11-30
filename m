From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] crypto: limit more FPU-enabled sections
Date: Thu, 30 Nov 2017 11:18:26 -0500
Message-ID: <20171130111826.6e6661a9@gandalf.local.home>
References: <20171130142216.GB12606@linutronix.de>
        <20171130102948.22d451cd@gandalf.local.home>
        <20171130154108.GC11362@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171130154108.GC11362@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 30 Nov 2017 16:41:08 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> I would keep it for now until we decide if we keep fixing those things
> are disable for RT because it is not worth it. As I said, this is only
> x86 specific and we have something similar on ARM with NEON.
> But I guess the decision here will be postponed until someone posts
> numbers with SW and with this workaround and cyclictest with a cycle of
> 1 - 10 ms.

Fair enough.

-- Steve
