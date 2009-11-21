From: "Leyendecker, Robert" <Robert.Leyendecker@lsi.com>
Subject: RE: help needed, 2.6.31.6-rt19 hang with network user app
Date: Fri, 20 Nov 2009 22:56:10 -0500
Message-ID: <8C8865ED624BB94F8FE50259E2B5C5B304593DAACF@palmail03.lsi.com>
References: <8C8865ED624BB94F8FE50259E2B5C5B304593DAA9E@palmail03.lsi.com>
 <200911210044.09962@blacky.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:41998 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751876AbZKUD4O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Nov 2009 22:56:14 -0500
In-Reply-To: <200911210044.09962@blacky.localdomain>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



> -----Original Message-----
> From: Nikita V. Youshchenko [mailto:yoush@cs.msu.su]
> Sent: Friday, November 20, 2009 3:44 PM
> To: Leyendecker, Robert
> Cc: rt-users
> Subject: Re: help needed, 2.6.31.6-rt19 hang with network user app
>
> > Hang details:
> > 1 The UI freezes. No keyboard or mouse. Graphics OK but screen
> freeze.
> > 2 Host B reports no data from Host A. When Host B is terminated and
> > unplugged from network, the network card on Host A still blinks as if
> it
> > is sending or receiving data. Unplugging Host A stops the blinking.
> > Plugging A back in starts the blinking. I have waited up to 20
> minutes
> > or more and card still blinking.
>
> This looks like something in kernel crashed.
>
> Does host A have a serial port? If yes, connect that to another host
> using
> a null-modem cable, boot host A with serial console (boot arg
> console=ttyS0,15200), and use that to extract kernel crash message.
> Then
> post that to this list.

Thank you very much for the fast reply-

unfortunately - nothing shows up in the serial log after the normal boot spew. I do see some sort of cr/lf every second for a while.

I ran the test two times - once with services off and once with services on.

When I turned on services - something interesting happened. After a freeze period of at least 10 minutes, suddenly my program started running again and I got at least two pop-ups saying diagnostic info has been sent to kernel.org. Then everything was frozen and I power cycled.

Here is what was in the log/messages - I assume this is what was sent to kernel.org.  Host B is reporting destination unreachables at time of freeze.  Hope this log is useful. I have the full log from start of boot I can zip it up if you would like. At the bottom you can see where it is rebooting due to power cycle.



Nov 20 21:11:54 localhost init: serial main process (19239) killed by HUP signal
Nov 20 21:11:56 localhost init: serial main process (19253) killed by HUP signal
Nov 20 21:11:57 localhost init: serial main process (19266) killed by HUP signal
Nov 20 21:11:58 localhost init: serial main process (19279) killed by HUP signal
Nov 20 21:11:59 localhost init: serial main process (19292) killed by HUP signal
Nov 20 21:12:00 localhost init: serial main process (19305) killed by HUP signal
Nov 20 21:12:00 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:00 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:00 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:00 localhost kernel: Call Trace:
Nov 20 21:12:00 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:00 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:00 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:00 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:00 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:00 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:00 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:00 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:00 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:00 localhost kernel: Call Trace:
Nov 20 21:12:00 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:00 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:00 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:00 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:00 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:00 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:00 localhost nmbd[2256]: [2009/11/20 21:12:00,  0] nmbd/nmbd_become_lmb.c:become_local_master_stage2(395)
Nov 20 21:12:00 localhost nmbd[2256]:   *****
Nov 20 21:12:00 localhost nmbd[2256]:
Nov 20 21:12:00 localhost nmbd[2256]:   Samba name server XXXXX is now a local master browser for workgroup XXXXX on subnet XXXXXXXXX
Nov 20 21:12:00 localhost nmbd[2256]:
Nov 20 21:12:00 localhost nmbd[2256]:   *****
Nov 20 21:12:01 localhost init: serial main process (19318) killed by HUP signal
Nov 20 21:12:02 localhost init: serial main process (19331) killed by HUP signal
Nov 20 21:12:03 localhost init: serial main process (19344) killed by HUP signal
Nov 20 21:12:04 localhost init: serial main process (19357) killed by HUP signal
Nov 20 21:12:05 localhost kerneloops: Submitted 1 kernel oopses to www.kerneloops.org
Nov 20 21:12:05 localhost init: serial main process (19370) killed by HUP signal
Nov 20 21:12:06 localhost init: serial main process (19385) killed by HUP signal
Nov 20 21:12:07 localhost init: serial main process (19398) killed by HUP signal
Nov 20 21:12:08 localhost init: serial main process (19411) killed by HUP signal
Nov 20 21:12:09 localhost init: serial main process (19424) killed by HUP signal
Nov 20 21:12:10 localhost init: serial main process (19437) killed by HUP signal
Nov 20 21:12:10 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:10 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:10 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:10 localhost kernel: Call Trace:
Nov 20 21:12:10 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:10 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:10 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:10 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:10 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:10 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:10 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:10 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:10 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:10 localhost kernel: Call Trace:
Nov 20 21:12:10 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:10 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:10 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:10 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:10 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:10 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:11 localhost init: serial main process (19450) killed by HUP signal
Nov 20 21:12:12 localhost init: serial main process (19463) killed by HUP signal
Nov 20 21:12:13 localhost init: serial main process (19476) killed by HUP signal
Nov 20 21:12:14 localhost init: serial main process (19489) killed by HUP signal
Nov 20 21:12:14 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:14 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:14 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:14 localhost kernel: Call Trace:
Nov 20 21:12:14 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:14 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:14 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:14 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:14 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:14 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:14 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:14 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:14 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:14 localhost kernel: Call Trace:
Nov 20 21:12:14 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:14 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:14 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:14 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:14 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:14 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:14 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:14 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:14 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:14 localhost kernel: Call Trace:
Nov 20 21:12:14 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:14 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:14 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:14 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:14 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:14 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:14 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:14 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:14 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:14 localhost kernel: Call Trace:
Nov 20 21:12:14 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:14 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:14 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:14 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:14 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:14 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:15 localhost init: serial main process (19502) killed by HUP signal
Nov 20 21:12:16 localhost init: serial main process (19515) killed by HUP signal
Nov 20 21:12:16 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:16 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:16 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:16 localhost kernel: Call Trace:
Nov 20 21:12:16 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:16 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:16 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:16 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:16 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:16 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:16 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:16 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:16 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:16 localhost kernel: Call Trace:
Nov 20 21:12:16 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:16 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:16 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:16 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:16 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:16 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:17 localhost init: serial main process (19528) killed by HUP signal
Nov 20 21:12:18 localhost init: serial main process (19541) killed by HUP signal
Nov 20 21:12:18 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:18 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:18 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:18 localhost kernel: Call Trace:
Nov 20 21:12:18 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:18 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:18 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:18 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:18 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:18 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:18 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:18 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:18 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:18 localhost kernel: Call Trace:
Nov 20 21:12:18 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:18 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:18 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:18 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:18 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:18 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:19 localhost init: serial main process (19554) killed by HUP signal
Nov 20 21:12:20 localhost init: serial main process (19567) killed by HUP signal
Nov 20 21:12:20 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:20 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:20 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:20 localhost kernel: Call Trace:
Nov 20 21:12:20 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:20 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:20 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:20 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:20 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:20 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:20 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:20 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:20 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:20 localhost kernel: Call Trace:
Nov 20 21:12:20 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:20 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:20 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:20 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:20 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:20 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:21 localhost init: serial main process (19580) killed by HUP signal
Nov 20 21:12:22 localhost init: serial main process (19593) killed by HUP signal
Nov 20 21:12:22 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:22 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:22 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:22 localhost kernel: Call Trace:
Nov 20 21:12:22 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:22 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:22 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:22 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:22 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:22 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:22 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:22 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:22 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:22 localhost kernel: Call Trace:
Nov 20 21:12:22 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:22 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:22 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:22 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:22 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:22 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:22 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:22 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:22 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:22 localhost kernel: Call Trace:
Nov 20 21:12:22 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:22 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:22 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:22 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:22 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:22 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:22 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:22 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:22 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:22 localhost kernel: Call Trace:
Nov 20 21:12:22 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:22 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:22 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:22 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:22 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:22 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:23 localhost init: serial main process (19606) killed by HUP signal
Nov 20 21:12:24 localhost init: serial main process (19619) killed by HUP signal
Nov 20 21:12:24 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:24 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:24 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:24 localhost kernel: Call Trace:
Nov 20 21:12:24 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:24 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:24 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:24 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:24 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:24 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:24 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:24 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:24 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:24 localhost kernel: Call Trace:
Nov 20 21:12:24 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:24 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:24 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:24 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:24 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:24 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:24 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:24 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:24 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:24 localhost kernel: Call Trace:
Nov 20 21:12:24 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:24 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:24 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:24 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:24 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:24 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:24 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:24 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:24 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:24 localhost kernel: Call Trace:
Nov 20 21:12:24 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:24 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:24 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:24 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:24 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:24 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:25 localhost kerneloops: Submitted 1 kernel oopses to www.kerneloops.org
Nov 20 21:12:25 localhost init: serial main process (19632) killed by HUP signal
Nov 20 21:12:26 localhost init: serial main process (19645) killed by HUP signal
Nov 20 21:12:27 localhost init: serial main process (19658) killed by HUP signal
Nov 20 21:12:28 localhost init: serial main process (19671) killed by HUP signal
Nov 20 21:12:28 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:28 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:28 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:28 localhost kernel: Call Trace:
Nov 20 21:12:28 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:28 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:28 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:28 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:28 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:28 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:28 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:28 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:28 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:28 localhost kernel: Call Trace:
Nov 20 21:12:28 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:28 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:28 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:28 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:28 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:28 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:28 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:28 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:28 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:28 localhost kernel: Call Trace:
Nov 20 21:12:28 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:28 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:28 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:28 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:28 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:28 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:28 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:28 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:28 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:28 localhost kernel: Call Trace:
Nov 20 21:12:28 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:28 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:28 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:28 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:28 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:28 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:29 localhost init: serial main process (19684) killed by HUP signal
Nov 20 21:12:30 localhost init: serial main process (19697) killed by HUP signal
Nov 20 21:12:30 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:30 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:30 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:30 localhost kernel: Call Trace:
Nov 20 21:12:30 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:30 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:30 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:30 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:30 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:30 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:30 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:30 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:30 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:30 localhost kernel: Call Trace:
Nov 20 21:12:30 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:30 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:30 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:30 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:30 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:30 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:31 localhost init: serial main process (19710) killed by HUP signal
Nov 20 21:12:32 localhost init: serial main process (19723) killed by HUP signal
Nov 20 21:12:33 localhost init: serial main process (19736) killed by HUP signal
Nov 20 21:12:34 localhost init: serial main process (19749) killed by HUP signal
Nov 20 21:12:34 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:34 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:34 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:34 localhost kernel: Call Trace:
Nov 20 21:12:34 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:34 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:34 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:34 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:34 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:34 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:34 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:34 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:34 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:34 localhost kernel: Call Trace:
Nov 20 21:12:34 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:34 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:34 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:34 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:34 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:34 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:34 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:34 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:34 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:34 localhost kernel: Call Trace:
Nov 20 21:12:34 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:34 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:34 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:34 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:34 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:34 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:34 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:34 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:34 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:34 localhost kernel: Call Trace:
Nov 20 21:12:34 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:34 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:34 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:34 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:34 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:34 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:35 localhost init: serial main process (19762) killed by HUP signal
Nov 20 21:12:36 localhost init: serial main process (19775) killed by HUP signal
Nov 20 21:12:36 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:36 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:36 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:36 localhost kernel: Call Trace:
Nov 20 21:12:36 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:36 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:36 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:36 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:36 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:36 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:36 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:36 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:36 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:36 localhost kernel: Call Trace:
Nov 20 21:12:36 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:36 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:36 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:36 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:36 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:36 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:37 localhost init: serial main process (19788) killed by HUP signal
Nov 20 21:12:38 localhost init: serial main process (19801) killed by HUP signal
Nov 20 21:12:38 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:38 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:38 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:38 localhost kernel: Call Trace:
Nov 20 21:12:38 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:38 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:38 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:38 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:38 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:38 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:38 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:38 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:38 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:38 localhost kernel: Call Trace:
Nov 20 21:12:38 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:38 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:38 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:38 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:38 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:38 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:39 localhost init: serial main process (19814) killed by HUP signal
Nov 20 21:12:40 localhost init: serial main process (19827) killed by HUP signal
Nov 20 21:12:40 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:40 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:40 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:40 localhost kernel: Call Trace:
Nov 20 21:12:40 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:40 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:40 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:40 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:40 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:40 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:40 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:40 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:40 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:40 localhost kernel: Call Trace:
Nov 20 21:12:40 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:40 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:40 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:40 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:40 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:40 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:41 localhost init: serial main process (19840) killed by HUP signal
Nov 20 21:12:42 localhost init: serial main process (19853) killed by HUP signal
Nov 20 21:12:43 localhost init: serial main process (19866) killed by HUP signal
Nov 20 21:12:44 localhost init: serial main process (19879) killed by HUP signal
Nov 20 21:12:44 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:44 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:44 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:44 localhost kernel: Call Trace:
Nov 20 21:12:44 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:44 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:44 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:44 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:44 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:44 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:44 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:44 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:44 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:44 localhost kernel: Call Trace:
Nov 20 21:12:44 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:44 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:44 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:44 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:44 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:44 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:44 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:44 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:44 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:44 localhost kernel: Call Trace:
Nov 20 21:12:44 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:44 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:44 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:44 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:44 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:44 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:44 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:44 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:44 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:44 localhost kernel: Call Trace:
Nov 20 21:12:44 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:44 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:44 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:44 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:44 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:44 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:45 localhost init: serial main process (19892) killed by HUP signal
Nov 20 21:12:46 localhost init: serial main process (19905) killed by HUP signal
Nov 20 21:12:46 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:46 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:46 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:46 localhost kernel: Call Trace:
Nov 20 21:12:46 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:46 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:46 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:46 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:46 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:46 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:46 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:46 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:46 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:46 localhost kernel: Call Trace:
Nov 20 21:12:46 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:46 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:46 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:46 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:46 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:46 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:47 localhost init: serial main process (19918) killed by HUP signal
Nov 20 21:12:48 localhost init: serial main process (19931) killed by HUP signal
Nov 20 21:12:49 localhost init: serial main process (19944) killed by HUP signal
Nov 20 21:12:51 localhost init: serial main process (19957) killed by HUP signal
Nov 20 21:12:52 localhost init: serial main process (19970) killed by HUP signal
Nov 20 21:12:52 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:52 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:52 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:52 localhost kernel: Call Trace:
Nov 20 21:12:52 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:52 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:52 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:52 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:52 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:52 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:52 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:52 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:52 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:52 localhost kernel: Call Trace:
Nov 20 21:12:52 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:52 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:52 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:52 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:52 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:52 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:53 localhost init: serial main process (19983) killed by HUP signal
Nov 20 21:12:54 localhost init: serial main process (19996) killed by HUP signal
Nov 20 21:12:54 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:54 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:54 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:54 localhost kernel: Call Trace:
Nov 20 21:12:54 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:54 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:54 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:54 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:54 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:54 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:54 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:54 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:54 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:54 localhost kernel: Call Trace:
Nov 20 21:12:54 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:54 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:54 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:54 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:54 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:54 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:55 localhost init: serial main process (20009) killed by HUP signal
Nov 20 21:12:56 localhost init: serial main process (20022) killed by HUP signal
Nov 20 21:12:56 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:56 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:56 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:56 localhost kernel: Call Trace:
Nov 20 21:12:56 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:56 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:56 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:56 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:56 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:56 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:56 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:56 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:56 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:56 localhost kernel: Call Trace:
Nov 20 21:12:56 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:56 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:56 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:56 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:56 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:56 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:56 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:56 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:12:56 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:56 localhost kernel: Call Trace:
Nov 20 21:12:56 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:56 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:56 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:12:56 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:56 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:56 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:56 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:12:56 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:12:56 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:12:56 localhost kernel: Call Trace:
Nov 20 21:12:56 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:12:56 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:12:56 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:12:56 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:12:56 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:12:56 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:12:57 localhost init: serial main process (20035) killed by HUP signal
Nov 20 21:12:58 localhost init: serial main process (20048) killed by HUP signal
Nov 20 21:12:59 localhost init: serial main process (20061) killed by HUP signal
Nov 20 21:13:00 localhost init: serial main process (20074) killed by HUP signal
Nov 20 21:13:01 localhost init: serial main process (20087) killed by HUP signal
Nov 20 21:13:02 localhost init: serial main process (20100) killed by HUP signal
Nov 20 21:13:02 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:02 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:13:02 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:02 localhost kernel: Call Trace:
Nov 20 21:13:02 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:02 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:02 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:13:02 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:02 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:02 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:02 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:02 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:13:02 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:02 localhost kernel: Call Trace:
Nov 20 21:13:02 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:02 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:02 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:13:02 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:02 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:02 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:03 localhost init: serial main process (20113) killed by HUP signal
Nov 20 21:13:04 localhost init: serial main process (20126) killed by HUP signal
Nov 20 21:13:05 localhost init: serial main process (20139) killed by HUP signal
Nov 20 21:13:06 localhost init: serial main process (20152) killed by HUP signal
Nov 20 21:13:07 localhost init: serial main process (20165) killed by HUP signal
Nov 20 21:13:08 localhost init: serial main process (20178) killed by HUP signal
Nov 20 21:13:08 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:08 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:13:08 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:08 localhost kernel: Call Trace:
Nov 20 21:13:08 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:08 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:08 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:13:08 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:08 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:08 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:08 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:08 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:13:08 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:08 localhost kernel: Call Trace:
Nov 20 21:13:08 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:08 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:08 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:13:08 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:08 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:08 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:09 localhost init: serial main process (20191) killed by HUP signal
Nov 20 21:13:10 localhost init: serial main process (20204) killed by HUP signal
Nov 20 21:13:10 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:10 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:13:10 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:10 localhost kernel: Call Trace:
Nov 20 21:13:10 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:10 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:10 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:13:10 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:10 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:10 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:10 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:10 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:13:10 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:10 localhost kernel: Call Trace:
Nov 20 21:13:10 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:10 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:10 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:13:10 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:10 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:10 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:10 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:10 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:13:10 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:10 localhost kernel: Call Trace:
Nov 20 21:13:10 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:10 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:10 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:13:10 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:10 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:10 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:10 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:10 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:13:10 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:10 localhost kernel: Call Trace:
Nov 20 21:13:10 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:10 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:10 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:13:10 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:10 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:10 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:11 localhost init: serial main process (20217) killed by HUP signal
Nov 20 21:13:12 localhost init: serial main process (20230) killed by HUP signal
Nov 20 21:13:13 localhost init: serial main process (20243) killed by HUP signal
Nov 20 21:13:14 localhost init: serial main process (20256) killed by HUP signal
Nov 20 21:13:14 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:14 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:13:14 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:14 localhost kernel: Call Trace:
Nov 20 21:13:14 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:14 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:14 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:13:14 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:14 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:14 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:14 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:14 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:13:14 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:14 localhost kernel: Call Trace:
Nov 20 21:13:14 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:14 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:14 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:13:14 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:14 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:14 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:15 localhost init: serial main process (20269) killed by HUP signal
Nov 20 21:13:16 localhost init: serial main process (20282) killed by HUP signal
Nov 20 21:13:17 localhost init: serial main process (20295) killed by HUP signal
Nov 20 21:13:18 localhost init: serial main process (20308) killed by HUP signal
Nov 20 21:13:18 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:18 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:13:18 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:18 localhost kernel: Call Trace:
Nov 20 21:13:18 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:18 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:18 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:13:18 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:18 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:18 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:18 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:18 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:13:18 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:18 localhost kernel: Call Trace:
Nov 20 21:13:18 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:18 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:18 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:13:18 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:18 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:18 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:19 localhost init: serial main process (20321) killed by HUP signal
Nov 20 21:13:20 localhost init: serial main process (20334) killed by HUP signal
Nov 20 21:13:21 localhost init: serial main process (20347) killed by HUP signal
Nov 20 21:13:22 localhost init: serial main process (20360) killed by HUP signal
Nov 20 21:13:22 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:22 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:13:22 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:22 localhost kernel: Call Trace:
Nov 20 21:13:22 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:22 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:22 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:13:22 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:22 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:22 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:22 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:22 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:13:22 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:22 localhost kernel: Call Trace:
Nov 20 21:13:22 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:22 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:22 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:13:22 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:22 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:22 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:23 localhost init: serial main process (20373) killed by HUP signal
Nov 20 21:13:24 localhost init: serial main process (20386) killed by HUP signal
Nov 20 21:13:25 localhost init: serial main process (20399) killed by HUP signal
Nov 20 21:13:26 localhost init: serial main process (20412) killed by HUP signal
Nov 20 21:13:26 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:26 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:13:26 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:26 localhost kernel: Call Trace:
Nov 20 21:13:26 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:26 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:26 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:13:26 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:26 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:26 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:26 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:26 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:13:26 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:26 localhost kernel: Call Trace:
Nov 20 21:13:26 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:26 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:26 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:13:26 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:26 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:26 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:26 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:26 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:13:26 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:26 localhost kernel: Call Trace:
Nov 20 21:13:26 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:26 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:26 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:13:26 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:26 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:26 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:26 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:26 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:13:26 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:26 localhost kernel: Call Trace:
Nov 20 21:13:26 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:26 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:26 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:13:26 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:26 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:26 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:26 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:26 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:13:26 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:26 localhost kernel: Call Trace:
Nov 20 21:13:26 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:26 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:26 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:13:26 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:26 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:26 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:26 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:26 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:13:26 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:26 localhost kernel: Call Trace:
Nov 20 21:13:26 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:26 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:26 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:13:26 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:26 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:26 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:27 localhost init: serial main process (20425) killed by HUP signal
Nov 20 21:13:28 localhost init: serial main process (20438) killed by HUP signal
Nov 20 21:13:28 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:28 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:13:28 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:28 localhost kernel: Call Trace:
Nov 20 21:13:28 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:28 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:28 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:13:28 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:28 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:28 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:28 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:28 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:13:28 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:28 localhost kernel: Call Trace:
Nov 20 21:13:28 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:28 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:28 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:13:28 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:28 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:28 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:29 localhost init: serial main process (20451) killed by HUP signal
Nov 20 21:13:30 localhost init: serial main process (20464) killed by HUP signal
Nov 20 21:13:31 localhost init: serial main process (20477) killed by HUP signal
Nov 20 21:13:32 localhost init: serial main process (20490) killed by HUP signal
Nov 20 21:13:32 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:32 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:13:32 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:32 localhost kernel: Call Trace:
Nov 20 21:13:32 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:32 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:32 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:13:32 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:32 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:32 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:32 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:32 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:13:32 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:32 localhost kernel: Call Trace:
Nov 20 21:13:32 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:32 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:32 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:13:32 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:32 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:32 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:33 localhost init: serial main process (20503) killed by HUP signal
Nov 20 21:13:34 localhost init: serial main process (20516) killed by HUP signal
Nov 20 21:13:34 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:34 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:13:34 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:34 localhost kernel: Call Trace:
Nov 20 21:13:34 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:34 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:34 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:13:34 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:34 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:34 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:34 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:34 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:13:34 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:34 localhost kernel: Call Trace:
Nov 20 21:13:34 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:34 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:34 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:13:34 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:34 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:34 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:35 localhost init: serial main process (20529) killed by HUP signal
Nov 20 21:13:36 localhost init: serial main process (20542) killed by HUP signal
Nov 20 21:13:37 localhost init: serial main process (20555) killed by HUP signal
Nov 20 21:13:38 localhost init: serial main process (20568) killed by HUP signal
Nov 20 21:13:39 localhost init: serial main process (20581) killed by HUP signal
Nov 20 21:13:40 localhost init: serial main process (20594) killed by HUP signal
Nov 20 21:13:41 localhost init: serial main process (20607) killed by HUP signal
Nov 20 21:13:42 localhost init: serial main process (20620) killed by HUP signal
Nov 20 21:13:42 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:42 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:13:42 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:42 localhost kernel: Call Trace:
Nov 20 21:13:42 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:42 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:42 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:13:42 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:42 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:42 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:42 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:42 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:13:42 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:42 localhost kernel: Call Trace:
Nov 20 21:13:42 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:42 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:42 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:13:42 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:42 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:42 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:42 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:42 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:13:42 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:42 localhost kernel: Call Trace:
Nov 20 21:13:42 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:42 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:42 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:13:42 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:42 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:42 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:42 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:42 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:13:42 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:42 localhost kernel: Call Trace:
Nov 20 21:13:42 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:42 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:42 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:13:42 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:42 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:42 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:43 localhost init: serial main process (20633) killed by HUP signal
Nov 20 21:13:44 localhost init: serial main process (20646) killed by HUP signal
Nov 20 21:13:45 localhost init: serial main process (20659) killed by HUP signal
Nov 20 21:13:46 localhost init: serial main process (20672) killed by HUP signal
Nov 20 21:13:47 localhost init: serial main process (20685) killed by HUP signal
Nov 20 21:13:48 localhost init: serial main process (20698) killed by HUP signal
Nov 20 21:13:50 localhost init: serial main process (20711) killed by HUP signal
Nov 20 21:13:50 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:50 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:13:50 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:50 localhost kernel: Call Trace:
Nov 20 21:13:50 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:50 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:50 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:13:50 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:50 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:50 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:50 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:50 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:13:50 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:50 localhost kernel: Call Trace:
Nov 20 21:13:50 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:50 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:50 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:13:50 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:50 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:50 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:50 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:50 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:13:50 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:50 localhost kernel: Call Trace:
Nov 20 21:13:50 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:50 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:50 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:13:50 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:50 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:50 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:50 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:50 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:13:50 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:50 localhost kernel: Call Trace:
Nov 20 21:13:50 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:50 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:50 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:13:50 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:50 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:50 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:51 localhost init: serial main process (20724) killed by HUP signal
Nov 20 21:13:52 localhost init: serial main process (20737) killed by HUP signal
Nov 20 21:13:53 localhost init: serial main process (20750) killed by HUP signal
Nov 20 21:13:54 localhost init: serial main process (20763) killed by HUP signal
Nov 20 21:13:55 localhost init: serial main process (20776) killed by HUP signal
Nov 20 21:13:56 localhost init: serial main process (20789) killed by HUP signal
Nov 20 21:13:57 localhost init: serial main process (20802) killed by HUP signal
Nov 20 21:13:58 localhost init: serial main process (20815) killed by HUP signal
Nov 20 21:13:58 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:58 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:13:58 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:58 localhost kernel: Call Trace:
Nov 20 21:13:58 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:58 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:58 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:13:58 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:58 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:58 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:58 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:13:58 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:13:58 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:13:58 localhost kernel: Call Trace:
Nov 20 21:13:58 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:13:58 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:13:58 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:13:58 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:13:58 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:13:58 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:13:59 localhost init: serial main process (20828) killed by HUP signal
Nov 20 21:14:00 localhost init: serial main process (20841) killed by HUP signal
Nov 20 21:14:00 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:14:00 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:14:00 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:14:00 localhost kernel: Call Trace:
Nov 20 21:14:00 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:14:00 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:14:00 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:14:00 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:14:00 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:14:00 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:14:00 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:14:00 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:14:00 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:14:00 localhost kernel: Call Trace:
Nov 20 21:14:00 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:14:00 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:14:00 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:14:00 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:14:00 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:14:00 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:14:01 localhost init: serial main process (20854) killed by HUP signal
Nov 20 21:14:02 localhost init: serial main process (20867) killed by HUP signal
Nov 20 21:14:02 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:14:02 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:14:02 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:14:02 localhost kernel: Call Trace:
Nov 20 21:14:02 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:14:02 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:14:02 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:14:02 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:14:02 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:14:02 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:14:02 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:14:02 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:14:02 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:14:02 localhost kernel: Call Trace:
Nov 20 21:14:02 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:14:02 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:14:02 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:14:02 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:14:02 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:14:02 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:14:03 localhost init: serial main process (20880) killed by HUP signal
Nov 20 21:14:04 localhost init: serial main process (20893) killed by HUP signal
Nov 20 21:14:05 localhost init: serial main process (20906) killed by HUP signal
Nov 20 21:14:06 localhost init: serial main process (20919) killed by HUP signal
Nov 20 21:14:06 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:14:06 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:14:06 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:14:06 localhost kernel: Call Trace:
Nov 20 21:14:06 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:14:06 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:14:06 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:14:06 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:14:06 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:14:06 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:14:06 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:14:06 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:14:06 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:14:06 localhost kernel: Call Trace:
Nov 20 21:14:06 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:14:06 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:14:06 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:14:06 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:14:06 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:14:06 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:14:07 localhost init: serial main process (20932) killed by HUP signal
Nov 20 21:14:08 localhost init: serial main process (20945) killed by HUP signal
Nov 20 21:14:09 localhost init: serial main process (20958) killed by HUP signal
Nov 20 21:14:10 localhost init: serial main process (20971) killed by HUP signal
Nov 20 21:14:11 localhost init: serial main process (20984) killed by HUP signal
Nov 20 21:14:12 localhost init: serial main process (20997) killed by HUP signal
Nov 20 21:14:13 localhost init: serial main process (21010) killed by HUP signal
Nov 20 21:14:14 localhost init: serial main process (21023) killed by HUP signal
Nov 20 21:14:14 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:14:14 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:14:14 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:14:14 localhost kernel: Call Trace:
Nov 20 21:14:14 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:14:14 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:14:14 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:14:14 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:14:14 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:14:14 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:14:14 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:14:14 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:14:14 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:14:14 localhost kernel: Call Trace:
Nov 20 21:14:14 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:14:14 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:14:14 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:14:14 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:14:14 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:14:14 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:14:14 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:14:14 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:14:14 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:14:14 localhost kernel: Call Trace:
Nov 20 21:14:14 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:14:14 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:14:14 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:14:14 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:14:14 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:14:14 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:14:14 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:14:14 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:14:14 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:14:14 localhost kernel: Call Trace:
Nov 20 21:14:14 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:14:14 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:14:14 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:14:14 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:14:14 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:14:14 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:14:15 localhost init: serial main process (21036) killed by HUP signal
Nov 20 21:14:16 localhost init: serial main process (21049) killed by HUP signal
Nov 20 21:14:16 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:14:16 localhost kernel: caller is __schedule+0xe/0x7d4
Nov 20 21:14:16 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:14:16 localhost kernel: Call Trace:
Nov 20 21:14:16 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:14:16 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:14:16 localhost kernel: [<c06dc689>] __schedule+0xe/0x7d4
Nov 20 21:14:16 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:14:16 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:14:16 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:14:16 localhost kernel: BUG: using smp_processor_id() in preemptible [00000000] code: smash/6801
Nov 20 21:14:16 localhost kernel: caller is __schedule+0x93/0x7d4
Nov 20 21:14:16 localhost kernel: Pid: 6801, comm: smash Not tainted 2.6.31.6-rt19 #1
Nov 20 21:14:16 localhost kernel: Call Trace:
Nov 20 21:14:16 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
Nov 20 21:14:16 localhost kernel: [<c05499a6>] debug_smp_processor_id+0xa6/0xbc
Nov 20 21:14:16 localhost kernel: [<c06dc70e>] __schedule+0x93/0x7d4
Nov 20 21:14:16 localhost kernel: [<c046621f>] ? audit_syscall_exit+0xfa/0x10f
Nov 20 21:14:16 localhost kernel: [<c040a955>] ? syscall_trace_leave+0xc8/0xef
Nov 20 21:14:16 localhost kernel: [<c040338a>] work_resched+0x5/0x19
Nov 20 21:14:17 localhost init: serial main process (21062) killed by HUP signal
Nov 20 21:14:18 localhost init: serial main process (21075) killed by HUP signal
Nov 20 21:14:19 localhost init: serial main process (21088) killed by HUP signal
Nov 20 21:14:20 localhost init: serial main process (21101) killed by HUP signal
Nov 20 21:14:21 localhost init: serial main process (21114) killed by HUP signal
Nov 20 21:14:22 localhost init: serial main process (21127) killed by HUP signal
Nov 20 21:14:23 localhost init: serial main process (21140) killed by HUP signal
Nov 20 21:14:24 localhost init: serial main process (21153) killed by HUP signal
Nov 20 21:14:25 localhost init: serial main process (21166) killed by HUP signal
Nov 20 21:14:26 localhost init: serial main process (21179) killed by HUP signal
Nov 20 21:14:27 localhost init: serial main process (21192) killed by HUP signal
Nov 20 21:14:28 localhost init: serial main process (21205) killed by HUP signal
Nov 20 21:14:29 localhost init: serial main process (21218) killed by HUP signal
Nov 20 21:14:30 localhost init: serial main process (21231) killed by HUP signal
Nov 20 21:14:31 localhost init: serial main process (21244) killed by HUP signal
Nov 20 21:14:32 localhost init: serial main process (21257) killed by HUP signal
Nov 20 21:14:33 localhost init: serial main process (21270) killed by HUP signal
Nov 20 21:14:34 localhost init: serial main process (21283) killed by HUP signal
Nov 20 21:14:35 localhost init: serial main process (21296) killed by HUP signal
Nov 20 21:14:36 localhost init: serial main process (21309) killed by HUP signal
Nov 20 21:14:37 localhost init: serial main process (21322) killed by HUP signal
Nov 20 21:14:38 localhost init: serial main process (21335) killed by HUP signal
Nov 20 21:14:39 localhost init: serial main process (21348) killed by HUP signal
Nov 20 21:14:40 localhost init: serial main process (21361) killed by HUP signal
Nov 20 21:14:41 localhost init: serial main process (21374) killed by HUP signal
Nov 20 21:14:42 localhost init: serial main process (21387) killed by HUP signal
Nov 20 21:14:43 localhost init: serial main process (21400) killed by HUP signal
Nov 20 21:14:44 localhost init: serial main process (21413) killed by HUP signal
Nov 20 21:14:45 localhost init: serial main process (21426) killed by HUP signal
Nov 20 21:14:46 localhost init: serial main process (21439) killed by HUP signal
Nov 20 21:14:47 localhost init: serial main process (21452) killed by HUP signal
Nov 20 21:14:48 localhost init: serial main process (21465) killed by HUP signal
Nov 20 21:18:29 localhost kernel: imklog 3.21.3, log source = /proc/kmsg started.
Nov 20 21:18:29 localhost kernel: Initializing cgroup subsys cpuset
Nov 20 21:18:29 localhost kernel: Linux version 2.6.31.6-rt19 (root@mgwtest) (gcc version 4.3.2 20081105 (Red Hat 4.3.2-7) (GCC) ) #1 SMP PREEMPT RT Wed Nov 18 22:20:20 CST 2009
Nov 20 21:18:29 localhost kernel: KERNEL supported cpus:
Nov 20 21:18:29 localhost kernel:  Intel GenuineIntel
Nov 20 21:18:29 localhost kernel:  AMD AuthenticAMD
Nov 20 21:18:29 localhost kernel:  NSC Geode by NSC
Nov 20 21:18:29 localhost kernel:  Cyrix CyrixInstead
Nov 20 21:18:29 localhost kernel:  Centaur CentaurHauls
Nov 20 21:18:29 localhost kernel:  Transmeta GenuineTMx86
Nov 20 21:18:29 localhost kernel:  Transmeta TransmetaCPU
Nov 20 21:18:29 localhost kernel:  UMC UMC UMC UMC
Nov 20 21:18:29 localhost kernel: BIOS-provided physical RAM map:
Nov 20 21:18:29 localhost kernel: BIOS-e820: 0000000000000000 - 000000000009a000 (usable)
Nov 20 21:18:29 localhost kernel: BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Nov 20 21:18:29 localhost kernel: BIOS-e820: 0000000000100000 - 000000007bbffc00 (usable)
Nov 20 21:18:29 localhost kernel: BIOS-e820: 000000007bbffc00 - 000000007bc53c00 (ACPI NVS)
Nov 20 21:18:29 localhost kernel: BIOS-e820: 000000007bc53c00 - 000000007bc55c00 (ACPI data)
Nov 20 21:18:29 localhost kernel: BIOS-e820: 000000007bc55c00 - 000000007e00000el.org.




