From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [patch ]mm/zs_malloc: Fix bit spinlock replacement
Date: Mon, 17 Oct 2016 18:12:29 +0200
Message-ID: <1476720749.30636.5.camel@gmail.com>
References: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
         <1476587883.1538.12.camel@gmail.com>
         <20161017151526.c4snf4vlt6bytqrx@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1251"
Content-Transfer-Encoding: 8bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161017151526.c4snf4vlt6bytqrx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2016-10-17 at 17:15 +0200, Sebastian Andrzej Siewior wrote:
> On 2016-10-16 05:18:03 [+0200], Mike Galbraith wrote:
> > 
> > Do not alter HANDLE_SIZE, memory corruption ensues.  The handle is
> > a pointer, allocate space for the struct it points to and align it
> > ZS_ALIGN.  Also, when accessing the struct, mask HANDLE_PIN_BIT.
> 
> So this is to merged / folded into "mm/zsmalloc: Use get/put_cpu_light
> in zs_map_object()/zs_unmap_object()" which I re-did for v4.8?

Yeah.

> How was this tested?

Latest LTP.  You need latest, else it'll abort early.

> I have:
>    CONFIG_FRONTSWAP=y
>    # CONFIG_CMA is not set
>    CONFIG_ZSWAP=y
>    CONFIG_ZPOOL=y
>    CONFIG_ZBUD=m
>    CONFIG_Z3FOLD=m
>    CONFIG_ZSMALLOC=m
>    # CONFIG_PGTABLE_MAPPING is not set
>    CONFIG_ZSMALLOC_STAT=y
> 
> and
> 
>    # cat /sys/module/zswap/parameters/enabled
>    Y
>    cat /sys/module/zswap/parameters/zpool
>    zbud
>    # cat /sys/module/zswap/parameters/compressor 
>    lzo
>    # cat /sys/module/zswap/parameters/max_pool_percent 
>    20
> 
> and I do have 1GiB of swap on /dev/vdc. While I get swap to be used, I
> see no firework. Is there something wrong with my setup? I would assume
> so due to the lack of the fireworks on my side…

Run the ltp testcase, and you'll meet the below every time.  It'll
write 23 time, then explode.

[  117.527727] zram: Added device: zram0
[  132.913046] SFW2-INext-DROP-DEFLT IN=br0 OUT= MAC= SRC=fe80:0000:0000:0000:d63d:7eff:fefc:4f09 DST=ff02:0000:0000:0000:0000:0000:0000:00fb LEN=138 TC=0 HOPLIMIT=255 FLOWLBL=240223 PROTO=UDP SPT=5353 DPT=5353 LEN=98 
[  145.205893] loop: module loaded
[  145.388652] zram0: detected capacity change from 0 to 536870912
[  146.096042] BUG: unable to handle kernel paging request at ffff880389fa0000
[  146.096045] IP: [<ffffffff813aa516>] memcpy_erms+0x6/0x10
[  146.096046] PGD 2ded067 PUD 3f8f52063 PMD 38befc063 PTE 8000000389fa0161
[  146.096048] Oops: 0003 [#1] PREEMPT SMP
[  146.096050] Dumping ftrace buffer:
[  146.096053]    (ftrace buffer empty)
[  146.096064] Modules linked in: loop(E) zram(E) ebtable_filter(E) ebtables(E) fuse(E) nf_log_ipv6(E) xt_pkttype(E) xt_physdev(E) br_netfilter(E) nf_log_ipv4(E) nf_log_common(E) xt_LOG(E) xt_limit(E) af_packet(E) bridge(E) stp(E) llc(E) iscsi_ibft(E) iscsi_boot_sysfs(E) ip6t_REJECT(E) xt_tcpudp(E) nf_conntrack_ipv6(E) nf_defrag_ipv6(E) ip6table_raw(E) ipt_REJECT(E) iptable_raw(E) xt_CT(E) iptable_filter(E) ip6table_mangle(E) nf_conntrack_netbios_ns(E) nf_conntrack_broadcast(E) nf_conntrack_ipv4(E) nf_defrag_ipv4(E) ip_tables(E) xt_conntrack(E) nf_conntrack(E) ip6table_filter(E) ip6_tables(E) x_tables(E) nls_iso8859_1(E) intel_rapl(E) nls_cp437(E) intel_powerclamp(E) coretemp(E) vfat(E) fat(E) kvm_intel(E) kvm(E) pl2303(E) usbserial(E) dm_mod(E) snd_hda_codec_hdmi(E) snd_hda_codec_realtek(
 E) snd_hda_codec_generic(E)
[  146.096077]  snd_hda_intel(E) snd_hda_codec(E) irqbypass(E) sr_mod(E) cdrom(E) joydev(E) iTCO_wdt(E) crct10dif_pclmul(E) iTCO_vendor_support(E) crc32_pclmul(E) lpc_ich(E) mfd_core(E) ghash_clmulni_intel(E) aesni_intel(E) snd_hda_core(E) aes_x86_64(E) lrw(E) mei_me(E) mei(E) i2c_i801(E) gf128mul(E) i2c_smbus(E) pcspkr(E) shpchp(E) serio_raw(E) intel_smartconnect(E) tpm_infineon(E) battery(E) snd_hwdep(E) glue_helper(E) ablk_helper(E) snd_pcm(E) snd_timer(E) thermal(E) snd(E) nfsd(E) cryptd(E) fan(E) soundcore(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) sunrpc(E) efivarfs(E) hid_logitech_hidpp(E) ext4(E) crc16(E) jbd2(E) mbcache(E) hid_logitech_dj(E) sd_mod(E) uas(E) usb_storage(E) hid_generic(E) usbhid(E) crc32c_intel(E) nouveau(E) wmi(E) i2c_algo_bit(E) drm_kms_helper(E) syscopyarea(
 E) sysfillrect(E)
[  146.096081]  sysimgblt(E) ahci(E) ehci_pci(E) fb_sys_fops(E) libahci(E) xhci_pci(E) r8169(E) ehci_hcd(E) mii(E) ttm(E) xhci_hcd(E) libata(E) drm(E) usbcore(E) usb_common(E) fjes(E) video(E) button(E) sg(E) scsi_mod(E) autofs4(E)
[  146.096083] CPU: 1 PID: 4168 Comm: zram01 Tainted: G            E   4.8.1-rt1-virgin_debug #6
[  146.096083] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[  146.096084] task: ffff88038e763200 task.stack: ffff8803f7e4c000
[  146.096085] RIP: 0010:[<ffffffff813aa516>]  [<ffffffff813aa516>] memcpy_erms+0x6/0x10
[  146.096085] RSP: 0018:ffff8803f7e4f820  EFLAGS: 00010286
[  146.096086] RAX: ffff880386d1a050 RBX: ffff880377d42b80 RCX: fffffffffcd7a000
[  146.096086] RDX: ffffffffffffffb0 RSI: ffff880400551030 RDI: ffff880389fa0000
[  146.096086] RBP: ffff8803f7e4f870 R08: ffff88038e763200 R09: 0000000000000000
[  146.096087] R10: 0000000000000004 R11: 0000000000000001 R12: ffff880375767000
[  146.096087] R13: ffffea000df02d00 R14: 0000000000000080 R15: ffffffffffffffb0
[  146.096088] FS:  00007f8313fd4700(0000) GS:ffff88041ec40000(0000) knlGS:0000000000000000
[  146.096088] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  146.096089] CR2: ffff880389fa0000 CR3: 000000037c627000 CR4: 00000000001406e0
[  146.096089] Stack:
[  146.096090]  ffffffff8124bb53 00000fd077d42b80 ffff88038e763200 000000000e1b4640
[  146.096091]  ffff8803fd2cb080 ffff8803d32c6400 0000000000000000 ffff880377d42b80
[  146.096092]  ffff88038e763200 ffff8803f7e4f940 ffff8803f7e4f8f8 ffffffffa0a23571
[  146.096092] Call Trace:
[  146.096095]  [<ffffffff8124bb53>] ? zs_unmap_object+0x153/0x2a0
[  146.096098]  [<ffffffffa0a23571>] zram_bvec_rw+0x3d1/0x850 [zram]
[  146.096100]  [<ffffffffa0a23c9d>] zram_make_request+0x19d/0x3b6 [zram]
[  146.096101]  [<ffffffff81366c18>] ? blk_queue_enter+0x38/0x2c0
[  146.096102]  [<ffffffff81366fae>] generic_make_request+0x10e/0x2e0
[  146.096103]  [<ffffffff813671ed>] submit_bio+0x6d/0x150
[  146.096105]  [<ffffffff8135d8e8>] ? bio_alloc_bioset+0x168/0x2a0
[  146.096107]  [<ffffffff8129508c>] submit_bh_wbc+0x15c/0x1a0
[  146.096109]  [<ffffffff812951fc>] __block_write_full_page+0x12c/0x3b0
[  146.096110]  [<ffffffff81297a90>] ? I_BDEV+0x20/0x20
[  146.096111]  [<ffffffff81297a90>] ? I_BDEV+0x20/0x20
[  146.096112]  [<ffffffff8129569f>] block_write_full_page+0xff/0x130
[  146.096113]  [<ffffffff812984c8>] blkdev_writepage+0x18/0x20
[  146.096116]  [<ffffffff811cea26>] __writepage+0x16/0x50
[  146.096117]  [<ffffffff811d055f>] write_cache_pages+0x2af/0x690
[  146.096118]  [<ffffffff811c8bc3>] ? free_pcppages_bulk+0x33/0x560
[  146.096119]  [<ffffffff811cea10>] ? compound_head+0x20/0x20
[  146.096121]  [<ffffffff811d0986>] generic_writepages+0x46/0x60
[  146.096122]  [<ffffffff8129847f>] blkdev_writepages+0x2f/0x40
[  146.096123]  [<ffffffff811d2541>] do_writepages+0x21/0x40
[  146.096124]  [<ffffffff811c374a>] __filemap_fdatawrite_range+0xaa/0xf0
[  146.096125]  [<ffffffff811c3800>] filemap_write_and_wait+0x40/0x80
[  146.096126]  [<ffffffff8129904f>] __sync_blockdev+0x1f/0x40
[  146.096126]  [<ffffffff812993a8>] __blkdev_put+0x78/0x3a0
[  146.096127]  [<ffffffff8129971e>] blkdev_put+0x4e/0x150
[  146.096128]  [<ffffffff81299848>] blkdev_close+0x28/0x30
[  146.096130]  [<ffffffff8125610b>] __fput+0xfb/0x230
[  146.096131]  [<ffffffff8125627e>] ____fput+0xe/0x10
[  146.096132]  [<ffffffff8109f393>] task_work_run+0x83/0xc0
[  146.096134]  [<ffffffff81072672>] exit_to_usermode_loop+0xb4/0xee
[  146.096135]  [<ffffffff81002afb>] syscall_return_slowpath+0xbb/0x130
[  146.096137]  [<ffffffff816de118>] entry_SYSCALL_64_fastpath+0xbb/0xbd
[  146.096146] Code: ff eb eb 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 
[  146.096147] RIP  [<ffffffff813aa516>] memcpy_erms+0x6/0x10
[  146.096147]  RSP <ffff8803f7e4f820>
[  146.096148] CR2: ffff880389fa0000
