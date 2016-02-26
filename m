From: Yang Shi <yang.shi@linaro.org>
Subject: [RFC PATCH] kernfs: create raw version kernfs_path_len and kernfs_path
Date: Fri, 26 Feb 2016 10:15:05 -0800
Message-ID: <1456510505-6620-1-git-send-email-yang.shi@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org, yang.shi@linaro.org
To: gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
	tglx@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33347 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932737AbcBZSi2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2016 13:38:28 -0500
Received: by mail-pa0-f53.google.com with SMTP id fl4so54994587pad.0
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Feb 2016 10:38:28 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

commit 5634cc2aa9aebc77bc862992e7805469dcf83dac ("writeback: update writeback
tracepoints to report cgroup") made writeback tracepoints report cgroup
writeback, but it may trigger the below bug on -rt kernel since kernfs_path
and kernfs_path_len are called by tracepoints, which acquire sleeping lock.

BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:930
in_atomic(): 1, irqs_disabled(): 0, pid: 625, name: kworker/u16:3
INFO: lockdep is turned off.
Preemption disabled at:[<ffffffc000374a5c>] wb_writeback+0xec/0x830

CPU: 7 PID: 625 Comm: kworker/u16:3 Not tainted 4.4.1-rt5 #20
Hardware name: Freescale Layerscape 2085a RDB Board (DT)
Workqueue: writeback wb_workfn (flush-7:0)
Call trace:
[<ffffffc00008d708>] dump_backtrace+0x0/0x200
[<ffffffc00008d92c>] show_stack+0x24/0x30
[<ffffffc0007b0f40>] dump_stack+0x88/0xa8
[<ffffffc000127d74>] ___might_sleep+0x2ec/0x300
[<ffffffc000d5d550>] rt_spin_lock+0x38/0xb8
[<ffffffc0003e0548>] kernfs_path_len+0x30/0x90
[<ffffffc00036b360>] trace_event_raw_event_writeback_work_class+0xe8/0x2e8
[<ffffffc000374f90>] wb_writeback+0x620/0x830
[<ffffffc000376224>] wb_workfn+0x61c/0x950
[<ffffffc000110adc>] process_one_work+0x3ac/0xb30
[<ffffffc0001112fc>] worker_thread+0x9c/0x7a8
[<ffffffc00011a9e8>] kthread+0x190/0x1b0
[<ffffffc000086ca0>] ret_from_fork+0x10/0x30

Since kernfs_* functions are heavily used by cgroup, so it sounds not
reasonable to convert kernfs_rename_lock to raw lock.

Create raw version kernfs_path, kernfs_path_len and cgroup_path, which don't
acquire lock and are used by tracepoints only.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
It should be applicable to both mainline and -rt kernel.
The change survives ftrace stress test in ltp.

 fs/kernfs/dir.c                  | 27 ++++++++++++++++++++++++---
 include/linux/cgroup.h           | 10 ++++++++++
 include/linux/kernfs.h           | 10 ++++++++++
 include/trace/events/writeback.h |  4 ++--
 4 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 996b774..9249336 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -44,7 +44,7 @@ static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t buflen)
 	return strlcpy(buf, kn->parent ? kn->name : "/", buflen);
 }
 
-static char * __must_check kernfs_path_locked(struct kernfs_node *kn, char *buf,
+static char * __must_check __kernfs_path(struct kernfs_node *kn, char *buf,
 					      size_t buflen)
 {
 	char *p = buf + buflen;
@@ -131,12 +131,33 @@ char *kernfs_path(struct kernfs_node *kn, char *buf, size_t buflen)
 	char *p;
 
 	spin_lock_irqsave(&kernfs_rename_lock, flags);
-	p = kernfs_path_locked(kn, buf, buflen);
+	p = __kernfs_path(kn, buf, buflen);
 	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
 	return p;
 }
 EXPORT_SYMBOL_GPL(kernfs_path);
 
+/* Raw version. Used by tracepoints only without acquiring lock */
+size_t _kernfs_path_len(struct kernfs_node *kn)
+{
+	size_t len = 0;
+
+	do {
+		len += strlen(kn->name) + 1;
+		kn = kn->parent;
+	} while (kn && kn->parent);
+
+	return len;
+}
+
+char *_kernfs_path(struct kernfs_node *kn, char *buf, size_t buflen)
+{
+	char *p;
+
+	p = __kernfs_path(kn, buf, buflen);
+	return p;
+}
+
 /**
  * pr_cont_kernfs_name - pr_cont name of a kernfs_node
  * @kn: kernfs_node of interest
@@ -168,7 +189,7 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
 
 	spin_lock_irqsave(&kernfs_rename_lock, flags);
 
-	p = kernfs_path_locked(kn, kernfs_pr_cont_buf,
+	p = __kernfs_path(kn, kernfs_pr_cont_buf,
 			       sizeof(kernfs_pr_cont_buf));
 	if (p)
 		pr_cont("%s", p);
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 2162dca..bbd88d3 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -538,6 +538,16 @@ static inline char * __must_check cgroup_path(struct cgroup *cgrp, char *buf,
 	return kernfs_path(cgrp->kn, buf, buflen);
 }
 
+/*
+ * Without acquiring kernfs_rename_lock in _kernfs_path.
+ * Used by tracepoints only.
+ */
+static inline char * __must_check _cgroup_path(struct cgroup *cgrp, char *buf,
+					      size_t buflen)
+{
+	return _kernfs_path(cgrp->kn, buf, buflen);
+}
+
 static inline void pr_cont_cgroup_name(struct cgroup *cgrp)
 {
 	pr_cont_kernfs_name(cgrp->kn);
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index af51df3..14c01cdc 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -267,8 +267,11 @@ static inline bool kernfs_ns_enabled(struct kernfs_node *kn)
 
 int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen);
 size_t kernfs_path_len(struct kernfs_node *kn);
+size_t _kernfs_path_len(struct kernfs_node *kn);
 char * __must_check kernfs_path(struct kernfs_node *kn, char *buf,
 				size_t buflen);
+char * __must_check _kernfs_path(struct kernfs_node *kn, char *buf,
+				size_t buflen);
 void pr_cont_kernfs_name(struct kernfs_node *kn);
 void pr_cont_kernfs_path(struct kernfs_node *kn);
 struct kernfs_node *kernfs_get_parent(struct kernfs_node *kn);
@@ -338,10 +341,17 @@ static inline int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen)
 static inline size_t kernfs_path_len(struct kernfs_node *kn)
 { return 0; }
 
+static inline size_t _kernfs_path_len(struct kernfs_node *kn)
+{ return 0; }
+
 static inline char * __must_check kernfs_path(struct kernfs_node *kn, char *buf,
 					      size_t buflen)
 { return NULL; }
 
+static inline char * __must_check _kernfs_path(struct kernfs_node *kn, char *buf,
+					      size_t buflen)
+{ return NULL; }
+
 static inline void pr_cont_kernfs_name(struct kernfs_node *kn) { }
 static inline void pr_cont_kernfs_path(struct kernfs_node *kn) { }
 
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index fff846b..91ceced 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -136,7 +136,7 @@ DEFINE_EVENT(writeback_dirty_inode_template, writeback_dirty_inode,
 
 static inline size_t __trace_wb_cgroup_size(struct bdi_writeback *wb)
 {
-	return kernfs_path_len(wb->memcg_css->cgroup->kn) + 1;
+	return _kernfs_path_len(wb->memcg_css->cgroup->kn) + 1;
 }
 
 static inline void __trace_wb_assign_cgroup(char *buf, struct bdi_writeback *wb)
@@ -144,7 +144,7 @@ static inline void __trace_wb_assign_cgroup(char *buf, struct bdi_writeback *wb)
 	struct cgroup *cgrp = wb->memcg_css->cgroup;
 	char *path;
 
-	path = cgroup_path(cgrp, buf, kernfs_path_len(cgrp->kn) + 1);
+	path = _cgroup_path(cgrp, buf, _kernfs_path_len(cgrp->kn) + 1);
 	WARN_ON_ONCE(path != buf);
 }
 
-- 
2.0.2

