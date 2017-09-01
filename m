From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch-rt] drivers/zram: fix zcomp_stream_get() smp_processor_id()
 use in preemptible code
Date: Fri, 1 Sep 2017 09:47:56 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1709010947090.1857@nanos>
References: <20170818120939.b2rj2whb2hgfzjpm@linutronix.de> <1503482249.4970.7.camel@gmx.de> <alpine.DEB.2.20.1708312103530.2346@nanos> <20170831192637.ffzw2km3zfiafx7s@linutronix.de> <alpine.DEB.2.20.1708312130260.2346@nanos>
 <20170901074023.2ctuzw3ohlnlmtid@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170901074023.2ctuzw3ohlnlmtid@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 1 Sep 2017, Sebastian Andrzej Siewior wrote:

> On 2017-08-31 21:32:30 [+0200], Thomas Gleixner wrote:
> > > zram_lock_table() is bit_spin_lock() on !RT and spin_lock(&table->lock);
> > > on RT. So this is done.
> > > !RT has this running in a kmap_atomic() section so they have no
> > > preemption there.
> > > zcomp_stream_get() returns a per-CPU object which is protected with a
> > > spinlock and only accessed locked.
> > 
> > So when we are inside a spinlocked section, why is this_cpu_ptr() not
> > working? That does not make sense.
> 
> zram_decompress_page() invokes zcomp_stream_get() within a spin_lock
> section (zram_lock_table()). This is fine.
> zram_bvec_write() does not invoke zcomp_stream_get() within a spin_lock
> section.

Fair enough.
