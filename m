From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.4.15-rt25
Date: Mon, 29 Oct 2012 19:46:33 -0400
Message-ID: <1351554393.8467.79.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:29458 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505Ab2J2Xqf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Oct 2012 19:46:35 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 3.4.15-rt25 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  Head SHA1: 7fe212b3cf8cb2ba4dda85345130f7d3b0412e0f


Or to build 3.4.15-rt25 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.15.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.15-rt25.patch.xz


You can also build from 3.4.15-rt24 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/incr/patch-3.4.15-rt24-rt25.patch.xz



Enjoy,

-- Steve


Changes from 3.4.15-rt24:

---

Steven Rostedt (1):
      Linux 3.4.15-rt25

Thomas Gleixner (1):
      rcu: rcutiny: Prevent RCU stall

----
 kernel/rcutiny_plugin.h |    2 +-
 localversion-rt         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---------------------------
diff --git a/kernel/rcutiny_plugin.h b/kernel/rcutiny_plugin.h
index 22ecea0..97e359b 100644
--- a/kernel/rcutiny_plugin.h
+++ b/kernel/rcutiny_plugin.h
@@ -572,7 +572,7 @@ static noinline void rcu_read_unlock_special(struct task_struct *t)
 		rcu_preempt_cpu_qs();
 
 	/* Hardware IRQ handlers cannot block. */
-	if (in_irq() || in_serving_softirq()) {
+	if (preempt_count() & (HARDIRQ_MASK | SOFTIRQ_OFFSET)) {
 		local_irq_restore(flags);
 		return;
 	}
diff --git a/localversion-rt b/localversion-rt
index b2111a2..c5b71f9 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt24
+-rt25


