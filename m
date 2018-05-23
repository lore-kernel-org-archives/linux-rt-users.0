Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:55058 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754649AbeEWQHk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 23 May 2018 12:07:40 -0400
Date: Wed, 23 May 2018 11:07:08 -0500
From: Julia Cartwright <julia@ni.com>
Subject: Re: Non RT threads impact on RT thread
Message-ID: <20180523160708.GR1403@jcartwri.amer.corp.natinst.com>
References: <CAGiv7G3sWoamRjg=ArLRi1eYYFJLY4bZvX2VQttMsw8DuVVScA@mail.gmail.com>
 <20180522183442.GP1403@jcartwri.amer.corp.natinst.com>
 <CAGiv7G0Qd-3H6JgJAqtRNLXA-eGcQhchauXMOFPv0hSFWYDysg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGiv7G0Qd-3H6JgJAqtRNLXA-eGcQhchauXMOFPv0hSFWYDysg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Jordan Palacios <jordan.palacios@pal-robotics.com>
Cc: linux-rt-users@vger.kernel.org

On Wed, May 23, 2018 at 05:43:57PM +0200, Jordan Palacios wrote:
> Hello,
>
> Thanks for the answers.
>
> We don't have any nvidia card installed on the system.
>
> We'll try the isolcpus in conjunct with our cpuset setup and we'll
> look into the irq_smp_affinity.

Given the spike magnitudes you are seeing, I doubt they are task
migration related; meaning I don't think that isolcpus will make a
difference.

> These are some of the specs of the system. Let me know if you need
> something else that might be relevant.
>
> Active module: Congatec conga-TS77/i7-3612QE
> Carrier: Connect Tech CCG008
> DDR3L-SODIMM-1600 (8GB)
> Crucial MX200 250GB mSATA SSD
>
> I have uploaded one graph with an example of our issue here:
>
> https://i.imgur.com/8KoxzNV.png
>
> In blue the time between cycles and in green the execution time of
> each loop. X is in seconds and Y in microseconds. As you can see the
> execution time is quite constant until we run some intensive IO tasks.
> In this case those spikes are caused by a hdparm -tT /dev/sda. In this
> particular instance the spike is no issue since its less than our task
> period.

Interesting.  Does that 2-second higher-latency window directly coincide
with the starting/stopping of the hdparm load?

> The problem arises when spikes that are particularly nasty make us go
> over the 1ms limit, resulting in an overrun. Here is an example:
>
> https://i.imgur.com/77sgj3S.png
>
> Till now we have only used tracing in our example application but we
> haven't been able to draw any conclusions. I'll try to obtain a trace
> of our main update cycle when one of these spikes happen.

This would be most helpful.  The first step will be to confirm the
assumption that nothing else is executing on the CPU with this RT task.

Also, keep in mind that tracing induces some overhead, so you might need
to adjust your threshold accordingly.  I've found that most of the
latency issues I've debugged can be via the irq, sched, and timer trace
events (maybe syscalls as well) so that's where I typically start.

It may also be worth a test with a later -rt kernel series like 4.14-rt
or even 4.16-rt to see if you can reproduce the issue there.

   Julia
