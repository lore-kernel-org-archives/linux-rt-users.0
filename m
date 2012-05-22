From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH RT] rwsem_rt: Another (more sane) approach to mulit
 reader rt locks
Date: Tue, 22 May 2012 17:26:38 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1205221553400.3231@ionos>
References: <1337090625.14207.304.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38670 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753614Ab2EVP0l (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 May 2012 11:26:41 -0400
In-Reply-To: <1337090625.14207.304.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 15 May 2012, Steven Rostedt wrote:
> +struct rw_semaphore {
> +	int			initialized;
> +	struct __rw_semaphore	lock[NR_CPUS];

So that will blow up every rw_semaphore user by

   NR_CPUS * sizeof(struct __rw_semaphore)

With lockdep off thats: NR_CPUS * 48

With lockdep on thats:  NR_CPUS * 128 + NR_CPUS * 8 (__key)

So for NR_CPUS=64 that's 3072 or 8704 Bytes.

That'll make e.g. XFS happy. xfs_inode has two rw_sems.

sizeof(xfs_inode) in mainline is:  856 bytes

sizeof(xfs_inode) on RT is:       1028 bytes

But with your change it would goto (NR_CPUS = 64):

    1028 - 96 + 2 * 3072 =        7076 bytes

That's almost an order of magnitude!

NFS has an rwsem in the inode as well, and ext4 has two.

So we trade massive memory waste for how much performance? 

We really need numbers for various scenarios. There are applications
which are pretty mmap heavy and it would really surprise me when
taking NR_CPUS locks in one go is not going to cause a massive
overhead.

Thanks,

	tglx
