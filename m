From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT] arm/unwind: fail on unwind in irq disabled regions
Date: Thu, 13 Feb 2014 23:57:45 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1402132355360.21991@ionos.tec.linutronix.de>
References: <1390580663-28869-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-282708098-1392332266=:21991"
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390580663-28869-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-282708098-1392332266=:21991
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 24 Jan 2014, Sebastian Andrzej Siewior wrote:

> Mostly unwind is done with irqs enabled however SLUB may call it with
> irqs disabled while creating a new SLUB cache.
> 
> I had system freeze while loading a module which called
> kmem_cache_create() on init. That means SLUB's __slab_alloc() disabled
> interrupts and then
> 
> ->new_slab_objects()
>  ->new_slab()
>   ->setup_object()
>    ->setup_object_debug()
>     ->init_tracking()
>      ->set_track()
>       ->save_stack_trace()
>        ->save_stack_trace_tsk()
>         ->walk_stackframe()
>          ->unwind_frame()
>           ->unwind_find_idx()
>            =>spin_lock_irqsave(&unwind_lock);
> 
> I would prefer not to turn this into a raw lock so for now it will just
> fail if it is called with irqs disabled which might return a few "empty"
> traces…

If we really end up with unwinding then the few cycles to follow the
stack are not that important anymore. We really want that output.

Thanks,

	tglx


--8323329-282708098-1392332266=:21991--
