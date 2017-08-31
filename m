From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch-rt] drivers/zram: fix zcomp_stream_get() smp_processor_id()
 use in preemptible code
Date: Thu, 31 Aug 2017 21:32:30 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1708312130260.2346@nanos>
References: <20170818120939.b2rj2whb2hgfzjpm@linutronix.de> <1503482249.4970.7.camel@gmx.de> <alpine.DEB.2.20.1708312103530.2346@nanos> <20170831192637.ffzw2km3zfiafx7s@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170831192637.ffzw2km3zfiafx7s@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 31 Aug 2017, Sebastian Andrzej Siewior wrote:

> On 2017-08-31 21:11:08 [+0200], Thomas Gleixner wrote:
> > On Wed, 23 Aug 2017, Mike Galbraith wrote:
> > 
> > > 
> > > Use get_local_ptr() vs this_cpu_ptr().
> > > 
> > > Signed-off-by: Mike Galbraith <efault@gmx.de>
> > > ---
> > >  drivers/block/zram/zcomp.c |    3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > --- a/drivers/block/zram/zcomp.c
> > > +++ b/drivers/block/zram/zcomp.c
> > > @@ -120,7 +120,7 @@ struct zcomp_strm *zcomp_stream_get(stru
> > >  {
> > >  	struct zcomp_strm *zstrm;
> > >  
> > > -	zstrm = *this_cpu_ptr(comp->stream);
> > > +	zstrm = *get_local_ptr(comp->stream);
> > 
> > This looks wrong. On mainline the calling code must have preemption disable
> > somehow, otherwise this_cpu_ptr() would not work.
> 
> This was introduced by Mike in a previous patch. The zstrm is only
> accessed while the spinlock is held.
> 
> > Looking at the call site it is;
> > 
> > 	zram_slot_lock()
> > 	  bit_spin_lock()
> > 
> > which is of course evading lockdep and everything else debugging wise.
> > 
> > Sebastian, do we have migration protection in bitlocked regions? And we
> > shpuld look into converting that into a spinlock on rt.
> 
> zram_lock_table() is bit_spin_lock() on !RT and spin_lock(&table->lock);
> on RT. So this is done.
> !RT has this running in a kmap_atomic() section so they have no
> preemption there.
> zcomp_stream_get() returns a per-CPU object which is protected with a
> spinlock and only accessed locked.

So when we are inside a spinlocked section, why is this_cpu_ptr() not
working? That does not make sense.

Thanks,

	tglx
