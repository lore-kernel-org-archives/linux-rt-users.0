From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch-rt] drivers/zram: fix zcomp_stream_get() smp_processor_id()
 use in preemptible code
Date: Thu, 31 Aug 2017 21:11:08 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1708312103530.2346@nanos>
References: <20170818120939.b2rj2whb2hgfzjpm@linutronix.de> <1503482249.4970.7.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:34636 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbdHaTLL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 31 Aug 2017 15:11:11 -0400
In-Reply-To: <1503482249.4970.7.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 23 Aug 2017, Mike Galbraith wrote:

> 
> Use get_local_ptr() vs this_cpu_ptr().
> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> ---
>  drivers/block/zram/zcomp.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/drivers/block/zram/zcomp.c
> +++ b/drivers/block/zram/zcomp.c
> @@ -120,7 +120,7 @@ struct zcomp_strm *zcomp_stream_get(stru
>  {
>  	struct zcomp_strm *zstrm;
>  
> -	zstrm = *this_cpu_ptr(comp->stream);
> +	zstrm = *get_local_ptr(comp->stream);

This looks wrong. On mainline the calling code must have preemption disable
somehow, otherwise this_cpu_ptr() would not work.

Looking at the call site it is;

	zram_slot_lock()
	  bit_spin_lock()

which is of course evading lockdep and everything else debugging wise.

Sebastian, do we have migration protection in bitlocked regions? And we
shpuld look into converting that into a spinlock on rt.

Thanks,

	tglx

