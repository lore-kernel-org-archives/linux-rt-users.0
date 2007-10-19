From: Sripathi Kodi <sripathik@in.ibm.com>
Subject: Re: High 50us+ latencies in the process signal handling path
Date: Fri, 19 Oct 2007 19:50:09 +0530
Message-ID: <200710191950.11664.sripathik@in.ibm.com>
References: <20071018124827.GA22282@in.ibm.com> <4718A680.5000501@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ankita Garg <ankita@in.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Ingo Molnar <mingo@elte.hu>,
	Dinakar Guniguntala <dino@in.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>,
	Mike Kravetz <kravetz@us.ibm.com>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from E23SMTP04.au.ibm.com ([202.81.18.173]:33509 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756409AbXJSOUi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Oct 2007 10:20:38 -0400
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9JEKXd2019137
	for <linux-rt-users@vger.kernel.org>; Sat, 20 Oct 2007 00:20:33 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l9JEOAVm172068
	for <linux-rt-users@vger.kernel.org>; Sat, 20 Oct 2007 00:24:10 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l9JEHgxl025573
	for <linux-rt-users@vger.kernel.org>; Sat, 20 Oct 2007 00:17:43 +1000
In-Reply-To: <4718A680.5000501@stud.feec.vutbr.cz>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Friday 19 October 2007 18:13, Michal Schmidt wrote:
> Ankita Garg wrote:
> > Hi,
> >
> > There is a testcase called 'pthread_kill_latency' under the rt-test suite
> > on the the RT Wiki:
> >
> > http://www.kernel.org/pub/linux/kernel/people/dvhart/realtime/tests/rt-te
> >st-0.3.tar.bz2
> >
> > Description of the testcase:
> >
> > The test measures the latency involved in sending a signal to a thread
> > using pthread_kill. Two threads are created, receiver thread (thread1)
> > and sender thread (thread2). Before sending the signal, it waits for
> > thread1 to initialize (thread1 waits by calling sigwait), notes the time
> > and send pthread_kill signal to thread1. thread1 notes the time it
> > receives the signal. The maximum and the minimum latency is reported.
> > This is repeated about 10000 times.
>
> I'm looking at the source. The receiver thread runs with realtime
> priority (it's created with create_fifo_thread), but the sender thread
> (thread2) doesn't (create_other_thread). The sender does:
>
>         /* Record the time just before sending the signal */
>         begin = rt_gettime();
> /**** The sender can get preempted by anything right here ! ****/
>         if ((ret = pthread_kill(PTHREADOF(target_thread), SIGNALNUMBER))) {
>             printf("pthread_kill returned %d\n", ret);
>         }
>
> Can this explain it?

We have changed the sender to be of priority 1 less than the receiver. This 
brings down the frequency of seeing high latencies, especially if there is a 
background load, but does not eliminate them. In fact the logs Ankita posted 
were with the sender at this RT priority.

-Sripathi.

>
> Michal
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
