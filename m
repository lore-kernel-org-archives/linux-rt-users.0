From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: PI mutex support on ARM
Date: Sat, 15 Sep 2007 22:43:42 +0200
Message-ID: <3efb10970709151343q7266e0ady2a721c72f36f2a24@mail.gmail.com>
References: <200708201453.14641.m.gruber@tirol.com>
	 <200709041348.42229.m.gruber@tirol.com>
	 <3efb10970709050557i24dbdc3bub65a5eea249ae8f1@mail.gmail.com>
	 <200709051836.02683.m.gruber@tirol.com>
	 <3efb10970709051146r49462626h28e0febbf44282dd@mail.gmail.com>
	 <Pine.LNX.4.58.0709142213240.25727@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Manfred Gruber" <m.gruber@tirol.com>, tglx@linutronix.de,
	mingo@elte.hu, linux-rt-users@vger.kernel.org, williams@redhat.com
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:63923 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbXIOUno (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 15 Sep 2007 16:43:44 -0400
Received: by py-out-1112.google.com with SMTP id u77so2396431pyb
        for <linux-rt-users@vger.kernel.org>; Sat, 15 Sep 2007 13:43:43 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0709142213240.25727@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Steven,

Thanks for your explanation, here are my answers:

> > So, A normal (non-raw) spinlock should NOT be used here, because that
> > does would be converted to a rt-mutex, which is preemptible. If this
> > code is preemptible, it could be preempted by another user space
> > thread which could, in theory, modify the same piece of memory, and
> > thus causing a race condition.
>
> Are you talking about this code?

Yes!

>
> +       spin_lock(&futex_atomic_lock);
> +
> +       __asm__ __volatile__( "@futex_atomic_cmpxchg_inatomic   \n"
> +       "1:     ldrt    %0, [%3]                                \n"
> +       "       teq     %0, %1                                  \n"
> +       "2:     streqt  %2, [%3]                                \n"
> +       "3:                                                     \n"
> +       "       .section __ex_table, \"a\"                      \n"
> +       "       .align 3                                        \n"
> +       "       .long   1b, 4f, 2b, 4f                          \n"
> +       "       .previous                                       \n"
> +       "       .section .fixup,\"ax\"                          \n"
> +       "4:     mov     %0, %4                                  \n"
> +       "       b       3b                                      \n"
> +       "       .previous"
> +       : "=&r" (val)
> +       : "r" (oldval), "r" (newval), "r" (uaddr), "Ir" (-EFAULT)
> +       : "cc");
> +
> +       spin_unlock(&futex_atomic_lock);
>
> I don't quite remember ARM (been a few years since working with it), but
> this looks like the standard "load store-conditional", or is it simply a
> read/test/write? (I don't have a ARM book handy at the moment).

it is a read/test/write, or in other words a cmpxchg().

>
> But I would ask, what would touch that memory without first taking the
> futex_atomic_lock? So I don't understand your issue of being preempted.

AFAIK, it is user space memory, allocated in the context of a user
space process.
If this memory location is modified outside this 'protected' section,
like for example in some codepath in glibc also (e.g. futex slowpath
implementation), then this implementation could be dangerous with a
normal spinlock/rt-mutex.

>  >
> > Notice that there have been raised questions about the interrupt lock
> > while accessing user space memory in this code, it is considered as
> > not-safe.
> > AFAIK the only situation where it is not-safe, is the case where the
> > memory is not available in RAM, but e.g. somewhere in a swap space. If
> > the memory has to be paged in, probably interrupts are needed. In my
> > system things like this will never happen...
>
> That's nice, but other systems might have that happen ;-)

And that is exactly the reason, why I have questions with this implementation...


Kind Regards,

Remy
