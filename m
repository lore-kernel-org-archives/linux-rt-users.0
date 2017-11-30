From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] crypto: limit more FPU-enabled sections
Date: Thu, 30 Nov 2017 16:41:08 +0100
Message-ID: <20171130154108.GC11362@linutronix.de>
References: <20171130142216.GB12606@linutronix.de>
 <20171130102948.22d451cd@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171130102948.22d451cd@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-11-30 10:29:48 [-0500], Steven Rostedt wrote:
> > +static void camellia_fpu_end_rt(struct crypt_priv *ctx)
> > +{
> > +#if CONFIG_PREEMPT_RT_FULL
> > +	bool fpu_enabled = ctx->fpu_enabled;
> > +
> > +	if (!fpu_enabled)
> > +		return;
> > +	camellia_fpu_end(fpu_enabled);
> > +	ctx->fpu_enabled = false;
> > +#endif
> > +}
> > +
> > +static void camellia_fpu_sched_rt(struct crypt_priv *ctx)
> > +{
> > +#if CONFIG_PREEMPT_RT_FULL
> > +	bool fpu_enabled = ctx->fpu_enabled;
> > +
> > +	if (!fpu_enabled || !tif_need_resched_now())
> > +		return;
> > +	camellia_fpu_end(fpu_enabled);
> 
> I haven't looked deeply, but why does this call the camellia_fpu_end()
> but other *_fpu_sched_rt() do not call the equivalent?

There is lrw_encrypt() which as "end" function after the end of the full
operation. So encrypt_callback() might be invoked multiple times but
only the first invocation does the fpu-enable part.

#1 We need to disable-FTP after one invocation of encrypt_callback()
   because blkcipher_walk_done() might alloc/free/map memory.

#2 That camellia_fpu_sched_rt() is only RT specific in order to enable
   preempt if need-resched is set for a RT task. For !RT we continue.

> > +	kernel_fpu_end();
> > +	/* schedule due to preemptible */
> > +	kernel_fpu_begin();
> > +#endif
> > +}
> > +
> 
> These are duplicate functions. Shouldn't they go into a header file?
> 
> Also, they are very similar:

That whole thing is kind of ugly, yes. That *_fpu_end_rt() use a struct
crypt_priv but this is defined in each cipher file.

I would keep it for now until we decide if we keep fixing those things
are disable for RT because it is not worth it. As I said, this is only
x86 specific and we have something similar on ARM with NEON.
But I guess the decision here will be postponed until someone posts
numbers with SW and with this workaround and cyclictest with a cycle of
1 - 10 ms.

Sebastian
