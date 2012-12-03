From: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Subject: Re: bugsplat 3.6.7-rt18
Date: Mon, 3 Dec 2012 10:28:30 +0100
Message-ID: <201212031028.32657.tim01@vlsi.informatik.tu-darmstadt.de>
References: <201212010050.59563.tim01@vlsi.informatik.tu-darmstadt.de> <50B94C0D.1010809@am.sony.com> <20121201015932.GP2474@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Frank Rowand <frank.rowand@am.sony.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lnx500.hrz.tu-darmstadt.de ([130.83.156.225]:40442 "EHLO
	lnx500.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751546Ab2LCJfr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Dec 2012 04:35:47 -0500
In-Reply-To: <20121201015932.GP2474@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Paul
> > > After Frank posted a patch i managed the 3.6.7-rt18 kernel to boot:
> > > There are some local platform modifications for arm mach-pcm043 but
> > > nothing which should cause this. The kernel got renamed so that the
> > > hw debugger works. HR_TIMERS are disabled in my config.
> > > 
> > > The kernel continues to work after that but it fails later on more
> > > below on that.
> > > 
> > > Best regards
> > > Tim
> > > 
> > > PS: This mail went accidentially to lkml and i was wondering that it is
> > > not reaching the linux-rt-users mailing list. But as the s/n ratio is
> > > much better on this list, i just resend it over here...
> > > 
> > > NET: Registered protocol family 16
> > > DMA: preallocated 256 KiB pool for atomic coherent allocations
> > > 
> > > =================================
> > > [ INFO: inconsistent lock state ]
> > > 2.6.42pmx-rt18-00015-gdc97b0a-dirty #48 Not tainted <-- this is really
> > > 3.6.7-rt18 changed for hw debugger ---------------------------------
> > > inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> > > 
> > > kworker/u:0/13 [HC1[1]:SC0[0]:HE0:SE1] takes:
> > >  (rcu_kthread_wq.lock.lock.wait_lock){?.+...}, at: [<c0259720>]
> > >  rt_spin_lock_slowlock+0x44/0x208
> > > 
> > > {HARDIRQ-ON-W} state was registered at:
> > >   [<c004faac>] mark_lock+0x274/0x3c8
> > >   [<c004fd1c>] mark_irqflags+0x11c/0x1a4
> > >   [<c0050380>] __lock_acquire+0x5dc/0x814
> > >   [<c0050abc>] lock_acquire+0x68/0x7c
> > >   [<c025a35c>] _raw_spin_lock+0x40/0x50
> > >   [<c0259720>] rt_spin_lock_slowlock+0x44/0x208
> > >   [<c0259c9c>] rt_spin_lock+0x1c/0x44
> > >   [<c0039038>] prepare_to_wait+0x28/0x70
> > >   [<c0063694>] rcu_kthread+0x68/0x1b0
> > >   [<c0038a88>] kthread+0x90/0x9c
> > >   [<c0020e38>] do_exit+0x0/0x2e0
> > > 
> > > irq event stamp: 46
> > > hardirqs last  enabled at (45): [<c025a5f4>]
> > > _raw_spin_unlock_irqrestore+0x44/0x7c hardirqs last disabled at (46):
> > > [<c000dad4>] __irq_svc+0x34/0x98 softirqs last  enabled at (0):
> > > [<c001a1e4>] copy_process+0x1f4/0xb78 softirqs last disabled at (0):
> > > [<  (null)>]   (null)
> > > 
> > > other info that might help us debug this:
> > >  Possible unsafe locking scenario:
> > >        CPU0
> > >        ----
> > >   
> > >   lock(rcu_kthread_wq.lock.lock.wait_lock);
> > >   <Interrupt>
> > >   
> > >     lock(rcu_kthread_wq.lock.lock.wait_lock);
> 
> ???
> 
> These are all spin_lock_irqsave() calls, so how would the interrupt
> happen?  Or do these need to be changed to raw_spinlock_t?
> 
> Hmmm...  In include/linux/wait.h, doesn't struct __wait_queue_head
> need to have raw_spinlock_t rather than spinlock_t?  Please try that
> change and let me know what happens.
This semantic patch turned out to look like the thing below when put 
into my local interpreter. It's was a rather mechanic make it compile
after the single line change you suggested. So don't expect to much.

Well it does have some problems though. I don't see anything on the
console but the hw debugger gives me the following call stack 
(transcribe by hand):
panic
find_new_reaper
forget_original_parent
exit_notify
do_exit
SR:0xFFFF:0xC00116E4  <- die? Don't know why it is not resolved
__do_kernel_fault
do_page_fault
do_DataAbort
__dabt_svc
<---exception occured here
plist_add
task_block_on_rt_mutex
rt_spin_lock_slowlock
rt_spin_lock
wait_for_common
wait_for_completion
kthread_create_on_node
cpu_callback
spawn_ksoftirqd
do_one_initcall
kernel_init
do_exit

Best regards
Tim

---
 include/linux/mutex.h |    2 +-
 include/linux/wait.h  |    4 ++--
 init/init_task.c      |    1 +
 init/main.c           |    1 +
 kernel/wait.c         |   30 +++++++++++++++---------------
 mm/filemap.c          |    4 ++--
 6 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index bdf1da2..c83a9cd 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -59,7 +59,7 @@
 struct mutex {
        /* 1: unlocked, 0: locked, negative: locked, possible waiters */
        atomic_t                count;
-       spinlock_t              wait_lock;
+       raw_spinlock_t          wait_lock;
        struct list_head        wait_list;
 #if defined(CONFIG_DEBUG_MUTEXES) || defined(CONFIG_SMP)
        struct task_struct      *owner;
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 1dee81c..4337b2f 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -47,7 +47,7 @@ struct wait_bit_queue {
 };
 
 struct __wait_queue_head {
-       spinlock_t lock;
+       raw_spinlock_t lock;
        struct list_head task_list;
 };
 typedef struct __wait_queue_head wait_queue_head_t;
@@ -67,7 +67,7 @@ struct task_struct;
        wait_queue_t name = __WAITQUEUE_INITIALIZER(name, tsk)
 
 #define __WAIT_QUEUE_HEAD_INITIALIZER(name) {                          \
-       .lock           = __SPIN_LOCK_UNLOCKED(name.lock),              \
+       .lock           = __RAW_SPIN_LOCK_UNLOCKED(name.lock),          \
        .task_list      = { &(name).task_list, &(name).task_list } }
 
 #define DECLARE_WAIT_QUEUE_HEAD(name) \
diff --git a/init/init_task.c b/init/init_task.c
index 8b2f399..c9f7984 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -1,3 +1,4 @@
+#include <linux/spinlock_types.h>
 #include <linux/init_task.h>
 #include <linux/export.h>
 #include <linux/mqueue.h>
diff --git a/init/main.c b/init/main.c
index 162a9de..ff8615c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -9,6 +9,7 @@
  *  Simplified starting of init:  Michael A. Griffith <grif@acm.org> 
  */
 
+#include <linux/spinlock_types.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
diff --git a/kernel/wait.c b/kernel/wait.c
index 7fdd9ea..194722a 100644
--- a/kernel/wait.c
+++ b/kernel/wait.c
@@ -12,7 +12,7 @@
 
 void __init_waitqueue_head(wait_queue_head_t *q, const char *name, struct lock_class_key *key)
 {
-       spin_lock_init(&q->lock);
+       raw_spin_lock_init(&q->lock);
        lockdep_set_class_and_name(&q->lock, key, name);
        INIT_LIST_HEAD(&q->task_list);
 }
@@ -24,9 +24,9 @@ void add_wait_queue(wait_queue_head_t *q, wait_queue_t *wait)
        unsigned long flags;
 
        wait->flags &= ~WQ_FLAG_EXCLUSIVE;
-       spin_lock_irqsave(&q->lock, flags);
+       raw_spin_lock_irqsave(&q->lock, flags);
        __add_wait_queue(q, wait);
-       spin_unlock_irqrestore(&q->lock, flags);
+       raw_spin_unlock_irqrestore(&q->lock, flags);
 }
 EXPORT_SYMBOL(add_wait_queue);
 
@@ -35,9 +35,9 @@ void add_wait_queue_exclusive(wait_queue_head_t *q, wait_queue_t *wait)
        unsigned long flags;
 
        wait->flags |= WQ_FLAG_EXCLUSIVE;
-       spin_lock_irqsave(&q->lock, flags);
+       raw_spin_lock_irqsave(&q->lock, flags);
        __add_wait_queue_tail(q, wait);
-       spin_unlock_irqrestore(&q->lock, flags);
+       raw_spin_unlock_irqrestore(&q->lock, flags);
 }
 EXPORT_SYMBOL(add_wait_queue_exclusive);
 
@@ -45,9 +45,9 @@ void remove_wait_queue(wait_queue_head_t *q, wait_queue_t *wait)
 {
        unsigned long flags;
 
-       spin_lock_irqsave(&q->lock, flags);
+       raw_spin_lock_irqsave(&q->lock, flags);
        __remove_wait_queue(q, wait);
-       spin_unlock_irqrestore(&q->lock, flags);
+       raw_spin_unlock_irqrestore(&q->lock, flags);
 }
 EXPORT_SYMBOL(remove_wait_queue);
 
@@ -70,11 +70,11 @@ prepare_to_wait(wait_queue_head_t *q, wait_queue_t *wait, int state)
        unsigned long flags;
 
        wait->flags &= ~WQ_FLAG_EXCLUSIVE;
-       spin_lock_irqsave(&q->lock, flags);
+       raw_spin_lock_irqsave(&q->lock, flags);
        if (list_empty(&wait->task_list))
                __add_wait_queue(q, wait);
        set_current_state(state);
-       spin_unlock_irqrestore(&q->lock, flags);
+       raw_spin_unlock_irqrestore(&q->lock, flags);
 }
 EXPORT_SYMBOL(prepare_to_wait);
 
@@ -84,11 +84,11 @@ prepare_to_wait_exclusive(wait_queue_head_t *q, wait_queue_t *wait, int state)
        unsigned long flags;
 
        wait->flags |= WQ_FLAG_EXCLUSIVE;
-       spin_lock_irqsave(&q->lock, flags);
+       raw_spin_lock_irqsave(&q->lock, flags);
        if (list_empty(&wait->task_list))
                __add_wait_queue_tail(q, wait);
        set_current_state(state);
-       spin_unlock_irqrestore(&q->lock, flags);
+       raw_spin_unlock_irqrestore(&q->lock, flags);
 }
 EXPORT_SYMBOL(prepare_to_wait_exclusive);
 
@@ -120,9 +120,9 @@ void finish_wait(wait_queue_head_t *q, wait_queue_t *wait)
         *    the list).
         */
        if (!list_empty_careful(&wait->task_list)) {
-               spin_lock_irqsave(&q->lock, flags);
+               raw_spin_lock_irqsave(&q->lock, flags);
                list_del_init(&wait->task_list);
-               spin_unlock_irqrestore(&q->lock, flags);
+               raw_spin_unlock_irqrestore(&q->lock, flags);
        }
 }
 EXPORT_SYMBOL(finish_wait);
@@ -151,12 +151,12 @@ void abort_exclusive_wait(wait_queue_head_t *q, wait_queue_t *wait,
        unsigned long flags;
 
        __set_current_state(TASK_RUNNING);
-       spin_lock_irqsave(&q->lock, flags);
+       raw_spin_lock_irqsave(&q->lock, flags);
        if (!list_empty(&wait->task_list))
                list_del_init(&wait->task_list);
        else if (waitqueue_active(q))
                __wake_up_locked_key(q, mode, key);
-       spin_unlock_irqrestore(&q->lock, flags);
+       raw_spin_unlock_irqrestore(&q->lock, flags);
 }
 EXPORT_SYMBOL(abort_exclusive_wait);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index d9f32ee..16a4537 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -567,9 +567,9 @@ void add_page_wait_queue(struct page *page, wait_queue_t *waiter)
        wait_queue_head_t *q = page_waitqueue(page);
        unsigned long flags;
 
-       spin_lock_irqsave(&q->lock, flags);
+       raw_spin_lock_irqsave(&q->lock, flags);
        __add_wait_queue(q, waiter);
-       spin_unlock_irqrestore(&q->lock, flags);
+       raw_spin_unlock_irqrestore(&q->lock, flags);
 }
 EXPORT_SYMBOL_GPL(add_page_wait_queue);
 
-- 
1.7.9.5

