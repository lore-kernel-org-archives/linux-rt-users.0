From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: 2.6.20-rc4-rt3 on i.MX oopses !?
Date: Fri, 12 Jan 2007 20:20:47 +0100
Message-ID: <20070112192047.GA6111@himalia.labnet.pengutronix.de>
References: <45A7C96F.90609@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:38526 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964956AbXALTVA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Jan 2007 14:21:00 -0500
To: Steven Scholz <steven.scholz@imc-berlin.de>
Content-Disposition: inline
In-Reply-To: <45A7C96F.90609@imc-berlin.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Jan 12, 2007 at 06:46:23PM +0100, Steven Scholz wrote:
> Hi all,
> 
> anyone tried 2.6.20-rc4-rt3 on an i.MX board?

Yes

> 
> On my mx1ads I get
> 
> RAMDISK: Compressed image found at block 0
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
> pgd = c0004000
> [00000004] *pgd=00000000
> Internal error: Oops: 5 [#1]
> Modules linked in:
> CPU: 0
> PC is at get_next_event_device+0x48/0x64
> LR is at clockevents_next_event_available+0x24/0x60
> pc : [<c0058104>]    lr : [<c0058144>]    Not tainted
> sp : c0bb9ea0  ip : 00000000  fp : c0bb9eac
> r10: ffffffff  r9 : c01d8438  r8 : c01c6bf0
> r7 : c01c4d34  r6 : c0bb8000  r5 : c01c6bf0  r4 : 20000013
> r3 : c01da08c  r2 : 00000000  r1 : 00000004  r0 : 00000000
> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
> Control: C000717F
> Table: 08004000  DAC: 00000017
> Process softirq-timer/0 (pid: 4, stack limit = 0xc0bb8250)
> Stack: (0xc0bb9ea0 to 0xc0bba000)
> < - snip - >
> Backtrace:
> [<c00580bc>] (get_next_event_device+0x0/0x64) from [<c0058144>]
> (clockevents_next_event_available+0x24/0x60)
> [<c0058120>] (clockevents_next_event_available+0x0/0x60) from [<c0055704>]
> (hrtimer_run_queues+0x230/0x3c8) r5 = C01C6BF0  r4 = 00000001
> [<c00554d4>] (hrtimer_run_queues+0x0/0x3c8) from [<c0045608>]
> (run_timer_softirq+0xbc/0xe18)
> [<c004554c>] (run_timer_softirq+0x0/0xe18) from [<c0040a08>]
> (ksoftirqd+0x100/0x1b0)
> [<c0040908>] (ksoftirqd+0x0/0x1b0) from [<c0051000>] (kthread+0x110/0x13c)
> [<c0050ef0>] (kthread+0x0/0x13c) from [<c003d268>] (do_exit+0x0/0x8ac)
>  r8 = 00000000  r7 = 00000000  r6 = 00000000  r5 = 00000000
>  r4 = 00000000
> Code: e15c0000 cafffff8 e59f3018 e5932000 (e5921004)
>  <6>note: softirq-timer/0[4] exited with preempt_count 1
> VFS: Mounted root (ext2 filesystem).
> Freeing init memory: 88K

get_next_event_device() looks like this:

static int get_next_event_device(void)
{
        struct local_events *devices = &__get_cpu_var(local_eventdevices);
        int i;

        for (i = 0; i < devices->installed; i++) {
                struct clock_event_device *evt;

                evt = devices->events[i].event;
                if (evt->capabilities & CLOCK_CAP_NEXTEVT)
                        return i;
        }

        if (global_eventdevice.event->capabilities & CLOCK_CAP_NEXTEVT)
                return GLOBAL_CLOCK_EVENT;

        return -ENODEV;
}

Loop through all available devices and search for one with CLOCK_CAP_NEXTEVT.
If none is found global_eventdevice is dereferenced, which isn't set
when you have no clock_event_device at all. Have you got the i.MX
clockevent patch applied? You can get the latest version here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0701.1/0478.html

Maybe we could emit a warning message here instead of oopsing.

> 
> Sascha, do you know if your clocksource/clockevent patches made it into
> mainline?

Clocksource yes, clockevent no

Sascha

-- 
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
