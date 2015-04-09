From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [patch] rt, hotplug: Use set_cpus_allowed_ptr() in
 sync_unplug_thread()
Date: Thu, 09 Apr 2015 19:40:01 +0200
Message-ID: <1428601201.2328.4.camel@gmail.com>
References: <1427181289.3316.27.camel@gmail.com>
	 <20150409140512.GB2416@linutronix.de> <1428589425.6927.10.camel@gmail.com>
	 <552692C3.20709@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36606 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbbDIRkF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Apr 2015 13:40:05 -0400
In-Reply-To: <552692C3.20709@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2015-04-09 at 16:54 +0200, Sebastian Andrzej Siewior wrote:
> On 04/09/2015 04:23 PM, Mike Galbraith wrote:
> > On Thu, 2015-04-09 at 16:05 +0200, Sebastian Andrzej Siewior wrote:
> > > * Mike Galbraith | 2015-03-24 08:14:49 [+0100]:
> > > 
> > > > do_set_cpus_allowed() is not safe vs ->sched_class change.
> > > > 
> > > > crash> bt
> > > > PID: 11676  TASK: ffff88026f979da0  CPU: 22  COMMAND: 
> > > > "sync_unplug/22"
> > > > #0 [ffff880274d25bc8] machine_kexec at ffffffff8103b41c
> > > > #1 [ffff880274d25c18] crash_kexec at ffffffff810d881a
> > > > #2 [ffff880274d25cd8] oops_end at ffffffff81525818
> > > > #3 [ffff880274d25cf8] do_invalid_op at ffffffff81003096
> > > > #4 [ffff880274d25d90] invalid_op at ffffffff8152d3de
> > > >    [exception RIP: set_cpus_allowed_rt+18]
> > > >    RIP: ffffffff8109e012  RSP: ffff880274d25e48  RFLAGS: 
> > > > 00010202
> > > >    RAX: ffffffff8109e000  RBX: ffff88026f979da0  RCX: 
> > > > ffff8802770cb6e8
> > > >    RDX: 0000000000000000  RSI: ffffffff81add700  RDI: 
> > > > ffff88026f979da0
> > > >    RBP: ffff880274d25e78   R8: ffffffff816112e0   R9: 
> > > > 0000000000000001
> > > >    R10: 0000000000000001  R11: 0000000000011940  R12: 
> > > > ffff88026f979da0
> > > >    R13: ffff8802770cb6d0  R14: ffff880274d25fd8  R15: 
> > > > 0000000000000000
> > > >    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> > > > #5 [ffff880274d25e60] do_set_cpus_allowed at ffffffff8108e65f
> > > > #6 [ffff880274d25e80] sync_unplug_thread at ffffffff81058c08
> > > > #7 [ffff880274d25ed8] kthread at ffffffff8107cad6
> > > > #8 [ffff880274d25f50] ret_from_fork at ffffffff8152bbbc
> > > > crash> task_struct ffff88026f979da0 | grep class
> > > >  sched_class = 0xffffffff816111e0 <fair_sched_class+64>,
> > > 
> > > Is this a one-time thing or can you reproduce this?
> > 
> > Well, I can't reproduce it now, having fixed it ;-)  Dunno how 
> > repeatable it would be if I un-fixed it.
> > 
> > > What happen here? I doubt p vanished. +18 is mostlikely the
> > > "migrate_disabled_updated()" check.
> > > 
> > > I doubt p->sched_class->set_cpus_allowed or p->sched_class vanish
> > > between testing for it and invoking it, or did it?
> > 
> > Class changed under us.  We saw rt task, called rt method, rt 
> > method 
> > said BUG_ON(!rt_task(p)), as task had become fair class.
> 
> but why does backtrace then end in do_set_cpus_allowed and not in
> set_cpus_allowed_rt()? Is it possible to provide a backtrace which 
> ends
> in the BUG() statement in set_cpus_allowed_rt() if this is where it 
> is
> coming from?

[exception RIP: set_cpus_allowed_rt+18] is BUG_ON(!rt_task(p)).

        -Mike



