From: "Leyendecker, Robert" <Robert.Leyendecker@lsi.com>
Subject: RE: help needed, 2.6.31.6-rt19 hang with network user app
Date: Sat, 21 Nov 2009 11:20:46 -0500
Message-ID: <8C8865ED624BB94F8FE50259E2B5C5B304593DAAD2@palmail03.lsi.com>
References: <8C8865ED624BB94F8FE50259E2B5C5B304593DAA9E@palmail03.lsi.com>
 <200911210044.09962@blacky.localdomain>
 <8C8865ED624BB94F8FE50259E2B5C5B304593DAACF@palmail03.lsi.com>
 <200911211125.38161@blacky.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:42302 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754639AbZKUQVA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 21 Nov 2009 11:21:00 -0500
In-Reply-To: <200911211125.38161@blacky.localdomain>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



> -----Original Message-----
> From: Nikita V. Youshchenko [mailto:yoush@cs.msu.su]
> Sent: Saturday, November 21, 2009 2:26 AM
> To: Leyendecker, Robert
> Cc: rt-users
> Subject: Re: help needed, 2.6.31.6-rt19 hang with network user app
> 
> > > Does host A have a serial port? If yes, connect that to another
> host
> > > using a null-modem cable, boot host A with serial console (boot arg
> > > console=ttyS0,15200), and use that to extract kernel crash message.
> > > Then post that to this list.
> >
> > unfortunately - nothing shows up in the serial log after the normal
> boot
> > spew. I do see some sort of cr/lf every second for a while.
> 
> Of course that should be console=ttyS0,115200
> And on other side serial communication software should be configured
> to use 115200 8n1 with no flow control.
No problem, I caught that. During boot, console messages are displayed in tty and it looks normal, after boot tty is quiet. I'll look at it some more because it would be very nice to have the console working.  Are the regular tty HUPs a result of failed auto baud detect?
> 
> > Nov 20 21:12:00 localhost kernel: BUG: using smp_processor_id() in
> preemptible [00000000] code: smash/6801
> > Nov 20 21:12:00 localhost kernel: caller is  __schedule+0xe/0x7d4 Nov
> 20 21:12:00 localhost kernel: Pid: 6801, comm: smash Not tainted
> 2.6.31.6-rt19 #1
> > Nov 20 21:12:00 localhost kernel: Call Trace:
> > Nov 20 21:12:00 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
> > Nov 20 21:12:00 localhost kernel: [<c05499a6>]
> debug_smp_processor_id+0xa6/0xbc
> > Nov 20 21:12:00 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
> > Nov 20 21:12:00 localhost kernel: [<c046621f>] ?
> audit_syscall_exit+0xfa/0x10f
> > Nov 20 21:12:00 localhost kernel: [<c040a955>] ?
> syscall_trace_leave+0xc8/0xef
> > Nov 20 21:12:00 localhost kernel: [<c040338a>] work_resched+0x5/0x19
> 
> Hopely somebody on list will be able to comment on this.

