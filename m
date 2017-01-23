From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [btrfs/rt] lockdep false positive
Date: Mon, 23 Jan 2017 06:23:23 +0100
Message-ID: <1485149003.4554.74.camel@gmail.com>
References: <1485074793.4467.49.camel@gmail.com>
         <1485107114.4467.73.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485107114.4467.73.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 2017-01-22 at 18:45 +0100, Mike Galbraith wrote:
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
> 
> Hrm.  The below seems to work fine, but /me strongly suspects that if
> it were this damn trivial, the issue would be long dead.

(iow, did I merely spell '2' as '3' vs creating the annotation I want)
