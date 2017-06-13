From: Corey Minyard <cminyard@mvista.com>
Subject: Re: Why is real time pinging not possible with RT kernels?
Date: Tue, 13 Jun 2017 11:53:09 -0500
Message-ID: <c251dbb8-48f1-1d8c-7b90-0d4e3e714465@mvista.com>
References: <trinity-c4969a6b-8eeb-4799-93a4-349c300c9363-1497118391298@3capp-webde-bap09>
 <f60f3487-64d7-141c-6d6c-aec8318a87da@mvista.com>
 <20170613115818.yjjoec3kojryuxam@linutronix.de>
 <59400D95.8000304@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: rolf.freitag@email.de, linux-rt-users@vger.kernel.org
To: Chris Friesen <chris.friesen@windriver.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35613 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753217AbdFMQxW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Jun 2017 12:53:22 -0400
Received: by mail-pg0-f50.google.com with SMTP id k71so63183785pgd.2
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Jun 2017 09:53:21 -0700 (PDT)
In-Reply-To: <59400D95.8000304@windriver.com>
Content-Language: en-GB
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/13/2017 11:06 AM, Chris Friesen wrote:
> On 06/13/2017 05:58 AM, Sebastian Andrzej Siewior wrote:
>> On 2017-06-12 07:57:18 [-0500], Corey Minyard wrote:
>>> A few notes on what you have done:
>>>
>>>   * ionice doesn't affect network I/O.
>>>   * renice does not set real-time priorities.
>>>   * You don't do anything with memory locking.  What happens
>>>     if memory in your program gets paged out then is required?
>>>   * Something on the other end of the ping is running, too. It
>>>     also needs to be real-time, too, and it's not by default.
>>
>> You forgot to mention that the real-time kernel is not automatically
>> overclocking the software in terms of performance (but providing
>> determinism).
>
> Pinging localhost *should* be reasonably quick.  It's basically a test 
> of the scheduler and context switching (once all the memory is locked 
> in place).
>
> Chris

That's not what Sebastian is talking about.  Some people believe that
running a task on an RT kernel will make it run faster.  RT is not about
making your program run faster.  It's about, if you have a properly
designed application, having your program meet certain latency
requirements.  RT generally reduces throughput.

Pinging localhost should, of course, be reasonably quick, but we
are talking about latency guarantees.   Generally being reasonably
quick is not the same thing as guaranteeing latency every single
time.

To the original poster's credit, they were talking about latency, not
throughput, so I didn't address the performance question.  They
seemed to be asking the right question, they just didn't know how
it all works on Linux.

-corey

