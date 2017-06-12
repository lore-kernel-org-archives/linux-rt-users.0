From: "Peter C. Wallace" <pcw@mesanet.com>
Subject: Re: Why is real time pinging not possible with RT kernels?
Date: Mon, 12 Jun 2017 06:17:15 -0700 (PDT)
Message-ID: <Pine.NEB.4.64.1706120607570.9648@freeby.mesanet.com>
References: <trinity-c4969a6b-8eeb-4799-93a4-349c300c9363-1497118391298@3capp-webde-bap09>
 <f60f3487-64d7-141c-6d6c-aec8318a87da@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: rolf.freitag@email.de, linux-rt-users@vger.kernel.org
To: Corey Minyard <cminyard@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from freeby.mesanet.com ([108.95.56.89]:57471 "EHLO
        freeby.mesanet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdFLNdT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Jun 2017 09:33:19 -0400
In-Reply-To: <f60f3487-64d7-141c-6d6c-aec8318a87da@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 12 Jun 2017, Corey Minyard wrote:

> Date: Mon, 12 Jun 2017 07:57:18 -0500
> From: Corey Minyard <cminyard@mvista.com>
> To: rolf.freitag@email.de, linux-rt-users@vger.kernel.org
> Subject: Re: Why is real time pinging not possible with RT kernels?
> 
> On 06/10/2017 01:13 PM, rolf.freitag@email.de wrote:
>> Hi,
>> 
>> I tried ping as a minimal latency test, e. g.
>> 
>> ionice -c3 -p $$
>> renice +19 -p $$
>> ping -q -s 28 -l 1 -p 0f1e2d3c4b5a6978 -i 0.001 localhost
>> 
>> but when cyclictest shows a worst-case latency of 40 mikroseconds,
>> ping shows more than 10,000 (after 1 day run).
>> I tried different kernels, e. g.
>> SMP PREEMPT RT Debian 4.6.4-1~bpo8+1 (2016-08-11) x86_64
>> but with the same result, low cyclictest values, high ping values.
>> What is the reason?
>
> Since no one else has answered, I guess I will.
>
> Creating a real-time *system* is hard work.  Just running a program on a
> real-time OS does not magically make it a real-time system.  You really
> have to know what you are doing.  I suggest you read "POSIX.4
> Programmers Guide: Programming for the Real World" for an intro to
> the subject.  It's fairly close to what Linux does, though there are things
> that Linux does beyond what is in there.
>
> A few notes on what you have done:
>
> * ionice doesn't affect network I/O.
> * renice does not set real-time priorities.
> * You don't do anything with memory locking.  What happens
>   if memory in your program gets paged out then is required?
> * Something on the other end of the ping is running, too.  It
>   also needs to be real-time, too, and it's not by default.
>
> I'd suggest you need to spend some time learning before you attempt
> something like this.
>
> -corey
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Lowly user perspective:

You can get ping to be approximately realtime by setting its priority but it 
will do awful things to your system load since ping was not written to be RT 
capable.

Heres 1/2 a day of 100 Hz pinging:


pcw@pcw-G41M-Combo:~$ sudo chrt 99 ping -i .010 -q localhost
PING localhost (127.0.0.1) 56(84) bytes of data.
^C
--- localhost ping statistics ---
4311151 packets transmitted, 4311151 received, 0% packet loss, time 43111566ms
rtt min/avg/max/mdev = 0.005/0.007/0.133/0.005 ms

pcw@pcw-G41M-Combo:~$ uname -a
Linux pcw-G41M-Combo 4.1.38-rt46 #1 SMP PREEMPT RT Sat Mar 11 10:51:18 PST 
2017 i686 i686 i686 GNU/Linux


Peter Wallace

