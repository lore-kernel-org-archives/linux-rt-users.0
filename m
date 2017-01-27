From: Andy Ng <andreas2025@gmail.com>
Subject: Re: wake_up does not return
Date: Fri, 27 Jan 2017 22:25:08 +0000
Message-ID: <CAAVaN8ycOtGDBgEuFGz2dp7RqvoywG2172A3dWEhVYyqx=7-5Q@mail.gmail.com>
References: <CAAVaN8wqmh9qYYU7TXR58-0=5Lk_s1vMcdHKdWEp4Ln9iEf=wg@mail.gmail.com>
 <20170126165752.lsjdyuheyvzwjess@linutronix.de> <CAAVaN8zW6vEq4Y84N4NKvUFMJsgrUDPbpihuQcon+4jEfsyoEA@mail.gmail.com>
 <CAAVaN8yq4BveUhhed66embAx+NZE0wq6+RgKF_K7imi=07dj2g@mail.gmail.com> <CAAVaN8xHrt6NgS9R24eWnBjPcAJV6A05QaCS4HpTj+=6+3kWQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36063 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbdA0WZJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Jan 2017 17:25:09 -0500
Received: by mail-vk0-f54.google.com with SMTP id t8so184609098vke.3
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Jan 2017 14:25:09 -0800 (PST)
In-Reply-To: <CAAVaN8xHrt6NgS9R24eWnBjPcAJV6A05QaCS4HpTj+=6+3kWQw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

the wake_up from a non threaded isr in RT will end up to try to get
the spin_lock of of that wait_queue, but this kind of locking in not
allowed in non threaded isr and therefore the use of wake_up_locked
does not touches the spin_locks of the queue... and it seems to work

On Fri, Jan 27, 2017 at 7:24 PM, Andy Ng <andreas2025@gmail.com> wrote:
> i have replaced wake_up call with wake_up_locked ... and it seems better.
>
> On Fri, Jan 27, 2017 at 2:09 PM, Andy Ng <andreas2025@gmail.com> wrote:
>> I have activated kprobes and it seems that timer tick and schedule
>> don't get called. I have a gpio line to monitor the kprobe entry and
>> exit handlers
>>
>>
>> On Fri, Jan 27, 2017 at 2:04 PM, Andy Ng <andreas2025@gmail.com> wrote:
>>> Thank you. However when I turn debug on the problem goes away :(
>>>
>>> On Thu, Jan 26, 2017 at 4:57 PM, Sebastian Andrzej Siewior
>>> <bigeasy@linutronix.de> wrote:
>>>> On 2017-01-25 13:54:15 [+0000], Andy Ng wrote:
>>>>> Dear List,
>>>>>
>>>>> I have an interesting problem on 3.0.35 with the rt56 patch on ARM.
>>>>>
>>>>> I have some external events that drive my ISR, which I have set it up
>>>>> as non_threaded one.
>>>>> When the interrupt rate is low, 1.8msec things are going fine, but
>>>>> when the rate is higher, the wake_up call from the isr does not
>>>>> return. The system is frozen. No Magic SysRq. Nothing.
>>>>>
>>>>> All will work fine once I change my ISR to be a threaded one.
>>>>>
>>>>> Any ideas where to search?
>>>>
>>>> If you you enable lockdep and sleeping-while-atomic warning you should
>>>> see quite a few warnings. That would be a good starting point to search.
>>>>
>>>>> Kind regards,
>>>>> Andy
>>>>
>>>> Sebastian
