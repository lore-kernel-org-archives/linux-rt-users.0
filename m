From: Gregory Haskins <ghaskins@novell.com>
Subject: [PATCH [RT] 12/14] remove the extra call to try_to_take_lock
Date: Thu, 21 Feb 2008 10:27:27 -0500
Message-ID: <20080221152727.4804.42132.stgit@novell1.haskins.net>
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
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:41394
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755984AbYBUPy7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Feb 2008 10:54:59 -0500
In-Reply-To: <20080221152504.4804.8724.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Peter W. Morreale <pmorreale@novell.com>

Remove the redundant attempt to get the lock.  While it is true that the
exit path with this patch adds an un-necessary xchg (in the event the
lock is granted without further traversal in the loop) experimentation
shows that we almost never encounter this situation. 

Signed-off-by: Peter W. Morreale <pmorreale@novell.com>
---

 kernel/rtmutex.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index ebdaa17..95c3644 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -718,12 +718,6 @@ rt_spin_lock_slowlock(struct rt_mutex *lock)
 	spin_lock_irqsave(&lock->wait_lock, flags);
 	init_lists(lock);
 
-	/* Try to acquire the lock again: */
-	if (try_to_take_rt_mutex(lock)) {
-		spin_unlock_irqrestore(&lock->wait_lock, flags);
-		return;
-	}
-
 	BUG_ON(rt_mutex_owner(lock) == current);
 
 	/*
