From: Andy Ng <andreas2025@gmail.com>
Subject: Re: wake_up does not return
Date: Fri, 27 Jan 2017 14:04:48 +0000
Message-ID: <CAAVaN8zW6vEq4Y84N4NKvUFMJsgrUDPbpihuQcon+4jEfsyoEA@mail.gmail.com>
References: <CAAVaN8wqmh9qYYU7TXR58-0=5Lk_s1vMcdHKdWEp4Ln9iEf=wg@mail.gmail.com>
 <20170126165752.lsjdyuheyvzwjess@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:34664 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932292AbdA0OMQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Jan 2017 09:12:16 -0500
Received: by mail-ua0-f182.google.com with SMTP id 35so205648666uak.1
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Jan 2017 06:11:24 -0800 (PST)
In-Reply-To: <20170126165752.lsjdyuheyvzwjess@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thank you. However when I turn debug on the problem goes away :(

On Thu, Jan 26, 2017 at 4:57 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2017-01-25 13:54:15 [+0000], Andy Ng wrote:
>> Dear List,
>>
>> I have an interesting problem on 3.0.35 with the rt56 patch on ARM.
>>
>> I have some external events that drive my ISR, which I have set it up
>> as non_threaded one.
>> When the interrupt rate is low, 1.8msec things are going fine, but
>> when the rate is higher, the wake_up call from the isr does not
>> return. The system is frozen. No Magic SysRq. Nothing.
>>
>> All will work fine once I change my ISR to be a threaded one.
>>
>> Any ideas where to search?
>
> If you you enable lockdep and sleeping-while-atomic warning you should
> see quite a few warnings. That would be a good starting point to search.
>
>> Kind regards,
>> Andy
>
> Sebastian
