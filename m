From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [ltt-dev] lttctl locks up with RT Linux
Date: Wed, 12 May 2010 16:10:51 -0700
Message-ID: <20100512231051.GL2303@linux.vnet.ibm.com>
References: <A47866F933DF804684068A24BF04A9730862A74C@gdrs-exchange.gdrs.com>
 <20100422160601.GB28863@Krystal>
 <A47866F933DF804684068A24BF04A97309116C93@gdrs-exchange.gdrs.com>
 <20100511115939.GA17304@Krystal>
 <A47866F933DF804684068A24BF04A9730862A7EB@gdrs-exchange.gdrs.com>
 <20100511151120.GA5013@Krystal>
 <20100511221121.GG2336@linux.vnet.ibm.com>
 <A47866F933DF804684068A24BF04A973093432ED@gdrs-exchange.gdrs.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: compudj@krystal.dyndns.org, ltt-dev@lists.casi.polymtl.ca,
	linux-rt-users@vger.kernel.org
To: jpaul@gdrs.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:33998 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414Ab0ELXKy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 May 2010 19:10:54 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4CN5RCl003671
	for <linux-rt-users@vger.kernel.org>; Wed, 12 May 2010 19:05:27 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o4CNArV9156352
	for <linux-rt-users@vger.kernel.org>; Wed, 12 May 2010 19:10:53 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id o4CNAqX5015742
	for <linux-rt-users@vger.kernel.org>; Wed, 12 May 2010 19:10:52 -0400
Content-Disposition: inline
In-Reply-To: <A47866F933DF804684068A24BF04A973093432ED@gdrs-exchange.gdrs.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello, John,

Strange.  I wonder where the other four call stacks are coming from.

							Thanx, Paul

On Wed, May 12, 2010 at 08:26:01AM -0400, jpaul@gdrs.com wrote:
> Hi Paul:
> 
> I'm running on a single Intel Core 2 Duo.
> 
> JP
> 
> -----Original Message-----
> From: Paul E. McKenney [mailto:paulmck@linux.vnet.ibm.com] 
> Sent: Tuesday, May 11, 2010 6:11 PM
> To: Mathieu Desnoyers
> Cc: John P. Paul; ltt-dev@lists.casi.polymtl.ca;
> linux-rt-users@vger.kernel.org
> Subject: Re: [ltt-dev] lttctl locks up with RT Linux
> 
> On Tue, May 11, 2010 at 11:11:20AM -0400, Mathieu Desnoyers wrote:
> > * jpaul@gdrs.com (jpaul@gdrs.com) wrote:
> > > Thanks Mathieu. I'm going to have to look at this a bit more. This
> may
> > > have fixed one problem and cause another as "lttctl -C -w /tmp/trace
> > > trace1" does not return and I'm getting a stack dump in the messages
> > > file (see below). The last msg I see from that "lttctl -C" command
> is
> > > "lttctl: Creating trace". The "lttctl: Forking lttd" is not
> displayed.
> > 
> > If you disable RCU stalls detection, does it work ?
> > 
> > [Context for Paul: it's on a -RT kernel, with the LTTng patchset]
> 
> Strange.  It looks like everyone is idle.
> 
> Or is it possible that some CPU is spinning in an NMI handler?
> 
> You have six call traces -- are there six CPUs online?
> 
> 							Thanx, Paul
> 
> > Thanks,
> > 
> > Mathieu
> > 
> > > 
> > > JP
> > > 
> > > May 11 10:05:00 ans-ebb3 kernel:  P5
> > > May 11 10:05:00 ans-ebb3 kernel: INFO: RCU detected CPU stalls: P5
> (detected by 0, t=10002 jiffies)
> > > May 11 10:05:00 ans-ebb3 kernel: sending NMI to all CPUs:
> > > May 11 10:05:00 ans-ebb3 kernel: NMI backtrace for cpu 1
> > > May 11 10:05:00 ans-ebb3 kernel: Modules linked in: battery sbshc
> ehci_hcd sbs scsi_dh ohci_hcd dm_multipath uhci_hcd scsi_mod dm_mirror
> sd_mod libata ahci dm_mod dm_log dm_region_hash tpm_bios tpm intel_agp
> iTCO_vendor_support i2c_core pcspkr tpm_tis iTCO_wdt i2c_i801 autofs4
> e1000e button serio_raw sg output video ac parport lp parport_pc ipv6
> nvidia(P) [last unloaded: nvidia]
> > > May 11 10:05:00 ans-ebb3 kernel: 
> > > May 11 10:05:00 ans-ebb3 kernel: Pid: 0, comm: swapper Tainted: P
> 2.6.33.2-rt13.11.trace #10 PXT    /To Be Filled By O.E.M.
> > > May 11 10:05:00 ans-ebb3 kernel: EIP: 0060:[<c062e4fa>] EFLAGS:
> 00000246 CPU: 1
> > > May 11 10:05:00 ans-ebb3 kernel: EIP is at poll_idle+0x1e/0x5c
> > > May 11 10:05:00 ans-ebb3 kernel: EAX: f74bc000 EBX: 6b655cfc ECX:
> 6b655cfc EDX: 000001a2
> > > May 11 10:05:00 ans-ebb3 kernel: ESI: 000001a2 EDI: 00000000 EBP:
> f74bcf84 ESP: f74bcf7c
> > > May 11 10:05:00 ans-ebb3 kernel:  DS: 007b ES: 007b FS: 00d8 GS:
> 0000 SS: 0068 preempt:04010002
> > > May 11 10:05:00 ans-ebb3 kernel: Process swapper (pid: 0,
> ti=f74bc000 task=f74d90c0 task.ti=f74bc000)
> > > May 11 10:05:00 ans-ebb3 kernel: Stack:
> > > May 11 10:05:00 ans-ebb3 kernel:  f765b02c f765b01c f74bcf94
> c062e7c9 00000001 c0877c90 f74bcfa4 c0401c0d
> > > May 11 10:05:00 ans-ebb3 kernel: <0> 00000001 00000000 f74bcfb0
> c06ca177 01020800 00000000 00000000 00000000
> > > May 11 10:05:00 ans-ebb3 kernel: <0> 00000000 00000000 00000000
> 00000000 00000000 00000000 00000000 000000d8
> > > May 11 10:05:00 ans-ebb3 kernel: Call Trace:
> > > May 11 10:05:00 ans-ebb3 kernel:  [<c062e7c9>] ?
> cpuidle_idle_call+0x6c/0xdf
> > > May 11 10:05:00 ans-ebb3 kernel:  [<c0401c0d>] ? cpu_idle+0x49/0x80
> > > May 11 10:05:00 ans-ebb3 kernel:  [<c06ca177>] ?
> start_secondary+0x1b9/0x1be
> > > May 11 10:05:00 ans-ebb3 kernel: Code: ff ff ff 8d 65 f4 89 d8 5b 5e
> 5f 5d c3 55 89 e5 56 53 e8 7b 61 e2 ff 89 c3 89 d6 fb 89 e0 25 00 f0 ff
> ff eb 02 f3 90 f6 40 08 08 <74> f8 e8 60 61 e2 ff 29 d8 19 f2 e8 95 b6
> e0 ff b9 40 42 0f 00 
> > > May 11 10:05:00 ans-ebb3 kernel: Call Trace:
> > > May 11 10:05:00 ans-ebb3 kernel:  [<c062e7c9>]
> cpuidle_idle_call+0x6c/0xdf
> > > May 11 10:05:00 ans-ebb3 kernel:  [<c0401c0d>] cpu_idle+0x49/0x80
> > > May 11 10:05:00 ans-ebb3 kernel:  [<c06ca177>]
> start_secondary+0x1b9/0x1be
> > > May 11 10:05:00 ans-ebb3 kernel: Pid: 0, comm: swapper Tainted: P
> 2.6.33.2-rt13.11.trace #10
> > > May 11 10:05:00 ans-ebb3 kernel: Call Trace:
> > > May 11 10:05:00 ans-ebb3 kernel:  [<c04019d4>] ? show_regs+0x1a/0x20
> > > May 11 10:05:00 ans-ebb3 kernel:  [<c06d0d7a>]
> nmi_watchdog_tick+0x9b/0x162
> > > May 11 10:05:00 ans-ebb3 kernel:  [<c06d02e1>] do_nmi+0xd1/0x2e1
> > > May 11 10:05:00 ans-ebb3 kernel:  [<c056355d>] ?
> ltt_chan_for_each_channel+0x35/0x4f
> > > May 11 10:05:00 ans-ebb3 kernel:  [<c05628df>] ?
> ltt_chanbuf_idle_switch+0x0/0x1c
> > > May 11 10:05:00 ans-ebb3 kernel:  [<c06cfd41>]
> nmi_stack_correct+0x28/0x2d
> > > May 11 10:05:00 ans-ebb3 kernel:  [<c062e4fa>] ? poll_idle+0x1e/0x5c
> > > May 11 10:05:00 ans-ebb3 kernel:  [<c062e7c9>]
> cpuidle_idle_call+0x6c/0xdf
> > > May 11 10:05:00 ans-ebb3 kernel:  [<c0401c0d>] cpu_idle+0x49/0x80
> > > May 11 10:05:00 ans-ebb3 kernel:  [<c06ca177>]
> start_secondary+0x1b9/0x1be
> > > May 11 10:05:00 ans-ebb3 kernel: NMI backtrace for cpu 0
> > > May 11 10:05:00 ans-ebb3 kernel: Modules linked in: battery sbshc
> ehci_hcd sbs scsi_dh ohci_hcd dm_multipath uhci_hcd scsi_mod dm_mirror
> sd_mod libata ahci dm_mod dm_log dm_region_hash tpm_bios tpm intel_agp
> iTCO_vendor_support i2c_core pcspkr tpm_tis iTCO_wdt i2c_i801 autofs4
> e1000e button serio_raw sg output video ac parport lp parport_pc ipv6
> nvidia(P) [last unloaded: nvidia]
> > > May 11 10:05:00 ans-ebb3 kernel: 
> > > May 11 10:05:00 ans-ebb3 kernel: Pid: 0, comm: swapper Tainted: P
> 2.6.33.2-rt13.11.trace #10 PXT    /To Be Filled By O.E.M.
> > > May 11 10:05:00 ans-ebb3 kernel: EIP: 0060:[<c0570ab6>] EFLAGS:
> 00000807 CPU: 0
> > > May 11 10:05:00 ans-ebb3 kernel: EIP is at delay_tsc+0x0/0x8a
> > > May 11 10:05:00 ans-ebb3 kernel: EAX: 001c7b29 EBX: 00000001 ECX:
> 04f29000 EDX: 001c7b28
> > > May 11 10:05:00 ans-ebb3 kernel: ESI: 00000000 EDI: c084a6c0 EBP:
> c0828e6c ESP: c0828e68
> > > May 11 10:05:00 ans-ebb3 kernel:  DS: 007b ES: 007b FS: 00d8 GS:
> 0000 SS: 0068 preempt:04020002
> > > May 11 10:05:00 ans-ebb3 kernel: Process swapper (pid: 0,
> ti=c0828000 task=c08407a0 task.ti=c0828000)
> > > May 11 10:05:00 ans-ebb3 kernel: Stack:
> > > May 11 10:05:00 ans-ebb3 kernel:  c0570a4f c0828e78 c0418e84
> c084a740 c0828eb0 c047c35b c07c1944 00000000
> > > May 11 10:05:00 ans-ebb3 kernel: <0> 00002712 c5805268 c084a6c0
> c084a6ec 00000003 c084a740 00000083 00000000
> > > May 11 10:05:00 ans-ebb3 kernel: <0> 00000000 c08407a0 c0828ec0
> c047c45f 00000000 00000000 c0828ed4 c0441fbd
> > > May 11 10:05:00 ans-ebb3 kernel: Call Trace:
> > > May 11 10:05:00 ans-ebb3 kernel:  [<c0570a4f>] ?
> __const_udelay+0x2f/0x31
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c0418e84>] ?
> arch_trigger_all_cpu_backtrace+0x42/0x4f
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c047c35b>] ?
> __rcu_pending+0x258/0x309
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c047c45f>] ?
> rcu_check_callbacks+0x53/0x114
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c0441fbd>] ?
> update_process_times+0x32/0x43
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c04587b7>] ?
> tick_sched_timer+0x6d/0x9b
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c045874a>] ?
> tick_sched_timer+0x0/0x9b
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c044f8fc>] ?
> __run_hrtimer+0xeb/0x154
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c044fc4d>] ?
> hrtimer_interrupt+0xed/0x21e
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c04518c5>] ?
> sched_clock_idle_wakeup_event+0x16/0x18
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c0418512>] ?
> smp_apic_timer_interrupt+0xb4/0x106
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c06cfa66>] ?
> apic_timer_interrupt+0x2a/0x30
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c062e4f6>] ? poll_idle+0x1a/0x5c
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c062e7c9>] ?
> cpuidle_idle_call+0x6c/0xdf
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c0401c0d>] ? cpu_idle+0x49/0x80
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c06bdde4>] ? rest_init+0x80/0x82
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c087a859>] ?
> start_kernel+0x2fb/0x300
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c087a08c>] ?
> i386_start_kernel+0x8c/0x91
> > > May 11 10:05:01 ans-ebb3 kernel: Code: c0 8b 0c 8d 18 7b 87 c0 6b c0
> 14 ba 40 ff 8d c0 55 89 e5 69 94 0a 98 00 00 00 fa 00 00 00 f7 e2 8d 42
> 01 ff 15 90 84 85 c0 5d c3 <55> 89 e5 57 56 89 c6 53 83 ec 04 89 e0 25
> 00 f0 ff ff ff 40 14 
> > > May 11 10:05:01 ans-ebb3 kernel: Call Trace:
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c0570a4f>] ?
> __const_udelay+0x2f/0x31
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c0418e84>]
> arch_trigger_all_cpu_backtrace+0x42/0x4f
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c047c35b>]
> __rcu_pending+0x258/0x309
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c047c45f>]
> rcu_check_callbacks+0x53/0x114
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c0441fbd>]
> update_process_times+0x32/0x43
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c04587b7>]
> tick_sched_timer+0x6d/0x9b
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c045874a>] ?
> tick_sched_timer+0x0/0x9b
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c044f8fc>]
> __run_hrtimer+0xeb/0x154
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c044fc4d>]
> hrtimer_interrupt+0xed/0x21e
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c04518c5>] ?
> sched_clock_idle_wakeup_event+0x16/0x18
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c0418512>]
> smp_apic_timer_interrupt+0xb4/0x106
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c06cfa66>]
> apic_timer_interrupt+0x2a/0x30
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c062e4f6>] ? poll_idle+0x1a/0x5c
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c062e7c9>]
> cpuidle_idle_call+0x6c/0xdf
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c0401c0d>] cpu_idle+0x49/0x80
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c06bdde4>] rest_init+0x80/0x82
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c087a859>]
> start_kernel+0x2fb/0x300
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c087a08c>]
> i386_start_kernel+0x8c/0x91
> > > May 11 10:05:01 ans-ebb3 kernel: Pid: 0, comm: swapper Tainted: P
> 2.6.33.2-rt13.11.trace #10
> > > May 11 10:05:01 ans-ebb3 kernel: Call Trace:
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c04019d4>] ? show_regs+0x1a/0x20
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c06d0d7a>]
> nmi_watchdog_tick+0x9b/0x162
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c06d02e1>] do_nmi+0xd1/0x2e1
> > > May 11 10:05:01 ans-ebb3 kernel:  [<c05645a8>] ?
> ltt_vtrace+0x0/0x79b
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c06cfd41>]
> nmi_stack_correct+0x28/0x2d
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c0570ab6>] ? delay_tsc+0x0/0x8a
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c0570a4f>] ?
> __const_udelay+0x2f/0x31
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c0418e84>]
> arch_trigger_all_cpu_backtrace+0x42/0x4f
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c047c35b>]
> __rcu_pending+0x258/0x309
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c047c45f>]
> rcu_check_callbacks+0x53/0x114
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c0441fbd>]
> update_process_times+0x32/0x43
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c04587b7>]
> tick_sched_timer+0x6d/0x9b
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c045874a>] ?
> tick_sched_timer+0x0/0x9b
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c044f8fc>]
> __run_hrtimer+0xeb/0x154
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c044fc4d>]
> hrtimer_interrupt+0xed/0x21e
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c04518c5>] ?
> sched_clock_idle_wakeup_event+0x16/0x18
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c0418512>]
> smp_apic_timer_interrupt+0xb4/0x106
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c06cfa66>]
> apic_timer_interrupt+0x2a/0x30
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c062e4f6>] ? poll_idle+0x1a/0x5c
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c062e7c9>]
> cpuidle_idle_call+0x6c/0xdf
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c0401c0d>] cpu_idle+0x49/0x80
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c06bdde4>] rest_init+0x80/0x82
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c087a859>]
> start_kernel+0x2fb/0x300
> > > May 11 10:05:02 ans-ebb3 kernel:  [<c087a08c>]
> i386_start_kernel+0x8c/0x91
> > > 
> > > 
> > > 
> > > -----Original Message-----
> > > From: Mathieu Desnoyers [mailto:compudj@krystal.dyndns.org]
> > > Sent: Tue 5/11/2010 7:59 AM
> > > To: John P. Paul
> > > Cc: ltt-dev@lists.casi.polymtl.ca
> > > Subject: Re: [ltt-dev] lttctl locks up with RT Linux
> > >  
> > > * jpaul@gdrs.com (jpaul@gdrs.com) wrote:
> > > > Hey Mathieu:
> > > > 
> > > > Thanks for looking at this. I'm a bit new to debugging at this
> level, so
> > > > you may need to provide me a bit more info on what you need. I
> attempted
> > > > to use "pstack" on the lttctl and lttd tasks ... no luck as pstack
> also
> > > > locked up.
> > > > 
> > > > I put a bit of tracing into liblttctl and discovered the lockup
> occurs
> > > > when a write of "traceName" (whatever traceName happens to be)
> occurs to
> > > > the "/mnt/debugfs/ltt/destroy_trace" file.
> > > > 
> > > > I'm guessing that you would like some tracing of the ltt kernel
> module.
> > > > Is there something that I can turn on, or another way I could get
> a
> > > > stack dump of that module after lockup?  I'll do a little research
> this
> > > > weekend on kernel debugging techniques.
> > > > 
> > > > I can certainly sprinkle in some printk statements in the ltt
> kernel
> > > > module source. Doing provided the following info:
> > > > 
> > > > - Control entered _ltt_trace_destroy (single underscore)
> > > > - Control entered del_timer_sync(&ltt_async_wakeup_timer) and
> never
> > > > returned
> > > > 
> > > > Does that help, or should I continue farther down this path?
> > > 
> > > Can you try the following patch to see if it fixes your problem ?
> > > 
> > > 
> > > lttng fix rt kernel teardown deadlock
> > > 
> > > LTTng has a teardown bug on RT (deadlock):
> > > 
> > > Deleting a timer (sync) while holding the traces mutex, and the
> handler takes
> > > the same mutex, which leads to a deadlock.
> > > 
> > > Fix this by taking a RCU read lock in the timer (instead of the
> RT-specific fix
> > > using the mutex), and by doing synchronize_rcu() in addition to
> > > synchronize_sched() upon updates.
> > > 
> > > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > ---
> > >  ltt/ltt-tracer.c |   28 ++++++++++++++++++----------
> > >  1 file changed, 18 insertions(+), 10 deletions(-)
> > > 
> > > Index: linux-2.6-lttng/ltt/ltt-tracer.c
> > > ===================================================================
> > > --- linux-2.6-lttng.orig/ltt/ltt-tracer.c	2010-05-11
> 07:50:46.000000000 -0400
> > > +++ linux-2.6-lttng/ltt/ltt-tracer.c	2010-05-11
> 07:55:46.000000000 -0400
> > > @@ -41,6 +41,14 @@
> > >  #include <linux/vmalloc.h>
> > >  #include <asm/atomic.h>
> > >  
> > > +static void synchronize_trace(void)
> > > +{
> > > +	synchronize_sched();
> > > +#ifdef CONFIG_PREEMPT_RT
> > > +	synchronize_rcu();
> > > +#endif
> > > +}
> > > +
> > >  static void async_wakeup(unsigned long data);
> > >  
> > >  static DEFINE_TIMER(ltt_async_wakeup_timer, async_wakeup, 0, 0);
> > > @@ -321,7 +329,7 @@ void ltt_module_unregister(enum ltt_modu
> > >  		ltt_filter_unregister();
> > >  		ltt_run_filter_owner = NULL;
> > >  		/* Wait for preempt sections to finish */
> > > -		synchronize_sched();
> > > +		synchronize_trace();
> > >  		break;
> > >  	case LTT_FUNCTION_FILTER_CONTROL:
> > >  		ltt_filter_control_functor = ltt_filter_control_default;
> > > @@ -429,13 +437,13 @@ static void async_wakeup(unsigned long d
> > >  	 * PREEMPT_RT does not allow spinlocks to be taken within
> preempt
> > >  	 * disable sections (spinlock taken in wake_up). However,
> mainline won't
> > >  	 * allow mutex to be taken in interrupt context. Ugly.
> > > -	 * A proper way to do this would be to turn the timer into a
> > > -	 * periodically woken up thread, but it adds to the footprint.
> > > +	 * Take a standard RCU read lock for RT kernels, which imply
> that we
> > > +	 * also have to synchronize_rcu() upon updates.
> > >  	 */
> > >  #ifndef CONFIG_PREEMPT_RT
> > >  	rcu_read_lock_sched();
> > >  #else
> > > -	ltt_lock_traces();
> > > +	rcu_read_lock();
> > >  #endif
> > >  	list_for_each_entry_rcu(trace, &ltt_traces.head, list) {
> > >  		trace_async_wakeup(trace);
> > > @@ -443,7 +451,7 @@ static void async_wakeup(unsigned long d
> > >  #ifndef CONFIG_PREEMPT_RT
> > >  	rcu_read_unlock_sched();
> > >  #else
> > > -	ltt_unlock_traces();
> > > +	rcu_read_unlock();
> > >  #endif
> > >  
> > >  	mod_timer(&ltt_async_wakeup_timer, jiffies +
> LTT_PERCPU_TIMER_INTERVAL);
> > > @@ -901,7 +909,7 @@ int ltt_trace_alloc(const char *trace_na
> > >  		set_kernel_trace_flag_all_tasks();
> > >  	}
> > >  	list_add_rcu(&trace->list, &ltt_traces.head);
> > > -	synchronize_sched();
> > > +	synchronize_trace();
> > >  
> > >  	ltt_unlock_traces();
> > >  
> > > @@ -974,7 +982,7 @@ static int _ltt_trace_destroy(struct ltt
> > >  	}
> > >  	/* Everything went fine */
> > >  	list_del_rcu(&trace->list);
> > > -	synchronize_sched();
> > > +	synchronize_trace();
> > >  	if (list_empty(&ltt_traces.head)) {
> > >  		clear_kernel_trace_flag_all_tasks();
> > >  		/*
> > > @@ -1195,7 +1203,7 @@ static int _ltt_trace_stop(struct ltt_tr
> > >  			trace->nr_channels);
> > >  		trace->active = 0;
> > >  		ltt_traces.num_active_traces--;
> > > -		synchronize_sched(); /* Wait for each tracing to be
> finished */
> > > +		synchronize_trace(); /* Wait for each tracing to be
> finished */
> > >  	}
> > >  	module_put(ltt_run_filter_owner);
> > >  	/* Everything went fine */
> > > @@ -1327,12 +1335,12 @@ static void __exit ltt_exit(void)
> > >  	list_for_each_entry_rcu(trace, &ltt_traces.head, list)
> > >  		_ltt_trace_stop(trace);
> > >  	/* Wait for quiescent state. Readers have preemption disabled.
> */
> > > -	synchronize_sched();
> > > +	synchronize_trace();
> > >  	/* Safe iteration is now permitted. It does not have to be
> RCU-safe
> > >  	 * because no readers are left. */
> > >  	list_for_each_safe(pos, n, &ltt_traces.head) {
> > >  		trace = container_of(pos, struct ltt_trace, list);
> > > -		/* _ltt_trace_destroy does a synchronize_sched() */
> > > +		/* _ltt_trace_destroy does a synchronize_trace() */
> > >  		_ltt_trace_destroy(trace);
> > >  		__ltt_trace_destroy(trace);
> > >  	}
> > > 
> > > 
> > > 
> > > --
> > > This is an e-mail from General Dynamics Robotic Systems. It is for
> the intended recipient only and may contain confidential and privileged
> information. No one else may read, print, store, copy, forward or act in
> reliance on it or its attachments. If you are not the intended
> recipient, please return this message to the sender and delete the
> message and any attachments from your computer. Your cooperation is
> appreciated.
> > > 
> > 
> > -- 
> > Mathieu Desnoyers
> > Operating System Efficiency R&D Consultant
> > EfficiOS Inc.
> > http://www.efficios.com
> 
> --
> This is an e-mail from General Dynamics Robotic Systems. It is for the intended recipient only and may contain confidential and privileged information. No one else may read, print, store, copy, forward or act in reliance on it or its attachments. If you are not the intended recipient, please return this message to the sender and delete the message and any attachments from your computer. Your cooperation is appreciated.
> 
