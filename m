From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: preempt-rt: Real Time hogging task
Date: Thu, 02 Feb 2012 09:12:04 -0500
Message-ID: <1328191924.5882.86.camel@gandalf.stny.rr.com>
References: <CAPB=Z-r+3ht0Au3mvrUBQ7-g+r=QfLao19BF7n97662q52fxKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Raz <raziebe@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:56615 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756132Ab2BBOMG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Feb 2012 09:12:06 -0500
In-Reply-To: <CAPB=Z-r+3ht0Au3mvrUBQ7-g+r=QfLao19BF7n97662q52fxKg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2012-02-02 at 12:52 +0200, Raz wrote:
> hey
> 
> I am trying to understand why a user space MT process behaves in an
> unexpected manner.
> I have real time process, which executes most of its threads in RT priority,
> and from time to time a task ( medium priority ) is executing without
> trying to stop.
> 
> There are times, that this task is hogging the entire process and no
> other **higher*** rt priority
> task is getting any cpu time.
> 
> Linux is **not** getting hogged. when setting the serial console (
> irq/serial ) and its shell ( /bin/sh )
> to a higher priority linux is responsive.
> 
> Observing the task list  through ps command i can see that this task's
> threads when
> to un-interruptible sleep.
> 
> Any idea why is it happening ?

Some ideas, but I need a lot more information.

> kernel is 3.2.0-rc5-rt8.

Is this a x86 box?

Can you run a trace on the task that is going berserk?

Enable CONFIG_FUNCTION_TRACER in your kernel and do the following:

# mount -t debugfs nodev /sys/kernel/debug
# cd /sys/kernel/debug/tracing
# echo <pid-of-berserk-task> > set_ftrace_pid
# echo function > current_tracer
# cat trace

Thanks!

-- Steve


