From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: High 50us+ latencies in the process signal handling path
Date: Fri, 19 Oct 2007 14:43:44 +0200
Message-ID: <4718A680.5000501@stud.feec.vutbr.cz>
References: <20071018124827.GA22282@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Ingo Molnar <mingo@elte.hu>,
	Dinakar Guniguntala <dino@in.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>,
	Mike Kravetz <kravetz@us.ibm.com>
To: Ankita Garg <ankita@in.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:44703 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958AbXJSMoz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Oct 2007 08:44:55 -0400
In-Reply-To: <20071018124827.GA22282@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ankita Garg wrote:
> Hi,
>
> There is a testcase called 'pthread_kill_latency' under the rt-test suite 
> on the the RT Wiki:
>
> http://www.kernel.org/pub/linux/kernel/people/dvhart/realtime/tests/rt-test-0.3.tar.bz2
>
> Description of the testcase: 
>
> The test measures the latency involved in sending a signal to a thread 
> using pthread_kill. Two threads are created, receiver thread (thread1) 
> and sender thread (thread2). Before sending the signal, it waits for 
> thread1 to initialize (thread1 waits by calling sigwait), notes the time and
> send pthread_kill signal to thread1. thread1 notes the time it receives the
> signal. The maximum and the minimum latency is reported. This is repeated
> about 10000 times.
>   

I'm looking at the source. The receiver thread runs with realtime 
priority (it's created with create_fifo_thread), but the sender thread 
(thread2) doesn't (create_other_thread). The sender does:

        /* Record the time just before sending the signal */
        begin = rt_gettime();
/**** The sender can get preempted by anything right here ! ****/
        if ((ret = pthread_kill(PTHREADOF(target_thread), SIGNALNUMBER))) {
            printf("pthread_kill returned %d\n", ret);
        }

Can this explain it?

Michal
