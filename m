From: "Hillier, Gernot" <gernot.hillier@siemens.com>
Subject: Re: thread load balancing on dual CPU Multicore AMD64 system
Date: Mon, 05 Nov 2007 08:22:52 +0100
Message-ID: <472EC4CC.2040606@siemens.com>
References: <47179170.7030802@siemens.com> <Pine.LNX.4.58.0710242126070.13877@gandalf.stny.rr.com> <472B017C.5020308@siemens.com> <Pine.LNX.4.58.0711020810240.11943@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:24525 "EHLO david.siemens.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458AbXKEHWi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Nov 2007 02:22:38 -0500
In-Reply-To: <Pine.LNX.4.58.0711020810240.11943@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi!

Steven Rostedt schrieb:
>> it didn't get better. I still see only 2 CPUs being occupied by our test
>> program.
>>
>> Interestingly enough, it seems I now can't use CPU2 and CPU3 at all -
> 
> Is this also the case without PREEMPT_RT configured?

Not sure if I understand your question, but let's try: When I disable
CONFIG_PREEMPT_SOFTIRQS, I can use all four CPUs.

>> even if I start several test processes in parallel. IIRC, this was
>> better with 2.6.22.1-rt9 - there CPU2 and CPU3 got used if I started two
>> test programs in parallel.
>>
>> I can now even reproduce the problem with a simple kernel make. Here's a
>> snapshot of /proc/stat after compiling the kernel with "make -j 4":
>>
>> MRBOX:~/linux-2.6.23.1 # cat /proc/stat
>> cpu  249482 0 46304 683034 9592 90 358 0 1 28
>> cpu0 124240 0 20690 99283 2767 50 214 0 0 8
>> cpu1 125242 0 25586 89781 6431 33 136 0 0 10
>> cpu2 0 0 8 246867 333 0 0 0 0 0
>> cpu3 0 0 18 247103 60 6 7 0 0 8
>> intr 115025
>> ctxt 8498063
>> btime 1193997310
>> processes 82614
>> procs_running 1
>> procs_blocked 0
>>
>> As with 2.6.23-rt1, behaviour only breaks for me as soon as I enable
>> PREEMPT_RT.
> 
> But otherwise it runs fine (you can use CPU2 and CPU3)?

Yes, as long as I don't enable CONFIG_PREEMPT_SOFTIRQS. When talking
about PREEMPT_RT here, I meant it as a synonym for "all those additional
config options coming with the -rt patch series".

>> To narrow it down a bit, I now played a bit with the configure options
>> of 2.6.23.1-rt5 (leaving PREEMPT_RT disabled and enabling the other RT
>> features one after another). The culprit for me is
>> CONFIG_PREEMPT_SOFTIRQS. As soon as I enable it, only CPU0 and 1 are
>> used. Disabling it again makes the kernel use all CPUs.
>>
>> Any hint how to continue with this matter is greatly appreciated...
> 
> Could you send me the contents of /proc/cpuinfo your dmesg on bootup
> as well as the .config that you are using.

Will follow in a few minutes via private mail.

-- 
Gernot Hillier

Siemens AG, CT SE 2
Corporate Competence Center Embedded Linux
