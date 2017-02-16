From: Mike Galbraith <efault@gmx.de>
Subject: Re: [RT] lockdep munching nr_list_entries like popcorn
Date: Thu, 16 Feb 2017 09:50:00 +0100
Message-ID: <1487235000.5258.48.camel@gmx.de>
References: <1487224986.5258.45.camel@gmx.de>
         <alpine.DEB.2.20.1702160933420.3543@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1702160933420.3543@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2017-02-16 at 09:37 +0100, Thomas Gleixner wrote:
> On Thu, 16 Feb 2017, Mike Galbraith wrote:
> 
...
> > swapvec_lock?  Oodles of 'em?  Nope.
> 
> Well, it's a per cpu lock and the lru_cache_add() variants might be called
> from a gazillion of different call chains, but yes, it does not make a lot
> of sense. We'll have a look.

Adding explicit local_irq_lock_init() makes things heaps better, so
presumably we need better lockdep-foo in DEFINE_LOCAL_IRQ_LOCK().

	-Mike
