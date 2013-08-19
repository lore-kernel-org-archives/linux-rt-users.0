From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/3] swait: Add smp_mb() after setting h->list
Date: Mon, 19 Aug 2013 11:35:33 -0400
Message-ID: <20130819153619.148613482@goodmis.org>
References: <20130819153530.409041534@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <clark.williams@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-swait-Add-smp_mb-after-setting-h-list.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

The raw_spin_unlock() is not a full memory barrier. It only keeps
things from leaking past it, but does not prevent leaks from entering
the critical section. That is:

 	p = 1;

 	raw_spin_lock();
 	[...]
 	raw_spin_unlock();

 	y = x

 Can turn into:

  	p = 1;

 	raw_spin_lock();

 	load x

 	store p = 1

 	raw_spin_unlock();

 	y = x

This means that the condition check in __swait_event() (and friends)
can be seen before the h->list is set.

 	raw_spin_lock();

 	load condition;

 	store h->list;

 	raw_spin_unlock();

And the other CPU can see h->list as empty, and this CPU see condition
as not set, and possibly miss the wake up.

To prevent this from happening, add an mb() after setting the h->list.

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/wait-simple.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/wait-simple.c b/kernel/wait-simple.c
index 9725a11..2c85626 100644
--- a/kernel/wait-simple.c
+++ b/kernel/wait-simple.c
@@ -16,6 +16,8 @@
 static inline void __swait_enqueue(struct swait_head *head, struct swaiter *w)
 {
 	list_add(&w->node, &head->list);
+	/* We can't let the condition leak before the setting of head */
+	smp_mb();
 }
 
 /* Removes w from head->list. Must be called with head->lock locked. */
-- 
1.7.10.4
