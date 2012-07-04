From: Dong Liu <dliu.cn@gmail.com>
Subject: Re: cpu stall and hyperthread
Date: Wed, 04 Jul 2012 13:27:14 -0400
Message-ID: <4FF47CF2.90607@gmail.com>
References: <4FEBCDDE.60503@gmail.com> <4FF351C6.3000100@gmail.com> <20120704011300.GA2522@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090200050601040403020407"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:41572 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab2GDR1R (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Jul 2012 13:27:17 -0400
Received: by qadb17 with SMTP id b17so3397832qad.19
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Jul 2012 10:27:16 -0700 (PDT)
In-Reply-To: <20120704011300.GA2522@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------090200050601040403020407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/12 9:13 PM, Paul E. McKenney wrote:

>> On 6/27/12 11:22 PM, Dong Liu wrote:
>>> Hi,
>>>
>>> I'm running 3.4.3-rt11 and 3.2.18-rt29 on a system with Intel I7 860, I
>>> noticed that with hyperthread enabled, I'm getting kernel error
>>>
>>> rcu_preempt detected stalls on CPUs/tasks: { 3} (detected by 5, t=60002
>>> jiffies)
>
> Did you get stack traces with this error?  And did you get repeated
> stall messages if you waited a few minutes after the first one?
>
> If so, the stack traces can help track down the problem.
>
> 							Thanx, Paul
>
Sorry, I thought I attached the dmesg output in my initial mail :)

Here is the dmesg output.

Thanks,

Dong

--------------090200050601040403020407
Content-Type: text/plain; charset=UTF-8;
 name="rt-cpu-stall-with-ht.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="rt-cpu-stall-with-ht.txt"

[ 7218.536199] INFO: rcu_preempt detected stalls on CPUs/tasks: { 3} (detected by 5, t=60002 jiffies)
[ 7218.536210] sending NMI to all CPUs:
[ 7218.536218] NMI backtrace for cpu 7
[ 7218.536222] CPU 7 
[ 7218.536225] Modules linked in: fuse ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack xt_CHECKSUM iptable_mangle 8021q garp sunrpc bridge stp llc binfmt_misc vhost_net macvtap macvlan tun kvm_intel kvm uinput joydev microcode serio_raw pcspkr i7core_edac edac_core i2c_i801 iTCO_wdt iTCO_vendor_support r8169 mii snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 7218.536293] 
[ 7218.536298] Pid: 0, comm: swapper/7 Not tainted 3.2.18-1.el6.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 7218.536306] RIP: 0010:[<ffffffff8103dbb6>]  [<ffffffff8103dbb6>] hpet_legacy_next_event+0x16/0x50
[ 7218.536318] RSP: 0018:ffff880122943ce8  EFLAGS: 00000002
[ 7218.536322] RAX: 000000001ac98327 RBX: ffffffff81c1a500 RCX: 0000000000000020
[ 7218.536327] RDX: 0000000225c17d03 RSI: ffffffff81c1a500 RDI: 0000000000002e45
[ 7218.536331] RBP: ffff880122943ce8 R08: 0000000000000000 R09: 0000000000000000
[ 7218.536335] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[ 7218.536339] R13: 00000000000c9f9a R14: 0000000000000004 R15: 0000000000000007
[ 7218.536344] FS:  0000000000000000(0000) GS:ffff88012fdc0000(0000) knlGS:0000000000000000
[ 7218.536349] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 7218.536354] CR2: 0000000001173200 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 7218.536358] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 7218.536363] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 7218.536368] Process swapper/7 (pid: 0, threadinfo ffff880122942000, task ffff880122940500)
[ 7218.536371] Stack:
[ 7218.536374]  ffff880122943d18 ffffffff810a9034 ffff880122943d18 0000000000000002
[ 7218.536382]  ffff88012fdcba40 ffffffff81c1a500 ffff880122943d58 ffffffff810a9dd8
[ 7218.536389]  ffff880122943d38 ffff880122943e84 ffff880122943e84 00000000ffffffff
[ 7218.536396] Call Trace:
[ 7218.536405]  [<ffffffff810a9034>] clockevents_program_event+0x74/0x120
[ 7218.536413]  [<ffffffff810a9dd8>] tick_broadcast_oneshot_control+0x128/0x130
[ 7218.536420]  [<ffffffff810a94f5>] tick_notify+0x325/0x410
[ 7218.536427]  [<ffffffff8101e542>] ? __switch_to_xtra+0x172/0x1a0
[ 7218.536435]  [<ffffffff816005c5>] notifier_call_chain+0x55/0x80
[ 7218.536443]  [<ffffffff8109f036>] raw_notifier_call_chain+0x16/0x20
[ 7218.536450]  [<ffffffff810a89ad>] clockevents_notify+0x3d/0x140
[ 7218.536458]  [<ffffffff81326006>] intel_idle+0x136/0x150
[ 7218.536466]  [<ffffffff814b0919>] ? menu_select+0xf9/0x3b0
[ 7218.536473]  [<ffffffff814af6b1>] cpuidle_idle_call+0xd1/0x1d0
[ 7218.536481]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
[ 7218.536488]  [<ffffffff815f4958>] start_secondary+0x230/0x237
[ 7218.536493] Code: 0f 1f 44 00 00 31 c0 c9 c3 66 66 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 66 66 66 66 90 48 8b 05 50 e2 ea 00 8b 80 f0 00 00 00 <8d> 3c 38 48 8b 05 40 e2 ea 00 89 b8 08 01 00 00 48 8b 05 33 e2 
[ 7218.536543] Call Trace:
[ 7218.536548]  [<ffffffff810a9034>] clockevents_program_event+0x74/0x120
[ 7218.536555]  [<ffffffff810a9dd8>] tick_broadcast_oneshot_control+0x128/0x130
[ 7218.536562]  [<ffffffff810a94f5>] tick_notify+0x325/0x410
[ 7218.536567]  [<ffffffff8101e542>] ? __switch_to_xtra+0x172/0x1a0
[ 7218.536574]  [<ffffffff816005c5>] notifier_call_chain+0x55/0x80
[ 7218.536581]  [<ffffffff8109f036>] raw_notifier_call_chain+0x16/0x20
[ 7218.536587]  [<ffffffff810a89ad>] clockevents_notify+0x3d/0x140
[ 7218.536593]  [<ffffffff81326006>] intel_idle+0x136/0x150
[ 7218.536599]  [<ffffffff814b0919>] ? menu_select+0xf9/0x3b0
[ 7218.536606]  [<ffffffff814af6b1>] cpuidle_idle_call+0xd1/0x1d0
[ 7218.536612]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
[ 7218.536617]  [<ffffffff815f4958>] start_secondary+0x230/0x237
[ 7218.536625] NMI backtrace for cpu 2
[ 7218.536629] CPU 2 
[ 7218.536631] Modules linked in: fuse ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack xt_CHECKSUM iptable_mangle 8021q garp sunrpc bridge stp llc binfmt_misc vhost_net macvtap macvlan tun kvm_intel kvm uinput joydev microcode serio_raw pcspkr i7core_edac edac_core i2c_i801 iTCO_wdt iTCO_vendor_support r8169 mii snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 7218.536694] 
[ 7218.536698] Pid: 18, comm: ksoftirqd/2 Not tainted 3.2.18-1.el6.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 7218.536706] RIP: 0010:[<ffffffff812cb7a6>]  [<ffffffff812cb7a6>] cpumask_next_and+0x36/0x40
[ 7218.536717] RSP: 0018:ffff88012281ba70  EFLAGS: 00000012
[ 7218.536722] RAX: 0000000000000100 RBX: ffff88011df53198 RCX: 0000000000000008
[ 7218.536726] RDX: 0000000000000008 RSI: 0000000000000100 RDI: 0000000000000000
[ 7218.536730] RBP: ffff88012281ba80 R08: ffff88011df531b8 R09: 0000000000000100
[ 7218.536735] R10: 0000000000000000 R11: 0000000000000002 R12: ffff88012fc8c260
[ 7218.536739] R13: 0000000000000000 R14: 0000000000011e00 R15: 0000000000000000
[ 7218.536744] FS:  0000000000000000(0000) GS:ffff88012fc80000(0000) knlGS:0000000000000000
[ 7218.536749] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 7218.536753] CR2: 000000000114d098 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 7218.536758] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 7218.536762] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 7218.536767] Process ksoftirqd/2 (pid: 18, threadinfo ffff88012281a000, task ffff8801228184c0)
[ 7218.536771] Stack:
[ 7218.536773]  0000000000011e00 ffff88012fc8c260 ffff88012281bc50 ffffffff8105d2f9
[ 7218.536781]  ffff88012281bbe0 ffff88012281bb30 ffff88012281bad0 ffff880045dca2d0
[ 7218.536788]  ffff88012281bd40 ffff88012281bdec 0000000200dca950 ffff88012fc8c260
[ 7218.536795] Call Trace:
[ 7218.536804]  [<ffffffff8105d2f9>] find_busiest_group+0x239/0xb10
[ 7218.536817]  [<ffffffff8106e2c2>] load_balance+0xf2/0x990
[ 7218.536824]  [<ffffffff81068921>] ? __dequeue_rt_entity+0x201/0x2c0
[ 7218.536831]  [<ffffffff81069c69>] ? update_shares+0x109/0x120
[ 7218.536837]  [<ffffffff81068e49>] ? dequeue_task_rt+0x39/0x50
[ 7218.536845]  [<ffffffff815fa7bd>] __schedule+0x7cd/0x880
[ 7218.536853]  [<ffffffff815facde>] schedule+0x2e/0xa0
[ 7218.536859]  [<ffffffff815fafb8>] schedule_preempt_disabled+0x18/0x30
[ 7218.536867]  [<ffffffff8107bee5>] run_ksoftirqd+0x1b5/0x1e0
[ 7218.536874]  [<ffffffff8107bd30>] ? __thread_do_softirq+0x150/0x150
[ 7218.536880]  [<ffffffff8107bd30>] ? __thread_do_softirq+0x150/0x150
[ 7218.536889]  [<ffffffff81098626>] kthread+0x96/0xa0
[ 7218.536895]  [<ffffffff8105f199>] ? finish_task_switch+0x49/0xf0
[ 7218.536904]  [<ffffffff816062b4>] kernel_thread_helper+0x4/0x10
[ 7218.536911]  [<ffffffff81098590>] ? kthreadd+0x1f0/0x1f0
[ 7218.536918]  [<ffffffff816062b0>] ? gs_change+0x13/0x13
[ 7218.536921] Code: 53 48 89 f3 90 83 c0 01 be 00 01 00 00 48 89 df 48 63 d0 e8 6d 16 01 00 3b 05 ef c6 a0 00 7d 0b 41 0f a3 04 24 19 d2 85 d2 74 da <5b> 41 5c c9 c3 0f 1f 44 00 00 55 b8 ff ff ff ff 48 89 e5 41 54 
[ 7218.536971] Call Trace:
[ 7218.536977]  [<ffffffff8105d2f9>] find_busiest_group+0x239/0xb10
[ 7218.536988]  [<ffffffff8106e2c2>] load_balance+0xf2/0x990
[ 7218.536995]  [<ffffffff81068921>] ? __dequeue_rt_entity+0x201/0x2c0
[ 7218.537001]  [<ffffffff81069c69>] ? update_shares+0x109/0x120
[ 7218.537007]  [<ffffffff81068e49>] ? dequeue_task_rt+0x39/0x50
[ 7218.537014]  [<ffffffff815fa7bd>] __schedule+0x7cd/0x880
[ 7218.537021]  [<ffffffff815facde>] schedule+0x2e/0xa0
[ 7218.537027]  [<ffffffff815fafb8>] schedule_preempt_disabled+0x18/0x30
[ 7218.537033]  [<ffffffff8107bee5>] run_ksoftirqd+0x1b5/0x1e0
[ 7218.537040]  [<ffffffff8107bd30>] ? __thread_do_softirq+0x150/0x150
[ 7218.537046]  [<ffffffff8107bd30>] ? __thread_do_softirq+0x150/0x150
[ 7218.537053]  [<ffffffff81098626>] kthread+0x96/0xa0
[ 7218.537059]  [<ffffffff8105f199>] ? finish_task_switch+0x49/0xf0
[ 7218.537066]  [<ffffffff816062b4>] kernel_thread_helper+0x4/0x10
[ 7218.537073]  [<ffffffff81098590>] ? kthreadd+0x1f0/0x1f0
[ 7218.537080]  [<ffffffff816062b0>] ? gs_change+0x13/0x13
[ 7218.537084] NMI backtrace for cpu 6
[ 7218.537087] CPU 6 
[ 7218.537089] Modules linked in: fuse ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack xt_CHECKSUM iptable_mangle 8021q garp sunrpc bridge stp llc binfmt_misc vhost_net macvtap macvlan tun kvm_intel kvm uinput joydev microcode serio_raw pcspkr i7core_edac edac_core i2c_i801 iTCO_wdt iTCO_vendor_support r8169 mii snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 7218.537141] 
[ 7218.537144] Pid: 38, comm: ksoftirqd/6 Not tainted 3.2.18-1.el6.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 7218.537150] RIP: 0010:[<ffffffff812dce68>]  [<ffffffff812dce68>] find_next_bit+0x68/0xb0
[ 7218.537158] RSP: 0018:ffff8801228fda60  EFLAGS: 00000006
[ 7218.537161] RAX: 0000000000000000 RBX: ffff88011df53198 RCX: 0000000000000008
[ 7218.537164] RDX: 0000000000000008 RSI: 0000000000000100 RDI: 0000000000000040
[ 7218.537167] RBP: ffff8801228fda60 R08: ffff88011df531b8 R09: 0000000000000100
[ 7218.537170] R10: 0000000000000000 R11: 0000000000000002 R12: ffff88012fd8c260
[ 7218.537173] R13: 0000000000000000 R14: 0000000000011e00 R15: 0000000000000000
[ 7218.537177] FS:  0000000000000000(0000) GS:ffff88012fd80000(0000) knlGS:0000000000000000
[ 7218.537181] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 7218.537184] CR2: 0000003642817230 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 7218.537187] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 7218.537191] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 7218.537194] Process ksoftirqd/6 (pid: 38, threadinfo ffff8801228fc000, task ffff8801228f6340)
[ 7218.537197] Stack:
[ 7218.537199]  ffff8801228fda80 ffffffff812cb793 0000000000011e00 ffff88012fd8c260
[ 7218.537204]  ffff8801228fdc50 ffffffff8105d2f9 ffff8801228fdbe0 ffff8801228fdb30
[ 7218.537209]  ffff8801228fdad0 ffff880045c6a550 ffff8801228fdd40 ffff8801228fddec
[ 7218.537214] Call Trace:
[ 7218.537218]  [<ffffffff812cb793>] cpumask_next_and+0x23/0x40
[ 7218.537224]  [<ffffffff8105d2f9>] find_busiest_group+0x239/0xb10
[ 7218.537232]  [<ffffffff8106e2c2>] load_balance+0xf2/0x990
[ 7218.537237]  [<ffffffff81068921>] ? __dequeue_rt_entity+0x201/0x2c0
[ 7218.537243]  [<ffffffff81069c69>] ? update_shares+0x109/0x120
[ 7218.537247]  [<ffffffff81068e49>] ? dequeue_task_rt+0x39/0x50
[ 7218.537252]  [<ffffffff815fa7bd>] __schedule+0x7cd/0x880
[ 7218.537258]  [<ffffffff815facde>] schedule+0x2e/0xa0
[ 7218.537262]  [<ffffffff815fafb8>] schedule_preempt_disabled+0x18/0x30
[ 7218.537267]  [<ffffffff8107bee5>] run_ksoftirqd+0x1b5/0x1e0
[ 7218.537272]  [<ffffffff8107bd30>] ? __thread_do_softirq+0x150/0x150
[ 7218.537277]  [<ffffffff8107bd30>] ? __thread_do_softirq+0x150/0x150
[ 7218.537282]  [<ffffffff81098626>] kthread+0x96/0xa0
[ 7218.537287]  [<ffffffff8105f199>] ? finish_task_switch+0x49/0xf0
[ 7218.537293]  [<ffffffff816062b4>] kernel_thread_helper+0x4/0x10
[ 7218.537298]  [<ffffffff81098590>] ? kthreadd+0x1f0/0x1f0
[ 7218.537303]  [<ffffffff816062b0>] ? gs_change+0x13/0x13
[ 7218.537306] Code: 83 ff 3f 76 3e 48 85 c0 75 4f 49 83 c0 08 48 83 ef 40 49 83 c1 40 eb 17 0f 1f 00 49 8b 00 48 85 c0 75 36 49 83 c0 08 49 83 c1 40 <48> 83 ef 40 48 f7 c7 c0 ff ff ff 75 e3 48 85 ff 4c 89 c8 74 20 
[ 7218.537339] Call Trace:
[ 7218.537343]  [<ffffffff812cb793>] cpumask_next_and+0x23/0x40
[ 7218.537348]  [<ffffffff8105d2f9>] find_busiest_group+0x239/0xb10
[ 7218.537356]  [<ffffffff8106e2c2>] load_balance+0xf2/0x990
[ 7218.537361]  [<ffffffff81068921>] ? __dequeue_rt_entity+0x201/0x2c0
[ 7218.537366]  [<ffffffff81069c69>] ? update_shares+0x109/0x120
[ 7218.537371]  [<ffffffff81068e49>] ? dequeue_task_rt+0x39/0x50
[ 7218.537376]  [<ffffffff815fa7bd>] __schedule+0x7cd/0x880
[ 7218.537381]  [<ffffffff815facde>] schedule+0x2e/0xa0
[ 7218.537386]  [<ffffffff815fafb8>] schedule_preempt_disabled+0x18/0x30
[ 7218.537391]  [<ffffffff8107bee5>] run_ksoftirqd+0x1b5/0x1e0
[ 7218.537395]  [<ffffffff8107bd30>] ? __thread_do_softirq+0x150/0x150
[ 7218.537400]  [<ffffffff8107bd30>] ? __thread_do_softirq+0x150/0x150
[ 7218.537405]  [<ffffffff81098626>] kthread+0x96/0xa0
[ 7218.537410]  [<ffffffff8105f199>] ? finish_task_switch+0x49/0xf0
[ 7218.537415]  [<ffffffff816062b4>] kernel_thread_helper+0x4/0x10
[ 7218.537421]  [<ffffffff81098590>] ? kthreadd+0x1f0/0x1f0
[ 7218.537426]  [<ffffffff816062b0>] ? gs_change+0x13/0x13
[ 7218.537430] NMI backtrace for cpu 4
[ 7218.537434] CPU 4 
[ 7218.537437] Modules linked in: fuse ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack xt_CHECKSUM iptable_mangle 8021q garp sunrpc bridge stp llc binfmt_misc vhost_net macvtap macvlan tun kvm_intel kvm uinput joydev microcode serio_raw pcspkr i7core_edac edac_core i2c_i801 iTCO_wdt iTCO_vendor_support r8169 mii snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 7218.537498] 
[ 7218.537502] Pid: 28, comm: ksoftirqd/4 Not tainted 3.2.18-1.el6.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 7218.537510] RIP: 0010:[<ffffffff8106e9b8>]  [<ffffffff8106e9b8>] load_balance+0x7e8/0x990
[ 7218.537521] RSP: 0018:ffff88012289dc60  EFLAGS: 00000012
[ 7218.537525] RAX: 0000000000000200 RBX: 0000000000000000 RCX: 0000000000000002
[ 7218.537529] RDX: 0000000000000200 RSI: ffff88012289dd40 RDI: ffff880120684000
[ 7218.537534] RBP: ffff88012289dd80 R08: ffff88012289ddec R09: 0000000000000001
[ 7218.537538] R10: 0000000000000000 R11: 0000000000000002 R12: ffff88012289a430
[ 7218.537542] R13: 0000000000000004 R14: ffff880120684000 R15: 000000010069c3a7
[ 7218.537548] FS:  0000000000000000(0000) GS:ffff88012fd00000(0000) knlGS:0000000000000000
[ 7218.537552] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 7218.537557] CR2: 00007fb277790000 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 7218.537561] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 7218.537566] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 7218.537571] Process ksoftirqd/4 (pid: 28, threadinfo ffff88012289c000, task ffff88012289a040)
[ 7218.537574] Stack:
[ 7218.537576]  ffff88011cab2400 0000000300000001 0000000000011e00 ffff880122878038
[ 7218.537584]  ffff88012289ddec 0000000000011e00 0000000000000002 0000000000000000
[ 7218.537591]  00001266601b9ae6 ffff88012fd0c260 ffff88012289dce0 ffff88012289a040
[ 7218.537598] Call Trace:
[ 7218.537606]  [<ffffffff81068921>] ? __dequeue_rt_entity+0x201/0x2c0
[ 7218.537613]  [<ffffffff81069c69>] ? update_shares+0x109/0x120
[ 7218.537619]  [<ffffffff81068e49>] ? dequeue_task_rt+0x39/0x50
[ 7218.537627]  [<ffffffff815fa7bd>] __schedule+0x7cd/0x880
[ 7218.537633]  [<ffffffff8107ba93>] ? __do_softirq_common+0x153/0x2a0
[ 7218.537640]  [<ffffffff815facde>] schedule+0x2e/0xa0
[ 7218.537647]  [<ffffffff815fafb8>] schedule_preempt_disabled+0x18/0x30
[ 7218.537653]  [<ffffffff8107bee5>] run_ksoftirqd+0x1b5/0x1e0
[ 7218.537660]  [<ffffffff8107bd30>] ? __thread_do_softirq+0x150/0x150
[ 7218.537666]  [<ffffffff8107bd30>] ? __thread_do_softirq+0x150/0x150
[ 7218.537673]  [<ffffffff81098626>] kthread+0x96/0xa0
[ 7218.537680]  [<ffffffff8105f199>] ? finish_task_switch+0x49/0xf0
[ 7218.537687]  [<ffffffff816062b4>] kernel_thread_helper+0x4/0x10
[ 7218.537695]  [<ffffffff81098590>] ? kthreadd+0x1f0/0x1f0
[ 7218.537701]  [<ffffffff816062b0>] ? gs_change+0x13/0x13
[ 7218.537704] Code: ff ff ff 4d 89 d7 e9 45 fd ff ff 48 89 45 98 e9 f3 fd ff ff 48 8b 7d 90 c7 47 64 00 00 00 00 4c 8b 45 90 49 8b 40 18 41 89 40 60 <48> 81 c4 f8 00 00 00 89 d8 5b 41 5c 41 5d 41 5e 41 5f c9 c3 4c 
[ 7218.537754] Call Trace:
[ 7218.537761]  [<ffffffff81068921>] ? __dequeue_rt_entity+0x201/0x2c0
[ 7218.537768]  [<ffffffff81069c69>] ? update_shares+0x109/0x120
[ 7218.537774]  [<ffffffff81068e49>] ? dequeue_task_rt+0x39/0x50
[ 7218.537780]  [<ffffffff815fa7bd>] __schedule+0x7cd/0x880
[ 7218.537786]  [<ffffffff8107ba93>] ? __do_softirq_common+0x153/0x2a0
[ 7218.537794]  [<ffffffff815facde>] schedule+0x2e/0xa0
[ 7218.537800]  [<ffffffff815fafb8>] schedule_preempt_disabled+0x18/0x30
[ 7218.537806]  [<ffffffff8107bee5>] run_ksoftirqd+0x1b5/0x1e0
[ 7218.537812]  [<ffffffff8107bd30>] ? __thread_do_softirq+0x150/0x150
[ 7218.537819]  [<ffffffff8107bd30>] ? __thread_do_softirq+0x150/0x150
[ 7218.537825]  [<ffffffff81098626>] kthread+0x96/0xa0
[ 7218.537831]  [<ffffffff8105f199>] ? finish_task_switch+0x49/0xf0
[ 7218.537838]  [<ffffffff816062b4>] kernel_thread_helper+0x4/0x10
[ 7218.537846]  [<ffffffff81098590>] ? kthreadd+0x1f0/0x1f0
[ 7218.537852]  [<ffffffff816062b0>] ? gs_change+0x13/0x13
[ 7218.537855] NMI backtrace for cpu 5
[ 7218.537858] CPU 5 
[ 7218.537860] Modules linked in: fuse ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack xt_CHECKSUM iptable_mangle 8021q garp sunrpc bridge stp llc binfmt_misc vhost_net macvtap macvlan tun kvm_intel kvm uinput joydev microcode serio_raw pcspkr i7core_edac edac_core i2c_i801 iTCO_wdt iTCO_vendor_support r8169 mii snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 7218.537921] 
[ 7218.537926] Pid: 0, comm: swapper/5 Not tainted 3.2.18-1.el6.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 7218.537934] RIP: 0010:[<ffffffff812d7a32>]  [<ffffffff812d7a32>] __const_udelay+0x12/0x30
[ 7218.537943] RSP: 0018:ffff88012fd43d98  EFLAGS: 00000002
[ 7218.537947] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000094
[ 7218.537952] RDX: 00000000002a9c44 RSI: 0000000000000100 RDI: 0000000000418958
[ 7218.537956] RBP: ffff88012fd43d98 R08: 0000000000000004 R09: 000000000000000a
[ 7218.537960] R10: 0000000000000006 R11: 0000000000000000 R12: ffffffff81c37500
[ 7218.537965] R13: ffffffff81c37600 R14: 0000000000000001 R15: ffffffff81c38600
[ 7218.537970] FS:  0000000000000000(0000) GS:ffff88012fd40000(0000) knlGS:0000000000000000
[ 7218.537975] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 7218.537979] CR2: 0000003642817230 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 7218.537984] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 7218.537988] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 7218.537993] Process swapper/5 (pid: 0, threadinfo ffff8801228e0000, task ffff8801228de200)
[ 7218.537996] Stack:
[ 7218.537999]  ffff88012fd43db8 ffffffff81035a2d 000000000000fffb ffff88012fd4cf40
[ 7218.538007]  ffff88012fd43e28 ffffffff810f06df ffff880100000000 0000000000000000
[ 7218.538013]  00000000000f41a8 0000000000000003 000000000000ea62 0000000000000087
[ 7218.538021] Call Trace:
[ 7218.538023]  <IRQ> 
[ 7218.538031]  [<ffffffff81035a2d>] arch_trigger_all_cpu_backtrace+0x6d/0xa0
[ 7218.538040]  [<ffffffff810f06df>] __rcu_pending+0x40f/0x510
[ 7218.538047]  [<ffffffff810f0a8a>] rcu_check_callbacks+0x2aa/0x2c0
[ 7218.538055]  [<ffffffff81083ebd>] update_process_times+0x4d/0x70
[ 7218.538063]  [<ffffffff810aab73>] tick_sched_timer+0x63/0xc0
[ 7218.538069]  [<ffffffff8109d686>] __run_hrtimer+0x76/0x270
[ 7218.538075]  [<ffffffff810aab10>] ? tick_nohz_handler+0x110/0x110
[ 7218.538082]  [<ffffffff8109db60>] hrtimer_interrupt+0xf0/0x230
[ 7218.538089]  [<ffffffff81606d16>] smp_apic_timer_interrupt+0x66/0x98
[ 7218.538096]  [<ffffffff81604c1e>] apic_timer_interrupt+0x6e/0x80
[ 7218.538100]  <EOI> 
[ 7218.538107]  [<ffffffff81325fb0>] ? intel_idle+0xe0/0x150
[ 7218.538113]  [<ffffffff81325f96>] ? intel_idle+0xc6/0x150
[ 7218.538121]  [<ffffffff814af6b1>] cpuidle_idle_call+0xd1/0x1d0
[ 7218.538128]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
[ 7218.538134]  [<ffffffff815f4958>] start_secondary+0x230/0x237
[ 7218.538139] Code: 66 90 ff 15 d1 c4 99 00 c9 c3 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 66 66 66 66 90 65 48 8b 14 25 58 1d 01 00 <48> 8d 04 bd 00 00 00 00 48 69 d2 fa 00 00 00 f7 e2 48 8d 7a 01 
[ 7218.538188] Call Trace:
[ 7218.538191]  <IRQ>  [<ffffffff81035a2d>] arch_trigger_all_cpu_backtrace+0x6d/0xa0
[ 7218.538202]  [<ffffffff810f06df>] __rcu_pending+0x40f/0x510
[ 7218.538210]  [<ffffffff810f0a8a>] rcu_check_callbacks+0x2aa/0x2c0
[ 7218.538216]  [<ffffffff81083ebd>] update_process_times+0x4d/0x70
[ 7218.538222]  [<ffffffff810aab73>] tick_sched_timer+0x63/0xc0
[ 7218.538229]  [<ffffffff8109d686>] __run_hrtimer+0x76/0x270
[ 7218.538235]  [<ffffffff810aab10>] ? tick_nohz_handler+0x110/0x110
[ 7218.538241]  [<ffffffff8109db60>] hrtimer_interrupt+0xf0/0x230
[ 7218.538248]  [<ffffffff81606d16>] smp_apic_timer_interrupt+0x66/0x98
[ 7218.538254]  [<ffffffff81604c1e>] apic_timer_interrupt+0x6e/0x80
[ 7218.538258]  <EOI>  [<ffffffff81325fb0>] ? intel_idle+0xe0/0x150
[ 7218.538268]  [<ffffffff81325f96>] ? intel_idle+0xc6/0x150
[ 7218.538275]  [<ffffffff814af6b1>] cpuidle_idle_call+0xd1/0x1d0
[ 7218.538281]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
[ 7218.538287]  [<ffffffff815f4958>] start_secondary+0x230/0x237
[ 7218.538293] NMI backtrace for cpu 1
[ 7218.538297] CPU 1 
[ 7218.538299] Modules linked in: fuse ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack xt_CHECKSUM iptable_mangle 8021q garp sunrpc bridge stp llc binfmt_misc vhost_net macvtap macvlan tun kvm_intel kvm uinput joydev microcode serio_raw pcspkr i7core_edac edac_core i2c_i801 iTCO_wdt iTCO_vendor_support r8169 mii snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 7218.538365] 
[ 7218.538369] Pid: 0, comm: swapper/1 Not tainted 3.2.18-1.el6.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 7218.538378] RIP: 0010:[<ffffffff81325f86>]  [<ffffffff81325f86>] intel_idle+0xb6/0x150
[ 7218.538387] RSP: 0018:ffff880122ffde58  EFLAGS: 00000046
[ 7218.538392] RAX: 0000000000000020 RBX: 0000000000000008 RCX: 0000000000000001
[ 7218.538397] RDX: 0000000000000000 RSI: ffff880122ffdfd8 RDI: ffffffff81c16100
[ 7218.538401] RBP: ffff880122ffdeb8 R08: 0000000000000000 R09: 0000000000000000
[ 7218.538406] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
[ 7218.538411] R13: ffff88012fc58a70 R14: 0000000000000020 R15: 129b8774d980e5ec
[ 7218.538417] FS:  0000000000000000(0000) GS:ffff88012fc40000(0000) knlGS:0000000000000000
[ 7218.538423] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 7218.538427] CR2: 00000000011e5990 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 7218.538432] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 7218.538437] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 7218.538443] Process swapper/1 (pid: 0, threadinfo ffff880122ffc000, task ffff880122ffa380)
[ 7218.538447] Stack:
[ 7218.538449]  ffff880122ffdeb8 ffffffff814b0919 0000000000000000 00000000000cb768
[ 7218.538457]  0000000000000000 00000001000cb768 00000000ffffffff ffff88012fc58a70
[ 7218.538465]  ffffffff81c76ca0 0000000000000000 0000000000000003 0000000000000001
[ 7218.538473] Call Trace:
[ 7218.538480]  [<ffffffff814b0919>] ? menu_select+0xf9/0x3b0
[ 7218.538488]  [<ffffffff814af6b1>] cpuidle_idle_call+0xd1/0x1d0
[ 7218.538495]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
[ 7218.538502]  [<ffffffff815f4958>] start_secondary+0x230/0x237
[ 7218.538507] Code: c7 48 8d 86 38 e0 ff ff 83 e2 08 75 1e 31 d2 48 89 d1 0f 01 c8 0f ae f0 48 8b 86 38 e0 ff ff a8 08 75 08 b1 01 4c 89 f0 0f 01 c9 <e8> 05 cf d7 ff 4c 29 f8 48 89 c7 e8 0a 46 d5 ff 49 89 c6 49 89 
[ 7218.538564] Call Trace:
[ 7218.538570]  [<ffffffff814b0919>] ? menu_select+0xf9/0x3b0
[ 7218.538578]  [<ffffffff814af6b1>] cpuidle_idle_call+0xd1/0x1d0
[ 7218.538585]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
[ 7218.538591]  [<ffffffff815f4958>] start_secondary+0x230/0x237
[ 7218.538598] NMI backtrace for cpu 0
[ 7218.538601] CPU 0 
[ 7218.538602] Modules linked in: fuse ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack xt_CHECKSUM iptable_mangle 8021q garp sunrpc bridge stp llc binfmt_misc vhost_net macvtap macvlan tun kvm_intel kvm uinput joydev microcode serio_raw pcspkr i7core_edac edac_core i2c_i801 iTCO_wdt iTCO_vendor_support r8169 mii snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 7218.538644] 
[ 7218.538648] Pid: 0, comm: swapper/0 Not tainted 3.2.18-1.el6.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 7218.538653] RIP: 0010:[<ffffffff81325f86>]  [<ffffffff81325f86>] intel_idle+0xb6/0x150
[ 7218.538660] RSP: 0018:ffffffff81c01e48  EFLAGS: 00000046
[ 7218.538663] RAX: 0000000000000020 RBX: 0000000000000008 RCX: 0000000000000001
[ 7218.538667] RDX: 0000000000000000 RSI: ffffffff81c01fd8 RDI: ffffffff81c16100
[ 7218.538670] RBP: ffffffff81c01ea8 R08: 0000000000000000 R09: 0000000000000000
[ 7218.538673] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
[ 7218.538676] R13: ffff88012fc18a70 R14: 0000000000000020 R15: 129b8774d980e757
[ 7218.538680] FS:  0000000000000000(0000) GS:ffff88012fc00000(0000) knlGS:0000000000000000
[ 7218.538683] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 7218.538686] CR2: 000000000125a040 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 7218.538690] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 7218.538693] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 7218.538697] Process swapper/0 (pid: 0, threadinfo ffffffff81c00000, task ffffffff81c10020)
[ 7218.538699] Stack:
[ 7218.538701]  ffffffff81c01ea8 ffffffff814b0919 0000000000000000 00000000000cb63c
[ 7218.538706]  0000000000000000 00000000000cb63c 00000000ffffffff ffff88012fc18a70
[ 7218.538711]  ffffffff81c76ca0 0000000000000000 0000000000000003 0000000000000000
[ 7218.538716] Call Trace:
[ 7218.538721]  [<ffffffff814b0919>] ? menu_select+0xf9/0x3b0
[ 7218.538727]  [<ffffffff814af6b1>] cpuidle_idle_call+0xd1/0x1d0
[ 7218.538732]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
[ 7218.538737]  [<ffffffff815e2565>] rest_init+0x85/0x90
[ 7218.538743]  [<ffffffff81cf3d94>] start_kernel+0x3d3/0x3de
[ 7218.538748]  [<ffffffff81cf3346>] x86_64_start_reservations+0x131/0x135
[ 7218.538753]  [<ffffffff81cf344d>] x86_64_start_kernel+0x103/0x112
[ 7218.538756] Code: c7 48 8d 86 38 e0 ff ff 83 e2 08 75 1e 31 d2 48 89 d1 0f 01 c8 0f ae f0 48 8b 86 38 e0 ff ff a8 08 75 08 b1 01 4c 89 f0 0f 01 c9 <e8> 05 cf d7 ff 4c 29 f8 48 89 c7 e8 0a 46 d5 ff 49 89 c6 49 89 
[ 7218.538790] Call Trace:
[ 7218.538794]  [<ffffffff814b0919>] ? menu_select+0xf9/0x3b0
[ 7218.538799]  [<ffffffff814af6b1>] cpuidle_idle_call+0xd1/0x1d0
[ 7218.538804]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
[ 7218.538808]  [<ffffffff815e2565>] rest_init+0x85/0x90
[ 7218.538812]  [<ffffffff81cf3d94>] start_kernel+0x3d3/0x3de
[ 7218.538817]  [<ffffffff81cf3346>] x86_64_start_reservations+0x131/0x135
[ 7218.538822]  [<ffffffff81cf344d>] x86_64_start_kernel+0x103/0x112
[ 7218.538826] NMI backtrace for cpu 3
[ 7218.538828] CPU 3 
[ 7218.538830] Modules linked in: fuse ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack xt_CHECKSUM iptable_mangle 8021q garp sunrpc bridge stp llc binfmt_misc vhost_net macvtap macvlan tun kvm_intel kvm uinput joydev microcode serio_raw pcspkr i7core_edac edac_core i2c_i801 iTCO_wdt iTCO_vendor_support r8169 mii snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 7218.538872] 
[ 7218.538875] Pid: 0, comm: swapper/3 Not tainted 3.2.18-1.el6.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 7218.538881] RIP: 0010:[<ffffffff81325f86>]  [<ffffffff81325f86>] intel_idle+0xb6/0x150
[ 7218.538887] RSP: 0018:ffff88012285fe58  EFLAGS: 00000046
[ 7218.538890] RAX: 0000000000000020 RBX: 0000000000000008 RCX: 0000000000000001
[ 7218.538893] RDX: 0000000000000000 RSI: ffff88012285ffd8 RDI: ffffffff81c16100
[ 7218.538896] RBP: ffff88012285feb8 R08: 0000000000000000 R09: 0000000000000000
[ 7218.538899] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
[ 7218.538902] R13: ffff88012fcd8a70 R14: 0000000000000020 R15: 129b8774d9809ca4
[ 7218.538906] FS:  0000000000000000(0000) GS:ffff88012fcc0000(0000) knlGS:0000000000000000
[ 7218.538910] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 7218.538913] CR2: 00000000011f2c60 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 7218.538916] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 7218.538919] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 7218.538923] Process swapper/3 (pid: 0, threadinfo ffff88012285e000, task ffff88012285c680)
[ 7218.538925] Stack:
[ 7218.538927]  ffff88012285feb8 ffffffff814b0919 ffffffffffffffc3 000000003b8a4bca
[ 7218.538932]  ffffffffffffffc3 000000033b8a4bca 00000000ffffffff ffff88012fcd8a70
[ 7218.538937]  ffffffff81c76ca0 0000000000000000 0000000000000003 0000000000000003
[ 7218.538942] Call Trace:
[ 7218.538947]  [<ffffffff814b0919>] ? menu_select+0xf9/0x3b0
[ 7218.538953]  [<ffffffff814af6b1>] cpuidle_idle_call+0xd1/0x1d0
[ 7218.538958]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
[ 7218.538962]  [<ffffffff815f4958>] start_secondary+0x230/0x237
[ 7218.538965] Code: c7 48 8d 86 38 e0 ff ff 83 e2 08 75 1e 31 d2 48 89 d1 0f 01 c8 0f ae f0 48 8b 86 38 e0 ff ff a8 08 75 08 b1 01 4c 89 f0 0f 01 c9 <e8> 05 cf d7 ff 4c 29 f8 48 89 c7 e8 0a 46 d5 ff 49 89 c6 49 89 
[ 7218.538999] Call Trace:
[ 7218.539003]  [<ffffffff814b0919>] ? menu_select+0xf9/0x3b0
[ 7218.539009]  [<ffffffff814af6b1>] cpuidle_idle_call+0xd1/0x1d0
[ 7218.539013]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
[ 7218.539017]  [<ffffffff815f4958>] start_secondary+0x230/0x237

--------------090200050601040403020407--
