From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Filesystem lockup with CONFIG_PREEMPT_RT
Date: Fri, 27 Jun 2014 14:19:03 -0400
Message-ID: <20140627141903.16817c28@gandalf.local.home>
References: <CANGgnMbHckBQdKGN_N5Q6qEKc9n1CenxvMpeXog1NbSdL8UrTw@mail.gmail.com>
	<CANGgnMYDXerOUDOO9-RHMJKadKACA2KBGskZwoP-1ZwAhDEfVA@mail.gmail.com>
	<CAFLxGvxfBt7OvW=a2Kz08GLHSEiiOZsN-vB19CXnQiwqFxqMsA@mail.gmail.com>
	<CANGgnMYVoP-Z0Bv-VDEkJnvfa7Fi4-zY2F4A0PhMewGvwo3VVw@mail.gmail.com>
	<alpine.DEB.2.10.1406270027300.5170@nanos>
	<CANGgnMa+qtgJ3wwg_h5Rynw5vEvZpQZ6PvaUfXNQ8+Y3Yu5U0g@mail.gmail.com>
	<1403873856.5827.56.camel@marge.simpson.net>
	<20140627100157.6b0143a5@gandalf.local.home>
	<1403890493.5830.33.camel@marge.simpson.net>
	<20140627135415.7246e87e@gandalf.local.home>
	<1403892474.5830.41.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Austin Schuh <austin@peloton-tech.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Richard Weinberger <richard.weinberger@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:27939 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751273AbaF0STH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Jun 2014 14:19:07 -0400
In-Reply-To: <1403892474.5830.41.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 27 Jun 2014 20:07:54 +0200
Mike Galbraith <umgwanakikbuti@gmail.com> wrote:
 
> > Why do we need the wakeup? the owner of the lock should wake it up
> > shouldn't it?
> 
> True, but that can take ages.

Can it? If the workqueue is of some higher priority, it should boost
the process that owns the lock. Otherwise it just waits like anything
else does.

I much rather keep the paradigm of the mainline kernel than to add a
bunch of hacks that can cause more unforeseen side effects that may
cause other issues.

Remember, this would only be for spinlocks converted into a rtmutex,
not for normal mutex or other sleeps. In mainline, the wake up still
would not happen so why are we waking it up here?

This seems similar to the BKL crap we had to deal with as well. If we
were going to sleep because we were blocked on a spinlock converted
rtmutex we could not release and retake the BKL because we would end up
blocked on two locks. Instead, we made sure that the spinlock would not
release or take the BKL. It kept with the paradigm of mainline and
worked. Sucked, but it worked.

-- Steve
