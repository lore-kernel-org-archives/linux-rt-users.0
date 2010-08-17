From: David Sommerseth <davids@redhat.com>
Subject: Re: Query regarding 2.6.335 RT and Non-RT performance
Date: Tue, 17 Aug 2010 19:19:34 +0200
Message-ID: <4C6AC4A6.4080407@redhat.com>
References: <AANLkTik4U-ua1zi5r5n4uw8oA-cQOO0zev__OuCto7CP@mail.gmail.com> <AANLkTimbQh3rTKnK5cri10_wLJ8BJfUnf54iZ1ENLyuN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Manikandan Ramachandran <crmanik@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3651 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905Ab0HQRTh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Aug 2010 13:19:37 -0400
In-Reply-To: <AANLkTimbQh3rTKnK5cri10_wLJ8BJfUnf54iZ1ENLyuN@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 17/08/10 08:07, Manikandan Ramachandran wrote:
> :
>>
>> Hello All,
>>
>>     I created a very simple program which has higher priority than normal tasks and runs a tight loop. Under same test environment I ran this program on both non-rt and rt 2.6.33.5 kernel.  To my suprise I see that performance of non-RT kernel is better than RT. non-RT kernel took 3 sec and 366156 usec while RT kernel took about 3 sec and 418011 usec.Can someone please explain why the performance of non-rt kernel is better than rt kernel? From the face of the test result, I feel RT has more overhead,Is there any configuration that I could do to bring down the overhead?
>>
>> Processor:
>> ----------------
>> processor       : 0
>> cpu             : 7448
>> clock           : 996.000000MHz
>> revision        : 2.2 (pvr 8004 0202)
>> bogomips        : 83.10
>> processor       : 1
>> cpu             : 7448
>> clock           : 996.000000MHz
>> revision        : 2.2 (pvr 8004 0202)
>> bogomips        : 83.10
>>
>> CFS optimization:
>> --------------------------
>> # cat /proc/sys/kernel/sched_rt_runtime_us
>> 1000000
>> # cat /proc/sys/kernel/sched_rt_period_us
>> 1000000
>> # cat /proc/sys/kernel/sched_compat_yield
>> 1
>>
>> Test Program:
>> ---------------------
>>
>> main()
>> {
>>
>>     int sched_rr_min,sched_rr_max;
>>     struct sched_param scheduling_parameters;
>>     struct timeval tv,late_tv;
>>     suseconds_t usec_diff,avg_usec = 0;
>>     time_t sec_diff, avg_sec = 0;
>>     int i;
>>     long count = 1;
>>
>>     sched_rr_min = sched_get_priority_min(SCHED_RR);
>>     sched_rr_max = sched_get_priority_max(SCHED_RR);
>>     scheduling_parameters.sched_priority = sched_rr_min+4;
>>     sched_setscheduler(0, SCHED_RR, &scheduling_parameters);// Run the process with the given priority
>>
>>     for(i = 0 ; i < 150 ; i++) {
>>        gettimeofday(&tv, NULL);
>>        while(count > 0){
>>         //printf(".");
>>         count++;
>>        }
>>        gettimeofday(&late_tv, NULL);
>>        count = 1;
>>        sec_diff = (late_tv.tv_sec - tv.tv_sec);
>>        avg_sec += sec_diff;
>>        usec_diff = ( (late_tv.tv_usec > tv.tv_usec) ? (late_tv.tv_usec - tv.tv_usec) : ( tv.tv_usec - late_tv.tv_usec));
>>        avg_usec += usec_diff;
>>        printf("Iteration #%d sec %x usec %x\n",i,(sec_diff),(usec_diff));
>>     }
>>        printf("Average of #%d sec %x usec %x\n",i,(avg_sec/i),(avg_usec)/i);
>> }

It seems to me that this test program only tries to measure speed, which
is not something RT kernels will not give you.  As Mark Knecht correctly
pointed out, RT kernels care about latency.  Non-RT kernels are
sometimes referred to as Real-Fast kernels.

Your program will run before all SCHED_OTHER programs.  But again, all
SCHED_FIFO/SCHED_RR tasks which got a higher priority (like many kernel
threads), will preempt your program, which slows it down.  Having that
said, this do not mean that running your program with priority 99 is a
clever thing, in fact, that can block the kernel to really do more
needed stuff, like to take care of I/O traffic, etc, etc.

But to really measure what the RT kernel can give you, try to run
cyclictest in the rt-tests tree [1].  That program will measure your
system latency.  Btw. to really get a good overview over you latency,
run it over a longer time (>several hours).

You can also have peek at a tool call rteval [2] which will run
cyclictest together with some loads and summarise the performance for
you.  During an rteval run, your box will be heavy loaded - but if you
get max latencies < 100us after some hours of test run, consider that
pretty good results.

In general, don't use RT if you want to do things quick.  RT will be
slower than non-RT kernels.  Try building a kernel on a non-RT kernel
and then on a RT kernel, and you'll feel it very well.

But if you care about latency (a program which needs to react within a
certain time scope after it received some work to do), then the RT
kernel will serve you better.


kind regards,

David Sommerseth


[1]
<http://git.kernel.org/?p=linux/kernel/git/clrkwllms/rt-tests.git;a=summary>
[2]
<http://git.kernel.org/?p=linux/kernel/git/clrkwllms/rteval.git;a=summary>
