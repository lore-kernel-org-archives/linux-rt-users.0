From: Gregory Haskins <ghaskins@novell.com>
Subject: [(RT RFC) PATCH v2 9/9] remove the extra call to try_to_take_lock
Date: Mon, 25 Feb 2008 11:01:23 -0500
Message-ID: <20080225160123.11268.6904.stgit@novell1.haskins.net>
References: <20080225155959.11268.35541.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, bill.huey@gmail.com,
	kevin@hilman.org, cminyard@mvista.com, dsingleton@mvista.com,
	dwalker@mvista.com, npiggin@suse.de, dsaxena@plexity.net,
	ak@suse.de, pavel@ucw.cz, acme@redhat.com, gregkh@suse.de,
	sdietrich@novell.com, pmorreale@novell.com, mkohari@novell.com,
	ghaskins@novell.com
To: mingo@elte.hu, a.p.zijlstra@chello.nl, tglx@linutronix.de,
	rostedt@goodmis.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-111-13.dhcp.oxfr.ma.charter.com ([75.130.111.13]:53986
	"EHLO novell1.haskins.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756930AbYBYQ3s (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Feb 2008 11:29:48 -0500
In-Reply-To: <20080225155959.11268.35541.stgit@novell1.haskins.net>
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
index b81bbef..266ae31 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -756,12 +756,6 @@ rt_spin_lock_slowlock(struct rt_mutex *lock)
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
