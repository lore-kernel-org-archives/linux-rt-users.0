From: John Kacur <jkacur@redhat.com>
Subject: Re: [RFC][PATCH RT] acpi/rt: Convert acpi lock back to a
 raw_spinlock_t
Date: Wed, 13 Feb 2013 18:46:50 +0100 (CET)
Message-ID: <alpine.LFD.2.03.1302131844530.13701@tycho>
References: <1360765565.23152.5.camel@gandalf.local.home> <alpine.LFD.2.03.1302131744590.13701@tycho> <alpine.LFD.2.02.1302131755230.11905@ionos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Kacur <jkacur@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@gmail.com>,
	Clark Williams <clark@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1302131755230.11905@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On Wed, 13 Feb 2013, Thomas Gleixner wrote:

> On Wed, 13 Feb 2013, John Kacur wrote:
> > 
> > Thanks Steven. That looks way better than the previous revert.
> 
> I can't tell as I haven't seen the previous revert. And looks good is
> not really a good review criteria.

Absolutely true, and I wasn't claiming to have reviewed it, just wanted to 
let everyone know that testing on it was to begin.
> 
> The patch is converting _all_ the spin_locks in acpi to raw spinlocks,
> which will give you a nice bunch of "BUG: sleeping function called
> from invalid context" splats depending on the ACPI functionality of
> your machine.
> 
> The lock which is related to this splat is: acpi_gbl_hardware_lock and
> that's the only lock which can be safely converted to a raw spinlock.
> 
> Untested patch below.
> 
> Thanks,
> 
> 	tglx


Thank you Thomas, adding this version instead to our test queue.

John

-----------------SNIP
