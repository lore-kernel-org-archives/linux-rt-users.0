From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Tue, 09 Jun 2015 09:45:43 -0700
Message-ID: <55771837.4020007@localhost>
References: <20150519213923.GA26363@linutronix.de>	<20150526083449.5357059b@sluggy>	<20150526093832.558e2e46@gandalf.local.home>	<20150526084802.2cfd055b@sluggy>	<20150526111924.20836deb@gandalf.local.home> <20150526104343.51fad474@sluggy> <5564CC80.3080101@localhost> <5567C741.5010007@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020800060608000907060304"
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5567C741.5010007@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------020800060608000907060304
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 05/28/2015 06:56 PM, Fernando Lopez-Lezcano wrote:
> Oh well. Second time the machine hangs in two days in the same way
> (otherwise very stable running 3.18.x-rty)
>
> (this is a bumblebee + bbswitch graphics laptop - argh, if I had known
> better...)
>
> ----
> May 28 18:49:21 localhost kernel: ------------[ cut here ]------------
> May 28 18:49:21 localhost kernel: kernel BUG at mm/memcontrol.c:5848!
> May 28 18:49:21 localhost kernel: invalid opcode: 0000 [#1] PREEMPT SMP
...
> ----

This is still happening, about once a day. John Dulaney help me set up a 
crash kernel dump (thanks!) so now I have a kernel core dump for this 
one, I'll try to post more details tomorrow. Let me know if there is 
anything in particular I should look at.

I'm attaching another backtrace on a different machine (older desktop), 
slightly different but same end result.

-- Fernando

--------------020800060608000907060304
Content-Type: text/plain; charset=UTF-8;
 name="trace.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="trace.txt"

Jun  9 03:49:19 localhost kernel: ------------[ cut here ]------------
Jun  9 03:49:19 localhost kernel: kernel BUG at mm/memcontrol.c:5848!
Jun  9 03:49:19 localhost kernel: invalid opcode: 0000 [#1] PREEMPT SMP 
Jun  9 03:49:19 localhost kernel: Modules linked in: bnep bluetooth rfkill fuse tun act_police cls_basic cls_flow cls_fw cls_u32 sch_tbf sch_prio sch_htb sch_hfsc sch_ingress sch_sfq xt_CHECKSUM ipt_rpfilter xt_statistic xt_CT nf_log_ipv4 nf_log_common xt_LOG xt_connlimit xt_realm xt_addrtype xt_comment xt_recent xt_nat ipt_MASQUERADE nf_nat_masquerade_ipv4 ipt_ECN ipt_CLUSTERIP ipt_ah xt_set ip_set nf_nat_tftp nf_nat_snmp_basic nf_conntrack_snmp nf_nat_sip nf_nat_pptp nf_nat_proto_gre nf_nat_irc nf_nat_h323 nf_nat_ftp nf_nat_amanda ts_kmp nf_conntrack_amanda nf_conntrack_sane ebtable_nat nf_conntrack_tftp ebtables nf_conntrack_sip nf_conntrack_proto_udplite nf_conntrack_proto_sctp nf_conntrack_pptp nf_conntrack_proto_gre nf_conntrack_netlink nf_conntrack_netbios_ns nf_conntrack_broadcast 
 nf_conntrack_irc nf_conntrack_h323
Jun  9 03:49:19 localhost kernel: nf_conntrack_ftp xt_TPROXY xt_time xt_TCPMSS xt_tcpmss xt_sctp xt_policy xt_pkttype xt_physdev br_netfilter bridge stp llc xt_owner xt_NFQUEUE xt_NFLOG nfnetlink_log xt_multiport xt_mark xt_mac xt_limit xt_length xt_iprange xt_helper xt_hashlimit xt_DSCP xt_dscp xt_dccp xt_connmark xt_CLASSIFY xt_AUDIT xt_state iptable_raw iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 iptable_mangle nfnetlink nfsv3 nfs_acl auth_rpcgss nfsv4 dns_resolver nfs lockd grace sunrpc fscache ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 xt_conntrack nf_conntrack ip6table_filter ip6_tables w83627ehf hwmon_vid iTCO_wdt iTCO_vendor_support gpio_ich raid1 coretemp kvm_intel kvm hid_logitech_hidpp serio_raw snd_ice1712 snd_cs8427 snd_i2c snd_ice17xx_ak4x
 xx snd_ak4xxx_adda snd_mpu401_uart
Jun  9 03:49:19 localhost kernel: snd_rawmidi snd_ac97_codec ac97_bus snd_seq snd_seq_device snd_pcm snd_timer snd lpc_ich soundcore i2c_i801 mfd_core shpchp acpi_cpufreq binfmt_misc hid_logitech_dj ata_generic firewire_ohci radeon pata_acpi firewire_core crc_itu_t sata_sil24 i2c_algo_bit drm_kms_helper sky2 r8169 pata_marvell mii ttm drm
Jun  9 03:49:19 localhost kernel: CPU: 2 PID: 10424 Comm: prelink Not tainted 4.0.4-100.rt1.3.fc20.ccrma.x86_64+rt #1
Jun  9 03:49:19 localhost kernel: Hardware name: System manufacturer P5K/EPU/P5K/EPU, BIOS 0604    06/19/2008
Jun  9 03:49:19 localhost kernel: task: ffff8802225e1520 ti: ffff8801256c8000 task.ti: ffff8801256c8000
Jun  9 03:49:19 localhost kernel: RIP: 0010:[<ffffffff812112c2>]  [<ffffffff812112c2>] mem_cgroup_swapout+0x102/0x110
Jun  9 03:49:19 localhost kernel: RSP: 0018:ffff8801256cb288  EFLAGS: 00010202
Jun  9 03:49:19 localhost kernel: RAX: 0000000000000246 RBX: ffffea0008be7ec0 RCX: 0000000000000000
Jun  9 03:49:19 localhost kernel: RDX: 0000000000000000 RSI: ffff8801256cb248 RDI: ffffffff820236d0
Jun  9 03:49:19 localhost kernel: RBP: ffff8801256cb298 R08: ffffea0008be7ee0 R09: ffff8801256cb498
Jun  9 03:49:19 localhost kernel: R10: ffff8801256cbfd8 R11: 0000000000000002 R12: ffff880227013800
Jun  9 03:49:19 localhost kernel: R13: ffffffff81c652b8 R14: 0000000000000001 R15: ffffffff81c652a0
Jun  9 03:49:19 localhost kernel: FS:  0000000001ad8900(0063) GS:ffff88022fd00000(0000) knlGS:0000000000000000
Jun  9 03:49:19 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jun  9 03:49:19 localhost kernel: CR2: 0000000002131878 CR3: 000000014a4f3000 CR4: 00000000000007e0
Jun  9 03:49:19 localhost kernel: Stack:
Jun  9 03:49:19 localhost kernel: ffffea0008be7ec0 00000000000c2a0d ffff8801256cb2d8 ffffffff811b60c7
Jun  9 03:49:19 localhost kernel: 0000000000000000 ffff8801256cb738 ffffea0008be7ec0 ffff8801256cb4b0
Jun  9 03:49:19 localhost kernel: ffffea0008be7ee0 ffffffff81c652a0 ffff8801256cb418 ffffffff811b924f
Jun  9 03:49:19 localhost kernel: Call Trace:
Jun  9 03:49:19 localhost kernel: [<ffffffff811b60c7>] __remove_mapping+0x107/0x180
Jun  9 03:49:19 localhost kernel: [<ffffffff811b924f>] shrink_page_list+0x7df/0xb50
Jun  9 03:49:19 localhost kernel: [<ffffffff811b9bd1>] shrink_inactive_list+0x1e1/0x620
Jun  9 03:49:19 localhost kernel: [<ffffffff811ba9d5>] shrink_lruvec+0x635/0x840
Jun  9 03:49:19 localhost kernel: [<ffffffff811bacd0>] shrink_zone+0xf0/0x2f0
Jun  9 03:49:19 localhost kernel: [<ffffffff811bb265>] do_try_to_free_pages+0x175/0x450
Jun  9 03:49:19 localhost kernel: [<ffffffff811b65e8>] ? throttle_direct_reclaim+0x168/0x260
Jun  9 03:49:19 localhost kernel: [<ffffffff811bb61a>] try_to_free_pages+0xda/0x1d0
Jun  9 03:49:19 localhost kernel: [<ffffffff811adce1>] __alloc_pages_nodemask+0x531/0x980
Jun  9 03:49:19 localhost kernel: [<ffffffff811f6821>] alloc_pages_current+0x91/0x100
Jun  9 03:49:19 localhost kernel: [<ffffffff81201a87>] new_slab+0x397/0x4c0
Jun  9 03:49:19 localhost kernel: [<ffffffff8178c848>] __slab_alloc+0x429/0x54e
Jun  9 03:49:19 localhost kernel: [<ffffffff812c0efd>] ? ext4_alloc_inode+0x1d/0x280
Jun  9 03:49:19 localhost kernel: [<ffffffff812acbb7>] ? ext4_map_blocks+0x2e7/0x520
Jun  9 03:49:19 localhost kernel: [<ffffffff81201da3>] kmem_cache_alloc+0x1f3/0x270
Jun  9 03:49:19 localhost kernel: [<ffffffff812c0efd>] ext4_alloc_inode+0x1d/0x280
Jun  9 03:49:19 localhost kernel: [<ffffffff8123731d>] alloc_inode+0x1d/0xa0
Jun  9 03:49:19 localhost kernel: [<ffffffff8123856b>] iget_locked+0xdb/0x1b0
Jun  9 03:49:19 localhost kernel: [<ffffffff812adc32>] ext4_iget+0x42/0xb10
Jun  9 03:49:19 localhost kernel: [<ffffffff812ae735>] ext4_iget_normal+0x35/0x40
Jun  9 03:49:19 localhost kernel: [<ffffffff812b8977>] ext4_lookup+0x107/0x170
Jun  9 03:49:19 localhost kernel: [<ffffffff812253dd>] lookup_real+0x1d/0x50
Jun  9 03:49:19 localhost kernel: [<ffffffff81225d42>] __lookup_hash+0x42/0x60
Jun  9 03:49:19 localhost kernel: [<ffffffff8178cc17>] lookup_slow+0x45/0xab
Jun  9 03:49:19 localhost kernel: [<ffffffff81229a88>] path_lookupat+0x6d8/0x700
Jun  9 03:49:19 localhost kernel: [<ffffffff810e3a19>] ? __wake_up+0x49/0x60
Jun  9 03:49:19 localhost kernel: [<ffffffff812fc065>] ? jbd2_journal_stop+0x1e5/0x400
Jun  9 03:49:19 localhost kernel: [<ffffffff81229adb>] filename_lookup+0x2b/0xc0
Jun  9 03:49:19 localhost kernel: [<ffffffff8122ce03>] user_path_at_empty+0x63/0xc0
Jun  9 03:49:19 localhost kernel: [<ffffffff81249c82>] ? __mark_inode_dirty+0x352/0x460
Jun  9 03:49:19 localhost kernel: [<ffffffff8122ce71>] user_path_at+0x11/0x20
Jun  9 03:49:19 localhost kernel: [<ffffffff81220363>] vfs_fstatat+0x63/0xc0
Jun  9 03:49:19 localhost kernel: [<ffffffff81220984>] SYSC_newfstatat+0x24/0x60
Jun  9 03:49:19 localhost kernel: [<ffffffff8102597c>] ? do_audit_syscall_entry+0x6c/0x70
Jun  9 03:49:19 localhost kernel: [<ffffffff81027343>] ? syscall_trace_enter_phase1+0x143/0x1a0
Jun  9 03:49:19 localhost kernel: [<ffffffff810276b6>] ? syscall_trace_leave+0xc6/0x130
Jun  9 03:49:19 localhost kernel: [<ffffffff8179500a>] ? int_check_syscall_exit_work+0x34/0x3d
Jun  9 03:49:19 localhost kernel: [<ffffffff81220bee>] SyS_newfstatat+0xe/0x10
Jun  9 03:49:19 localhost kernel: [<ffffffff81794dc9>] system_call_fastpath+0x12/0x17
Jun  9 03:49:19 localhost kernel: Code: 80 e6 80 48 0f 44 c3 e9 49 ff ff ff 48 c7 c6 7f 3e a6 81 e8 81 f6 fb ff 0f 0b 48 c7 c6 cb 67 a6 81 48 89 df e8 70 f6 fb ff 0f 0b <0f> 0b 66 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90 8b 05 
Jun  9 03:49:19 localhost kernel: RIP  [<ffffffff812112c2>] mem_cgroup_swapout+0x102/0x110
Jun  9 03:49:19 localhost kernel: RSP <ffff8801256cb288>
Jun  9 03:49:19 localhost kernel: ---[ end trace 0000000000000002 ]---

--------------020800060608000907060304--
