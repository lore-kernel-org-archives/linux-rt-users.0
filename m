From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Fri, 08 Apr 2016 15:44:04 +0200
Message-ID: <1460123044.16946.11.camel@gmail.com>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
	 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
	 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
	 <alpine.DEB.2.11.1603241140510.3978@nanos>
	 <1459405903.14336.64.camel@gmail.com>
	 <20160401211105.GE29603@linutronix.de> <1459566735.3779.36.camel@gmail.com>
	 <57068F28.8010409@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57068F28.8010409@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2016-04-07 at 18:47 +0200, Sebastian Andrzej Siewior wrote:

> just to be clear: The patch I attached did _not_ work for you.

Did you perchance mean with "Reenable migration across schedule"
reverted?  Figured it would still explode in seconds.. it did.

[  172.996232] kernel BUG at kernel/locking/rtmutex.c:1360!
[  172.996234] invalid opcode: 0000 [#1] PREEMPT SMP 
[  172.996236] Dumping ftrace buffer:
[  172.996239]    (ftrace buffer empty)
[  172.996254] Modules linked in: ebtable_filter(E) ebtables(E) fuse(E) nf_log_ipv6(E) xt_pkttype(E) xt_physdev(E) br_netfilter(E) nf_log_ipv4(E) nf_log_common(E) xt_LOG(E) xt_limit(E) af_packet(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) ip6t_REJECT(E) xt_tcpudp(E) nf_conntrack_ipv6(E) nf_defrag_ipv6(E) ip6table_raw(E) ipt_REJECT(E) iptable_raw(E) xt_CT(E) iptable_filter(E) ip6table_mangle(E) nf_conntrack_netbios_ns(E) nf_conntrack_broadcast(E) nf_conntrack_ipv4(E) nf_defrag_ipv4(E) ip_tables(E) xt_conntrack(E) nf_conntrack(E) ip6table_filter(E) ip6_tables(E) x_tables(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) intel_rapl(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) kvm(E) irqbypass(E) crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E) snd_hda_codec_hdmi(E) snd_hd
 a_codec_realtek(E)
[  172.996271]  snd_hda_codec_generic(E) drbg(E) snd_hda_intel(E) ansi_cprng(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E) aesni_intel(E) snd_pcm(E) aes_x86_64(E) lrw(E) r8169(E) mii(E) snd_timer(E) gf128mul(E) dm_mod(E) iTCO_wdt(E) iTCO_vendor_support(E) lpc_ich(E) mei_me(E) shpchp(E) snd(E) i2c_i801(E) joydev(E) pcspkr(E) serio_raw(E) glue_helper(E) ablk_helper(E) mei(E) mfd_core(E) cryptd(E) soundcore(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) processor(E) thermal(E) battery(E) fan(E) tpm_infineon(E) fjes(E) intel_smartconnect(E) sunrpc(E) efivarfs(E) ext4(E) crc16(E) mbcache(E) jbd2(E) sr_mod(E) cdrom(E) sd_mod(E) hid_logitech_hidpp(E) hid_logitech_dj(E) hid_generic(E) uas(E) usb_storage(E) usbhid(E) nouveau(E) wmi(E) i2c_algo_bit(E) drm_kms_helper(E) syscopyarea(E) sysf
 illrect(E)
[  172.996275]  ahci(E) sysimgblt(E) fb_sys_fops(E) libahci(E) ttm(E) libata(E) drm(E) video(E) button(E) sg(E) scsi_mod(E) autofs4(E)
[  172.996277] CPU: 7 PID: 6109 Comm: futex_wait Tainted: G            E   4.4.6-rt13-virgin #12
[  172.996277] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[  172.996278] task: ffff88017ce6ab80 ti: ffff8803d2e20000 task.ti: ffff8803d2e20000
[  172.996283] RIP: 0010:[<ffffffff810b5a23>]  [<ffffffff810b5a23>] task_blocks_on_rt_mutex+0x243/0x260
[  172.996284] RSP: 0018:ffff8803d2e23a38  EFLAGS: 00010092
[  172.996285] RAX: ffff8803d2e23c10 RBX: ffff88017ce6ab80 RCX: 0000000000000000
[  172.996285] RDX: 0000000000000001 RSI: ffff8803d2e23a98 RDI: ffff88017ce6b258
[  172.996286] RBP: ffff8803d2e23a68 R08: ffff8800dddc0000 R09: ffffffff81f33918
[  172.996286] R10: ffff8800dddc0001 R11: 0000000000000000 R12: ffff8800dddc0000
[  172.996287] R13: ffff8803d2e23a98 R14: ffffffff81f33900 R15: 0000000000000000
[  172.996288] FS:  00007f4017988700(0000) GS:ffff88041edc0000(0000) knlGS:0000000000000000
[  172.996288] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  172.996289] CR2: 0000000000000000 CR3: 00000003bf7f4000 CR4: 00000000001406e0
[  172.996289] Stack:
[  172.996291]  000000007ce6abe8 ffffffff81f33900 ffff8803d2e23a98 0000000000000000
[  172.996292]  0000000000000000 0000000000000000 ffff8803d2e23b08 ffffffff8162f105
[  172.996293]  0000000200000000 0000000000000296 0000000000000000 ffff8803d2e23ae8
[  172.996293] Call Trace:
[  172.996298]  [<ffffffff8162f105>] rt_mutex_slowlock+0xe5/0x290
[  172.996301]  [<ffffffff810a30e5>] ? pick_next_entity+0xa5/0x160
[  172.996303]  [<ffffffff8162f3a1>] rt_mutex_lock+0x31/0x40
[  172.996304]  [<ffffffff816308ae>] _mutex_lock+0xe/0x10
[  172.996306]  [<ffffffff81096543>] migrate_me+0x63/0x1f0
[  172.996308]  [<ffffffff81093fed>] ? finish_task_switch+0x7d/0x300
[  172.996310]  [<ffffffff8106bb25>] pin_current_cpu+0x1e5/0x2a0
[  172.996311]  [<ffffffff810942e3>] migrate_disable+0x73/0xd0
[  172.996313]  [<ffffffff8162f598>] rt_spin_lock_slowlock+0x1e8/0x2e0
[  172.996314]  [<ffffffff81630748>] rt_spin_lock+0x38/0x40
[  172.996317]  [<ffffffff810ece18>] futex_wait_setup+0x98/0x100
[  172.996318]  [<ffffffff810ecfcf>] futex_wait+0x14f/0x240
[  172.996320]  [<ffffffff810b4f36>] ? rt_mutex_dequeue_pi+0x36/0x60
[  172.996322]  [<ffffffff810b5cc6>] ? rt_mutex_adjust_prio+0x36/0x40
[  172.996323]  [<ffffffff8162f714>] ? rt_spin_lock_slowunlock+0x84/0xc0
[  172.996325]  [<ffffffff810edb81>] do_futex+0xd1/0x560
[  172.996327]  [<ffffffff81003666>] ? __switch_to+0x1d6/0x450
[  172.996329]  [<ffffffff81093fed>] ? finish_task_switch+0x7d/0x300
[  172.996330]  [<ffffffff8162d40e>] ? __schedule+0x2ae/0x7d0
[  172.996332]  [<ffffffff810ee081>] SyS_futex+0x71/0x150
[  172.996334]  [<ffffffff81066123>] ? exit_to_usermode_loop+0x4b/0xe4
[  172.996335]  [<ffffffff81630c2e>] entry_SYSCALL_64_fastpath+0x12/0x71
[  172.996349] Code: 0d 1b 54 f5 7e 74 30 65 48 8b 04 25 c4 28 01 00 48 8b 80 08 c0 ff ff f6 c4 02 75 1b b8 f5 ff ff ff e9 25 ff ff ff e8 8d f5 ff ff <0f> 0b e8 d6 b5 f4 ff e9 0e ff ff ff e8 cc b5 f4 ff b8 f5 ff ff 
[  172.996351] RIP  [<ffffffff810b5a23>] task_blocks_on_rt_mutex+0x243/0x260
[  172.996351]  RSP <ffff8803d2e23a38>
