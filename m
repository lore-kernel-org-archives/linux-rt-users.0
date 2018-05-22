Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:51066 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751390AbeEVSq0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 22 May 2018 14:46:26 -0400
Date: Tue, 22 May 2018 13:34:42 -0500
From: Julia Cartwright <julia@ni.com>
Subject: Re: Non RT threads impact on RT thread
Message-ID: <20180522183442.GP1403@jcartwri.amer.corp.natinst.com>
References: <CAGiv7G3sWoamRjg=ArLRi1eYYFJLY4bZvX2VQttMsw8DuVVScA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGiv7G3sWoamRjg=ArLRi1eYYFJLY4bZvX2VQttMsw8DuVVScA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Jordan Palacios <jordan.palacios@pal-robotics.com>
Cc: linux-rt-users@vger.kernel.org

On Tue, May 22, 2018 at 12:00:27PM +0200, Jordan Palacios wrote:
> Hello,

Hello Jordan-

> We are currently running a version of the linux kernel (3.18.24) with
> the RT-PREEMPT patch. In our system there are several non RT tasks and
> one RT task. The RT process runs in the FIFO scheduler with 95
> priority and a control loop of 1ms.
>
> We have achieved latencies of about 5us which are perfect for us.
>
> Our issue is that the RT task sometimes misses one of its cycles due
> to an unexpected very long execution time of its control loop. In our
> system this is a critical failure.
>
> We enabled tracing in the kernel and started measuring the execution
> time of the RT thread. The execution time is quite constant (about
> 200us), which random spikes every now and then. Thing is, the less non
> RT tasks running in the system the better the RT task behaves.
>
> We wrote a very simple RT application that does some light work and
> writes its execution time using the trace_marker. Execution time is
> constant but IO intensive stuff, like a stress --io 32 or a hdparm,
> will have and impact on its execution time. This is surprising because
> the test does not any kind of work related to IO. Nor does the RT task
> in our system for that matter.

You haven't specified anything about your hardware setup, nor any
numbers here showing the magnitude of these latency spikes.  Could you
elaborate?

> Our question is: Is this behaviour normal? Why are non RT tasks
> affecting the RT task performance?  Is there any other kind of test
> that we could run that would shed some light on this issue?

I think it's "normal" that there will be _some_ impact from non-RT
tasks.  Even across CPUs in the case where CPUs share some level of
cache.  The question is what magnitude of impact should be expected.

Another thing you might want to look at is irq_smp_affinity, in the case
where your RT task is still serving interrupts it should not be.

Your test already has some scaffolding for tracing.  Start a run with
tracing enabled and stop tracing once you observe a latency larger than
expected; dump the trace buffer; inspect.

  Julia
