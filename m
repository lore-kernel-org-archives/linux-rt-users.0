From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: 3.0.4 + rt12: deadlock
Date: Thu, 01 Sep 2011 22:52:12 +0200
Message-ID: <1314910332.1485.14.camel@twins>
References: <4E5E6A75.5030404@localhost>
	 <alpine.LFD.2.02.1109012136300.2723@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@us.ibm.com>, efault@gmx.de
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:36774 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757887Ab1IAUwZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Sep 2011 16:52:25 -0400
In-Reply-To: <alpine.LFD.2.02.1109012136300.2723@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2011-09-01 at 21:38 +0200, Thomas Gleixner wrote:
> > =============================================
> > [ INFO: possible recursive locking detected ]
> > 3.0.4-1.rt12.1.fc14.ccrma.i686.rtPAE #1
> > ---------------------------------------------
> > swapper/0 is trying to acquire lock:
> >  (&parent->list_lock){+.+...}, at: [<c05054ce>]
> > __cache_free.clone.27+0x45/0xc4
> > 
> > but task is already holding lock:
> >  (&parent->list_lock){+.+...}, at: [<c050662c>] do_tune_cpucache
> +0xf0/0x2b0
> > 
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> > 
> >        CPU0
> >        ----
> >   lock(&parent->list_lock);
> >   lock(&parent->list_lock);
> 

> 
>  
> >  *** DEADLOCK ***
> > 
> >  May be due to missing lock nesting notation
> > 
> > 3 locks held by swapper/0:
> >  #0:  (cache_chain_mutex){+.+...}, at: [<c0bedb96>]
> > kmem_cache_init_late+0x15/0x61
> >  #1:  (&per_cpu(slab_lock, __cpu).lock){+.+...}, at: [<c0504a53>]
> > __local_lock_irq+0x1e/0x5b
> >  #2:  (&parent->list_lock){+.+...}, at: [<c050662c>]
> > do_tune_cpucache+0xf0/0x2b0 

> That's something which has to do with debugging options (debugobjects
> IIRC). There was some attempt to fix that, but that might have gone
> lost in my vacation and the following futile attempt to take care of
> the resulting backlog. Peter ???

Looks like the one supposedly cured by:

patches/peter_zijlstra-slab_lockdep-annotate_the_locks_before_using.patch

which should be in -rt12

will have a peek, never reproduced for me though..
