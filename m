From: Andy Ng <andreas2025@gmail.com>
Subject: Re: wake_up does not return
Date: Fri, 27 Jan 2017 14:09:24 +0000
Message-ID: <CAAVaN8yq4BveUhhed66embAx+NZE0wq6+RgKF_K7imi=07dj2g@mail.gmail.com>
References: <CAAVaN8wqmh9qYYU7TXR58-0=5Lk_s1vMcdHKdWEp4Ln9iEf=wg@mail.gmail.com>
 <20170126165752.lsjdyuheyvzwjess@linutronix.de> <CAAVaN8zW6vEq4Y84N4NKvUFMJsgrUDPbpihuQcon+4jEfsyoEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:36830 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932697AbdA0OKk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Jan 2017 09:10:40 -0500
Received: by mail-ua0-f178.google.com with SMTP id 96so205448177uaq.3
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Jan 2017 06:09:30 -0800 (PST)
In-Reply-To: <CAAVaN8zW6vEq4Y84N4NKvUFMJsgrUDPbpihuQcon+4jEfsyoEA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I have activated kprobes and it seems that timer tick and schedule
don't get called. I have a gpio line to monitor the kprobe entry and
exit handlers


On Fri, Jan 27, 2017 at 2:04 PM, Andy Ng <andreas2025@gmail.com> wrote:
> Thank you. However when I turn debug on the problem goes away :(
>
> On Thu, Jan 26, 2017 at 4:57 PM, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
>> On 2017-01-25 13:54:15 [+0000], Andy Ng wrote:
>>> Dear List,
>>>
>>> I have an interesting problem on 3.0.35 with the rt56 patch on ARM.
>>>
>>> I have some external events that drive my ISR, which I have set it up
>>> as non_threaded one.
>>> When the interrupt rate is low, 1.8msec things are going fine, but
>>> when the rate is higher, the wake_up call from the isr does not
>>> return. The system is frozen. No Magic SysRq. Nothing.
>>>
>>> All will work fine once I change my ISR to be a threaded one.
>>>
>>> Any ideas where to search?
>>
>> If you you enable lockdep and sleeping-while-atomic warning you should
>> see quite a few warnings. That would be a good starting point to search.
>>
>>> Kind regards,
>>> Andy
>>
>> Sebastian
