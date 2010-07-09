From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.33.[56]-rt23: howto create repeatable explosion in
 wakeup_next_waiter()
Date: Fri, 09 Jul 2010 06:32:22 +0200
Message-ID: <1278649942.7207.23.camel@marge.simson.net>
References: <1278478019.10245.77.camel@marge.simson.net>
	 <alpine.LFD.2.00.1007071356480.2604@localhost.localdomain>
	 <4C368565.3020806@us.ibm.com>
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
Received: from mail.gmx.net ([213.165.64.20]:49011 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750793Ab0GIEcQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Jul 2010 00:32:16 -0400
In-Reply-To: <4C368565.3020806@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2010-07-08 at 19:11 -0700, Darren Hart wrote:

> So the WARN_ON sequence is obviously wrong, if it's critical it should
> be a BUG(), if not we shouldn't dereference what we know to be null. The
> following patch avoids the NULL pointer dereference in the WARN_ON. With
> this patch the NULL WARN_ON makes it to the console, and test runs to
> completion with no obvious negative side effects. I'm only posting for
> reference at this point, as while this may be necessary, it isn't the
> right "solution".

I've been slogging through the locking under the assumption that
pi_blocked_on->task pointing to a stranger is very bad juju, but you're
right, the only obviously evil consequence I see is tripping over the
fallout in WARN_ON().

> Tonight/Tomorrow I'll review the rtmutex and futex code to try and fully
> understand (again) the usage of pi_blocked_on and if we need to avoid
> this scenario, or if we need to handle it "gracefully".

I hope you find it, I'm going blind crawling in endless circles :)

	-Mike

