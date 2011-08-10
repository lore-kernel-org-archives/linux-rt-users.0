From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [ANNOUNCE] 3.0.1-rt8
Date: Tue, 9 Aug 2011 18:07:45 -0700
Message-ID: <20110810010745.GB2737@linux.vnet.ibm.com>
References: <1312580681.28695.44.camel@twins>
 <4E417D12.70608@localhost>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:53751 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115Ab1HJBHr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Aug 2011 21:07:47 -0400
Content-Disposition: inline
In-Reply-To: <4E417D12.70608@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Aug 09, 2011 at 11:31:46AM -0700, Fernando Lopez-Lezcano wrote:
> On 08/05/2011 02:44 PM, Peter Zijlstra wrote:
> >Hi,
> >
> >Since yesterday is old, and yesterday's kernels aren't interesting,
> >here's a fresh one: 3.0.1-rt8.
> 
> Hmmm, what are reasonable values for CONFIG_RCU_BOOST_PRIO and
> CONFIG_RCU_BOOST_DELAY? (or at least what are you using?). I think
> CONFIG_RCU_BOOST should be working now so I should reenable the
> option for my next build.

I use the defaults, except when verifying that I can change them.  ;-)

							Thanx, Paul

> -- Fernando
> 
> 
> >Aside from the obvious rebase to 3.0.1 changes include:
> >
> >  - a fix from Rostedt for his cpupri rework involving memory ordering
> >  - a fix from me regarding this highmem muck, seeing as I mostly
> >    wrecked things last time around :-)
> >  - some lockdep annotations from upstream for things people were
> >    seeing here as well
> >  - a patch from Clark adding a sysfs file to recognize a PREEMP_RT
> >    kernel for udev -- is there really no saner solution !?
> >  - and a fresh raw_spinlock_t conversion of cpufreq_driver_lock, done
> >    just minutes before releasing this, to keep life interesting.
> >
> >Still working on the known issues from last time..
> >
> >The patch is at:
> >
> >   http://www.kernel.org/pub/linux/kernel/projects/rt/patch-3.0.1-rt8.patch.bz2
> >
> >The quilt series can be found here:
> >
> >   http://www.kernel.org/pub/linux/kernel/projects/rt/patches-3.0.1-rt8.tar.bz2
> >
> >Once kernel.org mirrors catch up that is..
