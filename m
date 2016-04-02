From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Sat, 02 Apr 2016 05:12:15 +0200
Message-ID: <1459566735.3779.36.camel@gmail.com>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
	 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
	 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
	 <alpine.DEB.2.11.1603241140510.3978@nanos>
	 <1459405903.14336.64.camel@gmail.com>
	 <20160401211105.GE29603@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36610 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbcDBDMU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Apr 2016 23:12:20 -0400
In-Reply-To: <20160401211105.GE29603@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2016-04-01 at 23:11 +0200, Sebastian Andrzej Siewior wrote:
> * Mike Galbraith | 2016-03-31 08:31:43 [+0200]:
> 
> > 3. nuke irksome grab_lock: make everybody always try to get the hell
> > outta Dodge or hotplug can bloody well wait.
> > 
> > I haven't yet flogged my 64 core box doing that, but my local boxen
> > seem to be saying we don't really really need the grab_lock business.
> > 
> > Are my boxen fibbing, is that very attractive looking door #3 a trap?
> 
> By the time I improved hotplug I played with this. I had a few ideas but
> it didn't fly in the end. Today however I ended up with this:

Yeah, but that fails the duct tape test too.  Mine is below, and is the
extra sticky variety ;-)  With busted 0299 patch reverted and those two
applied, my DL980 took a beating for ~36 hours before I aborted it.. ie
hotplug road seemingly has no more -rt specific potholes.

If that lock dies, we can unpin when entering lock slow path and pin
again post acquisition with no ABBA worries as well, and not only does
existing hotplug work heaping truckloads better, -rt can perhaps help
spot trouble as the rewrite proceeds.

Current state is more broken than ever.. if that's possible.

	-Mike

hotplug/rt: Do not let pin_current_cpu() block RCU grace periods

Notifiers may depend upon grace periods continuing to advance
as blk_mq_queue_reinit_notify() below.

crash> bt ffff8803aee76400
PID: 1113   TASK: ffff8803aee76400  CPU: 0   COMMAND: "stress-cpu-hotp"
 #0 [ffff880396fe7ad8] __schedule at ffffffff816b7142
 #1 [ffff880396fe7b28] schedule at ffffffff816b797b
 #2 [ffff880396fe7b48] blk_mq_freeze_queue_wait at ffffffff8135c5ac
 #3 [ffff880396fe7b80] blk_mq_queue_reinit_notify at ffffffff8135f819
 #4 [ffff880396fe7b98] notifier_call_chain at ffffffff8109b8ed
 #5 [ffff880396fe7bd8] __raw_notifier_call_chain at ffffffff8109b91e
 #6 [ffff880396fe7be8] __cpu_notify at ffffffff81072825
 #7 [ffff880396fe7bf8] cpu_notify_nofail at ffffffff81072b15
 #8 [ffff880396fe7c08] notify_dead at ffffffff81072d06
 #9 [ffff880396fe7c38] cpuhp_invoke_callback at ffffffff81073718
#10 [ffff880396fe7c78] cpuhp_down_callbacks at ffffffff81073a70
#11 [ffff880396fe7cb8] _cpu_down at ffffffff816afc71
#12 [ffff880396fe7d38] do_cpu_down at ffffffff8107435c
#13 [ffff880396fe7d60] cpu_down at ffffffff81074390
#14 [ffff880396fe7d70] cpu_subsys_offline at ffffffff814cd854
#15 [ffff880396fe7d80] device_offline at ffffffff814c7cda
#16 [ffff880396fe7da8] online_store at ffffffff814c7dd0
#17 [ffff880396fe7dd0] dev_attr_store at ffffffff814c4fc8
#18 [ffff880396fe7de0] sysfs_kf_write at ffffffff812cfbe4
#19 [ffff880396fe7e08] kernfs_fop_write at ffffffff812cf172
#20 [ffff880396fe7e50] __vfs_write at ffffffff81241428
#21 [ffff880396fe7ed0] vfs_write at ffffffff81242535
#22 [ffff880396fe7f10] sys_write at ffffffff812438f9
#23 [ffff880396fe7f50] entry_SYSCALL_64_fastpath at ffffffff816bb4bc
    RIP: 00007fafd918acd0  RSP: 00007ffd2ca956e8  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 000000000226a770  RCX: 00007fafd918acd0
    RDX: 0000000000000002  RSI: 00007fafd9cb9000  RDI: 0000000000000001
    RBP: 00007ffd2ca95700   R8: 000000000000000a   R9: 00007fafd9cb3700
    R10: 00000000ffffffff  R11: 0000000000000246  R12: 0000000000000007
    R13: 0000000000000001  R14: 0000000000000009  R15: 000000000000000a
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b

blk_mq_queue_reinit_notify:
        /*
         * We need to freeze and reinit all existing queues.  Freezing
         * involves synchronous wait for an RCU grace period and doing it
         * one by one may take a long time.  Start freezing all queues in
         * one swoop and then wait for the completions so that freezing can
         * take place in parallel.
         */
        list_for_each_entry(q, &all_q_list, all_q_node)
                blk_mq_freeze_queue_start(q);
        list_for_each_entry(q, &all_q_list, all_q_node) {
                blk_mq_freeze_queue_wait(q);

crash> bt ffff880176cc9900
PID: 17     TASK: ffff880176cc9900  CPU: 0   COMMAND: "rcu_sched"
 #0 [ffff880176cd7ab8] __schedule at ffffffff816b7142
 #1 [ffff880176cd7b08] schedule at ffffffff816b797b
 #2 [ffff880176cd7b28] rt_spin_lock_slowlock at ffffffff816b974d
 #3 [ffff880176cd7bc8] rt_spin_lock_fastlock at ffffffff811b0f3c
 #4 [ffff880176cd7be8] rt_spin_lock__no_mg at ffffffff816bac1b
 #5 [ffff880176cd7c08] pin_current_cpu at ffffffff8107406a
 #6 [ffff880176cd7c50] migrate_disable at ffffffff810a0e9e
 #7 [ffff880176cd7c70] rt_spin_lock at ffffffff816bad69
 #8 [ffff880176cd7c90] lock_timer_base at ffffffff810fc5e8
 #9 [ffff880176cd7cc8] try_to_del_timer_sync at ffffffff810fe290
#10 [ffff880176cd7cf0] del_timer_sync at ffffffff810fe381
#11 [ffff880176cd7d58] schedule_timeout at ffffffff816b9e4b
#12 [ffff880176cd7df0] rcu_gp_kthread at ffffffff810f52b4
#13 [ffff880176cd7e70] kthread at ffffffff8109a02f
#14 [ffff880176cd7f50] ret_from_fork at ffffffff816bb6f2

Game Over.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 include/linux/sched.h |    1 +
 kernel/cpu.c          |    7 ++++---
 kernel/rcu/tree.c     |    3 +++
 3 files changed, 8 insertions(+), 3 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1492,6 +1492,7 @@ struct task_struct {
 #ifdef CONFIG_COMPAT_BRK
 	unsigned brk_randomized:1;
 #endif
+	unsigned sched_is_rcu:1; /* RT: is a critical RCU thread */
 
 	unsigned long atomic_flags; /* Flags needing atomic access. */
 
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -147,17 +147,18 @@ static DEFINE_PER_CPU(struct hotplug_pcp
 void pin_current_cpu(void)
 {
 	struct hotplug_pcp *hp;
+	struct task_struct *p = current;
 	int force = 0;
 
 retry:
 	hp = this_cpu_ptr(&hotplug_pcp);
 
 	if (!hp->unplug || hp->refcount || force || preempt_count() > 1 ||
-	    hp->unplug == current) {
+	    hp->unplug == p) {
 		hp->refcount++;
 		return;
 	}
-	if (hp->grab_lock) {
+	if (hp->grab_lock && !p->sched_is_rcu) {
 		preempt_enable();
 		hotplug_lock(hp);
 		hotplug_unlock(hp);
@@ -169,7 +170,7 @@ void pin_current_cpu(void)
 		if (!migrate_me()) {
 			preempt_disable();
 			hp = this_cpu_ptr(&hotplug_pcp);
-			if (!hp->grab_lock) {
+			if (!hp->grab_lock || (p->sched_is_rcu && p->state)) {
 				/*
 				 * Just let it continue it's already pinned
 				 * or about to sleep.
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2100,6 +2100,9 @@ static int __noreturn rcu_gp_kthread(voi
 	struct rcu_state *rsp = arg;
 	struct rcu_node *rnp = rcu_get_root(rsp);
 
+	/* RT: pin_current_cpu() MUST NOT block RCU grace periods. */
+	current->sched_is_rcu = 1;
+
 	rcu_bind_gp_kthread();
 	for (;;) {
 

hotplug/rt/kernfs: Put kernfs_mutex under migrate_disable()/migrate_enable()

Hotplug path takes kernfs_mutex, so let pin_current_cpu() snag callers
before they can deadlock us.  Below, systemd-udevd was snagged while
acquiring a spinlock, but already holding kernfs_mutex.

PID: 11107  TASK: ffff8803b12b9900  CPU: 4   COMMAND: "stress-cpu-hotp"                                                                                                                                                                      
 #0 [ffff88038b34f9b8] __schedule at ffffffff816b7132
 #1 [ffff88038b34fa08] schedule at ffffffff816b796b
 #2 [ffff88038b34fa28] rt_mutex_slowlock at ffffffff816b93ee
 #3 [ffff88038b34fac8] rt_mutex_fastlock at ffffffff811b0e9d
 #4 [ffff88038b34faf0] rt_mutex_lock at ffffffff816b95c8
 #5 [ffff88038b34fb08] _mutex_lock at ffffffff816baf59
 #6 [ffff88038b34fb28] kernfs_find_and_get_ns at ffffffff812cd573
 #7 [ffff88038b34fb50] sysfs_remove_group at ffffffff812d100a
 #8 [ffff88038b34fb78] thermal_throttle_cpu_callback at ffffffff81036ab9
 #9 [ffff88038b34fb98] notifier_call_chain at ffffffff8109b8dd
#10 [ffff88038b34fbd8] __raw_notifier_call_chain at ffffffff8109b90e
#11 [ffff88038b34fbe8] __cpu_notify at ffffffff81072825
#12 [ffff88038b34fbf8] cpu_notify_nofail at ffffffff81072b15
#13 [ffff88038b34fc08] notify_dead at ffffffff81072d06
#14 [ffff88038b34fc38] cpuhp_invoke_callback at ffffffff81073718
#15 [ffff88038b34fc78] cpuhp_down_callbacks at ffffffff81073a70
#16 [ffff88038b34fcb8] _cpu_down at ffffffff816afc61
#17 [ffff88038b34fd38] do_cpu_down at ffffffff8107434c
#18 [ffff88038b34fd60] cpu_down at ffffffff81074380
#19 [ffff88038b34fd70] cpu_subsys_offline at ffffffff814cd844
#20 [ffff88038b34fd80] device_offline at ffffffff814c7cca
#21 [ffff88038b34fda8] online_store at ffffffff814c7dc0
#22 [ffff88038b34fdd0] dev_attr_store at ffffffff814c4fb8
#23 [ffff88038b34fde0] sysfs_kf_write at ffffffff812cfbd4
#24 [ffff88038b34fe08] kernfs_fop_write at ffffffff812cf162
#25 [ffff88038b34fe50] __vfs_write at ffffffff81241418
#26 [ffff88038b34fed0] vfs_write at ffffffff81242525
#27 [ffff88038b34ff10] sys_write at ffffffff812438e9
#28 [ffff88038b34ff50] entry_SYSCALL_64_fastpath at ffffffff816bb4fc
    RIP: 00007f05f3d69cd0  RSP: 00007ffdfc934468  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 0000000001908770  RCX: 00007f05f3d69cd0
    RDX: 0000000000000002  RSI: 00007f05f4898000  RDI: 0000000000000001
    RBP: 00007ffdfc934480   R8: 000000000000000a   R9: 00007f05f4892700
    R10: 00000000ffffffff  R11: 0000000000000246  R12: 0000000000000007
    R13: 0000000000000001  R14: 0000000000000009  R15: 000000000000000a
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b

stress-cpu-hotp blocks on kernfs_mutex, held by systemd-udevd..

crash> bt ffff8803b12bcb00
PID: 11130  TASK: ffff8803b12bcb00  CPU: 6   COMMAND: "systemd-udevd"
 #0 [ffff88038b327a18] __schedule at ffffffff816b7132
 #1 [ffff88038b327a68] schedule at ffffffff816b796b
 #2 [ffff88038b327a88] rt_spin_lock_slowlock at ffffffff816b9750
 #3 [ffff88038b327b30] rt_spin_lock_fastlock at ffffffff811b0f2c
 #4 [ffff88038b327b50] rt_spin_lock__no_mg at ffffffff816bac7b
 #5 [ffff88038b327b70] pin_current_cpu at ffffffff8107406a
 #6 [ffff88038b327bb8] migrate_disable at ffffffff810a0e8e
 #7 [ffff88038b327bd8] rt_spin_lock at ffffffff816badc9
 #8 [ffff88038b327bf8] ida_simple_remove at ffffffff8138765c
 #9 [ffff88038b327c18] kernfs_put at ffffffff812ccc58
#10 [ffff88038b327c60] __kernfs_remove at ffffffff812cd15c
#11 [ffff88038b327cc0] kernfs_remove_by_name_ns at ffffffff812ce2f3
#12 [ffff88038b327ce8] sysfs_remove_link at ffffffff812d05e9
#13 [ffff88038b327cf8] free_module at ffffffff8111c8f2
#14 [ffff88038b327d30] do_init_module at ffffffff811b157f
#15 [ffff88038b327d58] load_module at ffffffff8111f11b
#16 [ffff88038b327e98] SYSC_finit_module at ffffffff8111faf9
#17 [ffff88038b327f40] sys_finit_module at ffffffff8111fb3e
#18 [ffff88038b327f50] entry_SYSCALL_64_fastpath at ffffffff816bb4fc
    RIP: 00007f75d9925f79  RSP: 00007ffd1c040ed8  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 0000000001d368e0  RCX: 00007f75d9925f79
    RDX: 0000000000000000  RSI: 00007f75da0233c1  RDI: 0000000000000008
    RBP: 0000000000000008   R8: 0000000000000000   R9: 0000000001d39c82
    R10: 0000000000000008  R11: 0000000000000246  R12: 00007ffd1c03ff00
    R13: 00007ffd1c03fee0  R14: 0000000000000005  R15: 000000000aba9500
    ORIG_RAX: 0000000000000139  CS: 0033  SS: 002b

..which stress-cpu-hotp has blocked via pin_current_cpu().  Game Over.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 fs/kernfs/dir.c             |   56 ++++++++++++++++++++++----------------------
 fs/kernfs/file.c            |    4 +--
 fs/kernfs/inode.c           |   20 +++++++--------
 fs/kernfs/kernfs-internal.h |   15 +++++++++++
 fs/kernfs/mount.c           |   16 ++++++------
 fs/kernfs/symlink.c         |    4 +--
 6 files changed, 65 insertions(+), 50 deletions(-)

--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -372,7 +372,7 @@ static void kernfs_drain(struct kernfs_n
 	lockdep_assert_held(&kernfs_mutex);
 	WARN_ON_ONCE(kernfs_active(kn));
 
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 
 	if (kernfs_lockdep(kn)) {
 		rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_);
@@ -391,7 +391,7 @@ static void kernfs_drain(struct kernfs_n
 
 	kernfs_unmap_bin_file(kn);
 
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 }
 
 /**
@@ -471,7 +471,7 @@ static int kernfs_dop_revalidate(struct
 		goto out_bad_unlocked;
 
 	kn = dentry->d_fsdata;
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 
 	/* The kernfs node has been deactivated */
 	if (!kernfs_active(kn))
@@ -490,10 +490,10 @@ static int kernfs_dop_revalidate(struct
 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
 		goto out_bad;
 
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 	return 1;
 out_bad:
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 out_bad_unlocked:
 	return 0;
 }
@@ -603,7 +603,7 @@ int kernfs_add_one(struct kernfs_node *k
 	bool has_ns;
 	int ret;
 
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 
 	ret = -EINVAL;
 	has_ns = kernfs_ns_enabled(parent);
@@ -634,7 +634,7 @@ int kernfs_add_one(struct kernfs_node *k
 		ps_iattrs->ia_ctime = ps_iattrs->ia_mtime = CURRENT_TIME;
 	}
 
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 
 	/*
 	 * Activate the new node unless CREATE_DEACTIVATED is requested.
@@ -648,7 +648,7 @@ int kernfs_add_one(struct kernfs_node *k
 	return 0;
 
 out_unlock:
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 	return ret;
 }
 
@@ -709,10 +709,10 @@ struct kernfs_node *kernfs_find_and_get_
 {
 	struct kernfs_node *kn;
 
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 	kn = kernfs_find_ns(parent, name, ns);
 	kernfs_get(kn);
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 
 	return kn;
 }
@@ -851,7 +851,7 @@ static struct dentry *kernfs_iop_lookup(
 	struct inode *inode;
 	const void *ns = NULL;
 
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
@@ -876,7 +876,7 @@ static struct dentry *kernfs_iop_lookup(
 	/* instantiate and hash dentry */
 	ret = d_splice_alias(inode, dentry);
  out_unlock:
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 	return ret;
 }
 
@@ -1030,7 +1030,7 @@ void kernfs_activate(struct kernfs_node
 {
 	struct kernfs_node *pos;
 
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
@@ -1044,7 +1044,7 @@ void kernfs_activate(struct kernfs_node
 		pos->flags |= KERNFS_ACTIVATED;
 	}
 
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 }
 
 static void __kernfs_remove(struct kernfs_node *kn)
@@ -1121,9 +1121,9 @@ static void __kernfs_remove(struct kernf
  */
 void kernfs_remove(struct kernfs_node *kn)
 {
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 	__kernfs_remove(kn);
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 }
 
 /**
@@ -1210,7 +1210,7 @@ bool kernfs_remove_self(struct kernfs_no
 {
 	bool ret;
 
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 	kernfs_break_active_protection(kn);
 
 	/*
@@ -1238,9 +1238,9 @@ bool kernfs_remove_self(struct kernfs_no
 			    atomic_read(&kn->active) == KN_DEACTIVATED_BIAS)
 				break;
 
-			mutex_unlock(&kernfs_mutex);
+			kernfs_mutex_unlock(&kernfs_mutex);
 			schedule();
-			mutex_lock(&kernfs_mutex);
+			kernfs_mutex_lock(&kernfs_mutex);
 		}
 		finish_wait(waitq, &wait);
 		WARN_ON_ONCE(!RB_EMPTY_NODE(&kn->rb));
@@ -1253,7 +1253,7 @@ bool kernfs_remove_self(struct kernfs_no
 	 */
 	kernfs_unbreak_active_protection(kn);
 
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 	return ret;
 }
 
@@ -1277,13 +1277,13 @@ int kernfs_remove_by_name_ns(struct kern
 		return -ENOENT;
 	}
 
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 
 	kn = kernfs_find_ns(parent, name, ns);
 	if (kn)
 		__kernfs_remove(kn);
 
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 
 	if (kn)
 		return 0;
@@ -1309,7 +1309,7 @@ int kernfs_rename_ns(struct kernfs_node
 	if (!kn->parent)
 		return -EINVAL;
 
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 
 	error = -ENOENT;
 	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
@@ -1363,7 +1363,7 @@ int kernfs_rename_ns(struct kernfs_node
 
 	error = 0;
  out:
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 	return error;
 }
 
@@ -1438,7 +1438,7 @@ static int kernfs_fop_readdir(struct fil
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dentry->d_sb)->ns;
@@ -1455,12 +1455,12 @@ static int kernfs_fop_readdir(struct fil
 		file->private_data = pos;
 		kernfs_get(pos);
 
-		mutex_unlock(&kernfs_mutex);
+		kernfs_mutex_unlock(&kernfs_mutex);
 		if (!dir_emit(ctx, name, len, ino, type))
 			return 0;
-		mutex_lock(&kernfs_mutex);
+		kernfs_mutex_lock(&kernfs_mutex);
 	}
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 	file->private_data = NULL;
 	ctx->pos = INT_MAX;
 	return 0;
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -830,7 +830,7 @@ static void kernfs_notify_workfn(struct
 	spin_unlock_irq(&kernfs_open_node_lock);
 
 	/* kick fsnotify */
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct inode *inode;
@@ -851,7 +851,7 @@ static void kernfs_notify_workfn(struct
 		iput(inode);
 	}
 
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 	kernfs_put(kn);
 	goto repeat;
 }
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -103,9 +103,9 @@ int kernfs_setattr(struct kernfs_node *k
 {
 	int ret;
 
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 	ret = __kernfs_setattr(kn, iattr);
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 	return ret;
 }
 
@@ -118,7 +118,7 @@ int kernfs_iop_setattr(struct dentry *de
 	if (!kn)
 		return -EINVAL;
 
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 	error = inode_change_ok(inode, iattr);
 	if (error)
 		goto out;
@@ -131,7 +131,7 @@ int kernfs_iop_setattr(struct dentry *de
 	setattr_copy(inode, iattr);
 
 out:
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 	return error;
 }
 
@@ -181,9 +181,9 @@ int kernfs_iop_setxattr(struct dentry *d
 		if (error)
 			return error;
 
-		mutex_lock(&kernfs_mutex);
+		kernfs_mutex_lock(&kernfs_mutex);
 		error = kernfs_node_setsecdata(kn, &secdata, &secdata_len);
-		mutex_unlock(&kernfs_mutex);
+		kernfs_mutex_unlock(&kernfs_mutex);
 
 		if (secdata)
 			security_release_secctx(secdata, secdata_len);
@@ -273,9 +273,9 @@ int kernfs_iop_getattr(struct vfsmount *
 	struct kernfs_node *kn = dentry->d_fsdata;
 	struct inode *inode = d_inode(dentry);
 
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 	kernfs_refresh_inode(kn, inode);
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 
 	generic_fillattr(inode, stat);
 	return 0;
@@ -364,9 +364,9 @@ int kernfs_iop_permission(struct inode *
 
 	kn = inode->i_private;
 
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 	kernfs_refresh_inode(kn, inode);
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 
 	return generic_permission(inode, mask);
 }
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -115,4 +115,19 @@ void kernfs_unmap_bin_file(struct kernfs
  */
 extern const struct inode_operations kernfs_symlink_iops;
 
+static inline void kernfs_mutex_lock(struct mutex *lock)
+{
+#ifdef CONFIG_PREEMPT_RT_FULL
+	migrate_disable();
+#endif
+	mutex_lock(lock);
+}
+
+static inline void kernfs_mutex_unlock(struct mutex *lock)
+{
+	mutex_unlock(lock);
+#ifdef CONFIG_PREEMPT_RT_FULL
+	migrate_enable();
+#endif
+}
 #endif	/* __KERNFS_INTERNAL_H */
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -76,9 +76,9 @@ static int kernfs_fill_super(struct supe
 	sb->s_time_gran = 1;
 
 	/* get root inode, initialize and unlock it */
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 	inode = kernfs_get_inode(sb, info->root->kn);
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 	if (!inode) {
 		pr_debug("kernfs: could not get root inode\n");
 		return -ENOMEM;
@@ -177,9 +177,9 @@ struct dentry *kernfs_mount_ns(struct fi
 		}
 		sb->s_flags |= MS_ACTIVE;
 
-		mutex_lock(&kernfs_mutex);
+		kernfs_mutex_lock(&kernfs_mutex);
 		list_add(&info->node, &root->supers);
-		mutex_unlock(&kernfs_mutex);
+		kernfs_mutex_unlock(&kernfs_mutex);
 	}
 
 	return dget(sb->s_root);
@@ -198,9 +198,9 @@ void kernfs_kill_sb(struct super_block *
 	struct kernfs_super_info *info = kernfs_info(sb);
 	struct kernfs_node *root_kn = sb->s_root->d_fsdata;
 
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 	list_del(&info->node);
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 
 	/*
 	 * Remove the superblock from fs_supers/s_instances
@@ -228,7 +228,7 @@ struct super_block *kernfs_pin_sb(struct
 	struct kernfs_super_info *info;
 	struct super_block *sb = NULL;
 
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 	list_for_each_entry(info, &root->supers, node) {
 		if (info->ns == ns) {
 			sb = info->sb;
@@ -237,7 +237,7 @@ struct super_block *kernfs_pin_sb(struct
 			break;
 		}
 	}
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 	return sb;
 }
 
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -105,9 +105,9 @@ static int kernfs_getlink(struct dentry
 	struct kernfs_node *target = kn->symlink.target_kn;
 	int error;
 
-	mutex_lock(&kernfs_mutex);
+	kernfs_mutex_lock(&kernfs_mutex);
 	error = kernfs_get_target_path(parent, target, path);
-	mutex_unlock(&kernfs_mutex);
+	kernfs_mutex_unlock(&kernfs_mutex);
 
 	return error;
 }
