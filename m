From: "Alexandra N. Kossovsky" <Alexandra.Kossovsky@oktetlabs.ru>
Subject: Re: Bug#746232: 3.2.57-rt: rcu_preempt detected stalls at boot
Date: Thu, 15 May 2014 12:58:25 +0400
Message-ID: <20140515085825.GN12328@oktetlabs.ru>
References: <20140513074539.GJ12328@oktetlabs.ru>
 <53739824.2080007@windriver.com>
 <1400098553.2647.26.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-rt-users@vger.kernel.org, 746232@bugs.debian.org
To: Ben Hutchings <ben@decadent.org.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from shelob.oktetlabs.ru ([84.52.89.53]:53786 "EHLO
	shelob.oktetlabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbaEOI6l (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 May 2014 04:58:41 -0400
Content-Disposition: inline
In-Reply-To: <1400098553.2647.26.camel@deadeye.wl.decadent.org.uk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On May 14 21:15, Ben Hutchings wrote:
> On Wed, 2014-05-14 at 12:21 -0400, Paul Gortmaker wrote:
> > On 14-05-13 03:45 AM, Alexandra N. Kossovsky wrote:
> > > Hello.
> > > 
> > > One of my computers fails to boot with 3.2.57-rt kernel, i686.
> > > The kernel is the Debian one: linux-image-3.2.0-4-rt-686-pae, version
> > > 3.2.57-3.  Same non-rt kernel boots fine.  All newer -rt kernels (I've
> > > tried kernels starting from 3.6) boot fine.
> > > You can find some details of the hardware in
> > > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=746232,
> > > including lspci output and full kernel output.
> > 
> > One of the more recent additions was to ensure RCU_BOOST was
> > auto selected via Kconfig dependencies.  It might not have
> > been present in 3.2.57-rt; not sure w/o checking what debian
> > has in there.  But you might want to check the .config you
> > have to see whether it is on or off, and try enabling it.
> [...]
> 
> $ grep RCU_BOOST /usr/src/linux-headers-3.2.0-4-rt-686-pae/.config
> # CONFIG_RCU_BOOST is not set

$ grep BOOST .config
CONFIG_RCU_BOOST=y
CONFIG_RCU_BOOST_PRIO=1
CONFIG_RCU_BOOST_DELAY=500

Does not help.

Should I play with PRIO and DELAY numbers?

Log:

[    5.414059] Switching to clocksource tsc
[   64.503649] INFO: rcu_preempt detected stalls on CPUs/tasks: {} (detected by 6, t=15002 jiffies)
[   64.503655] INFO: Stall ended before state dump start
[  244.054622] INFO: task swapper/0:1 blocked for more than 120 seconds.
[  244.075069] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  244.088152] swapper/0       D e9f40680     0     1      0 0x00000000
[  244.094720]  e28d56f0 00000046 00000df4 e9f40680 e28d58c4 c102815b c14c7680 c14c7680
[  244.103035]  c1547fdc c12c35f2 000035c0 c102815b 00000001 c12c6149 e2818800 c12c357c
[  244.111342]  c119012e 00000004 c13fc07c e2818800 00000000 c13fc07c c12c6276 ffffffff
[  244.119649] Call Trace:
[  244.122163]  [<c102815b>] ? get_parent_ip+0x8/0x19
[  244.127012]  [<c12c35f2>] ? _raw_spin_lock_irqsave+0x1b/0x39
[  244.132726]  [<c102815b>] ? get_parent_ip+0x8/0x19
[  244.137576]  [<c12c6149>] ? sub_preempt_count+0x68/0x84
[  244.142859]  [<c12c357c>] ? _raw_spin_unlock_irqrestore+0x1f/0x29
[  244.149031]  [<c119012e>] ? vgacon_scroll+0x109/0x19a
[  244.154142]  [<c12c6276>] ? __atomic_notifier_call_chain+0x33/0x3c
[  244.160374]  [<c12c26ca>] ? schedule+0x65/0x7e
[  244.164871]  [<c12c28f2>] ? schedule_timeout+0x1f/0xaf
[  244.170064]  [<c102815b>] ? get_parent_ip+0x8/0x19
[  244.174909]  [<c12c6149>] ? sub_preempt_count+0x68/0x84
[  244.180188]  [<c102815b>] ? get_parent_ip+0x8/0x19
[  244.185032]  [<c102815b>] ? get_parent_ip+0x8/0x19
[  244.189880]  [<c12c6149>] ? sub_preempt_count+0x68/0x84
[  244.195166]  [<c102b005>] ? migrate_enable+0xb3/0x135
[  244.200272]  [<c12c259c>] ? wait_for_common+0x7f/0xe1
[  244.205377]  [<c102aed0>] ? try_to_wake_up+0x183/0x183
[  244.210577]  [<c10781d5>] ? __call_rcu+0xe7/0xe7
[  244.215257]  [<c1044f64>] ? wait_rcu_gp+0x2e/0x33
[  244.220019]  [<c1044f69>] ? wait_rcu_gp+0x33/0x33
[  244.224790]  [<c1020000>] ? kmap_atomic_prot+0x7b/0xd9
[  244.229979]  [<c102b005>] ? migrate_enable+0xb3/0x135
[  244.235097]  [<c119bd45>] ? acpi_post_unmap_gar+0x78/0x93
[  244.240562]  [<c11b9ff2>] ? apei_res_sub+0xd2/0xd2
[  244.245407]  [<c11ba007>] ? post_unmap_gar_callback+0x15/0x18
[  244.251208]  [<c11b9e14>] ? apei_exec_for_each_entry+0x56/0x68
[  244.257105]  [<c1436be8>] ? setup_erst_disable+0xd/0xd
[  244.262302]  [<c11b9e44>] ? apei_exec_post_unmap_gars+0xe/0x10
[  244.268183]  [<c1436e18>] ? erst_init+0x230/0x29d
[  244.272956]  [<c11ef1ca>] ? bus_add_driver+0x17d/0x1ce
[  244.278158]  [<c1436a00>] ? acpi_initialize_subsystem+0x83/0x83
[  244.284140]  [<c11efbb8>] ? driver_register+0x75/0xd6
[  244.289252]  [<c100115c>] ? do_one_initcall+0x66/0x10e
[  244.294445]  [<c14137d7>] ? kernel_init+0xfc/0x173
[  244.299291]  [<c14136db>] ? start_kernel+0x314/0x314
[  244.304310]  [<c12c7d3e>] ? kernel_thread_helper+0x6/0xd
[  244.309676] INFO: task rcub/1:13 blocked for more than 120 seconds.
[  244.315993] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  244.323885] rcub/1          D e9f40680     0    13      2 0x00000000
[  244.330414]  e28eec10 00000046 6572756c e9f40680 30056543 00000001 c14c7680 c14c7680
[  244.338732]  c104ba42 c1471680 c10061df e9f406c4 ff48e500 ffffffff e28d56f0 c12cc3d8
[  244.347049]  e28d56f0 c12cc3d8 c1020f7b
[  244.350142] INFO: rcu_preempt detected stalls on CPUs/tasks: {} (detected by 0, t=60034 jiffies)
[  244.350143] INFO: Stall ended before state dump start
[  244.365081]  e28d56f0 e9f40680 00000062 c102a24f 00000078
[  244.370853] Call Trace:
[  364.546439]  [<c104ba42>] ? sched_clock_cpu+0x10/0x146
[  364.551634]  [<c10061df>] ? __cycles_2_ns+0x19/0x7e
[  364.556567]  [<c1020f7b>] ? check_class_changed+0x25/0x33
[  364.562020]  [<c102a24f>] ? rt_mutex_setprio+0x10d/0x134
[  364.567384]  [<c12c26ca>] ? schedule+0x65/0x7e
[  364.571882]  [<c12c2f87>] ? __rt_mutex_slowlock+0x79/0xb7
[  364.577336]  [<c12c3086>] ? rt_mutex_slowlock+0xc1/0x116
[  364.582701]  [<c1024abb>] ? finish_task_switch+0x66/0x9f
[  364.588066]  [<c10579a7>] ? rt_mutex_fastlock.constprop.14+0x12/0x2a
[  364.594472]  [<c1076fba>] ? rcu_boost_kthread+0xdf/0x125
[  364.599843]  [<c1020101>] ? __kunmap_atomic+0x2f/0x6a
[  364.604949]  [<c1076edb>] ? trace_rcu_utilization+0x50/0x50
[  364.610573]  [<c1046c54>] ? kthread+0x64/0x69
[  364.614986]  [<c1046bf0>] ? flush_kthread_worker+0x7d/0x7d
[  364.620525]  [<c12c7d3e>] ? kernel_thread_helper+0x6/0xd

Sasha.
-- 
Alexandra N. Kossovsky
OKTET Labs (http://www.oktetlabs.ru/)
