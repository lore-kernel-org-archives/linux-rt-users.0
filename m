From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.11.12-rt9
Date: Sat, 05 Aug 2017 08:13:03 +0200
Message-ID: <1501913583.7917.42.camel@gmx.de>
References: <20170804173823.lzuhnejlnxczr2lj@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170804173823.lzuhnejlnxczr2lj@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2017-08-04 at 19:38 +0200, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v4.11.12-rt9 patch set. 
> 
> Changes since v4.11.12-rt8:
> 
>   - CPU hotplug could be rock solid now. Yes. The rewrite of the hotplug
>     related parts for RT including rwlock's implementation over the last
>     few weeks looks good. 'good' means that Steven's CPU-hotplug test script
>     run a x86 box with two nodes without hanging for over a week.

Woohoo!

Steven's script annoyed the scheduler here, but woohoo regardless, it
hasn't yet made boom, or stopped dead in its tracks.  I'll give it some
exercise on my 64 core box, where death has never (modulo fugly hacks
that survived 30 hrs of hell.. once) been more than minutes away.

[  190.589248] ------------[ cut here ]------------
[  190.589273] WARNING: CPU: 1 PID: 5679 at kernel/sched/core.c:6346 __might_sleep+0x80/0x90
[  190.589277] do not call blocking ops when !TASK_RUNNING; state=2 set at [<ffffffff810d2c45>] __finish_swait+0x5/0x60
[  190.589279] Modules linked in: x86_pkg_temp_thermal(E-) fuse(E) ebtable_filter(E) ebtables(E) rpcsec_gss_krb5(E) nfsv4(E) dns_resolver(E) nfs(E) fscache(E) xt_pkttype(E) xt_physdev(E) af_packet(E) br_netfilter(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) ip6t_REJECT(E) xt_tcpudp(E) nf_conntrack_ipv6(E) nf_defrag_ipv6(E) ip6table_raw(E) ipt_REJECT(E) iptable_raw(E) xt_CT(E) iptable_filter(E) ip6table_mangle(E) nf_conntrack_netbios_ns(E) nf_conntrack_broadcast(E) nf_conntrack_ipv4(E) nf_defrag_ipv4(E) ip_tables(E) xt_conntrack(E) nf_conntrack(E) libcrc32c(E) ip6table_filter(E) ip6_tables(E) x_tables(E) nls_iso8859_1(E) nls_cp437(E) intel_rapl(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) kvm(E) irqbypass(E) joydev(E) snd_hda_codec_realtek(E) snd_hda_codec_hdmi(E) snd_hda
 _codec_generic(E)
[  190.589300]  crct10dif_pclmul(E) crc32_pclmul(E) snd_hda_intel(E) crc32c_intel(E) snd_hda_codec(E) snd_hda_core(E) intel_spi_platform(E) intel_spi(E) spi_nor(E) snd_hwdep(E) ghash_clmulni_intel(E) battery(E) pcbc(E) r8169(E) mtd(E) mii(E) snd_pcm(E) iTCO_wdt(E) iTCO_vendor_support(E) aesni_intel(E) snd_timer(E) aes_x86_64(E) crypto_simd(E) snd(E) mei_me(E) lpc_ich(E) thermal(E) glue_helper(E) tpm_infineon(E) soundcore(E) i2c_i801(E) mfd_core(E) cryptd(E) mei(E) shpchp(E) pcspkr(E) fan(E) intel_smartconnect(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) sunrpc(E) sr_mod(E) cdrom(E) hid_logitech_hidpp(E) hid_logitech_dj(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) nouveau(E) wmi(E) i2c_algo_bit(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) fb_sys_fops(E) ehc
 i_pci(E) xhci_pci(E)
[  190.589324]  ahci(E) ehci_hcd(E) ttm(E) xhci_hcd(E) libahci(E) drm(E) libata(E) usbcore(E) video(E) button(E) sd_mod(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio_pci(E) virtio_ring(E) virtio(E) ext4(E) crc16(E) jbd2(E) mbcache(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) efivarfs(E) autofs4(E)
[  190.589340] CPU: 1 PID: 5679 Comm: stress-cpu-hotp Tainted: G            E   4.11.12-rt9-virgin #11
[  190.589341] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[  190.589341] Call Trace:
[  190.589345]  dump_stack+0x85/0xc8
[  190.589348]  __warn+0xec/0x110
[  190.589351]  warn_slowpath_fmt+0x4f/0x60
[  190.589353]  ? __finish_swait+0x5/0x60
[  190.589354]  ? __finish_swait+0x5/0x60
[  190.589355]  __might_sleep+0x80/0x90
[  190.589358]  rt_mutex_lock_state+0x25/0x60
[  190.589360]  ? cpu_stop_queue_work+0xb0/0xb0
[  190.589361]  rt_mutex_lock+0x13/0x20
[  190.589362]  _mutex_lock+0x39/0x40
[  190.589363]  ? stop_cpus+0x23/0x50
[  190.589365]  stop_cpus+0x23/0x50
[  190.589366]  ? cpuhp_invoke_callback+0x9d0/0x9d0
[  190.589367]  stop_machine_cpuslocked+0xed/0x130
[  190.589368]  ? cpuhp_invoke_callback+0x9d0/0x9d0
[  190.589370]  takedown_cpu+0x80/0x110
[  190.589372]  ? cpuhp_complete_idle_dead+0x20/0x20
[  190.589372]  cpuhp_invoke_callback+0x248/0x9d0
[  190.589376]  cpuhp_down_callbacks+0x42/0x80
[  190.589378]  _cpu_down+0xc5/0x100
[  190.589380]  do_cpu_down+0x3c/0x60
[  190.589381]  cpu_down+0x10/0x20
[  190.589384]  cpu_subsys_offline+0x14/0x20
[  190.589385]  device_offline+0x8a/0xb0
[  190.589387]  online_store+0x40/0x80
[  190.589389]  dev_attr_store+0x18/0x30
[  190.589391]  sysfs_kf_write+0x44/0x60
[  190.589392]  kernfs_fop_write+0x13c/0x1d0
[  190.589395]  __vfs_write+0x28/0x140
[  190.589397]  ? rcu_read_lock_sched_held+0x98/0xa0
[  190.589398]  ? rcu_sync_lockdep_assert+0x32/0x60
[  190.589399]  ? __sb_start_write+0x1d2/0x290
[  190.589400]  ? vfs_write+0x196/0x1f0
[  190.589402]  ? security_file_permission+0x3b/0xc0
[  190.589404]  vfs_write+0xc7/0x1f0
[  190.589406]  ? trace_hardirqs_on_caller+0xf9/0x1c0
[  190.589408]  SyS_write+0x49/0xa0
[  190.589410]  entry_SYSCALL_64_fastpath+0x1f/0xc2
[  190.589411] RIP: 0033:0x7fb5065a92d0
[  190.589411] RSP: 002b:00007ffe9afe2988 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  190.589412] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007fb5065a92d0
[  190.589413] RDX: 0000000000000002 RSI: 00007fb5070ff000 RDI: 0000000000000001
[  190.589413] RBP: 00007ffe9afe2980 R08: 000000000000000a R09: 00007fb5070c2700
[  190.589414] R10: 0000000000bc2580 R11: 0000000000000246 R12: 0000000000000001
[  190.589414] R13: 0000000000000009 R14: 000000000000000a R15: 0000000000bc44b0
[  190.589419] ---[ end trace 0000000000000002 ]---
