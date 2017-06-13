From: Chris Friesen <chris.friesen@windriver.com>
Subject: Re: Why is real time pinging not possible with RT kernels?
Date: Tue, 13 Jun 2017 10:06:45 -0600
Message-ID: <59400D95.8000304@windriver.com>
References: <trinity-c4969a6b-8eeb-4799-93a4-349c300c9363-1497118391298@3capp-webde-bap09> <f60f3487-64d7-141c-6d6c-aec8318a87da@mvista.com> <20170613115818.yjjoec3kojryuxam@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <rolf.freitag@email.de>, <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Corey Minyard <cminyard@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:37379 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbdFMQHH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Jun 2017 12:07:07 -0400
In-Reply-To: <20170613115818.yjjoec3kojryuxam@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/13/2017 05:58 AM, Sebastian Andrzej Siewior wrote:
> On 2017-06-12 07:57:18 [-0500], Corey Minyard wrote:
>> A few notes on what you have done:
>>
>>   * ionice doesn't affect network I/O.
>>   * renice does not set real-time priorities.
>>   * You don't do anything with memory locking.  What happens
>>     if memory in your program gets paged out then is required?
>>   * Something on the other end of the ping is running, too.  It
>>     also needs to be real-time, too, and it's not by default.
>
> You forgot to mention that the real-time kernel is not automatically
> overclocking the software in terms of performance (but providing
> determinism).

Pinging localhost *should* be reasonably quick.  It's basically a test of the 
scheduler and context switching (once all the memory is locked in place).

Chris
