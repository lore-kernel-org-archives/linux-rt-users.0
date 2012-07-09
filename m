From: Mike Galbraith <efault@gmx.de>
Subject: Re: 3.0-rt: ext4 sync IO logjam
Date: Mon, 09 Jul 2012 07:40:14 +0200
Message-ID: <1341812414.7370.73.camel@marge.simpson.net>
References: <1341044702.7381.93.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Theodore Tso <tytso@mit.edu>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:37677 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751073Ab2GIFkT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Jul 2012 01:40:19 -0400
In-Reply-To: <1341044702.7381.93.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2012-06-30 at 10:25 +0200, Mike Galbraith wrote: 
> Greetings,
> 
> While chasing down an ext3 IO logjam, I stumbled into a similar looking
> logjam in ext4.  A simple taskset -c 3 dbench -s 8 will lock a box up in
> pretty short order.  ext3 logjam I was chasing turned out to be a not so
> rt friendly patch in enterprise land.  This one is in virgin source.

Nope, patches were innocent.

> I beat virgin ext3 hard, and couldn't induce any journal troubles.

But, if I beat ext3 with the suse qa test package, I bet it will lock,
just a matter of time.  For whatever reason, I've yet to lock up any box
sitting in front of it trying to pound ext3 into the ground, but run
full qa dbench test package repeatedly, eventually IO stops, box 'D'ies.
My crippled 64 core DL980 (thinks it's one node w. 64 cores) w. 1 x
spinning rust bucket jams up pretty reliably.

Unplugging in __log_wait_for_space() prevents everybody waiting for
everyone else forever.  On DL980 box, I measured flush being nailed in
write_cache_pages() for three MINUTES by a page locked by dbench on it's
way to submitting IO with __log_wait_for_space() in the way even when
pulling plugs (don't pull plugs, latency can become infinity).  A quick
test on virgin 3.0-rt with the same diag page/bh patchlet on 4 core box
quickly hit 13 seconds (and it was dbench being nailed usually, vs flush
usually on enterprise DL980.. shrug), but I bet it'll go loads higher,
and eventually lock up tight as well.

Skipping the locked page in write_cache_pages() prevent live lock, as
does not waiting for space with your plug intact, though latencies, as
mentioned, can be really horrible when the test hits dbench -s 500
phase.

I still haven't dug into the ext4 lockup other than to check that it's
not quite the same, but the below appears to have fixed up my much
harder to hit ext3 stalls. 

fs, jbd: pull your plug when waiting for space

With an -rt kernel, and a heavy sync IO load, tasks can jam
up on journal locks without unplugging, which can lead to
terminal IO starvation.  Unplug and schedule when waiting for space.

Signed-off-by: Mike Galbraith <mgalbraith@suse.de>
---
 fs/jbd/checkpoint.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/jbd/checkpoint.c
+++ b/fs/jbd/checkpoint.c
@@ -124,6 +124,8 @@ void __log_wait_for_space(journal_t *jou
 		if (journal->j_flags & JFS_ABORT)
 			return;
 		spin_unlock(&journal->j_state_lock);
+		if (current->plug)
+			io_schedule();
 		mutex_lock(&journal->j_checkpoint_mutex);
 
 		/*


In this crash dump, flush is spinning, due to an rt unsafe trylock loop
(now fixed) in an optimization that should be mainlined.  If it weren't
doing that, it'd be sleeping forever like everybody else.  I removed the
optimizations to verify that they weren't inducing the problem.

crash> bt 1613
PID: 1613   TASK: ffff88026f424380  CPU: 40  COMMAND: "flush-104:0"
 #0 [ffff88027eb06e30] crash_nmi_callback at ffffffff8101fbff
 #1 [ffff88027eb06e40] notifier_call_chain at ffffffff8148984f
 #2 [ffff88027eb06e80] __atomic_notifier_call_chain at ffffffff814898d8
 #3 [ffff88027eb06ec0] atomic_notifier_call_chain at ffffffff81489911
 #4 [ffff88027eb06ed0] notify_die at ffffffff8148994e
 #5 [ffff88027eb06f00] default_do_nmi at ffffffff81487009
 #6 [ffff88027eb06f30] do_nmi at ffffffff814871e8                                                                                                                                                                                           
 #7 [ffff88027eb06f50] nmi at ffffffff814868d0
    [exception RIP: spin_trylock_page+97]
    RIP: ffffffff810f8131  RSP: ffff88026da4b8e0  RFLAGS: 00000246
    RAX: 0000000000000000  RBX: ffffea000017ec90  RCX: 0000000000000000
    RDX: ffff88026da4a010  RSI: ffff88026f424380  RDI: ffffea000017ec90
    RBP: ffff88026da4b8e0   R8: 2400000000000000   R9: 2000000000000000
    R10: 0000000000000000  R11: 0000000000000000  R12: ffff88026da4b900
    R13: ffff88027ff52b80  R14: ffff88026da4b8f0  R15: 0000000000000000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <RT exception stack> ---
 #8 [ffff88026da4b8e0] spin_trylock_page at ffffffff810f8131
 #9 [ffff88026da4b8e8] __lock_page at ffffffff810f8978
#10 [ffff88026da4b958] write_cache_pages at ffffffff81104368
#11 [ffff88026da4ba98] generic_writepages at ffffffff8110459f
#12 [ffff88026da4baf8] do_writepages at ffffffff811045f5
#13 [ffff88026da4bb08] writeback_single_inode at ffffffff81182f85
#14 [ffff88026da4bb68] writeback_sb_inodes at ffffffff81183690
#15 [ffff88026da4bbd8] writeback_inodes_wb at ffffffff811839d9
#16 [ffff88026da4bc28] wb_writeback at ffffffff81183e5b
#17 [ffff88026da4bd28] wb_do_writeback at ffffffff811840b2
#18 [ffff88026da4bdd8] bdi_writeback_thread at ffffffff811842db
#19 [ffff88026da4be78] kthread at ffffffff8107e4d6
#20 [ffff88026da4bf48] kernel_thread_helper at ffffffff8148e464

Flush is waiting for a page locked by blocked dbench.  Don't block here,
IO continues, stall doesn't happen.
crash> bt 2417
PID: 2417   TASK: ffff880268a16d60  CPU: 9   COMMAND: "kjournald"
 #0 [ffff880267ebfa90] schedule at ffffffff81483923
 #1 [ffff880267ebfbf8] io_schedule at ffffffff814841dc
 #2 [ffff880267ebfc28] sleep_on_buffer at ffffffff8118b389
 #3 [ffff880267ebfc38] __wait_on_bit at ffffffff8148499a
 #4 [ffff880267ebfc78] out_of_line_wait_on_bit at ffffffff81484a44
 #5 [ffff880267ebfce8] __wait_on_buffer at ffffffff8118b356
 #6 [ffff880267ebfcf8] journal_commit_transaction at ffffffff811f160a
 #7 [ffff880267ebfdf8] kjournald at ffffffff811f4774
 #8 [ffff880267ebfe78] kthread at ffffffff8107e4d6
 #9 [ffff880267ebff48] kernel_thread_helper at ffffffff8148e464

kjournald in this particular case got nailed by a bh submitted by
somebody else.. b_end_io = end_buffer_async_write.

PID: 11158  TASK: ffff88026eb749e0  CPU: 9   COMMAND: "dbench"
 #0 [ffff88026e1ed9c8] schedule at ffffffff81483923
 #1 [ffff88026e1edb30] io_schedule at ffffffff814841dc
 #2 [ffff88026e1edb60] sleep_on_page at ffffffff810f87f9
 #3 [ffff88026e1edb70] __wait_on_bit at ffffffff8148499a
 #4 [ffff88026e1edbb0] wait_on_page_bit at ffffffff810f8f2f
 #5 [ffff88026e1edc10] filemap_fdatawait_range at ffffffff810f9fbe
 #6 [ffff88026e1edcf0] filemap_write_and_wait_range at ffffffff810fa13f
 #7 [ffff88026e1edd20] ext3_sync_file at ffffffff811d8a70
 #8 [ffff88026e1edd60] vfs_fsync_range at ffffffff81187d93
 #9 [ffff88026e1edd70] generic_write_sync at ffffffff81187e02
#10 [ffff88026e1edd80] generic_file_aio_write at ffffffff810fadf6
#11 [ffff88026e1ede00] do_sync_write at ffffffff811594a1
#12 [ffff88026e1edf10] vfs_write at ffffffff81159aeb
#13 [ffff88026e1edf40] sys_write at ffffffff81159c43
#14 [ffff88026e1edf80] system_call_fastpath at ffffffff8148d312
    RIP: 00007f76b0412160  RSP: 00007fff6a102320  RFLAGS: 00010202
    RAX: 0000000000000001  RBX: ffffffff8148d312  RCX: ffffffffffffffff
    RDX: 0000000000000035  RSI: 00007f76b08d8000  RDI: 0000000000000001
    RBP: 00007f76b08d8000   R8: 0000000000000000   R9: 00000000ffffffff
    R10: 00007f76b08aa700  R11: 0000000000000246  R12: 0000000000000000
    R13: 0000000000000035  R14: 00007f76b06b67a0  R15: 0000000000000035
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b

PID: 11317  TASK: ffff880146a58ca0  CPU: 18  COMMAND: "dbench"
 #0 [ffff88026eb0d588] schedule at ffffffff81483923
 #1 [ffff88026eb0d6f0] log_wait_commit at ffffffff811f45e5
 #2 [ffff88026eb0d780] __process_buffer at ffffffff811f2c7c
 #3 [ffff88026eb0d7c0] log_do_checkpoint at ffffffff811f2f1f
 #4 [ffff88026eb0da30] __log_wait_for_space at ffffffff811f3137
 #5 [ffff88026eb0da80] start_this_handle at ffffffff811eedc4
 #6 [ffff88026eb0db20] journal_start at ffffffff811ef2dd
 #7 [ffff88026eb0db50] ext3_journal_start_sb at ffffffff811e6cfc
 #8 [ffff88026eb0db60] ext3_write_begin at ffffffff811de487
 #9 [ffff88026eb0dbe0] generic_perform_write at ffffffff810f7abc
#10 [ffff88026eb0dc60] generic_file_buffered_write at ffffffff810f7c10
#11 [ffff88026eb0dcc0] __generic_file_aio_write at ffffffff810fab7c
#12 [ffff88026eb0dd70] generic_file_aio_write at ffffffff810fadd4
#13 [ffff88026eb0ddf0] do_sync_write at ffffffff811594a1
#14 [ffff88026eb0df00] vfs_write at ffffffff81159aeb
#15 [ffff88026eb0df30] sys_pwrite64 at ffffffff81159bea
#16 [ffff88026eb0df80] system_call_fastpath at ffffffff8148d312
    RIP: 00007f76b0410373  RSP: 00007fff6a101b10  RFLAGS: 00010246
    RAX: 0000000000000012  RBX: ffffffff8148d312  RCX: 00000000006185b0
    RDX: 0000000000010000  RSI: 00000000006085b0  RDI: 0000000000000005
    RBP: 00007f76b08d4290   R8: 0000000000000008   R9: 0000000000180000
    R10: 0000000000010000  R11: 0000000000000246  R12: 0000000000010000
    R13: 0000000000010000  R14: 0000000000010000  R15: 0000000000000000
    ORIG_RAX: 0000000000000012  CS: 0033  SS: 002b

383 remaining dbench instances also waiting for what ain't gonna happen.

PID: 11159  TASK: ffff880103f78140  CPU: 10  COMMAND: "dbench"
 #0 [ffff8802744a9768] schedule at ffffffff81483923
 #1 [ffff8802744a98d0] __rt_mutex_slowlock at ffffffff814852bb
 #2 [ffff8802744a9930] rt_mutex_slowlock at ffffffff8148541d
 #3 [ffff8802744a9a10] rt_mutex_lock at ffffffff81485522
 #4 [ffff8802744a9a20] _mutex_lock at ffffffff81485d29
 #5 [ffff8802744a9a30] __log_wait_for_space at ffffffff811f317b
 #6 [ffff8802744a9a80] start_this_handle at ffffffff811eedc4
 #7 [ffff8802744a9b20] journal_start at ffffffff811ef2dd
 #8 [ffff8802744a9b50] ext3_journal_start_sb at ffffffff811e6cfc
 #9 [ffff8802744a9b60] ext3_write_begin at ffffffff811de487
#10 [ffff8802744a9be0] generic_perform_write at ffffffff810f7abc
#11 [ffff8802744a9c60] generic_file_buffered_write at ffffffff810f7c10
#12 [ffff8802744a9cc0] __generic_file_aio_write at ffffffff810fab7c
#13 [ffff8802744a9d70] generic_file_aio_write at ffffffff810fadd4
#14 [ffff8802744a9df0] do_sync_write at ffffffff811594a1
#15 [ffff8802744a9f00] vfs_write at ffffffff81159aeb
#16 [ffff8802744a9f30] sys_pwrite64 at ffffffff81159bea
#17 [ffff8802744a9f80] system_call_fastpath at ffffffff8148d312
    RIP: 00007f76b0410373  RSP: 00007fff6a101a58  RFLAGS: 00010206
    RAX: 0000000000000012  RBX: ffffffff8148d312  RCX: 00000000006072ec
    RDX: 0000000000010000  RSI: 0000000000608560  RDI: 0000000000000005


