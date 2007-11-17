From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: [BUG on PREEMPT_RT, 2.6.23.1-rt5] in rt-mutex code and signals
Date: Sat, 17 Nov 2007 16:36:08 +0100
Message-ID: <3efb10970711170736u469bbbc5p8c227ca2a12657dd@mail.gmail.com>
References: <3efb10970711160751l279fe99dl9f3a130a4373a449@mail.gmail.com>
	 <Pine.LNX.4.58.0711161516580.25989@gandalf.stny.rr.com>
	 <3efb10970711161502m6216bf5rc19a34184b4f3a2b@mail.gmail.com>
	 <Pine.LNX.4.58.0711161830570.28002@gandalf.stny.rr.com>
	 <3efb10970711170344n670d8b69w6679d494922c5bb@mail.gmail.com>
	 <Pine.LNX.4.58.0711170840130.4453@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:3385 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbXKQPgK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 17 Nov 2007 10:36:10 -0500
Received: by py-out-1112.google.com with SMTP id u77so4805292pyb
        for <linux-rt-users@vger.kernel.org>; Sat, 17 Nov 2007 07:36:09 -0800 (PST)
In-Reply-To: <Pine.LNX.4.58.0711170840130.4453@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Steven,

> It should print out warnings, do you have CONFIG_DEBUG_RT_MUTEXES set?

Nope, not yet... I will do that on Monday also. (On ARM I have as less
as debug options enabled per default, because it eats too much
CPU-power)

> > * PI should only take place if it is for 100% sure that the 'struct
> > semaphore' is used as a mutex. And this is only the case when it is
> > initialised with init_MUTEX().
>
> Well, we can't determine that with code ;-)  Remember, there are still
> drivers out in the world that use semaphores as mutexes. So the PI
> on semaphores is really more of a compatibility issue.

Very strange, although there is now a real mutex in non-RT as in RT,
all semaphores are still converted to some
badly-implemented-recursive-but-not-recursive-callable-mutexes,
because the assumption is made that semaphores are intentionally
always used in the wrong way?!!
So, the code that is written nicely must be adapted to prevent
adaption of bad code?

I would expect a more logical solution like the introduction of raw_
types for the exceptions, just like what is done with spinlocks and so
on.

> > So, this is a regression if exactly the same driver is used in both
> > non-preempt-rt patched kernel and preempt-rt patched kernels.
>
> Not really.  There are things that the preempt-rt kernels require. One, is
> that things that need to keep semaphores instead of using them as mutexes,
> they should be converted to compat_semaphores.  Perhaps now that we have
> mutexes, we can remove the PI on semaphores, and out-of-tree drivers will
> need to make sure they don't use semaphores as mutexes anymore.

Up to this semaphore implementation the standard was always that a
driver written for a non-RT kernel should compile and work properly
without any adaption on a RT-kernel, until there are some specific
realtime requirements.
When it comes to semaphores this is thus completely not true.

And this is where the whole thing confused me completely.

> Yeah, that code is more of a hack to convert counting semaphores into
> mutexes.

Enough said...

> But semaphores still need to have owners, and they should not
> block on themselves. That may be where the bug is.

Or there should be a real recursive mutex implementation. But the need
for recursive mutexes is usually a sign for bad locking, and should
therefor be avoided.

> OK, I wont be able to work on this this weekend, but I'll try to get to it
> on Monday.  A better example to show the bug you are looking for is simply
> create a mutex and create a thread that grabs that mutex and goes to
> sleep. Have your driver read grab that mutex with
> mutex_lock_interruptible. And if the signal code is broken with this, then
> you definitely got a point that the inerruptible code is broken.

I will work on an example like this on Monday.

> This will keep the semantics clean and not obfuscate it with the semaphore
> code.

I agree.

> I'll write up that example on Monday if you don't have the time.

I will make time ;-)

> Note, that the unloading of the module should wake up the thread that
> grabbed the mutex so it can release it.

Unloading of a module is not possible as long as there is still a
handle open to it. So, it should be safe without waking up the thread.
And returning from the read call and still have a mutex locked is not
nice either.

Thanks for the explanation. I will keep you informed on Monday.


Have a nice weekend !


Remy
