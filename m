From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH] RT: fix spinlock preemption feature when PREEMPT_RT is enabled
Date: Fri, 07 Mar 2008 09:06:35 -0500
Message-ID: <20080307140635.13543.98126.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: ghaskins@novell.com, linux-kernel@vger.kernel.org
To: mingo@elte.hu, rostedt@goodmis.org, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:58771
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758084AbYCGOg5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Mar 2008 09:36:57 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

kernel/spinlock.c implements two versions of spinlock wrappers around
the arch-specific implementations:

1) A simple passthrough which implies disabled preemption while spinning

2) A "preemptible waiter" version which uses trylock.

Currently, PREEMPT && SMP will turn on the preemptible feature, and
lockdep or PREEMPT_RT will disable it.  Disabling the feature for
lockdep makes perfect sense, but PREEMPT_RT is counter-intuitive.  My
guess is that this was inadvertent, so this patch once again enables
the feature for PREEMPT_RT.

(Since PREEMPT is set for PREEMPT_RT, we simply get rid of the extra
condition).

I have tested the PREEMPT_RT kernel with this patch and all seems well.
Therefore, if there *is* an issue with running preemptible versions of
these spinlocks under PREEMPT_RT, it is not immediately apparent why. 

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
---

 kernel/spinlock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/spinlock.c b/kernel/spinlock.c
index c9bcf1b..b0e7f02 100644
--- a/kernel/spinlock.c
+++ b/kernel/spinlock.c
@@ -117,7 +117,7 @@ EXPORT_SYMBOL(__write_trylock_irqsave);
  * not re-enabled during lock-acquire (which the preempt-spin-ops do):
  */
 #if !defined(CONFIG_PREEMPT) || !defined(CONFIG_SMP) || \
-	defined(CONFIG_DEBUG_LOCK_ALLOC) || defined(CONFIG_PREEMPT_RT)
+	defined(CONFIG_DEBUG_LOCK_ALLOC)
 
 void __lockfunc __read_lock(raw_rwlock_t *lock)
 {

