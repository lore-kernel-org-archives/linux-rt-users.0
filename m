From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 14/17] f2fs: Mutex cant be used by down_write_nest_lock()
Date: Wed, 02 Mar 2016 10:44:47 -0500
Message-ID: <20160302154502.045854886@goodmis.org>
References: <20160302154433.638594715@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Yang Shi <yang.shi@linaro.org>, <cm224.lee@samsung.com>,
	<chao2.yu@samsung.com>, <linaro-kernel@lists.linaro.org>,
	<linux-f2fs-devel@lists.sourceforge.net>,
	<linux-fsdevel@vger.kernel.org>, <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59827 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755721AbcCBPpK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Mar 2016 10:45:10 -0500
Content-Disposition: inline; filename=0014-f2fs-Mutex-can-t-be-used-by-down_write_nest_lock.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.14.61-rt64-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Yang Shi <yang.shi@linaro.org>

fsf2_lock_all() calls down_write_nest_lock() to acquire a rw_sem and check
a mutex, but down_write_nest_lock() is designed for two rw_sem accoring to the
comment in include/linux/rwsem.h. And, other than f2fs, it is just called in
mm/mmap.c with two rwsem.

So, it looks it is used wrongly by f2fs. And, it causes the below compile
warning on -rt kernel too.

In file included from fs/f2fs/xattr.c:25:0:
fs/f2fs/f2fs.h: In function 'f2fs_lock_all':
fs/f2fs/f2fs.h:962:34: warning: passing argument 2 of 'down_write_nest_lock' from
		       incompatible pointer type [-Wincompatible-pointer-types]
  f2fs_down_write(&sbi->cp_rwsem, &sbi->cp_mutex);
                                  ^

The nest annotation was anyway bogus as nested annotations for lockdep are
only required if one nests two locks of the same lock class, which is not the
case here.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
Cc: cm224.lee@samsung.com
Cc: chao2.yu@samsung.com
Cc: linaro-kernel@lists.linaro.org
Cc: linux-rt-users@vger.kernel.org
Cc: bigeasy@linutronix.de
Cc: rostedt@goodmis.org
Cc: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org
Cc: jaegeuk@kernel.org
Link: http://lkml.kernel.org/r/1456532725-4126-1-git-send-email-yang.shi@linaro.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 fs/f2fs/f2fs.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fc3c558cb4f3..36c2cd00cfa9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -22,10 +22,8 @@
 
 #ifdef CONFIG_F2FS_CHECK_FS
 #define f2fs_bug_on(condition)	BUG_ON(condition)
-#define f2fs_down_write(x, y)	down_write_nest_lock(x, y)
 #else
 #define f2fs_bug_on(condition)
-#define f2fs_down_write(x, y)	down_write(x)
 #endif
 
 /*
@@ -590,7 +588,7 @@ static inline void f2fs_unlock_op(struct f2fs_sb_info *sbi)
 
 static inline void f2fs_lock_all(struct f2fs_sb_info *sbi)
 {
-	f2fs_down_write(&sbi->cp_rwsem, &sbi->cp_mutex);
+	down_write(&sbi->cp_rwsem);
 }
 
 static inline void f2fs_unlock_all(struct f2fs_sb_info *sbi)
-- 
2.7.0


