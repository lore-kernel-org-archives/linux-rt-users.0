From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: High 50us+ latencies in the process signal handling path
Date: Fri, 19 Oct 2007 08:53:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710190852250.28232@gandalf.stny.rr.com>
References: <20071018124827.GA22282@in.ibm.com> <4718A680.5000501@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ankita Garg <ankita@in.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Ingo Molnar <mingo@elte.hu>,
	Dinakar Guniguntala <dino@in.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>,
	Mike Kravetz <kravetz@us.ibm.com>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:55554 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755886AbXJSMxi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Oct 2007 08:53:38 -0400
In-Reply-To: <4718A680.5000501@stud.feec.vutbr.cz>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



--
On Fri, 19 Oct 2007, Michal Schmidt wrote:
>
> I'm looking at the source. The receiver thread runs with realtime
> priority (it's created with create_fifo_thread), but the sender thread
> (thread2) doesn't (create_other_thread). The sender does:
>
>         /* Record the time just before sending the signal */
>         begin = rt_gettime();
> /**** The sender can get preempted by anything right here ! ****/

Not only that, if the sender is not RT it can easily be preempted in the
system call that does the signal. Which is highly likely.

-- Steve

>         if ((ret = pthread_kill(PTHREADOF(target_thread), SIGNALNUMBER))) {
>             printf("pthread_kill returned %d\n", ret);
>         }
>
> Can this explain it?
>
> Michal
>
>
>
