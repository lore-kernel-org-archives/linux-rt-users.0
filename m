From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Lockdep chain_key key collision warning on 4.6.1-rt3
Date: Fri, 3 Jun 2016 13:37:11 -0300
Message-ID: <20160603163711.GC27058@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33579 "EHLO
	mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932259AbcFCQnI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Jun 2016 12:43:08 -0400
Received: by mail-qt0-f171.google.com with SMTP id 23so12635084qtq.0
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Jun 2016 09:43:07 -0700 (PDT)
Received: from lclaudio.dyndns.org ([177.156.98.66])
        by smtp.gmail.com with ESMTPSA id b20sm1236930qge.44.2016.06.03.09.37.13
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2016 09:37:14 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Right after boot, on both 4.6.1-rt2 and 4.6.1-rt3, I saw the lockdep warning
listed below. What caught my attention are those two lines:

   DEBUG_LOCKS_WARN_ON(chain->depth != curr->lockdep_depth - (i - 1))

   modprobe/1050: Hash chain already cached but the contents don't match!

Anybody else saw something similar?

[   30.736024] ------------[ cut here ]------------
[   30.736028] WARNING: CPU: 1 PID: 1050 at /home/lclaudio/kernel-rt/kernel/locking/lockdep.c:2090 __lock_acquire+0x17d8/0x1fb0
[   30.736030] DEBUG_LOCKS_WARN_ON(chain->depth != curr->lockdep_depth - (i - 1))
[   30.736059] Modules linked in: nf_conntrack(+) bnep coretemp kvm_intel kvm arc4 rt2800pci rt2800mmio rt2800lib eeprom_93cx6 rt2x00pci rt2x00mmio rt2x00lib btusb btrtl btbcm vfat fat mac80211 btintel bluetooth iTCO_wdt iTCO_vendor_support joydev irqbypass snd_hda_codec_idt crc32c_intel pcspkr ghash_clmulni_intel snd_hda_codec_generic snd_hda_intel snd_hda_codec cfg80211 acpi_cpufreq snd_hda_core crc_ccitt rfkill snd_hwdep tpm_tis snd_seq tpm snd_seq_device snd_pcm shpchp snd_timer snd soundcore lpc_ich mfd_core i2c_i801 nfsd auth_rpcgss nfs_acl lockd grace sunrpc binfmt_misc sch_fq_codel i915 serio_raw i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm r8169 mii i2c_core video usb_storage efivarfs
[   30.736060] CPU: 1 PID: 1050 Comm: modprobe Not tainted 4.6.1-rt3 #2
[   30.736061] Hardware name: Hewlett-Packard p7-1512/2ADA, BIOS 8.15 02/05/2013
[   30.736063]  0000000000000086 00000000c9a2388d ffff8800d31c34a8 ffffffff813f1c5c
[   30.736064]  ffff8800d31c34f8 0000000000000000 ffff8800d31c34e8 ffffffff81088954
[   30.736065]  0000082a00000008 ffff88003ca3c000 0000000000000000 ffffffff8239cb20
[   30.736065] Call Trace:
[   30.736069]  [<ffffffff813f1c5c>] dump_stack+0x67/0x9b
[   30.736070]  [<ffffffff81088954>] __warn+0xe4/0x100
[   30.736072]  [<ffffffff810889cf>] warn_slowpath_fmt+0x5f/0x80
[   30.736073]  [<ffffffff810e7f78>] __lock_acquire+0x17d8/0x1fb0
[   30.736075]  [<ffffffff810e92d4>] lock_acquire+0x124/0x240
[   30.736078]  [<ffffffff81804f43>] ? __schedule+0xf3/0xc70
[   30.736080]  [<ffffffff81809651>] _raw_spin_lock+0x41/0x80
[   30.736081]  [<ffffffff81804f43>] ? __schedule+0xf3/0xc70
[   30.736082]  [<ffffffff81804f43>] __schedule+0xf3/0xc70
[   30.736083]  [<ffffffff81806040>] ? preempt_schedule_irq+0x60/0xb0
[   30.736084]  [<ffffffff81412843>] ? __this_cpu_preempt_check+0x13/0x20
[   30.736086]  [<ffffffff8180604b>] preempt_schedule_irq+0x6b/0xb0
[   30.736087]  [<ffffffff8180b092>] do_preempt_schedule_irq+0x5/0x17
[   30.736090]  [<ffffffff81222386>] ? __slab_alloc.isra.71+0x86/0xc0
[   30.736093]  [<ffffffff816b0147>] ? __alloc_skb+0x87/0x1f0
[   30.736094]  [<ffffffff8122574c>] __kmalloc_node_track_caller+0xcc/0x520
[   30.736096]  [<ffffffff816b0147>] ? __alloc_skb+0x87/0x1f0
[   30.736097]  [<ffffffff816af271>] __kmalloc_reserve.isra.33+0x31/0x90
[   30.736098]  [<ffffffff816b011b>] ? __alloc_skb+0x5b/0x1f0
[   30.736100]  [<ffffffff816b0147>] __alloc_skb+0x87/0x1f0
[   30.736102]  [<ffffffff813f6163>] kobject_uevent_env+0x3f3/0x650
[   30.736103]  [<ffffffff813f63cb>] kobject_uevent+0xb/0x10
[   30.736104]  [<ffffffff81223324>] sysfs_slab_add+0x1a4/0x1f0
[   30.736105]  [<ffffffff81225276>] __kmem_cache_create+0x4a6/0x540
[   30.736108]  [<ffffffff811e315b>] ? create_cache+0x3b/0x180
[   30.736111]  [<ffffffff81107a5f>] ? rcu_read_lock_sched_held+0x7f/0x90
[   30.736112]  [<ffffffff81224078>] ? kmem_cache_alloc+0x2b8/0x330
[   30.736113]  [<ffffffff811e31b7>] create_cache+0x97/0x180
[   30.736115]  [<ffffffff811e345a>] kmem_cache_create+0x1ba/0x280
[   30.736116]  [<ffffffffa07e6000>] ? 0xffffffffa07e6000
[   30.736121]  [<ffffffffa079c5ce>] nf_conntrack_init_net+0x15e/0x2b0 [nf_conntrack]
[   30.736126]  [<ffffffffa079d0f4>] nf_conntrack_pernet_init+0x14/0x170 [nf_conntrack]
[   30.736127]  [<ffffffff816bb491>] ops_init+0x41/0x170
[   30.736128]  [<ffffffffa07e6000>] ? 0xffffffffa07e6000
[   30.736129]  [<ffffffff816bb84d>] register_pernet_operations+0x10d/0x1b0
[   30.736131]  [<ffffffff816bb918>] register_pernet_subsys+0x28/0x40
[   30.736135]  [<ffffffffa07e6055>] nf_conntrack_standalone_init+0x55/0x1000 [nf_conntrack]
[   30.736137]  [<ffffffff810003e3>] do_one_initcall+0xb3/0x1f0
[   30.736138]  [<ffffffff81107a5f>] ? rcu_read_lock_sched_held+0x7f/0x90
[   30.736139]  [<ffffffff81223075>] ? kmem_cache_alloc_trace+0x2c5/0x330
[   30.736141]  [<ffffffff811b17ba>] ? do_init_module+0x27/0x1d7
[   30.736142]  [<ffffffff811b17f2>] do_init_module+0x5f/0x1d7
[   30.736145]  [<ffffffff811360df>] load_module+0x212f/0x2850
[   30.736146]  [<ffffffff81132680>] ? __symbol_put+0xa0/0xa0
[   30.736149]  [<ffffffff8123ce49>] ? vfs_read+0x119/0x130
[   30.736152]  [<ffffffff81136a96>] SYSC_finit_module+0xe6/0x120
[   30.736153]  [<ffffffff81136aee>] SyS_finit_module+0xe/0x10
[   30.736154]  [<ffffffff81003101>] do_syscall_64+0x61/0x170
[   30.736155]  [<ffffffff8180a75a>] entry_SYSCALL64_slow_path+0x25/0x25
[   30.736156] ---[ end trace 0000000000000002 ]---

[   30.736157] ======================
[   30.736157] [chain_key collision ]
[   30.736158] 4.6.1-rt3 #2 Tainted: G        W      
[   30.736158] ----------------------
[   30.736159] modprobe/1050: Hash chain already cached but the contents don't match!
[   30.736159] Held locks:depth: 6
[   30.736162]  class_idx:173 -> chain_key:00000000000000ad (net_mutex){+.+.+.}, at: [<ffffffff816bb909>] register_pernet_subsys+0x19/0x40
[   30.736164]  class_idx:46 -> chain_key:000000000015a02e (cpu_hotplug.lock){++++++}, at: [<ffffffff81089172>] get_online_cpus+0x32/0x80
[   30.736166]  class_idx:49 -> chain_key:00000002b405c031 (memcg_cache_ids_sem){.+.+.+}, at: [<ffffffff810eee90>] rt_down_read+0x10/0x20
[   30.736169]  class_idx:51 -> chain_key:00005680b8062033 (slab_mutex){+.+.+.}, at: [<ffffffff811e32eb>] kmem_cache_create+0x4b/0x280
[   30.736171]  class_idx:325 -> chain_key:0ad01700c4066145 (uevent_sock_mutex){+.+.+.}, at: [<ffffffff813f60b6>] kobject_uevent_env+0x346/0x650
[   30.736173]  class_idx:54 -> chain_key:02e01880cc28a16c (&rq->lock){-...-.}, at: [<ffffffff81804f43>] __schedule+0xf3/0xc70
[   30.736174] Locks in cached chain:depth: 5
[   30.736175]  class_idx:46 -> chain_key:000000000000002e (cpu_hotplug.lock){++++++}
[   30.736176]  class_idx:49 -> chain_key:000000000005c031 (memcg_cache_ids_sem){.+.+.+}
[   30.736177]  class_idx:51 -> chain_key:00000000b8062033 (slab_mutex){+.+.+.}
[   30.736178]  class_idx:325 -> chain_key:00001700c4066145 (uevent_sock_mutex){+.+.+.}
[   30.736179]  class_idx:364 -> chain_key:02e01880cc28a16c (nl_table_wait.lock.lock.wait_lock){......}
[   30.736179] 
               stack backtrace:
[   30.736180] CPU: 1 PID: 1050 Comm: modprobe Tainted: G        W       4.6.1-rt3 #2
[   30.736180] Hardware name: Hewlett-Packard p7-1512/2ADA, BIOS 8.15 02/05/2013
[   30.736181]  0000000000000086 00000000c9a2388d ffff8800d31c3508 ffffffff813f1c5c
[   30.736183]  ffffffff8239cb20 000000000000016b ffff8800d31c3550 ffffffff810e4a37
[   30.736184]  ffff88003ca3cab0 ffff88003ca3c9d0 ffff88003ca3c000 0000000000000000
[   30.736184] Call Trace:
[   30.736185]  [<ffffffff813f1c5c>] dump_stack+0x67/0x9b
[   30.736186]  [<ffffffff810e4a37>] print_collision+0x157/0x260
[   30.736188]  [<ffffffff810e7b50>] __lock_acquire+0x13b0/0x1fb0
[   30.736189]  [<ffffffff810e92d4>] lock_acquire+0x124/0x240
[   30.736191]  [<ffffffff81804f43>] ? __schedule+0xf3/0xc70
[   30.736192]  [<ffffffff81809651>] _raw_spin_lock+0x41/0x80
[   30.736193]  [<ffffffff81804f43>] ? __schedule+0xf3/0xc70
[   30.736194]  [<ffffffff81804f43>] __schedule+0xf3/0xc70
[   30.736195]  [<ffffffff81806040>] ? preempt_schedule_irq+0x60/0xb0
[   30.736196]  [<ffffffff81412843>] ? __this_cpu_preempt_check+0x13/0x20
[   30.736198]  [<ffffffff8180604b>] preempt_schedule_irq+0x6b/0xb0
[   30.736199]  [<ffffffff8180b092>] do_preempt_schedule_irq+0x5/0x17
[   30.736200]  [<ffffffff81222386>] ? __slab_alloc.isra.71+0x86/0xc0
[   30.736202]  [<ffffffff816b0147>] ? __alloc_skb+0x87/0x1f0
[   30.736203]  [<ffffffff8122574c>] __kmalloc_node_track_caller+0xcc/0x520
[   30.736204]  [<ffffffff816b0147>] ? __alloc_skb+0x87/0x1f0
[   30.736206]  [<ffffffff816af271>] __kmalloc_reserve.isra.33+0x31/0x90
[   30.736207]  [<ffffffff816b011b>] ? __alloc_skb+0x5b/0x1f0
[   30.736208]  [<ffffffff816b0147>] __alloc_skb+0x87/0x1f0
[   30.736210]  [<ffffffff813f6163>] kobject_uevent_env+0x3f3/0x650
[   30.736212]  [<ffffffff813f63cb>] kobject_uevent+0xb/0x10
[   30.736213]  [<ffffffff81223324>] sysfs_slab_add+0x1a4/0x1f0
[   30.736214]  [<ffffffff81225276>] __kmem_cache_create+0x4a6/0x540
[   30.736215]  [<ffffffff811e315b>] ? create_cache+0x3b/0x180
[   30.736217]  [<ffffffff81107a5f>] ? rcu_read_lock_sched_held+0x7f/0x90
[   30.736218]  [<ffffffff81224078>] ? kmem_cache_alloc+0x2b8/0x330
[   30.736219]  [<ffffffff811e31b7>] create_cache+0x97/0x180
[   30.736221]  [<ffffffff811e345a>] kmem_cache_create+0x1ba/0x280
[   30.736222]  [<ffffffffa07e6000>] ? 0xffffffffa07e6000
[   30.736225]  [<ffffffffa079c5ce>] nf_conntrack_init_net+0x15e/0x2b0 [nf_conntrack]
[   30.736229]  [<ffffffffa079d0f4>] nf_conntrack_pernet_init+0x14/0x170 [nf_conntrack]
[   30.736230]  [<ffffffff816bb491>] ops_init+0x41/0x170
[   30.736231]  [<ffffffffa07e6000>] ? 0xffffffffa07e6000
[   30.736232]  [<ffffffff816bb84d>] register_pernet_operations+0x10d/0x1b0
[   30.736233]  [<ffffffff816bb918>] register_pernet_subsys+0x28/0x40
[   30.736237]  [<ffffffffa07e6055>] nf_conntrack_standalone_init+0x55/0x1000 [nf_conntrack]
[   30.736238]  [<ffffffff810003e3>] do_one_initcall+0xb3/0x1f0
[   30.736240]  [<ffffffff81107a5f>] ? rcu_read_lock_sched_held+0x7f/0x90
[   30.736241]  [<ffffffff81223075>] ? kmem_cache_alloc_trace+0x2c5/0x330
[   30.736242]  [<ffffffff811b17ba>] ? do_init_module+0x27/0x1d7
[   30.736243]  [<ffffffff811b17f2>] do_init_module+0x5f/0x1d7
[   30.736245]  [<ffffffff811360df>] load_module+0x212f/0x2850
[   30.736246]  [<ffffffff81132680>] ? __symbol_put+0xa0/0xa0
[   30.736248]  [<ffffffff8123ce49>] ? vfs_read+0x119/0x130
[   30.736250]  [<ffffffff81136a96>] SYSC_finit_module+0xe6/0x120
[   30.736252]  [<ffffffff81136aee>] SyS_finit_module+0xe/0x10
[   30.736252]  [<ffffffff81003101>] do_syscall_64+0x61/0x170
[   30.736253]  [<ffffffff8180a75a>] entry_SYSCALL64_slow_path+0x25/0x25
