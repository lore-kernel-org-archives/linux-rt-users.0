From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: PI mutex support on ARM
Date: Fri, 14 Sep 2007 22:23:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0709142213240.25727@gandalf.stny.rr.com>
References: <200708201453.14641.m.gruber@tirol.com>  <200709041348.42229.m.gruber@tirol.com>
  <3efb10970709050557i24dbdc3bub65a5eea249ae8f1@mail.gmail.com>
 <200709051836.02683.m.gruber@tirol.com> <3efb10970709051146r49462626h28e0febbf44282dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Manfred Gruber <m.gruber@tirol.com>, tglx@linutronix.de,
	mingo@elte.hu, linux-rt-users@vger.kernel.org, williams@redhat.com
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:49336 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbXIOCYx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Sep 2007 22:24:53 -0400
In-Reply-To: <3efb10970709051146r49462626h28e0febbf44282dd@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Wed, 5 Sep 2007, Remy Bohmer wrote:
> So, A normal (non-raw) spinlock should NOT be used here, because that
> does would be converted to a rt-mutex, which is preemptible. If this
> code is preemptible, it could be preempted by another user space
> thread which could, in theory, modify the same piece of memory, and
> thus causing a race condition.

Are you talking about this code?

+	spin_lock(&futex_atomic_lock);
+
+	__asm__ __volatile__( "@futex_atomic_cmpxchg_inatomic	\n"
+	"1:     ldrt    %0, [%3]				\n"
+	"       teq     %0, %1					\n"
+	"2:     streqt  %2, [%3]				\n"
+	"3:							\n"
+	"       .section __ex_table, \"a\"			\n"
+	"       .align 3					\n"
+	"       .long   1b, 4f, 2b, 4f				\n"
+	"       .previous					\n"
+	"       .section .fixup,\"ax\"				\n"
+	"4:     mov     %0, %4					\n"
+	"       b       3b					\n"
+	"       .previous"
+	: "=&r" (val)
+	: "r" (oldval), "r" (newval), "r" (uaddr), "Ir" (-EFAULT)
+	: "cc");
+
+	spin_unlock(&futex_atomic_lock);

I don't quite remember ARM (been a few years since working with it), but
this looks like the standard "load store-conditional", or is it simply a
read/test/write? (I don't have a ARM book handy at the moment).

But I would ask, what would touch that memory without first taking the
futex_atomic_lock? So I don't understand your issue of being preempted.

 >
> Notice that there have been raised questions about the interrupt lock
> while accessing user space memory in this code, it is considered as
> not-safe.
> AFAIK the only situation where it is not-safe, is the case where the
> memory is not available in RAM, but e.g. somewhere in a swap space. If
> the memory has to be paged in, probably interrupts are needed. In my
> system things like this will never happen...

That's nice, but other systems might have that happen ;-)

But mainly, yes, the area can be swapped out, _or_ it may not have been
allocated yet. Areas like the BSS section where variables are initialized
to zero may not have memory allocated to them until something actually
writes to it.

-- Steve
