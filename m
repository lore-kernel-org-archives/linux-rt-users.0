From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [patch] drivers/zram: Don't disable preemption in
 zcomp_stream_get/put()
Date: Mon, 17 Oct 2016 19:18:05 +0200
Message-ID: <1476724685.19030.5.camel@gmail.com>
References: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
         <1476587662.1538.8.camel@gmail.com>
         <20161017142428.25dyxefk2arjeyfz@linutronix.de>
         <1476721140.30636.10.camel@gmail.com>
         <20161017162900.y337rfe6ydmolbn3@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161017162900.y337rfe6ydmolbn3@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2016-10-17 at 18:29 +0200, Sebastian Andrzej Siewior wrote:
> On 2016-10-17 18:19:00 [+0200], Mike Galbraith wrote:
> > I used a local lock first, but lockdep was unhappy with it.  Ok,
> > back
> > to the drawing board.  Seems to work, but...
> 
> locallock can be taken recursively so unless preemption was already
> disabled, lockdep shouldn't complain. But then from the small context
> it should not be taken recursively.

FWIW here's the lockdep gripe.

BTW, 4.8 either needs the btrfs deadlock fix (0ccd05285e7f) or the LTP
testcase has to be hacked to not test btrfs.  It also fails the first
time it's run in 4.8/4.8-rt, doesn't do that in master/tip-rt.

[  130.090247] zram: Added device: zram0
[  130.163407] zram0: detected capacity change from 0 to 536870912
[  131.760327] zram: 4188 (zram01) Attribute compr_data_size (and others) will be removed. See zram documentation.

[  131.760923] ======================================================
[  131.760923] [ INFO: possible circular locking dependency detected ]
[  131.760924] 4.8.2-rt1-virgin_debug #20 Tainted: G            E  
[  131.760924] -------------------------------------------------------
[  131.760924] zram01/4188 is trying to acquire lock:
[  131.760928]  ((null)){+.+...}, at: [<ffffffffa0a28384>] zcomp_stream_get+0x44/0xd0 [zram]
[  131.760929] but task is already holding lock:
[  131.760932]  (&zspage->lock){+.+...}, at: [<ffffffff8124b7ab>] zs_map_object+0x8b/0x2e0
[  131.760932] which lock already depends on the new lock.
[  131.760932] the existing dependency chain (in reverse order) is:
[  131.760933] -> #2 (&zspage->lock){+.+...}:
[  131.760936]        [<ffffffff810d9f5d>] lock_acquire+0xbd/0x260
[  131.760939]        [<ffffffff816dee57>] rt_read_lock+0x47/0x60
[  131.760940]        [<ffffffff8124b7ab>] zs_map_object+0x8b/0x2e0
[  131.760941]        [<ffffffffa0a2a523>] zram_bvec_rw+0x383/0x850 [zram]
[  131.760942]        [<ffffffffa0a2ac9d>] zram_make_request+0x19d/0x3b6 [zram]
[  131.760944]        [<ffffffff8136707e>] generic_make_request+0x10e/0x2e0
[  131.760944]        [<ffffffff813672bd>] submit_bio+0x6d/0x150
[  131.760947]        [<ffffffff812950bc>] submit_bh_wbc+0x15c/0x1a0
[  131.760948]        [<ffffffff8129522c>] __block_write_full_page+0x12c/0x3b0
[  131.760949]        [<ffffffff812956cf>] block_write_full_page+0xff/0x130
[  131.760951]        [<ffffffff812984f8>] blkdev_writepage+0x18/0x20
[  131.760953]        [<ffffffff811cea66>] __writepage+0x16/0x50
[  131.760954]        [<ffffffff811d059f>] write_cache_pages+0x2af/0x690
[  131.760955]        [<ffffffff811d09c6>] generic_writepages+0x46/0x60
[  131.760957]        [<ffffffff812984af>] blkdev_writepages+0x2f/0x40
[  131.760958]        [<ffffffff811d2581>] do_writepages+0x21/0x40
[  131.760959]        [<ffffffff811c378a>] __filemap_fdatawrite_range+0xaa/0xf0
[  131.760960]        [<ffffffff811c3840>] filemap_write_and_wait+0x40/0x80
[  131.760961]        [<ffffffff8129907f>] __sync_blockdev+0x1f/0x40
[  131.760961]        [<ffffffff812993d8>] __blkdev_put+0x78/0x3a0
[  131.760962]        [<ffffffff8129974e>] blkdev_put+0x4e/0x150
[  131.760963]        [<ffffffff81299878>] blkdev_close+0x28/0x30
[  131.760964]        [<ffffffff8125613b>] __fput+0xfb/0x230
[  131.760965]        [<ffffffff812562ae>] ____fput+0xe/0x10
[  131.760967]        [<ffffffff8109f393>] task_work_run+0x83/0xc0
[  131.760968]        [<ffffffff81072672>] exit_to_usermode_loop+0xb4/0xee
[  131.760970]        [<ffffffff81002afb>] syscall_return_slowpath+0xbb/0x130
[  131.760971]        [<ffffffff816df118>] entry_SYSCALL_64_fastpath+0xbb/0xbd
[  131.760971] -> #1 (&zh->lock){+.+...}:
[  131.760973]        [<ffffffff810d9f5d>] lock_acquire+0xbd/0x260
[  131.760974]        [<ffffffff816deac1>] _mutex_lock+0x31/0x40
[  131.760975]        [<ffffffff8124b768>] zs_map_object+0x48/0x2e0
[  131.760976]        [<ffffffffa0a2a523>] zram_bvec_rw+0x383/0x850 [zram]
[  131.760977]        [<ffffffffa0a2ac9d>] zram_make_request+0x19d/0x3b6 [zram]
[  131.760978]        [<ffffffff8136707e>] generic_make_request+0x10e/0x2e0
[  131.760978]        [<ffffffff813672bd>] submit_bio+0x6d/0x150
[  131.760979]        [<ffffffff812950bc>] submit_bh_wbc+0x15c/0x1a0
[  131.760980]        [<ffffffff8129522c>] __block_write_full_page+0x12c/0x3b0
[  131.760982]        [<ffffffff812956cf>] block_write_full_page+0xff/0x130
[  131.760983]        [<ffffffff812984f8>] blkdev_writepage+0x18/0x20
[  131.760984]        [<ffffffff811cea66>] __writepage+0x16/0x50
[  131.760985]        [<ffffffff811d059f>] write_cache_pages+0x2af/0x690
[  131.760986]        [<ffffffff811d09c6>] generic_writepages+0x46/0x60
[  131.760987]        [<ffffffff812984af>] blkdev_writepages+0x2f/0x40
[  131.760988]        [<ffffffff811d2581>] do_writepages+0x21/0x40
[  131.760989]        [<ffffffff811c378a>] __filemap_fdatawrite_range+0xaa/0xf0
[  131.760990]        [<ffffffff811c3840>] filemap_write_and_wait+0x40/0x80
[  131.760990]        [<ffffffff8129907f>] __sync_blockdev+0x1f/0x40
[  131.760991]        [<ffffffff812993d8>] __blkdev_put+0x78/0x3a0
[  131.760992]        [<ffffffff8129974e>] blkdev_put+0x4e/0x150
[  131.760992]        [<ffffffff81299878>] blkdev_close+0x28/0x30
[  131.760993]        [<ffffffff8125613b>] __fput+0xfb/0x230
[  131.760994]        [<ffffffff812562ae>] ____fput+0xe/0x10
[  131.760995]        [<ffffffff8109f393>] task_work_run+0x83/0xc0
[  131.760996]        [<ffffffff81072672>] exit_to_usermode_loop+0xb4/0xee
[  131.760996]        [<ffffffff81002afb>] syscall_return_slowpath+0xbb/0x130
[  131.760997]        [<ffffffff816df118>] entry_SYSCALL_64_fastpath+0xbb/0xbd
[  131.760998] -> #0 ((null)){+.+...}:
[  131.760999]        [<ffffffff810d9b1c>] __lock_acquire+0x162c/0x1660
[  131.761000]        [<ffffffff810d9f5d>] lock_acquire+0xbd/0x260
[  131.761001]        [<ffffffff816de92a>] rt_spin_lock__no_mg+0x5a/0x70
[  131.761002]        [<ffffffffa0a28384>] zcomp_stream_get+0x44/0xd0 [zram]
[  131.761003]        [<ffffffffa0a29204>] zram_decompress_page.isra.17+0xc4/0x150 [zram]
[  131.761004]        [<ffffffffa0a2a694>] zram_bvec_rw+0x4f4/0x850 [zram]
[  131.761005]        [<ffffffffa0a2aa9c>] zram_rw_page+0xac/0x110 [zram]
[  131.761007]        [<ffffffff81297d24>] bdev_read_page+0x84/0xb0
[  131.761007]        [<ffffffff8129eb2f>] do_mpage_readpage+0x53f/0x780
[  131.761008]        [<ffffffff8129eeb4>] mpage_readpages+0x144/0x1b0
[  131.761009]        [<ffffffff8129847d>] blkdev_readpages+0x1d/0x20
[  131.761011]        [<ffffffff811d3046>] __do_page_cache_readahead+0x286/0x360
[  131.761011]        [<ffffffff811c4d1a>] filemap_fault+0x44a/0x6a0
[  131.761013]        [<ffffffff811fb033>] __do_fault+0x73/0xf0
[  131.761014]        [<ffffffff81200b3c>] handle_mm_fault+0xc7c/0x10a0
[  131.761017]        [<ffffffff8105c6ef>] __do_page_fault+0x1bf/0x5a0
[  131.761018]        [<ffffffff8105cb00>] do_page_fault+0x30/0x80
[  131.761019]        [<ffffffff816e0338>] page_fault+0x28/0x30
[  131.761019] other info that might help us debug this:
[  131.761020] Chain exists of: (null) --> &zh->lock --> &zspage->lock
[  131.761020]  Possible unsafe locking scenario:
[  131.761020]        CPU0                    CPU1
[  131.761020]        ----                    ----
[  131.761021]   lock(&zspage->lock);
[  131.761021]                                lock(&zh->lock);
[  131.761022]                                lock(&zspage->lock);
[  131.761022]   lock((null));
[  131.761022] *** DEADLOCK ***
[  131.761023] 4 locks held by zram01/4188:
[  131.761024]  #0:  (&mm->mmap_sem){++++++}, at: [<ffffffff8105c65a>] __do_page_fault+0x12a/0x5a0
[  131.761026]  #1:  (lock#5){+.+...}, at: [<ffffffffa0a2917c>] zram_decompress_page.isra.17+0x3c/0x150 [zram]
[  131.761027]  #2:  (&zh->lock){+.+...}, at: [<ffffffff8124b768>] zs_map_object+0x48/0x2e0
[  131.761029]  #3:  (&zspage->lock){+.+...}, at: [<ffffffff8124b7ab>] zs_map_object+0x8b/0x2e0
[  131.761029] stack backtrace:
[  131.761030] CPU: 2 PID: 4188 Comm: zram01 Tainted: G            E   4.8.2-rt1-virgin_debug #20
[  131.761030] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[  131.761032]  0000000000000000 ffff88038fbbb668 ffffffff8139b9fd ffffffff826ffa90
[  131.761033]  ffffffff826ffdf0 ffff88038fbbb6a8 ffffffff811be11f ffff88038fbbb6e0
[  131.761034]  ffff880392212300 0000000000000003 0000000000000004 ffff880392211900
[  131.761034] Call Trace:
[  131.761035]  [<ffffffff8139b9fd>] dump_stack+0x85/0xc8
[  131.761037]  [<ffffffff811be11f>] print_circular_bug+0x1f9/0x207
[  131.761038]  [<ffffffff810d9b1c>] __lock_acquire+0x162c/0x1660
[  131.761039]  [<ffffffff810d9f5d>] lock_acquire+0xbd/0x260
[  131.761041]  [<ffffffffa0a28384>] ? zcomp_stream_get+0x44/0xd0 [zram]
[  131.761042]  [<ffffffff816de92a>] rt_spin_lock__no_mg+0x5a/0x70
[  131.761043]  [<ffffffffa0a28384>] ? zcomp_stream_get+0x44/0xd0 [zram]
[  131.761044]  [<ffffffffa0a28384>] zcomp_stream_get+0x44/0xd0 [zram]
[  131.761045]  [<ffffffffa0a29204>] zram_decompress_page.isra.17+0xc4/0x150 [zram]
[  131.761046]  [<ffffffffa0a2a694>] zram_bvec_rw+0x4f4/0x850 [zram]
[  131.761048]  [<ffffffffa0a2aa9c>] zram_rw_page+0xac/0x110 [zram]
[  131.761049]  [<ffffffff81297d24>] bdev_read_page+0x84/0xb0
[  131.761050]  [<ffffffff8129eb2f>] do_mpage_readpage+0x53f/0x780
[  131.761051]  [<ffffffff811d607e>] ? lru_cache_add+0xe/0x10
[  131.761052]  [<ffffffff8129eeb4>] mpage_readpages+0x144/0x1b0
[  131.761053]  [<ffffffff81297ac0>] ? I_BDEV+0x20/0x20
[  131.761054]  [<ffffffff81297ac0>] ? I_BDEV+0x20/0x20
[  131.761055]  [<ffffffff813bc1f7>] ? debug_smp_processor_id+0x17/0x20
[  131.761056]  [<ffffffff811cbe1a>] ? get_page_from_freelist+0x39a/0xd90
[  131.761057]  [<ffffffff810d67c9>] ? __lock_is_held+0x49/0x70
[  131.761058]  [<ffffffff810d67c9>] ? __lock_is_held+0x49/0x70
[  131.761060]  [<ffffffff810f7b73>] ? rcu_read_lock_sched_held+0x93/0xa0
[  131.761061]  [<ffffffff811cce62>] ? __alloc_pages_nodemask+0x392/0x480
[  131.761062]  [<ffffffff81223347>] ? alloc_pages_current+0x97/0x1b0
[  131.761063]  [<ffffffff811c0c8f>] ? __page_cache_alloc+0x12f/0x160
[  131.761065]  [<ffffffff8129847d>] blkdev_readpages+0x1d/0x20
[  131.761066]  [<ffffffff811d3046>] __do_page_cache_readahead+0x286/0x360
[  131.761067]  [<ffffffff811d2f30>] ? __do_page_cache_readahead+0x170/0x360
[  131.761068]  [<ffffffff811c4d1a>] filemap_fault+0x44a/0x6a0
[  131.761069]  [<ffffffff813bc1f7>] ? debug_smp_processor_id+0x17/0x20
[  131.761070]  [<ffffffff811fb033>] __do_fault+0x73/0xf0
[  131.761071]  [<ffffffff81200b3c>] handle_mm_fault+0xc7c/0x10a0
[  131.761072]  [<ffffffff810d67c9>] ? __lock_is_held+0x49/0x70
[  131.761073]  [<ffffffff8105c6ef>] __do_page_fault+0x1bf/0x5a0
[  131.761074]  [<ffffffff8105cb00>] do_page_fault+0x30/0x80
[  131.761075]  [<ffffffff816e0338>] page_fault+0x28/0x30
[  132.696315] zram0: detected capacity change from 536870912 to 0
[  132.702019] zram: Removed device: zram0
[  132.801476] zram: Added device: zram0
[  132.802011] zram: Added device: zram1
[  132.803332] zram: Added device: zram2
[  132.804999] zram: Added device: zram3
[  132.830229] zram0: detected capacity change from 0 to 26214400
[  132.831491] zram1: detected capacity change from 0 to 26214400
[  132.832725] zram2: detected capacity change from 0 to 26214400
[  132.834931] zram3: detected capacity change from 0 to 41943040
[  133.003077] raid6: sse2x1   gen() 12140 MB/s
[  133.020078] raid6: sse2x1   xor()  9453 MB/s
[  133.037077] raid6: sse2x2   gen() 15566 MB/s
[  133.054079] raid6: sse2x2   xor() 10304 MB/s
[  133.071084] raid6: sse2x4   gen() 17945 MB/s
[  133.088084] raid6: sse2x4   xor() 12447 MB/s
[  133.105087] raid6: avx2x1   gen() 23656 MB/s
[  133.122089] raid6: avx2x2   gen() 28191 MB/s
[  133.139090] raid6: avx2x4   gen() 32050 MB/s
[  133.139091] raid6: using algorithm avx2x4 gen() 32050 MB/s
[  133.139092] raid6: using avx2x2 recovery algorithm
[  133.153651] xor: automatically using best checksumming function:
[  133.163098]    avx       : 36704.000 MB/sec
[  133.372902] Btrfs loaded, crc32c=crc32c-intel, assert=on
[  133.373255] BTRFS: device fsid e04952e8-f9fa-4145-8bd9-43b23dfd995f devid 1 transid 3 /dev/zram3
[  133.396333] EXT4-fs (zram0): mounting ext3 file system using the ext4 subsystem
[  133.396684] EXT4-fs (zram0): mounted filesystem with ordered data mode. Opts: (null)
[  133.402146] EXT4-fs (zram1): mounted filesystem with ordered data mode. Opts: (null)
[  133.716775] SGI XFS with ACLs, security attributes, realtime, no debug enabled
[  133.718729] XFS (zram2): Mounting V4 Filesystem
[  133.720285] XFS (zram2): Ending clean mount
[  133.725864] BTRFS info (device zram3): disk space caching is enabled
[  133.725869] BTRFS info (device zram3): has skinny extents
[  133.726570] BTRFS info (device zram3): detected SSD devices, enabling SSD mode
[  133.726633] BTRFS info (device zram3): creating UUID tree
[  151.080729] SFW2-INext-DROP-DEFLT IN=br0 OUT= MAC= SRC=fe80:0000:0000:0000:d63d:7eff:fefc:4f09 DST=ff02:0000:0000:0000:0000:0000:0000:00fb LEN=138 TC=0 HOPLIMIT=255 FLOWLBL=855088 PROTO=UDP SPT=5353 DPT=5353 LEN=98 
[  181.364952] XFS (zram2): Unmounting Filesystem
[  181.408367] zram0: detected capacity change from 26214400 to 0
[  181.408578] zram1: detected capacity change from 26214400 to 0
[  181.408969] zram2: detected capacity change from 26214400 to 0
[  181.409262] zram3: detected capacity change from 41943040 to 0
[  181.409978] zram: Removed device: zram0
[  181.419062] zram: Removed device: zram1
[  181.433933] zram: Removed device: zram2
[  181.451062] zram: Removed device: zram3
[  181.510512] zram: Added device: zram0
[  185.667788] zram0: detected capacity change from 0 to 107374182400
[  185.692536] Adding 104857596k swap on /dev/zram0.  Priority:-1 extents:1 across:104857596k SSFS
[  186.069786] zram0: detected capacity change from 107374182400 to 0
[  186.070654] zram: Removed device: zram0
[  186.131458] zram: Added device: zram0
[  186.155595] zram0: detected capacity change from 0 to 536870912
[  187.064553] zram: 18984 (zram03) Attribute compr_data_size (and others) will be removed. See zram documentation.
[  188.006358] zram0: detected capacity change from 536870912 to 0
[  188.008209] zram: Removed device: zram0
