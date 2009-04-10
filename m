From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 0/3] Patches for KVM & RT
Date: Fri, 10 Apr 2009 09:23:06 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0904100916530.21577@localhost.localdomain>
References: <20090407235853.309888494@suse.de> <49DE6C4C.3070308@osadl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Blunck <jblunck@suse.de>,
	rt-users <linux-rt-users@vger.kernel.org>, kvm@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>
To: Carsten Emde <Carsten.Emde@osadl.org>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <49DE6C4C.3070308@osadl.org>
Sender: kvm-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 9 Apr 2009, Carsten Emde wrote:

> Jan,
> 
> > Here are some patches that are necessary to get KVM running with the -rt4
> > patchset.
> Thanks a lot.
> 
> Unfortunaately, there is still a last one at kernel/smp.c:288
>         /* Can deadlock when called with interrupts disabled */
>         WARN_ON_ONCE(irqs_disabled() && !oops_in_progress);
> 
> Do we get another fix?

I think I have seen that before. Just remembered that I fixed that
with Avi last year. Patch got dropped in the 26->29 move.

Thanks,

	tglx

----

From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 14 Jan 2008 14:02:44 +0200
Subject: CFS: enable irqs in fire_sched_in_preempt_notifier

KVM expects the notifier call with irqs enabled. It's necessary due
to a possible IPI call. Make the preempt-rt version behave the same
way as mainline.

Signed-off-by: Thomas Gleixner <tgxl@linutronix.de>

---
 kernel/sched.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-2.6.24.7-rt27/kernel/sched.c
===================================================================
--- linux-2.6.24.7-rt27.orig/kernel/sched.c	2009-02-08 00:01:16.000000000 -0500
+++ linux-2.6.24.7-rt27/kernel/sched.c	2009-02-08 00:01:22.000000000 -0500
@@ -1821,8 +1821,17 @@ static void fire_sched_in_preempt_notifi
 	struct preempt_notifier *notifier;
 	struct hlist_node *node;
 
+	if (hlist_empty(&curr->preempt_notifiers))
+		return;
+
+	/*
+	 * The KVM sched in notifier expects to be called with
+	 * interrupts enabled.
+	 */
+	local_irq_enable();
 	hlist_for_each_entry(notifier, node, &curr->preempt_notifiers, link)
 		notifier->ops->sched_in(notifier, raw_smp_processor_id());
+	local_irq_disable();
 }
 
 static void
