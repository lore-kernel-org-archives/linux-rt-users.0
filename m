From: Mike Galbraith <efault@gmx.de>
Subject: 3.0-rt: ext4 sync IO logjam
Date: Sat, 30 Jun 2012 10:25:02 +0200
Message-ID: <1341044702.7381.93.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:53069 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751856Ab2F3IZL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 30 Jun 2012 04:25:11 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings,

While chasing down an ext3 IO logjam, I stumbled into a similar looking
logjam in ext4.  A simple taskset -c 3 dbench -s 8 will lock a box up in
pretty short order.  ext3 logjam I was chasing turned out to be a not so
rt friendly patch in enterprise land.  This one is in virgin source.

I beat virgin ext3 hard, and couldn't induce any journal troubles.  ext4
OTOH is pretty close to instant gratification, but I'm not having much
luck figuring out why so far.  Ext4 is crippled (ro) in enterprise for
some reason, so it jamming up is not as big a deal as.. _anything_ else,
so unless I mange to get it fingered out over the weekend (unlikely
given squabble time already invested), it's headed toward the back
burner pile, where it could easily R(ot).I.P. forever more.

Anyway, start a heavy dbench -s load, you should see everybody and his
brother jam up on lg_mutex, with it's holder waiting for IO that ain't
gonna happen.  Box goes completely idle.  The ext3 thing I was chasing
looked _awfully_ similar, but with flush munching cpu in a trylock loop
endlessly due to optimizations (in rt they sure ain't).  Maybe you can
lock ext3 if you're patient enough, dunno.  I tried pretty darn hard
though, and failed, so speculate it's ext4 only despite _mighty
suspicious_ similarities.  Haven't checked the other rt trees yet.

[  631.984240] SysRq : Show Blocked State
[  631.984244]   task                        PC stack   pid father
[  631.984266] jbd2/sdb3-8     D 0000000000000000     0  2483      2 0x00000000
[  631.984270]  ffff88017693baa0 0000000000000046 ffff880100000000 ffff88017693bfd8
[  631.984274]  ffff88017693bfd8 0000000000004000 ffff88017693a000 ffff88017693a000
[  631.984277]  000000000000eb40 ffff88017693bfd8 ffffffff8180d020 ffff88017698b140
[  631.984280] Call Trace:
[  631.984289]  [<ffffffff8103cbc3>] ? migrate_enable+0xd3/0x1b0
[  631.984294]  [<ffffffff81231135>] ? blk_flush_plug_list+0x1d5/0x220
[  631.984298]  [<ffffffff810cbaf0>] ? __lock_page+0x70/0x70
[  631.984303]  [<ffffffff8141740e>] schedule+0x2e/0xa0
[  631.984306]  [<ffffffff814174e0>] io_schedule+0x60/0x80
[  631.984309]  [<ffffffff810cbafe>] sleep_on_page+0xe/0x20
[  631.984312]  [<ffffffff81417cbf>] __wait_on_bit+0x5f/0x90
[  631.984315]  [<ffffffff810cbd53>] wait_on_page_bit+0x73/0x80
[  631.984319]  [<ffffffff81066ba0>] ? autoremove_wake_function+0x40/0x40
[  631.984322]  [<ffffffff810d7345>] ? pagevec_lookup_tag+0x25/0x40
[  631.984325]  [<ffffffff810cc502>] filemap_fdatawait_range+0x102/0x190
[  631.984328]  [<ffffffff8122ebb4>] ? submit_bio+0x64/0xe0
[  631.984331]  [<ffffffff810cc5ba>] filemap_fdatawait+0x2a/0x30
[  631.984335]  [<ffffffff811f938f>] jbd2_journal_commit_transaction+0x93f/0x1b40
[  631.984340]  [<ffffffff811ffb0f>] kjournald2+0xdf/0x3d0
[  631.984342]  [<ffffffff81066b60>] ? wake_up_bit+0x40/0x40
[  631.984345]  [<ffffffff811ffa30>] ? commit_timeout+0x10/0x10
[  631.984348]  [<ffffffff811ffa30>] ? commit_timeout+0x10/0x10
[  631.984350]  [<ffffffff81066546>] kthread+0x96/0xa0
[  631.984354]  [<ffffffff8103616a>] ? finish_task_switch+0x5a/0xe0
[  631.984357]  [<ffffffff81421034>] kernel_thread_helper+0x4/0x10
[  631.984360]  [<ffffffff810664b0>] ? __init_kthread_worker+0x60/0x60
[  631.984363]  [<ffffffff81421030>] ? gs_change+0xb/0xb
[  631.984366] flush-8:16      D 0000000000000000     0  2490      2 0x00000000
[  631.984369]  ffff8801758db850 0000000000000046 ffff880100000000 ffff8801758dbfd8
[  631.984372]  ffff8801758dbfd8 0000000000004000 ffff8801758da000 ffff8801758da000
[  631.984375]  000000000000eb40 ffff8801758dbfd8 ffff88017a599080 ffff88017a0837b0
[  631.984378] Call Trace:
[  631.984381]  [<ffffffff8122ebb4>] ? submit_bio+0x64/0xe0
[  631.984384]  [<ffffffff810d87ca>] ? lru_add_drain+0x10a/0x210
[  631.984387]  [<ffffffff810cbaf0>] ? __lock_page+0x70/0x70
[  631.984390]  [<ffffffff8141740e>] schedule+0x2e/0xa0
[  631.984393]  [<ffffffff814174e0>] io_schedule+0x60/0x80
[  631.984396]  [<ffffffff810cbafe>] sleep_on_page+0xe/0x20
[  631.984399]  [<ffffffff81417b6a>] __wait_on_bit_lock+0x5a/0xc0
[  631.984402]  [<ffffffff810cbae7>] __lock_page+0x67/0x70
[  631.984405]  [<ffffffff81066ba0>] ? autoremove_wake_function+0x40/0x40
[  631.984407]  [<ffffffff810d7345>] ? pagevec_lookup_tag+0x25/0x40
[  631.984412]  [<ffffffff811b1530>] ext4_num_dirty_pages+0x280/0x2b0
[  631.984416]  [<ffffffff811b94ac>] ext4_da_writepages+0x64c/0x6b0
[  631.984421]  [<ffffffff810d6794>] do_writepages+0x24/0x40
[  631.984425]  [<ffffffff8113d48b>] writeback_single_inode+0xfb/0x2a0
[  631.984428]  [<ffffffff8113dd1a>] writeback_sb_inodes+0xea/0x1d0
[  631.984431]  [<ffffffff8113e583>] writeback_inodes_wb+0x83/0x190
[  631.984434]  [<ffffffff8113eb7b>] wb_writeback+0x4eb/0x550
[  631.984437]  [<ffffffff8113ee78>] wb_do_writeback+0x298/0x2a0
[  631.984441]  [<ffffffff8113ef43>] bdi_writeback_thread+0xc3/0x320
[  631.984444]  [<ffffffff8102f649>] ? __wake_up_common+0x59/0x90
[  631.984447]  [<ffffffff8113ee80>] ? wb_do_writeback+0x2a0/0x2a0
[  631.984450]  [<ffffffff8113ee80>] ? wb_do_writeback+0x2a0/0x2a0
[  631.984452]  [<ffffffff81066546>] kthread+0x96/0xa0
[  631.984455]  [<ffffffff8103616a>] ? finish_task_switch+0x5a/0xe0
[  631.984458]  [<ffffffff81421034>] kernel_thread_helper+0x4/0x10
[  631.984461]  [<ffffffff810664b0>] ? __init_kthread_worker+0x60/0x60
[  631.984464]  [<ffffffff81421030>] ? gs_change+0xb/0xb
[  631.984491] konsole         D 0000000000000000     0  7077      1 0x00000000
[  631.984494]  ffff880176d51c08 0000000000000086 ffff880100000000 ffff880176d51fd8
[  631.984498]  ffff880176d51fd8 0000000000004000 ffff880176d50000 ffff880176d50000
[  631.984501]  000000000000eb40 ffff880176d51fd8 ffffffff8180d020 ffff88017450f0c0
[  631.984504] Call Trace:
[  631.984507]  [<ffffffff8103cbc3>] ? migrate_enable+0xd3/0x1b0
[  631.984510]  [<ffffffff811fc620>] ? find_revoke_record+0xb0/0xc0
[  631.984514]  [<ffffffff8103cbc3>] ? migrate_enable+0xd3/0x1b0
[  631.984517]  [<ffffffff8141740e>] schedule+0x2e/0xa0
[  631.984520]  [<ffffffff811f7e75>] do_get_write_access+0x2b5/0x550
[  631.984523]  [<ffffffff81066ba0>] ? autoremove_wake_function+0x40/0x40
[  631.984526]  [<ffffffff811f8261>] jbd2_journal_get_write_access+0x31/0x50
[  631.984529]  [<ffffffff811dbdee>] __ext4_journal_get_write_access+0x3e/0x80
[  631.984533]  [<ffffffff811be93b>] ext4_orphan_add+0xbb/0x2c0
[  631.984536]  [<ffffffff811bfb97>] ext4_unlink+0x357/0x370
[  631.984540]  [<ffffffff812185ae>] ? security_inode_permission+0x1e/0x30
[  631.984545]  [<ffffffff81123639>] vfs_unlink+0x99/0x110
[  631.984547]  [<ffffffff8112528b>] do_unlinkat+0x18b/0x1c0
[  631.984552]  [<ffffffff8111ad83>] ? sys_newstat+0x33/0x40
[  631.984556]  [<ffffffff81070b7d>] ? ktime_get_ts+0xad/0xe0
[  631.984559]  [<ffffffff81125fe6>] sys_unlink+0x16/0x20
[  631.984563]  [<ffffffff8141ffeb>] system_call_fastpath+0x16/0x1b
[  631.984568] dbench          D 0000000000000000     0  7643   7642 0x00000000
[  631.984571]  ffff8801744efb48 0000000000000086 ffff8801744efa88 ffff8801744effd8
[  631.984574]  ffff8801744effd8 0000000000004000 ffff8801744ee000 ffff8801744ee000
[  631.984578]  000000000000eb40 ffff8801744effd8 ffff88017a083080 ffff8801752277f0
[  631.984581] Call Trace:
[  631.984584]  [<ffffffff8141740e>] ? schedule+0x2e/0xa0
[  631.984587]  [<ffffffff814174e0>] ? io_schedule+0x60/0x80
[  631.984591]  [<ffffffff8103cbc3>] ? migrate_enable+0xd3/0x1b0
[  631.984594]  [<ffffffff8141740e>] schedule+0x2e/0xa0
[  631.984597]  [<ffffffff811ff93d>] jbd2_log_wait_commit+0xed/0x1d0
[  631.984599]  [<ffffffff81066b60>] ? wake_up_bit+0x40/0x40
[  631.984602]  [<ffffffff811ad35f>] ext4_sync_file+0x22f/0x390
[  631.984612]  [<ffffffff81142689>] vfs_fsync_range+0x79/0x90
[  631.984616]  [<ffffffff811426e4>] generic_write_sync+0x44/0x50
[  631.984619]  [<ffffffff810ccfc6>] generic_file_aio_write+0xc6/0xe0
[  631.984622]  [<ffffffff811ace39>] ext4_file_write+0x69/0x280
[  631.984625]  [<ffffffff81125655>] ? path_openat+0x105/0x430
[  631.984628]  [<ffffffff8111589a>] do_sync_write+0xda/0x120
[  631.984634]  [<ffffffff81058422>] ? group_send_sig_info+0x42/0x80
[  631.984638]  [<ffffffff81058598>] ? kill_pid_info+0x58/0x80
[  631.984641]  [<ffffffff8121882c>] ? security_file_permission+0x2c/0xb0
[  631.984644]  [<ffffffff81115fe6>] vfs_write+0xc6/0x170
[  631.984647]  [<ffffffff81116472>] sys_pwrite64+0xa2/0xb0
[  631.984650]  [<ffffffff8141ffeb>] system_call_fastpath+0x16/0x1b
[  631.984658] dbench          D 0000000000000000     0  7644   7642 0x00000000
[  631.984661]  ffff8801714eba48 0000000000000082 00000000fffffffb ffff8801714ebfd8
[  631.984665]  ffff8801714ebfd8 0000000000004000 ffff8801714ea000 ffff8801714ea000
[  631.984668]  000000000000eb40 ffff8801714ebfd8 ffff88017a296830 ffff88017a083080
[  631.984671] Call Trace:
[  631.984675]  [<ffffffff8103cbc3>] ? migrate_enable+0xd3/0x1b0
[  631.984678]  [<ffffffff8103cbc3>] ? migrate_enable+0xd3/0x1b0
[  631.984681]  [<ffffffff8141740e>] schedule+0x2e/0xa0
[  631.984684]  [<ffffffff811f7e75>] do_get_write_access+0x2b5/0x550
[  631.984687]  [<ffffffff81066ba0>] ? autoremove_wake_function+0x40/0x40
[  631.984690]  [<ffffffff811f8261>] jbd2_journal_get_write_access+0x31/0x50
[  631.984693]  [<ffffffff811dbdee>] __ext4_journal_get_write_access+0x3e/0x80
[  631.984696]  [<ffffffff811ae97c>] ext4_new_inode+0x30c/0x1240
[  631.984701]  [<ffffffff811f6883>] ? jbd2_journal_start+0x13/0x20
[  631.984705]  [<ffffffff811cf49d>] ? ext4_journal_start_sb+0x6d/0x160
[  631.984708]  [<ffffffff8112e7a7>] ? __d_lookup+0x157/0x170
[  631.984711]  [<ffffffff8112186b>] ? do_lookup+0x4b/0x370
[  631.984714]  [<ffffffff811be067>] ext4_create+0xb7/0x140
[  631.984717]  [<ffffffff81120b03>] ? generic_permission+0x23/0xd0
[  631.984720]  [<ffffffff81123416>] vfs_create+0xb6/0xf0
[  631.984723]  [<ffffffff81124196>] do_last+0x536/0x7f0
[  631.984726]  [<ffffffff81125621>] path_openat+0xd1/0x430
[  631.984729]  [<ffffffff8103cbc3>] ? migrate_enable+0xd3/0x1b0
[  631.984732]  [<ffffffff81125a89>] do_filp_open+0x49/0xa0
[  631.984735]  [<ffffffff8103cbc3>] ? migrate_enable+0xd3/0x1b0
[  631.984739]  [<ffffffff81132fa9>] ? alloc_fd+0xf9/0x150
[  631.984742]  [<ffffffff81115471>] do_sys_open+0x101/0x1e0
[  631.984745]  [<ffffffff81113bd6>] ? filp_close+0x66/0x90
[  631.984748]  [<ffffffff81115570>] sys_open+0x20/0x30
[  631.984751]  [<ffffffff8141ffeb>] system_call_fastpath+0x16/0x1b
[  631.984753] dbench          D 0000000000000000     0  7645   7642 0x00000000
[  631.984756]  ffff8801714fb528 0000000000000086 ffff880176a476f0 ffff8801714fbfd8
[  631.984760]  ffff8801714fbfd8 0000000000004000 ffff8801714fa000 ffff8801714fa000
[  631.984763]  000000000000eb40 ffff8801714fbfd8 ffff8801769a2830 ffff880176689140
[  631.984766] Call Trace:
[  631.984769]  [<ffffffff8107cfc8>] ? task_blocks_on_rt_mutex+0x1e8/0x240
[  631.984772]  [<ffffffff8107c66c>] ? __try_to_take_rt_mutex+0x11c/0x190
[  631.984776]  [<ffffffff8103cbc3>] ? migrate_enable+0xd3/0x1b0
[  631.984779]  [<ffffffff8141740e>] schedule+0x2e/0xa0
[  631.984782]  [<ffffffff811f7e75>] do_get_write_access+0x2b5/0x550
[  631.984785]  [<ffffffff81066ba0>] ? autoremove_wake_function+0x40/0x40
[  631.984788]  [<ffffffff811f8261>] jbd2_journal_get_write_access+0x31/0x50
[  631.984791]  [<ffffffff811dbdee>] __ext4_journal_get_write_access+0x3e/0x80
[  631.984795]  [<ffffffff811df20c>] ext4_mb_mark_diskspace_used+0x7c/0x480
[  631.984798]  [<ffffffff811e0305>] ? ext4_mb_use_preallocated+0x225/0x280
[  631.984801]  [<ffffffff811e476f>] ext4_mb_new_blocks+0x30f/0x560
[  631.984803]  [<ffffffff811d9bb0>] ext4_ext_map_blocks+0x5d0/0x16d0
[  631.984806]  [<ffffffff811d9647>] ? ext4_ext_map_blocks+0x67/0x16d0
[  631.984810]  [<ffffffff811fcc31>] ? jbd2_journal_cancel_revoke+0x61/0x1d0
[  631.984813]  [<ffffffff811b531a>] ext4_map_blocks+0x1fa/0x270
[  631.984816]  [<ffffffff811b85af>] mpage_da_map_and_submit+0xaf/0x490
[  631.984820]  [<ffffffff811b89f0>] mpage_add_bh_to_extent+0x60/0xe0
[  631.984823]  [<ffffffff811b8d47>] write_cache_pages_da+0x2d7/0x3f0
[  631.984827]  [<ffffffff811b91f3>] ext4_da_writepages+0x393/0x6b0
[  631.984830]  [<ffffffff810cb0c5>] ? generic_file_buffered_write+0x1b5/0x260
[  631.984834]  [<ffffffff810d6794>] do_writepages+0x24/0x40
[  631.984837]  [<ffffffff810cc89b>] __filemap_fdatawrite_range+0x5b/0x60
[  631.984840]  [<ffffffff810cc8fa>] filemap_write_and_wait_range+0x5a/0x80
[  631.984843]  [<ffffffff8114266a>] vfs_fsync_range+0x5a/0x90
[  631.984846]  [<ffffffff811426e4>] generic_write_sync+0x44/0x50
[  631.984849]  [<ffffffff810ccfc6>] generic_file_aio_write+0xc6/0xe0
[  631.984852]  [<ffffffff811ace39>] ext4_file_write+0x69/0x280
[  631.984855]  [<ffffffff81125655>] ? path_openat+0x105/0x430
[  631.984858]  [<ffffffff8111589a>] do_sync_write+0xda/0x120
[  631.984861]  [<ffffffff81058422>] ? group_send_sig_info+0x42/0x80
[  631.984865]  [<ffffffff81058598>] ? kill_pid_info+0x58/0x80
[  631.984867]  [<ffffffff8121882c>] ? security_file_permission+0x2c/0xb0
[  631.984871]  [<ffffffff81115fe6>] vfs_write+0xc6/0x170
[  631.984874]  [<ffffffff81116472>] sys_pwrite64+0xa2/0xb0
[  631.984877]  [<ffffffff8141ffeb>] system_call_fastpath+0x16/0x1b
[  631.984879] dbench          D 0000000000000000     0  7646   7642 0x00000000
[  631.984882]  ffff880174c9f698 0000000000000082 ffff88017299d380 ffff880174c9ffd8
[  631.984885]  ffff880174c9ffd8 0000000000004000 ffff880174c9e000 ffff880174c9e000
[  631.984888]  000000000000eb40 ffff880174c9ffd8 ffff88017a04a7f0 ffff8801763de140
[  631.984892] Call Trace:
[  631.984895]  [<ffffffff81234bba>] ? blk_recount_segments+0x2a/0x50
[  631.984898]  [<ffffffff8122e329>] ? drive_stat_acct+0xf9/0x1e0
[  631.984901]  [<ffffffff81230daf>] ? __make_request+0x1ef/0x3a0
[  631.984904]  [<ffffffff8141740e>] schedule+0x2e/0xa0
[  631.984908]  [<ffffffff8141853b>] __rt_mutex_slowlock+0x4b/0xd0
[  631.984910]  [<ffffffff81418782>] rt_mutex_slowlock+0xc2/0x190
[  631.984913]  [<ffffffff814188ff>] rt_mutex_lock+0x2f/0x40
[  631.984916]  [<ffffffff81418f9e>] _mutex_lock+0xe/0x10
[  631.984919]  [<ffffffff811dff6f>] ext4_mb_group_or_file+0x9f/0x110
[  631.984921]  [<ffffffff811e00c1>] ext4_mb_initialize_context+0xe1/0x100
[  631.984925]  [<ffffffff811e458d>] ext4_mb_new_blocks+0x12d/0x560
[  631.984927]  [<ffffffff811d9bb0>] ext4_ext_map_blocks+0x5d0/0x16d0
[  631.984931]  [<ffffffff810d87ca>] ? lru_add_drain+0x10a/0x210
[  631.984934]  [<ffffffff811b531a>] ext4_map_blocks+0x1fa/0x270
[  631.984937]  [<ffffffff811b85af>] mpage_da_map_and_submit+0xaf/0x490
[  631.984941]  [<ffffffff811b9212>] ext4_da_writepages+0x3b2/0x6b0
[  631.984945]  [<ffffffff810d6794>] do_writepages+0x24/0x40
[  631.984947]  [<ffffffff810cc89b>] __filemap_fdatawrite_range+0x5b/0x60
[  631.984951]  [<ffffffff810cc8fa>] filemap_write_and_wait_range+0x5a/0x80
[  631.984954]  [<ffffffff8114266a>] vfs_fsync_range+0x5a/0x90
[  631.984957]  [<ffffffff811426e4>] generic_write_sync+0x44/0x50
[  631.984960]  [<ffffffff810ccfc6>] generic_file_aio_write+0xc6/0xe0
[  631.984963]  [<ffffffff811ace39>] ext4_file_write+0x69/0x280
[  631.984966]  [<ffffffff81125655>] ? path_openat+0x105/0x430
[  631.984969]  [<ffffffff8111589a>] do_sync_write+0xda/0x120
[  631.984972]  [<ffffffff81058422>] ? group_send_sig_info+0x42/0x80
[  631.984976]  [<ffffffff81058598>] ? kill_pid_info+0x58/0x80
[  631.984979]  [<ffffffff8121882c>] ? security_file_permission+0x2c/0xb0
[  631.984982]  [<ffffffff81115fe6>] vfs_write+0xc6/0x170
[  631.984985]  [<ffffffff81116472>] sys_pwrite64+0xa2/0xb0
[  631.984988]  [<ffffffff8141ffeb>] system_call_fastpath+0x16/0x1b
[  631.984990] dbench          D 0000000000000000     0  7647   7642 0x00000000
[  631.984993]  ffff880173425b48 0000000000000082 ffff880173425a88 ffff880173425fd8
[  631.984997]  ffff880173425fd8 0000000000004000 ffff880173424000 ffff880173424000
[  631.985000]  000000000000eb40 ffff880173425fd8 ffff8801763de140 ffff88017a296830
[  631.985003] Call Trace:
[  631.985006]  [<ffffffff8141740e>] ? schedule+0x2e/0xa0
[  631.985009]  [<ffffffff814174e0>] ? io_schedule+0x60/0x80
[  631.985012]  [<ffffffff8103cbc3>] ? migrate_enable+0xd3/0x1b0
[  631.985016]  [<ffffffff8103cbc3>] ? migrate_enable+0xd3/0x1b0
[  631.985019]  [<ffffffff8141740e>] schedule+0x2e/0xa0
[  631.985022]  [<ffffffff811ff93d>] jbd2_log_wait_commit+0xed/0x1d0
[  631.985024]  [<ffffffff81066b60>] ? wake_up_bit+0x40/0x40
[  631.985027]  [<ffffffff811ad35f>] ext4_sync_file+0x22f/0x390
[  631.985030]  [<ffffffff810cc89b>] ? __filemap_fdatawrite_range+0x5b/0x60
[  631.985034]  [<ffffffff81142689>] vfs_fsync_range+0x79/0x90
[  631.985037]  [<ffffffff811426e4>] generic_write_sync+0x44/0x50
[  631.985039]  [<ffffffff810ccfc6>] generic_file_aio_write+0xc6/0xe0
[  631.985042]  [<ffffffff811ace39>] ext4_file_write+0x69/0x280
[  631.985045]  [<ffffffff81125655>] ? path_openat+0x105/0x430
[  631.985049]  [<ffffffff8111589a>] do_sync_write+0xda/0x120
[  631.985052]  [<ffffffff81058422>] ? group_send_sig_info+0x42/0x80
[  631.985055]  [<ffffffff81058598>] ? kill_pid_info+0x58/0x80
[  631.985058]  [<ffffffff8121882c>] ? security_file_permission+0x2c/0xb0
[  631.985061]  [<ffffffff81115fe6>] vfs_write+0xc6/0x170
[  631.985064]  [<ffffffff81116472>] sys_pwrite64+0xa2/0xb0
[  631.985068]  [<ffffffff8141ffeb>] system_call_fastpath+0x16/0x1b
[  631.985070] dbench          D 0000000000000000     0  7648   7642 0x00000000
[  631.985073]  ffff8801714edb48 0000000000000086 ffff88017698b140 ffff8801714edfd8
[  631.985076]  ffff8801714edfd8 0000000000004000 ffff8801714ec000 ffff8801714ec000
[  631.985079]  000000000000eb40 ffff8801714edfd8 ffff880176689140 ffff880173fa5830
[  631.985082] Call Trace:
[  631.985086]  [<ffffffff8103b44a>] ? ttwu_do_wakeup+0x5a/0x130
[  631.985089]  [<ffffffff8103c5f3>] ? try_to_wake_up+0x73/0x320
[  631.985092]  [<ffffffff8103cbc3>] ? migrate_enable+0xd3/0x1b0
[  631.985095]  [<ffffffff8141740e>] schedule+0x2e/0xa0
[  631.985098]  [<ffffffff811ff93d>] jbd2_log_wait_commit+0xed/0x1d0
[  631.985101]  [<ffffffff81066b60>] ? wake_up_bit+0x40/0x40
[  631.985104]  [<ffffffff811ad35f>] ext4_sync_file+0x22f/0x390
[  631.985107]  [<ffffffff810cc89b>] ? __filemap_fdatawrite_range+0x5b/0x60
[  631.985110]  [<ffffffff81142689>] vfs_fsync_range+0x79/0x90
[  631.985113]  [<ffffffff811426e4>] generic_write_sync+0x44/0x50
[  631.985116]  [<ffffffff810ccfc6>] generic_file_aio_write+0xc6/0xe0
[  631.985119]  [<ffffffff811ace39>] ext4_file_write+0x69/0x280
[  631.985122]  [<ffffffff81125655>] ? path_openat+0x105/0x430
[  631.985125]  [<ffffffff8111589a>] do_sync_write+0xda/0x120
[  631.985129]  [<ffffffff81058422>] ? group_send_sig_info+0x42/0x80
[  631.985132]  [<ffffffff81058598>] ? kill_pid_info+0x58/0x80
[  631.985135]  [<ffffffff8121882c>] ? security_file_permission+0x2c/0xb0
[  631.985138]  [<ffffffff81115fe6>] vfs_write+0xc6/0x170
[  631.985141]  [<ffffffff81116472>] sys_pwrite64+0xa2/0xb0
[  631.985144]  [<ffffffff8141ffeb>] system_call_fastpath+0x16/0x1b
[  631.985147] dbench          D 0000000000000000     0  7649   7642 0x00000000
[  631.985150]  ffff880172929a48 0000000000000082 ffff880172928000 ffff880172929fd8
[  631.985153]  ffff880172929fd8 0000000000004000 ffff880172928000 ffff880172928000
[  631.985156]  000000000000eb40 ffff880172929fd8 ffff88017a5ec0c0 ffff880176104770
[  631.985159] Call Trace:
[  631.985163]  [<ffffffff8103cbc3>] ? migrate_enable+0xd3/0x1b0
[  631.985166]  [<ffffffff8103cbc3>] ? migrate_enable+0xd3/0x1b0
[  631.985169]  [<ffffffff8141740e>] schedule+0x2e/0xa0
[  631.985172]  [<ffffffff811f7e75>] do_get_write_access+0x2b5/0x550
[  631.985175]  [<ffffffff81066ba0>] ? autoremove_wake_function+0x40/0x40
[  631.985178]  [<ffffffff811f8261>] jbd2_journal_get_write_access+0x31/0x50
[  631.985181]  [<ffffffff811dbdee>] __ext4_journal_get_write_access+0x3e/0x80
[  631.985184]  [<ffffffff811ae97c>] ext4_new_inode+0x30c/0x1240
[  631.985188]  [<ffffffff811f6883>] ? jbd2_journal_start+0x13/0x20
[  631.985191]  [<ffffffff811cf49d>] ? ext4_journal_start_sb+0x6d/0x160
[  631.985194]  [<ffffffff8112e7a7>] ? __d_lookup+0x157/0x170
[  631.985196]  [<ffffffff8112186b>] ? do_lookup+0x4b/0x370
[  631.985199]  [<ffffffff811be067>] ext4_create+0xb7/0x140
[  631.985202]  [<ffffffff81120b03>] ? generic_permission+0x23/0xd0
[  631.985205]  [<ffffffff81123416>] vfs_create+0xb6/0xf0
[  631.985208]  [<ffffffff81124196>] do_last+0x536/0x7f0
[  631.985211]  [<ffffffff81125621>] path_openat+0xd1/0x430
[  631.985214]  [<ffffffff8103cbc3>] ? migrate_enable+0xd3/0x1b0
[  631.985217]  [<ffffffff81125a89>] do_filp_open+0x49/0xa0
[  631.985221]  [<ffffffff8103cbc3>] ? migrate_enable+0xd3/0x1b0
[  631.985223]  [<ffffffff81132fa9>] ? alloc_fd+0xf9/0x150
[  631.985226]  [<ffffffff81115471>] do_sys_open+0x101/0x1e0
[  631.985229]  [<ffffffff81113bd6>] ? filp_close+0x66/0x90
[  631.985232]  [<ffffffff81115570>] sys_open+0x20/0x30
[  631.985235]  [<ffffffff8141ffeb>] system_call_fastpath+0x16/0x1b
[  631.985237] dbench          D 0000000000000000     0  7650   7642 0x00000000
[  631.985240]  ffff88017572db48 0000000000000086 ffff88017572da88 ffff88017572dfd8
[  631.985244]  ffff88017572dfd8 0000000000004000 ffff88017572c000 ffff88017572c000
[  631.985247]  000000000000eb40 ffff88017572dfd8 ffff8801752277f0 ffff8801769a2830
[  631.985250] Call Trace:
[  631.985253]  [<ffffffff8141740e>] ? schedule+0x2e/0xa0
[  631.985256]  [<ffffffff814174e0>] ? io_schedule+0x60/0x80
[  631.985259]  [<ffffffff8103cbc3>] ? migrate_enable+0xd3/0x1b0
[  631.985263]  [<ffffffff8103cbc3>] ? migrate_enable+0xd3/0x1b0
[  631.985266]  [<ffffffff8141740e>] schedule+0x2e/0xa0
[  631.985269]  [<ffffffff811ff93d>] jbd2_log_wait_commit+0xed/0x1d0
[  631.985271]  [<ffffffff81066b60>] ? wake_up_bit+0x40/0x40
[  631.985274]  [<ffffffff811ad35f>] ext4_sync_file+0x22f/0x390
[  631.985277]  [<ffffffff810cc89b>] ? __filemap_fdatawrite_range+0x5b/0x60
[  631.985281]  [<ffffffff81142689>] vfs_fsync_range+0x79/0x90
[  631.985284]  [<ffffffff811426e4>] generic_write_sync+0x44/0x50
[  631.985287]  [<ffffffff810ccfc6>] generic_file_aio_write+0xc6/0xe0
[  631.985290]  [<ffffffff811ace39>] ext4_file_write+0x69/0x280
[  631.985293]  [<ffffffff81125655>] ? path_openat+0x105/0x430
[  631.985296]  [<ffffffff8111589a>] do_sync_write+0xda/0x120
[  631.985299]  [<ffffffff81058422>] ? group_send_sig_info+0x42/0x80
[  631.985303]  [<ffffffff81058598>] ? kill_pid_info+0x58/0x80
[  631.985305]  [<ffffffff8121882c>] ? security_file_permission+0x2c/0xb0
[  631.985309]  [<ffffffff81115fe6>] vfs_write+0xc6/0x170
[  631.985312]  [<ffffffff81116472>] sys_pwrite64+0xa2/0xb0
[  631.985315]  [<ffffffff8141ffeb>] system_call_fastpath+0x16/0x1b
[  631.985319] Sched Debug Version: v0.10, 3.0.36-rt57 #14
[  631.985321] ktime                                   : 632710.715216
[  631.985323] sched_clk                               : 631985.318353
[  631.985325] cpu_clk                                 : 631985.318415
[  631.985327] jiffies                                 : 4295300006
[  631.985328] sched_clock_stable                      : 1
[  631.985330] 
[  631.985330] sysctl_sched
[  631.985332]   .sysctl_sched_latency                    : 24.000000
[  631.985334]   .sysctl_sched_min_granularity            : 3.000000
[  631.985335]   .sysctl_sched_wakeup_granularity         : 4.000000
[  631.985337]   .sysctl_sched_child_runs_first           : 0
[  631.985339]   .sysctl_sched_features                   : 40047
[  631.985341]   .sysctl_sched_tunable_scaling            : 1 (logaritmic)
[  631.985343] 
[  631.985343] cpu#0, 2400.139 MHz
[  631.985345]   .nr_running                    : 0
[  631.985346]   .load                          : 0
[  631.985348]   .nr_switches                   : 234578
[  631.985349]   .nr_load_updates               : 35323
[  631.985351]   .nr_uninterruptible            : 68
[  631.985352]   .next_balance                  : 4295.299250
[  631.985354]   .curr->pid                     : 0
[  631.985355]   .clock                         : 631984.217539
[  631.985357]   .cpu_load[0]                   : 0
[  631.985358]   .cpu_load[1]                   : 0
[  631.985360]   .cpu_load[2]                   : 0
[  631.985361]   .cpu_load[3]                   : 0
[  631.985362]   .cpu_load[4]                   : 0
[  631.985364] 
[  631.985364] cfs_rq[0]:
[  631.985365]   .exec_clock                    : 0.000000
[  631.985367]   .MIN_vruntime                  : 0.000001
[  631.985369]   .min_vruntime                  : 25302.660498
[  631.985371]   .max_vruntime                  : 0.000001
[  631.985372]   .spread                        : 0.000000
[  631.985374]   .spread0                       : 0.000000
[  631.985375]   .nr_spread_over                : 0
[  631.985376]   .nr_running                    : 0
[  631.985378]   .load                          : 0
[  631.985379] 
[  631.985380] rt_rq[0]:
[  631.985381]   .rt_nr_running                 : 0
[  631.985382]   .rt_throttled                  : 0
[  631.985384]   .rt_time                       : 0.027168
[  631.985385]   .rt_runtime                    : 950.000000
[  631.985387]   .rt_nr_migratory               : 0
[  631.985388] 
[  631.985389] runnable tasks:
[  631.985390]             task   PID         tree-key  switches  prio     exec-runtime         sum-exec        sum-sleep
[  631.985391] ----------------------------------------------------------------------------------------------------------
[  631.985403] 
[  631.985403] cpu#1, 2400.139 MHz
[  631.985405]   .nr_running                    : 0
[  631.985406]   .load                          : 0
[  631.985408]   .nr_switches                   : 201741
[  631.985409]   .nr_load_updates               : 26087
[  631.985411]   .nr_uninterruptible            : 50
[  631.985412]   .next_balance                  : 4295.299810
[  631.985414]   .curr->pid                     : 0
[  631.985415]   .clock                         : 631886.786271
[  631.985417]   .cpu_load[0]                   : 0
[  631.985418]   .cpu_load[1]                   : 0
[  631.985419]   .cpu_load[2]                   : 0
[  631.985421]   .cpu_load[3]                   : 0
[  631.985422]   .cpu_load[4]                   : 0
[  631.985423] 
[  631.985424] cfs_rq[1]:
[  631.985425]   .exec_clock                    : 0.000000
[  631.985427]   .MIN_vruntime                  : 0.000001
[  631.985428]   .min_vruntime                  : 79457.986147
[  631.985430]   .max_vruntime                  : 0.000001
[  631.985431]   .spread                        : 0.000000
[  631.985433]   .spread0                       : 54155.325649
[  631.985435]   .nr_spread_over                : 0
[  631.985436]   .nr_running                    : 0
[  631.985437]   .load                          : 0
[  631.985439] 
[  631.985439] rt_rq[1]:
[  631.985440]   .rt_nr_running                 : 0
[  631.985442]   .rt_throttled                  : 0
[  631.985443]   .rt_time                       : 0.034527
[  631.985445]   .rt_runtime                    : 950.000000
[  631.985446]   .rt_nr_migratory               : 0
[  631.985448] 
[  631.985448] runnable tasks:
[  631.985449]             task   PID         tree-key  switches  prio     exec-runtime         sum-exec        sum-sleep
[  631.985451] ----------------------------------------------------------------------------------------------------------
[  631.985457] 
[  631.985458] cpu#2, 2400.139 MHz
[  631.985459]   .nr_running                    : 2
[  631.985460]   .load                          : 1024
[  631.985462]   .nr_switches                   : 117056
[  631.985463]   .nr_load_updates               : 22160
[  631.985465]   .nr_uninterruptible            : -13
[  631.985467]   .next_balance                  : 4295.300007
[  631.985468]   .curr->pid                     : 1850
[  631.985470]   .clock                         : 631984.657010
[  631.985471]   .cpu_load[0]                   : 0
[  631.985472]   .cpu_load[1]                   : 0
[  631.985474]   .cpu_load[2]                   : 0
[  631.985475]   .cpu_load[3]                   : 0
[  631.985476]   .cpu_load[4]                   : 0
[  631.985477] 
[  631.985478] cfs_rq[2]:
[  631.985479]   .exec_clock                    : 0.000000
[  631.985481]   .MIN_vruntime                  : 10044.918380
[  631.985483]   .min_vruntime                  : 10055.642798
[  631.985484]   .max_vruntime                  : 10044.918380
[  631.985486]   .spread                        : 0.000000
[  631.985488]   .spread0                       : -15247.017700
[  631.985489]   .nr_spread_over                : 0
[  631.985490]   .nr_running                    : 1
[  631.985492]   .load                          : 1024
[  631.985493] 
[  631.985494] rt_rq[2]:
[  631.985495]   .rt_nr_running                 : 1
[  631.985496]   .rt_throttled                  : 0
[  631.985498]   .rt_time                       : 0.585563
[  631.985499]   .rt_runtime                    : 950.000000
[  631.985501]   .rt_nr_migratory               : 0
[  631.985502] 
[  631.985503] runnable tasks:
[  631.985503]             task   PID         tree-key  switches  prio     exec-runtime         sum-exec        sum-sleep
[  631.985505] ----------------------------------------------------------------------------------------------------------
[  631.985507]      kworker/2:0    17     10044.918380      6501   120               0               0               0.000000               0.000000               0.000000
[  631.985514] Rirq/19-uhci_hcd  1850        -7.545066      4021     4               0               0               0.000000               0.000000               0.000000
[  631.985522] 
[  631.985523] cpu#3, 2400.139 MHz
[  631.985524]   .nr_running                    : 0
[  631.985525]   .load                          : 0
[  631.985527]   .nr_switches                   : 178435
[  631.985528]   .nr_load_updates               : 17297
[  631.985530]   .nr_uninterruptible            : -43
[  631.985532]   .next_balance                  : 4295.299260
[  631.985533]   .curr->pid                     : 0
[  631.985535]   .clock                         : 631546.269284
[  631.985536]   .cpu_load[0]                   : 0
[  631.985537]   .cpu_load[1]                   : 0
[  631.985539]   .cpu_load[2]                   : 0
[  631.985540]   .cpu_load[3]                   : 0
[  631.985541]   .cpu_load[4]                   : 0
[  631.985542] 
[  631.985543] cfs_rq[3]:
[  631.985544]   .exec_clock                    : 0.000000
[  631.985546]   .MIN_vruntime                  : 0.000001
[  631.985548]   .min_vruntime                  : 8627.169383
[  631.985549]   .max_vruntime                  : 0.000001
[  631.985551]   .spread                        : 0.000000
[  631.985553]   .spread0                       : -16675.491115
[  631.985554]   .nr_spread_over                : 0
[  631.985555]   .nr_running                    : 0
[  631.985557]   .load                          : 0
[  631.985558] 
[  631.985559] rt_rq[3]:
[  631.985560]   .rt_nr_running                 : 0
[  631.985561]   .rt_throttled                  : 0
[  631.985563]   .rt_time                       : 0.009053
[  631.985564]   .rt_runtime                    : 950.000000
[  631.985566]   .rt_nr_migratory               : 0
[  631.985567] 
[  631.985568] runnable tasks:
[  631.985568]             task   PID         tree-key  switches  prio     exec-runtime         sum-exec        sum-sleep
[  631.985570] ----------------------------------------------------------------------------------------------------------
[  631.985576] 
[  631.985577] cpu#4, 2400.139 MHz
[  631.985578]   .nr_running                    : 0
[  631.985580]   .load                          : 0
[  631.985581]   .nr_switches                   : 148468
[  631.985583]   .nr_load_updates               : 31737
[  631.985584]   .nr_uninterruptible            : -36
[  631.985586]   .next_balance                  : 4295.299766
[  631.985587]   .curr->pid                     : 0
[  631.985589]   .clock                         : 631740.985709
[  631.985590]   .cpu_load[0]                   : 0
[  631.985592]   .cpu_load[1]                   : 0
[  631.985593]   .cpu_load[2]                   : 0
[  631.985594]   .cpu_load[3]                   : 0
[  631.985595]   .cpu_load[4]                   : 0
[  631.985597] 
[  631.985597] cfs_rq[4]:
[  631.985598]   .exec_clock                    : 0.000000
[  631.985600]   .MIN_vruntime                  : 0.000001
[  631.985602]   .min_vruntime                  : 26029.083901
[  631.985611]   .max_vruntime                  : 0.000001
[  631.985613]   .spread                        : 0.000000
[  631.985615]   .spread0                       : 726.423403
[  631.985616]   .nr_spread_over                : 0
[  631.985618]   .nr_running                    : 0
[  631.985619]   .load                          : 0
[  631.985620] 
[  631.985621] rt_rq[4]:
[  631.985622]   .rt_nr_running                 : 0
[  631.985623]   .rt_throttled                  : 0
[  631.985625]   .rt_time                       : 0.050084
[  631.985626]   .rt_runtime                    : 950.000000
[  631.985628]   .rt_nr_migratory               : 0
[  631.985629] 
[  631.985630] runnable tasks:
[  631.985630]             task   PID         tree-key  switches  prio     exec-runtime         sum-exec        sum-sleep
[  631.985632] ----------------------------------------------------------------------------------------------------------
[  631.985640] 
[  631.985640] cpu#5, 2400.139 MHz
[  631.985641]   .nr_running                    : 0
[  631.985643]   .load                          : 0
[  631.985644]   .nr_switches                   : 147506
[  631.985646]   .nr_load_updates               : 23546
[  631.985647]   .nr_uninterruptible            : -36
[  631.985649]   .next_balance                  : 4295.300002
[  631.985651]   .curr->pid                     : 0
[  631.985652]   .clock                         : 631978.656035
[  631.985654]   .cpu_load[0]                   : 0
[  631.985655]   .cpu_load[1]                   : 0
[  631.985656]   .cpu_load[2]                   : 0
[  631.985657]   .cpu_load[3]                   : 0
[  631.985659]   .cpu_load[4]                   : 0
[  631.985660] 
[  631.985660] cfs_rq[5]:
[  631.985662]   .exec_clock                    : 0.000000
[  631.985663]   .MIN_vruntime                  : 0.000001
[  631.985665]   .min_vruntime                  : 132027.223879
[  631.985667]   .max_vruntime                  : 0.000001
[  631.985668]   .spread                        : 0.000000
[  631.985670]   .spread0                       : 106724.563381
[  631.985672]   .nr_spread_over                : 0
[  631.985673]   .nr_running                    : 0
[  631.985674]   .load                          : 0
[  631.985676] 
[  631.985676] rt_rq[5]:
[  631.985677]   .rt_nr_running                 : 0
[  631.985679]   .rt_throttled                  : 0
[  631.985680]   .rt_time                       : 0.083941
[  631.985682]   .rt_runtime                    : 950.000000
[  631.985683]   .rt_nr_migratory               : 0
[  631.985685] 
[  631.985685] runnable tasks:
[  631.985686]             task   PID         tree-key  switches  prio     exec-runtime         sum-exec        sum-sleep
[  631.985688] ----------------------------------------------------------------------------------------------------------
[  631.985694] 
[  631.985694] cpu#6, 2400.139 MHz
[  631.985696]   .nr_running                    : 0
[  631.985697]   .load                          : 0
[  631.985698]   .nr_switches                   : 84486
[  631.985700]   .nr_load_updates               : 21653
[  631.985701]   .nr_uninterruptible            : -16
[  631.985703]   .next_balance                  : 4295.300008
[  631.985704]   .curr->pid                     : 0
[  631.985706]   .clock                         : 631978.635659
[  631.985708]   .cpu_load[0]                   : 0
[  631.985709]   .cpu_load[1]                   : 0
[  631.985710]   .cpu_load[2]                   : 0
[  631.985711]   .cpu_load[3]                   : 0
[  631.985713]   .cpu_load[4]                   : 0
[  631.985714] 
[  631.985714] cfs_rq[6]:
[  631.985716]   .exec_clock                    : 0.000000
[  631.985717]   .MIN_vruntime                  : 0.000001
[  631.985719]   .min_vruntime                  : 33318.645451
[  631.985721]   .max_vruntime                  : 0.000001
[  631.985722]   .spread                        : 0.000000
[  631.985724]   .spread0                       : 8015.984953
[  631.985725]   .nr_spread_over                : 0
[  631.985727]   .nr_running                    : 0
[  631.985728]   .load                          : 0
[  631.985729] 
[  631.985730] rt_rq[6]:
[  631.985731]   .rt_nr_running                 : 0
[  631.985732]   .rt_throttled                  : 0
[  631.985734]   .rt_time                       : 0.067606
[  631.985735]   .rt_runtime                    : 950.000000
[  631.985737]   .rt_nr_migratory               : 0
[  631.985738] 
[  631.985739] runnable tasks:
[  631.985739]             task   PID         tree-key  switches  prio     exec-runtime         sum-exec        sum-sleep
[  631.985741] ----------------------------------------------------------------------------------------------------------
[  631.985747] 
[  631.985748] cpu#7, 2400.139 MHz
[  631.985749]   .nr_running                    : 0
[  631.985750]   .load                          : 0
[  631.985752]   .nr_switches                   : 57948
[  631.985753]   .nr_load_updates               : 16003
[  631.985755]   .nr_uninterruptible            : 37
[  631.985756]   .next_balance                  : 4295.297384
[  631.985758]   .curr->pid                     : 0
[  631.985759]   .clock                         : 631865.747576
[  631.985761]   .cpu_load[0]                   : 0
[  631.985762]   .cpu_load[1]                   : 0
[  631.985763]   .cpu_load[2]                   : 0
[  631.985765]   .cpu_load[3]                   : 0
[  631.985766]   .cpu_load[4]                   : 0
[  631.985767] 
[  631.985768] cfs_rq[7]:
[  631.985769]   .exec_clock                    : 0.000000
[  631.985771]   .MIN_vruntime                  : 0.000001
[  631.985772]   .min_vruntime                  : 15319.070577
[  631.985774]   .max_vruntime                  : 0.000001
[  631.985776]   .spread                        : 0.000000
[  631.985777]   .spread0                       : -9983.589921
[  631.985779]   .nr_spread_over                : 0
[  631.985780]   .nr_running                    : 0
[  631.985781]   .load                          : 0
[  631.985783] 
[  631.985783] rt_rq[7]:
[  631.985784]   .rt_nr_running                 : 0
[  631.985786]   .rt_throttled                  : 0
[  631.985787]   .rt_time                       : 0.008954
[  631.985789]   .rt_runtime                    : 950.000000
[  631.985790]   .rt_nr_migratory               : 0
[  631.985792] 
[  631.985792] runnable tasks:
[  631.985793]             task   PID         tree-key  switches  prio     exec-runtime         sum-exec        sum-sleep
[  631.985795] ----------------------------------------------------------------------------------------------------------
[  631.985800] 


