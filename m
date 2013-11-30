From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: 3.10.20-rt17, BUG and Oops
Date: Sat, 30 Nov 2013 17:40:49 +0100
Message-ID: <529A1511.5050801@osadl.org>
References: <52999A44.7060103@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:37182 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752Ab3K3QxV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 30 Nov 2013 11:53:21 -0500
In-Reply-To: <52999A44.7060103@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/30/2013 08:56 AM, Fernando Lopez-Lezcano wrote:
> Just got this on 3.10.20-rt17, ThinkPad T510 running Fedora 19 (I think
> it has happened a few times before). The machine is not completely dead,
> the mouse pointer moves around but otherwise display updates and
> keyboard response are nil.
Same behavior and same manufacturer here, but newer kernel (3.12.0-rt2). 
This is the second crash of its kind. About four days after this fault, 
the system stopped working and needed a reboot - as predicted. This 
crash already made it into the OSADL Hall of Shame 
(https://www.osadl.org/?id=1817&system=r1s6) where more details are 
available.

While I can't remember crashes at advance_transaction(), function calls 
such as acpi_ev_gpe_detect() and friends already occurred a couple of 
times in crash dumps. It probably is important to note that the problem 
is ACPI related and occurred in two different systems of the same board 
manufacturer (and probably the same BIOS/ACPI supplier).

	-Carsten.


----------

# addr2line -e vmlinux 0xffffffff81298301
/usr/src/kernels/linux-3.12.0-rt2/drivers/acpi/ec.c:186

         if (t->wlen > t->wi) {
                 if ((status & ACPI_EC_FLAG_IBF) == 0)
                         acpi_ec_write_data(ec,
---->                           t->wdata[t->wi++]);
                 else
                         goto err;


----------

[805457.455978] BUG: unable to handle kernel paging request at 
000000000000809b
[805457.455989] IP: [<ffffffff81298301>] advance_transaction+0x5b/0x12e
[805457.455994] PGD 72551067 PUD 79d02067 PMD 0
[805457.455998] Oops: 0000 [#1] PREEMPT SMP
[805457.456049] Modules linked in: nfsv4 nfs fscache lockd cpufreq_stats 
eeprom rpcsec_gss_krb5 auth_rpcgss bnep oid_registry bluetooth sunrpc 
ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables 
coretemp snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_intel 
snd_hda_codec arc4 snd_hwdep rtl8192ce snd_seq rtl8192c_common 
snd_seq_device rtl_pci rtlwifi mac80211 snd_pcm iTCO_wdt 
iTCO_vendor_support cfg80211 snd_timer snd lpc_ich microcode soundcore 
mfd_core pcspkr i2c_i801 r8169 serio_raw mii rfkill snd_page_alloc ipv6 
autofs4 radeon ttm drm_kms_helper drm i2c_algo_bit [last unloaded: 
speedstep_lib]
[805457.456055] CPU: 1 PID: 45 Comm: irq/9-acpi Not tainted 3.12.0-rt2 #9
[805457.456057] Hardware name: LENOVO 10087&3110/Tiger Hill, BIOS 
E6KT11AUS 11/17/2011
[805457.456060] task: ffff88007cb59800 ti: ffff88007c41c000 task.ti: 
ffff88007c41c000
[805457.456067] RIP: 0010:[<ffffffff81298301>]  [<ffffffff81298301>] 
advance_transaction+0x5b/0x12e
[805457.456069] RSP: 0018:ffff88007c41dce8  EFLAGS: 00010202
[805457.456071] RAX: 000000000000007c RBX: ffff88007bc27d98 RCX: 
0000000000008020
[805457.456074] RDX: 000000000000007b RSI: 0000000000000009 RDI: 
ffff88007cb7a0b0
[805457.456076] RBP: ffff88007c41dd18 R08: 00000000000004d0 R09: 
000000000000042e
[805457.456078] R10: ffff88007c41c000 R11: ffff88007c41c000 R12: 
ffff88007cb7a000
[805457.456081] R13: 0000000000000011 R14: 0000000000000009 R15: 
ffff88007cb7a0b0
[805457.456084] FS:  0000000000000000(0000) GS:ffff88007f680000(0000) 
knlGS:0000000000000000
[805457.456086] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[805457.456088] CR2: 000000000000809b CR3: 000000007985a000 CR4: 
00000000000007e0
[805457.456090] Stack:
[805457.456097]  ffff88007ca8c909 ffff88007cb7a000 ffff88007ca8c909 
0000000000000011
[805457.456102]  0000000000000002 0000000000000000 ffff88007c41dd38 
ffffffff81298ed8
[805457.456108]  0000000000000001 ffff88007ca8c998 ffff88007c41dd68 
ffffffff812a1e11
[805457.456109] Call Trace:
[805457.456116]  [<ffffffff81298ed8>] acpi_ec_gpe_handler+0x47/0xc6
[805457.456122]  [<ffffffff812a1e11>] acpi_ev_gpe_dispatch+0xc5/0x13e
[805457.456127]  [<ffffffff812a1f3f>] acpi_ev_gpe_detect+0xb5/0x10a
[805457.456135]  [<ffffffff81077e15>] ? irq_thread_fn+0x41/0x41
[805457.456140]  [<ffffffff812a3e46>] acpi_ev_sci_xrupt_handler+0x22/0x2b
[805457.456146]  [<ffffffff81290f92>] acpi_irq+0x16/0x31
[805457.456152]  [<ffffffff81077e39>] irq_forced_thread_fn+0x24/0x5a
[805457.456159]  [<ffffffff81077ba7>] irq_thread+0x8c/0x174
[805457.456166]  [<ffffffff81077d2e>] ? 
irq_finalize_oneshot.part.5+0x9f/0x9f
[805457.456173]  [<ffffffff81077b1b>] ? wake_threads_waitq+0x44/0x44
[805457.456179]  [<ffffffff81077b1b>] ? wake_threads_waitq+0x44/0x44
[805457.456186]  [<ffffffff81051c71>] kthread+0x8d/0x95
[805457.456192]  [<ffffffff81051be4>] ? 
rcu_read_unlock_sched_notrace+0x44/0x44
[805457.456199]  [<ffffffff814d327c>] ret_from_fork+0x7c/0xb0
[805457.456205]  [<ffffffff81051be4>] ? 
rcu_read_unlock_sched_notrace+0x44/0x44
[805457.456264] Code: ff e8 36 59 23 00 48 85 db 0f 84 d6 00 00 00 8a 53 
15 8a 43 13 38 c2 76 49 41 f6 c6 02 0f 85 a1 00 00 00 48 8b 0b 0f b6 d0 
ff c0 <44> 8a 2c 11 88 43 13 f6 05 bb 5b 80 00 04 74 19 41 0f b6 d5 48
[805457.456269] RIP  [<ffffffff81298301>] advance_transaction+0x5b/0x12e
[805457.456270]  RSP <ffff88007c41dce8>
[805457.456272] CR2: 000000000000809b
[805458.068444] ---[ end trace 0000000000000002 ]---
[805458.068475] BUG: unable to handle kernel paging request at 
ffffffffffffffd8
[805458.068484] IP: [<ffffffff81051f6e>] kthread_data+0x10/0x16
[805458.068488] PGD 1a0f067 PUD 1a11067 PMD 0
[805458.068491] Oops: 0000 [#2] PREEMPT SMP
[805458.068542] Modules linked in: nfsv4 nfs fscache lockd cpufreq_stats 
eeprom rpcsec_gss_krb5 auth_rpcgss bnep oid_registry bluetooth sunrpc 
ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables 
coretemp snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_intel 
snd_hda_codec arc4 snd_hwdep rtl8192ce snd_seq rtl8192c_common 
snd_seq_device rtl_pci rtlwifi mac80211 snd_pcm iTCO_wdt 
iTCO_vendor_support cfg80211 snd_timer snd lpc_ich microcode soundcore 
mfd_core pcspkr i2c_i801 r8169 serio_raw mii rfkill snd_page_alloc ipv6 
autofs4 radeon ttm drm_kms_helper drm i2c_algo_bit [last unloaded: 
speedstep_lib]
[805458.068546] CPU: 1 PID: 45 Comm: irq/9-acpi Tainted: G      D 
3.12.0-rt2 #9
[805458.068548] Hardware name: LENOVO 10087&3110/Tiger Hill, BIOS 
E6KT11AUS 11/17/2011
[805458.068550] task: ffff88007cb59800 ti: ffff88007c41c000 task.ti: 
ffff88007c41c000
[805458.068556] RIP: 0010:[<ffffffff81051f6e>]  [<ffffffff81051f6e>] 
kthread_data+0x10/0x16
[805458.068558] RSP: 0018:ffff88007c41d928  EFLAGS: 00010202
[805458.068560] RAX: 0000000000000000 RBX: ffff88007cb59800 RCX: 
0000000000000000
[805458.068561] RDX: ffff88007c41de70 RSI: 0000000000000000 RDI: 
ffff88007cb59800
[805458.068563] RBP: ffff88007c41d928 R08: 0000000000000000 R09: 
0000000000000001
[805458.068565] R10: 0000000000000001 R11: ffff88007cb59800 R12: 
ffff88007cb59800
[805458.068566] R13: ffffffff81c51f20 R14: 0000000000000246 R15: 
0000000000000001
[805458.068569] FS:  0000000000000000(0000) GS:ffff88007f680000(0000) 
knlGS:0000000000000000
[805458.068571] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[805458.068572] CR2: ffffffffffffffd8 CR3: 000000007985a000 CR4: 
00000000000007e0
[805458.068574] Stack:
[805458.068579]  ffff88007c41d948 ffffffff81077d76 ffff88007cb59800 
0000000000000000
[805458.068583]  ffff88007c41d978 ffffffff8104efe9 ffff88007cb59800 
ffff88007cb59800
[805458.068587]  0000000000000000 ffff88007c41dc38 ffff88007c41d9f8 
ffffffff81036fa0
[805458.068588] Call Trace:
[805458.068594]  [<ffffffff81077d76>] irq_thread_dtor+0x48/0xa6
[805458.068599]  [<ffffffff8104efe9>] task_work_run+0x83/0x9a
[805458.068604]  [<ffffffff81036fa0>] do_exit+0x3f0/0x969
[805458.068609]  [<ffffffff81076127>] ? kmsg_dump+0xac/0xb3
[805458.068613]  [<ffffffff814cf03c>] oops_end+0xba/0xc2
[805458.068619]  [<ffffffff814c5ae1>] no_context+0x1f9/0x208
[805458.068624]  [<ffffffff81008d40>] ? __cycles_2_ns+0xe/0x4c
[805458.068629]  [<ffffffff814c5cc5>] __bad_area_nosemaphore+0x1d5/0x1f6
[805458.068634]  [<ffffffff8105d4c4>] ? get_parent_ip+0xe/0x3e
[805458.068638]  [<ffffffff814ce4d9>] ? restore_args+0x30/0x30
[805458.068643]  [<ffffffff814c5cf9>] bad_area_nosemaphore+0x13/0x15
[805458.068647]  [<ffffffff814d110d>] __do_page_fault+0x370/0x3b0
[805458.068651]  [<ffffffff810b8fb4>] ? buffer_ftrace_now+0x39/0x45
[805458.068656]  [<ffffffff810016ee>] ? __switch_to+0x1f9/0x409
[805458.068660]  [<ffffffff814cdeb7>] ? _raw_spin_unlock_irq+0x47/0x54
[805458.068665]  [<ffffffff8105c1d2>] ? finish_task_switch+0x8c/0xdb
[805458.068669]  [<ffffffff8105c585>] ? need_resched+0x38/0x44
[805458.068673]  [<ffffffff814cca3f>] ? __schedule+0x614/0x62b
[805458.068677]  [<ffffffff8105d4c4>] ? get_parent_ip+0xe/0x3e
[805458.068681]  [<ffffffff814d115b>] do_page_fault+0xe/0x10
[805458.068685]  [<ffffffff814ce6c2>] page_fault+0x22/0x30
[805458.068691]  [<ffffffff81298301>] ? advance_transaction+0x5b/0x12e
[805458.068696]  [<ffffffff812982dc>] ? advance_transaction+0x36/0x12e
[805458.068703]  [<ffffffff81298ed8>] acpi_ec_gpe_handler+0x47/0xc6
[805458.068710]  [<ffffffff812a1e11>] acpi_ev_gpe_dispatch+0xc5/0x13e
[805458.068716]  [<ffffffff812a1f3f>] acpi_ev_gpe_detect+0xb5/0x10a
[805458.068724]  [<ffffffff81077e15>] ? irq_thread_fn+0x41/0x41
[805458.068728]  [<ffffffff812a3e46>] acpi_ev_sci_xrupt_handler+0x22/0x2b
[805458.068732]  [<ffffffff81290f92>] acpi_irq+0x16/0x31
[805458.068737]  [<ffffffff81077e39>] irq_forced_thread_fn+0x24/0x5a
[805458.068741]  [<ffffffff81077ba7>] irq_thread+0x8c/0x174
[805458.068746]  [<ffffffff81077d2e>] ? 
irq_finalize_oneshot.part.5+0x9f/0x9f
[805458.068750]  [<ffffffff81077b1b>] ? wake_threads_waitq+0x44/0x44
[805458.068754]  [<ffffffff81077b1b>] ? wake_threads_waitq+0x44/0x44
[805458.068758]  [<ffffffff81051c71>] kthread+0x8d/0x95
[805458.068764]  [<ffffffff81051be4>] ? 
rcu_read_unlock_sched_notrace+0x44/0x44
[805458.068768]  [<ffffffff814d327c>] ret_from_fork+0x7c/0xb0
[805458.068773]  [<ffffffff81051be4>] ? 
rcu_read_unlock_sched_notrace+0x44/0x44
[805458.068820] Code: 40 98 00 00 48 8b 80 c8 03 00 00 48 89 e5 5d 48 8b 
40 c8 48 c1 e8 02 83 e0 01 c3 0f 1f 44 00 00 48 8b 87 c8 03 00 00 55 48 
89 e5 <48> 8b 40 d8 5d c3 0f 1f 44 00 00 55 ba 08 00 00 00 48 89 e5 48
[805458.068824] RIP  [<ffffffff81051f6e>] kthread_data+0x10/0x16
[805458.068825]  RSP <ffff88007c41d928>
[805458.068826] CR2: ffffffffffffffd8
[805458.912113] ---[ end trace 0000000000000003 ]---
[805458.912115] Fixing recursive fault but reboot is needed!
