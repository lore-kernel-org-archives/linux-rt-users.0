From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/4] fs,btrfs: fix rt deadlock on extent_buffer->lock
Date: Tue, 17 Mar 2015 12:25:22 -0400
Message-ID: <20150317162556.461877278@goodmis.org>
References: <20150317162521.748798934@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Clark Williams <williams@redhat.com>,
	Chris Mason <chris.mason@fusionio.com>,
	Mike Galbraith <efault@gmx.de>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0039-fs-btrfs-fix-rt-deadlock-on-extent_buffer-lock.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.14.34-rt32-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <mgalbraith@suse.de>

Sat Jul 14 12:30:41 CEST 2012

Trivially repeatable deadlock is cured by enabling lockdep code in
btrfs_clear_path_blocking() as suggested by Chris Mason.  He also
suggested restricting blocking reader count to one, and not allowing
a spinning reader while blocking reader exists.  This has proven to
be unnecessary, the strict lock order enforcement is enough.. or
rather that's my box's opinion after long hours of hard pounding.

Note: extent-tree.c bit is additional recommendation from Chris
      Mason, split into a separate patch after discussion.

Link: http://lkml.kernel.org/r/1414913478.5380.114.camel@marge.simpson.net

Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Carsten Emde <C.Emde@osadl.org>
Cc: John Kacur <jkacur@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Clark Williams <williams@redhat.com>
Cc: Chris Mason <chris.mason@fusionio.com>
Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 fs/btrfs/ctree.c       | 4 ++--
 fs/btrfs/extent-tree.c | 8 --------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index cbd3a7d6fa68..50c7edc8f4d2 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -80,7 +80,7 @@ noinline void btrfs_clear_path_blocking(struct btrfs_path *p,
 {
 	int i;
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#if (defined(CONFIG_DEBUG_LOCK_ALLOC) || defined(CONFIG_PREEMPT_RT_BASE))
 	/* lockdep really cares that we take all of these spinlocks
 	 * in the right order.  If any of the locks in the path are not
 	 * currently blocking, it is going to complain.  So, make really
@@ -107,7 +107,7 @@ noinline void btrfs_clear_path_blocking(struct btrfs_path *p,
 		}
 	}
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#if (defined(CONFIG_DEBUG_LOCK_ALLOC) || defined(CONFIG_PREEMPT_RT_BASE))
 	if (held)
 		btrfs_clear_lock_blocking_rw(held, held_rw);
 #endif
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d2f1c011d73a..73035cf6681a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6940,14 +6940,6 @@ again:
 		goto again;
 	}
 
-	if (btrfs_test_opt(root, ENOSPC_DEBUG)) {
-		static DEFINE_RATELIMIT_STATE(_rs,
-				DEFAULT_RATELIMIT_INTERVAL * 10,
-				/*DEFAULT_RATELIMIT_BURST*/ 1);
-		if (__ratelimit(&_rs))
-			WARN(1, KERN_DEBUG
-				"BTRFS: block rsv returned %d\n", ret);
-	}
 try_reserve:
 	ret = reserve_metadata_bytes(root, block_rsv, blocksize,
 				     BTRFS_RESERVE_NO_FLUSH);
-- 
2.1.4
