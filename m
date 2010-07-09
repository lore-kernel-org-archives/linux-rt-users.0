From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.33.[56]-rt23: howto create repeatable explosion in
 wakeup_next_waiter()
Date: Fri, 09 Jul 2010 21:34:49 +0200
Message-ID: <1278704089.7961.12.camel@marge.simson.net>
References: <1278478019.10245.77.camel@marge.simson.net>
	 <alpine.LFD.2.00.1007071356480.2604@localhost.localdomain>
	 <4C368565.3020806@us.ibm.com>  <4C36CD83.6070809@us.ibm.com>
	 <1278683900.10161.8.camel@marge.simson.net>  <4C374FE2.2090309@us.ibm.com>
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
Received: from mail.gmx.net ([213.165.64.20]:34352 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751913Ab0GITel (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Jul 2010 15:34:41 -0400
In-Reply-To: <4C374FE2.2090309@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2010-07-09 at 09:35 -0700, Darren Hart wrote:

> If pendowner is blocked on "lock" to begin with (he should be as his 
> waiter struct in in the rtmutex waiters list) then he can't block on 
> someone else until he either acquires this one or removes himself as a 
> waiter (due to a timeout for instance) - both of these operations 
> require holding lock->wait_lock, which is held by the caller of 
> wakeup_next_waiter().

Hm, right, first thing wakee does is re-grab the wait_lock.

	-Mike

