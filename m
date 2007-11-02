From: Gernot Hillier <gernot.hillier@siemens.com>
Subject: Re: thread load balancing on dual CPU Multicore AMD64 system
Date: Fri, 02 Nov 2007 11:52:44 +0100
Message-ID: <472B017C.5020308@siemens.com>
References: <47179170.7030802@siemens.com> <Pine.LNX.4.58.0710242126070.13877@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from goliath.siemens.de ([192.35.17.28]:22449 "EHLO
	goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbXKBKwr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Nov 2007 06:52:47 -0400
In-Reply-To: <Pine.LNX.4.58.0710242126070.13877@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi!

On Thu, 25 Oct 2007, Steven Rostedt wrote:
>> We're currently evaluating whether PREEMPT_RT will work for a certain
>> use case combining realtime and performance requirements running on a
>> lot of CPUs and using a bunch of RAM.
>>
>> For first tests, we're running a "small" AMD64 test system with 2x2
>> cores (2 CPUs with 2 cores each) with 8 GB of RAM.
>>
>> We wrote a small testcase which basically has one SCHED_FIFO "realtime"
>> thread which does nothing but sleeping and checking if it wakes up at
>> the right time. In addition, it spawns 20 low-prio "load threads"
>> introducing a lot of malloc/memory access/free load on some GB of RAM.
>>
>> We can see, that the realtime requirements are fulfilled quite well (if
>> using the current glibc with private futexes, but that's another story).
>> The "rt thread" reacts within the expected timeframe with 2.6.22.1-rt9
>> as well as with 2.6.23-rt1.
>>
>> However, what causes problems is the load balancing of the 20 threads
>> over the available CPU cores:
>>
> 
> The latest 2.6.23-rt3 (as well as -rt2) has new RT balancing code. Could
> you try that to see if it solves you issues.

Sorry - being a bit late here.

I now tried my testcase with the current 2.6.23.1-rt5 patch (please tell
if you're still interested in test results for the old 2.6.23-rt3!) and
it didn't get better. I still see only 2 CPUs being occupied by our test
program.

Interestingly enough, it seems I now can't use CPU2 and CPU3 at all -
even if I start several test processes in parallel. IIRC, this was
better with 2.6.22.1-rt9 - there CPU2 and CPU3 got used if I started two
test programs in parallel.

I can now even reproduce the problem with a simple kernel make. Here's a
snapshot of /proc/stat after compiling the kernel with "make -j 4":

MRBOX:~/linux-2.6.23.1 # cat /proc/stat
cpu  249482 0 46304 683034 9592 90 358 0 1 28
cpu0 124240 0 20690 99283 2767 50 214 0 0 8
cpu1 125242 0 25586 89781 6431 33 136 0 0 10
cpu2 0 0 8 246867 333 0 0 0 0 0
cpu3 0 0 18 247103 60 6 7 0 0 8
intr 115025
ctxt 8498063
btime 1193997310
processes 82614
procs_running 1
procs_blocked 0

As with 2.6.23-rt1, behaviour only breaks for me as soon as I enable
PREEMPT_RT.

To narrow it down a bit, I now played a bit with the configure options
of 2.6.23.1-rt5 (leaving PREEMPT_RT disabled and enabling the other RT
features one after another). The culprit for me is
CONFIG_PREEMPT_SOFTIRQS. As soon as I enable it, only CPU0 and 1 are
used. Disabling it again makes the kernel use all CPUs.

Any hint how to continue with this matter is greatly appreciated...

-- 
Gernot Hillier

Siemens AG, CT SE 2
Corporate Competence Center Embedded Linux
