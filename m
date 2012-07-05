From: Dong Liu <dliu.cn@gmail.com>
Subject: Re: cpu stall and hyperthread
Date: Thu, 05 Jul 2012 14:41:32 -0400
Message-ID: <4FF5DFDC.9010501@gmail.com>
References: <4FEBCDDE.60503@gmail.com> <4FF351C6.3000100@gmail.com> <4FF4C94A.6040105@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000109070805040001050703"
Cc: linux-rt-users@vger.kernel.org
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44066 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792Ab2GESl3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Jul 2012 14:41:29 -0400
Received: by eeit10 with SMTP id t10so3356223eei.19
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Jul 2012 11:41:28 -0700 (PDT)
In-Reply-To: <4FF4C94A.6040105@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000109070805040001050703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Carsten,

I tried to disable CONFIG_RT_GROUP_SCHED, but I still got cpu stalls!

Is there a recommended config for the RT patch?

kernel msg attached, it looks like that the stall occurred at the same 
place "menu_select"

Thanks,

Dong

On 7/4/12 6:52 PM, Carsten Emde wrote:
> Dong Liu,
>
>> [..]
>> BUG: soft lockup - CPU#0 stuck for 279s! [swapper/0:0]
> Just a wild guess: Please check your configuration for
> CONFIG_RT_GROUP_SCHED=y. Is it there? If so, disable it and try whether
> this solves your problem.
>
> -Carsten.


--------------000109070805040001050703
Content-Type: text/plain; charset=UTF-8;
 name="no-rt-group-sched-stalls.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="no-rt-group-sched-stalls.txt"

Jul  5 01:05:31 upmc-svr1 kernel: [  130.606416] INFO: rcu_preempt detected stalls on CPUs/tasks: { 3} (detected by 2, t=60002 jiffies)
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606424] sending NMI to all CPUs:
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606478] NMI backtrace for cpu 6
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606481] CPU 6 
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606483] Modules linked in: ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack xt_CHECKSUM iptable_mangle 8021q garp sunrpc bridge stp llc binfmt_misc vhost_net macvtap macvlan tun kvm_intel kvm uinput joydev microcode serio_raw pcspkr i7core_edac edac_core i2c_i801 iTCO_wdt iTCO_vendor_support r8169 mii snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606553] 
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606557] Pid: 0, comm: swapper/6 Not tainted 3.2.18-3.el6.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606563] RIP: 0010:[<ffffffff81324d76>]  [<ffffffff81324d76>] intel_idle+0xb6/0x150
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606573] RSP: 0018:ffff880122903e58  EFLAGS: 00000046
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606576] RAX: 0000000000000020 RBX: 0000000000000008 RCX: 0000000000000001
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606579] RDX: 0000000000000000 RSI: ffff880122903fd8 RDI: ffffffff81c16100
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606582] RBP: ffff880122903eb8 R08: 0000000000000000 R09: 0000000000000000
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606586] R10: 00000002fc14952a R11: 0000000000000002 R12: 0000000000000003
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606589] R13: ffff88012fd98a70 R14: 0000000000000020 R15: 129dd6d92c4690d9
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606593] FS:  0000000000000000(0000) GS:ffff88012fd80000(0000) knlGS:0000000000000000
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606597] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606600] CR2: 00007f1976ba8e30 CR3: 0000000001c08000 CR4: 00000000000026e0
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606603] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606607] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606611] Process swapper/6 (pid: 0, threadinfo ffff880122902000, task ffff880122900380)
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606613] Stack:
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606615]  ffff880122903eb8 ffffffff814af709 0000000000000000 00000000000c60bf
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606621]  0000000000000000 00000006000c60bf 00000000ffffffff ffff88012fd98a70
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606627]  ffffffff81c76b20 0000000000000000 0000000000000003 0000000000000006
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606632] Call Trace:
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606639]  [<ffffffff814af709>] ? menu_select+0xf9/0x3b0
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606645]  [<ffffffff814ae4a1>] cpuidle_idle_call+0xd1/0x1d0
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606652]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606658]  [<ffffffff815f3738>] start_secondary+0x230/0x237
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606661] Code: c7 48 8d 86 38 e0 ff ff 83 e2 08 75 1e 31 d2 48 89 d1 0f 01 c8 0f ae f0 48 8b 86 38 e0 ff ff a8 08 75 08 b1 01 4c 89 f0 0f 01 c9 <e8> 15 cf d7 ff 4c 29 f8 48 89 c7 e8 1a 46 d5 ff 49 89 c6 49 89 
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606699] Call Trace:
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606703]  [<ffffffff814af709>] ? menu_select+0xf9/0x3b0
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606708]  [<ffffffff814ae4a1>] cpuidle_idle_call+0xd1/0x1d0
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606713]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606717]  [<ffffffff815f3738>] start_secondary+0x230/0x237
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606722] NMI backtrace for cpu 7
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606725] CPU 7 
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606727] Modules linked in: ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack xt_CHECKSUM iptable_mangle 8021q garp sunrpc bridge stp llc binfmt_misc vhost_net macvtap macvlan tun kvm_intel kvm uinput joydev microcode serio_raw pcspkr i7core_edac edac_core i2c_i801 iTCO_wdt iTCO_vendor_support r8169 mii snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606773] 
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606777] Pid: 0, comm: swapper/7 Not tainted 3.2.18-3.el6.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606783] RIP: 0010:[<ffffffff81324d76>]  [<ffffffff81324d76>] intel_idle+0xb6/0x150
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606790] RSP: 0018:ffff880122943e58  EFLAGS: 00000046
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606794] RAX: 0000000000000010 RBX: 0000000000000004 RCX: 0000000000000001
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606797] RDX: 0000000000000000 RSI: ffff880122943fd8 RDI: ffffffff81c16100
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606800] RBP: ffff880122943eb8 R08: 0000000000000000 R09: 0000000000000000
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606803] R10: 000000001e4a6002 R11: 0000000000000002 R12: 0000000000000002
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606807] R13: ffff88012fdd8a70 R14: 0000000000000010 R15: 129dd6d92c4696f8
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606811] FS:  0000000000000000(0000) GS:ffff88012fdc0000(0000) knlGS:0000000000000000
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606814] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606818] CR2: 00007fb094d1b000 CR3: 0000000001c08000 CR4: 00000000000026e0
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606821] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606824] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606828] Process swapper/7 (pid: 0, threadinfo ffff880122942000, task ffff880122940500)
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606831] Stack:
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606833]  ffff880122943eb8 ffffffff814af709 0000000000000000 00000000000c5e6a
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606838]  0000000000000000 00000007000c5e6a 00000000ffffffff ffff88012fdd8a70
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606843]  ffffffff81c76b20 0000000000000000 0000000000000002 0000000000000007
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606849] Call Trace:
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606854]  [<ffffffff814af709>] ? menu_select+0xf9/0x3b0
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606860]  [<ffffffff814ae4a1>] cpuidle_idle_call+0xd1/0x1d0
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606866]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606871]  [<ffffffff815f3738>] start_secondary+0x230/0x237
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606875] Code: c7 48 8d 86 38 e0 ff ff 83 e2 08 75 1e 31 d2 48 89 d1 0f 01 c8 0f ae f0 48 8b 86 38 e0 ff ff a8 08 75 08 b1 01 4c 89 f0 0f 01 c9 <e8> 15 cf d7 ff 4c 29 f8 48 89 c7 e8 1a 46 d5 ff 49 89 c6 49 89 
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606912] Call Trace:
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606916]  [<ffffffff814af709>] ? menu_select+0xf9/0x3b0
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606921]  [<ffffffff814ae4a1>] cpuidle_idle_call+0xd1/0x1d0
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606926]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606930]  [<ffffffff815f3738>] start_secondary+0x230/0x237
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606935] NMI backtrace for cpu 3
Jul  5 01:05:31 upmc-svr1 kernel: [  130.606937] CPU 3 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.606940] Modules linked in: ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack xt_CHECKSUM iptable_mangle 8021q garp sunrpc bridge stp llc binfmt_misc vhost_net macvtap macvlan tun kvm_intel kvm uinput joydev microcode serio_raw pcspkr i7core_edac edac_core i2c_i801 iTCO_wdt iTCO_vendor_support r8169 mii snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
Jul  5 01:05:32 upmc-svr1 kernel: [  130.606978] 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.606981] Pid: 0, comm: swapper/3 Not tainted 3.2.18-3.el6.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
Jul  5 01:05:32 upmc-svr1 kernel: [  130.606985] RIP: 0010:[<ffffffff81324d76>]  [<ffffffff81324d76>] intel_idle+0xb6/0x150
Jul  5 01:05:32 upmc-svr1 kernel: [  130.606990] RSP: 0018:ffff88012285fe58  EFLAGS: 00000046
Jul  5 01:05:32 upmc-svr1 kernel: [  130.606992] RAX: 0000000000000020 RBX: 0000000000000008 RCX: 0000000000000001
Jul  5 01:05:32 upmc-svr1 kernel: [  130.606995] RDX: 0000000000000000 RSI: ffff88012285ffd8 RDI: ffffffff81c16100
Jul  5 01:05:32 upmc-svr1 kernel: [  130.606997] RBP: ffff88012285feb8 R08: 0000000000000000 R09: 0000000000000000
Jul  5 01:05:32 upmc-svr1 kernel: [  130.606999] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607002] R13: ffff88012fcd8a70 R14: 0000000000000020 R15: 129dd6d92c463b5c
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607004] FS:  0000000000000000(0000) GS:ffff88012fcc0000(0000) knlGS:0000000000000000
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607007] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607009] CR2: 00000000006d43c4 CR3: 0000000001c08000 CR4: 00000000000026e0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607012] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607014] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607017] Process swapper/3 (pid: 0, threadinfo ffff88012285e000, task ffff88012285c680)
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607019] Stack:
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607020]  ffff88012285feb8 ffffffff814af709 ffffffffffffffc3 0000000005f43cb6
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607024]  ffffffffffffffc3 0000000305f43cb6 00000000ffffffff ffff88012fcd8a70
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607028]  ffffffff81c76b20 0000000000000000 0000000000000003 0000000000000003
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607031] Call Trace:
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607035]  [<ffffffff814af709>] ? menu_select+0xf9/0x3b0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607039]  [<ffffffff814ae4a1>] cpuidle_idle_call+0xd1/0x1d0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607043]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607046]  [<ffffffff815f3738>] start_secondary+0x230/0x237
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607049] Code: c7 48 8d 86 38 e0 ff ff 83 e2 08 75 1e 31 d2 48 89 d1 0f 01 c8 0f ae f0 48 8b 86 38 e0 ff ff a8 08 75 08 b1 01 4c 89 f0 0f 01 c9 <e8> 15 cf d7 ff 4c 29 f8 48 89 c7 e8 1a 46 d5 ff 49 89 c6 49 89 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607074] Call Trace:
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607077]  [<ffffffff814af709>] ? menu_select+0xf9/0x3b0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607081]  [<ffffffff814ae4a1>] cpuidle_idle_call+0xd1/0x1d0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607084]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607087]  [<ffffffff815f3738>] start_secondary+0x230/0x237
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607091] NMI backtrace for cpu 2
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607092] CPU 2 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607093] Modules linked in: ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack xt_CHECKSUM iptable_mangle 8021q garp sunrpc bridge stp llc binfmt_misc vhost_net macvtap macvlan tun kvm_intel kvm uinput joydev microcode serio_raw pcspkr i7core_edac edac_core i2c_i801 iTCO_wdt iTCO_vendor_support r8169 mii snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607140] 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607144] Pid: 0, comm: swapper/2 Not tainted 3.2.18-3.el6.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607150] RIP: 0010:[<ffffffff812d68a4>]  [<ffffffff812d68a4>] delay_tsc+0x64/0xf0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607157] RSP: 0018:ffff88012fc83c48  EFLAGS: 00000046
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607160] RAX: 0000000400000000 RBX: 00000000b886f88b RCX: 00000000b8876797
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607163] RDX: 000000000000005d RSI: 0000000000000000 RDI: 0000000000000001
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607166] RBP: ffff88012fc83c78 R08: 0000000000000004 R09: 000000000000000a
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607169] R10: 0000000000000006 R11: 0000000000000001 R12: ffff88012281e010
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607172] R13: 00000000002a9c55 R14: 0000000000000002 R15: 00000000b8876797
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607176] FS:  0000000000000000(0000) GS:ffff88012fc80000(0000) knlGS:0000000000000000
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607180] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607183] CR2: 00007fc3f21d7210 CR3: 0000000001c08000 CR4: 00000000000026e0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607186] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607189] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607193] Process swapper/2 (pid: 0, threadinfo ffff88012281e000, task ffff88012281c500)
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607195] Stack:
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607197]  0000000000000046 0000000000000001 ffffffff81c37380 ffffffff81c37480
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607202]  0000000000000001 ffffffff81c38480 ffff88012fc83c88 ffffffff812d683d
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607207]  ffff88012fc83ca8 ffffffff81035a2d 000000000000fffb ffff88012fc8cf40
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607212] Call Trace:
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607214]  <IRQ> 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607218]  [<ffffffff812d683d>] __const_udelay+0x2d/0x30
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607225]  [<ffffffff81035a2d>] arch_trigger_all_cpu_backtrace+0x6d/0xa0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607232]  [<ffffffff810ef4df>] __rcu_pending+0x40f/0x510
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607238]  [<ffffffff810ef88a>] rcu_check_callbacks+0x2aa/0x2c0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607244]  [<ffffffff81082cbd>] update_process_times+0x4d/0x70
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607251]  [<ffffffff810a9973>] tick_sched_timer+0x63/0xc0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607257]  [<ffffffff8109c486>] __run_hrtimer+0x76/0x270
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607262]  [<ffffffff810a9910>] ? tick_nohz_handler+0x110/0x110
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607267]  [<ffffffff8109c960>] hrtimer_interrupt+0xf0/0x230
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607274]  [<ffffffff8105e1dd>] ? enqueue_task_rt+0x14d/0x200
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607280]  [<ffffffff8103e2b6>] hpet_interrupt_handler+0x16/0x40
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607285]  [<ffffffff810e7482>] handle_irq_event_percpu+0x72/0x220
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607290]  [<ffffffff810e767b>] handle_irq_event+0x4b/0x70
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607296]  [<ffffffff810eae20>] handle_edge_irq+0x80/0x140
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607300]  [<ffffffff810173c6>] handle_irq+0x46/0xb0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607307]  [<ffffffff81605a2d>] do_IRQ+0x5d/0xe0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607314]  [<ffffffff815fbeee>] common_interrupt+0x6e/0x6e
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607317]  <EOI> 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607321]  [<ffffffff81324da0>] ? intel_idle+0xe0/0x150
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607326]  [<ffffffff81324d86>] ? intel_idle+0xc6/0x150
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607331]  [<ffffffff814ae4a1>] cpuidle_idle_call+0xd1/0x1d0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607336]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607340]  [<ffffffff815f3738>] start_secondary+0x230/0x237
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607344] Code: 4c 8b 24 25 48 a4 00 00 89 c3 49 81 ec c8 1f 00 00 eb 2c 0f 1f 40 00 bf 01 00 00 00 e8 36 89 32 00 49 8b 04 24 a8 08 75 5a f3 90 <bf> 01 00 00 00 e8 f2 89 32 00 e8 1d 70 00 00 41 39 c6 75 4b 66 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607386] Call Trace:
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607388]  <IRQ>  [<ffffffff812d683d>] __const_udelay+0x2d/0x30
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607401]  [<ffffffff81035a2d>] arch_trigger_all_cpu_backtrace+0x6d/0xa0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607406]  [<ffffffff810ef4df>] __rcu_pending+0x40f/0x510
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607412]  [<ffffffff810ef88a>] rcu_check_callbacks+0x2aa/0x2c0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607417]  [<ffffffff81082cbd>] update_process_times+0x4d/0x70
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607422]  [<ffffffff810a9973>] tick_sched_timer+0x63/0xc0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607426]  [<ffffffff8109c486>] __run_hrtimer+0x76/0x270
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607431]  [<ffffffff810a9910>] ? tick_nohz_handler+0x110/0x110
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607435]  [<ffffffff8109c960>] hrtimer_interrupt+0xf0/0x230
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607441]  [<ffffffff8105e1dd>] ? enqueue_task_rt+0x14d/0x200
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607445]  [<ffffffff8103e2b6>] hpet_interrupt_handler+0x16/0x40
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607450]  [<ffffffff810e7482>] handle_irq_event_percpu+0x72/0x220
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607455]  [<ffffffff810e767b>] handle_irq_event+0x4b/0x70
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607460]  [<ffffffff810eae20>] handle_edge_irq+0x80/0x140
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607464]  [<ffffffff810173c6>] handle_irq+0x46/0xb0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607469]  [<ffffffff81605a2d>] do_IRQ+0x5d/0xe0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607474]  [<ffffffff815fbeee>] common_interrupt+0x6e/0x6e
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607476]  <EOI>  [<ffffffff81324da0>] ? intel_idle+0xe0/0x150
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607484]  [<ffffffff81324d86>] ? intel_idle+0xc6/0x150
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607489]  [<ffffffff814ae4a1>] cpuidle_idle_call+0xd1/0x1d0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607494]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607498]  [<ffffffff815f3738>] start_secondary+0x230/0x237
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607504] NMI backtrace for cpu 0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607508] CPU 0 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607511] Modules linked in: ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack xt_CHECKSUM iptable_mangle 8021q garp sunrpc bridge stp llc binfmt_misc vhost_net macvtap macvlan tun kvm_intel kvm uinput joydev microcode serio_raw pcspkr i7core_edac edac_core i2c_i801 iTCO_wdt iTCO_vendor_support r8169 mii snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607571] 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607575] Pid: 0, comm: swapper/0 Not tainted 3.2.18-3.el6.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607583] RIP: 0010:[<ffffffff8103dd2c>]  [<ffffffff8103dd2c>] hpet_msi_next_event+0x1c/0x50
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607593] RSP: 0018:ffff88012fc03db8  EFLAGS: 00000002
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607597] RAX: 0000000000000002 RBX: ffff88012241b000 RCX: 0000000000000020
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607602] RDX: 000000006fa8b1a6 RSI: ffff88012241b000 RDI: 000000000000333e
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607606] RBP: ffff88012fc03db8 R08: 00000000000f4240 R09: 0000001e699e4940
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607610] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607615] R13: 00000000000dfadd R14: 0000001e69ad8b80 R15: 0000001e69ad8b80
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607620] FS:  0000000000000000(0000) GS:ffff88012fc00000(0000) knlGS:0000000000000000
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607625] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607629] CR2: 0000003643a13000 CR3: 0000000001c08000 CR4: 00000000000026e0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607634] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607638] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607643] Process swapper/0 (pid: 0, threadinfo ffffffff81c00000, task ffffffff81c10020)
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607647] Stack:
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607649]  ffff88012fc03de8 ffffffff810a7e34 ffff88012fc03df8 ffff88012fc0c9d0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607657]  0000000000000000 ffff88012fc0c8e0 ffff88012fc03df8 ffffffff810a92d4
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607664]  ffff88012fc03e78 ffffffff8109c9b9 0000000000000001 ffff88012fc0caa0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607671] Call Trace:
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607674]  <IRQ> 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607681]  [<ffffffff810a7e34>] clockevents_program_event+0x74/0x120
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607688]  [<ffffffff810a92d4>] tick_program_event+0x24/0x30
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607695]  [<ffffffff8109c9b9>] hrtimer_interrupt+0x149/0x230
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607703]  [<ffffffff8105e1dd>] ? enqueue_task_rt+0x14d/0x200
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607710]  [<ffffffff8103e2b6>] hpet_interrupt_handler+0x16/0x40
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607717]  [<ffffffff810e7482>] handle_irq_event_percpu+0x72/0x220
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607724]  [<ffffffff810e767b>] handle_irq_event+0x4b/0x70
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607730]  [<ffffffff810eae20>] handle_edge_irq+0x80/0x140
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607737]  [<ffffffff810173c6>] handle_irq+0x46/0xb0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607744]  [<ffffffff81605a2d>] do_IRQ+0x5d/0xe0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607752]  [<ffffffff815fbeee>] common_interrupt+0x6e/0x6e
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607755]  <EOI> 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607761]  [<ffffffff81324da0>] ? intel_idle+0xe0/0x150
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607767]  [<ffffffff81324d86>] ? intel_idle+0xc6/0x150
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607775]  [<ffffffff814ae4a1>] cpuidle_idle_call+0xd1/0x1d0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607781]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607789]  [<ffffffff815e1345>] rest_init+0x85/0x90
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607797]  [<ffffffff81cf3d94>] start_kernel+0x3d3/0x3de
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607804]  [<ffffffff81cf3346>] x86_64_start_reservations+0x131/0x135
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607810]  [<ffffffff81cf344d>] x86_64_start_kernel+0x103/0x112
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607814] Code: 46 04 00 00 00 00 c9 c3 0f 1f 80 00 00 00 00 55 48 89 e5 66 66 66 66 90 48 8b 15 e0 e0 ea 00 8b 86 c0 00 00 00 8b 92 f0 00 00 00 <c1> e0 05 8d 3c 3a 05 08 01 00 00 89 c0 48 03 05 c0 e0 ea 00 89 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607864] Call Trace:
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607866]  <IRQ>  [<ffffffff810a7e34>] clockevents_program_event+0x74/0x120
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607877]  [<ffffffff810a92d4>] tick_program_event+0x24/0x30
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607884]  [<ffffffff8109c9b9>] hrtimer_interrupt+0x149/0x230
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607891]  [<ffffffff8105e1dd>] ? enqueue_task_rt+0x14d/0x200
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607897]  [<ffffffff8103e2b6>] hpet_interrupt_handler+0x16/0x40
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607903]  [<ffffffff810e7482>] handle_irq_event_percpu+0x72/0x220
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607910]  [<ffffffff810e767b>] handle_irq_event+0x4b/0x70
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607916]  [<ffffffff810eae20>] handle_edge_irq+0x80/0x140
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607923]  [<ffffffff810173c6>] handle_irq+0x46/0xb0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607929]  [<ffffffff81605a2d>] do_IRQ+0x5d/0xe0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607935]  [<ffffffff815fbeee>] common_interrupt+0x6e/0x6e
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607938]  <EOI>  [<ffffffff81324da0>] ? intel_idle+0xe0/0x150
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607949]  [<ffffffff81324d86>] ? intel_idle+0xc6/0x150
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607956]  [<ffffffff814ae4a1>] cpuidle_idle_call+0xd1/0x1d0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607962]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607968]  [<ffffffff815e1345>] rest_init+0x85/0x90
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607974]  [<ffffffff81cf3d94>] start_kernel+0x3d3/0x3de
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607981]  [<ffffffff81cf3346>] x86_64_start_reservations+0x131/0x135
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607987]  [<ffffffff81cf344d>] x86_64_start_kernel+0x103/0x112
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607993] NMI backtrace for cpu 4
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607996] CPU 4 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.607998] Modules linked in: ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack xt_CHECKSUM iptable_mangle 8021q garp sunrpc bridge stp llc binfmt_misc vhost_net macvtap macvlan tun kvm_intel kvm uinput joydev microcode serio_raw pcspkr i7core_edac edac_core i2c_i801 iTCO_wdt iTCO_vendor_support r8169 mii snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608048] 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608051] Pid: 0, comm: swapper/4 Not tainted 3.2.18-3.el6.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608057] RIP: 0010:[<ffffffff8103dd2c>]  [<ffffffff8103dd2c>] hpet_msi_next_event+0x1c/0x50
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608064] RSP: 0018:ffff88012fd03db8  EFLAGS: 00000002
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608067] RAX: 0000000000000006 RBX: ffff88012241b400 RCX: 0000000000000020
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608070] RDX: 000000006fa8ae32 RSI: ffff88012241b400 RDI: 000000000000333e
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608073] RBP: ffff88012fd03db8 R08: 00000000000f4240 R09: 0000001e699e4940
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608076] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608079] R13: 00000000000dfad7 R14: 0000001e69ad8b80 R15: 0000001e69ad8b80
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608083] FS:  0000000000000000(0000) GS:ffff88012fd00000(0000) knlGS:0000000000000000
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608087] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608090] CR2: 00007f34268e20a0 CR3: 0000000001c08000 CR4: 00000000000026e0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608093] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608096] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608100] Process swapper/4 (pid: 0, threadinfo ffff8801228a0000, task ffff88012289e080)
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608102] Stack:
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608104]  ffff88012fd03de8 ffffffff810a7e34 ffff88012fd03df8 ffff88012fd0c9d0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608109]  0000000000000000 ffff88012fd0c8e0 ffff88012fd03df8 ffffffff810a92d4
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608114]  ffff88012fd03e78 ffffffff8109c9b9 0000000000000001 ffff88012fd0caa0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608119] Call Trace:
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608121]  <IRQ> 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608125]  [<ffffffff810a7e34>] clockevents_program_event+0x74/0x120
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608131]  [<ffffffff810a92d4>] tick_program_event+0x24/0x30
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608135]  [<ffffffff8109c9b9>] hrtimer_interrupt+0x149/0x230
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608141]  [<ffffffff8105e1dd>] ? enqueue_task_rt+0x14d/0x200
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608146]  [<ffffffff8103e2b6>] hpet_interrupt_handler+0x16/0x40
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608151]  [<ffffffff810e7482>] handle_irq_event_percpu+0x72/0x220
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608156]  [<ffffffff810e767b>] handle_irq_event+0x4b/0x70
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608161]  [<ffffffff810eae20>] handle_edge_irq+0x80/0x140
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608165]  [<ffffffff810173c6>] handle_irq+0x46/0xb0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608170]  [<ffffffff81605a2d>] do_IRQ+0x5d/0xe0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608175]  [<ffffffff815fbeee>] common_interrupt+0x6e/0x6e
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608178]  <EOI> 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608182]  [<ffffffff81324da0>] ? intel_idle+0xe0/0x150
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608187]  [<ffffffff81324d86>] ? intel_idle+0xc6/0x150
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608192]  [<ffffffff814ae4a1>] cpuidle_idle_call+0xd1/0x1d0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608197]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608201]  [<ffffffff815f3738>] start_secondary+0x230/0x237
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608205] Code: 46 04 00 00 00 00 c9 c3 0f 1f 80 00 00 00 00 55 48 89 e5 66 66 66 66 90 48 8b 15 e0 e0 ea 00 8b 86 c0 00 00 00 8b 92 f0 00 00 00 <c1> e0 05 8d 3c 3a 05 08 01 00 00 89 c0 48 03 05 c0 e0 ea 00 89 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608238] Call Trace:
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608240]  <IRQ>  [<ffffffff810a7e34>] clockevents_program_event+0x74/0x120
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608248]  [<ffffffff810a92d4>] tick_program_event+0x24/0x30
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608253]  [<ffffffff8109c9b9>] hrtimer_interrupt+0x149/0x230
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608258]  [<ffffffff8105e1dd>] ? enqueue_task_rt+0x14d/0x200
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608263]  [<ffffffff8103e2b6>] hpet_interrupt_handler+0x16/0x40
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608268]  [<ffffffff810e7482>] handle_irq_event_percpu+0x72/0x220
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608273]  [<ffffffff810e767b>] handle_irq_event+0x4b/0x70
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608277]  [<ffffffff810eae20>] handle_edge_irq+0x80/0x140
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608282]  [<ffffffff810173c6>] handle_irq+0x46/0xb0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608287]  [<ffffffff81605a2d>] do_IRQ+0x5d/0xe0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608291]  [<ffffffff815fbeee>] common_interrupt+0x6e/0x6e
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608294]  <EOI>  [<ffffffff81324da0>] ? intel_idle+0xe0/0x150
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608301]  [<ffffffff81324d86>] ? intel_idle+0xc6/0x150
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608307]  [<ffffffff814ae4a1>] cpuidle_idle_call+0xd1/0x1d0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608311]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608315]  [<ffffffff815f3738>] start_secondary+0x230/0x237
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608322] NMI backtrace for cpu 1
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608326] CPU 1 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608328] Modules linked in: ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack xt_CHECKSUM iptable_mangle 8021q garp sunrpc bridge stp llc binfmt_misc vhost_net macvtap macvlan tun kvm_intel kvm uinput joydev microcode serio_raw pcspkr i7core_edac edac_core i2c_i801 iTCO_wdt iTCO_vendor_support r8169 mii snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608388] 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608393] Pid: 0, comm: swapper/1 Not tainted 3.2.18-3.el6.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608401] RIP: 0010:[<ffffffff81324d76>]  [<ffffffff81324d76>] intel_idle+0xb6/0x150
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608410] RSP: 0018:ffff880122ffde58  EFLAGS: 00000046
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608414] RAX: 0000000000000010 RBX: 0000000000000004 RCX: 0000000000000001
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608419] RDX: 0000000000000000 RSI: ffff880122ffdfd8 RDI: ffffffff81c16100
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608423] RBP: ffff880122ffdeb8 R08: 0000000000000000 R09: 0000000000000000
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608427] R10: 00000000ba9e6aab R11: 0000000000000002 R12: 0000000000000002
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608432] R13: ffff88012fc58a70 R14: 0000000000000010 R15: 129dd6d92c467f0e
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608437] FS:  0000000000000000(0000) GS:ffff88012fc40000(0000) knlGS:0000000000000000
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608442] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608446] CR2: 00000000006df2d0 CR3: 0000000001c08000 CR4: 00000000000026e0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608451] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608455] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608460] Process swapper/1 (pid: 0, threadinfo ffff880122ffc000, task ffff880122ffa380)
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608464] Stack:
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608467]  ffff880122ffdeb8 ffffffff814af709 0000000000000000 00000000000c6fab
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608474]  0000000000000000 00000001000c6fab 00000000ffffffff ffff88012fc58a70
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608481]  ffffffff81c76b20 0000000000000000 0000000000000002 0000000000000001
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608488] Call Trace:
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608495]  [<ffffffff814af709>] ? menu_select+0xf9/0x3b0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608503]  [<ffffffff814ae4a1>] cpuidle_idle_call+0xd1/0x1d0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608510]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608516]  [<ffffffff815f3738>] start_secondary+0x230/0x237
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608521] Code: c7 48 8d 86 38 e0 ff ff 83 e2 08 75 1e 31 d2 48 89 d1 0f 01 c8 0f ae f0 48 8b 86 38 e0 ff ff a8 08 75 08 b1 01 4c 89 f0 0f 01 c9 <e8> 15 cf d7 ff 4c 29 f8 48 89 c7 e8 1a 46 d5 ff 49 89 c6 49 89 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608570] Call Trace:
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608576]  [<ffffffff814af709>] ? menu_select+0xf9/0x3b0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608583]  [<ffffffff814ae4a1>] cpuidle_idle_call+0xd1/0x1d0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608589]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608594]  [<ffffffff815f3738>] start_secondary+0x230/0x237
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608601] NMI backtrace for cpu 5
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608604] CPU 5 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608606] Modules linked in: ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack xt_CHECKSUM iptable_mangle 8021q garp sunrpc bridge stp llc binfmt_misc vhost_net macvtap macvlan tun kvm_intel kvm uinput joydev microcode serio_raw pcspkr i7core_edac edac_core i2c_i801 iTCO_wdt iTCO_vendor_support r8169 mii snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc firewire_ohci firewire_core crc_itu_t nouveau ttm drm_kms_helper drm i2c_algo_bit i2c_core mxm_wmi wmi video [last unloaded: scsi_wait_scan]
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608656] 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608660] Pid: 0, comm: swapper/5 Not tainted 3.2.18-3.el6.alu_preempt_rt.x86_64-rt29 #1 Hewlett-Packard HP Elite 7100 Microtower PC/2A9Ch
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608665] RIP: 0010:[<ffffffff81324d76>]  [<ffffffff81324d76>] intel_idle+0xb6/0x150
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608672] RSP: 0018:ffff8801228e1e58  EFLAGS: 00000046
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608675] RAX: 0000000000000010 RBX: 0000000000000004 RCX: 0000000000000001
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608678] RDX: 0000000000000000 RSI: ffff8801228e1fd8 RDI: ffffffff81c16100
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608681] RBP: ffff8801228e1eb8 R08: 0000000000000000 R09: 0000000000000000
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608684] R10: 000000008d9076a9 R11: 0000000000000002 R12: 0000000000000002
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608687] R13: ffff88012fd58a70 R14: 0000000000000010 R15: 129dd6d92c469937
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608691] FS:  0000000000000000(0000) GS:ffff88012fd40000(0000) knlGS:0000000000000000
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608695] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608698] CR2: 00007f35cdc4eb70 CR3: 0000000001c08000 CR4: 00000000000026e0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608701] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608704] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608708] Process swapper/5 (pid: 0, threadinfo ffff8801228e0000, task ffff8801228de200)
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608710] Stack:
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608712]  ffff8801228e1eb8 ffffffff814af709 0000000000000000 00000000000c55d2
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608717]  0000000000000000 00000005000c55d2 00000000ffffffff ffff88012fd58a70
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608722]  ffffffff81c76b20 0000000000000000 0000000000000002 0000000000000005
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608727] Call Trace:
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608732]  [<ffffffff814af709>] ? menu_select+0xf9/0x3b0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608737]  [<ffffffff814ae4a1>] cpuidle_idle_call+0xd1/0x1d0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608742]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608746]  [<ffffffff815f3738>] start_secondary+0x230/0x237
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608750] Code: c7 48 8d 86 38 e0 ff ff 83 e2 08 75 1e 31 d2 48 89 d1 0f 01 c8 0f ae f0 48 8b 86 38 e0 ff ff a8 08 75 08 b1 01 4c 89 f0 0f 01 c9 <e8> 15 cf d7 ff 4c 29 f8 48 89 c7 e8 1a 46 d5 ff 49 89 c6 49 89 
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608783] Call Trace:
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608787]  [<ffffffff814af709>] ? menu_select+0xf9/0x3b0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608792]  [<ffffffff814ae4a1>] cpuidle_idle_call+0xd1/0x1d0
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608797]  [<ffffffff81014a5a>] cpu_idle+0xba/0x110
Jul  5 01:05:32 upmc-svr1 kernel: [  130.608801]  [<ffffffff815f3738>] start_secondary+0x230/0x237

--------------000109070805040001050703--
