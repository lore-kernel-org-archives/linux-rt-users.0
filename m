From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Subject: Re: help needed, 2.6.31.6-rt19 hang with network user app
Date: Sat, 21 Nov 2009 11:25:37 +0300
Message-ID: <200911211125.38161@blacky.localdomain>
References: <8C8865ED624BB94F8FE50259E2B5C5B304593DAA9E@palmail03.lsi.com> <200911210044.09962@blacky.localdomain> <8C8865ED624BB94F8FE50259E2B5C5B304593DAACF@palmail03.lsi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: "Leyendecker, Robert" <Robert.Leyendecker@lsi.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.lvk.cs.msu.su ([158.250.17.1]:57509 "EHLO
	mail.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbZKUIZk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 21 Nov 2009 03:25:40 -0500
In-Reply-To: <8C8865ED624BB94F8FE50259E2B5C5B304593DAACF@palmail03.lsi.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> > Does host A have a serial port? If yes, connect that to another host
> > using a null-modem cable, boot host A with serial console (boot arg
> > console=ttyS0,15200), and use that to extract kernel crash message.
> > Then post that to this list.
>
> unfortunately - nothing shows up in the serial log after the normal boot
> spew. I do see some sort of cr/lf every second for a while.

Of course that should be console=ttyS0,115200
And on other side serial communication software should be configured
to use 115200 8n1 with no flow control.

> Nov 20 21:12:00 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
> Nov 20 21:12:00 localhost kernel: caller is  __schedule+0xe/0x7d4 Nov 20 21:12:00 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
> Nov 20 21:12:00 localhost kernel: Call Trace:
> Nov 20 21:12:00 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
> Nov 20 21:12:00 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
> Nov 20 21:12:00 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
> Nov 20 21:12:00 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
> Nov 20 21:12:00 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
> Nov 20 21:12:00 localhost kernel: [<c040338a>] work_resched+0x5/0x19

Hopely somebody on list will be able to comment on this.

