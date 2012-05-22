From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH RT] rwsem_rt: Another (more sane) approach to mulit
 reader rt locks
Date: Tue, 22 May 2012 18:40:21 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1205221803290.3231@ionos>
References: <1337090625.14207.304.camel@gandalf.stny.rr.com>  <alpine.LFD.2.02.1205221553400.3231@ionos> <1337701801.13348.56.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1337701801.13348.56.camel@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 22 May 2012, Steven Rostedt wrote:
> On Tue, 2012-05-22 at 17:26 +0200, Thomas Gleixner wrote:
> > On Tue, 15 May 2012, Steven Rostedt wrote:
> > > +struct rw_semaphore {
> > > +	int			initialized;
> > > +	struct __rw_semaphore	lock[NR_CPUS];
> > 
> > So that will blow up every rw_semaphore user by
> > 
> >    NR_CPUS * sizeof(struct __rw_semaphore)
> > 
> > With lockdep off thats: NR_CPUS * 48
> > 
> > With lockdep on thats:  NR_CPUS * 128 + NR_CPUS * 8 (__key)
> > 
> > So for NR_CPUS=64 that's 3072 or 8704 Bytes.
> 
> For a box that has 64 CPUS, 8k should be nothing (even for every task).
> But then again, NR_CPUS is compile time option. It would be nice if we
> could make NR_CPUS just what was actually available :-/

We are talking about inodes not tasks. My 32 core machine has

 ext4_inode_cache  1997489
 xfs_inode          838780

and those are not my largest filesytem. So I pretty much care whether
my inode cache eats 20 GB or 2 GB of RAM. And so does every one else
with a machine with large filesystems. 

Even if I compile the kernel with NR_CPUS=32 then it's still 11GB
vs. 2GB.

> > So we trade massive memory waste for how much performance? 
> 
> We could always make this an option. I may be able to also do linker
> tricks to make it a boot time option where the memory is allocated in
> sections that can be freed if the option is not enabled. Just a thought,
> I know this is making it more complex than necessary.

Oh yes, we all know your affinity to the most complex solutions. :)

> > We really need numbers for various scenarios. There are applications
> > which are pretty mmap heavy and it would really surprise me when
> > taking NR_CPUS locks in one go is not going to cause a massive
> > overhead.
> 
> Well, it doesn't take NR_CPUS locks, it takes possible_cpus() locks,
> which may be much smaller. As a compiled time NR_CPUS=64 running on a
> box with just 4 cpus will do a loop of 4 and not 64.

Then let's talk about 32 cores, which is what I have and not really an
exotic machine anymore. 
 
> I'm all for benchmarks. But right now, making all readers pass through a
> single mutex is a huge bottle neck for a lot of loads. Yes, they are
> mostly Java loads, but for some strange reason, our customers seems to
> like to run Java on our RT kernel :-p

I'm well aware that mmap_sem is a PITA but replacing one nightmare
with the next one is not the best approach.

Thanks,

	tglx
