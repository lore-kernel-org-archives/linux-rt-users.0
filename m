From: Carsten Emde <C.Emde@osadl.org>
Subject: [OSADL QA 3.18.7-rt2 #2] BUG: scheduling while atomic: nfsd and irq/30-eth0
Date: Wed, 04 Mar 2015 22:27:43 +0100
Message-ID: <54F778CF.1090201@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:32790 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752325AbbCDVaL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Mar 2015 16:30:11 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

An NFS server occasionally runs into "BUG: scheduling while atomic". The 
message appears about once every 2 to 4 minutes at heavy NFS traffic.

There are only two different patterns, one through nfsd and the other 
through the network interrupt thread. I applied Steven's patch 
https://lkml.org/lkml/2014/1/16/366 to get as much information as possible.

Thanks,
Carsten.


irq/30-eth0:
[ 9346.799757] BUG: scheduling while atomic: irq/30-eth0/1123/0x00000002
[ 9346.799791] Modules linked in: eeprom nfsd lockd grace nfs_acl 
exportfs auth_rpcgss oid_registry sunrpc ip6t_REJECT nf_reject_ipv6 
bluetooth nf_conntrack_ipv6 rfkill nf_defrag_ipv6 ip6table_filter 
cpufreq_ondemand ip6_tables it87 hwmon_vid coretemp snd_hda_codec_hdmi 
snd_hda_codec_via snd_hda_codec_generic snd_hda_intel snd_hda_controller 
snd_hda_codec snd_hwdep r8169 mii iTCO_wdt iTCO_vendor_support snd_seq 
snd_seq_device snd_pcm snd_timer xhci_pci xhci_hcd wmi i2c_i801 
serio_raw lpc_ich mfd_core snd microcode pcspkr soundcore acpi_cpufreq 
ipv6 i915 drm_kms_helper drm video i2c_algo_bit i2c_core
[ 9346.799804] Preemption disabled at:[<ffffffffa03fc582>] 
svc_xprt_enqueue+0x16/0x18 [sunrpc]
[ 9346.799804]
[ 9346.799807] CPU: 2 PID: 1123 Comm: irq/30-eth0 Tainted: G        W 
    3.18.7-rt2-nodebug #32
[ 9346.799808] Hardware name: System manufacturer System Product 
Name/P8H61-I, BIOS 0403 02/11/2011
[ 9346.799810]  ffff8800adc49cb0 ffff880137d5b6e8 ffffffff814c6c96 
0000000000000000
[ 9346.799811]  ffff88013b28aa00 ffff880137d5b6f8 ffffffff814c3e55 
ffff880137d5b778
[ 9346.799813]  ffffffff814c8427 ffff880137d5b728 ffffffff810862a6 
ffff880137d58000
[ 9346.799813] Call Trace:
[ 9346.799818]  [<ffffffff814c6c96>] dump_stack+0x4f/0x7c
[ 9346.799820]  [<ffffffff814c3e55>] __schedule_bug+0x9a/0xad
[ 9346.799822]  [<ffffffff814c8427>] __schedule+0x8f/0x55a
[ 9346.799824]  [<ffffffff810862a6>] ? __rt_mutex_adjust_prio+0x26/0x2a
[ 9346.799826]  [<ffffffff814ca409>] ? _raw_spin_unlock_irqrestore+0x19/0x2c
[ 9346.799828]  [<ffffffff814c89ed>] schedule+0x7a/0x8d
[ 9346.799830]  [<ffffffff814c9809>] rt_spin_lock_slowlock+0x150/0x1df
[ 9346.799832]  [<ffffffff810867d5>] 
rt_spin_lock_fastlock.constprop.12+0x1f/0x21
[ 9346.799834]  [<ffffffff814ca615>] rt_spin_lock+0xe/0x10
[ 9346.799840]  [<ffffffffa03fc49d>] svc_xprt_do_enqueue+0x7d/0x14c [sunrpc]
[ 9346.799845]  [<ffffffffa03fc582>] svc_xprt_enqueue+0x16/0x18 [sunrpc]
[ 9346.799851]  [<ffffffffa03f194c>] svc_tcp_data_ready+0x2b/0x52 [sunrpc]
[ 9346.799854]  [<ffffffff814614b1>] tcp_rcv_established+0x344/0x44d
[ 9346.799856]  [<ffffffff81468fc3>] tcp_v4_do_rcv+0x86/0x251
[ 9346.799858]  [<ffffffff81426766>] ? sk_filter+0xaf/0xba
[ 9346.799860]  [<ffffffff8146abad>] tcp_v4_rcv+0x50d/0x7ab
[ 9346.799862]  [<ffffffff8144c9ae>] ? 
xfrm4_policy_check.constprop.4+0x52/0x52
[ 9346.799863]  [<ffffffff8144c9ae>] ? 
xfrm4_policy_check.constprop.4+0x52/0x52
[ 9346.799865]  [<ffffffff8144ca87>] ip_local_deliver_finish+0xd9/0x178
[ 9346.799867]  [<ffffffff8144c9ae>] ? 
xfrm4_policy_check.constprop.4+0x52/0x52
[ 9346.799868]  [<ffffffff8144c955>] NF_HOOK.constprop.3+0x4c/0x53
[ 9346.799870]  [<ffffffff8144cc69>] ip_local_deliver+0x4f/0x54
[ 9346.799872]  [<ffffffff8144c8f2>] ip_rcv_finish+0x32a/0x341
[ 9346.799873]  [<ffffffff8144c5c8>] ? inet_add_protocol+0x43/0x43
[ 9346.799875]  [<ffffffff8144c955>] NF_HOOK.constprop.3+0x4c/0x53
[ 9346.799876]  [<ffffffff8144cf87>] ip_rcv+0x319/0x376
[ 9346.799879]  [<ffffffff81412462>] __netif_receive_skb_core+0x4a9/0x4e8
[ 9346.799881]  [<ffffffff81009ec5>] ? read_tsc+0x9/0xb
[ 9346.799883]  [<ffffffff8141492e>] __netif_receive_skb+0x5a/0x5f
[ 9346.799884]  [<ffffffff81414abd>] netif_receive_skb_internal+0x87/0x8e
[ 9346.799887]  [<ffffffff8147b3c0>] ? inet_gro_complete+0xc9/0xd3
[ 9346.799888]  [<ffffffff81414bd5>] napi_gro_complete+0xbf/0xca
[ 9346.799889]  [<ffffffff81414f60>] napi_gro_flush+0x51/0x6d
[ 9346.799890]  [<ffffffff81414f9a>] napi_complete+0x1e/0x36
[ 9346.799894]  [<ffffffffa02cf297>] rtl8169_poll+0x521/0x53f [r8169]
[ 9346.799897]  [<ffffffff81262d36>] ? debug_smp_processor_id+0x17/0x19
[ 9346.799898]  [<ffffffff810773f9>] ? preempt_count_add+0x55/0xe9
[ 9346.799900]  [<ffffffff81415043>] net_rx_action+0x91/0x1ac
[ 9346.799902]  [<ffffffff81262c73>] ? check_preemption_disabled+0x9b/0x132
[ 9346.799905]  [<ffffffff8105ab19>] do_current_softirqs+0x15f/0x26f
[ 9346.799907]  [<ffffffff8108d4fc>] ? irq_thread_fn+0x41/0x41
[ 9346.799908]  [<ffffffff8105acb1>] __local_bh_enable+0x4b/0x6e
[ 9346.799910]  [<ffffffff8105ace2>] local_bh_enable+0xe/0x10
[ 9346.799911]  [<ffffffff8108d54a>] irq_forced_thread_fn+0x4e/0x5a
[ 9346.799913]  [<ffffffff8108d298>] irq_thread+0x8e/0x16c
[ 9346.799914]  [<ffffffff8108d415>] ? irq_finalize_oneshot.part.5+0x9f/0x9f
[ 9346.799915]  [<ffffffff8108d20a>] ? wake_threads_waitq+0x2e/0x2e
[ 9346.799918]  [<ffffffff8106fb4d>] kthread+0xc4/0xcc
[ 9346.799919]  [<ffffffff8106fa89>] ? __init_kthread_worker+0x50/0x50
[ 9346.799922]  [<ffffffff814cabac>] ret_from_fork+0x7c/0xb0
[ 9346.799923]  [<ffffffff8106fa89>] ? __init_kthread_worker+0x50/0x50
[ 9346.799925] ---------------------------
[ 9346.799925] | preempt count: 00000002 ]
[ 9346.799926] | 2-level deep critical section nesting:
[ 9346.799926] ----------------------------------------
[ 9346.799931] .. [<ffffffffa03fc473>] .... 
svc_xprt_do_enqueue+0x53/0x14c [sunrpc]
[ 9346.799936] .....[<ffffffffa03fc582>] ..   ( <= 
svc_xprt_enqueue+0x16/0x18 [sunrpc])
[ 9346.799938] .. [<ffffffff814c83e1>] .... __schedule+0x49/0x55a
[ 9346.799939] .....[<ffffffff814c89ed>] ..   ( <= schedule+0x7a/0x8d)
[ 9346.799939]

nfsd:
[ 9545.948169] BUG: scheduling while atomic: nfsd/1358/0x00000002
[ 9545.948195] Modules linked in: eeprom nfsd lockd grace nfs_acl 
exportfs auth_rpcgss oid_registry sunrpc ip6t_REJECT nf_reject_ipv6 
bluetooth nf_conntrack_ipv6 rfkill nf_defrag_ipv6 ip6table_filter 
cpufreq_ondemand ip6_tables it87 hwmon_vid coretemp snd_hda_codec_hdmi 
snd_hda_codec_via snd_hda_codec_generic snd_hda_intel snd_hda_controller 
snd_hda_codec snd_hwdep r8169 mii iTCO_wdt iTCO_vendor_support snd_seq 
snd_seq_device snd_pcm snd_timer xhci_pci xhci_hcd wmi i2c_i801 
serio_raw lpc_ich mfd_core snd microcode pcspkr soundcore acpi_cpufreq 
ipv6 i915 drm_kms_helper drm video i2c_algo_bit i2c_core
[ 9545.948204] Preemption disabled at:[<ffffffffa03fc91d>] 
svc_xprt_received+0x54/0x61 [sunrpc]
[ 9545.948205]
[ 9545.948207] CPU: 0 PID: 1358 Comm: nfsd Tainted: G        W 
3.18.7-rt2-nodebug #32
[ 9545.948208] Hardware name: System manufacturer System Product 
Name/P8H61-I, BIOS 0403 02/11/2011
[ 9545.948210]  ffff880137de5fa0 ffff8800aca1bc48 ffffffff814c6c96 
0000000000000000
[ 9545.948211]  ffff88013b08aa00 ffff8800aca1bc58 ffffffff814c3e55 
ffff8800aca1bcd8
[ 9545.948213]  ffffffff814c8427 ffff8800aca1bc88 ffffffff814ca486 
ffff8800aca18000
[ 9545.948213] Call Trace:
[ 9545.948217]  [<ffffffff814c6c96>] dump_stack+0x4f/0x7c
[ 9545.948219]  [<ffffffff814c3e55>] __schedule_bug+0x9a/0xad
[ 9545.948220]  [<ffffffff814c8427>] __schedule+0x8f/0x55a
[ 9545.948222]  [<ffffffff814ca486>] ? _raw_spin_lock_irqsave+0x1d/0x44
[ 9545.948224]  [<ffffffff814ca409>] ? _raw_spin_unlock_irqrestore+0x19/0x2c
[ 9545.948226]  [<ffffffff814c89ed>] schedule+0x7a/0x8d
[ 9545.948228]  [<ffffffff814c9809>] rt_spin_lock_slowlock+0x150/0x1df
[ 9545.948234]  [<ffffffffa03f186e>] ? svc_recvfrom+0x5b/0x6e [sunrpc]
[ 9545.948237]  [<ffffffff810867d5>] 
rt_spin_lock_fastlock.constprop.12+0x1f/0x21
[ 9545.948239]  [<ffffffff814ca615>] rt_spin_lock+0xe/0x10
[ 9545.948244]  [<ffffffffa03fc49d>] svc_xprt_do_enqueue+0x7d/0x14c [sunrpc]
[ 9545.948250]  [<ffffffffa03fc91d>] svc_xprt_received+0x54/0x61 [sunrpc]
[ 9545.948255]  [<ffffffffa03fcfd1>] svc_recv+0x6a7/0x727 [sunrpc]
[ 9545.948260]  [<ffffffffa045d60a>] nfsd+0xe6/0x14f [nfsd]
[ 9545.948263]  [<ffffffffa045d524>] ? nfsd_destroy+0x64/0x64 [nfsd]
[ 9545.948265]  [<ffffffff8106fb4d>] kthread+0xc4/0xcc
[ 9545.948267]  [<ffffffff8106fa89>] ? __init_kthread_worker+0x50/0x50
[ 9545.948270]  [<ffffffff814cabac>] ret_from_fork+0x7c/0xb0
[ 9545.948271]  [<ffffffff8106fa89>] ? __init_kthread_worker+0x50/0x50
[ 9545.948273] ---------------------------
[ 9545.948273] | preempt count: 00000002 ]
[ 9545.948274] | 2-level deep critical section nesting:
[ 9545.948274] ----------------------------------------
[ 9545.948280] .. [<ffffffffa03fc473>] .... 
svc_xprt_do_enqueue+0x53/0x14c [sunrpc]
[ 9545.948285] .....[<ffffffffa03fc91d>] ..   ( <= 
svc_xprt_received+0x54/0x61 [sunrpc])
[ 9545.948286] .. [<ffffffff814c83e1>] .... __schedule+0x49/0x55a
[ 9545.948288] .....[<ffffffff814c89ed>] ..   ( <= schedule+0x7a/0x8d)
[ 9545.948288]
