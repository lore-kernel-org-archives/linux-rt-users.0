From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.33.1-rt11 BUG: sleeping function called from invalid context
 at kernel/rtmutex.c:684
Date: Tue, 6 Apr 2010 10:07:26 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1004061005300.32352@localhost.localdomain>
References: <4BB8587F.40307@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>
To: Udo van den Heuvel <udovdh@xs4all.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:39044 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698Ab0DFIHb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Apr 2010 04:07:31 -0400
In-Reply-To: <4BB8587F.40307@xs4all.nl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 4 Apr 2010, Udo van den Heuvel wrote:

> Hello,
> 
> I see a load of these after booting into 2.6.33.1-rt11:
> 
> BUG: sleeping function called from invalid context at kernel/rtmutex.c:684
> pcnt: 1 0 in_atomic(): 1, irqs_disabled(): 0, pid: 1507, name: md1_raid5
> Pid: 1507, comm: md1_raid5 Not tainted 2.6.33.1-rt11 #1
> Call Trace:
>  [<ffffffff8138fb8c>] ? rt_spin_lock+0x2c/0x70
>  [<ffffffff812becc4>] ? __raid_run_ops+0x304/0xc60
>  [<ffffffff812c0ccd>] ? handle_stripe+0x6bd/0x1a70
>  [<ffffffff8104b460>] ? mod_timer+0x150/0x200
>  [<ffffffff812c23f6>] ? raid5d+0x376/0x4f0
>  [<ffffffff8138e5bd>] ? schedule_timeout+0x22d/0x2b0
>  [<ffffffff8138fb8c>] ? rt_spin_lock+0x2c/0x70
>  [<ffffffff812cd0f3>] ? md_thread+0x53/0x120
>  [<ffffffff810573a0>] ? autoremove_wake_function+0x0/0x30
>  [<ffffffff812cd0a0>] ? md_thread+0x0/0x120
>  [<ffffffff81057016>] ? kthread+0x96/0xa0
>  [<ffffffff81037908>] ? finish_task_switch+0x58/0xd0
>  [<ffffffff810032d4>] ? kernel_thread_helper+0x4/0x10
>  [<ffffffff81056f80>] ? kthread+0x0/0xa0
>  [<ffffffff810032d0>] ? kernel_thread_helper+0x0/0x10
> 
> As these appear to be touching my raid array I am quite eager to learn
> how I can fix the BUGs.
> 
> Please have a look and explain.

That's caused by the get_cpu()/put_cpu() preempt disabled region. Can
you try the following (untested) patch ?

Thanks,

	tglx
---
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index ceb24af..b61eaa6 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1149,8 +1149,9 @@ static void __raid_run_ops(struct stripe_head *sh, unsigned long ops_request)
 	struct raid5_percpu *percpu;
 	unsigned long cpu;
 
-	cpu = get_cpu();
+	cpu = raw_smp_processor_id();
 	percpu = per_cpu_ptr(conf->percpu, cpu);
+	spin_lock(&percpu->lock);
 	if (test_bit(STRIPE_OP_BIOFILL, &ops_request)) {
 		ops_run_biofill(sh);
 		overlap_clear++;
@@ -1202,7 +1203,7 @@ static void __raid_run_ops(struct stripe_head *sh, unsigned long ops_request)
 			if (test_and_clear_bit(R5_Overlap, &dev->flags))
 				wake_up(&sh->raid_conf->wait_for_overlap);
 		}
-	put_cpu();
+	spin_unlock(&percpu->lock);
 }
 
 #ifdef CONFIG_MULTICORE_RAID456
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index dd70835..2db71cd 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -400,6 +400,7 @@ struct raid5_private_data {
 					    */
 	/* per cpu variables */
 	struct raid5_percpu {
+		spinlock_t	lock;	     /* Protection for -RT */
 		struct page	*spare_page; /* Used when checking P/Q in raid6 */
 		void		*scribble;   /* space for constructing buffer
 					      * lists and performing address
