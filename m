From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.33.[56]-rt23: howto create repeatable explosion in
 wakeup_next_waiter()
Date: Fri, 09 Jul 2010 15:58:20 +0200
Message-ID: <1278683900.10161.8.camel@marge.simson.net>
References: <1278478019.10245.77.camel@marge.simson.net>
	 <alpine.LFD.2.00.1007071356480.2604@localhost.localdomain>
	 <4C368565.3020806@us.ibm.com>  <4C36CD83.6070809@us.ibm.com>
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
Received: from mail.gmx.net ([213.165.64.20]:33816 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753054Ab0GIN6M (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Jul 2010 09:58:12 -0400
In-Reply-To: <4C36CD83.6070809@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2010-07-09 at 00:19 -0700, Darren Hart wrote:

> Walking through it:
> 
> First the dumps:
> ------------[ cut here ]------------
> WARNING: at kernel/rtmutex.c:583 wakeup_next_waiter+0x1ad/0x220()
> 
> 
> WARN_ON(pendowner->pi_blocked_on != waiter);
> The pi_blocked_on is not NULL, but it isn't the expected waiter either.
> This means that the top waiter selected at the beginning of
> wakeup_next_waiter() is now blocked on a lock with a different waiter
> structure, possibly on a different lock.

pendowner->pi_blocked_on changes while we're in wakeup_next_waiter().
The below fi^Wmade it not do that any more.  We hold the wait_lock for
this lock, but if the wakee blocks on another, what's protecting us?

bandaid-by: /me

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 23dd443..dd91ede 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -525,6 +525,8 @@ static void wakeup_next_waiter(struct rt_mutex *lock, int savestate)
 	pendowner = waiter->task;
 	waiter->task = NULL;
 
+	raw_spin_lock(&pendowner->pi_lock);
+
 	/*
 	 * Do the wakeup before the ownership change to give any spinning
 	 * waiter grantees a headstart over the other threads that will
@@ -577,8 +579,6 @@ static void wakeup_next_waiter(struct rt_mutex *lock, int savestate)
 	else
 		next = NULL;
 
-	raw_spin_lock(&pendowner->pi_lock);
