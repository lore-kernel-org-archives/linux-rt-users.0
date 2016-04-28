From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v2] sched/completion: convert completions to use simple wait  queues
Date: Thu, 28 Apr 2016 14:57:24 +0200
Message-ID: <1461848244-16469-1-git-send-email-wagi@monom.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Completions have no long lasting callbacks and therefore do not need
the complex waitqueue variant.  Use simple waitqueues which reduces
the contention on the waitqueue lock.

This was a carry forward from v3.10-rt, with some RT specific chunks,
dropped, and updated to align with names that were chosen to match the
simple waitqueue support.

While the conversion of complete() is trivial the complete_all() is
more difficult. complete_all() could be called from IRQ context and
therefore we don't want to wake up potentially a lot of
waiters. Therefore, only the first waiter is waked and the rest of the
waiters are waked by the first waiter. To avoid a larger struct
completion data structure the done integer is spitted into a unsigned
short for the flags and one unsigned short done.

The size of vmlinuz doesn't change too much:


add/remove: 3/0 grow/shrink: 3/10 up/down: 242/-236 (6)
function                                     old     new   delta
swake_up_all_locked                            -     181    +181
__kstrtab_swake_up_all_locked                  -      20     +20
__ksymtab_swake_up_all_locked                  -      16     +16
complete_all                                  73      87     +14
try_wait_for_completion                       99     107      +8
completion_done                               40      43      +3
complete                                      73      65      -8
wait_for_completion_timeout                  283     265     -18
wait_for_completion_killable_timeout         319     301     -18
wait_for_completion_io_timeout               283     265     -18
wait_for_completion_io                       275     257     -18
wait_for_completion                          275     257     -18
wait_for_completion_interruptible_timeout     304     285     -19
kexec_purgatory                            26473   26449     -24
wait_for_completion_killable                 544     499     -45
wait_for_completion_interruptible            522     472     -50


The downside of this approach is we can only wake up 32k waiters
instead of 2m. Though this doesn't seem to be a real issue.

With a lockdep inspired waiter tracker I verified how many waiters
are queued up on a complete() or complete_all() call.

The first line contains starts with class name of the swait object
followed by 4 columns which count the number of waiters. After that
there is a left ip/symbol column for the waiter and the right
ip/symbol column for the waker.

I run mmtest with config/config-global-dhp__scheduler-unbound with
additional kernbench:


swait_stat version 0.1
---------------------------------------------------------------------------------------------
                              class name     1 waiter    2 waiters    3 waiters   4+ waiters
---------------------------------------------------------------------------------------------
                             &rsp->gp_wq       129572            0            0            0
         [<ffffffff810c5b81>] kthread+0x101/0x120
                                                20154          [<ffffffff8110cf1f>] rcu_gp_kthread_wake+0x3f/0x50
                                                  535          [<ffffffff8110f603>] rcu_nocb_kthread+0x423/0x4b0
                                                43867          [<ffffffff8110cfc1>] rcu_report_qs_rsp+0x51/0x80
                                                44010          [<ffffffff8110d105>] rcu_report_qs_rnp+0x115/0x130
                                                15882          [<ffffffff81111778>] rcu_process_callbacks+0x268/0x4a0
                                                 4437          [<ffffffff8111043c>] note_gp_changes+0xbc/0xc0
                                                  687          [<ffffffff8110f83e>] rcu_eqs_enter_common+0x1ae/0x1e0
                             &x->wait#11        39002            0            0            0
         [<ffffffff810a4c43>] _do_fork+0x253/0x3c0
                                                39002          [<ffffffff810a2e9b>] mm_release+0xbb/0x140
                     &rnp->nocb_gp_wq[1]        10277            0            0            0
         [<ffffffff810c5b81>] kthread+0x101/0x120
                                                10277          [<ffffffff810c5b81>] kthread+0x101/0x120
                           &rdp->nocb_wq         9862            0            0            0
         [<ffffffff810c5b81>] kthread+0x101/0x120
                                                 4931          [<ffffffff8110ce05>] wake_nocb_leader+0x45/0x50
                                                 4290          [<ffffffff8110ced7>] __call_rcu_nocb_enqueue+0xc7/0xd0
                                                  629          [<ffffffff8110f728>] rcu_eqs_enter_common+0x98/0x1e0
                                                   12          [<ffffffff811115e5>] rcu_process_callbacks+0xd5/0x4a0
                     &rnp->nocb_gp_wq[0]         9769            0            0            0
         [<ffffffff810c5b81>] kthread+0x101/0x120
                                                 9769          [<ffffffff810c5b81>] kthread+0x101/0x120
                              &x->wait#8         4123            0            0            0
         [<ffffffffa011f03f>] xfs_buf_submit_wait+0x7f/0x280 [xfs]
                                                 4123          [<ffffffffa011e855>] xfs_buf_ioend+0xf5/0x230 [xfs]
                          (wait).wait#98         1594            0            0            0
         [<ffffffff81471e94>] blk_execute_rq+0xb4/0x130
                                                 1594          [<ffffffff81471f33>] blk_end_sync_rq+0x23/0x30
                                &x->wait          827            0            0            0
         [<ffffffff810c571d>] kthread_park+0x4d/0x60
         [<ffffffff810c602f>] kthread_stop+0x4f/0x140
                                                  320          [<ffffffff810c566c>] __kthread_parkme+0x3c/0x70
                                                  507          [<ffffffff810a2e9b>] mm_release+0xbb/0x140
                         (done).wait#119          512            0            0            0
         [<ffffffff810c5836>] kthread_create_on_node+0x106/0x1d0
                                                  512          [<ffffffff810c5b51>] kthread+0xd1/0x120
                              &x->wait#5          347            0            0            0
         [<ffffffff810beb97>] flush_work+0x127/0x1d0
         [<ffffffff810bc976>] flush_workqueue+0x176/0x5b0
                                                  273          [<ffffffff810bc742>] wq_barrier_func+0x12/0x20
                                                   74          [<ffffffff810bf308>] pwq_dec_nr_in_flight+0x98/0xa0
                          (done).wait#10          315            0            0            0
         [<ffffffff810c5836>] kthread_create_on_node+0x106/0x1d0
                                                  315          [<ffffffff810c5b51>] kthread+0xd1/0x120
                              &x->wait#4          298            0            0            0
         [<ffffffff815d7f2b>] devtmpfs_create_node+0x10b/0x150
                                                  298          [<ffffffff815d7dce>] devtmpfsd+0x10e/0x160
                              &x->wait#3          171            0            0            0
         [<ffffffff8110bd26>] __wait_rcu_gp+0xc6/0xf0
                                                  171          [<ffffffff8110bc52>] wakeme_after_rcu+0x12/0x20
[...]

The stats show that at least for this workload there was never more
than 1 waiter when complete() or complete_all() was called. That
matches also the code review of all complete_all() calls.

One common pattern is

 - prepare packet to transmit
 - complete_init(&done)
 - trigger hardware to transmit packet
 - wait_for_completion(&done)
 - irq handler calls complete_all(&done)

e.g. see drivers/i2c/busses/i2c-bcm-iproc.c
git
The filesystem system uses completion in a more complex pattern which
I couldn't really decipher but some simple fs benchmarks didn't show
multiple waiters.

Only one complete_all() user could been identified so far, which happens
to be drivers/base/power/main.c. Several waiters appear when suspend
to disk or mem is executed.

As one can see above in the swait_stat output, the fork() path is
using completion. A histogram of a fork bomp (1000 forks) benchmark
shows a slight performance drop by 4%.

[wagi@handman completion-test-5 (master)]$ cat forky-4.6.0-rc4.txt | perl histo -min 0.12 -max 0.20 -int 0.01 -stars -scale 10
# NumSamples = 1000; Max = 0.208; Min = 0.123
# Mean = 0.146406; Variance = 0.000275351163999956; SD = 0.0165937085668019
# Each * represents a count of 10
     0.1200 - 0.1300 [   113]: ************
     0.1300 - 0.1400 [   324]: *********************************
     0.1400 - 0.1500 [   219]: **********************
     0.1500 - 0.1600 [   139]: **************
     0.1600 - 0.1700 [    94]: **********
     0.1700 - 0.1800 [    54]: ******
     0.1800 - 0.1900 [    37]: ****
     0.1900 - 0.2000 [    18]: **

[wagi@handman completion-test-5 (master)]$ cat forky-4.6.0-rc4-00001-g0a16067.txt | perl histo -min 0.12 -max 0.20 -int 0.01 -stars -scale 10
# NumSamples = 1000; Max = 0.207; Min = 0.121
# Mean = 0.152056; Variance = 0.000295474863999994; SD = 0.0171893823042014
# Each * represents a count of 10
     0.1200 - 0.1300 [    17]: **
     0.1300 - 0.1400 [   282]: *****************************
     0.1400 - 0.1500 [   240]: ************************
     0.1500 - 0.1600 [   158]: ****************
     0.1600 - 0.1700 [   114]: ************
     0.1700 - 0.1800 [    94]: **********
     0.1800 - 0.1900 [    66]: *******
     0.1900 - 0.2000 [    25]: ***
     0.2000 - 0.2100 [     1]: *

Compiling a kernel 100 times results in following statistics gather
by 'time make -j200'

user
                                        mean                std                var                max                min
               kernbech-4.6.0-rc4      9.126             0.2919            0.08523               9.92               8.55
   kernbech-4.6.0-rc4-00001-g0...       9.24  -1.25%     0.2768   5.17%    0.07664  10.07%      10.11  -1.92%       8.44   1.29%


system
                                        mean                std                var                max                min
               kernbech-4.6.0-rc4  1.676e+03              2.409              5.804          1.681e+03          1.666e+03
   kernbech-4.6.0-rc4-00001-g0...  1.675e+03   0.07%      2.433  -1.01%      5.922  -2.03%  1.682e+03  -0.03%   1.67e+03  -0.20%


elapsed
                                        mean                std                var                max                min
               kernbech-4.6.0-rc4  2.303e+03              26.67              711.1          2.357e+03          2.232e+03
   kernbech-4.6.0-rc4-00001-g0...  2.298e+03   0.23%      28.75  -7.83%      826.8 -16.26%  2.348e+03   0.38%  2.221e+03   0.49%


CPU
                                        mean                std                var                max                min
               kernbech-4.6.0-rc4  4.418e+03               48.9          2.391e+03          4.565e+03          4.347e+03
   kernbech-4.6.0-rc4-00001-g0...  4.424e+03  -0.15%      55.73 -13.98%  3.106e+03 -29.90%  4.572e+03  -0.15%  4.356e+03  -0.21%


While the mean is slightly less the var and std are increasing quite
noticeable.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---

I have also created a picture with the histograms for the above
tests. Since most of use are not able to process the postscript data
directly I omitted it to attach it directly. You can find it
here:

http://monom.org/data/completion/kernbench-completion-swait.png

changes since v1: none, just more tests and bigger commit message.


 include/linux/completion.h | 23 ++++++++++++++++-------
 include/linux/swait.h      |  1 +
 kernel/sched/completion.c  | 43 ++++++++++++++++++++++++++-----------------
 kernel/sched/swait.c       | 24 ++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 5d5aaae..45fd91a 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -8,7 +8,7 @@
  * See kernel/sched/completion.c for details.
  */
 
-#include <linux/wait.h>
+#include <linux/swait.h>
 
 /*
  * struct completion - structure used to maintain state for a "completion"
@@ -22,13 +22,22 @@
  * reinit_completion(), and macros DECLARE_COMPLETION(),
  * DECLARE_COMPLETION_ONSTACK().
  */
+
+#define COMPLETION_DEFER (1 << 0)
+
 struct completion {
-	unsigned int done;
-	wait_queue_head_t wait;
+	union {
+		struct {
+			unsigned short flags;
+			unsigned short done;
+		};
+		unsigned int val;
+	};
+	struct swait_queue_head wait;
 };
 
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, __WAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
+	{ 0, 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
 
 #define COMPLETION_INITIALIZER_ONSTACK(work) \
 	({ init_completion(&work); work; })
@@ -72,8 +81,8 @@ struct completion {
  */
 static inline void init_completion(struct completion *x)
 {
-	x->done = 0;
-	init_waitqueue_head(&x->wait);
+	x->val = 0;
+	init_swait_queue_head(&x->wait);
 }
 
 /**
@@ -85,7 +94,7 @@ static inline void init_completion(struct completion *x)
  */
 static inline void reinit_completion(struct completion *x)
 {
-	x->done = 0;
+	x->val = 0;
 }
 
 extern void wait_for_completion(struct completion *);
diff --git a/include/linux/swait.h b/include/linux/swait.h
index c1f9c62..83f004a 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -87,6 +87,7 @@ static inline int swait_active(struct swait_queue_head *q)
 extern void swake_up(struct swait_queue_head *q);
 extern void swake_up_all(struct swait_queue_head *q);
 extern void swake_up_locked(struct swait_queue_head *q);
+extern void swake_up_all_locked(struct swait_queue_head *q);
 
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 extern void prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int state);
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 8d0f35d..d4dccd3 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -30,10 +30,10 @@ void complete(struct completion *x)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&x->wait.lock, flags);
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
 	x->done++;
-	__wake_up_locked(&x->wait, TASK_NORMAL, 1);
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	swake_up_locked(&x->wait);
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 EXPORT_SYMBOL(complete);
 
@@ -50,10 +50,15 @@ void complete_all(struct completion *x)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&x->wait.lock, flags);
-	x->done += UINT_MAX/2;
-	__wake_up_locked(&x->wait, TASK_NORMAL, 0);
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
+	x->done += USHRT_MAX/2;
+	if (irqs_disabled_flags(flags)) {
+		x->flags = COMPLETION_DEFER;
+		swake_up_locked(&x->wait);
+	} else {
+		swake_up_all_locked(&x->wait);
+	}
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 }
 EXPORT_SYMBOL(complete_all);
 
@@ -62,20 +67,20 @@ do_wait_for_common(struct completion *x,
 		   long (*action)(long), long timeout, int state)
 {
 	if (!x->done) {
-		DECLARE_WAITQUEUE(wait, current);
+		DECLARE_SWAITQUEUE(wait);
 
-		__add_wait_queue_tail_exclusive(&x->wait, &wait);
+		__prepare_to_swait(&x->wait, &wait);
 		do {
 			if (signal_pending_state(state, current)) {
 				timeout = -ERESTARTSYS;
 				break;
 			}
 			__set_current_state(state);
-			spin_unlock_irq(&x->wait.lock);
+			raw_spin_unlock_irq(&x->wait.lock);
 			timeout = action(timeout);
-			spin_lock_irq(&x->wait.lock);
+			raw_spin_lock_irq(&x->wait.lock);
 		} while (!x->done && timeout);
-		__remove_wait_queue(&x->wait, &wait);
+		__finish_swait(&x->wait, &wait);
 		if (!x->done)
 			return timeout;
 	}
@@ -89,9 +94,13 @@ __wait_for_common(struct completion *x,
 {
 	might_sleep();
 
-	spin_lock_irq(&x->wait.lock);
+	raw_spin_lock_irq(&x->wait.lock);
 	timeout = do_wait_for_common(x, action, timeout, state);
-	spin_unlock_irq(&x->wait.lock);
+	raw_spin_unlock_irq(&x->wait.lock);
+	if (x->flags & COMPLETION_DEFER) {
+		x->flags = 0;
+		swake_up_all(&x->wait);
+	}
 	return timeout;
 }
 
@@ -277,12 +286,12 @@ bool try_wait_for_completion(struct completion *x)
 	if (!READ_ONCE(x->done))
 		return 0;
 
-	spin_lock_irqsave(&x->wait.lock, flags);
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
 	if (!x->done)
 		ret = 0;
 	else
 		x->done--;
-	spin_unlock_irqrestore(&x->wait.lock, flags);
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(try_wait_for_completion);
@@ -311,7 +320,7 @@ bool completion_done(struct completion *x)
 	 * after it's acquired the lock.
 	 */
 	smp_rmb();
-	spin_unlock_wait(&x->wait.lock);
+	raw_spin_unlock_wait(&x->wait.lock);
 	return true;
 }
 EXPORT_SYMBOL(completion_done);
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index 82f0dff..efe366b 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -72,6 +72,30 @@ void swake_up_all(struct swait_queue_head *q)
 }
 EXPORT_SYMBOL(swake_up_all);
 
+void swake_up_all_locked(struct swait_queue_head *q)
+{
+	struct swait_queue *curr;
+	LIST_HEAD(tmp);
+
+	if (!swait_active(q))
+		return;
+
+	list_splice_init(&q->task_list, &tmp);
+	while (!list_empty(&tmp)) {
+		curr = list_first_entry(&tmp, typeof(*curr), task_list);
+
+		wake_up_state(curr->task, TASK_NORMAL);
+		list_del_init(&curr->task_list);
+
+		if (list_empty(&tmp))
+			break;
+
+		raw_spin_unlock_irq(&q->lock);
+		raw_spin_lock_irq(&q->lock);
+	}
+}
+EXPORT_SYMBOL(swake_up_all_locked);
+
 void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait)
 {
 	wait->task = current;
-- 
2.5.5
