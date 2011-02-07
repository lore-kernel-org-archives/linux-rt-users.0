From: Peter LaDow <petela@gocougs.wsu.edu>
Subject: Jitter Due to Large Number of Timers
Date: Mon, 7 Feb 2011 10:48:27 -0800
Message-ID: <AANLkTimujobcDdW6oX2U2Bnn5kOU_aSDTpHhMiAOv0V1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51510 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335Ab1BGSs2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Feb 2011 13:48:28 -0500
Received: by iwn9 with SMTP id 9so4883447iwn.19
        for <linux-rt-users@vger.kernel.org>; Mon, 07 Feb 2011 10:48:28 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are measure large amounts of jitter on our PPC platform when there
are a large number of hrtimers.  This jitter is present regardless of
the priority of the tasks that depend upon those timers, and higher
(indeed the highest) priority tasks exhibit large jitter.  We've
created some test code for measuring this jitter and could really use
some insight from the RT experts here.  Here's our test setup.

We have a small C program that has a calibrated while loop that takes
approximately 4ms to execute.  For example, on our platform, it takes
just about 4ms to execute (call this 'test1'):

  float val = 1.234;

  for(i=0; i < 100000; i++)
  {
    val *= 12.354;
  }

We call clock_gettime() before and after this loop, then measure the
difference.  When running on a system with few hrtimers (about 6), we
get just about 4ms.  The problem appears when we add other
processes/threads that make use of hrtimers.  To test this, we created
another test program (call this 'test100') that creates 100 threads,
and each call clock_nanosleep() with a 4ms timeout.  When the number
of hrtimers spike, all with close expiration, the jitter on 'test1'
exceeds 400us, about 10%.  We run 'test1' with SCHED_FIFO at priority
99, and 'test100' under the default scheduler.  Here's some results:

Baseline:
  test100 not running
  /proc/timer_list showing 9 timers
  test1 run as 'chrt -f 99 ./test'

  Average: 3.817ms, Maximum: 3.859ms, Minimum: 3.809ms

Under load:
  test100 running as './test100'
  test1 run as 'chrt -f 99 ./test'

  Average: 4.168ms, Maximum: 4.204ms, Minimum: 3.585ms

We see a spike of 387us from the average (3.817ms baseline to 4.204ms
maximum).  And it is worse in our real system, since these other tasks
are also running as SCHED_FIFO.  This is problematic for our system,
because our highest priority task must complete in a fixed minimum
time.  But when these other tasks (all of which use clock_nanosleep()
or nanosleep()) are running, the excessive jitter breaks things.

Now, we supposed our highest priority task would not be interrupted by
lower priority tasks.  And indeed, they don't seem to be.  However, it
seems that the processing of a large number of hrtimers by the kernel
is starving our task of time.  How the hrtimers are implemented, and
how the kernel reacts to multiple timers expiring (or have expired)
isn't clear to us.

Any insight on the source of this jitter, and how to solve it would be
greatly appreciated.  We are running 2.6.29.3-rt13, but we have tried
it on 2.6.33.7.2-rt30.  Or platform is a MPC8349 at 533MHz.

Thanks,
Pete LaDow
