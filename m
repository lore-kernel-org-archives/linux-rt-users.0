From: Joel Fernandes <agnel.joel@gmail.com>
Subject: RFC on fixing mutex spinning on owner
Date: Wed, 16 Mar 2016 16:22:17 -0700
Message-ID: <CAD=GYpbHjcsuQSnNPL4SCv-r=Me6oiH7dJ98a64udbakWLaUjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernelnewbies <kernelnewbies@nl.linux.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36541 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933264AbcCPXWT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Mar 2016 19:22:19 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On a fairly recent kernel and android userspace, I am seeing that with
i915 driver is in a spin loop waiting for mutex owner to release it
(mutex_spin_on_owner). I believe this because the owner of the mutex
is running on another CPU and the expectation is the mutex owner
releases the mutex or goes to sleep soon, so we avoid sleeping if we
fail to acquire mutex and continue to spin and try to acquire it much
like a spinlock (while disabling preemption through out the spinning).

My question is, what if the owner cannot or doesn't want to sleep and
holds the mutex runs for a while while holding it. (Lets also assume
that all other tasks are sleeping on the mutex owner's CPU so its not
preempted).

In this case, does it make sense to time out the spinning after a
while? Because preemption is disabled during the spinning so this
spinning business seems a very very bad thing.

Should the code holding the mutex and running (the owner) be fixed to
not hold mutex for a while? Or would a patch introducing a timeout of
a certain threshold on the spinning be welcomed?

To give numbers, I am seeing spinning of as long as 20 ms in the worst
case, while the mutex owner holds the mutex for 22 ms. The ftrace
preemptoff tracer goes off.

Thanks for any advice on what the right fix of the problem should be.

Best,
Joel
