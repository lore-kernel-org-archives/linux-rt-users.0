From: Sam Mosel <sam.mosel@gmail.com>
Subject: Re: RT thread running slower as SCHED_OTHER threads increases
Date: Mon, 5 Feb 2018 11:32:16 +1030
Message-ID: <CA+m2VPWWPPesVufFKBP94s4vHo8MoA_3gCEix-sJ4A_1qA5Qkw@mail.gmail.com>
References: <CAF6bL9nmjZr-tQWF1Bd03TUj+X6=dcRWpsZ4kEwVjdSi5LnbMQ@mail.gmail.com>
 <d539f46a-e52a-903f-64ac-02ed2d013782@ti.com> <CAF6bL9mB-+3Zhw=9m7-TpfriT2iHipYX461nFHMYNZ9Ez2OTCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-rt-users@vger.kernel.org
To: Journey Journey <journeywang123@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:51313 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752114AbeBEBCi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 4 Feb 2018 20:02:38 -0500
Received: by mail-wm0-f54.google.com with SMTP id r71so23103908wmd.1
        for <linux-rt-users@vger.kernel.org>; Sun, 04 Feb 2018 17:02:37 -0800 (PST)
In-Reply-To: <CAF6bL9mB-+3Zhw=9m7-TpfriT2iHipYX461nFHMYNZ9Ez2OTCQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Throttling perhaps?
https://stackoverflow.com/questions/20722615/sched-fifo-process-with-priority-of-99-gets-preempted

322ms is a very long time for a RT task to run uninterrupted. Normally
you choose RT to meet specific deadlines, not try to monopolise the
CPUs for performance testing.

See the cyclic task sample code in the first link that Grygorii sent.

Sam.

On 4 February 2018 at 17:10, Journey Journey <journeywang123@gmail.com> wrote:
> Thanks very much for your reply!
>
> I had followed the tutorial , but it doesn't work.
> 1. mlockall
> 2. echo -1 > /proc/sys/kernel/sched_rt_runtime_us
> 3. under linux 4.4.32 with rt patch
>
> I will be very glad if you can test this case yourself.
>
> Thanks !
>
> On Sat, Feb 3, 2018 at 12:46 AM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>> Hi
>>
>> You probably need to look at
>> https://wiki.linuxfoundation.org/realtime/documentation/howto/applications/start
>> https://rt.wiki.kernel.org/index.php/Main_Page
>>
>> it not enough to just set policy and prio - you need to follow some
>> additional rules while creating RT App.
>>
>>
>>
>> On 02/01/2018 09:52 PM, Journey Journey wrote:
>>> Hi  Dear All
>>>
>>> I had tested a program in order to calculate computing time in a
>>> machine with 48  intel cpu cores.
>>>
>>> 1. when running ./test, it outputs like this:
>>> MM: 324.039000 ms
>>> MM: 324.052000 ms
>>> MM: 324.079000 ms
>>> MM: 324.042000 ms
>>> MM: 324.060000 ms
>>> MM: 324.052000 ms
>>> MM: 324.026000 ms
>>> MM: 324.040000 ms
>>> MM: 324.075000 ms
>>> MM: 324.011000 ms
>>> MM: 324.072000 ms
>>>
>>> 2. running other programs, like sample code 2
>>> ./aa &
>>> ./aa &
>>> ....
>>> about 30 times
>>>
>>> 3. ./test output changes:
>>> MM: 354.601000 ms
>>> MM: 322.289000 ms
>>> MM: 322.250000 ms
>>> MM: 322.348000 ms
>>> MM: 354.700000 ms
>>> MM: 322.556000 ms
>>> MM: 354.834000 ms
>>> MM: 354.816000 ms
>>> MM: 354.777000 ms
>>> MM: 354.812000 ms
>>> MM: 322.451000 ms
>>> MM: 322.507000 ms
>>> MM: 322.473000 ms
>>>
>>> 4. For purpose to decrease computing cost time, I had tried:
>>> (1) set test policy to SCHED_RR/SCHED_FIFO, and priority to 50/98
>>>   chrt -f -p 98 5911
>>> (2)  bind test to specific cpu
>>> taskset -pc 4 5911
>>> (3) limit aa processes to other cpus
>>> for i in `ps -ef |grep aa|awk '{print $2}'`; do echo $i; taskset -pc
>>> 5-47 $i; done
>>>
>>> It still not working, the result is not good.
>>> MM: 322.316000 ms
>>> MM: 322.307000 ms
>>> MM: 326.739000 ms
>>> MM: 354.399000 ms
>>> MM: 354.662000 ms
>>> MM: 354.740000 ms
>>> MM: 322.275000 ms
>>>
>>> 5. But when limit aa processes to a small cpuset, it works,
>>> for i in `ps -ef |grep aa|awk '{print $2}'`; do echo $i; taskset -pc
>>> 5-7 $i; done
>>>
>>> the result:
>>> MM: 322.304000 ms
>>> MM: 322.335000 ms
>>> MM: 322.344000 ms
>>> MM: 322.319000 ms
>>> MM: 322.340000 ms
>>> MM: 322.328000 ms
>>> MM: 322.298000 ms
>>> MM: 322.318000 ms
>>>
>>>
>>> It's quite amazing why such low priority processes can affect realtime
>>> process, please help me!
>>>
>>>
>>>
>>> Sample test code1:
>>>
>>> #include <stdio.h>
>>> #include <sys/time.h>
>>>
>>> void calc() {
>>>      int c, d, k;
>>>      int m = 100000, q = 1, p = 1000;
>>>      int sum;
>>>      for (c = 0; c < m; c++) {
>>>          for (d = 0; d < q; d++) {
>>>              for (k = 0; k < p; k++) {
>>>                   sum = c * m * d * q * p * k;
>>>              }
>>>          }
>>>
>>>      }
>>> }
>>>
>>> int main() {
>>>      struct timeval t1, t2;
>>>      double elapsedTime;
>>>
>>>      while(1) {
>>>          gettimeofday(&t1, NULL);
>>>          calc();
>>>          gettimeofday(&t2, NULL);
>>>          elapsedTime = (t2.tv_sec - t1.tv_sec) * 1000.0;      // sec to ms
>>>          elapsedTime += (t2.tv_usec - t1.tv_usec) / 1000.0;   // us to ms
>>>          printf("MM: %lf ms\n", elapsedTime);
>>>          sleep(1);
>>>      }
>>> }
>>>
>>>
>>> Sample Code 2:
>>>
>>> #include <stdio.h>
>>>
>>> int main() {
>>>      while(1) {
>>>      }
>>> }
>>>
>>> Thanks~
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> regards,
>> -grygorii
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
