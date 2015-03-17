From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/2] fs,btrfs: fix rt deadlock on extent_buffer->lock
Date: Tue, 17 Mar 2015 12:38:47 -0400
Message-ID: <20150317163926.666399381@goodmis.org>
References: <20150317163846.461046825@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Chris Mason <chris.mason@fusionio.com>,
	Mike Galbraith <efault@gmx.de>
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38161 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932561AbbCQQj3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Mar 2015 12:39:29 -0400
Content-Disposition: inline; filename=0027-fs-btrfs-fix-rt-deadlock-on-extent_buffer-lock.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.4.106-rt132-rc1 stable review patch.
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

Conflicts:
	fs/btrfs/extent-tree.c
---
 fs/btrfs/ctree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 4106264fbc65..ae47cc2c9f2f 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -77,7 +77,7 @@ noinline void btrfs_clear_path_blocking(struct btrfs_path *p,
 {
 	int i;
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#if (defined(CONFIG_DEBUG_LOCK_ALLOC) || defined(CONFIG_PREEMPT_RT_BASE))
 	/* lockdep really cares that we take all of these spinlocks
 	 * in the right order.  If any of the locks in the path are not
 	 * currently blocking, it is going to complain.  So, make really
@@ -104,7 +104,7 @@ noinline void btrfs_clear_path_blocking(struct btrfs_path *p,
 		}
 	}
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#if (defined(CONFIG_DEBUG_LOCK_ALLOC) || defined(CONFIG_PREEMPT_RT_BASE))
 	if (held)
 		btrfs_clear_lock_blocking_rw(held, held_rw);
 #endif
-- 
2.1.4


