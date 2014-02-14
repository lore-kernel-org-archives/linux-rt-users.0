From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 3.12.9-rt13: BUG: soft lockup
Date: Fri, 14 Feb 2014 11:43:34 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1402141040460.21991@ionos.tec.linutronix.de>
References: <52FBF2F1.8040504@localhost> <alpine.DEB.2.02.1402132324230.21991@ionos.tec.linutronix.de> <52FD4D89.2000207@localhost> <alpine.DEB.2.02.1402140053000.21991@ionos.tec.linutronix.de> <52FDB71F.2020000@ccrma.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Kacur <jkacur@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52FDB71F.2020000@ccrma.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 13 Feb 2014, Fernando Lopez-Lezcano wrote:
> On 02/13/2014 03:55 PM, Thomas Gleixner wrote:
> > On Thu, 13 Feb 2014, Fernando Lopez-Lezcano wrote:
> > 
> > > On 02/13/2014 02:25 PM, Thomas Gleixner wrote:
> > > > On Wed, 12 Feb 2014, Fernando Lopez-Lezcano wrote:
> > > > > [771508.546449] RIP: 0010:[<ffffffff810dc60a>]  [<ffffffff810dc60a>]
> > > > > smp_call_function_many+0x2ca/0x330
> > > > 
> > > > Can you decode the exact location inside of smp_call_function_many via
> > > > addr2line please ?
> > > 
> > > Hope this is useful (adding 0x2ce/0x330 as offsets does not make any
> > > difference, don't know if it should)...
> > > 
> > > # grep smp_call_function /var/log/messages|tail -1
> > > Feb 12 14:18:21 cmn27 kernel: [771840.224419] RIP:
> > > 0010:[<ffffffff810dc60e>]
> > > [<ffffffff810dc60e>] smp_call_function_many+0x2ce/0x330
> > > # addr2line -e
> > > /usr/lib/debug/lib/modules/3.12.10-300.rt15.1.fc20.ccrma.x86_64+rt/vmlinux
> > > ffffffff810dc60e
> > > /usr/src/debug/kernel-3.12.fc20.ccrma/linux-3.12.10-300.rt15.1.fc20.ccrma.x86_64/kernel/rtmutex.c:1295
> > 
> > I can't see how the kernel decoder thinks it's smp_call_function_many
> > but addr2line looks at rtmutex.c
> > 
> > That doesn't make any sense at all. Version mismatch?
> 
> Indeed, sorry for the mixup... here I go again, hopefully this one will make
> sense:
> 
> # addr2line -e
> /usr/lib/debug/lib/modules/3.12.9-301.rt13.1.fc20.ccrma.x86_64+rt/vmlinux
> ffffffff810dc60e
> /usr/src/debug/kernel-3.12.fc20.ccrma/linux-3.12.9-301.rt13.1.fc20.ccrma.x86_64/kernel/smp.c:108

So it's stuck in csd_lock_wait(), which means that the csd of the
target cpu is not free.

Is the machine completely dead or can you still retrieve information
from it?

Thanks,

	tglx
