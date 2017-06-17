From: Corey Minyard <cminyard@mvista.com>
Subject: Re: Why is real time pinging not possible with RT kernels?
Date: Sat, 17 Jun 2017 07:10:27 -0500
Message-ID: <9e257af7-66ea-4620-2e50-2c58830ac4b0@mvista.com>
References: <trinity-c4969a6b-8eeb-4799-93a4-349c300c9363-1497118391298@3capp-webde-bap09>
 <f60f3487-64d7-141c-6d6c-aec8318a87da@mvista.com>
 <593EC529.80508@windriver.com>
 <trinity-e834ad4b-a1e3-49fd-b72d-52128c5c2288-1497688679877@3capp-webde-bs08>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: rolf.freitag@email.de, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33939 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752937AbdFQMKg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 17 Jun 2017 08:10:36 -0400
Received: by mail-oi0-f50.google.com with SMTP id b6so35807717oia.1
        for <linux-rt-users@vger.kernel.org>; Sat, 17 Jun 2017 05:10:36 -0700 (PDT)
In-Reply-To: <trinity-e834ad4b-a1e3-49fd-b72d-52128c5c2288-1497688679877@3capp-webde-bs08>
Content-Language: en-GB
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/17/2017 03:37 AM, rolf.freitag@email.de wrote:
> Hi,
>    
> Gesendet: Montag, 12. Juni 2017 um 18:45 Uhr
> Von: "Chris Friesen" <chris.friesen@windriver.com>
> ...
>>> A few notes on what you have done:
>>>
>>> * ionice doesn't affect network I/O.
>>> * renice does not set real-time priorities.
>> Good point...the OP probably wants something like "sudo chrt <prio> <cmd> ...."
> Ok, i added chrt in the script:
>
> ionice -c3 -p $$
> renice +19 -p $$
> chrt -f -p 99 $$
> ping -q -s 28 -l 1 -p 0f1e2d3c4b5a6978 -i 0.001 localhost
>
> and now the worst case latency is about twice the value measured with cyclictest:
>
> 27893223 packets transmitted, 27893223 received, 0% packet loss, time 27921273ms
> rtt min/avg/max/mdev = 0.022/0.023/0.280/0.006 ms

That is pretty good, really.  However, I'm guessing you aren't doing 
anything
else on the system.

When we test RT, we do so while running a heavy I/O, network, and CPU load.
If you do that, you may see very different results, though I doubt 
cyclictest
will move much.

That's what RT is about.  If someone decides to log on to your system 
running
an RT application, and compiles a kernel or something, your RT application
still meets its deadlines.

>
>>> * You don't do anything with memory locking. What happens
>>> if memory in your program gets paged out then is required?
> I use much RAM and no swap, so i have implicit memory locking.

That is not implicit memory locking.  The kernel is free to swap out 
anything
that is backed by disk, like your executable code.  Lots of memory helps,
but does not offer a guarantee.  Lack of swap doesn't matter (much).

-corey

> Regards,
>
> Rolf
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


