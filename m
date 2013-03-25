From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT LATENCY] 249 microsecond latency caused by slub's
 unfreeze_partials() code.
Date: Mon, 25 Mar 2013 11:57:53 -0400
Message-ID: <1364227073.6345.182.camel@gandalf.local.home>
References: <1363906545.6345.81.camel@gandalf.local.home>
	 <0000013d92c37ff3-5fb85400-bec1-4eda-8ba1-332566884c59-000000@email.amazonses.com>
	 <1364010673.6345.156.camel@gandalf.local.home>
	 <0000013da1f93be3-c3d42ae8-ff34-4c63-8094-77a83291ea19-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>
To: Christoph Lameter <cl@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000013da1f93be3-c3d42ae8-ff34-4c63-8094-77a83291ea19-000000@email.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2013-03-25 at 14:34 +0000, Christoph Lameter wrote:
> On Fri, 22 Mar 2013, Steven Rostedt wrote:
> 
> > I uploaded it here:
> >
> > http://rostedt.homelinux.com/private/slab_partials
> >
> > See anything I should be worried about?
> 
> Looks fine. Maybe its the spinlocks being contended that cause the
> long holdoff?


Funny, I was in the process of telling you this :-)

I added trace_printks() around the lock where the lock was tried to be
taken and where it actually had the lock. Here's what I got:

hackbenc-56308  18d...0 164395.064073: funcgraph_entry:                   |  unfreeze_partials() {
hackbenc-56308  18d...0 164395.064073: bprint:               unfreeze_partials : take lock 0xffff881fff4000a0
hackbenc-56308  18d..10 164395.064093: bprint:               unfreeze_partials : have lock 0xffff881fff4000a0
hackbenc-56308  18d...0 164395.064094: bprint:               unfreeze_partials : take lock 0xffff880fff4010a0
hackbenc-56308  18d..10 164395.064094: bprint:               unfreeze_partials : have lock 0xffff880fff4010a0
hackbenc-56308  18d...0 164395.064094: bprint:               unfreeze_partials : take lock 0xffff881fff4000a0
hackbenc-56308  18d..10 164395.064159: bprint:               unfreeze_partials : have lock 0xffff881fff4000a0
hackbenc-56308  18d...0 164395.064162: bprint:               unfreeze_partials : take lock 0xffff880fff4010a0
hackbenc-56308  18d..10 164395.064162: bprint:               unfreeze_partials : have lock 0xffff880fff4010a0
hackbenc-56308  18d...0 164395.064162: bprint:               unfreeze_partials : take lock 0xffff881fff4000a0
hackbenc-56308  18d..10 164395.064224: bprint:               unfreeze_partials : have lock 0xffff881fff4000a0
hackbenc-56308  18d...0 164395.064226: bprint:               unfreeze_partials : take lock 0xffff880fff4010a0
hackbenc-56308  18d..10 164395.064226: bprint:               unfreeze_partials : have lock 0xffff880fff4010a0
hackbenc-56308  18d...0 164395.064226: bprint:               unfreeze_partials : take lock 0xffff881fff4000a0
hackbenc-56308  18d..10 164395.064274: bprint:               unfreeze_partials : have lock 0xffff881fff4000a0
hackbenc-56308  18d...0 164395.064277: bprint:               unfreeze_partials : take lock 0xffff882fff4000a0
hackbenc-56308  18d..10 164395.064277: bprint:               unfreeze_partials : have lock 0xffff882fff4000a0
hackbenc-56308  18d...0 164395.064277: bprint:               unfreeze_partials : take lock 0xffff881fff4000a0
hackbenc-56308  18d..10 164395.064334: bprint:               unfreeze_partials : have lock 0xffff881fff4000a0
hackbenc-56308  18d...0 164395.064336: bprint:               unfreeze_partials : out=14 in=14 dis=0
hackbenc-56308  18d...0 164395.064336: funcgraph_exit:       ! 262.907 us |  }

There were several locations that took 60us to grab the lock. This
happened enough to add up to a large latency. This shows that it is the
lock contention that's the issue here.



>  How does RT deal with the spinlocks? Dont know too much
> about it.

Normally, spin_locks are converted to mutexes. But for the slub case,
the locks in question have been made into raw_spinlock_t. These locks
act the same as they do in mainline (ticket spin locks). As it looked
like the locks were held for such short intervals, and it would be quite
difficult to convert them into sleeping locks, we kept them as real spin
locks.

> 
> You can eliminate the whole thing by setting
> 
> /sys/kernel/slab/<whatever/cpu_partial
> 
> to zero.

Thanks! I'll give this a try.

-- Steve
