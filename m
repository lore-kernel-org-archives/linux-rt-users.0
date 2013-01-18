From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH v2] slub: Keep page and object in sync in
 slab_alloc_node()
Date: Fri, 18 Jan 2013 10:04:44 -0500
Message-ID: <1358521484.7383.8.camel@gandalf.local.home>
References: <1358446258.23211.32.camel@gandalf.local.home>
	 <1358447864.23211.34.camel@gandalf.local.home>
	 <0000013c4a69a2cf-1a19a6f6-e6a3-4f06-99a4-10fdd4b9aca2-000000@email.amazonses.com>
	 <1358458996.23211.46.camel@gandalf.local.home>
	 <0000013c4a7e7fbf-c51fd42a-2455-4fec-bb37-915035956f05-000000@email.amazonses.com>
	 <1358462763.23211.57.camel@gandalf.local.home>
	 <1358464245.23211.62.camel@gandalf.local.home>
	 <1358464837.23211.66.camel@gandalf.local.home>
	 <1358468598.23211.67.camel@gandalf.local.home>
	 <1358468924.23211.69.camel@gandalf.local.home>
	 <0000013c4e1ea131-b8ab56b9-bfca-44fe-b5da-f030551194c9-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pekka Enberg <penberg@kernel.org>,
	Matt Mackall <mpm@selenic.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <clark@redhat.com>,
	John Kacur <jkacur@gmail.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Christoph Lameter <cl@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000013c4e1ea131-b8ab56b9-bfca-44fe-b5da-f030551194c9-000000@email.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2013-01-18 at 14:44 +0000, Christoph Lameter wrote:
> On Thu, 17 Jan 2013, Steven Rostedt wrote:
> 
> > In slab_alloc_node(), after the cpu_slab is assigned, if the task is
> > preempted and moves to another CPU, there's nothing keeping the page and
> > object in sync. The -rt kernel crashed because page was NULL and object
> > was not, and the node_match() dereferences page. Even though the crash
> > happened on -rt, there's nothing that's keeping this from happening on
> > mainline.
> >
> > The easiest fix is to disable interrupts for the entire time from
> > acquiring the current CPU cpu_slab and assigning the object and page.
> > After that, it's fine to allow preemption.
> 
> Its easiest to just check for the NULL pointer as initally done. The call
> to __slab_alloc can do what the fastpath does.
> 
> And the fastpath will verify that the c->page pointer was not changed.

The problem is that the changes can happen on another CPU, which means
that barrier isn't sufficient.

	CPU0			CPU1
	----			----
<cpu fetches c->page>
			updates c->tid
			updates c->page
			updates c->freelist
<cpu fetches c->tid>
<cpu fetches c->freelist>

  node_match() succeeds even though
    current c->page wont

 this_cpu_cmpxchg_double() only tests
   the object (freelist) and tid, both which
   will match, but the page that was tested
   isn't the right one.


That barrier() is meaningless as soon as another CPU is involved. The
CPU can order things anyway it wants, even if the assembly did in
differently. Due to cacheline misses and such, we have no idea if
c->page has been prefetched into memory or not.

We may get by with just disabling preemption and testing for page ==
NULL (just in case an interrupt comes in between objects and page and
resets that). But we can't grab freelist and page if c points to another
CPUs object.

-- Steve
