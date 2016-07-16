From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.14.73-rt78
Date: Fri, 15 Jul 2016 23:23:45 -0400
Message-ID: <20160715232345.5c3f72f3@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:34871 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751217AbcGPDXu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jul 2016 23:23:50 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

I'm pleased to announce the 3.14.73-rt78 stable release.

Due to a bug in a backport, I had to make a quick update.

Reported-by: Arnd Bergmann <arnd@arndb.de>

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.14-rt
  Head SHA1: 01af6fad4dae666b64d5db5ec6807b1f2994f438


Or to build 3.14.73-rt78 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.14.73.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/patch-3.14.73-rt78.patch.xz



You can also build from 3.14.73-rt77 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.14/incr/patch-3.14.73-rt77-rt78.patch.xz



Enjoy,

-- Steve


Changes from v3.14.73-rt77:

---

Steven Rostedt (Red Hat) (2):
      Fix backport of: sched,preempt: Fix preempt_count manipulations
      Linux 3.14.73-rt78

----
 include/asm-generic/preempt.h | 2 +-
 localversion-rt               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---------------------------
diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index 65759d8b0b46..25c09df2c046 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -7,7 +7,7 @@
 
 static __always_inline int preempt_count(void)
 {
-	return READ_ONCE(current_thread_info()->preempt_count);
+	return ACCESS_ONCE(current_thread_info()->preempt_count);
 }
 
 static __always_inline volatile int *preempt_count_ptr(void)
diff --git a/localversion-rt b/localversion-rt
index 595841feef80..30758e0b2242 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt77
+-rt78
