From: rolf.freitag@email.de
Subject: Re: Why is real time pinging not possible with RT kernels?
Date: Sat, 17 Jun 2017 10:37:59 +0200
Message-ID: <trinity-e834ad4b-a1e3-49fd-b72d-52128c5c2288-1497688679877@3capp-webde-bs08>
References: <trinity-c4969a6b-8eeb-4799-93a4-349c300c9363-1497118391298@3capp-webde-bap09>
 <f60f3487-64d7-141c-6d6c-aec8318a87da@mvista.com>
 <593EC529.80508@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:50492 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752410AbdFQIiC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 17 Jun 2017 04:38:02 -0400
In-Reply-To: <593EC529.80508@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
  
Gesendet: Montag, 12. Juni 2017 um 18:45 Uhr
Von: "Chris Friesen" <chris.friesen@windriver.com>
...
>> A few notes on what you have done:
>>
>> * ionice doesn't affect network I/O.
>> * renice does not set real-time priorities.
>
> Good point...the OP probably wants something like "sudo chrt <prio> <cmd> ...."

Ok, i added chrt in the script:

ionice -c3 -p $$
renice +19 -p $$
chrt -f -p 99 $$
ping -q -s 28 -l 1 -p 0f1e2d3c4b5a6978 -i 0.001 localhost

and now the worst case latency is about twice the value measured with cyclictest:

27893223 packets transmitted, 27893223 received, 0% packet loss, time 27921273ms
rtt min/avg/max/mdev = 0.022/0.023/0.280/0.006 ms


>> * You don't do anything with memory locking. What happens
>> if memory in your program gets paged out then is required?

I use much RAM and no swap, so i have implicit memory locking.

Regards,

Rolf
