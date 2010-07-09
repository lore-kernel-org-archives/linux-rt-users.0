From: Mike Galbraith <mgalbraith@suse.de>
Subject: Re: 2.6.33.[56]-rt23: howto create repeatable explosion in
 wakeup_next_waiter()
Date: Fri, 09 Jul 2010 16:51:24 +0200
Message-ID: <1278687084.10336.5.camel@marge.simson.net>
References: <1278478019.10245.77.camel@marge.simson.net>
	 <alpine.LFD.2.00.1007071356480.2604@localhost.localdomain>
	 <4C368565.3020806@us.ibm.com>  <4C36CD83.6070809@us.ibm.com>
	 <1278683900.10161.8.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Steven Rostedt <rostedt@goodmis.org>,
	gowrishankar <gowrishankar.m@linux.vnet.ibm.com>
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40311 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756911Ab0GIOvU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Jul 2010 10:51:20 -0400
In-Reply-To: <1278683900.10161.8.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This would likely be better if holding over wakeup is ok.

pi-tests still work, as does everything else I've tried.  Doesn't _seem_
like a bad idea to keep pending owner on a leash until we're done
fiddling with him, but dunno, I've never needed to tinker here. 

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 23dd443..051f386 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -525,6 +525,9 @@ static void wakeup_next_waiter(struct rt_mutex *lock, int savestate)
 	pendowner = waiter->task;
 	waiter->task = NULL;
 
+	raw_spin_unlock(&current->pi_lock);
+	raw_spin_lock(&pendowner->pi_lock);
+
 	/*
 	 * Do the wakeup before the ownership change to give any spinning
 	 * waiter grantees a headstart over the other threads that will
@@ -562,8 +565,6 @@ static void wakeup_next_waiter(struct rt_mutex *lock, int savestate)
 
 	rt_mutex_set_owner(lock, pendowner, RT_MUTEX_OWNER_PENDING);
 
-	raw_spin_unlock(&current->pi_lock);
-
 	/*
 	 * Clear the pi_blocked_on variable and enqueue a possible
 	 * waiter into the pi_waiters list of the pending owner. This
@@ -577,8 +578,6 @@ static void wakeup_next_waiter(struct rt_mutex *lock, int savestate)
 	else
 		next = NULL;
 
-	raw_spin_lock(&pendowner->pi_lock);
