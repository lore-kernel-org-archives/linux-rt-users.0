From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.33.[56]-rt23: howto create repeatable explosion in
 wakeup_next_waiter()
Date: Fri, 09 Jul 2010 10:13:50 +0200
Message-ID: <1278663230.10134.15.camel@marge.simson.net>
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
Received: from mail.gmx.net ([213.165.64.20]:36743 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754512Ab0GIINn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Jul 2010 04:13:43 -0400
In-Reply-To: <4C36CD83.6070809@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2010-07-09 at 00:19 -0700, Darren Hart wrote:

> I'll keep on looking, but I wanted to share what I've learned in case anyone
> in another timezone is hoping to continue debugging should I fall asleep at
> the helm ;-)

Still making smoke here, no heat or light tho..

Q: why is it ok to call rt_mutex_proxy_unlock() without the wait_lock
held?  Every other path leading to rt_mutex_set_owner() seems to hold
the lock.  Locking it did diddly spit other than shut up my WARN_ON().

diff --git a/kernel/futex.c b/kernel/futex.c
index a6cec32..f4b76d9 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -407,7 +407,9 @@ static void free_pi_state(struct futex_pi_state *pi_state)
 		list_del_init(&pi_state->list);
 		raw_spin_unlock_irq(&pi_state->owner->pi_lock);
 
+		raw_spin_lock(&pi_state->pi_mutex.wait_lock);
 		rt_mutex_proxy_unlock(&pi_state->pi_mutex, pi_state->owner);
+		raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
 	}
 
 	if (current->pi_state_cache)


