From: "Christian Di Biagio" <cdibiagio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: New LTP test feature [Hard Real Time Linux Testing]
Date: Tue, 15 Jul 2008 11:31:28 +0200
Message-ID: <985fbaec0807150231i3e2ed0fcjd3dfd6e44c6ab5ba@mail.gmail.com>
References: <985fbaec0806160129t3673009dxb818b00fbf86080c@mail.gmail.com>
	<1213647618.4710.26.camel@subratamodak.linux.ibm.com>
	<985fbaec0806190242scfe86c7j5188725970c464e3@mail.gmail.com>
	<1214400299.10818.29.camel@subratamodak.linux.ibm.com>
	<3811280f0807011114v206c0fbbp2c3194d82c74e525@mail.gmail.com>
	<1215087479.4885.57.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2043332827=="
Cc: Luca Recchia <lucarex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	ltp-list <ltp-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	tinytim <tinytim-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, bastoni-+n69K+pIvRMT3tEHH5o3mg@public.gmane.org,
	linux-rt-users <linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	dvhltc <dvhltc-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, dino <dino-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>,
	Sebastien Dugue <sebastien.dugue-6ktuUTfB/bM@public.gmane.org>,
	mreed10-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Jean-Pierre Dion <jean-pierre.dion-6ktuUTfB/bM@public.gmane.org>,
	John Stultz <jstultz-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Jeff Burke <jburke-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
To: subrata-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
Return-path: <ltp-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1215087479.4885.57.camel-NRFfyExJdYpgXGGE5LP+UZlqa2bBAFbm0E9HWUfgJXw@public.gmane.org>
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

--===============2043332827==
Content-Type: multipart/alternative;
	boundary="----=_Part_2196_22815232.1216114288303"

------=_Part_2196_22815232.1216114288303
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Darren/others, any comments?
We wish you send us a feedback in order to automate HRT test suitable for
LTP and start the integration.

Best regards.

Christian

2008/7/3 Subrata Modak <subrata-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>:

> Thank you Luca for that wonderful explanation of the work that you are
> doing. Meanwhile, i am not an expert in RT linux Kernel hard/soft. So, i
> would prefer experts to comment on your proposal (Darren/others, will
> you !!). I will be more interested in the test cases, automating them,
> and make sure that affected parties can make the best use of it through
> LTP. And the test cases helps in improving the kernel features that you
> are developing. Slowly i would be working with you to integrate the test
> suites to LTP, as we move ahead with comments/reviews from the experts.
>
> On Tue, 2008-07-01 at 20:14 +0200, Luca Recchia wrote:
> > Dear All,
> >
> > just some details about our test.
> >
> >     We're actually dealing with Hard Real-Time problems (on x86) and
> > we need a way
> > to measure latencies in the IRQ handling kernel flow-paths.
> > We do not only need to measure the global (from the rise of an
> > interrupt to its
> > complete management) IRQ handling latency, but also the intermediate
> > (inter-function) latency values.
> >
> > Our main objective is to evaluate Hard Real-Time feautures like
> > predictability
> > and time latency of IRQ response and IRQ management flow.
> >
> >
> >     The kernel patch and the modules we have developed are in this
> > direction. The
> > patch allows us to measure (with little overhead) the execution times
> > between the main functions of the IRQ management flow. The modules
> > read the
> > values we measure and place them into proc fs (in a more readable
> > manner).
> >
> >     All time-values that are taken in the test are measured by reading
> > the TSC
> > register. Both the user space task and the kernel IRQ management
> > flow-path should
> > be bound on one processor, so to avoid discrepancies between different
> > TSC reads
> > on different CPUs.
> >
> >
> >     The test is composed by a user space application which is waiting
> > (with a
> > blocking read on /dev/rtc) for RTC interrupts. We re-program the RTC
> > device to
> > launch interrupts at fixed frequency.
> >
> >     First fo all the user space test application set the real time
> > priority and
> > the real time policy SCHED_FIFO of the user task, then re-program the
> > RTC device
> > to launch interrupts at fixed frequency, and go to sleep waiting for
> > RTC interrupt.
> >
> > Immediately after being woke up, the user space test application
> > performs a TSC read,
> > which constitutes the final measure of the IRQ management flow.
> > Furthermore this read
> > helps in telling kernel test latencies from spurious kernel
> > inter-function latencies
> > that may occur before the beginning of the test.
> > When the test is over the user apllication print the TSC values on the
> > console.
> >
> >     The patch we introduce in the kernel is able to record up to
> > SAMPLES samples
> > of inter-function latencies throughout the kernel path activated by
> > RTC
> > interrupt management flow-path.
> >
> > When the test is over, it is possible to read the inter-function
> > latencies
> > (sampled in the kernel) through the proc fs, using "delta_read_irq"
> > and "irq_latencies_tsc" modules.
> >
> >     The "delta_read_irq" module is used to read the inter-function
> > latencies values
> > as the max, min, and total TSC cycles elapsed during the measured
> > intervals.
> >
> >     With the "irq_latencies_tsc" module it is possible to read the TSC
> > values taken
> > inside IRQ flow-path functions.
> > By comparing these values with those obtained in the user space
> > application, one
> > can evaluate the whole latencies in the IRQ management flow (from the
> > arrival
> > of an hardware interrupt to the system, to the beginning of the test
> > application).
> >
> >     From the analisys of these results we can estimate the worst-case
> > latency and
> > the periodic jitter of an interrupt management flow-path.
> > We are also able to evaluate the required (re)scheduling effort and
> > inter-function
> > latencies.
> >
> > The execution-jitter of the kernel paths we analyze is our measure to
> > evaluate the
> > predictability of "end-to-end" IRQ management (from the arrival of an
> > hardware interrupt
> > to the system, to the beginning of the test application).
> >
> > The measured jitter is the standard deviation of the sampled
> > latencies,
> > relatively to their mean.
> >
> >     At the moment, we make use of a spreadsheet to evaluate
> > std.deviation, worst,
> > best and average inter-function and end-to-end latencies. We build
> > these results
> > using 1000 sampled latency values (these values are obtained through
> > the module
> > "irq_latencies_tsc" and through the user space application).
> >
> > It is important to note that the samples we measure in the kernel are
> > in clock cycle
> > unit and we have to transform them into time unit. The resolution of
> > the measure
> > heavily depends on the CPU frequency and on the time spent in reading
> > the TSC.
> > We have estimate for our measure a base definition of 10 ns.
> >
> >     The test is not yet automated, and doesn't respect LTP's
> > requirement. At the moment it is just a quite usable tool that is
>
> Even if it does not use LTP specific libraries, it would be OK for it to
> be initially integrated to LTP. But the major(and Primary) requirement
> is to automate them. And we should be able to get the output/results
> automatically and should be able to analyze them in human-readable
> format.
>
> As one of my goals is to bring all Linux testing efforts under unified
> umbrella, i would rather like this test suite to me maintained from LTP.
> I would like to have an option where it would run this test suite along
> with the default LTP together, or, each one separately depending on user
> choice.
> Seems that our engagement will be long.
>
> Regards--
> Subrata
>
> >  being mainly use
> > as a base comparison between Vanilla kernel and RT kernel project
> > (http://www.eu.kernel.org/pub/linux/kernel/projects/rt/).
> >
> >
> >
> > Regards,
> >
> > Luca Recchia
> >
>
> >
>
>

------=_Part_2196_22815232.1216114288303
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Darren/others, any comments? <br>We wish you send us a feedback in order to automate HRT test suitable for LTP and start the integration.<br><br>Best regards.<br><br>Christian<br><br><div class="gmail_quote">
2008/7/3 Subrata Modak &lt;<a href="mailto:subrata-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org">subrata-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org</a>&gt;:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Thank you Luca for that wonderful explanation of the work that you are<br>
doing. Meanwhile, i am not an expert in RT linux Kernel hard/soft. So, i<br>
would prefer experts to comment on your proposal (Darren/others, will<br>
you !!). I will be more interested in the test cases, automating them,<br>
and make sure that affected parties can make the best use of it through<br>
LTP. And the test cases helps in improving the kernel features that you<br>
are developing. Slowly i would be working with you to integrate the test<br>
suites to LTP, as we move ahead with comments/reviews from the experts.<br>
<div><div></div><div class="Wj3C7c"><br>
On Tue, 2008-07-01 at 20:14 +0200, Luca Recchia wrote:<br>
&gt; Dear All,<br>
&gt;<br>
&gt; just some details about our test.<br>
&gt;<br>
&gt; &nbsp; &nbsp; We&#39;re actually dealing with Hard Real-Time problems (on x86) and<br>
&gt; we need a way<br>
&gt; to measure latencies in the IRQ handling kernel flow-paths.<br>
&gt; We do not only need to measure the global (from the rise of an<br>
&gt; interrupt to its<br>
&gt; complete management) IRQ handling latency, but also the intermediate<br>
&gt; (inter-function) latency values.<br>
&gt;<br>
&gt; Our main objective is to evaluate Hard Real-Time feautures like<br>
&gt; predictability<br>
&gt; and time latency of IRQ response and IRQ management flow.<br>
&gt;<br>
&gt;<br>
&gt; &nbsp; &nbsp; The kernel patch and the modules we have developed are in this<br>
&gt; direction. The<br>
&gt; patch allows us to measure (with little overhead) the execution times<br>
&gt; between the main functions of the IRQ management flow. The modules<br>
&gt; read the<br>
&gt; values we measure and place them into proc fs (in a more readable<br>
&gt; manner).<br>
&gt;<br>
&gt; &nbsp; &nbsp; All time-values that are taken in the test are measured by reading<br>
&gt; the TSC<br>
&gt; register. Both the user space task and the kernel IRQ management<br>
&gt; flow-path should<br>
&gt; be bound on one processor, so to avoid discrepancies between different<br>
&gt; TSC reads<br>
&gt; on different CPUs.<br>
&gt;<br>
&gt;<br>
&gt; &nbsp; &nbsp; The test is composed by a user space application which is waiting<br>
&gt; (with a<br>
&gt; blocking read on /dev/rtc) for RTC interrupts. We re-program the RTC<br>
&gt; device to<br>
&gt; launch interrupts at fixed frequency.<br>
&gt;<br>
&gt; &nbsp; &nbsp; First fo all the user space test application set the real time<br>
&gt; priority and<br>
&gt; the real time policy SCHED_FIFO of the user task, then re-program the<br>
&gt; RTC device<br>
&gt; to launch interrupts at fixed frequency, and go to sleep waiting for<br>
&gt; RTC interrupt.<br>
&gt;<br>
&gt; Immediately after being woke up, the user space test application<br>
&gt; performs a TSC read,<br>
&gt; which constitutes the final measure of the IRQ management flow.<br>
&gt; Furthermore this read<br>
&gt; helps in telling kernel test latencies from spurious kernel<br>
&gt; inter-function latencies<br>
&gt; that may occur before the beginning of the test.<br>
&gt; When the test is over the user apllication print the TSC values on the<br>
&gt; console.<br>
&gt;<br>
&gt; &nbsp; &nbsp; The patch we introduce in the kernel is able to record up to<br>
&gt; SAMPLES samples<br>
&gt; of inter-function latencies throughout the kernel path activated by<br>
&gt; RTC<br>
&gt; interrupt management flow-path.<br>
&gt;<br>
&gt; When the test is over, it is possible to read the inter-function<br>
&gt; latencies<br>
&gt; (sampled in the kernel) through the proc fs, using &quot;delta_read_irq&quot;<br>
&gt; and &quot;irq_latencies_tsc&quot; modules.<br>
&gt;<br>
&gt; &nbsp; &nbsp; The &quot;delta_read_irq&quot; module is used to read the inter-function<br>
&gt; latencies values<br>
&gt; as the max, min, and total TSC cycles elapsed during the measured<br>
&gt; intervals.<br>
&gt;<br>
&gt; &nbsp; &nbsp; With the &quot;irq_latencies_tsc&quot; module it is possible to read the TSC<br>
&gt; values taken<br>
&gt; inside IRQ flow-path functions.<br>
&gt; By comparing these values with those obtained in the user space<br>
&gt; application, one<br>
&gt; can evaluate the whole latencies in the IRQ management flow (from the<br>
&gt; arrival<br>
&gt; of an hardware interrupt to the system, to the beginning of the test<br>
&gt; application).<br>
&gt;<br>
&gt; &nbsp; &nbsp; From the analisys of these results we can estimate the worst-case<br>
&gt; latency and<br>
&gt; the periodic jitter of an interrupt management flow-path.<br>
&gt; We are also able to evaluate the required (re)scheduling effort and<br>
&gt; inter-function<br>
&gt; latencies.<br>
&gt;<br>
&gt; The execution-jitter of the kernel paths we analyze is our measure to<br>
&gt; evaluate the<br>
&gt; predictability of &quot;end-to-end&quot; IRQ management (from the arrival of an<br>
&gt; hardware interrupt<br>
&gt; to the system, to the beginning of the test application).<br>
&gt;<br>
&gt; The measured jitter is the standard deviation of the sampled<br>
&gt; latencies,<br>
&gt; relatively to their mean.<br>
&gt;<br>
&gt; &nbsp; &nbsp; At the moment, we make use of a spreadsheet to evaluate<br>
&gt; std.deviation, worst,<br>
&gt; best and average inter-function and end-to-end latencies. We build<br>
&gt; these results<br>
&gt; using 1000 sampled latency values (these values are obtained through<br>
&gt; the module<br>
&gt; &quot;irq_latencies_tsc&quot; and through the user space application).<br>
&gt;<br>
&gt; It is important to note that the samples we measure in the kernel are<br>
&gt; in clock cycle<br>
&gt; unit and we have to transform them into time unit. The resolution of<br>
&gt; the measure<br>
&gt; heavily depends on the CPU frequency and on the time spent in reading<br>
&gt; the TSC.<br>
&gt; We have estimate for our measure a base definition of 10 ns.<br>
&gt;<br>
&gt; &nbsp; &nbsp; The test is not yet automated, and doesn&#39;t respect LTP&#39;s<br>
&gt; requirement. At the moment it is just a quite usable tool that is<br>
<br>
</div></div>Even if it does not use LTP specific libraries, it would be OK for it to<br>
be initially integrated to LTP. But the major(and Primary) requirement<br>
is to automate them. And we should be able to get the output/results<br>
automatically and should be able to analyze them in human-readable<br>
format.<br>
<br>
As one of my goals is to bring all Linux testing efforts under unified<br>
umbrella, i would rather like this test suite to me maintained from LTP.<br>
I would like to have an option where it would run this test suite along<br>
with the default LTP together, or, each one separately depending on user<br>
choice.<br>
Seems that our engagement will be long.<br>
<br>
Regards--<br>
<font color="#888888">Subrata<br>
</font><div><div></div><div class="Wj3C7c"><br>
&gt; &nbsp;being mainly use<br>
&gt; as a base comparison between Vanilla kernel and RT kernel project<br>
&gt; (<a href="http://www.eu.kernel.org/pub/linux/kernel/projects/rt/" target="_blank">http://www.eu.kernel.org/pub/linux/kernel/projects/rt/</a>).<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Regards,<br>
&gt;<br>
&gt; Luca Recchia<br>
&gt;<br>
<br>
&gt;<br>
<br>
</div></div></blockquote></div><br></div>

------=_Part_2196_22815232.1216114288303--


--===============2043332827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============2043332827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2043332827==--
