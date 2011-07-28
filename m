From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rt4
Date: Thu, 28 Jul 2011 11:37:46 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1107281134310.2660@ionos>
References: <alpine.LFD.2.02.1107272222420.2660@ionos> <201107281224.44323@zigzag.lvk.cs.msu.su> <1311842677.5890.209.camel@twins> <201107281251.16892@zigzag.lvk.cs.msu.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	lasaine@lvk.cs.msu.su
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57801 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797Ab1G1Jhx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jul 2011 05:37:53 -0400
In-Reply-To: <201107281251.16892@zigzag.lvk.cs.msu.su>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 28 Jul 2011, Nikita V. Youshchenko wrote:

> > On Thu, 2011-07-28 at 12:24 +0400, Nikita V. Youshchenko wrote:
> > > (*) we need >1G of memory for data buffers, and have too much legacy
> > > software components so moving to 64bit system is not practical within
> > > available resource
> >
> > You can run a complete 32bit userspace on a 64bit kernel without any
> > problems.
> 
> ... expect shared data between kernel and userspace (structures passed over 
> ioctl()s, structures in mmapped buffers). Unfortunately, in scope of our 
> project (that lasts since 2001 or so), we do have such issues :(.

Aside of that being horrid, it's trivial to solve with proper data
types. u32 and friends are there for a reason. But feel free to get
the highmem thing working again :)

Thanks,

	tglx

