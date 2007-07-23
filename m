From: John Sigler <linux.kernel@free.fr>
Subject: Re: Pin-pointing the root of unusual application latencies
Date: Mon, 23 Jul 2007 16:14:26 +0200
Message-ID: <46A4B7C2.1070304@free.fr>
References: <469600F7.3060603@free.fr> <20070723095357.GA886@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:50484 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446AbXGWONw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Jul 2007 10:13:52 -0400
In-Reply-To: <20070723095357.GA886@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ingo Molnar wrote:

> John Sigler wrote:
> 
>> Here's a /proc/latency_trace dump. What is there to understand?
>>
>> # cat /proc/latency_trace
>> preemption latency trace v1.1.5 on 2.6.20.7-rt8
>> --------------------------------------------------------------------
>>  latency: 26 us, #2/2, CPU#0 | (M:rt VP:0, KP:0, SP:1 HP:1)
>>     -----------------
>>     | task: softirq-timer/0-4 (uid:0 nice:0 policy:1 rt_prio:50)
>>     -----------------
>>
>>                  _------=> CPU#
>>                 / _-----=> irqs-off
>>                | / _----=> need-resched
>>                || / _---=> hardirq/softirq
>>                ||| / _--=> preempt-depth
>>                |||| /
>>                |||||     delay
>>    cmd     pid ||||| time  |   caller
>>       \   /    |||||   \   |   /
>>    <...>-4     0D..1   26us : trace_stop_sched_switched 
>> (__sched_text_start)
> 
> could you try:
> 
>  http://redhat.com/~mingo/latency-tracing-patches/trace-it.c
> 
> and run it like this:
> 
>  ./trace-it 1 > trace.txt
> 
> does it produce lots of trace entries? If not then 
> CONFIG_FUNCTION_TRACING is not enabled. Once you see lots of output in 
> the file, the tracer is up and running and you can start tracing the 
> latency in your app.

# ./trace-it 1 >/tmp/trace.txt
# wc /tmp/trace.txt
   65555  393277 4096317 /tmp/trace.txt

preemption latency trace v1.1.5 on 2.6.20.7-rt8
--------------------------------------------------------------------
  latency: 1020019 us, #65536/76272, CPU#0 | (M:rt VP:0, KP:0, SP:1 HP:1)
     -----------------
     | task: trace-it-939 (uid:0 nice:0 policy:0 rt_prio:0)
     -----------------

                  _------=> CPU#
                 / _-----=> irqs-off
                | / _----=> need-resched
                || / _---=> hardirq/softirq
                ||| / _--=> preempt-depth
                |||| /
                |||||     delay
    cmd     pid ||||| time  |   caller
       \   /    |||||   \   |   /
    <...>-939   0D...    0us : read_tsc (get_monotonic_cycles)
    <...>-939   0D...    1us : read_tsc (get_monotonic_cycles)
    <...>-939   0D...    1us : read_tsc (get_monotonic_cycles)
    <...>-939   0D...    1us : read_tsc (get_monotonic_cycles)
    <...>-939   0D...    2us : read_tsc (get_monotonic_cycles)
    <...>-939   0D...    2us : read_tsc (get_monotonic_cycles)
    <...>-939   0D...    2us : read_tsc (get_monotonic_cycles)
    <...>-939   0D...    2us : read_tsc (get_monotonic_cycles)
    <...>-939   0D...    3us : read_tsc (get_monotonic_cycles)
    <...>-939   0D...    3us : read_tsc (get_monotonic_cycles)
[SNIP]
    <...>-939   0D... 19763us : read_tsc (get_monotonic_cycles)
    <...>-939   0D... 19763us : read_tsc (get_monotonic_cycles)
    <...>-939   0D... 19763us : read_tsc (get_monotonic_cycles)
    <...>-939   0D... 19764us : read_tsc (get_monotonic_cycles)
    <...>-939   0D... 19764us : read_tsc (get_monotonic_cycles)
    <...>-939   0D... 19764us : read_tsc (get_monotonic_cycles)
    <...>-939   0D... 19765us : read_tsc (get_monotonic_cycles)
    <...>-939   0D... 19765us : read_tsc (get_monotonic_cycles)
    <...>-939   0D... 19765us : read_tsc (get_monotonic_cycles)
    <...>-939   0D... 19765us : read_tsc (get_monotonic_cycles)


vim:ft=help

(I snipped ~65500 lines where only the number of "us" changes.)

Shouldn't there be other functions in the output?

Am I reading correctly that some read_tsc calls take 20 ms?

dmesg reports:
(        trace-it-939  |#0): new 1020019 us user-latency.

> To track it down, use the method that trace-it.c uses to start/stop 
> tracing, i.e. put the prctl(0,1); / prctl(0,0); calls into your app to 
> start/stop tracing and the kernel will do the rest once you've set 
> /proc/sys/kernel/preempt_max_latency back to 0: /proc/latency_trace will 
> always contain the longest latency that your app triggered, of the 
> critical path you programmed into it.

Here's what I came up with:
http://linux.kernel.free.fr/latency/check_dektec_input3.cxx
(I enable tracing only 1% of the time.)

The output looks very much like the one I got when I ran trace-it

preemption latency trace v1.1.5 on 2.6.20.7-rt8
--------------------------------------------------------------------
  latency: 19996 us, #65536/65815, CPU#0 | (M:rt VP:0, KP:0, SP:1 HP:1)
     -----------------
     | task: check_dektec_in-1151 (uid:0 nice:0 policy:2 rt_prio:80)
     -----------------

                  _------=> CPU#
                 / _-----=> irqs-off
                | / _----=> need-resched
                || / _---=> hardirq/softirq
                ||| / _--=> preempt-depth
                |||| /
                |||||     delay
    cmd     pid ||||| time  |   caller
       \   /    |||||   \   |   /
    <...>-1151  0D...    0us : read_tsc (get_monotonic_cycles)
    <...>-1151  0D...    1us : read_tsc (get_monotonic_cycles)
    <...>-1151  0D...    1us : read_tsc (get_monotonic_cycles)
    <...>-1151  0D...    1us : read_tsc (get_monotonic_cycles)
    <...>-1151  0D...    2us : read_tsc (get_monotonic_cycles)
    <...>-1151  0D...    2us : read_tsc (get_monotonic_cycles)
    <...>-1151  0D...    2us : read_tsc (get_monotonic_cycles)
    <...>-1151  0D...    3us : read_tsc (get_monotonic_cycles)
    <...>-1151  0D...    3us : read_tsc (get_monotonic_cycles)
    <...>-1151  0D...    3us : read_tsc (get_monotonic_cycles)
    <...>-1151  0D...    4us : read_tsc (get_monotonic_cycles)
[...]
    <...>-1151  0D... 19764us : read_tsc (get_monotonic_cycles)
    <...>-1151  0D... 19764us : read_tsc (get_monotonic_cycles)
    <...>-1151  0D... 19765us : read_tsc (get_monotonic_cycles)
    <...>-1151  0D... 19765us : read_tsc (get_monotonic_cycles)
    <...>-1151  0D... 19765us : read_tsc (get_monotonic_cycles)
    <...>-1151  0D... 19766us : read_tsc (get_monotonic_cycles)
    <...>-1151  0D... 19766us : read_tsc (get_monotonic_cycles)
    <...>-1151  0D... 19766us : read_tsc (get_monotonic_cycles)

Remarks:

1. Again, shouldn't there be other functions in the output?

2. How much overhead do the prctl calls incur? Is it possible that they 
are somehow masking my problem? (I'll let the program run all night to 
maximize the chances of capturing the anomalous latency.)

> also check the cyclictest source of how to do app-driven latency 
> tracing.

Are you talking about this code:
http://git.kernel.org/?p=linux/kernel/git/tglx/rt-tests.git;a=blob_plain;f=cyclictest/cyclictest.c;hb=HEAD
I will study it.

Regards.
