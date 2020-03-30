Return-Path: <SRS0=CtTq=5P=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4058C2D0E5
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Mar 2020 14:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DC12072E
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Mar 2020 14:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgC3OrP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:47:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58993 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgC3OrP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Mar 2020 10:47:15 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jIvh2-0006lt-I5; Mon, 30 Mar 2020 16:47:12 +0200
Date:   Mon, 30 Mar 2020 16:47:12 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.4.28-rt19
Message-ID: <20200330144712.cwcz5ejal4ankeoi@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.4.28-rt19 patch set. 

Changes since v5.4.28-rt18:

  - Memory compaction of unevictable pages has been disabled in the v5.4
    release. This aligns the change with what has been prepared for
    upstream: Disable is by default on PREEMPT_RT
    (/proc/sys/vm/compact_unevictable_allowed reads 0) but allow
    enabling it which will trigger a warning.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.4.28-rt18 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.28-rt18-rt19.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.4.28-rt19

The RT patch against v5.4.28 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patch-5.4.28-rt19.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patches-5.4.28-rt19.tar.xz

Sebastian

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 64aeee1009cab..0329a4d3fa9ec 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -128,6 +128,9 @@ allowed to examine the unevictable lru (mlocked pages) for pages to compact.
 This should be used on systems where stalls for minor page faults are an
 acceptable trade for large contiguous free memory.  Set to 0 to prevent
 compaction from moving pages that are unevictable.  Default value is 1.
+On CONFIG_PREEMPT_RT the default value is 0 in order to avoid a page fault, due
+to compaction, which would block the task from becomming active until the fault
+is resolved.
 
 
 dirty_background_bytes
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d08bd51a0fbc3..8221219d65c35 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -212,6 +212,11 @@ static int proc_do_cad_pid(struct ctl_table *table, int write,
 		  void __user *buffer, size_t *lenp, loff_t *ppos);
 static int proc_taint(struct ctl_table *table, int write,
 			       void __user *buffer, size_t *lenp, loff_t *ppos);
+#ifdef CONFIG_COMPACTION
+static int proc_dointvec_minmax_warn_RT_change(struct ctl_table *table,
+					       int write, void __user *buffer,
+					       size_t *lenp, loff_t *ppos);
+#endif
 #endif
 
 #ifdef CONFIG_PRINTK
@@ -1488,17 +1493,16 @@ static struct ctl_table vm_table[] = {
 		.extra1		= &min_extfrag_threshold,
 		.extra2		= &max_extfrag_threshold,
 	},
-#ifndef CONFIG_PREEMPT_RT
 	{
 		.procname	= "compact_unevictable_allowed",
 		.data		= &sysctl_compact_unevictable_allowed,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax_warn_RT_change,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-#endif
+
 #endif /* CONFIG_COMPACTION */
 	{
 		.procname	= "min_free_kbytes",
@@ -2582,6 +2586,28 @@ int proc_dointvec(struct ctl_table *table, int write,
 	return do_proc_dointvec(table, write, buffer, lenp, ppos, NULL, NULL);
 }
 
+#ifdef CONFIG_COMPACTION
+static int proc_dointvec_minmax_warn_RT_change(struct ctl_table *table,
+					       int write, void __user *buffer,
+					       size_t *lenp, loff_t *ppos)
+{
+	int ret, old;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || !write)
+		return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	old = *(int *)table->data;
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (ret)
+		return ret;
+	if (old != *(int *)table->data)
+		pr_warn_once("sysctl attribute %s changed by %s[%d]\n",
+			     table->procname, current->comm,
+			     task_pid_nr(current));
+	return ret;
+}
+#endif
+
 /**
  * proc_douintvec - read a vector of unsigned integers
  * @table: the sysctl table
diff --git a/localversion-rt b/localversion-rt
index 9e7cd66d9f44f..483ad771f201a 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt18
+-rt19
diff --git a/mm/compaction.c b/mm/compaction.c
index 83cc3d1e5df7b..31e6e103f38b4 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1591,7 +1591,7 @@ typedef enum {
  * compactable pages.
  */
 #ifdef CONFIG_PREEMPT_RT
-#define sysctl_compact_unevictable_allowed 0
+int sysctl_compact_unevictable_allowed __read_mostly = 0;
 #else
 int sysctl_compact_unevictable_allowed __read_mostly = 1;
 #endif
