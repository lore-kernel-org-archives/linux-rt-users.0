From: Aaron Ma <mapengyu@gmail.com>
Subject: Re: RCU stall and the system boot hang with nfsroot
Date: Wed, 30 Dec 2015 15:03:33 +0800
Message-ID: <CALSz7m3C4vj3Rp2uZvYc--_Zo5z+=8joGfPSbw1wY+Z1HzM_7g@mail.gmail.com>
References: <CALSz7m2KNryL1uo3u1jody3+VYcTga8ZwsHth95Ne1DKy7HzgA@mail.gmail.com>
	<CALSz7m00vj1yVETgwEAei+qXi+i+5=srNdY8oqZOcjAnv8Z4DQ@mail.gmail.com>
	<20151229234229.GJ4054@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151229234229.GJ4054@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Dec 30, 2015 at 7:42 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Tue, Dec 29, 2015 at 05:34:38PM +0800, Aaron Ma wrote:
>> Add paulmck@linux.vnet.ibm.com
>>
>> On Tue, Dec 29, 2015 at 5:32 PM, Aaron Ma <mapengyu@gmail.com> wrote:
>> > Hi, Paul:
>> > I found the linux-stable-4.1.15 with rt15 patches boot hang sometimes.
>> > Hardware is Grantley-EP and WildcatPass.
>
> I must confess that I am unfamiliar with this hardware, for whatever
> that might be worth.
>
>> > No response by sysrq.
>> >
>> > Did you found any issue about this? Or how can I address this issue?
>
> I see something similar in post-4.1 mainline, but only when CPU hotplug
> is enabled and only under extreme stress.  Which is probably not the
> case during your boot-up.  But please see below.
>
>> > Attached kernel config.
>> >
>> > Thanks,
>> > Pengyu
>> >
>> > xhci_hcd 0000:00:14.0: cache line size of 32 is not supported
>> > hub 1-0:1.0: USB hub found
>> > hub 1-0:1.0: 15 ports detected
>> > xhci_hcd 0000:00:14.0: xHCI Host Controller
>> > xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
>> > hub 2-0:1.0: USB hub found
>> > hub 2-0:1.0: 6 ports detected
>> > initcall xhci_pci_init+0x0/0x44 returned 0 after 306571 usecs
>> > calling  ehci_hcd_init+0x0/0x5d @ 1
>> > ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>> > initcall ehci_hcd_init+0x0/0x5d returned 0 after 5695 usecs
>> > calling  ehci_pci_init+0x0/0x69 @ 1
>> > ehci-pci: EHCI PCI platform driver
>> > ehci-pci 0000:00:1a.0: enabling bus mastering
>> > ehci-pci 0000:00:1a.0: EHCI Host Controller
>> > ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 3
>> > ehci-pci 0000:00:1a.0: debug port 2
>> > ehci-pci 0000:00:1a.0: cache line size of 32 is not supported
>> > ehci-pci 0000:00:1a.0: irq 18, io mem 0x91d02000
>> > cfg80211: Calling CRDA to update world regulatory domain
>> > cfg80211: Calling CRDA to update world regulatory domain
>> > cfg80211: Calling CRDA to update world regulatory domain
>> > cfg80211: Calling CRDA to update world regulatory domain
>> > cfg80211: Calling CRDA to update world regulatory domain
>> > cfg80211: Calling CRDA to update world regulatory domain
>> > cfg80211: Exceeded CRDA call max attempts. Not calling CRDA
>> > INFO: rcu_preempt detected stalls on CPUs/tasks:
>> >     18: (0 ticks this GP) idle=284/0/0 softirq=0/0 fqs=0
>
> The "stalling" CPU is idle, which is a quiescent state and therefore
> should not stall grace periods.  But please see below...
>
>> >     (detected by 12, t=26002 jiffies, g=5351, c=5350, q=451332)
>> > Task dump for CPU 18:
>> > swapper/18      R  running task        0     0      1 0x00200000
>> >  ffffffff814946a7 ffff88045fbc7e58 ffffffff814f42f7 0000000000000004
>> >  0000000000000004 ffff8804663e0f60 ffffffff820dc5c0 ffff88045fbc7ea8
>> >  ffffffff8181fca5 0000000000000000 0000000000000000 0000000000000046
>> > Call Trace:
>> >  [<ffffffff814946a7>] ? debug_smp_processor_id+0x17/0x20
>> >  [<ffffffff814f42f7>] ? intel_idle+0x137/0x140
>> >  [<ffffffff8181fca5>] ? cpuidle_enter_state+0x65/0x3e0
>> >  [<ffffffff81820057>] ? cpuidle_enter+0x17/0x20
>> >  [<ffffffff810a856d>] ? cpu_startup_entry+0x33d/0x630
>> >  [<ffffffff8103cf6e>] ? start_secondary+0x12e/0x140
>> > rcu_preempt kthread starved for 26002 jiffies!
>
> The reason that the idle CPU is not being recognized as a legitimate
> quiescent state is that the rcu_preempt grace-period kthread is not
> being allowed to run.  In fact, it has not been permitted to run for more
> than 26 seconds.  Despite the fact that in this situation, it would have
> invoked wait_event_interruptible_timeout() with a three-jiffy timeout.
>
> One thing to do is to modify the rcu_check_gp_kthread_starvation()
> function to print the value of rsp->gp_kthread, then to also print
> fields from the resulting pointer to task_struct to see what the thread
> is up to.  (It is tempting to suspect that this kthread might never have
> been spawned, but in that case the grace period would not have started.)
>
> For example, add the following in the "if (j - gpa > 2 * HZ)"
> body:
>
>         if (rsp->gp_kthread)
>                 sched_show_task(rsp->gp_kthread);
>
> Don't forget to add the "{" "}" to accommodate the additional statement
> within the "if" statement.
>
> If the additional output shows that the rcu_preempt kthread is runnable,
> the next question is "why is it not running?".  If the output instead
> shows that the task is blocked, the next question is "why didn't the
> wait_event_interruptible_timeout() awaken it?
>
>                                                         Thanx, Paul

Add sched_show_task to show the current task on stalled CPU:

calling  efi_load_efivars+0x0/0x40 @ 1
initcall efi_load_efivars+0x0/0x40 returned 0 after 0 usecs
calling  esrt_sysfs_init+0x0/0x2d6 @ 1
initcall esrt_sysfs_init+0x0/0x2d6 returned -38 after 1 usecs
calling  hid_init+0x0/0x4c @ 1
initcall hid_init+0x0/0x4c returned 0 after 373 usecs
calling  hid_generic_init+0x0/0x1b @ 1
initcall hid_generic_init+0x0/0x1b returned 0 after 108 usecs
calling  sensor_hub_driver_init+0x0/0x1b @ 1
initcall sensor_hub_driver_init+0x0/0x1b returned 0 after 101 usecs
calling  hid_init+0x0/0x54 @ 1
input: American Megatrends Inc. Virtual Keyboard and Mouse as
/devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9:1.0/0003:046B:FF10.0001/input/input2
cfg80211: Calling CRDA to update world regulatory domain
cfg80211: Calling CRDA to update world regulatory domain
cfg80211: Calling CRDA to update world regulatory domain
cfg80211: Calling CRDA to update world regulatory domain
cfg80211: Calling CRDA to update world regulatory domain
cfg80211: Calling CRDA to update world regulatory domain
cfg80211: Exceeded CRDA call max attempts. Not calling CRDA
INFO: rcu_preempt detected stalls on CPUs/tasks:
    71: (0 ticks this GP) idle=1ac/0/0 softirq=0/0 fqs=0
    (detected by 62, t=26002 jiffies, g=3735, c=3734, q=366014)
Task dump for CPU 71:
swapper/71      R  running task        0     0      1 0x00200000
 ffffffff81492587 ffff8804633cbe58 ffffffff814f21d7 0000000000000004
 0000000000000004 ffffe8fffb405310 ffffffff820dc5c0 ffff8804633cbea8
 ffffffff8181db85 0000000000000000 0000000000000000 0000000000000046
Call Trace:
 [<ffffffff81492587>] ? debug_smp_processor_id+0x17/0x20
 [<ffffffff814f21d7>] ? intel_idle+0x137/0x140
 [<ffffffff8181db85>] ? cpuidle_enter_state+0x65/0x3e0
 [<ffffffff8181df37>] ? cpuidle_enter+0x17/0x20
 [<ffffffff810a849d>] ? cpu_startup_entry+0x33d/0x630
 [<ffffffff8103ceae>] ? start_secondary+0x12e/0x140
rcu_preempt kthread starved for 26002 jiffies!
rcu_check_gp_kthread_starvation --->show task:
rcu_preempt     S ffff880456413c68     0     8      2 0x00000000
 ffff880456413c68 ffff8804564025d0 000000000000d7a0 ffff880456b18000
 ffff8804564025d0 ffff880456413c38 ffffffff81492587 ffff880456413c58
 ffff880456414000 ffff8804564025d0 ffff880456413cb8 ffff880869dce500
Call Trace:
 [<ffffffff81492587>] ? debug_smp_processor_id+0x17/0x20
 [<ffffffff81b5ce9f>] schedule+0x3f/0xd0
 [<ffffffff81b5ef19>] schedule_timeout+0x189/0x3f0
 [<ffffffff810a7904>] ? swait_prepare+0x24/0x90
 [<ffffffff810e8e60>] ? timer_cpu_notify+0x190/0x190
 [<ffffffff810a793b>] ? swait_prepare+0x5b/0x90
 [<ffffffff810de3f8>] rcu_gp_kthread+0x8a8/0x2190
 [<ffffffff810b275d>] ? trace_hardirqs_on+0xd/0x10
 [<ffffffff81b5c18f>] ? __schedule+0x4af/0x1180
 [<ffffffff810ddb50>] ? call_rcu_sched+0x20/0x20
 [<ffffffff8107f844>] kthread+0xe4/0x100
 [<ffffffff810b275d>] ? trace_hardirqs_on+0xd/0x10
 [<ffffffff8107f760>] ? kthread_create_on_node+0x240/0x240
 [<ffffffff81b61562>] ret_from_fork+0x42/0x70
 [<ffffffff8107f760>] ? kthread_create_on_node+0x240/0x240
rcu_check_gp_kthread_starvation --->end

It seems wait in rcu_gp_kthread. it should be no task blocked right?
If so, why the swait_event_interruptible_timeout is not awaken? the
timeout is CONFIG_HZ=1000.

Thanks for your answer during holiday.
Pengyu

>
>> > INFO: rcu_preempt detected stalls on CPUs/tasks:
>> >     18: (0 ticks this GP) idle=326/0/0 softirq=0/0 fqs=1
>> >     (detected by 67, t=104007 jiffies, g=5351, c=5350, q=451332)
>> > Task dump for CPU 18:
>> > swapper/18      R  running task        0     0      1 0x00200000
>> >  ffffffff814946a7 ffff88045fbc7e58 ffffffff814f42f7 0000000000000004
>> >  0000000000000004 ffff8804663e0f60 ffffffff820dc5c0 ffff88045fbc7ea8
>> >  ffffffff8181fca5 0000000000000000 0000000000000000 0000000000000046
>> > Call Trace:
>> >  [<ffffffff814946a7>] ? debug_smp_processor_id+0x17/0x20
>> >  [<ffffffff814f42f7>] ? intel_idle+0x137/0x140
>> >  [<ffffffff8181fca5>] ? cpuidle_enter_state+0x65/0x3e0
>> >  [<ffffffff81820057>] ? cpuidle_enter+0x17/0x20
>> >  [<ffffffff810a856d>] ? cpu_startup_entry+0x33d/0x630
>> >  [<ffffffff8103cf6e>] ? start_secondary+0x12e/0x140
>> > rcu_preempt kthread starved for 78005 jiffies!
>> > INFO: rcu_preempt detected stalls on CPUs/tasks:
>> >     18: (0 ticks this GP) idle=35c/0/0 softirq=0/0 fqs=0
>> >     (detected by 62, t=26002 jiffies, g=5352, c=5351, q=451332)
>> > Task dump for CPU 18:
>> > swapper/18      R  running task        0     0      1 0x00200000
>> >  ffffffff814946a7 ffff88045fbc7e58 ffffffff814f42f7 0000000000000004
>> >  0000000000000004 ffff8804663e0f60 ffffffff820dc5c0 ffff88045fbc7ea8
>> >  ffffffff8181fca5 0000000000000000 0000000000000000 0000000000000046
>> > Call Trace:
>> >  [<ffffffff814946a7>] ? debug_smp_processor_id+0x17/0x20
>> >  [<ffffffff814f42f7>] ? intel_idle+0x137/0x140
>> >  [<ffffffff8181fca5>] ? cpuidle_enter_state+0x65/0x3e0
>> >  [<ffffffff81820057>] ? cpuidle_enter+0x17/0x20
>> >  [<ffffffff810a856d>] ? cpu_startup_entry+0x33d/0x630
>> >  [<ffffffff8103cf6e>] ? start_secondary+0x12e/0x140
>> > rcu_preempt kthread starved for 26002 jiffies!
>> > perf interrupt took too long (2575 > 2500), lowering
>> > kernel.perf_event_max_sample_rate to 50000
>> > INFO: task swapper/0:1 blocked for more than 120 seconds.
>> >       Not tainted 4.1.15-rt13-WR8.0.0.0_preempt-rt+ #25
>> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> > swapper/0       D ffff880453547a18     0     1      0 0x00000000
>> >  ffff880453547a18 ffff880851aa8000 000000000000d7a0 ffff88045f604ba0
>> >  ffff880851aa8000 ffff8804535479e8 ffffffff814946a7 ffff880453547a08
>> >  ffff880453548000 ffff880851aa8000 ffff880453547a68 ffff8804663ce500
>> > Call Trace:
>> >  [<ffffffff814946a7>] ? debug_smp_processor_id+0x17/0x20
>> >  [<ffffffff81b60bff>] schedule+0x3f/0xd0
>> >  [<ffffffff81b62c89>] schedule_timeout+0x189/0x3f0
>> >  [<ffffffff810e8f10>] ? timer_cpu_notify+0x190/0x190
>> >  [<ffffffff810eaac2>] msleep+0x42/0x50
>> >  [<ffffffff81759bd6>] ehci_run+0xf6/0x1d0
>> >  [<ffffffff8174329d>] usb_add_hcd+0x2dd/0x810
>> >  [<ffffffff817551de>] usb_hcd_pci_probe+0x33e/0x490
>> >  [<ffffffff81761626>] ehci_pci_probe+0x36/0x40
>> >  [<ffffffff814bfe52>] local_pci_probe+0x42/0xa0
>> >  [<ffffffff814bfda2>] ? pci_match_device+0xf2/0x120
>> >  [<ffffffff814c1199>] pci_device_probe+0xe9/0x150
>> >  [<ffffffff815cf861>] driver_probe_device+0x181/0x310
>> >  [<ffffffff815cfacb>] __driver_attach+0x9b/0xa0
>> >  [<ffffffff815cfa30>] ? __device_attach+0x40/0x40
>> >  [<ffffffff815cd683>] bus_for_each_dev+0x73/0xb0
>> >  [<ffffffff815cf24e>] driver_attach+0x1e/0x20
>> >  [<ffffffff815cee78>] bus_add_driver+0x188/0x240
>> >  [<ffffffff8239ec18>] ? ehci_hcd_init+0x5d/0x5d
>> >  [<ffffffff815d09e4>] driver_register+0x64/0xf0
>> >  [<ffffffff814bf66a>] __pci_register_driver+0x8a/0x90
>> >  [<ffffffff8239ec7f>] ehci_pci_init+0x67/0x69
>> >  [<ffffffff8100045b>] do_one_initcall+0x12b/0x1c0
>> >  [<ffffffff8235615e>] kernel_init_freeable+0x1f9/0x2c0
>> >  [<ffffffff810b26c7>] ? trace_hardirqs_on_caller+0xe7/0x240
>> >  [<ffffffff810b282d>] ? trace_hardirqs_on+0xd/0x10
>> >  [<ffffffff81b641fb>] ? _raw_spin_unlock_irq+0x3b/0x80
>> >  [<ffffffff81087f5c>] ? finish_task_switch+0x9c/0x150
>> >  [<ffffffff81087f1d>] ? finish_task_switch+0x5d/0x150
>> >  [<ffffffff814946a7>] ? debug_smp_processor_id+0x17/0x20
>> >  [<ffffffff81b547a0>] ? rest_init+0x140/0x140
>> >  [<ffffffff81b547ae>] kernel_init+0xe/0xf0
>> >  [<ffffffff81b652a2>] ret_from_fork+0x42/0x70
>> >  [<ffffffff81b547a0>] ? rest_init+0x140/0x140
>>
>
