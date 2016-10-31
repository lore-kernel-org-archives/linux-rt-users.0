From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.8.6-rt5
Date: Mon, 31 Oct 2016 20:50:10 +0100
Message-ID: <20161031195010.7z6k67jjmomaznf2@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.8.6-rt5 patch set. 

Changes since v4.8.6-rt5:

  - Added `-no-PIE' to the Makefile for AFLAGS as well. This breaks gcc
    3.2. Is someone here still using it?

  - The NFS fixup was slightly adjusted to avoid disabling preemption on
    !RT.

Known issues
	- CPU hotplug got a little better but can deadlock.

The delta patch against 4.8.6-rt5 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.8/incr/patch-4.8.6-rt4-rt5.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.8.6-rt5

The RT patch against 4.8.6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.8/patch-4.8.6-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.8/patches-4.8.6-rt5.tar.xz

Sebastian

diff --git a/Makefile b/Makefile
index b1800d3ba0b5..5d699d055995 100644
--- a/Makefile
+++ b/Makefile
@@ -403,7 +403,7 @@ KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 
 KBUILD_AFLAGS_KERNEL :=
 KBUILD_CFLAGS_KERNEL :=
-KBUILD_AFLAGS   := -D__ASSEMBLY__
+KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
 KBUILD_AFLAGS_MODULE  := -DMODULE
 KBUILD_CFLAGS_MODULE  := -DMODULE
 KBUILD_LDFLAGS_MODULE := -T $(srctree)/scripts/module-common.lds
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 1f82c370d72b..657e13ed4b5d 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1459,7 +1459,11 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
 	 * recovering after a network partition or a reboot from a
 	 * server that doesn't support a grace period.
 	 */
+#ifdef CONFIG_PREEMPT_RT_FULL
 	write_seqlock(&sp->so_reclaim_seqlock);
+#else
+	write_seqcount_begin(&sp->so_reclaim_seqlock.seqcount);
+#endif
 	spin_lock(&sp->so_lock);
 restart:
 	list_for_each_entry(state, &sp->so_states, open_states) {
@@ -1529,11 +1533,19 @@ static int nfs4_reclaim_open_state(struct nfs4_state_owner *sp, const struct nfs
 		goto restart;
 	}
 	spin_unlock(&sp->so_lock);
+#ifdef CONFIG_PREEMPT_RT_FULL
 	write_sequnlock(&sp->so_reclaim_seqlock);
+#else
+	write_seqcount_end(&sp->so_reclaim_seqlock.seqcount);
+#endif
 	return 0;
 out_err:
 	nfs4_put_open_state(state);
+#ifdef CONFIG_PREEMPT_RT_FULL
 	write_sequnlock(&sp->so_reclaim_seqlock);
+#else
+	write_seqcount_end(&sp->so_reclaim_seqlock.seqcount);
+#endif
 	return status;
 }
 
diff --git a/localversion-rt b/localversion-rt
index ad3da1bcab7e..0efe7ba1930e 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
