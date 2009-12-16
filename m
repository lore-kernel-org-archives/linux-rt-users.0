From: "Leyendecker, Robert" <Robert.Leyendecker@lsi.com>
Subject: RE: help needed, 2.6.31.6-rt19 hang with network user app
Date: Tue, 15 Dec 2009 20:55:46 -0500
Message-ID: <8C8865ED624BB94F8FE50259E2B5C5B30459433101@palmail03.lsi.com>
References: <8C8865ED624BB94F8FE50259E2B5C5B304593DAA9E@palmail03.lsi.com>
 <200911210044.09962@blacky.localdomain>
 <8C8865ED624BB94F8FE50259E2B5C5B304593DAACF@palmail03.lsi.com>
 <alpine.LFD.2.00.0911272024280.24119@localhost.localdomain>
 <8C8865ED624BB94F8FE50259E2B5C5B304593DABB3@palmail03.lsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Nikita V. Youshchenko" <yoush@cs.msu.su>,
	rt-users <linux-rt-users@vger.kernel.org>
To: "Leyendecker, Robert" <Robert.Leyendecker@lsi.com>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:55954 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933323AbZLPB4A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Dec 2009 20:56:00 -0500
In-Reply-To: <8C8865ED624BB94F8FE50259E2B5C5B304593DABB3@palmail03.lsi.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



> -----Original Message-----
> From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-
> owner@vger.kernel.org] On Behalf Of Leyendecker, Robert
> Sent: Saturday, November 28, 2009 10:44 PM
> To: Thomas Gleixner
> Cc: Nikita V. Youshchenko; rt-users
> Subject: RE: help needed, 2.6.31.6-rt19 hang with network user app
> 
> 
> 
> > -----Original Message-----
> > From: Thomas Gleixner [mailto:tglx@linutronix.de]
> > Sent: Friday, November 27, 2009 1:43 PM
> > To: Leyendecker, Robert
> > Cc: Nikita V. Youshchenko; rt-users
> > Subject: RE: help needed, 2.6.31.6-rt19 hang with network user app
> >
> > On Fri, 20 Nov 2009, Leyendecker, Robert wrote:
> >
> > > Here is what was in the log/messages - I assume this is what was
> > > sent to kernel.org.  Host B is reporting destination unreachables
> at
> > > time of freeze.  Hope this log is useful. I have the full log from
> > > start of boot I can zip it up if you would like. At the bottom you
> > > can see where it is rebooting due to power cycle.
> >
> > > Nov 20 21:12:00 localhost kernel: BUG: using smp_processor_id() in
> > preemptible [00000000] code: smash/6801
> > > Nov 20 21:12:00 localhost kernel: caller is __schedule+0xe/0x7d4
> > > Nov 20 21:12:00 localhost kernel: Pid: 6801, comm: smash Not
> tainted
> > 2.6.31.6-rt19 #1
> > > Nov 20 21:12:00 localhost kernel: Call Trace:
> > > Nov 20 21:12:00 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
> > > Nov 20 21:12:00 localhost kernel: [<c05499a6>]
> > debug_smp_processor_id+0xa6/0xbc
> > > Nov 20 21:12:00 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
> > > Nov 20 21:12:00 localhost kernel: [<c046621f>] ?
> > audit_syscall_exit+0xfa/0x10f
> > > Nov 20 21:12:00 localhost kernel: [<c040a955>] ?
> > syscall_trace_leave+0xc8/0xef
> > > Nov 20 21:12:00 localhost kernel: [<c040338a>]
> work_resched+0x5/0x19
> >
> > Hmm, that comes from the low level code. We should have interrupts
> > disabled here, but I have a hard time to figure out the call path in
> > the ASM maze of entry_32.S. Still investigating.
> >
> > Thanks,
> >
> > 	tglx
> 
> Thomas-
> 
> Thank you for the help on this,
> 
> -Bob

I'm seeing this hang quite often now, some local users now reporting same issue even when systems lightly loaded - any ideas? 

On two systems, the problem has not shown up (so far) - both of these have been dell centrino duo laptops.  Higher-end Dell Desktops with core 2 duo seem to create problem at fairly random intervals but usually in 10 to 60 minutes. 

Can I add nosmp to kernel boot with rt patch, i.e. any stability consequences or other gottchas with no smp? Both 64 bit and 32 bit OS show problem with 64 bit seeming to have higher incidence under lighter loads.

-Bob

