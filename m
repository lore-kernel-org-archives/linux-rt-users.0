From: Yang Shi <yang.shi@linaro.org>
Subject: [PATCH] f2fs: mutex can't be used by down_write_nest_lock()
Date: Fri, 26 Feb 2016 16:25:25 -0800
Message-ID: <1456532725-4126-1-git-send-email-yang.shi@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org, yang.shi@linaro.org
To: jaegeuk@kernel.org, cm224.lee@samsung.com, chao2.yu@samsung.com,
	tglx@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

fsf2_lock_all() calls down_write_nest_lock() to acquire a rw_sem and check
a mutex, but down_write_nest_lock() is designed for two rw_sem accoring to the
comment in include/linux/rwsem.h. And, other than f2fs, it is just called in
mm/mmap.c with two rwsem.

So, it looks it is used wrongly by f2fs. And, it causes the below compile
warning on -rt kernel too.

In file included from fs/f2fs/xattr.c:25:0:
fs/f2fs/f2fs.h: In function 'f2fs_lock_all':
fs/f2fs/f2fs.h:962:34: warning: passing argument 2 of 'down_write_nest_lock' from incompatible pointer type [-Wincompatible-pointer-types]
  f2fs_down_write(&sbi->cp_rwsem, &sbi->cp_mutex);
                                  ^
fs/f2fs/f2fs.h:27:55: note: in definition of macro 'f2fs_down_write'
 #define f2fs_down_write(x, y) down_write_nest_lock(x, y)
                                                       ^
In file included from include/linux/rwsem.h:22:0,
                 from fs/f2fs/xattr.c:21:
include/linux/rwsem_rt.h:138:20: note: expected 'struct rw_semaphore *' but argument is of type 'struct mutex *'
 static inline void down_write_nest_lock(struct rw_semaphore *sem,

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 fs/f2fs/f2fs.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ff79054..af77c1a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -25,7 +25,6 @@
 
 #ifdef CONFIG_F2FS_CHECK_FS
 #define f2fs_bug_on(sbi, condition)	BUG_ON(condition)
-#define f2fs_down_write(x, y)	down_write_nest_lock(x, y)
 #else
 #define f2fs_bug_on(sbi, condition)					\
 	do {								\
@@ -34,7 +33,6 @@
 			set_sbi_flag(sbi, SBI_NEED_FSCK);		\
 		}							\
 	} while (0)
-#define f2fs_down_write(x, y)	down_write(x)
 #endif
 
 /*
@@ -1006,7 +1004,7 @@ static inline void f2fs_unlock_op(struct f2fs_sb_info *sbi)
 
 static inline void f2fs_lock_all(struct f2fs_sb_info *sbi)
 {
-	f2fs_down_write(&sbi->cp_rwsem, &sbi->cp_mutex);
+	down_write(&sbi->cp_rwsem);
 }
 
 static inline void f2fs_unlock_all(struct f2fs_sb_info *sbi)
-- 
2.0.2
