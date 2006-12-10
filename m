From: Gautam Thaker <gthaker@atl.lmco.com>
Subject: Re: 2.6.19-rt11 boot failure
Date: Sun, 10 Dec 2006 17:47:16 -0500
Message-ID: <457C8E74.9090301@atl.lmco.com>
References: <60535.192.168.1.8.1165699722.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000005040100020107090600"
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762253AbWLJWrQ@vger.kernel.org>
To: Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <60535.192.168.1.8.1165699722.squirrel@www.rncbc.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------000005040100020107090600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I see the attached two messages on the console output.  In one case for me 2.6.19-rt11 seemed to 
boot ok, in other case it do not seem to. I am not sure if this problem is related to disabled HPET, 
but I will try that also.

Gautam


--------------000005040100020107090600
Content-Type: text/plain;
 name="2.6.19-rt11.bug.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.19-rt11.bug.1"

Kernel 2.6.19-rt11-UNI on an i686

a.simple-2-nodes.corbatests.emulab.net login: softirq-timer/0/4[CPU#0]: BUG in update_wall_time0
 [<c0104c54>] dump_trace+0x69/0x1ac
 [<c0104dae>] show_trace_log_lvl+0x17/0x2b
 [<c041e7f9>] pmap_getport_ops+0xbc5/0x5df00
DWARF2 unwinder stuck at pmap_getport_ops+0xbc5/0x5df00

Leftover inexact backtrace:

 [<c01050fc>] show_trace+0xf/0x11
 [<c0105111>] dump_stack+0x13/0x15
 [<c011bf16>] __WARN_ON+0x5b/0x89
 [<c01237ce>] run_timer_softirq+0xd8/0xb21
 [<c0102ed6>] __switch_to+0x19/0x182
 [<c012d5cc>] posix_cpu_timers_thread+0x0/0xc3
 [<c03feec9>] preempt_schedule_irq+0x37/0x58
 [<c011f968>] ksoftirqd+0x0/0x179
 [<c03ff378>] schedule+0xc6/0xe2
 [<c011f968>] ksoftirqd+0x0/0x179
 [<c011fa53>] ksoftirqd+0xeb/0x179
 [<c012bbbe>] kthread+0xac/0xda
 [<c012bb12>] kthread+0x0/0xda
 [<c01049f3>] kernel_thread_helper+0x7/0x10
 =======================

Fedora Core release 4 (Stentz)
Kernel 2.6.19-rt11-UNI on an i686

a.simple-2-nodes.corbatests.emulab.net login:      


--------------000005040100020107090600
Content-Type: text/plain;
 name="2.6.19-rt11.bug.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.19-rt11.bug.2"

Boot Complete

Fedora Core release 4 (Stentz)
Kernel 2.6.19-rt11-UNI on an i686

a.simple-2-nodes.corbatests.emulab.net login: softirq-timer/0/4[CPU#0]: BUG in update_wall_time0
 [<c0104c54>] dump_trace+0x69/0x1ac
 [<c0104dae>] show_trace_log_lvl+0x17/0x2b
 [<c041e7f9>] pmap_getport_ops+0xbc5/0x5df00
DWARF2 unwinder stuck at pmap_getport_ops+0xbc5/0x5df00

Leftover inexact backtrace:

 [<c01050fc>] show_trace+0xf/0x11
 [<c0105111>] dump_stack+0x13/0x15
 [<c011bf16>] __WARN_ON+0x5b/0x89
 [<c01237ce>] run_timer_softirq+0xd8/0xb21
 [<c012d5cc>] posix_cpu_timers_thread+0x0/0xc3
 [<c0102ed6>] __switch_to+0x19/0x182
 [<c012d5cc>] posix_cpu_timers_thread+0x0/0xc3
 [<c011f968>] ksoftirqd+0x0/0x179
 [<c03ff378>] schedule+0xc6/0xe2
 [<c011f968>] ksoftirqd+0x0/0x179
 [<c011fa53>] ksoftirqd+0xeb/0x179
 [<c012bbbe>] kthread+0xac/0xda
 [<c012bb12>] kthread+0x0/0xda
 [<c01049f3>] kernel_thread_helper+0x7/0x10
 =======================
BUG: time warp detected!
prev > now, 1d2da428324317aa > e312d9e1df154b25:
= 4186881206986329221 delta, on CPU#0
 [<c0104c54>] dump_trace+0x69/0x1ac
 [<c0104dae>] show_trace_log_lvl+0x17/0x2b
 [<c041e7f9>] pmap_getport_ops+0xbc5/0x5df00
DWARF2 unwinder stuck at pmap_getport_ops+0xbc5/0x5df00

Leftover inexact backtrace:

 [<c01050fc>] show_trace+0xf/0x11
 [<c0105111>] dump_stack+0x13/0x15
 [<c01232fe>] do_gettimeofday+0x151/0x17f
 [<c011f001>] sys_time+0x9/0x2d
 [<c0103e49>] sysenter_past_esp+0x56/0x79
 =======================

--------------000005040100020107090600--
