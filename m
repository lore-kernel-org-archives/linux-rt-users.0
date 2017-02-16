From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RT] lockdep munching nr_list_entries like popcorn
Date: Thu, 16 Feb 2017 10:01:18 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1702161001100.3543@nanos>
References: <1487224986.5258.45.camel@gmx.de>  <alpine.DEB.2.20.1702160933420.3543@nanos> <1487235000.5258.48.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:50909 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753916AbdBPJBV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Feb 2017 04:01:21 -0500
In-Reply-To: <1487235000.5258.48.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 16 Feb 2017, Mike Galbraith wrote:

> On Thu, 2017-02-16 at 09:37 +0100, Thomas Gleixner wrote:
> > On Thu, 16 Feb 2017, Mike Galbraith wrote:
> > 
> ...
> > > swapvec_lock?  Oodles of 'em?  Nope.
> > 
> > Well, it's a per cpu lock and the lru_cache_add() variants might be called
> > from a gazillion of different call chains, but yes, it does not make a lot
> > of sense. We'll have a look.
> 
> Adding explicit local_irq_lock_init() makes things heaps better, so
> presumably we need better lockdep-foo in DEFINE_LOCAL_IRQ_LOCK().

Bah.
