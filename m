From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/2] Markers Implementation for Preempt RCU Boost
	Tracing
Date: Wed, 2 Jan 2008 21:10:32 +0100
Message-ID: <20080102201032.GB3985@elte.hu>
References: <20071231060911.GB6461@in.ibm.com> <20071231102045.GB30380@elte.hu> <y0modc4vr7a.fsf@ton.toronto.redhat.com> <20080102124734.GC11208@elte.hu> <20080102163309.GC11496@redhat.com> <20080102170157.GA11161@elte.hu> <20080102175606.GD11496@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "K. Prasad" <prasad@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	dipankar@in.ibm.com, ego@in.ibm.com, mathieu.desnoyers@polymtl.ca,
	paulmck@linux.vnet.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755695AbYABUMI@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080102175606.GD11496@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Frank Ch. Eigler <fche@redhat.com> wrote:

> Hi -
> 
> On Wed, Jan 02, 2008 at 06:01:57PM +0100, Ingo Molnar wrote:
> > [...]
> > well, -freorder-blocks seems to be default-enabled at -O2 on gcc 4.2, so 
> > we should already be getting that, right?
> 
> Right.
> 
> > [...]  So it would be nice if we could collect all this offline code
> > and stuff it away into another portion of the kernel image. (or,
> > into another portion of the object file - which would still be good
> > enough in practice)
> 
> That would be the -freorder-blocks-and-partition flag, as proposed by 
> Arjan two Februarys ago.  I don't see any traces of Andi's overriding 
> "-fno-reorder-blocks" in the current linus tree, so maybe it's time to 
> resurrect this one:
> 
> http://readlist.com/lists/vger.kernel.org/linux-kernel/39/196123.html

hm, that gives:

                                   Forbidden

   You don't have permission to access
   /lists/vger.kernel.org/linux-kernel/39/196123.html on this server.

but yeah, i had the impression that gcc couldnt yet do this. Not a 
showstopper, but it would be nice to initiate the gcc side of things ...

	Ingo
