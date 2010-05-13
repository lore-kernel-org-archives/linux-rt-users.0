From: john stultz <johnstul@us.ibm.com>
Subject: [PATCH 1/2] Fix mnt_count typo
Date: Wed, 12 May 2010 17:45:44 -0700
Message-ID: <1273711544.2856.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	Darren Hart <dvhltc@us.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:48001 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294Ab0EMApu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 May 2010 20:45:50 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4D0eO9x006750
	for <linux-rt-users@vger.kernel.org>; Wed, 12 May 2010 20:40:24 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o4D0jnZo175886
	for <linux-rt-users@vger.kernel.org>; Wed, 12 May 2010 20:45:49 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id o4D0jnJO028338
	for <linux-rt-users@vger.kernel.org>; Wed, 12 May 2010 21:45:49 -0300
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark noticed the following snippit in commit
070976b5b038218900648ea4cc88786d5dfcd58d :

        if (mnt->mnt_pinned) {
-               inc_mnt_count(mnt);
+               preempt_disable();
+               dec_mnt_count(mnt);
+               preempt_enable();
                mnt->mnt_pinned--;
        }
        vfsmount_write_unlock();


I accidentally replaced an inc_mnt_count() with a dec_mnt_count().

The issue went unnoticed, as the only user of mnt_unpin in the acct
syscall.

This patch corrects the mistake.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

diff --git a/fs/namespace.c b/fs/namespace.c
index 35c56c2..ed4a3ea 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -825,7 +825,7 @@ void mnt_unpin(struct vfsmount *mnt)
 	vfsmount_write_lock();
 	if (mnt->mnt_pinned) {
 		preempt_disable();
-		dec_mnt_count(mnt);
+		inc_mnt_count(mnt);
 		preempt_enable();
 		mnt->mnt_pinned--;
 	}


