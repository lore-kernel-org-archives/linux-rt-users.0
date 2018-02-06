From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: nonrt behavior with GPIO interrupts
Date: Tue, 6 Feb 2018 10:51:10 -0800
Message-ID: <CANGgnMbWoSXb77+C=JOGYMSODedN-Nkr_HrK3fpf5RAfHG5Yww@mail.gmail.com>
References: <CANGgnMaxk=82VH1PLUmGKCzfhp=kvwokQ8Qy3SzLxO8hn8pQ8A@mail.gmail.com>
 <20180206162250.GA870@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: rt-users <linux-rt-users@vger.kernel.org>,
        Philipp Schrader <philipp@peloton-tech.com>,
        Alison Chaiken <alison@peloton-tech.com>,
        Brian Silverman <brian@peloton-tech.com>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:44383 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753017AbeBFSvb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Feb 2018 13:51:31 -0500
Received: by mail-yw0-f180.google.com with SMTP id x62so2063497ywg.11
        for <linux-rt-users@vger.kernel.org>; Tue, 06 Feb 2018 10:51:31 -0800 (PST)
In-Reply-To: <20180206162250.GA870@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Julia,

On Tue, Feb 6, 2018 at 8:22 AM, Julia Cartwright <julia@ni.com> wrote:
> Hello Austin-
>
> On Mon, Feb 05, 2018 at 04:24:57PM -0800, Austin Schuh wrote:
>> We are seeing nonrt behavior with GPIO interrupts using the sysfs
>> interface.  We setup the pin by setting the ".../edge" file to
>> "rising", and then use epoll to wait for a priority event on the
>> ".../value" file.
>
> What does "nonrt" behavior look like to you?

I've got a *very* well timed 1 hz square wave. (0.01 ppm)  I measured
the max and min difference between when userspace timestamped
consecutive rising edges.  (The test as run will have problems with
clock variation due to temperature compared to the input signal, but I
think those are negligible compared to the effect I'm seeing)  This
was done at a priority of 73, the highest priority task on the box.  I
also set up IRQ and task pinning so everything was on the same core,
and set the IRQ threads to be priority 73 as well.  The end result was
I would get good timing most of the time (< 10 uS), and then an
occasional very large dt (> 1 ms).

> Unfortunately, the kernels poll()/select()/epoll() code is completely
> dependent on the workqueue infrastructure, which isn't designed with RT
> in mind.  (See the documentation in include/linux/swait.h to understand
> why that's the case).  This is Problem 1.

Interesting.  Antidotally, we've seen good RT behavior (small and
bounded wakeups) with RT tasks who use epoll with a timerfd + eventfd
+ socketcan.  We've got some good instrumentation in there.  Sounds
like we have some reading to do in our future.

>> From turning on the IRQ trace events, the workqueue trace events, and
>> the scheduler trace events, it looks like the sysfs event goes through
>> a workqueue, which is SCHED_OTHER.
>
> You haven't mentioned which GPIO driver you are working with, but I
> don't think it matters.  Here the irq subsystem is jumping through two
> threads, presumably because your controller implements an irq_chip, so
> there is some chained handling handling going on.
>
> Problem 2 is that there is no PI chain between the consuming thread(s)
> (gps_main in your case) and the servicing irqthread(s).  Static
> prioritization of irqthreads is the current guidance, which is a useful
> enough proxy for most simple RT applications.

It's a TI OMAP5 based chip.  I can dig up more details, but I'm not
sure it matters.

I'm already prioritizing the IRQ threads.  This trace let me find all
the threads involved and prioritize them.

> Problem 3 is that workqueues similarly don't participate in PI.  There
> is currently no clean way to prioritize work items, as they run from a
> set of mostly arbitrary worker threads.

Yup.  This is my main concern with the path through workqueues.

> For folks who've had there hands in RT for awhile, they are known
> issues.  They are lesser known issues to new users, however.
>
> Fixing these problems is a long and complicated road, requiring either
> constructing a new abstraction (see swait for example), or augmenting
> existing abstractions to make them RT friendly.
>
>    Julia

Sounds like this is known then and tricky to fix.  I've been around
long enough to know some of the problems but not all of them.  Thanks
for your reply!

Austin
