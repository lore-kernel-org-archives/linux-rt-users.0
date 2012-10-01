From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: msleep_interruptible() sleeps *way* too long on PowerPC
Date: Mon, 01 Oct 2012 19:45:40 -0400
Message-ID: <1349135140.22822.129.camel@gandalf.local.home>
References: <1349112952.5069d4780f4ae@webmail.texas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: vomlehn@texas.net
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:32795 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab2JAXpm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Oct 2012 19:45:42 -0400
In-Reply-To: <1349112952.5069d4780f4ae@webmail.texas.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2012-10-01 at 12:35 -0500, vomlehn@texas.net wrote:
> When I run a command from the Busybox shell (ash), I sometimes experience a
> very long delay, on a system with the RT patches enabled (fully-preempible),
> before the prompt appears. Busybox calls tcdrain() prior to printing the
> prompt, which eventually winds up in uart_wait_until_sent(). This function
> uses msleep_interruptible() to wait for a millisecond, but doesn't actually
> complete for many seconds, even minutes, on an otherwise idle system.
> 
> when I change the preemption model to low-latency desktop, the system behaves
> as I would expect it to. It's worth mentioning that this is on a PowerPC
> processor, which handles timer interrupts through a slightly different path
> than other interrupts, but I don't see an issue with this yet.
> 
> Another observation which seems pretty vital--if I send a ping packet to one
> of the network interfaces, the msleep_interruptible() completes. It is as
> though it queued the timer and didn't realize it while timer interrupts were
> happening (lost in softIRQ processing?). Then, when the network interrupt
> happened, it went through some queue and processed the timeout.
> 
> I've verified that the struct timer_list is added and it looks to be in the
> right place.
> 
> There is an IPI-related PowerPC patch that went into 3.2.30 that sounded a lot
> like this, commit 241ee90a69ede9cf9255df1a18036210beeb8adf, but our
> configuration doesn't use this and it appears as though this happens when the
> task queueing the timer is still on the same processor when it gets the
> wakeup. Thus IPIs don't appear to be an issue.
> 
> Any thoughts would be appreciated!

Have you tried running a trace on it? Something like:

# mkdir /debug
# mount -t debugfs nodev /debug
# cd /debug/tracing
# echo 1 > events/enable
# <cause the problem>
# <trigger interrupt>
# echo 0 > tracing_on
# cat trace

-- Steve


