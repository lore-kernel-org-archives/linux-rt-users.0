From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH][RT] xfs: Disable preemption when grabbing all icsb counter
 locks
Date: Thu, 30 Apr 2015 12:33:03 -0400
Message-ID: <20150430123303.30f5bd12@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Peter Zijlstra <peterz@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]:44885 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750891AbbD3QdH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Apr 2015 12:33:07 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Running a test on a large CPU count box with xfs, I hit a live lock
with the following backtraces on several CPUs:

 Call Trace:              
  [<ffffffff812c34f8>] __const_udelay+0x28/0x30 
  [<ffffffffa033ab9a>] xfs_icsb_lock_cntr+0x2a/0x40 [xfs] 
  [<ffffffffa033c871>] xfs_icsb_modify_counters+0x71/0x280 [xfs] 
  [<ffffffffa03413e1>] xfs_trans_reserve+0x171/0x210 [xfs] 
  [<ffffffffa0378cfd>] xfs_create+0x24d/0x6f0 [xfs] 
  [<ffffffff8124c8eb>] ? avc_has_perm_flags+0xfb/0x1e0 
  [<ffffffffa0336eeb>] xfs_vn_mknod+0xbb/0x1e0 [xfs] 
  [<ffffffffa0337043>] xfs_vn_create+0x13/0x20 [xfs] 
  [<ffffffff811b0edd>] vfs_create+0xcd/0x130 
  [<ffffffff811b21ef>] do_last+0xb8f/0x1240 
  [<ffffffff811b39b2>] path_openat+0xc2/0x490 

Looking at the code I see it was stuck at: 

STATIC void
xfs_icsb_lock_cntr(
	xfs_icsb_cnts_t	*icsbp)
{
	while (test_and_set_bit(XFS_ICSB_FLAG_LOCK, &icsbp->icsb_flags)) {
		ndelay(1000);
	}
}

I'm not sure why it does the ndelay() and not just a cpu_relax(), but
that's besides the point. In xfs_icsb_modify_counters() the code is
fine. There's a preempt_disable() called when taking this bit spinlock
and a preempt_enable() after it is released. The issue is that not all
locations are protected by preempt_disable() when PREEMPT_RT is set.
Namely the places that grab all CPU cntr locks.

STATIC void
xfs_icsb_lock_all_counters(
	xfs_mount_t	*mp)
{
	xfs_icsb_cnts_t *cntp;
	int		i;

	for_each_online_cpu(i) {
		cntp = (xfs_icsb_cnts_t *)per_cpu_ptr(mp->m_sb_cnts, i);
		xfs_icsb_lock_cntr(cntp);
	}
}

STATIC void
xfs_icsb_disable_counter()
{
	[...]
	xfs_icsb_lock_all_counters(mp);
	[...]
	xfs_icsb_unlock_all_counters(mp);
}


STATIC void
xfs_icsb_balance_counter_locked()
{
	[...]
	xfs_icsb_disable_counter();
	[...]
}

STATIC void
xfs_icsb_balance_counter(
	xfs_mount_t	*mp,
	xfs_sb_field_t  fields,
	int		min_per_cpu)
{
	spin_lock(&mp->m_sb_lock);
	xfs_icsb_balance_counter_locked(mp, fields, min_per_cpu);
	spin_unlock(&mp->m_sb_lock);
}

Now, when PREEMPT_RT is not enabled, that spin_lock() disables
preemption. But for PREEMPT_RT, it does not. Although with my test box I
was not able to produce a task state of all tasks, but I'm assuming that
some task called the xfs_icsb_lock_all_counters() and was preempted by
an RT task and could not finish, causing all callers of that lock to
block indefinitely.

Looking at all users of xfs_icsb_lock_all_counters(), they are leaf
functions and do not call anything that may block on PREEMPT_RT. I
believe the proper fix here is to simply disable preemption in
xfs_icsb_lock_all_counters() when PREEMPT_RT is enabled.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 51435dbce9c4..dbaa1ce3f308 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -1660,6 +1660,12 @@ xfs_icsb_lock_all_counters(
 	xfs_icsb_cnts_t *cntp;
 	int		i;
 
+	/*
+	 * In PREEMPT_RT, preemption is not disabled here, and it
+	 * must be to take the xfs_icsb_lock_cntr.
+	 */
+	preempt_disable_rt();
+
 	for_each_online_cpu(i) {
 		cntp = (xfs_icsb_cnts_t *)per_cpu_ptr(mp->m_sb_cnts, i);
 		xfs_icsb_lock_cntr(cntp);
@@ -1677,6 +1683,8 @@ xfs_icsb_unlock_all_counters(
 		cntp = (xfs_icsb_cnts_t *)per_cpu_ptr(mp->m_sb_cnts, i);
 		xfs_icsb_unlock_cntr(cntp);
 	}
+
+	preempt_enable_rt();
 }
 
 STATIC void
