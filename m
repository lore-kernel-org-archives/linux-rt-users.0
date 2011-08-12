From: Clark Williams <williams@redhat.com>
Subject: perf backtrace  with 3.0.1-rt9
Date: Fri, 12 Aug 2011 14:39:30 -0500
Message-ID: <20110812143930.5cd2d5b8@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/d_8_2WdAR3wM31xkSkU7rzF"; protocol="application/pgp-signature"
Cc: RT <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62450 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066Ab1HLTjr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Aug 2011 15:39:47 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/d_8_2WdAR3wM31xkSkU7rzF
Content-Type: multipart/mixed; boundary="MP_/mG+m3r_sEnaIkww7cJdJPdG"

--MP_/mG+m3r_sEnaIkww7cJdJPdG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Peter (et al),

Attached is another backtrace while running perf, this time on
3.0.1-rt9:

$ sudo perf record rteval --duration=3D30m

The rteval python script is really just an evolution of Ingo's old
'dohell' script. Kicks off cyclictest with a measurement thread per
core, then runs an endless kernel make -j<n*2> (where n is the number of
cpu cores) and a large number of hackbench invocations. You can get it
at:

 git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rteval.git

While the perf record was going, I kicked off perf top in another
window. Took about 10-15min on a quad-core Opteron box. Got three
warnings and then things went seriously downhill from there.=20

Let me know if I can get you any more information.

Clark




--MP_/mG+m3r_sEnaIkww7cJdJPdG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=splat.txt

WARNING: at kernel/events/core.c:1976 task_ctx_sched_out+0x57/0x7d()
Hardware name: empty
Modules linked in: nfs lockd auth_rpcgss nfs_acl sunrpc ipt_REJECT nf_connt=
rack_ipv4 nf_defrag_ipv4 iptable_filter ip_tables ip6t_REJECT xt_tcpudp nf_=
conntrack_ipv6 nf_defrag_ipv6 xt_state ip6table_filter ip6_tables x_tables =
ipv6 dm_mirror dm_region_hash dm_log lm87 hwmon_vid hwmon microcode serio_r=
aw pcspkr edac_core sfc mtd i2c_algo_bit mdio forcedeth sg i2c_nforce2 i2c_=
core ext4 mbcache jbd2 crc16 sd_mod crc_t10dif sr_mod cdrom sata_nv pata_ac=
pi ata_generic pata_amd libata ehci_hcd ohci_hcd button [last unloaded: scs=
i_wait_scan]
Pid: 21620, comm: sh Not tainted 3.0.1-rt9.7.el6rt.x86_64 #1
Call Trace:
 [<ffffffff81044672>] warn_slowpath_common+0x85/0x9d
 [<ffffffff810446a4>] warn_slowpath_null+0x1a/0x1c
 [<ffffffff810be49a>] task_ctx_sched_out+0x57/0x7d
 [<ffffffff810c5283>] ? perf_event_comm+0x46/0x35b
 [<ffffffff810c52bc>] perf_event_comm+0x7f/0x35b
 [<ffffffff81039480>] ? get_parent_ip+0x11/0x41
 [<ffffffff81039480>] ? get_parent_ip+0x11/0x41
 [<ffffffff813b8837>] ? sub_preempt_count+0x97/0xab
 [<ffffffff8111704c>] set_task_comm+0x51/0x58
 [<ffffffff81117136>] setup_new_exec+0xe3/0x294
 [<ffffffff81151532>] load_elf_binary+0x330/0x171a
 [<ffffffff8103f812>] ? migrate_enable+0x138/0x14a
 [<ffffffff8114edb6>] ? load_misc_binary+0x17c/0x366
 [<ffffffff813b8837>] ? sub_preempt_count+0x97/0xab
 [<ffffffff8103532e>] ? need_resched+0x23/0x2d
 [<ffffffff813b4170>] ? preempt_schedule_irq+0x81/0x87
 [<ffffffff813b5c06>] ? retint_kernel+0x26/0x30
 [<ffffffff81039480>] ? get_parent_ip+0x11/0x41
 [<ffffffff813b8837>] ? sub_preempt_count+0x97/0xab
 [<ffffffff81117d5d>] search_binary_handler+0xb2/0x256
 [<ffffffff81151202>] ? set_brk+0xed/0xed
 [<ffffffff8111808a>] do_execve_common+0x189/0x2af
 [<ffffffff8110573d>] ? kmem_cache_alloc+0xea/0x172
 [<ffffffff81118244>] do_execve+0x43/0x45
 [<ffffffff8100918d>] sys_execve+0x43/0x5a
 [<ffffffff813bbd9c>] stub_execve+0x6c/0xc0
---[ end trace 0000000000000002 ]---
------------[ cut here ]------------
WARNING: at arch/x86/kernel/cpu/perf_event.c:1161 x86_pmu_start+0x5c/0x10c()
Hardware name: empty
Modules linked in: nfs lockd auth_rpcgss nfs_acl sunrpc ipt_REJECT nf_connt=
rack_ipv4 nf_defrag_ipv4 iptable_filter ip_tables ip6t_REJECT xt_tcpudp nf_=
conntrack_ipv6 nf_defrag_ipv6 xt_state ip6table_filter ip6_tables x_tables =
ipv6 dm_mirror dm_region_hash dm_log lm87 hwmon_vid hwmon microcode serio_r=
aw pcspkr edac_core sfc mtd i2c_algo_bit mdio forcedeth sg i2c_nforce2 i2c_=
core ext4 mbcache jbd2 crc16 sd_mod crc_t10dif sr_mod cdrom sata_nv pata_ac=
pi ata_generic pata_amd libata ehci_hcd ohci_hcd button [last unloaded: scs=
i_wait_scan]
Pid: 5644, comm: cyclictest Tainted: G        W   3.0.1-rt9.7.el6rt.x86_64 =
#1
Call Trace:
 <IRQ>  [<ffffffff81044672>] warn_slowpath_common+0x85/0x9d
 [<ffffffff810446a4>] warn_slowpath_null+0x1a/0x1c
 [<ffffffff8100fc47>] x86_pmu_start+0x5c/0x10c
 [<ffffffff8100fea8>] x86_pmu_enable+0x1b1/0x25a
 [<ffffffff810bd851>] perf_pmu_enable+0x31/0x36
 [<ffffffff810c4461>] perf_event_task_tick+0x1e4/0x21c
 [<ffffffff8103a80c>] scheduler_tick+0x18b/0x1f2
 [<ffffffff810523fd>] update_process_times+0x36/0x57
 [<ffffffff810703ac>] tick_sched_timer+0xfc/0x125
 [<ffffffff8106543e>] __run_hrtimer+0xc0/0x15f
 [<ffffffff810702b0>] ? tick_setup_sched_timer+0xdc/0xdc
 [<ffffffff81065771>] hrtimer_interrupt+0xeb/0x1d6
 [<ffffffff813b88fd>] ? add_preempt_count+0xb2/0xb7
 [<ffffffff813bd338>] smp_apic_timer_interrupt+0x85/0x98
 [<ffffffff813bc313>] apic_timer_interrupt+0x13/0x20
 <EOI>  [<ffffffff813bba74>] ? sysret_audit+0x16/0x20
---[ end trace 0000000000000003 ]---
------------[ cut here ]------------
WARNING: at arch/x86/kernel/cpu/perf_event.c:1243 x86_pmu_stop+0x79/0xae()
Hardware name: empty
Modules linked in: nfs lockd auth_rpcgss nfs_acl sunrpc ipt_REJECT nf_connt=
rack_ipv4 nf_defrag_ipv4 iptable_filter ip_tables ip6t_REJECT xt_tcpudp nf_=
conntrack_ipv6 nf_defrag_ipv6 xt_state ip6table_filter ip6_tables x_tables =
ipv6 dm_mirror dm_region_hash dm_log lm87 hwmon_vid hwmon microcode serio_r=
aw pcspkr edac_core sfc mtd i2c_algo_bit mdio forcedeth sg i2c_nforce2 i2c_=
core ext4 mbcache jbd2 crc16 sd_mod crc_t10dif sr_mod cdrom sata_nv pata_ac=
pi ata_generic pata_amd libata ehci_hcd ohci_hcd button [last unloaded: scs=
i_wait_scan]
Pid: 22341, comm: hackbench Tainted: G        W   3.0.1-rt9.7.el6rt.x86_64 =
#1
Call Trace:
 [<ffffffff81044672>] warn_slowpath_common+0x85/0x9d
 [<ffffffff810446a4>] warn_slowpath_null+0x1a/0x1c
 [<ffffffff8100f752>] x86_pmu_stop+0x79/0xae
 [<ffffffff8100ff94>] x86_pmu_del+0x43/0xbe
 [<ffffffff810bd6cd>] event_sched_out+0x95/0xde
 [<ffffffff810bd739>] group_sched_out+0x23/0x71
 [<ffffffff810be41b>] ctx_sched_out+0x93/0xbb
 [<ffffffff810c04fe>] __perf_event_task_sched_out+0x2b7/0x2f7
 [<ffffffff810c051c>] ? __perf_event_task_sched_out+0x2d5/0x2f7
 [<ffffffff8103d3bd>] perf_event_task_sched_out+0x59/0x67
 [<ffffffff810356a3>] ? cpuacct_charge+0x5b/0x64
 [<ffffffff811cd428>] ? rb_insert_color+0x68/0xe5
 [<ffffffff810385e5>] ? pick_next_task_rt+0x8c/0xb3
 [<ffffffff813b3920>] __schedule+0x3f7/0x58e
 [<ffffffff81039480>] ? get_parent_ip+0x11/0x41
 [<ffffffff813b414c>] preempt_schedule_irq+0x5d/0x87
 [<ffffffff813b5c06>] retint_kernel+0x26/0x30
 [<ffffffff81102e5f>] ? free_block+0x5a/0x10f
 [<ffffffff81102e42>] ? free_block+0x3d/0x10f
 [<ffffffff8110334d>] __cache_free+0x180/0x1c6
 [<ffffffff813b535e>] ? rt_spin_lock+0x24/0x26
 [<ffffffff81102d48>] kmem_cache_free+0x6e/0xc7
 [<ffffffff81303933>] __kfree_skb+0x7d/0x82
 [<ffffffff813039af>] consume_skb+0x77/0x7c
 [<ffffffff8138d1ca>] unix_stream_recvmsg+0x594/0x63f
 [<ffffffff812f9049>] __sock_recvmsg_nosec+0x6a/0x73
 [<ffffffff812f9a3f>] __sock_recvmsg+0x4e/0x59
 [<ffffffff812f9b3c>] sock_aio_read+0xf2/0x106
 [<ffffffff8118cddd>] ? file_has_perm+0xa7/0xc9
 [<ffffffff8111107d>] do_sync_read+0xcb/0x108
 [<ffffffff8118a47a>] ? fsnotify_perm+0x66/0x72
 [<ffffffff8118a4e7>] ? security_file_permission+0x2e/0x33
 [<ffffffff81111b21>] vfs_read+0xbe/0x107
 [<ffffffff81103aa9>] ? kfree+0xcf/0xd5
 [<ffffffff81111c2d>] sys_read+0x4a/0x71
 [<ffffffff813bb942>] system_call_fastpath+0x16/0x1b
---[ end trace 0000000000000004 ]---
Uhhuh. NMI received for unknown reason 2d on CPU 2.
Do you have a strange power saving mode enabled?
Dazed and confused, but trying to continue
general protection fault: 0000 [#1] PREEMPT SMP=20
CPU 0=20
Modules linked in: nfs lockd auth_rpcgss nfs_acl sunrpc ipt_REJECT nf_connt=
rack_ipv4 nf_defrag_ipv4 iptable_filter ip_tables ip6t_REJECT xt_tcpudp nf_=
conntrack_ipv6 nf_defrag_ipv6 xt_state ip6table_filter ip6_tables x_tables =
ipv6 dm_mirror dm_region_hash dm_log lm87 hwmon_vid hwmon microcode serio_r=
aw pcspkr edac_core sfc mtd i2c_algo_bit mdio forcedeth sg i2c_nforce2 i2c_=
core ext4 mbcache jbd2 crc16 sd_mod crc_t10dif sr_mod cdrom sata_nv pata_ac=
pi ata_generic pata_amd libata ehci_hcd ohci_hcd button [last unloaded: scs=
i_wait_scan]

Pid: 23657, comm: hackbench Tainted: G        W   3.0.1-rt9.7.el6rt.x86_64 =
#1 empty empty/TYAN Transport GT20-B2925/B2925-E
RIP: 0010:[<ffffffff810c0177>]  [<ffffffff810c0177>] perf_event_update_user=
page+0x24/0xcf
RSP: 0000:ffff88011fc06d58  EFLAGS: 00010006
RAX: 2d2d2d2d2d2d2d2d RBX: ffff8800967a4c00 RCX: 00000000c0010005
RDX: 000000000000ffff RSI: 00000000a9003a01 RDI: 0000000000000001
RBP: ffff88011fc06d68 R08: 0000000000000000 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: ffffffffa9003a01 R14: 00000000a9003a01 R15: ffff88011fc09838
FS:  00007fbf34a31700(0000) GS:ffff88011fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007fbf34a323dc CR3: 000000009bba6000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process hackbench (pid: 23657, threadinfo ffff8800730b6000, task ffff8800ac=
5a8740)
Stack:
 ffff8800967a4c00 0000000000000001 ffff88011fc06d98 ffffffff8100fbdf
 0000000000000000 ffff88011fc09630 0000000000000001 ffff8800967a4c00
 ffff88011fc06e48 ffffffff8101197b ffff88011fc06f58 ffff88011fc09830
Call Trace:
 <NMI>=20
 [<ffffffff8100fbdf>] x86_perf_event_set_period+0x125/0x131
 [<ffffffff8101197b>] x86_pmu_handle_irq+0xc8/0x122
 [<ffffffff810943ba>] ? audit_syscall_exit+0xc7/0x14c
 [<ffffffff813b6e34>] perf_event_nmi_handler+0x39/0x81
 [<ffffffff813b8939>] notifier_call_chain+0x37/0x63
 [<ffffffff813b89a2>] __atomic_notifier_call_chain+0x3d/0x4f
 [<ffffffff813b89c8>] atomic_notifier_call_chain+0x14/0x16
 [<ffffffff813b89f8>] notify_die+0x2e/0x30
 [<ffffffff813b6502>] do_nmi+0x6c/0x215
 [<ffffffff813b5fd0>] nmi+0x20/0x30
 <<EOE>>=20
Code: e8 ff b9 fd ff c9 c3 55 48 89 e5 41 54 53 48 89 fb e8 8f ae fd ff 48 =
8b 83 40 02 00 00 48 85 c0 0f 84 a6 00 00 00 bf 01 00 00 00 <4c> 8b 60 58 e=
8 cb 86 2f 00 41 ff 44 24 08 f6 83 48 01 00 00 01=20
RIP  [<ffffffff810c0177>] perf_event_update_userpage+0x24/0xcf
 RSP <ffff88011fc06d58>
---[ end trace 0000000000000005 ]---
Kernel panic - not syncing: Fatal exception in interrupt
Pid: 23657, comm: hackbench Tainted: G      D W   3.0.1-rt9.7.el6rt.x86_64 =
#1
Call Trace:
 <NMI>  [<ffffffff813b32df>] panic+0x9b/0x1b2
 [<ffffffff813b686b>] oops_end+0xd8/0xe8
 [<ffffffff81004fdb>] die+0x5a/0x63
 [<ffffffff813b648e>] do_general_protection+0x143/0x14b
 [<ffffffff813b5ce5>] general_protection+0x25/0x30
 [<ffffffff810c0177>] ? perf_event_update_userpage+0x24/0xcf
 [<ffffffff810c0162>] ? perf_event_update_userpage+0xf/0xcf
 [<ffffffff8100fbdf>] x86_perf_event_set_period+0x125/0x131
 [<ffffffff8101197b>] x86_pmu_handle_irq+0xc8/0x122
 [<ffffffff810943ba>] ? audit_syscall_exit+0xc7/0x14c
 [<ffffffff813b6e34>] perf_event_nmi_handler+0x39/0x81
 [<ffffffff813b8939>] notifier_call_chain+0x37/0x63
 [<ffffffff813b89a2>] __atomic_notifier_call_chain+0x3d/0x4f
 [<ffffffff813b89c8>] atomic_notifier_call_chain+0x14/0x16
 [<ffffffff813b89f8>] notify_die+0x2e/0x30
 [<ffffffff813b6502>] do_nmi+0x6c/0x215
 [<ffffffff813b5fd0>] nmi+0x20/0x30
 <<EOE>>=20
------------[ cut here ]------------
kernel BUG at arch/x86/kernel/traps.c:436!
invalid opcode: 0000 [#2] PREEMPT SMP=20
CPU 0=20
Modules linked in: nfs lockd auth_rpcgss nfs_acl sunrpc ipt_REJECT nf_connt=
rack_ipv4 nf_defrag_ipv4 iptable_filter ip_tables ip6t_REJECT xt_tcpudp nf_=
conntrack_ipv6 nf_defrag_ipv6 xt_state ip6table_filter ip6_tables x_tables =
ipv6 dm_mirror dm_region_hash dm_log lm87 hwmon_vid hwmon microcode serio_r=
aw pcspkr edac_core sfc mtd i2c_algo_bit mdio forcedeth sg i2c_nforce2 i2c_=
core ext4 mbcache jbd2 crc16 sd_mod crc_t10dif sr_mod cdrom sata_nv pata_ac=
pi ata_generic pata_amd libata ehci_hcd ohci_hcd button [last unloaded: scs=
i_wait_scan]

Pid: 23657, comm: hackbench Tainted: G      D W   3.0.1-rt9.7.el6rt.x86_64 =
#1 empty empty/TYAN Transport GT20-B2925/B2925-E
RIP: 0010:[<ffffffff813b64bd>]  [<ffffffff813b64bd>] do_nmi+0x27/0x215
RSP: 0000:ffff88011fc06f28  EFLAGS: 00010002
RAX: ffff8800730b7fd8 RBX: 0000000000000001 RCX: 00000000c0000101
RDX: 00000000ffff8801 RSI: ffffffffffffffff RDI: ffff88011fc06f58
RBP: ffff88011fc06f48 R08: 0000000000000000 R09: 000000000000eb9d
R10: ffff88011fc06b78 R11: 0000000000000078 R12: ffff88011fc06f58
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88011fc09838
FS:  00007fbf34a31700(0000) GS:ffff88011fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007fbf34a323dc CR3: 000000009bba6000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process hackbench (pid: 23657, threadinfo ffff8800730b6000, task ffff8800ac=
5a8740)
Stack:
 0000000000000000 0000000000000001 0000000000000082 0000000000000000
 ffff88011fc06c08 ffffffff813b5fd0 ffff88011fc09838 0000000000000000
 0000000000000000 0000000000000082 ffff88011fc06c08 0000000000000000
Call Trace:
 <NMI>=20
 [<ffffffff813b5fd0>] nmi+0x20/0x30
 [<ffffffff813b33b4>] ? panic+0x170/0x1b2
 <<EOE>>=20
Code: 41 5d c9 c3 55 48 89 e5 41 55 41 54 49 89 fc 53 48 83 ec 08 e8 d3 88 =
c6 ff 65 48 8b 04 25 c8 95 00 00 f6 80 47 e0 ff ff 04 74 04 <0f> 0b eb fe b=
f 00 00 01 04 e8 80 23 00 00 65 ff 04 25 c4 ec 00=20
RIP  [<ffffffff813b64bd>] do_nmi+0x27/0x215
 RSP <ffff88011fc06f28>
---[ end trace 0000000000000006 ]---
Kernel panic - not syncing: Fatal exception in interrupt
Pid: 23657, comm: hackbench Tainted: G      D W   3.0.1-rt9.7.el6rt.x86_64 =
#1
Call Trace:
 <NMI>  [<ffffffff813b32df>] panic+0x9b/0x1b2
 [<ffffffff813b686b>] oops_end+0xd8/0xe8
 [<ffffffff81004fdb>] die+0x5a/0x63
 [<ffffffff813b62cc>] do_trap+0x121/0x130
 [<ffffffff8100330b>] do_invalid_op+0xaa/0xb3
 [<ffffffff813b64bd>] ? do_nmi+0x27/0x215
 [<ffffffff813b6e34>] ? perf_event_nmi_handler+0x39/0x81
 [<ffffffff813bc8db>] invalid_op+0x1b/0x20
 [<ffffffff813b64bd>] ? do_nmi+0x27/0x215
 [<ffffffff813b64ab>] ? do_nmi+0x15/0x215
 [<ffffffff813b5fd0>] nmi+0x20/0x30
 [<ffffffff813b33b4>] ? panic+0x170/0x1b2
 <<EOE>>=20

--MP_/mG+m3r_sEnaIkww7cJdJPdG--

--Sig_/d_8_2WdAR3wM31xkSkU7rzF
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk5FgXIACgkQHyuj/+TTEp2rewCeOeGKT/eTv/BcK+j/oleDsXmo
K8MAn0lpoIn9fXXHK/I9htYsWQKnom5f
=FfEO
-----END PGP SIGNATURE-----

--Sig_/d_8_2WdAR3wM31xkSkU7rzF--
