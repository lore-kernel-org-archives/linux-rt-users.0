From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: 3.14.23-rt20 - fs,btrfs: fix rt deadlock on extent_buffer->lock
Date: Tue, 17 Feb 2015 13:23:58 +0100
Message-ID: <1424175838.2948.14.camel@gmail.com>
References: <20141031170326.1491a63f@gandalf.local.home>
	 <1414910967.5380.81.camel@marge.simpson.net>
	 <1414913478.5380.114.camel@marge.simpson.net>
	 <20150217115641.GI26177@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150217115641.GI26177@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2015-02-17 at 12:56 +0100, Sebastian Andrzej Siewior wrote:
> * Mike Galbraith | 2014-11-02 08:31:18 [+0100]:
> 
> >--- a/fs/btrfs/ctree.c
> >+++ b/fs/btrfs/ctree.c
> >@@ -80,7 +80,7 @@ noinline void btrfs_clear_path_blocking(
> > {
> > 	int i;
> > 
> >-#ifdef CONFIG_DEBUG_LOCK_ALLOC
> >+#if (defined(CONFIG_DEBUG_LOCK_ALLOC) || defined(CONFIG_PREEMPT_RT_BASE))
> > 	/* lockdep really cares that we take all of these spinlocks
> > 	 * in the right order.  If any of the locks in the path are not
> > 	 * currently blocking, it is going to complain.  So, make really
> 
> This is gone since commit f82c458 ("btrfs: fix lockups from
> btrfs_clear_path_blocking")
> 
> >@@ -107,7 +107,7 @@ noinline void btrfs_clear_path_blocking(
> > 		}
> > 	}
> > 
> >-#ifdef CONFIG_DEBUG_LOCK_ALLOC
> >+#if (defined(CONFIG_DEBUG_LOCK_ALLOC) || defined(CONFIG_PREEMPT_RT_BASE))
> > 	if (held)
> > 		btrfs_clear_lock_blocking_rw(held, held_rw);
> > #endif
> >--- a/fs/btrfs/extent-tree.c
> >+++ b/fs/btrfs/extent-tree.c
> >@@ -6938,14 +6938,6 @@ use_block_rsv(struct btrfs_trans_handle
> > 		goto again;
> > 	}
> > 
> >-	if (btrfs_test_opt(root, ENOSPC_DEBUG)) {
> >-		static DEFINE_RATELIMIT_STATE(_rs,
> >-				DEFAULT_RATELIMIT_INTERVAL * 10,
> >-				/*DEFAULT_RATELIMIT_BURST*/ 1);
> >-		if (__ratelimit(&_rs))
> >-			WARN(1, KERN_DEBUG
> >-				"BTRFS: block rsv returned %d\n", ret);
> >-	}
> > try_reserve:
> > 	ret = reserve_metadata_bytes(root, block_rsv, blocksize,
> > 				     BTRFS_RESERVE_NO_FLUSH);
> >
> and this look like just a warning with enabled debug that is supressed.
> May I drop this patch?

Hm, I'll try to find some time to beat on filesystems again.

	-Mike
