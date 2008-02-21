From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH [RT] 01/14] spinlocks: fix preemption feature when PREEMPT_RT
	is enabled
Date: Thu, 21 Feb 2008 10:26:30 -0500
Message-ID: <20080221152630.4804.56954.stgit@novell1.haskins.net>
References: <20080221152504.4804.8724.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, bill.huey@gmail.com,
	kevin@hilman.org, cminyard@mvista.com, dsingleton@mvista.com,
	dwalker@mvista.com, npiggin@suse.de, dsaxena@plexity.net,
	ak@suse.de, gregkh@suse.de, sdietrich@novell.com,
	pmorreale@novell.com, mkohari@novell.com, ghaskins@novell.com
To: mingo@elte.hu, a.p.zijlstra@chello.nl, tglx@linutronix.de,
	rostedt@goodmis.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:41276
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755463AbYBUPyG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Feb 2008 10:54:06 -0500
In-Reply-To: <20080221152504.4804.8724.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The logic is currently broken so that PREEMPT_RT disables preemptible
spinlock waiters, which is counter intuitive. 

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
