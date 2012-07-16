From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 05/11] slab: Prevent local lock deadlock
Date: Mon, 16 Jul 2012 14:43:15 -0400
Message-ID: <20120716184354.467426653@goodmis.org>
References: <20120716184310.223095720@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0005-slab-Prevent-local-lock-deadlock.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

On RT we avoid the cross cpu function calls and take the per cpu local
locks instead. Now the code missed that taking the local lock on the
cpu which runs the code must use the proper local lock functions and
not a simple spin_lock(). Otherwise it deadlocks later when trying to
acquire the local lock with the proper function.

Reported-and-tested-by: Chris Pringle <chris.pringle@miranda.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 mm/slab.c |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 15bce6b..64eb636 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -743,8 +743,26 @@ slab_on_each_cpu(void (*func)(void *arg, int this_cpu), void *arg)
 {
 	unsigned int i;
 
+	get_cpu_light();
 	for_each_online_cpu(i)
 		func(arg, i);
+	put_cpu_light();
+}
+
+static void lock_slab_on(unsigned int cpu)
+{
+	if (cpu == smp_processor_id())
+		local_lock_irq(slab_lock);
+	else
+		local_spin_lock_irq(slab_lock, &per_cpu(slab_lock, cpu).lock);
+}
+
+static void unlock_slab_on(unsigned int cpu)
+{
+	if (cpu == smp_processor_id())
+		local_unlock_irq(slab_lock);
+	else
+		local_spin_unlock_irq(slab_lock, &per_cpu(slab_lock, cpu).lock);
 }
 #endif
 
@@ -2692,10 +2710,10 @@ static void do_drain(void *arg, int cpu)
 {
 	LIST_HEAD(tmp);
 
-	spin_lock_irq(&per_cpu(slab_lock, cpu).lock);
+	lock_slab_on(cpu);
 	__do_drain(arg, cpu);
 	list_splice_init(&per_cpu(slab_free_list, cpu), &tmp);
-	spin_unlock_irq(&per_cpu(slab_lock, cpu).lock);
+	unlock_slab_on(cpu);
 	free_delayed(&tmp);
 }
 #endif
@@ -4163,9 +4181,9 @@ static void do_ccupdate_local(void *info)
 #else
 static void do_ccupdate_local(void *info, int cpu)
 {
-	spin_lock_irq(&per_cpu(slab_lock, cpu).lock);
+	lock_slab_on(cpu);
 	__do_ccupdate_local(info, cpu);
-	spin_unlock_irq(&per_cpu(slab_lock, cpu).lock);
+	unlock_slab_on(cpu);
 }
 #endif
 
-- 
1.7.10.4
