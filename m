From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: RCU stall and the system boot hang
Date: Sat, 28 Nov 2015 22:05:37 -0800
Message-ID: <20151129060537.GP26643@linux.vnet.ibm.com>
References: <CADUONQMsaiTyFPRxm8TfB4ec__XjXUCAhjxZHG8Mz=cExvz5Sw@mail.gmail.com>
 <20151127162809.GM26643@linux.vnet.ibm.com>
 <CADUONQN3yFyFQ8pfkS9u7UAYNjQym8f1JAGapeR9YV4E=7_xXg@mail.gmail.com>
 <20151128145342.GO26643@linux.vnet.ibm.com>
 <CADUONQOYtHvwzoWNW33=WXy5r-UBTqs_vKdeRUgg=YEqq1meWg@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: fupan li <lifupan@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:42806 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbbK2GFC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 29 Nov 2015 01:05:02 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Sat, 28 Nov 2015 23:05:01 -0700
Content-Disposition: inline
In-Reply-To: <CADUONQOYtHvwzoWNW33=WXy5r-UBTqs_vKdeRUgg=YEqq1meWg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Nov 29, 2015 at 12:46:10PM +0800, fupan li wrote:
> 2015-11-28 22:53 GMT+08:00 Paul E. McKenney <paulmck@linux.vnet.ibm.com>:
> 
> > On Sat, Nov 28, 2015 at 01:05:52PM +0800, fupan li wrote:
> > > 2015-11-28 0:28 GMT+08:00 Paul E. McKenney <paulmck@linux.vnet.ibm.com>:
> > >
> > > > On Fri, Nov 27, 2015 at 08:23:24PM +0800, fupan li wrote:
> > > > > Hi, Paul
> > > > >
> > > > > On my Wildcat_Pass (Haswell) board, the system boot will hang as
> > below.
> > > > > The kernel is preempt-rt kernel.
> > > > > But it was not reproduced every time, about 1 time per 5-10 boots.
> > > >
> > > > CCing LMKL and linux-rt-users in case anyone else is seeing this.
> > > >
> > > > OK, let's take a look at the stall warning...
> > > >
> > > > [ . . . ]
> > > >
> > > > > Btrfs loaded
> > > > > console [netcon0] enabled
> > > > > netconsole: network logging started
> > > > > rtc_cmos 00:00: setting system clock to 2015-11-11 18:18:03 UTC
> > > > (1447265883)
> > > > > usb 1-9: new full-speed USB device number 3 using xhci_hcd
> > > > > IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> > > > > IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
> > > > > usb 1-9: ep 0x81 - rounding interval to 64 microframes, ep desc says
> > 80
> > > > > microframes
> > > > > input: American Megatrends Inc. Virtual Keyboard and Mouse as
> > > > >
> > > >
> > /devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9:1.0/0003:046B:FF10.0002/input/input3
> > > > > hid-generic 0003:046B:FF10.0002: input: USB HID v1.10 Keyboard
> > [American
> > > > > Megatrends Inc. Virtual Keyboard and Mouse] on
> > usb-0000:00:14.0-9/input0
> > > > > input: American Megatrends Inc. Virtual Keyboard and Mouse as
> > > > >
> > > >
> > /devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9:1.1/0003:046B:FF10.0003/input/input4
> > > > > hid-generic 0003:046B:FF10.0003: input: USB HID v1.10 Mouse [American
> > > > > Megatrends Inc. Virtual Keyboard and Mouse] on
> > usb-0000:00:14.0-9/input1
> > > > > ixgbe 0000:02:00.0: registered PHC device on eth2
> > > > > IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
> > > > > ixgbe 0000:02:00.1: registered PHC device on eth3
> > > > > IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
> > > > > igb 0000:04:00.0 eth0: igb: eth0 NIC Link is Up 100 Mbps Full Duplex,
> > > > Flow
> > > > > Control: RX/TX
> > > > > IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> > > > > cfg80211: Calling CRDA to update world regulatory domain
> > > > > Sending DHCP requests ., OK
> > > > > random: nonblocking pool is initialized
> > > > > cfg80211: Calling CRDA to update world regulatory domain
> > > > > cfg80211: Calling CRDA to update world regulatory domain
> > > > > cfg80211: Calling CRDA to update world regulatory domain
> > > > > cfg80211: Calling CRDA to update world regulatory domain
> > > > > cfg80211: Calling CRDA to update world regulatory domain
> > > > > cfg80211: Calling CRDA to update world regulatory domain
> > > > > INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > > 12: (0 ticks this GP) idle=f48/0/0 softirq=0/0 fqs=0
> > > > > 17: (59 GPs behind) idle=55a/0/0 softirq=0/0 fqs=0
> > > >
> > > > So CPUs 12 and 17 are stalling the grace period.
> > > >
> > > > > (detected by 5, t=21002 jiffies, g=-237, c=-238, q=136)
> > > > > Task dump for CPU 12:
> > > > > swapper/12      R  running task        0     0      1 0x00200000
> > > > >  ffffffff8140f1f7 ffff880859037eb8 ffffffff810b7ff5 ffff880859037ea8
> > > > >  ffffffff810759ef ffffffff82140220 000000000000000c ffffffff82140220
> > > > >  ffff880859034000 ffff880859037ea8 ffffffff8140f1f7 ffff880859037ec8
> > > > > Call Trace:
> > > > >  [<ffffffff8140f1f7>] ? debug_smp_processor_id+0x17/0x20
> > > > >  [<ffffffff810b7ff5>] ? rcu_eqs_enter_common+0x85/0x240
> > > > >  [<ffffffff810759ef>] ? __atomic_notifier_call_chain+0x4f/0x70
> > > > >  [<ffffffff8140f1f7>] ? debug_smp_processor_id+0x17/0x20
> > > > >  [<ffffffff8100dd52>] ? mwait_idle+0x42/0x1d0
> > > > >  [<ffffffff8100ea8f>] ? arch_cpu_idle+0xf/0x20
> > > > >  [<ffffffff8109688e>] ? cpu_startup_entry+0xae/0x300
> > > > >  [<ffffffff8103aabc>] ? start_secondary+0x12c/0x140
> > > >
> > > > But CPU 12 seems to be idle (as is in fact indicated by the
> > "idle=55a/0/0"
> > > > above), so the grace-period kthread should have reported a quiescent
> > > > state on its behalf.
> > > >
> > > > > Task dump for CPU 17:
> > > > > swapper/17      R  running task        0     0      1 0x00200000
> > > > >  ffffffff8140f1f7 ffff880859063eb8 ffffffff810b7ff5 ffff880859063ea8
> > > > >  ffffffff810759ef ffffffff82140220 0000000000000011 ffffffff82140220
> > > > >  ffff880859060000 ffff880859063ea8 ffffffff8140f1f7 ffff880859063ec8
> > > > > Call Trace:
> > > > >  [<ffffffff8140f1f7>] ? debug_smp_processor_id+0x17/0x20
> > > > >  [<ffffffff810b7ff5>] ? rcu_eqs_enter_common+0x85/0x240
> > > > >  [<ffffffff810759ef>] ? __atomic_notifier_call_chain+0x4f/0x70
> > > > >  [<ffffffff8140f1f7>] ? debug_smp_processor_id+0x17/0x20
> > > > >  [<ffffffff8100dd52>] ? mwait_idle+0x42/0x1d0
> > > > >  [<ffffffff8100ea8f>] ? arch_cpu_idle+0xf/0x20
> > > > >  [<ffffffff8109688e>] ? cpu_startup_entry+0xae/0x300
> > > > >  [<ffffffff8103aabc>] ? start_secondary+0x12c/0x140
> > > >
> > > > And the same for CPU 17.
> > > >
> > > > > rcu_preempt kthread starved for 21002 jiffies!
> > > >
> > > > But the grace-period kthread hasn't had a chance to run for more
> > > > than 21 seconds, which explains why the grace period is not ending.
> > > >
> > > > Are you starting up a heavy real-time workload at boot time?
> > >
> > > No,  just a normal boot, and these stalls were happened before
> > > systemd services running.
> >
> > Interesting.  My testing show v4.1 being OK, with the first issues showing
> > up somewhere between v4.1 and v4.2.  Or at least v4.1 is reliable enough
> > that is passes 42 hours of focused rcutorture testing, where v4.2 tends
> > to fail in under two hours.  And it seems to happen only on multisocket
> > systems -- I seem to be able to hammer as hard as I want on my four-core
> > (eight hardware thread) laptop without an issue.
> >
> > So it might be something between v4.1 and v4.1.12-rt8-8.0.0.0_preempt-rt.
> > Could you please test commits in that range?
> >
> Hmmm, that's a narrow scope, I'll try to bisect  between them and find
> the key commit.

Please let me know how it goes!

> > > > > cfg80211: Calling CRDA to update world regulatory domain
> > > > > cfg80211: Calling CRDA to update world regulatory domain
> > > > > cfg80211: Exceeded CRDA call max attempts. Not calling CRDA
> > > > > INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > > 12: (0 ticks this GP) idle=04c/0/0 softirq=0/0 fqs=1
> > > >
> > > > At this point, CPU 17's quiescent state has been recorded.
> > > >
> > > > > (detected by 24, t=84007 jiffies, g=-237, c=-238, q=147)
> > > > > Task dump for CPU 12:
> > > > > swapper/12      R  running task        0     0      1 0x00200000
> > > > >  ffffffff8140f1f7 ffff880859037eb8 ffffffff810b7ff5 ffff880859037ea8
> > > > >  ffffffff810759ef ffffffff82140220 000000000000000c ffffffff82140220
> > > > >  ffff880859034000 ffff880859037ea8 ffffffff8140f1f7 ffff880859037ec8
> > > > > Call Trace:
> > > > >  [<ffffffff8140f1f7>] ? debug_smp_processor_id+0x17/0x20
> > > > >  [<ffffffff810b7ff5>] ? rcu_eqs_enter_common+0x85/0x240
> > > > >  [<ffffffff810759ef>] ? __atomic_notifier_call_chain+0x4f/0x70
> > > > >  [<ffffffff8140f1f7>] ? debug_smp_processor_id+0x17/0x20
> > > > >  [<ffffffff8100dd52>] ? mwait_idle+0x42/0x1d0
> > > > >  [<ffffffff8100ea8f>] ? arch_cpu_idle+0xf/0x20
> > > > >  [<ffffffff8109688e>] ? cpu_startup_entry+0xae/0x300
> > > > >  [<ffffffff8103aabc>] ? start_secondary+0x12c/0x140
> > > >
> > > > CPU 12 still looks idle.  Though it does appear to have transitioned
> > > > between idle and non-idle several times.
> > > >
> > > > > rcu_preempt kthread starved for 63005 jiffies!
> > > >
> > > > And the last time the grace-period kthread ran was about the time of
> > > > the first stall-warning message.  Strange...
> > > >
> > > > > INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > > 12: (0 ticks this GP) idle=0a8/0/0 softirq=0/0 fqs=0
> > > > > 17: (60 GPs behind) idle=6b4/0/0 softirq=0/0 fqs=0
> > > > > (detected by 11, t=21002 jiffies, g=-236, c=-237, q=151)
> > > >
> > > > And the old grace period (g=-237, c=-238) finished and a new one has
> > > > been stalled for 21 seconds.  Again, CPUs 12 and 17 are idle and
> > > > stalling the grace period.
> > > >
> > > > > Task dump for CPU 12:
> > > > > swapper/12      R  running task        0     0      1 0x00200000
> > > > >  ffffffff8140f1f7 ffff880859037eb8 ffffffff810b7ff5 ffff880859037ea8
> > > > >  ffffffff810759ef ffffffff82140220 000000000000000c ffffffff82140220
> > > > >  ffff880859034000 ffff880859037ea8 ffffffff8140f1f7 ffff880859037ec8
> > > > > Call Trace:
> > > > >  [<ffffffff8140f1f7>] ? debug_smp_processor_id+0x17/0x20
> > > > >  [<ffffffff810b7ff5>] ? rcu_eqs_enter_common+0x85/0x240
> > > > >  [<ffffffff810759ef>] ? __atomic_notifier_call_chain+0x4f/0x70
> > > > >  [<ffffffff8140f1f7>] ? debug_smp_processor_id+0x17/0x20
> > > > >  [<ffffffff8100dd52>] ? mwait_idle+0x42/0x1d0
> > > > >  [<ffffffff8100ea8f>] ? arch_cpu_idle+0xf/0x20
> > > > >  [<ffffffff8109688e>] ? cpu_startup_entry+0xae/0x300
> > > > >  [<ffffffff8103aabc>] ? start_secondary+0x12c/0x140
> > > > > Task dump for CPU 17:
> > > > > swapper/17      R  running task        0     0      1 0x00200000
> > > > >  ffffffff8140f1f7 ffff880859063eb8 ffffffff810b7ff5 ffff880859063ea8
> > > > >  ffffffff810759ef ffffffff82140220 0000000000000011 ffffffff82140220
> > > > >  ffff880859060000 ffff880859063ea8 ffffffff8140f1f7 ffff880859063ec8
> > > > > Call Trace:
> > > > >  [<ffffffff8140f1f7>] ? debug_smp_processor_id+0x17/0x20
> > > > >  [<ffffffff810b7ff5>] ? rcu_eqs_enter_common+0x85/0x240
> > > > >  [<ffffffff810759ef>] ? __atomic_notifier_call_chain+0x4f/0x70
> > > > >  [<ffffffff8140f1f7>] ? debug_smp_processor_id+0x17/0x20
> > > > >  [<ffffffff8100dd52>] ? mwait_idle+0x42/0x1d0
> > > > >  [<ffffffff8100ea8f>] ? arch_cpu_idle+0xf/0x20
> > > > >  [<ffffffff8109688e>] ? cpu_startup_entry+0xae/0x300
> > > > >  [<ffffffff8103aabc>] ? start_secondary+0x12c/0x140
> > > >
> > > > The stack traces are consistent with idle CPUs.
> > > >
> > > > > rcu_preempt kthread starved for 21002 jiffies!
> > > >
> > > > And the grace-period kthread apparently hasn't gotten a chance to run
> > > > at all during the grace period.  Strange...  It should get awakened by
> > > > a timeout every three jiffies or so.
> > > >
> > > Was it possible that the grace-period kthread was bound to a
> > > no_hz cpu and it cannot be awakened by timer interrupts?
> >
> > Timer interrupts should have no problem awakening tasks bound to no_hz
> > CPUs.  But how many non-no_hz CPUs do you have?  If there is only the
> > boot CPU, that boot CPU might be horribly overloaded, which could result
> > in stalls.
> >
> I didn't know how to check the number of non-no_hz CPUs, is there any way
> to specify the number of none-no_hz cpus when boot?

If you don't specify anything at boot and if you didn't build with
CONFIG_NO_HZ_FULL_ALL=y, then all CPUs are non-no_hz CPUs.  But either
way, they are reported during early boot.  And in your earlier dmesg,
none were reported.  But please send your .config file.

> I don't understand why only some of the cpus stalls, especially the idle
> cpus stall,
> the system shouldn't hang, especially there so many cpus should work, but
> it hang
> there and didn't continue to boot the system.

Well, bugs should never happen, should they?  But they do, and they
need to be tracked down and fixed.

Is the system responsive to sysrq?  If so, sysrq-T could help get
useful information.

> > > > INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > > 12: (0 ticks this GP) idle=1aa/0/0 softirq=0/0 fqs=1
> > > > > (detected by 0, t=84007 jiffies, g=-236, c=-237, q=159)
> > > >
> > > > The same grace period is still stalled after a total of 84 seconds,
> > > > and again CPU 17's quiescent state has been reported.
> > > >
> > > > > Task dump for CPU 12:
> > > > > swapper/12      R  running task        0     0      1 0x00200000
> > > > >  ffffffff8140f1f7 ffff880859037eb8 ffffffff810b7ff5 ffff880859037ea8
> > > > >  ffffffff810759ef ffffffff82140220 000000000000000c ffffffff82140220
> > > > >  ffff880859034000 ffff880859037ea8 ffffffff8140f1f7 ffff880859037ec8
> > > > > Call Trace:
> > > > >  [<ffffffff8140f1f7>] ? debug_smp_processor_id+0x17/0x20
> > > > >  [<ffffffff810b7ff5>] ? rcu_eqs_enter_common+0x85/0x240
> > > > >  [<ffffffff810759ef>] ? __atomic_notifier_call_chain+0x4f/0x70
> > > > >  [<ffffffff8140f1f7>] ? debug_smp_processor_id+0x17/0x20
> > > > >  [<ffffffff8100dd52>] ? mwait_idle+0x42/0x1d0
> > > > >  [<ffffffff8100ea8f>] ? arch_cpu_idle+0xf/0x20
> > > > >  [<ffffffff8109688e>] ? cpu_startup_entry+0xae/0x300
> > > > >  [<ffffffff8103aabc>] ? start_secondary+0x12c/0x140
> > > >
> > > > And again, the stack is consistent with the CPU being idle.
> > > >
> > > > > rcu_preempt kthread starved for 63005 jiffies!
> > > >
> > > > And again the grace-period kthread seems to have gotten a chance to
> > > > run during the first RCU CPU stall warning, but not since then.
> > > >
> > > > > INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > > 12: (0 ticks this GP) idle=20c/0/0 softirq=0/0 fqs=0
> > > > > 17: (61 GPs behind) idle=810/0/0 softirq=0/0 fqs=0
> > > > > (detected by 40, t=21002 jiffies, g=-235, c=-236, q=162)
> > > >
> > > > And again, it looks like the stall warning gave the grace-period
> > kthread
> > > > another chance to run, thus completing the earlier grace period.  We
> > > > now have another grace period stalled for 21 seconds, again by CPUs 12
> > > > and 17.
> > > >
> > > > > Task dump for CPU 12:
> > > > > swapper/12      R  running task        0     0      1 0x00200000
> > > > >  ffffffff8140f1f7 ffff880859037eb8 ffffffff810b7ff5 ffff880859037ea8
> > > > >  ffffffff810759ef ffffffff82140220 000000000000000c ffffffff82140220
> > > > >  ffff880859034000 ffff880859037ea8 ffffffff8140f1f7 ffff880859037ec8
> > > > > Call Trace:
> > > > >  [<ffffffff8140f1f7>] ? debug_smp_processor_id+0x17/0x20
> > > > >  [<ffffffff810b7ff5>] ? rcu_eqs_enter_common+0x85/0x240
> > > > >  [<ffffffff810759ef>] ? __atomic_notifier_call_chain+0x4f/0x70
> > > > >  [<ffffffff8140f1f7>] ? debug_smp_processor_id+0x17/0x20
> > > > >  [<ffffffff8100dd52>] ? mwait_idle+0x42/0x1d0
> > > > >  [<ffffffff8100ea8f>] ? arch_cpu_idle+0xf/0x20
> > > > >  [<ffffffff8109688e>] ? cpu_startup_entry+0xae/0x300
> > > > >  [<ffffffff8103aabc>] ? start_secondary+0x12c/0x140
> > > > > Task dump for CPU 17:
> > > > > swapper/17      R  running task        0     0      1 0x00200000
> > > > >  ffffffff8140f1f7 ffff880859063eb8 ffffffff810b7ff5 ffff880859063ea8
> > > > >  ffffffff810759ef ffffffff82140220 0000000000000011 ffffffff82140220
> > > > >  ffff880859060000 ffff880859063ea8 ffffffff8140f1f7 ffff880859063ec8
> > > > > Call Trace:
> > > > >  [<ffffffff8140f1f7>] ? debug_smp_processor_id+0x17/0x20
> > > > >  [<ffffffff810b7ff5>] ? rcu_eqs_enter_common+0x85/0x240
> > > > >  [<ffffffff810759ef>] ? __atomic_notifier_call_chain+0x4f/0x70
> > > > >  [<ffffffff8140f1f7>] ? debug_smp_processor_id+0x17/0x20
> > > > >  [<ffffffff8100dd52>] ? mwait_idle+0x42/0x1d0
> > > > >  [<ffffffff8100ea8f>] ? arch_cpu_idle+0xf/0x20
> > > > >  [<ffffffff8109688e>] ? cpu_startup_entry+0xae/0x300
> > > > >  [<ffffffff8103aabc>] ? start_secondary+0x12c/0x140
> > > > > rcu_preempt kthread starved for 21002 jiffies!
> > > >
> > > > And again idle stacks, and again the RCU grace-period kthread has not
> > > > been allowed to run at all since the grace period stared.
> > > >
> > > > > INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > > 12: (0 ticks this GP) idle=30e/0/0 softirq=0/0 fqs=1
> > > > > (detected by 5, t=84007 jiffies, g=-235, c=-236, q=170)
> > > > > Task dump for CPU 12:
> > > > > swapper/12      R  running task        0     0      1 0x00200000
> > > > >  ffffffff8140f1f7 ffff880859037eb8 ffffffff810b7ff5 ffff880859037ea8
> > > > >  ffffffff810759ef ffffffff82140220 000000000000000c ffffffff82140220
> > > > >  ffff880859034000 ffff880859037ea8 ffffffff8140f1f7 ffff880859037ec8
> > > > > Call Trace:
> > > > >  [<ffffffff8140f1f7>] ? debug_smp_processor_id+0x17/0x20
> > > > >  [<ffffffff810b7ff5>] ? rcu_eqs_enter_common+0x85/0x240
> > > > >  [<ffffffff810759ef>] ? __atomic_notifier_call_chain+0x4f/0x70
> > > > >  [<ffffffff8140f1f7>] ? debug_smp_processor_id+0x17/0x20
> > > > >  [<ffffffff8100dd52>] ? mwait_idle+0x42/0x1d0
> > > > >  [<ffffffff8100ea8f>] ? arch_cpu_idle+0xf/0x20
> > > > >  [<ffffffff8109688e>] ? cpu_startup_entry+0xae/0x300
> > > > >  [<ffffffff8103aabc>] ? start_secondary+0x12c/0x140
> > > > > rcu_preempt kthread starved for 63005 jiffies!
> > > >
> > > > And again, CPU 17's grace period has been recorded, and the
> > grace-period
> > > > kthread hasn't been allowed to run since the last RCU CPU stall
> > warning.
> > > >
> > > > When a stall warning is printed, there is also a resched_cpu() on the
> > > > holdout CPU.  Perhaps that is also giving the grace-period kthread a
> > > > chance to run?  Alternatively, perhaps the overhead of all the printing
> > > > is letting the grace-period kthread run?
> > > >
> > > > I do sometimes see similar stalls, but under heavy rcutorture load and
> > > > when running qemu/kvm.  I am considering this to be a bug (somewhere!)
> > and
> > > > am tracking it down, but I suspect that your boot-time stalls are from
> > > > something different.  Yours is the only report of this that I have seen
> > > > thus far.
> > > >
> > > > So what are you starting up at boot time?
> > >
> > > This is just a normal boot, and I didn't run special heavy load tasks.
> > > BTW, I had try to specified rcu kthread's priority to the 99 from the
> > boot
> > > command,
> > > but the stall still happened sometimes.
> >
> > What priority are the softirq kthreads running at?  RCU depends on them
> > to make forward progress as well.
> >
> since the system hang there and I didn't know how to check their priority.

Well, you said that the system only hangs sometimes.  So when it does
boot successfully, please check their priority.

							Thanx, Paul

