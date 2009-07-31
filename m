From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: [PATCH] 2.6.31-rc4-rt1: Convert xt_info_lock.lock to
	atomic_spinlock_t
Date: Fri, 31 Jul 2009 13:50:56 -0300
Message-ID: <20090731165056.GJ22657@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark.williams@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:59165 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbZGaQvH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 31 Jul 2009 12:51:07 -0400
Received: by rv-out-0506.google.com with SMTP id f6so647409rvb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 31 Jul 2009 09:51:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Convert xt_info_lock.lock to atomic_spinlock_t

If xt_info_lock.lock is not a atomic_spinlock_t, every time I stop the
ip6tables initscript (i.e. 'service ip6tables restart') my machine panics.
In other words, it is hanging on every shutdown and every time I try to
stop the ip6tables service.

During normal use I see messages like this one:

 ================================================
 [ BUG: lock held when returning to user space! ]
 ------------------------------------------------
 deluged/2933 is leaving the kernel with locks still held!
 1 lock held by deluged/2933:
  #0:  (<NULL>){......}, at: [<ffffffffa02759e1>] ipt_do_table+0x10b/0x5ea [ip_tables]

This patch fixes the issue. It may be not the most elegant solution but
may help pointing to the right direction.

Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
diff --git a/include/linux/netfilter/x_tables.h b/include/linux/netfilter/x_tables.h
index f7ab3f9..2d992d4 100644
--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -450,7 +450,7 @@ extern void xt_free_table_info(struct xt_table_info *info);
  *  necessary for reading the counters.
  */
 struct xt_info_lock {
-	spinlock_t lock;
+	atomic_spinlock_t lock;
 	unsigned char readers;
 };
 DECLARE_PER_CPU(struct xt_info_lock, xt_info_locks);
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

