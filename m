From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: Filesystem lockup with CONFIG_PREEMPT_RT
Date: Fri, 27 Jun 2014 18:18:27 -0700
Message-ID: <CANGgnMZrx1s5AomG-L_F74215RE1uJOekTjYmLX0voG4NgakTg@mail.gmail.com>
References: <CANGgnMbHckBQdKGN_N5Q6qEKc9n1CenxvMpeXog1NbSdL8UrTw@mail.gmail.com>
 <CANGgnMYDXerOUDOO9-RHMJKadKACA2KBGskZwoP-1ZwAhDEfVA@mail.gmail.com>
 <CAFLxGvxfBt7OvW=a2Kz08GLHSEiiOZsN-vB19CXnQiwqFxqMsA@mail.gmail.com>
 <CANGgnMYVoP-Z0Bv-VDEkJnvfa7Fi4-zY2F4A0PhMewGvwo3VVw@mail.gmail.com>
 <alpine.DEB.2.10.1406270027300.5170@nanos> <CANGgnMa+qtgJ3wwg_h5Rynw5vEvZpQZ6PvaUfXNQ8+Y3Yu5U0g@mail.gmail.com>
 <1403873856.5827.56.camel@marge.simpson.net> <20140627100157.6b0143a5@gandalf.local.home>
 <1403890493.5830.33.camel@marge.simpson.net> <20140627135415.7246e87e@gandalf.local.home>
 <1403892474.5830.41.camel@marge.simpson.net> <20140627141903.16817c28@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Richard Weinberger <richard.weinberger@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:63687 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbaF1BSs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Jun 2014 21:18:48 -0400
Received: by mail-ig0-f169.google.com with SMTP id c1so2529178igq.4
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Jun 2014 18:18:48 -0700 (PDT)
In-Reply-To: <20140627141903.16817c28@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jun 27, 2014 at 11:19 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 27 Jun 2014 20:07:54 +0200
> Mike Galbraith <umgwanakikbuti@gmail.com> wrote:
>
>> > Why do we need the wakeup? the owner of the lock should wake it up
>> > shouldn't it?
>>
>> True, but that can take ages.
>
> Can it? If the workqueue is of some higher priority, it should boost
> the process that owns the lock. Otherwise it just waits like anything
> else does.
>
> I much rather keep the paradigm of the mainline kernel than to add a
> bunch of hacks that can cause more unforeseen side effects that may
> cause other issues.
>
> Remember, this would only be for spinlocks converted into a rtmutex,
> not for normal mutex or other sleeps. In mainline, the wake up still
> would not happen so why are we waking it up here?
>
> This seems similar to the BKL crap we had to deal with as well. If we
> were going to sleep because we were blocked on a spinlock converted
> rtmutex we could not release and retake the BKL because we would end up
> blocked on two locks. Instead, we made sure that the spinlock would not
> release or take the BKL. It kept with the paradigm of mainline and
> worked. Sucked, but it worked.
>
> -- Steve

Sounds like you are arguing that we should disable preemption (or
whatever the right mechanism is) while holding the pool lock?

Workqueues spin up more threads when work that they are executing
blocks.  This is done through hooks in the scheduler.  This means that
we have to acquire the pool lock when work blocks on a lock in order
to see if there is more work and whether or not we need to spin up a
new thread.

It would be more context switches, but I wonder if we could kick the
workqueue logic completely out of the scheduler into a thread.  Have
the scheduler increment/decrement an atomic pool counter, and wake up
the monitoring thread to spawn new threads when needed?  That would
get rid of the recursive pool lock problem, and should reduce
scheduler latency if we would need to spawn a new thread.

Austin
