From: john stultz <johnstul@us.ibm.com>
Subject: [PATCH 2/2] Resolve mntput_no_expire issues.
Date: Wed, 12 May 2010 17:52:14 -0700
Message-ID: <1273711934.2856.22.camel@localhost.localdomain>
References: <1273711544.2856.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>,
	Darren Hart <dvhltc@us.ibm.com>, Nick Piggin <npiggin@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:40363 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756268Ab0EMAwU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 May 2010 20:52:20 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4D0dmQ8023199
	for <linux-rt-users@vger.kernel.org>; Wed, 12 May 2010 20:39:48 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o4D0qJX1163018
	for <linux-rt-users@vger.kernel.org>; Wed, 12 May 2010 20:52:19 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id o4D0qJnh007039
	for <linux-rt-users@vger.kernel.org>; Wed, 12 May 2010 21:52:19 -0300
In-Reply-To: <1273711544.2856.15.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

In testing the mnt_count typo fix, I hit a few BUG_ON/WARN_ON messages
in the mntput_no_expire code.

The first issue was a race against the MNT_MOUNTED flag, where if after
the optimistic lock free check is done, someone changes the value, we
might BUG_ON after getting the lock.  The fix is after getting the lock,
re-check the MNT_MOUNTED bit and drop the lock and try again if its
changed.

The second issue was a call to smp_processor_id() in add_mnt_count()
that was done while preemptable. This was missed in my earlier commit
070976b5b038218900648ea4cc88786d5dfcd58d.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

diff --git a/fs/namespace.c b/fs/namespace.c
index 35c56c2..d8dcabb 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -752,6 +752,7 @@ void mntput_no_expire(struct vfsmount *mnt)
 {
 	int cpu = get_cpu();
 	put_cpu();
+repeat:
 	if (likely(mnt->mnt_flags & MNT_MOUNTED)) {
 		vfsmount_read_lock(cpu);
 		if (unlikely(!(mnt->mnt_flags & MNT_MOUNTED))) {
@@ -766,9 +767,11 @@ void mntput_no_expire(struct vfsmount *mnt)
 		return;
 	}
 
-repeat:
 	vfsmount_write_lock();
-	BUG_ON(mnt->mnt_flags & MNT_MOUNTED);
+	if (unlikely((mnt->mnt_flags & MNT_MOUNTED))) {
+		vfsmount_write_unlock();
+		goto repeat;
+	}
 	preempt_disable();
 	dec_mnt_count(mnt);
 	preempt_enable();
@@ -781,7 +784,9 @@ repeat:
 		__mntput(mnt);
 		return;
 	}
+	preempt_disable();
 	add_mnt_count(mnt, mnt->mnt_pinned + 1);
+	preempt_enable();
 	mnt->mnt_pinned = 0;
 	vfsmount_write_unlock();
 	acct_auto_close_mnt(mnt);


