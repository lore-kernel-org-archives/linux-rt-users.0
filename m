From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.2.63-rt93
Date: Tue, 4 Nov 2014 09:17:30 -0500
Message-ID: <20141104091730.2de6a785@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 3.2.63-rt93 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.2-rt
  Head SHA1: 21561b920d1d034b059d44a6e86489c150bf9fbb


Or to build 3.2.63-rt93 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.63.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.63-rt93.patch.xz



You can also build from 3.2.63-rt92 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2.63-rt92-rt93.patch.xz



Enjoy,

-- Steve


Changes from v3.2.63-rt92:

---

Steven Rostedt (Red Hat) (2):
      lockdep: Fix backport of "Correctly annotate hardirq context in irq_exit()"
      Linux 3.2.63-rt93

----
 kernel/softirq.c | 5 +++--
 localversion-rt  | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)
---------------------------
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 7d882ccfa22b..56d30853345d 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -637,9 +637,10 @@ static inline void invoke_softirq(void)
 static inline void invoke_softirq(void)
 {
 #ifndef CONFIG_PREEMPT_RT_FULL
-	if (!force_irqthreads)
+	if (!force_irqthreads) {
+		lockdep_softirq_from_hardirq();
 		do_softirq();
-	else {
+	} else {
 		__local_bh_disable((unsigned long)__builtin_return_address(0),
 				SOFTIRQ_OFFSET);
 		wakeup_softirqd();
diff --git a/localversion-rt b/localversion-rt
index 4905d52a4828..e98a1fe050bd 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt92
+-rt93
