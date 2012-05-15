From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Using patch-2.6.33.7.2-rt30 increases latency and CPU usage?
Date: Tue, 15 May 2012 13:33:12 -0400
Message-ID: <1337103192.14207.340.camel@gandalf.stny.rr.com>
References: <joemui$6v0$1@dough.gmane.org> <joepd0$e4f$1@dough.gmane.org>
	 <4FAAEBF3.10907@netacquire.com> <joetve$hm5$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:4433 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966052Ab2EORdO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 May 2012 13:33:14 -0400
In-Reply-To: <joetve$hm5$1@dough.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-05-09 at 23:18 +0000, Grant Edwards wrote:

> I eventually figured out that my increased interrupt latency is due to
> my ISR being run in a kernel thread instead of as a real ISR.  Adding
> the IRQF_NODELAY flag gets me the same average latency I had without
> the RT patch.  [It looks like that flag has a different name in 2.6.39
> and later?]

Note, adding a IRQF_NODELAY is very dangerous. To keep the kernel fully
preemptible (well mostly), spin-locks have been converted into mutexes.
If the irq handler has one of these spinlocks that have been converted,
it may schedule in the interrupt handler and crash the kernel. You can
not schedule in interrupt context, which is why the RT kernel makes the
interrupt handlers into threads.

Also note, you may get better response if you up the interrupt thread's
priority. Up it to 98, and you should see much better responses.

Now I don't think you will make the 20us under load, but you won't do
that in the non-RT patch either.

-- Steve



