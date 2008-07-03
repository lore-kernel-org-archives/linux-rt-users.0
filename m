From: Subrata Modak <subrata-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: New LTP test feature [Hard Real Time Linux Testing]
Date: Thu, 03 Jul 2008 17:47:53 +0530
Message-ID: <1215087479.4885.57.camel@subratamodak.linux.ibm.com>
References: <985fbaec0806160129t3673009dxb818b00fbf86080c@mail.gmail.com>
	<1213647618.4710.26.camel@subratamodak.linux.ibm.com>
	<985fbaec0806190242scfe86c7j5188725970c464e3@mail.gmail.com>
	<1214400299.10818.29.camel@subratamodak.linux.ibm.com>
	<3811280f0807011114v206c0fbbp2c3194d82c74e525@mail.gmail.com>
Reply-To: subrata-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: ltp-list <ltp-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	tinytim <tinytim-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, bastoni-+n69K+pIvRMT3tEHH5o3mg@public.gmane.org,
	linux-rt-users <linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Jean-Pierre Dion <jean-pierre.dion-6ktuUTfB/bM@public.gmane.org>,
	dvhltc <dvhltc-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>,
	Christian Di Biagio <cdibiagio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sebastien Dugue <sebastien.dugue-6ktuUTfB/bM@public.gmane.org>,
	mreed10-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dino <dino-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>,
	Jeff Burke <jburke-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, John Stultz <jstultz-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
To: Luca Recchia <lucarex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <ltp-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3811280f0807011114v206c0fbbp2c3194d82c74e525-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ltp-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ltp-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ltp-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

Thank you Luca for that wonderful explanation of the work that you are
doing. Meanwhile, i am not an expert in RT linux Kernel hard/soft. So, i
would prefer experts to comment on your proposal (Darren/others, will
you !!). I will be more interested in the test cases, automating them,
and make sure that affected parties can make the best use of it through
LTP. And the test cases helps in improving the kernel features that you
are developing. Slowly i would be working with you to integrate the test
suites to LTP, as we move ahead with comments/reviews from the experts.

On Tue, 2008-07-01 at 20:14 +0200, Luca Recchia wrote:
> Dear All,
> 
> just some details about our test.
> 
>     We're actually dealing with Hard Real-Time problems (on x86) and
> we need a way
> to measure latencies in the IRQ handling kernel flow-paths.
> We do not only need to measure the global (from the rise of an
> interrupt to its
> complete management) IRQ handling latency, but also the intermediate
> (inter-function) latency values.
> 
> Our main objective is to evaluate Hard Real-Time feautures like
> predictability
> and time latency of IRQ response and IRQ management flow.
> 
> 
>     The kernel patch and the modules we have developed are in this
> direction. The
> patch allows us to measure (with little overhead) the execution times
> between the main functions of the IRQ management flow. The modules
> read the
> values we measure and place them into proc fs (in a more readable
> manner).
> 
>     All time-values that are taken in the test are measured by reading
> the TSC
> register. Both the user space task and the kernel IRQ management
> flow-path should
> be bound on one processor, so to avoid discrepancies between different
> TSC reads
> on different CPUs.
> 
> 
>     The test is composed by a user space application which is waiting
> (with a
> blocking read on /dev/rtc) for RTC interrupts. We re-program the RTC
> device to
> launch interrupts at fixed frequency.
> 
>     First fo all the user space test application set the real time
> priority and 
> the real time policy SCHED_FIFO of the user task, then re-program the
> RTC device
> to launch interrupts at fixed frequency, and go to sleep waiting for
> RTC interrupt.
> 
> Immediately after being woke up, the user space test application
> performs a TSC read,
> which constitutes the final measure of the IRQ management flow.
> Furthermore this read
> helps in telling kernel test latencies from spurious kernel
> inter-function latencies
> that may occur before the beginning of the test.
> When the test is over the user apllication print the TSC values on the
> console.
> 
>     The patch we introduce in the kernel is able to record up to
> SAMPLES samples
> of inter-function latencies throughout the kernel path activated by
> RTC
> interrupt management flow-path.
> 
> When the test is over, it is possible to read the inter-function
> latencies
> (sampled in the kernel) through the proc fs, using "delta_read_irq"
> and "irq_latencies_tsc" modules.
> 
>     The "delta_read_irq" module is used to read the inter-function
> latencies values
> as the max, min, and total TSC cycles elapsed during the measured
> intervals.
> 
>     With the "irq_latencies_tsc" module it is possible to read the TSC
> values taken
> inside IRQ flow-path functions.
> By comparing these values with those obtained in the user space
> application, one
> can evaluate the whole latencies in the IRQ management flow (from the
> arrival
> of an hardware interrupt to the system, to the beginning of the test
> application).
> 
>     From the analisys of these results we can estimate the worst-case
> latency and
> the periodic jitter of an interrupt management flow-path.
> We are also able to evaluate the required (re)scheduling effort and
> inter-function
> latencies.
> 
> The execution-jitter of the kernel paths we analyze is our measure to
> evaluate the
> predictability of "end-to-end" IRQ management (from the arrival of an
> hardware interrupt
> to the system, to the beginning of the test application).
> 
> The measured jitter is the standard deviation of the sampled
> latencies,
> relatively to their mean.
> 
>     At the moment, we make use of a spreadsheet to evaluate
> std.deviation, worst,
> best and average inter-function and end-to-end latencies. We build
> these results
> using 1000 sampled latency values (these values are obtained through
> the module
> "irq_latencies_tsc" and through the user space application).
> 
> It is important to note that the samples we measure in the kernel are
> in clock cycle
> unit and we have to transform them into time unit. The resolution of
> the measure
> heavily depends on the CPU frequency and on the time spent in reading
> the TSC.
> We have estimate for our measure a base definition of 10 ns.
> 
>     The test is not yet automated, and doesn't respect LTP's
> requirement. At the moment it is just a quite usable tool that is

Even if it does not use LTP specific libraries, it would be OK for it to
be initially integrated to LTP. But the major(and Primary) requirement
is to automate them. And we should be able to get the output/results
automatically and should be able to analyze them in human-readable
format.

As one of my goals is to bring all Linux testing efforts under unified
umbrella, i would rather like this test suite to me maintained from LTP.
I would like to have an option where it would run this test suite along
with the default LTP together, or, each one separately depending on user
choice.
Seems that our engagement will be long.

Regards--
Subrata

>  being mainly use
> as a base comparison between Vanilla kernel and RT kernel project
> (http://www.eu.kernel.org/pub/linux/kernel/projects/rt/).
> 
> 
> 
> Regards,
> 
> Luca Recchia
> 

> 


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
