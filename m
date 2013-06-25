From: Steven Rostedt <rostedt@goodmis.org>
Subject: question about disabling interrupts for workqueue pool?
Date: Tue, 25 Jun 2013 18:52:34 -0400
Message-ID: <1372200754.18733.236.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clark@redhat.com>,
	"Paul E. McKenney" <paulmck@us.ibm.com>
To: Tejun Heo <tj@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:31789 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505Ab3FYWwg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Jun 2013 18:52:36 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Tejun,

We've been playing with porting -rt to 3.10, and one of the stumbling
blocks we are dealing with happens to be with commit fa1b54e69bc
"workqueue: update synchronization rules on worker_pool_idr".

The issue is with the disabling of interrupts, and specifically this
sequence of events from start_flush_work():

        local_irq_disable();
        pool = get_work_pool(work);
        if (!pool) {
                local_irq_enable();
                return false;
        }

        spin_lock(&pool->lock);
        /* see the comment in try_to_grab_pending() with the same code */
        pwq = get_work_pwq(work);
        if (pwq) {
                if (unlikely(pwq->pool != pool))
                        goto already_gone;
        } else {
                worker = find_worker_executing_work(pool, work);
                if (!worker)
                        goto already_gone;
                pwq = worker->current_pwq;
        }

        insert_wq_barrier(pwq, barr, work, worker);
        spin_unlock_irq(&pool->lock);


As -rt does not have spin_lock_irq() disable interrupts, it means that
spin_unlock_irq() will not enable them either. But that's not all:

        local_irq_save(flags);
        pool = get_work_pool(work);
        if (pool) {
                spin_lock(&pool->lock);
                if (find_worker_executing_work(pool, work))
                        ret |= WORK_BUSY_RUNNING;
                spin_unlock(&pool->lock);
        }
        local_irq_restore(flags);

Basically, anywhere you disable interrupts, as -rt converts spin_lock()
into a mutex.

Now my question is, are those local_irq_*() calls just for synchronizing
with sched RCU? If so, can you use rcu_read_lock_sched() instead?

This wont solve our problems, as we will need to deal with
rcu_read_lock_sched() critical sections sleeping, but it will at least
change the problem area away from workqueues, and will document the
workqueue code better because stand alone "local_irq_disable()"s tend to
bring up a lot of questions to "why do we need to disable interrupts
here?".

-- Steve



