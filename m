From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Fri, 28 Aug 2009 22:00:30 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0908282158100.19335@localhost.localdomain>
References: <1251282598.3514.20.camel@raz>  <alpine.DEB.1.10.0908260943090.9924@gentwo.org>  <1251297910.1791.22.camel@maxim-laptop> <1251322663.3882.48.camel@raz> <4A96B997.1070001@nortel.com> <alpine.DEB.1.10.0908271257270.17470@gentwo.org>
 <alpine.LFD.2.00.0908272242500.2888@localhost.localdomain> <4A97071F.5070804@novell.com> <4A973DAE.4020508@redhat.com> <4A975025.8030500@novell.com> <4A975CC4.1090208@novell.com> <alpine.LFD.2.00.0908281218560.2888@localhost.localdomain>
 <alpine.DEB.1.10.0908281446520.7317@gentwo.org> <alpine.LFD.2.00.0908282100040.19335@localhost.localdomain> <alpine.DEB.1.10.0908281551450.17784@gentwo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gregory Haskins <ghaskins@novell.com>,
	Rik van Riel <riel@redhat.com>,
	Chris Friesen <cfriesen@nortel.com>,
	raz ben yehuda <raziebe@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, mingo@elte.hu,
	peterz@infradead.org, maximlevitsky@gmail.com, efault@gmx.de,
	wiseman@macs.biu.ac.il, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Christoph Lameter <cl@linux-foundation.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753136AbZH1UDl@vger.kernel.org>
In-Reply-To: <alpine.DEB.1.10.0908281551450.17784@gentwo.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 28 Aug 2009, Christoph Lameter wrote:

> On Fri, 28 Aug 2009, Thomas Gleixner wrote:
> 
> > Right, and I think we can get there. The timer can be eliminated with
> > some work. Faults shouldn't happen on that CPU and all other
> > interrupts can be kept away with proper affinity settings. Softirqs
> > should not happen on such a CPU either as there is neither a hardirq
> > nor a user space task triggering them. Same applies for timers. So
> > there are some remaining issues like IPIs, but I'm pretty sure that
> > they can be tamed to zero as well.
> 
> There are various timer generated thingies like vm statistics, slab queue
> management and device specific things that run on each processor.

The statistics stuff needs to be tackled anyway as we need to offload
the sched accounting to some other cpu.

What slab queue stuff is running on timers and cannot be switched off
in such a context?

Device specific stuff should not happen on such a CPU when there is no
device handled on it.

Thanks,

	tglx
