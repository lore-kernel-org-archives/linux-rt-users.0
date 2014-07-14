From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] 3.14.12-rt9
Date: Mon, 14 Jul 2014 23:57:42 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1407142242270.24854@nanos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT Folks,

I'm pleased to announce the 3.14.12-rt9 release. 3.14.10-rt8 is a not
announced update to 3.14.12 without any RT changes.

Changes since 3.14.12-rt8:

   * Bring back the interrupt randomness hunk which got dropped due
     an unresolved reject. Thanks to Ben Hutchings for spotting that!

<politics>

Thanks a lot for all the supportive mails on- and offlist!

  The most intriguing idea so far was to jump on the momentum of the
  most hilarious crowd funding nonsense:

    https://www.kickstarter.com/projects/324283889/potato-salad

  So in consequence we might turn RT into a crowdfunded nonsense
  project which serves the purpose of controlling the potato-salad
  machine to make sure that Zack Danger Brown can deliver all the
  potato salad people have pledged for.

</politics>

Thanks,

      Thomas

---
The delta patch against 3.14.12-rt8 is appended below and can be found
here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/incr/patch-3.14.10-rt8-rt9.patch.xz

The RT patch against 3.14.12 can be found here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/patch-3.14.12-rt9.patch.xz

The split quilt queue is available at:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/patches-3.14.12-rt9.tar.xz

Index: linux-stable/kernel/irq/manage.c
===================================================================
--- linux-stable.orig/kernel/irq/manage.c
+++ linux-stable/kernel/irq/manage.c
@@ -942,6 +942,12 @@ static int irq_thread(void *data)
 		if (action_ret == IRQ_HANDLED)
 			atomic_inc(&desc->threads_handled);
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+		migrate_disable();
+		add_interrupt_randomness(action->irq, 0,
+				 desc->random_ip ^ (unsigned long) action);
+		migrate_enable();
+#endif
 		wake_threads_waitq(desc);
 	}
 
Index: linux-stable/localversion-rt
===================================================================
--- linux-stable.orig/localversion-rt
+++ linux-stable/localversion-rt
@@ -1 +1 @@
--rt8
+-rt9
