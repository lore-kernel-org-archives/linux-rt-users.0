From: Christoph Lameter <cl@linux.com>
Subject: Re: [patch 2/2] MM: allow per-cpu vmstat_threshold and vmstat_worker
 configuration
Date: Tue, 30 May 2017 13:17:41 -0500 (CDT)
Message-ID: <alpine.DEB.2.20.1705301310100.7195@east.gentwo.org>
References: <alpine.DEB.2.20.1705121103120.22831@east.gentwo.org> <20170512161915.GA4185@amt.cnet> <alpine.DEB.2.20.1705121154240.23503@east.gentwo.org> <20170515191531.GA31483@amt.cnet> <alpine.DEB.2.20.1705160825480.32761@east.gentwo.org>
 <20170519143407.GA19282@amt.cnet> <alpine.DEB.2.20.1705191205580.19631@east.gentwo.org> <20170519134934.0c298882@redhat.com> <20170525193508.GA30252@amt.cnet> <alpine.DEB.2.20.1705252220130.7596@east.gentwo.org> <20170526190926.GA8974@amt.cnet>
Content-Type: text/plain; charset=US-ASCII
Cc: Luiz Capitulino <lcapitulino@redhat.com>, linux-kernel@vger.kernel.org,
    linux-mm@kvack.org, Rik van Riel <riel@redhat.com>,
    Linux RT Users <linux-rt-users@vger.kernel.org>, cmetcalf@mellanox.com
To: Marcelo Tosatti <mtosatti@redhat.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170526190926.GA8974@amt.cnet>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 26 May 2017, Marcelo Tosatti wrote:

> > interrupts and scheduler ticks. But what does this have to do with vmstat?
> >
> > Show me your dpdk code running and trace the tick on / off events  as well
> > as the vmstat invocations. Also show all system calls occurring on the cpu
> > that runs dpdk. That is necessary to see what triggers vmstat and how the
> > system reacts to the changes to the differentials.
>
> Sure, i can get that to you. The question remains: Are you arguing
> its not valid for a realtime application to use any system call
> which changes a vmstat counter?

A true realtime app would be conscientious of its use of the OS services
because the use of the services may cause additional latencies and also
cause timers etc to fire later. A realtime app that is willing to use
these services is therefore willing to tolerate larger latencies. A
realtime app that is using OS service may cause the timer tick to be
enabled which also causes additional latencies.

I have seen completely OS noise free processing for extended time period
when not using OS services and using RDMA for I/O. This fits my use case
well.

If there are really these high latencies because of kworker processing for
vmstat then maybe we need a different mechanism there (bh? or other
triggers) and maybe we are using far too many counters so that the
processing becomes a heavy user of resources.

> Because if they are allowed, then its obvious something like
> this is needed.

I am still wondering what benefit there is. Lets get clear on the test
load and see if this actually makes sense.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
