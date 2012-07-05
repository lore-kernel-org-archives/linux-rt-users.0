From: Dong Liu <dliu.cn@gmail.com>
Subject: Re: cpu stall and hyperthread
Date: Thu, 05 Jul 2012 14:48:54 -0400
Message-ID: <4FF5E196.3060003@gmail.com>
References: <4FEBCDDE.60503@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020008070302050707010006"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:32937 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055Ab2GESsw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Jul 2012 14:48:52 -0400
Received: by eeit10 with SMTP id t10so3358307eei.19
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Jul 2012 11:48:50 -0700 (PDT)
In-Reply-To: <4FEBCDDE.60503@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------020008070302050707010006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I was running the pretty new kernel on CentOS 6.2, so I thought there 
might be some API incompatible issues. So I freshly installed Fedora 16 
on the same system, and built and run  3.2.18-rt29 on it. I got the same 
cpu stalls again.

dmesg showed that it occured at the same place menu_select()


The cpu stall seems always happening when I trying to run some KVM 
guests. There might be something not working together between  KVM and 
the RT patch?

Thanks!

Dong

PS. dmesg attached.


On 6/27/12 11:22 PM, Dong Liu wrote:
> Hi,
>
> I'm running 3.4.3-rt11 and 3.2.18-rt29 on a system with Intel I7 860, I
> noticed that with hyperthread enabled, I'm getting kernel error
>
> rcu_preempt detected stalls on CPUs/tasks: { 3} (detected by 5, t=60002
> jiffies)
>
> But with hyperthread disabled, no such error.
>
> Is preempt_rt not supposed to be used with hyperthread?
>
> Thanks,
>
> Dong
>
> P.S.


--------------020008070302050707010006
Content-Type: text/plain; charset=UTF-8;
 name="fc16-cpu-stall-dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fc16-cpu-stall-dmesg.txt"

[ 1013.787101] INFO: rcu_preempt detected stalls on CPUs/tasks: { 2} (detected by 3, t=60002 jiffies)
[ 1013.787109] sending NMI to all CPUs:
[ 1013.787117] NMI backtrace for cpu 1
[ 1013.787121] CPU 1 
[ 1013.787123] Modules linked in: ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle fcoe libfcoe libfc scsi_transport_fc scsi_tgt lockd 8021q garp bridge stp llc ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep i7core_edac vhost_net snd_seq snd_seq_device snd_pcm macvtap joydev snd_timer snd soundcore iTCO_wdt iTCO_vendor_support microcode macvlan tun r8169 snd_page_alloc edac_core mii i2c_i801 serio_raw pcspkr kvm_intel kvm uinput sunrpc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 1013.787197] 
[ 1013.787202] Pid: 12, comm: ksoftirqd/1 Not tainted 3.2.18-1.fc16.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 1013.787210] RIP: 0010:[<ffffffff81061026>]  [<ffffffff81061026>] find_busiest_group+0x556/0xbb0
[ 1013.787222] RSP: 0018:ffff880122ff5b10  EFLAGS: 00000046
[ 1013.787225] RAX: ffff880122ff5e0c RBX: 0000000000000000 RCX: 0000000000000000
[ 1013.787230] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff880122920400
[ 1013.787234] RBP: ffff880122ff5c90 R08: 0000000000000001 R09: 0000000000000000
[ 1013.787238] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[ 1013.787242] R13: ffff8801228822c0 R14: 0000000000000000 R15: ffff8801228821d8
[ 1013.787247] FS:  0000000000000000(0000) GS:ffff88012fc40000(0000) knlGS:0000000000000000
[ 1013.787252] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1013.787256] CR2: 00007fcef3d6c540 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 1013.787260] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1013.787264] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1013.787269] Process ksoftirqd/1 (pid: 12, threadinfo ffff880122ff4000, task ffff880122ff2300)
[ 1013.787273] Stack:
[ 1013.787275]  0000000000000000 ffff880122ff5d70 ffff880122ff5e0c 0000000000000002
[ 1013.787283]  0000000100000000 ffff880122920400 0000000000000008 ffffffff00000000
[ 1013.787289]  0000000000000000 0000000000000000 ffff88012fc4c320 ffff880122ff5c20
[ 1013.787296] Call Trace:
[ 1013.787307]  [<ffffffff810674b9>] load_balance+0xe9/0xa60
[ 1013.787318]  [<ffffffff810eaecc>] ? force_qs_rnp+0x11c/0x160
[ 1013.787321]  [<ffffffff8105f99a>] ? dequeue_rt_stack+0x20a/0x300
[ 1013.787324]  [<ffffffff812c9bdf>] ? plist_del+0x4f/0x80
[ 1013.787327]  [<ffffffff810601d8>] ? dequeue_task_rt+0x38/0x50
[ 1013.787331]  [<ffffffff815f7f89>] __schedule+0x769/0x870
[ 1013.787334]  [<ffffffff8107a98d>] ? __do_softirq_common+0x12d/0x2b0
[ 1013.787337]  [<ffffffff815f811e>] schedule+0x2e/0xa0
[ 1013.787339]  [<ffffffff815f8768>] schedule_preempt_disabled+0x18/0x30
[ 1013.787342]  [<ffffffff8107ae15>] run_ksoftirqd+0x1a5/0x1d0
[ 1013.787345]  [<ffffffff8107ac70>] ? __thread_do_softirq+0x160/0x160
[ 1013.787349]  [<ffffffff81096c8c>] kthread+0x8c/0xa0
[ 1013.787353]  [<ffffffff8105a9d9>] ? finish_task_switch+0x49/0xf0
[ 1013.787357]  [<ffffffff81603a34>] kernel_thread_helper+0x4/0x10
[ 1013.787360]  [<ffffffff81096c00>] ? __init_kthread_worker+0x60/0x60
[ 1013.787362]  [<ffffffff81603a30>] ? gs_change+0x13/0x13
[ 1013.787364] Code: fe ff ff 48 8b 8d e0 fe ff ff 85 ff 0f 94 c3 83 bd 98 fe ff ff 02 41 0f 94 c4 74 08 84 db 0f 84 8e 02 00 00 48 8b bd a8 fe ff ff <f6> 47 4d 08 0f 84 7d 02 00 00 48 85 c9 0f 84 8b 04 00 00 48 8d 
[ 1013.787383] Call Trace:
[ 1013.787387]  [<ffffffff810674b9>] load_balance+0xe9/0xa60
[ 1013.787389]  [<ffffffff810eaecc>] ? force_qs_rnp+0x11c/0x160
[ 1013.787392]  [<ffffffff8105f99a>] ? dequeue_rt_stack+0x20a/0x300
[ 1013.787394]  [<ffffffff812c9bdf>] ? plist_del+0x4f/0x80
[ 1013.787396]  [<ffffffff810601d8>] ? dequeue_task_rt+0x38/0x50
[ 1013.787399]  [<ffffffff815f7f89>] __schedule+0x769/0x870
[ 1013.787401]  [<ffffffff8107a98d>] ? __do_softirq_common+0x12d/0x2b0
[ 1013.787404]  [<ffffffff815f811e>] schedule+0x2e/0xa0
[ 1013.787406]  [<ffffffff815f8768>] schedule_preempt_disabled+0x18/0x30
[ 1013.787408]  [<ffffffff8107ae15>] run_ksoftirqd+0x1a5/0x1d0
[ 1013.787411]  [<ffffffff8107ac70>] ? __thread_do_softirq+0x160/0x160
[ 1013.787413]  [<ffffffff81096c8c>] kthread+0x8c/0xa0
[ 1013.787416]  [<ffffffff8105a9d9>] ? finish_task_switch+0x49/0xf0
[ 1013.787419]  [<ffffffff81603a34>] kernel_thread_helper+0x4/0x10
[ 1013.787422]  [<ffffffff81096c00>] ? __init_kthread_worker+0x60/0x60
[ 1013.787424]  [<ffffffff81603a30>] ? gs_change+0x13/0x13
[ 1013.787427] NMI backtrace for cpu 4
[ 1013.787428] CPU 4 
[ 1013.787429] Modules linked in: ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle fcoe libfcoe libfc scsi_transport_fc scsi_tgt lockd 8021q garp bridge stp llc ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep i7core_edac vhost_net snd_seq snd_seq_device snd_pcm macvtap joydev snd_timer snd soundcore iTCO_wdt iTCO_vendor_support microcode macvlan tun r8169 snd_page_alloc edac_core mii i2c_i801 serio_raw pcspkr kvm_intel kvm uinput sunrpc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 1013.787457] 
[ 1013.787459] Pid: 0, comm: swapper/4 Not tainted 3.2.18-1.fc16.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 1013.787462] RIP: 0010:[<ffffffff815f7d60>]  [<ffffffff815f7d60>] __schedule+0x540/0x870
[ 1013.787466] RSP: 0018:ffff8801228a1e48  EFLAGS: 00000006
[ 1013.787468] RAX: ffff88012fd11dc0 RBX: ffff88012fd11dc0 RCX: 0000000000000004
[ 1013.787470] RDX: 0000000000000000 RSI: ffff88012289a040 RDI: ffff88012289e080
[ 1013.787472] RBP: ffff8801228a1ec8 R08: 0000000000000000 R09: 0000000000000001
[ 1013.787473] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[ 1013.787475] R13: ffff88011ddec400 R14: 0000000000000004 R15: 0000000000000000
[ 1013.787477] FS:  0000000000000000(0000) GS:ffff88012fd00000(0000) knlGS:0000000000000000
[ 1013.787479] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1013.787481] CR2: 00000000009f94f8 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 1013.787482] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1013.787484] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1013.787486] Process swapper/4 (pid: 0, threadinfo ffff8801228a0000, task ffff88012289e080)
[ 1013.787488] Stack:
[ 1013.787488]  0000000000000000 0000000000000000 ffff8801228a1fd8 ffff8801228a1fd8
[ 1013.787492]  ffff8801228a1fd8 ffff8801228a1fd8 ffff88012289a040 ffff88012289e080
[ 1013.787494]  ffff88012fd18a70 0000000000000000 ffff8801228a1ef8 ffff88012289e080
[ 1013.787497] Call Trace:
[ 1013.787500]  [<ffffffff815f811e>] schedule+0x2e/0xa0
[ 1013.787503]  [<ffffffff815f8768>] schedule_preempt_disabled+0x18/0x30
[ 1013.787507]  [<ffffffff81015248>] cpu_idle+0xe8/0x100
[ 1013.787510]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1013.787512] Code: b2 90 08 00 00 e9 f6 fc ff ff 90 48 89 df e8 c8 27 a6 ff e9 19 fc ff ff 0f 1f 00 48 8b 75 b0 4c 89 ae a8 02 00 00 f0 41 ff 45 54 <65> 8b 04 25 88 1d 01 00 83 f8 01 0f 85 1e fe ff ff 65 c7 04 25 
[ 1013.787531] Call Trace:
[ 1013.787534]  [<ffffffff815f811e>] schedule+0x2e/0xa0
[ 1013.787536]  [<ffffffff815f8768>] schedule_preempt_disabled+0x18/0x30
[ 1013.787538]  [<ffffffff81015248>] cpu_idle+0xe8/0x100
[ 1013.787541]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1013.787543] NMI backtrace for cpu 0
[ 1013.787545] CPU 0 
[ 1013.787545] Modules linked in: ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle fcoe libfcoe libfc scsi_transport_fc scsi_tgt lockd 8021q garp bridge stp llc ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep i7core_edac vhost_net snd_seq snd_seq_device snd_pcm macvtap joydev snd_timer snd soundcore iTCO_wdt iTCO_vendor_support microcode macvlan tun r8169 snd_page_alloc edac_core mii i2c_i801 serio_raw pcspkr kvm_intel kvm uinput sunrpc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 1013.787566] 
[ 1013.787567] Pid: 0, comm: swapper/0 Not tainted 3.2.18-1.fc16.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 1013.787569] RIP: 0010:[<ffffffff815f7d60>]  [<ffffffff815f7d60>] __schedule+0x540/0x870
[ 1013.787572] RSP: 0018:ffffffff81c01e28  EFLAGS: 00000006
[ 1013.787573] RAX: ffff88012fc11dc0 RBX: ffff88012fc11dc0 RCX: 0000000000000000
[ 1013.787574] RDX: 0000000000000000 RSI: ffff880122f220c0 RDI: ffffffff81c10020
[ 1013.787576] RBP: ffffffff81c01ea8 R08: 0000000000000000 R09: 0000000000000001
[ 1013.787577] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[ 1013.787578] R13: ffff8800b7f34c00 R14: 0000000000000000 R15: 000000000008c000
[ 1013.787580] FS:  0000000000000000(0000) GS:ffff88012fc00000(0000) knlGS:0000000000000000
[ 1013.787581] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1013.787582] CR2: 00007f14c421e000 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 1013.787584] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1013.787585] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1013.787587] Process swapper/0 (pid: 0, threadinfo ffffffff81c00000, task ffffffff81c10020)
[ 1013.787588] Stack:
[ 1013.787588]  0000000000000000 0000000000000000 ffffffff81c01fd8 ffffffff81c01fd8
[ 1013.787590]  ffffffff81c01fd8 ffffffff81c01fd8 ffff880122f220c0 ffffffff81c10020
[ 1013.787592]  ffff88012fc18a70 0000000000000000 ffffffff81c01ed8 ffffffff81c10020
[ 1013.787594] Call Trace:
[ 1013.787597]  [<ffffffff815f811e>] schedule+0x2e/0xa0
[ 1013.787598]  [<ffffffff815f8768>] schedule_preempt_disabled+0x18/0x30
[ 1013.787600]  [<ffffffff81015248>] cpu_idle+0xe8/0x100
[ 1013.787603]  [<ffffffff815d749c>] rest_init+0x80/0x84
[ 1013.787607]  [<ffffffff81cf3c16>] start_kernel+0x3d1/0x3de
[ 1013.787609]  [<ffffffff81cf3347>] x86_64_start_reservations+0x132/0x136
[ 1013.787611]  [<ffffffff81cf3140>] ? early_idt_handlers+0x140/0x140
[ 1013.787613]  [<ffffffff81cf344d>] x86_64_start_kernel+0x102/0x111
[ 1013.787615] Code: b2 90 08 00 00 e9 f6 fc ff ff 90 48 89 df e8 c8 27 a6 ff e9 19 fc ff ff 0f 1f 00 48 8b 75 b0 4c 89 ae a8 02 00 00 f0 41 ff 45 54 <65> 8b 04 25 88 1d 01 00 83 f8 01 0f 85 1e fe ff ff 65 c7 04 25 
[ 1013.787628] Call Trace:
[ 1013.787630]  [<ffffffff815f811e>] schedule+0x2e/0xa0
[ 1013.787631]  [<ffffffff815f8768>] schedule_preempt_disabled+0x18/0x30
[ 1013.787633]  [<ffffffff81015248>] cpu_idle+0xe8/0x100
[ 1013.787635]  [<ffffffff815d749c>] rest_init+0x80/0x84
[ 1013.787637]  [<ffffffff81cf3c16>] start_kernel+0x3d1/0x3de
[ 1013.787639]  [<ffffffff81cf3347>] x86_64_start_reservations+0x132/0x136
[ 1013.787641]  [<ffffffff81cf3140>] ? early_idt_handlers+0x140/0x140
[ 1013.787643]  [<ffffffff81cf344d>] x86_64_start_kernel+0x102/0x111
[ 1013.787645] NMI backtrace for cpu 5
[ 1013.787646] CPU 5 
[ 1013.787647] Modules linked in: ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle fcoe libfcoe libfc scsi_transport_fc scsi_tgt lockd 8021q garp bridge stp llc ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep i7core_edac vhost_net snd_seq snd_seq_device snd_pcm macvtap joydev snd_timer snd soundcore iTCO_wdt iTCO_vendor_support microcode macvlan tun r8169 snd_page_alloc edac_core mii i2c_i801 serio_raw pcspkr kvm_intel kvm uinput sunrpc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 1013.787667] 
[ 1013.787668] Pid: 0, comm: swapper/5 Not tainted 3.2.18-1.fc16.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 1013.787671] RIP: 0010:[<ffffffff8131f9b0>]  [<ffffffff8131f9b0>] intel_idle+0xc0/0x150
[ 1013.787674] RSP: 0018:ffff8801228e1e38  EFLAGS: 00000046
[ 1013.787675] RAX: 0000000000000010 RBX: 0000000000000004 RCX: 0000000000000001
[ 1013.787676] RDX: 0000000000000000 RSI: ffff8801228e1fd8 RDI: ffffffff81c160c0
[ 1013.787677] RBP: ffff8801228e1e98 R08: 0000000000000000 R09: 0000000000000001
[ 1013.787678] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
[ 1013.787680] R13: ffff88012fd58a70 R14: 0000000000000010 R15: 129dff83427e27db
[ 1013.787681] FS:  0000000000000000(0000) GS:ffff88012fd40000(0000) knlGS:0000000000000000
[ 1013.787683] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1013.787684] CR2: 00000000017fc058 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 1013.787685] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1013.787687] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1013.787688] Process swapper/5 (pid: 0, threadinfo ffff8801228e0000, task ffff8801228de200)
[ 1013.787689] Stack:
[ 1013.787690]  ffff8801228e1e98 ffffffff814a6aa9 0000000000000000 00000000000ca23b
[ 1013.787692]  0000000000000000 00000005000ca23b ffff8801228e1e98 ffff88012fd58a70
[ 1013.787694]  00000000fffffff0 0000000000000002 0000000000000005 0000000000000000
[ 1013.787696] Call Trace:
[ 1013.787699]  [<ffffffff814a6aa9>] ? menu_select+0xf9/0x380
[ 1013.787701]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1013.787704]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1013.787706]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1013.787707] Code: 28 e0 ff ff 83 e2 08 75 22 31 d2 48 83 c0 10 48 89 d1 0f 01 c8 0f ae f0 48 8b 86 38 e0 ff ff a8 08 75 08 b1 01 4c 89 f0 0f 01 c9 <e8> bb 18 d8 ff 4c 29 f8 48 89 c7 e8 c0 9b d5 ff 4c 69 f0 40 42 
[ 1013.787721] Call Trace:
[ 1013.787722]  [<ffffffff814a6aa9>] ? menu_select+0xf9/0x380
[ 1013.787724]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1013.787726]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1013.787728]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1013.787730] NMI backtrace for cpu 7
[ 1013.787731] CPU 7 
[ 1013.787732] Modules linked in: ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle fcoe libfcoe libfc scsi_transport_fc scsi_tgt lockd 8021q garp bridge stp llc ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep i7core_edac vhost_net snd_seq snd_seq_device snd_pcm macvtap joydev snd_timer snd soundcore iTCO_wdt iTCO_vendor_support microcode macvlan tun r8169 snd_page_alloc edac_core mii i2c_i801 serio_raw pcspkr kvm_intel kvm uinput sunrpc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 1013.787759] 
[ 1013.787761] Pid: 0, comm: swapper/7 Not tainted 3.2.18-1.fc16.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 1013.787764] RIP: 0010:[<ffffffff8131f9b0>]  [<ffffffff8131f9b0>] intel_idle+0xc0/0x150
[ 1013.787768] RSP: 0018:ffff880122943e38  EFLAGS: 00000046
[ 1013.787770] RAX: 0000000000000010 RBX: 0000000000000004 RCX: 0000000000000001
[ 1013.787772] RDX: 0000000000000000 RSI: ffff880122943fd8 RDI: ffffffff81c160c0
[ 1013.787773] RBP: ffff880122943e98 R08: 0000000000000000 R09: 0000000000000001
[ 1013.787775] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
[ 1013.787777] R13: ffff88012fdd8a70 R14: 0000000000000010 R15: 129dff83427ee5af
[ 1013.787779] FS:  0000000000000000(0000) GS:ffff88012fdc0000(0000) knlGS:0000000000000000
[ 1013.787781] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1013.787782] CR2: 00000000006d8a18 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 1013.787784] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1013.787786] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1013.787788] Process swapper/7 (pid: 0, threadinfo ffff880122942000, task ffff880122940500)
[ 1013.787789] Stack:
[ 1013.787790]  ffff880122943e98 ffffffff814a6aa9 0000000000000000 00000000000be1df
[ 1013.787793]  0000000000000000 00000007000be1df ffff880122943e98 ffff88012fdd8a70
[ 1013.787796]  00000000fffffff0 0000000000000002 0000000000000007 0000000000000000
[ 1013.787799] Call Trace:
[ 1013.787801]  [<ffffffff814a6aa9>] ? menu_select+0xf9/0x380
[ 1013.787804]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1013.787808]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1013.787810]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1013.787812] Code: 28 e0 ff ff 83 e2 08 75 22 31 d2 48 83 c0 10 48 89 d1 0f 01 c8 0f ae f0 48 8b 86 38 e0 ff ff a8 08 75 08 b1 01 4c 89 f0 0f 01 c9 <e8> bb 18 d8 ff 4c 29 f8 48 89 c7 e8 c0 9b d5 ff 4c 69 f0 40 42 
[ 1013.787833] Call Trace:
[ 1013.787835]  [<ffffffff814a6aa9>] ? menu_select+0xf9/0x380
[ 1013.787837]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1013.787839]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1013.787841]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1013.787843] NMI backtrace for cpu 3
[ 1013.787844] CPU 3 
[ 1013.787845] Modules linked in: ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle fcoe libfcoe libfc scsi_transport_fc scsi_tgt lockd 8021q garp bridge stp llc ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep i7core_edac vhost_net snd_seq snd_seq_device snd_pcm macvtap joydev snd_timer snd soundcore iTCO_wdt iTCO_vendor_support microcode macvlan tun r8169 snd_page_alloc edac_core mii i2c_i801 serio_raw pcspkr kvm_intel kvm uinput sunrpc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 1013.787862] 
[ 1013.787863] Pid: 0, comm: swapper/3 Not tainted 3.2.18-1.fc16.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 1013.787865] RIP: 0010:[<ffffffff812d1fd0>]  [<ffffffff812d1fd0>] __ndelay+0x30/0x30
[ 1013.787868] RSP: 0018:ffff88012fcc3c80  EFLAGS: 00000847
[ 1013.787870] RAX: 0000000043707440 RBX: 0000000000002710 RCX: 0000000000000004
[ 1013.787871] RDX: 00000000002a9c44 RSI: 0000000000000100 RDI: 00000000002a9c45
[ 1013.787872] RBP: ffff88012fcc3c88 R08: 0000000000000000 R09: 0000000000000000
[ 1013.787873] R10: 000000000000000a R11: 0000000000000000 R12: ffffffff81c35100
[ 1013.787874] R13: ffffffff81c35200 R14: 0000000000000001 R15: ffffffff81c36200
[ 1013.787875] FS:  0000000000000000(0000) GS:ffff88012fcc0000(0000) knlGS:0000000000000000
[ 1013.787877] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1013.787878] CR2: 0000000001a3f328 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 1013.787879] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1013.787880] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1013.787881] Process swapper/3 (pid: 0, threadinfo ffff88012285e000, task ffff88012285c680)
[ 1013.787882] Stack:
[ 1013.787883]  ffffffff812d1f6d ffff88012fcc3ca8 ffffffff81036262 0000000000000000
[ 1013.787885]  ffff88012fcccce0 ffff88012fcc3cf8 ffffffff810ecb08 0000000000000006
[ 1013.787886]  000000000000ea62 ffff88012fcc3cf8 0000000000000003 000000000000cce0
[ 1013.787888] Call Trace:
[ 1013.787889]  <IRQ> 
[ 1013.787891]  [<ffffffff812d1f6d>] ? __const_udelay+0x2d/0x30
[ 1013.787893]  [<ffffffff81036262>] arch_trigger_all_cpu_backtrace+0x72/0xa0
[ 1013.787896]  [<ffffffff810ecb08>] __rcu_pending+0x3b8/0x430
[ 1013.787898]  [<ffffffff810ed15a>] rcu_check_callbacks+0x2da/0x2f0
[ 1013.787901]  [<ffffffff81084c6d>] update_process_times+0x4d/0x70
[ 1013.787903]  [<ffffffff810a8eb5>] tick_sched_timer+0x65/0xc0
[ 1013.787906]  [<ffffffff8109bb86>] __run_hrtimer+0x76/0x260
[ 1013.787907]  [<ffffffff810a8e50>] ? tick_nohz_handler+0x110/0x110
[ 1013.787909]  [<ffffffff8101d6c9>] ? read_tsc+0x9/0x20
[ 1013.787911]  [<ffffffff8109c4b6>] hrtimer_interrupt+0xf6/0x250
[ 1013.787913]  [<ffffffff8103e766>] hpet_interrupt_handler+0x16/0x40
[ 1013.787915]  [<ffffffff810e5333>] handle_irq_event_percpu+0x63/0x250
[ 1013.787917]  [<ffffffff8101dc02>] ? native_sched_clock+0x22/0x80
[ 1013.787918]  [<ffffffff810e556b>] handle_irq_event+0x4b/0x70
[ 1013.787920]  [<ffffffff810e876a>] handle_edge_irq+0x7a/0x120
[ 1013.787922]  [<ffffffff81018266>] handle_irq+0x46/0xb0
[ 1013.787924]  [<ffffffff816043aa>] do_IRQ+0x5a/0xd0
[ 1013.787927]  [<ffffffff815fa82e>] common_interrupt+0x6e/0x6e
[ 1013.787927]  <EOI> 
[ 1013.787929]  [<ffffffff8131f9de>] ? intel_idle+0xee/0x150
[ 1013.787930]  [<ffffffff8131f9c0>] ? intel_idle+0xd0/0x150
[ 1013.787932]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1013.787934]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1013.787936]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1013.787937] Code: 66 66 66 90 65 48 8b 14 25 18 1d 01 00 48 8d 04 bf 48 69 d2 fa 00 00 00 48 c1 e0 02 f7 e2 48 8d 7a 01 ff 15 eb 1c 9a 00 5d c3 90 <55> 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 ec 08 66 66 66 66 
[ 1013.787949] Call Trace:
[ 1013.787949]  <IRQ>  [<ffffffff812d1f6d>] ? __const_udelay+0x2d/0x30
[ 1013.787952]  [<ffffffff81036262>] arch_trigger_all_cpu_backtrace+0x72/0xa0
[ 1013.787954]  [<ffffffff810ecb08>] __rcu_pending+0x3b8/0x430
[ 1013.787956]  [<ffffffff810ed15a>] rcu_check_callbacks+0x2da/0x2f0
[ 1013.787958]  [<ffffffff81084c6d>] update_process_times+0x4d/0x70
[ 1013.787959]  [<ffffffff810a8eb5>] tick_sched_timer+0x65/0xc0
[ 1013.787961]  [<ffffffff8109bb86>] __run_hrtimer+0x76/0x260
[ 1013.787963]  [<ffffffff810a8e50>] ? tick_nohz_handler+0x110/0x110
[ 1013.787964]  [<ffffffff8101d6c9>] ? read_tsc+0x9/0x20
[ 1013.787966]  [<ffffffff8109c4b6>] hrtimer_interrupt+0xf6/0x250
[ 1013.787967]  [<ffffffff8103e766>] hpet_interrupt_handler+0x16/0x40
[ 1013.787972]  [<ffffffff810e5333>] handle_irq_event_percpu+0x63/0x250
[ 1013.787974]  [<ffffffff8101dc02>] ? native_sched_clock+0x22/0x80
[ 1013.787976]  [<ffffffff810e556b>] handle_irq_event+0x4b/0x70
[ 1013.787977]  [<ffffffff810e876a>] handle_edge_irq+0x7a/0x120
[ 1013.787979]  [<ffffffff81018266>] handle_irq+0x46/0xb0
[ 1013.787981]  [<ffffffff816043aa>] do_IRQ+0x5a/0xd0
[ 1013.787983]  [<ffffffff815fa82e>] common_interrupt+0x6e/0x6e
[ 1013.787984]  <EOI>  [<ffffffff8131f9de>] ? intel_idle+0xee/0x150
[ 1013.787987]  [<ffffffff8131f9c0>] ? intel_idle+0xd0/0x150
[ 1013.787989]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1013.787991]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1013.787992]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1013.787995] NMI backtrace for cpu 6
[ 1013.787997] CPU 6 
[ 1013.787999] Modules linked in: ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle fcoe libfcoe libfc scsi_transport_fc scsi_tgt lockd 8021q garp bridge stp llc ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep i7core_edac vhost_net snd_seq snd_seq_device snd_pcm macvtap joydev snd_timer snd soundcore iTCO_wdt iTCO_vendor_support microcode macvlan tun r8169 snd_page_alloc edac_core mii i2c_i801 serio_raw pcspkr kvm_intel kvm uinput sunrpc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 1013.788032] 
[ 1013.788034] Pid: 0, comm: swapper/6 Not tainted 3.2.18-1.fc16.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 1013.788039] RIP: 0010:[<ffffffff8131f9b0>]  [<ffffffff8131f9b0>] intel_idle+0xc0/0x150
[ 1013.788044] RSP: 0018:ffff880122903e38  EFLAGS: 00000046
[ 1013.788046] RAX: 0000000000000020 RBX: 0000000000000008 RCX: 0000000000000001
[ 1013.788049] RDX: 0000000000000000 RSI: ffff880122903fd8 RDI: ffffffff81c160c0
[ 1013.788051] RBP: ffff880122903e98 R08: 0000000000000000 R09: 0000000000000001
[ 1013.788054] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
[ 1013.788056] R13: ffff88012fd98a70 R14: 0000000000000020 R15: 129dff83427f344a
[ 1013.788059] FS:  0000000000000000(0000) GS:ffff88012fd80000(0000) knlGS:0000000000000000
[ 1013.788062] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1013.788064] CR2: 0000000001edf1f0 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 1013.788067] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1013.788069] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1013.788072] Process swapper/6 (pid: 0, threadinfo ffff880122902000, task ffff880122900380)
[ 1013.788074] Stack:
[ 1013.788076]  ffff880122903e98 ffffffff814a6aa9 0000000000000000 00000000000b92c8
[ 1013.788080]  0000000000000000 00000006000b92c8 ffff880122903e98 ffff88012fd98a70
[ 1013.788083]  00000000fffffff0 0000000000000003 0000000000000006 0000000000000000
[ 1013.788087] Call Trace:
[ 1013.788090]  [<ffffffff814a6aa9>] ? menu_select+0xf9/0x380
[ 1013.788094]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1013.788097]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1013.788101]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1013.788103] Code: 28 e0 ff ff 83 e2 08 75 22 31 d2 48 83 c0 10 48 89 d1 0f 01 c8 0f ae f0 48 8b 86 38 e0 ff ff a8 08 75 08 b1 01 4c 89 f0 0f 01 c9 <e8> bb 18 d8 ff 4c 29 f8 48 89 c7 e8 c0 9b d5 ff 4c 69 f0 40 42 
[ 1013.788125] Call Trace:
[ 1013.788127]  [<ffffffff814a6aa9>] ? menu_select+0xf9/0x380
[ 1013.788130]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1013.788134]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1013.788140]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1013.788143] NMI backtrace for cpu 2
[ 1013.788144] CPU 2 
[ 1013.788145] Modules linked in: ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle fcoe libfcoe libfc scsi_transport_fc scsi_tgt lockd 8021q garp bridge stp llc ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep i7core_edac vhost_net snd_seq snd_seq_device snd_pcm macvtap joydev snd_timer snd soundcore iTCO_wdt iTCO_vendor_support microcode macvlan tun r8169 snd_page_alloc edac_core mii i2c_i801 serio_raw pcspkr kvm_intel kvm uinput sunrpc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 1013.788166] 
[ 1013.788167] Pid: 0, comm: swapper/2 Not tainted 3.2.18-1.fc16.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 1013.788171] RIP: 0010:[<ffffffff8131f9b0>]  [<ffffffff8131f9b0>] intel_idle+0xc0/0x150
[ 1013.788173] RSP: 0018:ffff88012281fe38  EFLAGS: 00000046
[ 1013.788175] RAX: 0000000000000020 RBX: 0000000000000008 RCX: 0000000000000001
[ 1013.788177] RDX: 0000000000000000 RSI: ffff88012281ffd8 RDI: ffffffff81c160c0
[ 1013.788178] RBP: ffff88012281fe98 R08: 0000000000000000 R09: 0000000000000001
[ 1013.788180] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
[ 1013.788181] R13: ffff88012fc98a70 R14: 0000000000000020 R15: 129dff83427ec97b
[ 1013.788183] FS:  0000000000000000(0000) GS:ffff88012fc80000(0000) knlGS:0000000000000000
[ 1013.788185] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1013.788187] CR2: 00007f718de2908c CR3: 0000000001c08000 CR4: 00000000000026e0
[ 1013.788189] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1013.788190] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1013.788192] Process swapper/2 (pid: 0, threadinfo ffff88012281e000, task ffff88012281c500)
[ 1013.788194] Stack:
[ 1013.788194]  ffff88012281fe98 ffffffff814a6aa9 ffffffffffffffc4 00000000002a1fe7
[ 1013.788197]  ffffffffffffffc4 00000002002a1fe7 000000000000f640 ffff88012fc98a70
[ 1013.788199]  00000000fffffff0 0000000000000003 0000000000000002 0000000000000000
[ 1013.788201] Call Trace:
[ 1013.788203]  [<ffffffff814a6aa9>] ? menu_select+0xf9/0x380
[ 1013.788205]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1013.788208]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1013.788210]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1013.788211] Code: 28 e0 ff ff 83 e2 08 75 22 31 d2 48 83 c0 10 48 89 d1 0f 01 c8 0f ae f0 48 8b 86 38 e0 ff ff a8 08 75 08 b1 01 4c 89 f0 0f 01 c9 <e8> bb 18 d8 ff 4c 29 f8 48 89 c7 e8 c0 9b d5 ff 4c 69 f0 40 42 
[ 1013.788225] Call Trace:
[ 1013.788227]  [<ffffffff814a6aa9>] ? menu_select+0xf9/0x380
[ 1013.788229]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1013.788231]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1013.788233]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1193.519667] INFO: rcu_preempt detected stalls on CPUs/tasks: { 2} (detected by 3, t=240034 jiffies)
[ 1193.519676] sending NMI to all CPUs:
[ 1193.519684] NMI backtrace for cpu 1
[ 1193.519687] CPU 1 
[ 1193.519689] Modules linked in: ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle fcoe libfcoe libfc scsi_transport_fc scsi_tgt lockd 8021q garp bridge stp llc ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep i7core_edac vhost_net snd_seq snd_seq_device snd_pcm macvtap joydev snd_timer snd soundcore iTCO_wdt iTCO_vendor_support microcode macvlan tun r8169 snd_page_alloc edac_core mii i2c_i801 serio_raw pcspkr kvm_intel kvm uinput sunrpc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 1193.519762] 
[ 1193.519767] Pid: 12, comm: ksoftirqd/1 Not tainted 3.2.18-1.fc16.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 1193.519775] RIP: 0010:[<ffffffff8107a944>]  [<ffffffff8107a944>] __do_softirq_common+0xe4/0x2b0
[ 1193.519788] RSP: 0018:ffff880122ff5dd0  EFLAGS: 00000282
[ 1193.519792] RAX: ffff880122ff5fd8 RBX: ffffffff81c04488 RCX: 0000000000000000
[ 1193.519797] RDX: ffff880122ff2300 RSI: 0000000000000003 RDI: ffff880122fd0000
[ 1193.519801] RBP: ffff880122ff5e40 R08: 0000000000000000 R09: 0000000000000001
[ 1193.519805] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[ 1193.519809] R13: 0000000000000101 R14: ffff880122ff5fd8 R15: 0000000000000000
[ 1193.519814] FS:  0000000000000000(0000) GS:ffff88012fc40000(0000) knlGS:0000000000000000
[ 1193.519819] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1193.519823] CR2: 00007fbe88762000 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 1193.519827] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1193.519831] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1193.519836] Process ksoftirqd/1 (pid: 12, threadinfo ffff880122ff4000, task ffff880122ff2300)
[ 1193.519840] Stack:
[ 1193.519842]  ffff880122ff5fd8 ffff880122ff5fd8 0000000100000001 ffff880122ff5fd8
[ 1193.519851]  ffff880122ff5fd8 ffff880100000000 ffff880122ff5fd8 0000000000000001
[ 1193.519853]  ffff880122ff5e40 ffff88012fc4c480 0000000000000001 000000000000c480
[ 1193.519856] Call Trace:
[ 1193.519860]  [<ffffffff8107ac25>] __thread_do_softirq+0x115/0x160
[ 1193.519863]  [<ffffffff8107ad44>] run_ksoftirqd+0xd4/0x1d0
[ 1193.519865]  [<ffffffff8107ac70>] ? __thread_do_softirq+0x160/0x160
[ 1193.519870]  [<ffffffff81096c8c>] kthread+0x8c/0xa0
[ 1193.519874]  [<ffffffff8105a9d9>] ? finish_task_switch+0x49/0xf0
[ 1193.519879]  [<ffffffff81603a34>] kernel_thread_helper+0x4/0x10
[ 1193.519882]  [<ffffffff81096c00>] ? __init_kthread_worker+0x60/0x60
[ 1193.519885]  [<ffffffff81603a30>] ? gs_change+0x13/0x13
[ 1193.519886] Code: 49 c1 ec 03 44 89 e2 48 89 55 c8 65 ff 04 95 98 c2 00 00 66 66 66 66 90 48 89 df ff 13 66 66 66 66 90 65 4c 8b 34 25 c8 a4 00 00 <8b> 45 b8 41 3b 86 44 e0 ff ff 0f 85 78 01 00 00 8b 55 a4 85 d2 
[ 1193.519905] Call Trace:
[ 1193.519908]  [<ffffffff8107ac25>] __thread_do_softirq+0x115/0x160
[ 1193.519910]  [<ffffffff8107ad44>] run_ksoftirqd+0xd4/0x1d0
[ 1193.519913]  [<ffffffff8107ac70>] ? __thread_do_softirq+0x160/0x160
[ 1193.519915]  [<ffffffff81096c8c>] kthread+0x8c/0xa0
[ 1193.519918]  [<ffffffff8105a9d9>] ? finish_task_switch+0x49/0xf0
[ 1193.519921]  [<ffffffff81603a34>] kernel_thread_helper+0x4/0x10
[ 1193.519924]  [<ffffffff81096c00>] ? __init_kthread_worker+0x60/0x60
[ 1193.519926]  [<ffffffff81603a30>] ? gs_change+0x13/0x13
[ 1193.519928] NMI backtrace for cpu 0
[ 1193.519930] CPU 0 
[ 1193.519931] Modules linked in: ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle fcoe libfcoe libfc scsi_transport_fc scsi_tgt lockd 8021q garp bridge stp llc ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep i7core_edac vhost_net snd_seq snd_seq_device snd_pcm macvtap joydev snd_timer snd soundcore iTCO_wdt iTCO_vendor_support microcode macvlan tun r8169 snd_page_alloc edac_core mii i2c_i801 serio_raw pcspkr kvm_intel kvm uinput sunrpc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 1193.519959] 
[ 1193.519961] Pid: 3, comm: ksoftirqd/0 Not tainted 3.2.18-1.fc16.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 1193.519964] RIP: 0010:[<ffffffff812d7451>]  [<ffffffff812d7451>] find_next_bit+0x1/0xd0
[ 1193.519970] RSP: 0018:ffff880122f25ad0  EFLAGS: 00000057
[ 1193.519971] RAX: 0000000000000000 RBX: ffff8800b7e7e080 RCX: 0000000000000001
[ 1193.519973] RDX: 0000000000000000 RSI: 0000000000000100 RDI: ffff88012292bfd8
[ 1193.519975] RBP: ffff880122f25bb0 R08: ffff88012fc0c530 R09: 0000000000000004
[ 1193.519976] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88012292bfd8
[ 1193.519978] R13: ffff88012292bfc0 R14: 0000000000011dc0 R15: ffff88012292a600
[ 1193.519980] FS:  0000000000000000(0000) GS:ffff88012fc00000(0000) knlGS:0000000000000000
[ 1193.519982] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1193.519984] CR2: 00007f2320016208 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 1193.519986] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1193.519987] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1193.519989] Process ksoftirqd/0 (pid: 3, threadinfo ffff880122f24000, task ffff880122f220c0)
[ 1193.519991] Stack:
[ 1193.519992]  ffff880122f25bb0 ffffffff8105e3b6 ffff880122f25b00 ffffffff812c5ac6
[ 1193.519995]  0000000000000000 0000000000000000 ffff880122f25c90 ffffffff81060c41
[ 1193.519998]  0000000000000000 ffff880122f25d70 ffff880122f25e0c 0000000000000002
[ 1193.520000] Call Trace:
[ 1193.520004]  [<ffffffff8105e3b6>] ? select_task_rq_fair+0x466/0xba0
[ 1193.520009]  [<ffffffff812c5ac6>] ? cpumask_next_and+0x36/0x50
[ 1193.520011]  [<ffffffff81060c41>] ? find_busiest_group+0x171/0xbb0
[ 1193.520014]  [<ffffffff81065781>] ? get_parent_ip+0x11/0x50
[ 1193.520017]  [<ffffffff8106828c>] try_to_wake_up+0x15c/0x3d0
[ 1193.520020]  [<ffffffff81068575>] wake_up_process+0x15/0x20
[ 1193.520022]  [<ffffffff8108e6f4>] wake_up_worker+0x24/0x30
[ 1193.520025]  [<ffffffff8108f380>] insert_work+0x70/0x80
[ 1193.520027]  [<ffffffff8108fab2>] ___queue_work+0x92/0x210
[ 1193.520030]  [<ffffffff8108fd2b>] __queue_work+0xfb/0x280
[ 1193.520033]  [<ffffffff8108feef>] delayed_work_timer_fn+0x3f/0x50
[ 1193.520036]  [<ffffffff8108369a>] run_timer_softirq+0x14a/0x480
[ 1193.520038]  [<ffffffff8108feb0>] ? __queue_work+0x280/0x280
[ 1193.520041]  [<ffffffff8107a936>] __do_softirq_common+0xd6/0x2b0
[ 1193.520044]  [<ffffffff8107ac25>] __thread_do_softirq+0x115/0x160
[ 1193.520047]  [<ffffffff8107ad44>] run_ksoftirqd+0xd4/0x1d0
[ 1193.520049]  [<ffffffff8107ac70>] ? __thread_do_softirq+0x160/0x160
[ 1193.520052]  [<ffffffff81096c8c>] kthread+0x8c/0xa0
[ 1193.520055]  [<ffffffff8105a9d9>] ? finish_task_switch+0x49/0xf0
[ 1193.520058]  [<ffffffff81603a34>] kernel_thread_helper+0x4/0x10
[ 1193.520061]  [<ffffffff81096c00>] ? __init_kthread_worker+0x60/0x60
[ 1193.520064]  [<ffffffff81603a30>] ? gs_change+0x13/0x13
[ 1193.520065] Code: 34 d7 75 18 66 0f 1f 44 00 00 48 85 d2 74 19 48 83 ea 01 48 8b 34 d7 48 85 f6 74 ee 48 c1 e2 06 48 0f bd f6 48 8d 04 32 5d c3 55 <48> 39 f2 48 89 f0 48 89 e5 73 79 48 89 d1 49 89 d1 48 c1 e9 06 
[ 1193.520084] Call Trace:
[ 1193.520087]  [<ffffffff8105e3b6>] ? select_task_rq_fair+0x466/0xba0
[ 1193.520090]  [<ffffffff812c5ac6>] ? cpumask_next_and+0x36/0x50
[ 1193.520092]  [<ffffffff81060c41>] ? find_busiest_group+0x171/0xbb0
[ 1193.520094]  [<ffffffff81065781>] ? get_parent_ip+0x11/0x50
[ 1193.520097]  [<ffffffff8106828c>] try_to_wake_up+0x15c/0x3d0
[ 1193.520100]  [<ffffffff81068575>] wake_up_process+0x15/0x20
[ 1193.520102]  [<ffffffff8108e6f4>] wake_up_worker+0x24/0x30
[ 1193.520104]  [<ffffffff8108f380>] insert_work+0x70/0x80
[ 1193.520106]  [<ffffffff8108fab2>] ___queue_work+0x92/0x210
[ 1193.520109]  [<ffffffff8108fd2b>] __queue_work+0xfb/0x280
[ 1193.520111]  [<ffffffff8108feef>] delayed_work_timer_fn+0x3f/0x50
[ 1193.520114]  [<ffffffff8108369a>] run_timer_softirq+0x14a/0x480
[ 1193.520116]  [<ffffffff8108feb0>] ? __queue_work+0x280/0x280
[ 1193.520119]  [<ffffffff8107a936>] __do_softirq_common+0xd6/0x2b0
[ 1193.520121]  [<ffffffff8107ac25>] __thread_do_softirq+0x115/0x160
[ 1193.520124]  [<ffffffff8107ad44>] run_ksoftirqd+0xd4/0x1d0
[ 1193.520126]  [<ffffffff8107ac70>] ? __thread_do_softirq+0x160/0x160
[ 1193.520129]  [<ffffffff81096c8c>] kthread+0x8c/0xa0
[ 1193.520131]  [<ffffffff8105a9d9>] ? finish_task_switch+0x49/0xf0
[ 1193.520134]  [<ffffffff81603a34>] kernel_thread_helper+0x4/0x10
[ 1193.520137]  [<ffffffff81096c00>] ? __init_kthread_worker+0x60/0x60
[ 1193.520140]  [<ffffffff81603a30>] ? gs_change+0x13/0x13
[ 1193.520141] NMI backtrace for cpu 4
[ 1193.520143] CPU 4 
[ 1193.520143] Modules linked in: ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle fcoe libfcoe libfc scsi_transport_fc scsi_tgt lockd 8021q garp bridge stp llc ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep i7core_edac vhost_net snd_seq snd_seq_device snd_pcm macvtap joydev snd_timer snd soundcore iTCO_wdt iTCO_vendor_support microcode macvlan tun r8169 snd_page_alloc edac_core mii i2c_i801 serio_raw pcspkr kvm_intel kvm uinput sunrpc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 1193.520165] 
[ 1193.520166] Pid: 28, comm: ksoftirqd/4 Not tainted 3.2.18-1.fc16.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 1193.520169] RIP: 0010:[<ffffffff812d7450>]  [<ffffffff812d7450>] find_last_bit+0x50/0x50
[ 1193.520171] RSP: 0018:ffff88012289dad8  EFLAGS: 00000057
[ 1193.520172] RAX: 0000000000000000 RBX: ffff8800b7f025c0 RCX: 0000000000000010
[ 1193.520174] RDX: 0000000000000000 RSI: 0000000000000100 RDI: ffff88012292bfd8
[ 1193.520175] RBP: ffff88012289dbb0 R08: ffff88012fd0c530 R09: 0000000000000004
[ 1193.520176] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88012292bfd8
[ 1193.520178] R13: ffff88012292bfc0 R14: 0000000000011dc0 R15: ffff88012292ce00
[ 1193.520179] FS:  0000000000000000(0000) GS:ffff88012fd00000(0000) knlGS:0000000000000000
[ 1193.520181] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1193.520182] CR2: 0000000000a00338 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 1193.520183] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1193.520185] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1193.520186] Process ksoftirqd/4 (pid: 28, threadinfo ffff88012289c000, task ffff88012289a040)
[ 1193.520187] Stack:
[ 1193.520188]  ffffffff8105e3b6 ffff88012289db00 ffffffff812c5ac6 0000000000000000
[ 1193.520190]  0000000000000000 ffff88012289dc90 ffffffff81060c41 0000000000000000
[ 1193.520192]  ffff88012289dd70 ffff88012289de0c 0000000000000002 ffff8800b7f025c0
[ 1193.520194] Call Trace:
[ 1193.520196]  [<ffffffff8105e3b6>] ? select_task_rq_fair+0x466/0xba0
[ 1193.520198]  [<ffffffff812c5ac6>] ? cpumask_next_and+0x36/0x50
[ 1193.520200]  [<ffffffff81060c41>] ? find_busiest_group+0x171/0xbb0
[ 1193.520202]  [<ffffffff81065781>] ? get_parent_ip+0x11/0x50
[ 1193.520204]  [<ffffffff8106828c>] try_to_wake_up+0x15c/0x3d0
[ 1193.520206]  [<ffffffff81068575>] wake_up_process+0x15/0x20
[ 1193.520208]  [<ffffffff8108e6f4>] wake_up_worker+0x24/0x30
[ 1193.520210]  [<ffffffff8108f380>] insert_work+0x70/0x80
[ 1193.520211]  [<ffffffff8108fab2>] ___queue_work+0x92/0x210
[ 1193.520213]  [<ffffffff8108fd2b>] __queue_work+0xfb/0x280
[ 1193.520215]  [<ffffffff8108feef>] delayed_work_timer_fn+0x3f/0x50
[ 1193.520217]  [<ffffffff8108369a>] run_timer_softirq+0x14a/0x480
[ 1193.520219]  [<ffffffff8108feb0>] ? __queue_work+0x280/0x280
[ 1193.520221]  [<ffffffff8107a936>] __do_softirq_common+0xd6/0x2b0
[ 1193.520223]  [<ffffffff8107ac25>] __thread_do_softirq+0x115/0x160
[ 1193.520225]  [<ffffffff8107ad44>] run_ksoftirqd+0xd4/0x1d0
[ 1193.520227]  [<ffffffff8107ac70>] ? __thread_do_softirq+0x160/0x160
[ 1193.520229]  [<ffffffff81096c8c>] kthread+0x8c/0xa0
[ 1193.520232]  [<ffffffff8105a9d9>] ? finish_task_switch+0x49/0xf0
[ 1193.520234]  [<ffffffff81603a34>] kernel_thread_helper+0x4/0x10
[ 1193.520236]  [<ffffffff81096c00>] ? __init_kthread_worker+0x60/0x60
[ 1193.520238]  [<ffffffff81603a30>] ? gs_change+0x13/0x13
[ 1193.520239] Code: 23 34 d7 75 18 66 0f 1f 44 00 00 48 85 d2 74 19 48 83 ea 01 48 8b 34 d7 48 85 f6 74 ee 48 c1 e2 06 48 0f bd f6 48 8d 04 32 5d c3 <55> 48 39 f2 48 89 f0 48 89 e5 73 79 48 89 d1 49 89 d1 48 c1 e9 
[ 1193.520252] Call Trace:
[ 1193.520254]  [<ffffffff8105e3b6>] ? select_task_rq_fair+0x466/0xba0
[ 1193.520256]  [<ffffffff812c5ac6>] ? cpumask_next_and+0x36/0x50
[ 1193.520258]  [<ffffffff81060c41>] ? find_busiest_group+0x171/0xbb0
[ 1193.520260]  [<ffffffff81065781>] ? get_parent_ip+0x11/0x50
[ 1193.520262]  [<ffffffff8106828c>] try_to_wake_up+0x15c/0x3d0
[ 1193.520264]  [<ffffffff81068575>] wake_up_process+0x15/0x20
[ 1193.520265]  [<ffffffff8108e6f4>] wake_up_worker+0x24/0x30
[ 1193.520267]  [<ffffffff8108f380>] insert_work+0x70/0x80
[ 1193.520269]  [<ffffffff8108fab2>] ___queue_work+0x92/0x210
[ 1193.520271]  [<ffffffff8108fd2b>] __queue_work+0xfb/0x280
[ 1193.520272]  [<ffffffff8108feef>] delayed_work_timer_fn+0x3f/0x50
[ 1193.520274]  [<ffffffff8108369a>] run_timer_softirq+0x14a/0x480
[ 1193.520276]  [<ffffffff8108feb0>] ? __queue_work+0x280/0x280
[ 1193.520278]  [<ffffffff8107a936>] __do_softirq_common+0xd6/0x2b0
[ 1193.520280]  [<ffffffff8107ac25>] __thread_do_softirq+0x115/0x160
[ 1193.520282]  [<ffffffff8107ad44>] run_ksoftirqd+0xd4/0x1d0
[ 1193.520284]  [<ffffffff8107ac70>] ? __thread_do_softirq+0x160/0x160
[ 1193.520286]  [<ffffffff81096c8c>] kthread+0x8c/0xa0
[ 1193.520288]  [<ffffffff8105a9d9>] ? finish_task_switch+0x49/0xf0
[ 1193.520290]  [<ffffffff81603a34>] kernel_thread_helper+0x4/0x10
[ 1193.520292]  [<ffffffff81096c00>] ? __init_kthread_worker+0x60/0x60
[ 1193.520294]  [<ffffffff81603a30>] ? gs_change+0x13/0x13
[ 1193.520296] NMI backtrace for cpu 7
[ 1193.520298] CPU 7 
[ 1193.520298] Modules linked in: ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle fcoe libfcoe libfc scsi_transport_fc scsi_tgt lockd 8021q garp bridge stp llc ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep i7core_edac vhost_net snd_seq snd_seq_device snd_pcm macvtap joydev snd_timer snd soundcore iTCO_wdt iTCO_vendor_support microcode macvlan tun r8169 snd_page_alloc edac_core mii i2c_i801 serio_raw pcspkr kvm_intel kvm uinput sunrpc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 1193.520326] 
[ 1193.520328] Pid: 0, comm: swapper/7 Not tainted 3.2.18-1.fc16.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 1193.520331] RIP: 0010:[<ffffffff8131f9b0>]  [<ffffffff8131f9b0>] intel_idle+0xc0/0x150
[ 1193.520335] RSP: 0018:ffff880122943e38  EFLAGS: 00000046
[ 1193.520337] RAX: 0000000000000010 RBX: 0000000000000004 RCX: 0000000000000001
[ 1193.520338] RDX: 0000000000000000 RSI: ffff880122943fd8 RDI: ffffffff81c160c0
[ 1193.520340] RBP: ffff880122943e98 R08: 0000000000000000 R09: 0000000000000001
[ 1193.520342] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
[ 1193.520343] R13: ffff88012fdd8a70 R14: 0000000000000010 R15: 129dffad2d3d8482
[ 1193.520345] FS:  0000000000000000(0000) GS:ffff88012fdc0000(0000) knlGS:0000000000000000
[ 1193.520347] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1193.520349] CR2: 00000000006d8a18 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 1193.520351] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1193.520353] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1193.520355] Process swapper/7 (pid: 0, threadinfo ffff880122942000, task ffff880122940500)
[ 1193.520356] Stack:
[ 1193.520357]  ffff880122943e98 ffffffff814a6aa9 0000000000000000 00000000000b901f
[ 1193.520360]  0000000000000000 00000007000b901f ffff880122943e98 ffff88012fdd8a70
[ 1193.520363]  00000000fffffff0 0000000000000002 0000000000000007 0000000000000000
[ 1193.520365] Call Trace:
[ 1193.520369]  [<ffffffff814a6aa9>] ? menu_select+0xf9/0x380
[ 1193.520372]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1193.520376]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1193.520380]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1193.520382] Code: 28 e0 ff ff 83 e2 08 75 22 31 d2 48 83 c0 10 48 89 d1 0f 01 c8 0f ae f0 48 8b 86 38 e0 ff ff a8 08 75 08 b1 01 4c 89 f0 0f 01 c9 <e8> bb 18 d8 ff 4c 29 f8 48 89 c7 e8 c0 9b d5 ff 4c 69 f0 40 42 
[ 1193.520401] Call Trace:
[ 1193.520403]  [<ffffffff814a6aa9>] ? menu_select+0xf9/0x380
[ 1193.520406]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1193.520408]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1193.520411]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1193.520414] NMI backtrace for cpu 5
[ 1193.520415] CPU 5 
[ 1193.520415] Modules linked in: ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle fcoe libfcoe libfc scsi_transport_fc scsi_tgt lockd 8021q garp bridge stp llc ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep i7core_edac vhost_net snd_seq snd_seq_device snd_pcm macvtap joydev snd_timer snd soundcore iTCO_wdt iTCO_vendor_support microcode macvlan tun r8169 snd_page_alloc edac_core mii i2c_i801 serio_raw pcspkr kvm_intel kvm uinput sunrpc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 1193.520435] 
[ 1193.520436] Pid: 0, comm: swapper/5 Not tainted 3.2.18-1.fc16.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 1193.520439] RIP: 0010:[<ffffffff8131f9b0>]  [<ffffffff8131f9b0>] intel_idle+0xc0/0x150
[ 1193.520441] RSP: 0018:ffff8801228e1e38  EFLAGS: 00000046
[ 1193.520443] RAX: 0000000000000010 RBX: 0000000000000004 RCX: 0000000000000001
[ 1193.520444] RDX: 0000000000000000 RSI: ffff8801228e1fd8 RDI: ffffffff81c160c0
[ 1193.520445] RBP: ffff8801228e1e98 R08: 0000000000000000 R09: 0000000000000001
[ 1193.520446] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
[ 1193.520448] R13: ffff88012fd58a70 R14: 0000000000000010 R15: 129dffad2d3ce7ba
[ 1193.520449] FS:  0000000000000000(0000) GS:ffff88012fd40000(0000) knlGS:0000000000000000
[ 1193.520451] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1193.520452] CR2: 00007eff8e593540 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 1193.520453] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1193.520454] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1193.520456] Process swapper/5 (pid: 0, threadinfo ffff8801228e0000, task ffff8801228de200)
[ 1193.520457] Stack:
[ 1193.520458]  ffff8801228e1e98 ffffffff814a6aa9 0000000000000000 00000000000c3559
[ 1193.520460]  0000000000000000 00000005000c3559 ffff8801228e1e98 ffff88012fd58a70
[ 1193.520462]  00000000fffffff0 0000000000000002 0000000000000005 0000000000000000
[ 1193.520464] Call Trace:
[ 1193.520466]  [<ffffffff814a6aa9>] ? menu_select+0xf9/0x380
[ 1193.520468]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1193.520471]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1193.520473]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1193.520475] Code: 28 e0 ff ff 83 e2 08 75 22 31 d2 48 83 c0 10 48 89 d1 0f 01 c8 0f ae f0 48 8b 86 38 e0 ff ff a8 08 75 08 b1 01 4c 89 f0 0f 01 c9 <e8> bb 18 d8 ff 4c 29 f8 48 89 c7 e8 c0 9b d5 ff 4c 69 f0 40 42 
[ 1193.520488] Call Trace:
[ 1193.520490]  [<ffffffff814a6aa9>] ? menu_select+0xf9/0x380
[ 1193.520491]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1193.520493]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1193.520495]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1193.520497] NMI backtrace for cpu 3
[ 1193.520498] CPU 3 
[ 1193.520499] Modules linked in: ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle fcoe libfcoe libfc scsi_transport_fc scsi_tgt lockd 8021q garp bridge stp llc ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep i7core_edac vhost_net snd_seq snd_seq_device snd_pcm macvtap joydev snd_timer snd soundcore iTCO_wdt iTCO_vendor_support microcode macvlan tun r8169 snd_page_alloc edac_core mii i2c_i801 serio_raw pcspkr kvm_intel kvm uinput sunrpc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 1193.520517] 
[ 1193.520518] Pid: 0, comm: swapper/3 Not tainted 3.2.18-1.fc16.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 1193.520521] RIP: 0010:[<ffffffff812d1f52>]  [<ffffffff812d1f52>] __const_udelay+0x12/0x30
[ 1193.520524] RSP: 0018:ffff88012fcc3c88  EFLAGS: 00000046
[ 1193.520526] RAX: 0000000000000000 RBX: 0000000000002710 RCX: 0000000000000004
[ 1193.520527] RDX: 00000000002a9c2f RSI: 0000000000000100 RDI: 0000000000418958
[ 1193.520528] RBP: ffff88012fcc3c88 R08: 0000000000000000 R09: 0000000000000000
[ 1193.520530] R10: 000000000000000a R11: 0000000000000000 R12: ffffffff81c35100
[ 1193.520531] R13: ffffffff81c35200 R14: 0000000000000001 R15: ffffffff81c36200
[ 1193.520532] FS:  0000000000000000(0000) GS:ffff88012fcc0000(0000) knlGS:0000000000000000
[ 1193.520534] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1193.520535] CR2: 0000000001b0e778 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 1193.520536] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1193.520538] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1193.520539] Process swapper/3 (pid: 0, threadinfo ffff88012285e000, task ffff88012285c680)
[ 1193.520540] Stack:
[ 1193.520541]  ffff88012fcc3ca8 ffffffff81036262 0000000000000000 ffff88012fcccce0
[ 1193.520543]  ffff88012fcc3cf8 ffffffff810ecb08 0000000000000006 000000000003a9a2
[ 1193.520545]  ffff88012fcc3cf8 0000000000000003 000000000000cce0 0000000000000003
[ 1193.520547] Call Trace:
[ 1193.520548]  <IRQ> 
[ 1193.520551]  [<ffffffff81036262>] arch_trigger_all_cpu_backtrace+0x72/0xa0
[ 1193.520554]  [<ffffffff810ecb08>] __rcu_pending+0x3b8/0x430
[ 1193.520556]  [<ffffffff810ed15a>] rcu_check_callbacks+0x2da/0x2f0
[ 1193.520559]  [<ffffffff81084c6d>] update_process_times+0x4d/0x70
[ 1193.520562]  [<ffffffff810a8eb5>] tick_sched_timer+0x65/0xc0
[ 1193.520564]  [<ffffffff8109bb86>] __run_hrtimer+0x76/0x260
[ 1193.520566]  [<ffffffff810a8e50>] ? tick_nohz_handler+0x110/0x110
[ 1193.520568]  [<ffffffff8101d6c9>] ? read_tsc+0x9/0x20
[ 1193.520570]  [<ffffffff8109c4b6>] hrtimer_interrupt+0xf6/0x250
[ 1193.520573]  [<ffffffff8103e766>] hpet_interrupt_handler+0x16/0x40
[ 1193.520575]  [<ffffffff810e5333>] handle_irq_event_percpu+0x63/0x250
[ 1193.520577]  [<ffffffff8101dc02>] ? native_sched_clock+0x22/0x80
[ 1193.520579]  [<ffffffff810e556b>] handle_irq_event+0x4b/0x70
[ 1193.520581]  [<ffffffff810e876a>] handle_edge_irq+0x7a/0x120
[ 1193.520583]  [<ffffffff81018266>] handle_irq+0x46/0xb0
[ 1193.520585]  [<ffffffff816043aa>] do_IRQ+0x5a/0xd0
[ 1193.520588]  [<ffffffff815fa82e>] common_interrupt+0x6e/0x6e
[ 1193.520590]  <EOI> 
[ 1193.520591]  [<ffffffff8131f9de>] ? intel_idle+0xee/0x150
[ 1193.520593]  [<ffffffff8131f9c0>] ? intel_idle+0xd0/0x150
[ 1193.520595]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1193.520598]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1193.520600]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1193.520601] Code: 66 90 ff 15 89 1d 9a 00 5d c3 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 66 66 66 66 90 65 48 8b 14 25 18 1d 01 00 <48> 8d 04 bd 00 00 00 00 48 69 d2 fa 00 00 00 f7 e2 48 8d 7a 01 
[ 1193.520615] Call Trace:
[ 1193.520615]  <IRQ>  [<ffffffff81036262>] arch_trigger_all_cpu_backtrace+0x72/0xa0
[ 1193.520619]  [<ffffffff810ecb08>] __rcu_pending+0x3b8/0x430
[ 1193.520621]  [<ffffffff810ed15a>] rcu_check_callbacks+0x2da/0x2f0
[ 1193.520623]  [<ffffffff81084c6d>] update_process_times+0x4d/0x70
[ 1193.520625]  [<ffffffff810a8eb5>] tick_sched_timer+0x65/0xc0
[ 1193.520627]  [<ffffffff8109bb86>] __run_hrtimer+0x76/0x260
[ 1193.520628]  [<ffffffff810a8e50>] ? tick_nohz_handler+0x110/0x110
[ 1193.520630]  [<ffffffff8101d6c9>] ? read_tsc+0x9/0x20
[ 1193.520632]  [<ffffffff8109c4b6>] hrtimer_interrupt+0xf6/0x250
[ 1193.520637]  [<ffffffff8103e766>] hpet_interrupt_handler+0x16/0x40
[ 1193.520638]  [<ffffffff810e5333>] handle_irq_event_percpu+0x63/0x250
[ 1193.520640]  [<ffffffff8101dc02>] ? native_sched_clock+0x22/0x80
[ 1193.520641]  [<ffffffff810e556b>] handle_irq_event+0x4b/0x70
[ 1193.520643]  [<ffffffff810e876a>] handle_edge_irq+0x7a/0x120
[ 1193.520644]  [<ffffffff81018266>] handle_irq+0x46/0xb0
[ 1193.520646]  [<ffffffff816043aa>] do_IRQ+0x5a/0xd0
[ 1193.520648]  [<ffffffff815fa82e>] common_interrupt+0x6e/0x6e
[ 1193.520649]  <EOI>  [<ffffffff8131f9de>] ? intel_idle+0xee/0x150
[ 1193.520651]  [<ffffffff8131f9c0>] ? intel_idle+0xd0/0x150
[ 1193.520653]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1193.520655]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1193.520656]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1193.520659] NMI backtrace for cpu 6
[ 1193.520660] CPU 6 
[ 1193.520661] Modules linked in: ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle fcoe libfcoe libfc scsi_transport_fc scsi_tgt lockd 8021q garp bridge stp llc ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep i7core_edac vhost_net snd_seq snd_seq_device snd_pcm macvtap joydev snd_timer snd soundcore iTCO_wdt iTCO_vendor_support microcode macvlan tun r8169 snd_page_alloc edac_core mii i2c_i801 serio_raw pcspkr kvm_intel kvm uinput sunrpc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 1193.520692] 
[ 1193.520694] Pid: 0, comm: swapper/6 Not tainted 3.2.18-1.fc16.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 1193.520699] RIP: 0010:[<ffffffff8131f9b0>]  [<ffffffff8131f9b0>] intel_idle+0xc0/0x150
[ 1193.520703] RSP: 0018:ffff880122903e38  EFLAGS: 00000046
[ 1193.520705] RAX: 0000000000000010 RBX: 0000000000000004 RCX: 0000000000000001
[ 1193.520708] RDX: 0000000000000000 RSI: ffff880122903fd8 RDI: ffffffff81c160c0
[ 1193.520710] RBP: ffff880122903e98 R08: 0000000000000000 R09: 0000000000000001
[ 1193.520713] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
[ 1193.520715] R13: ffff88012fd98a70 R14: 0000000000000010 R15: 129dffad2d3dca5c
[ 1193.520718] FS:  0000000000000000(0000) GS:ffff88012fd80000(0000) knlGS:0000000000000000
[ 1193.520721] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1193.520723] CR2: 00000000006d8a18 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 1193.520726] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1193.520728] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1193.520731] Process swapper/6 (pid: 0, threadinfo ffff880122902000, task ffff880122900380)
[ 1193.520733] Stack:
[ 1193.520734]  ffff880122903e98 ffffffff814a6aa9 0000000000000000 00000000000b4c95
[ 1193.520738]  0000000000000000 00000006000b4c95 ffff880122903e98 ffff88012fd98a70
[ 1193.520741]  00000000fffffff0 0000000000000002 0000000000000006 0000000000000000
[ 1193.520744] Call Trace:
[ 1193.520747]  [<ffffffff814a6aa9>] ? menu_select+0xf9/0x380
[ 1193.520751]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1193.520754]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1193.520757]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1193.520760] Code: 28 e0 ff ff 83 e2 08 75 22 31 d2 48 83 c0 10 48 89 d1 0f 01 c8 0f ae f0 48 8b 86 38 e0 ff ff a8 08 75 08 b1 01 4c 89 f0 0f 01 c9 <e8> bb 18 d8 ff 4c 29 f8 48 89 c7 e8 c0 9b d5 ff 4c 69 f0 40 42 
[ 1193.520779] Call Trace:
[ 1193.520781]  [<ffffffff814a6aa9>] ? menu_select+0xf9/0x380
[ 1193.520784]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1193.520787]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1193.520790]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1193.520793] NMI backtrace for cpu 2
[ 1193.520794] CPU 2 
[ 1193.520795] Modules linked in: ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_CHECKSUM iptable_mangle fcoe libfcoe libfc scsi_transport_fc scsi_tgt lockd 8021q garp bridge stp llc ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep i7core_edac vhost_net snd_seq snd_seq_device snd_pcm macvtap joydev snd_timer snd soundcore iTCO_wdt iTCO_vendor_support microcode macvlan tun r8169 snd_page_alloc edac_core mii i2c_i801 serio_raw pcspkr kvm_intel kvm uinput sunrpc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
[ 1193.520816] 
[ 1193.520817] Pid: 0, comm: swapper/2 Not tainted 3.2.18-1.fc16.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
[ 1193.520820] RIP: 0010:[<ffffffff8131f9b0>]  [<ffffffff8131f9b0>] intel_idle+0xc0/0x150
[ 1193.520822] RSP: 0018:ffff88012281fe38  EFLAGS: 00000046
[ 1193.520824] RAX: 0000000000000020 RBX: 0000000000000008 RCX: 0000000000000001
[ 1193.520825] RDX: 0000000000000000 RSI: ffff88012281ffd8 RDI: ffffffff81c160c0
[ 1193.520826] RBP: ffff88012281fe98 R08: 0000000000000000 R09: 0000000000000001
[ 1193.520828] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
[ 1193.520829] R13: ffff88012fc98a70 R14: 0000000000000020 R15: 129dffad2d3d5f5a
[ 1193.520831] FS:  0000000000000000(0000) GS:ffff88012fc80000(0000) knlGS:0000000000000000
[ 1193.520833] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 1193.520834] CR2: 0000000002701e00 CR3: 0000000001c08000 CR4: 00000000000026e0
[ 1193.520835] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1193.520837] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 1193.520838] Process swapper/2 (pid: 0, threadinfo ffff88012281e000, task ffff88012281c500)
[ 1193.520839] Stack:
[ 1193.520840]  ffff88012281fe98 ffffffff814a6aa9 ffffffffffffff11 00000000314709df
[ 1193.520842]  ffffffffffffff11 00000002314709df 000000000000f640 ffff88012fc98a70
[ 1193.520845]  00000000fffffff0 0000000000000003 0000000000000002 0000000000000000
[ 1193.520847] Call Trace:
[ 1193.520849]  [<ffffffff814a6aa9>] ? menu_select+0xf9/0x380
[ 1193.520851]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1193.520853]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1193.520855]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254
[ 1193.520856] Code: 28 e0 ff ff 83 e2 08 75 22 31 d2 48 83 c0 10 48 89 d1 0f 01 c8 0f ae f0 48 8b 86 38 e0 ff ff a8 08 75 08 b1 01 4c 89 f0 0f 01 c9 <e8> bb 18 d8 ff 4c 29 f8 48 89 c7 e8 c0 9b d5 ff 4c 69 f0 40 42 
[ 1193.520870] Call Trace:
[ 1193.520871]  [<ffffffff814a6aa9>] ? menu_select+0xf9/0x380
[ 1193.520873]  [<ffffffff814a5631>] cpuidle_idle_call+0xc1/0x350
[ 1193.520875]  [<ffffffff8101520a>] cpu_idle+0xaa/0x100
[ 1193.520877]  [<ffffffff815e8fb3>] start_secondary+0x24d/0x254

--------------020008070302050707010006--
