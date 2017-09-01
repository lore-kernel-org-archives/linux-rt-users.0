From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch-rt] drivers/zram: fix zcomp_stream_get()
 smp_processor_id() use in preemptible code
Date: Fri, 1 Sep 2017 09:40:23 +0200
Message-ID: <20170901074023.2ctuzw3ohlnlmtid@linutronix.de>
References: <20170818120939.b2rj2whb2hgfzjpm@linutronix.de>
 <1503482249.4970.7.camel@gmx.de>
 <alpine.DEB.2.20.1708312103530.2346@nanos>
 <20170831192637.ffzw2km3zfiafx7s@linutronix.de>
 <alpine.DEB.2.20.1708312130260.2346@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1708312130260.2346@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-08-31 21:32:30 [+0200], Thomas Gleixner wrote:
> > zram_lock_table() is bit_spin_lock() on !RT and spin_lock(&table->lock);
> > on RT. So this is done.
> > !RT has this running in a kmap_atomic() section so they have no
> > preemption there.
> > zcomp_stream_get() returns a per-CPU object which is protected with a
> > spinlock and only accessed locked.
> 
> So when we are inside a spinlocked section, why is this_cpu_ptr() not
> working? That does not make sense.

zram_decompress_page() invokes zcomp_stream_get() within a spin_lock
section (zram_lock_table()). This is fine.
zram_bvec_write() does not invoke zcomp_stream_get() within a spin_lock
section.

> Thanks,
> 
> 	tglx

Sebastian
