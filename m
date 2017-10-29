From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] swait: export the symbols __prepare_to_swait and
 __finish_swait
Date: Sun, 29 Oct 2017 12:54:42 -0400 (EDT)
Message-ID: <alpine.LRH.2.02.1710291242560.23849@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>,
        linux-rt-users@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

In order to reduce locking overhead, I use the spinlock in 
swait_queue_head to protect not only the wait queue, but also the list of 
events. Consequently, I need to use unlocked functions __prepare_to_swait 
and __finish_swait. These functions are declared in the file 
include/linux/swait.h, but they are not exported, and so they are not 
useable from kernel modules.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 kernel/sched/swait.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/kernel/sched/swait.c
===================================================================
--- linux-2.6.orig/kernel/sched/swait.c
+++ linux-2.6/kernel/sched/swait.c
@@ -72,6 +72,7 @@ void __prepare_to_swait(struct swait_que
 	if (list_empty(&wait->task_list))
 		list_add(&wait->task_list, &q->task_list);
 }
+EXPORT_SYMBOL(__prepare_to_swait);
 
 void prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int state)
 {
@@ -101,6 +102,7 @@ void __finish_swait(struct swait_queue_h
 	if (!list_empty(&wait->task_list))
 		list_del_init(&wait->task_list);
 }
+EXPORT_SYMBOL(__finish_swait);
 
 void finish_swait(struct swait_queue_head *q, struct swait_queue *wait)
 {
