From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: v2.6.21.4-rt11
Date: Mon, 11 Jun 2007 10:18:06 -0700
Message-ID: <20070611171806.GH9102@linux.vnet.ibm.com>
References: <20070609210507.GA29194@elte.hu> <20070611011954.GG27982@linux.vnet.ibm.com> <20070611073634.GB32446@elte.hu> <20070611144401.GA9102@linux.vnet.ibm.com> <20070611153855.GA21136@elte.hu> <20070611155527.GD9102@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Dinakar Guniguntala <dino@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:54216 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbXFKRSI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Jun 2007 13:18:08 -0400
Content-Disposition: inline
In-Reply-To: <20070611155527.GD9102@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Jun 11, 2007 at 08:55:27AM -0700, Paul E. McKenney wrote:
> On Mon, Jun 11, 2007 at 05:38:55PM +0200, Ingo Molnar wrote:
> > 
> > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> > 
> > > > hm, what affinity do they start out with? Could they all be pinned 
> > > > to CPU#0 by default?
> > > 
> > > They start off with affinity masks of 0xf on a 4-CPU system.  I would 
> > > expect them to load-balance across the four CPUs, but they stay all on 
> > > the same CPU until long after I lose patience (many minutes).
> > 
> > ugh. Would be nice to figure out why this happens. I enabled rcutorture 
> > on a dual-core CPU and all the threads are spread evenly.
> 
> Here is the /proc/cpuinfo in case this helps.  I am starting up a test
> on a dual-core CPU to see if that works better.

And this quickly load-balanced to put a pair of readers on each CPU.
Later, it moved one of the readers so that it is now running with
one reader on one of the CPUs, and the remaining three readers on the
other CPU.

Argh...  this is with 2.6.21-rt1...  Need to reboot with 2.6.21.4-rt12...

						Thanx, Paul
