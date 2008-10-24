From: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: Re: [LTP] New LTP test feature [Hard Real Time Linux Testing]
Date: Fri, 24 Oct 2008 14:36:28 +0530
Message-ID: <1224839194.5270.55.camel@subratamodak.linux.ibm.com>
References: <985fbaec0806160129t3673009dxb818b00fbf86080c@mail.gmail.com>
	 <1213647618.4710.26.camel@subratamodak.linux.ibm.com>
	 <985fbaec0806190242scfe86c7j5188725970c464e3@mail.gmail.com>
	 <1214400299.10818.29.camel@subratamodak.linux.ibm.com>
	 <3811280f0807011114v206c0fbbp2c3194d82c74e525@mail.gmail.com>
	 <1215087479.4885.57.camel@subratamodak.linux.ibm.com>
	 <985fbaec0807150231i3e2ed0fcjd3dfd6e44c6ab5ba@mail.gmail.com>
	 <4900A963.2060601@us.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Luca Recchia <lucarex@gmail.com>,
	ltp-list <ltp-list@lists.sourceforge.net>,
	tinytim <tinytim@us.ibm.com>, bastoni@sprg.uniroma2.it,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	dvhltc <dvhltc@linux.vnet.ibm.com>,
	dino <dino@linux.vnet.ibm.com>,
	Sebastien Dugue <sebastien.dugue@bull.net>,
	mreed10@users.sourceforge.net,
	Jean-Pierre Dion <jean-pierre.dion@bull.net>,
	John Stultz <jstultz@us.ibm.com>,
	Jeff Burke <jburke@redhat.com>, Darren Hart <dvhltc@us.ibm.com>
To: Christian Di Biagio <cdibiagio@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:46463 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbYJXJGl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Oct 2008 05:06:41 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9O96ej6029969
	for <linux-rt-users@vger.kernel.org>; Fri, 24 Oct 2008 05:06:40 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id m9O96eSu105518
	for <linux-rt-users@vger.kernel.org>; Fri, 24 Oct 2008 03:06:40 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m9O969Qc026434
	for <linux-rt-users@vger.kernel.org>; Fri, 24 Oct 2008 03:06:11 -0600
In-Reply-To: <4900A963.2060601@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Christian,

On Thu, 2008-10-23 at 09:42 -0700, Darren Hart wrote:
> Christian Di Biagio wrote:
> > Darren/others, any comments?
> > We wish you send us a feedback in order to automate HRT test suitable 
> > for LTP and start the integration.
> > 
> 
> Right. Fell off the stack.
> 
> OK so.
> 
> 1) There are no other tests in LTP that require a kernel patch.  This
>     will be a maintenance nightmare as LTP is intended to run and most
>     any kernel.
> 2) This appears to be more of an instrumentation package than a
>     functional test or benchmark.  In this sense it doesn't seem
>     appropriate for LTP to me.
> 3) It is specific to x86, and makes use of the TSC.
> 4) This implements yet-another-tracing-mechanism.  With the recent work
>     on the unified tracing buffer, ftrace, llng, etc, it seems to me that
>     it wouldn't be a good idea for LTP to try and maintain a test the
>     rolls their own.
> 
> For these reasons, I think this tool (not test) would be best maintained
> by as an independent project.  I'd suggest starting a new project on 
> sourceforge, add it the rt wiki rt.wiki.kernel.org (I maintain that, so 
> I can help there) and mention it on the rt users mailing list.

Lets do this. Thanks for showing your interest in having these tests in
LTP. You can always send us patches for the RT tests already existing in
LTP.

Regards--
Subrata
> 
> If interest in this tool is significant and others would like to see it
> incorporated into LTP, we can revisit it.
> 
> Thanks,
> 
> Darren
> 
> > Best regards.
> > 
> > Christian
> > 
> > 2008/7/3 Subrata Modak <subrata@linux.vnet.ibm.com 
> > <mailto:subrata@linux.vnet.ibm.com>>:
> > 
> >     Thank you Luca for that wonderful explanation of the work that you are
> >     doing. Meanwhile, i am not an expert in RT linux Kernel hard/soft. So, i
> >     would prefer experts to comment on your proposal (Darren/others, will
> >     you !!). I will be more interested in the test cases, automating them,
> >     and make sure that affected parties can make the best use of it through
> >     LTP. And the test cases helps in improving the kernel features that you
> >     are developing. Slowly i would be working with you to integrate the test
> >     suites to LTP, as we move ahead with comments/reviews from the experts.
> > 
> >     On Tue, 2008-07-01 at 20:14 +0200, Luca Recchia wrote:
> >      > Dear All,
> >      >
> >      > just some details about our test.
> >      >
> >      >     We're actually dealing with Hard Real-Time problems (on x86) and
> >      > we need a way
> >      > to measure latencies in the IRQ handling kernel flow-paths.
> >      > We do not only need to measure the global (from the rise of an
> >      > interrupt to its
> >      > complete management) IRQ handling latency, but also the intermediate
> >      > (inter-function) latency values.
> >      >
> >      > Our main objective is to evaluate Hard Real-Time feautures like
> >      > predictability
> >      > and time latency of IRQ response and IRQ management flow.
> >      >
> >      >
> >      >     The kernel patch and the modules we have developed are in this
> >      > direction. The
> >      > patch allows us to measure (with little overhead) the execution times
> >      > between the main functions of the IRQ management flow. The modules
> >      > read the
> >      > values we measure and place them into proc fs (in a more readable
> >      > manner).
> >      >
> >      >     All time-values that are taken in the test are measured by
> >     reading
> >      > the TSC
> >      > register. Both the user space task and the kernel IRQ management
> >      > flow-path should
> >      > be bound on one processor, so to avoid discrepancies between
> >     different
> >      > TSC reads
> >      > on different CPUs.
> >      >
> >      >
> >      >     The test is composed by a user space application which is waiting
> >      > (with a
> >      > blocking read on /dev/rtc) for RTC interrupts. We re-program the RTC
> >      > device to
> >      > launch interrupts at fixed frequency.
> >      >
> >      >     First fo all the user space test application set the real time
> >      > priority and
> >      > the real time policy SCHED_FIFO of the user task, then re-program the
> >      > RTC device
> >      > to launch interrupts at fixed frequency, and go to sleep waiting for
> >      > RTC interrupt.
> >      >
> >      > Immediately after being woke up, the user space test application
> >      > performs a TSC read,
> >      > which constitutes the final measure of the IRQ management flow.
> >      > Furthermore this read
> >      > helps in telling kernel test latencies from spurious kernel
> >      > inter-function latencies
> >      > that may occur before the beginning of the test.
> >      > When the test is over the user apllication print the TSC values
> >     on the
> >      > console.
> >      >
> >      >     The patch we introduce in the kernel is able to record up to
> >      > SAMPLES samples
> >      > of inter-function latencies throughout the kernel path activated by
> >      > RTC
> >      > interrupt management flow-path.
> >      >
> >      > When the test is over, it is possible to read the inter-function
> >      > latencies
> >      > (sampled in the kernel) through the proc fs, using "delta_read_irq"
> >      > and "irq_latencies_tsc" modules.
> >      >
> >      >     The "delta_read_irq" module is used to read the inter-function
> >      > latencies values
> >      > as the max, min, and total TSC cycles elapsed during the measured
> >      > intervals.
> >      >
> >      >     With the "irq_latencies_tsc" module it is possible to read
> >     the TSC
> >      > values taken
> >      > inside IRQ flow-path functions.
> >      > By comparing these values with those obtained in the user space
> >      > application, one
> >      > can evaluate the whole latencies in the IRQ management flow (from the
> >      > arrival
> >      > of an hardware interrupt to the system, to the beginning of the test
> >      > application).
> >      >
> >      >     From the analisys of these results we can estimate the worst-case
> >      > latency and
> >      > the periodic jitter of an interrupt management flow-path.
> >      > We are also able to evaluate the required (re)scheduling effort and
> >      > inter-function
> >      > latencies.
> >      >
> >      > The execution-jitter of the kernel paths we analyze is our measure to
> >      > evaluate the
> >      > predictability of "end-to-end" IRQ management (from the arrival of an
> >      > hardware interrupt
> >      > to the system, to the beginning of the test application).
> >      >
> >      > The measured jitter is the standard deviation of the sampled
> >      > latencies,
> >      > relatively to their mean.
> >      >
> >      >     At the moment, we make use of a spreadsheet to evaluate
> >      > std.deviation, worst,
> >      > best and average inter-function and end-to-end latencies. We build
> >      > these results
> >      > using 1000 sampled latency values (these values are obtained through
> >      > the module
> >      > "irq_latencies_tsc" and through the user space application).
> >      >
> >      > It is important to note that the samples we measure in the kernel are
> >      > in clock cycle
> >      > unit and we have to transform them into time unit. The resolution of
> >      > the measure
> >      > heavily depends on the CPU frequency and on the time spent in reading
> >      > the TSC.
> >      > We have estimate for our measure a base definition of 10 ns.
> >      >
> >      >     The test is not yet automated, and doesn't respect LTP's
> >      > requirement. At the moment it is just a quite usable tool that is
> > 
> >     Even if it does not use LTP specific libraries, it would be OK for it to
> >     be initially integrated to LTP. But the major(and Primary) requirement
> >     is to automate them. And we should be able to get the output/results
> >     automatically and should be able to analyze them in human-readable
> >     format.
> > 
> >     As one of my goals is to bring all Linux testing efforts under unified
> >     umbrella, i would rather like this test suite to me maintained from LTP.
> >     I would like to have an option where it would run this test suite along
> >     with the default LTP together, or, each one separately depending on user
> >     choice.
> >     Seems that our engagement will be long.
> > 
> >     Regards--
> >     Subrata
> > 
> >      >  being mainly use
> >      > as a base comparison between Vanilla kernel and RT kernel project
> >      > (http://www.eu.kernel.org/pub/linux/kernel/projects/rt/).
> >      >
> >      >
> >      >
> >      > Regards,
> >      >
> >      > Luca Recchia
> >      >
> > 
> >      >
> > 
> > 
> > 
> > ------------------------------------------------------------------------
> > 
> > -------------------------------------------------------------------------
> > This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> > Build the coolest Linux based applications with Moblin SDK & win great prizes
> > Grand prize is a trip for two to an Open Source event anywhere in the world
> > http://moblin-contest.org/redirect.php?banner_id=100&url=/
> > 
> > 
> > ------------------------------------------------------------------------
> > 
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> 

