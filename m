From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: thread load balancing on dual CPU Multicore AMD64 system
Date: Fri, 2 Nov 2007 08:13:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0711020810240.11943@gandalf.stny.rr.com>
References: <47179170.7030802@siemens.com> <Pine.LNX.4.58.0710242126070.13877@gandalf.stny.rr.com>
 <472B017C.5020308@siemens.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Gernot Hillier <gernot.hillier@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:33092 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501AbXKBMNP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Nov 2007 08:13:15 -0400
In-Reply-To: <472B017C.5020308@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Fri, 2 Nov 2007, Gernot Hillier wrote:

> On Thu, 25 Oct 2007, Steven Rostedt wrote:
> > The latest 2.6.23-rt3 (as well as -rt2) has new RT balancing code. Could
> > you try that to see if it solves you issues.
>
> Sorry - being a bit late here.
>
> I now tried my testcase with the current 2.6.23.1-rt5 patch (please tell
> if you're still interested in test results for the old 2.6.23-rt3!) and

No need for 2.6.23-rt3

> it didn't get better. I still see only 2 CPUs being occupied by our test
> program.
>
> Interestingly enough, it seems I now can't use CPU2 and CPU3 at all -

Is this also the case without PREEMPT_RT configured?

> even if I start several test processes in parallel. IIRC, this was
> better with 2.6.22.1-rt9 - there CPU2 and CPU3 got used if I started two
> test programs in parallel.
>
> I can now even reproduce the problem with a simple kernel make. Here's a
> snapshot of /proc/stat after compiling the kernel with "make -j 4":
>
> MRBOX:~/linux-2.6.23.1 # cat /proc/stat
> cpu  249482 0 46304 683034 9592 90 358 0 1 28
> cpu0 124240 0 20690 99283 2767 50 214 0 0 8
> cpu1 125242 0 25586 89781 6431 33 136 0 0 10
> cpu2 0 0 8 246867 333 0 0 0 0 0
> cpu3 0 0 18 247103 60 6 7 0 0 8
> intr 115025
> ctxt 8498063
> btime 1193997310
> processes 82614
> procs_running 1
> procs_blocked 0
>
> As with 2.6.23-rt1, behaviour only breaks for me as soon as I enable
> PREEMPT_RT.

But otherwise it runs fine (you can use CPU2 and CPU3)?

>
> To narrow it down a bit, I now played a bit with the configure options
> of 2.6.23.1-rt5 (leaving PREEMPT_RT disabled and enabling the other RT
> features one after another). The culprit for me is
> CONFIG_PREEMPT_SOFTIRQS. As soon as I enable it, only CPU0 and 1 are
> used. Disabling it again makes the kernel use all CPUs.
>
> Any hint how to continue with this matter is greatly appreciated...

Could you send me the contents of /proc/cpuinfo your dmesg on bootup
as well as the .config that you are using.

Thanks,

-- Steve
