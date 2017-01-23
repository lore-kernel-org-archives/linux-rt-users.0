From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [btrfs/rt] lockdep false positive
Date: Mon, 23 Jan 2017 10:07:51 +0100
Message-ID: <20170123090751.GU6485@twins.programming.kicks-ass.net>
References: <1485074793.4467.49.camel@gmail.com>
 <1485107114.4467.73.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:44474 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750875AbdAWJIG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Jan 2017 04:08:06 -0500
Content-Disposition: inline
In-Reply-To: <1485107114.4467.73.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Jan 22, 2017 at 06:45:14PM +0100, Mike Galbraith wrote:
> On Sun, 2017-01-22 at 09:46 +0100, Mike Galbraith wrote:
> > Greetings btrfs/lockdep wizards,
> > 
> > RT trees have trouble with the BTRFS lockdep positive avoidance lock
> > class dance (see disk-io.c).  Seems the trouble is due to RT not having
> > a means of telling lockdep that its rwlocks are recursive for read by
> > the lock owner only, combined with the BTRFS lock class dance assuming
> > that read_lock() is annotated rwlock_acquire_read(), which RT cannot
> > do, as that would be a big fat lie.
> > 
> > Creating a rt_read_lock_shared() for btrfs_clear_lock_blocking_rw() did
> > indeed make lockdep happy as a clam for test purposes.  (hm, submitting
> > that would be excellent way to replenish frozen shark supply:)
> > 
> > Ideas?

Not having looked at anything much, currently lockdep does not in fact
model rwlock properly as is.

Note that rwlock is _not_ in fact reader biased like it used to be, that
is, read_lock() will block if there is a pending writer (just like
rwsem), with the exception when read_lock() happend in_interrupt()
(because tasklist_lock).
