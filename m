From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v0] Use swait in completion
Date: Tue,  8 Mar 2016 16:59:13 +0100
Message-ID: <1457452754-24029-1-git-send-email-wagi@monom.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi,

As Peter correctly pointed out in [1] a simple conversion from
wait to swait in completion.c wont work. I played a bit around and
came up with this rather ugly idea.

So in case complete_all() is called in hard irq context we just wake
up one waiter and let that one call swake_up_all(). For this I needed
to somehow transfer this information from complete_all() to
wait_for_completion(). The only working idea I found was to introduce
a new flag in struct completion. Ideas to overcome this problem
are highly appreciated.

I did also some performance measurement with below test program. The
test creates a trigger thread and a bunch of waiter threads. The
trigger thread calls complete_all() either from thread context or from
hard irq context. Time needed for 1000 iterations measured. This was
done on a idle IvyBridge machine with 64 logial cores (E5-4610).

waiter_nr: number of waiter threads
irqwork: 0 complete_all() from thread context, 1 complete_all() from irq_work()

wait:
waiter_nr 64
irqwork 0

count    66.000000
mean      0.378318
std       0.018468
min       0.344000
25%       0.364000
50%       0.382500
75%       0.395000
max       0.407000


swait:
waiter_nr 64
irqwork 1

count    86.000000
mean      0.315221
std       0.007115
min       0.291000
25%       0.312000
50%       0.316500
75%       0.320000
max       0.329000

swait:
waiter_nr 64
irqwork 0

count    81.000000
mean      0.344642
std       0.021708
min       0.294000
25%       0.336000
50%       0.341000
75%       0.355000
max       0.403000

cheers,
daniel


completion-test.c:

#include <linux/module.h>
#include <linux/wait.h>
#include <linux/swait.h>
#include <linux/kthread.h>
#include <linux/threads.h>
#include <linux/slab.h>
#include <linux/delay.h>
#include <linux/completion.h>
#include <linux/irq_work.h>

static unsigned int waiter_nr = 5;
static bool irqwork = true;
static unsigned int counter = 1000;

module_param(waiter_nr, uint,
		S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
MODULE_PARM_DESC(waiter_nr, "Number of waiter threads");

module_param(irqwork, bool,
		S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
MODULE_PARM_DESC(irqwork, "irqwork");

module_param(counter, uint,
		S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
MODULE_PARM_DESC(counter, "counter");

struct completion_test {
	/* We need two completions to avoid a race with reinit of the
	 * completion.
	 */
	struct completion sync_stage1;
	struct completion sync_stage2;

	wait_queue_head_t wq_stage1;
	wait_queue_head_t wq_stage2;

	atomic_t cnt_stage1;
	atomic_t cnt_stage2;

	struct irq_work irq_work;
};

static struct completion_test test_data;
static struct task_struct **waiter_tasks;
static struct task_struct *trigger_task;

static void trigger_irq(struct irq_work *arg)
{
	struct completion_test *ct =
		container_of(arg, struct completion_test, irq_work);

	complete_all(&ct->sync_stage1);
}

static int waiter(void *arg)
{
	struct completion_test *ct = arg;

	for (;;) {
		atomic_inc(&ct->cnt_stage1);
		wake_up(&ct->wq_stage1);
		wait_for_completion_interruptible(&ct->sync_stage1);
		if (kthread_should_stop())
			break;

		atomic_inc(&ct->cnt_stage2);
		wake_up(&ct->wq_stage2);
		wait_for_completion_interruptible(&ct->sync_stage2);
		if (kthread_should_stop())
			break;
	}
	return 0;
}

static int trigger(void *arg)
{
	struct completion_test *ct = arg;
	struct timespec ts_start, ts;
	unsigned long cnt;

	cnt = counter;
	ts_start = current_kernel_time();

	for (;;) {
		cnt--;
		if (cnt == 0) {
			ts = timespec_sub(current_kernel_time(), ts_start);
			printk("%ld.%.9ld\n", ts.tv_sec, ts.tv_nsec);

			cnt = counter;
			ts_start = current_kernel_time();
		}

		wait_event_interruptible(ct->wq_stage1,
				!(atomic_read(&ct->cnt_stage1) < waiter_nr));
		if (kthread_should_stop()) {
			complete_all(&ct->sync_stage1);
			break;
		}

		atomic_set(&ct->cnt_stage2, 0);
		reinit_completion(&ct->sync_stage2);

		if (irqwork)
			irq_work_queue(&ct->irq_work);
		else
			complete_all(&ct->sync_stage1);

		wait_event_interruptible(ct->wq_stage2,
				!(atomic_read(&ct->cnt_stage2) < waiter_nr));
		if (kthread_should_stop()) {
			complete_all(&ct->sync_stage2);
			break;
		}

		reinit_completion(&ct->sync_stage1);
		atomic_set(&ct->cnt_stage1, 0);
		complete_all(&ct->sync_stage2);
	}

	return 0;
}

static void __exit completion_test_module_cleanup(void)
{
	unsigned int i;

	if (trigger_task)
		kthread_stop(trigger_task);

	if (waiter_tasks) {
		for (i = 0; i < waiter_nr; i++) {
			if (waiter_tasks[i] && !IS_ERR(waiter_tasks[i]))
				kthread_stop(waiter_tasks[i]);

		}
		kfree(waiter_tasks);
	}
}

static int __init completion_test_module_init(void)
{
	struct completion_test *ct = &test_data;
	unsigned int i;
	int err;

	init_completion(&ct->sync_stage1);
	init_completion(&ct->sync_stage2);
	init_waitqueue_head(&ct->wq_stage1);
	init_waitqueue_head(&ct->wq_stage2);
	atomic_set(&ct->cnt_stage1, 0);
	atomic_set(&ct->cnt_stage2, 0);
	init_irq_work(&ct->irq_work, trigger_irq);

	waiter_tasks = kcalloc(waiter_nr, sizeof(waiter_tasks[0]), GFP_KERNEL);
	if (!waiter_tasks) {
		printk("out of memory\n");
		err = -ENOMEM;
		goto unwind;
	}

	for (i = 0; i < waiter_nr; i++) {
		waiter_tasks[i] = kthread_run(waiter, ct, "waiter");
		if (IS_ERR(waiter_tasks[i])) {
			err = -PTR_ERR(waiter_tasks[i]);
			goto unwind;
		}
	}

	trigger_task = kthread_run(trigger, ct, "trigger");
	if (IS_ERR(trigger_task)) {
		err = -PTR_ERR(trigger_task);
		goto unwind;
	}

	return 0;

unwind:
	completion_test_module_cleanup();
	return err;
}

module_init(completion_test_module_init);
module_exit(completion_test_module_cleanup);

MODULE_LICENSE("GPL v2");
MODULE_AUTHOR("Daniel Wagner");
MODULE_DESCRIPTION("completion test");


[1] http://thread.gmane.org/gmane.linux.kernel/2034867/focus=2034873


Daniel Wagner (1):
  sched/completion: convert completions to use simple wait queues

 include/linux/completion.h | 14 ++++++++++----
 kernel/sched/completion.c  | 41 +++++++++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 20 deletions(-)

-- 
2.5.0
