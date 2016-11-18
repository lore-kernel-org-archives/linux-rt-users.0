From: Oussama Ghorbel <ghorbel@gmail.com>
Subject: Re: RT_PREEMPT on Raspberry PI 3
Date: Fri, 18 Nov 2016 11:25:26 +0100
Message-ID: <CABfLueFUNmudobECEZ_jt4Q6ixqOSeTajKW2SpdLJW=Qi0zQyg@mail.gmail.com>
References: <2c0e540f-c501-f65b-1292-782e12f71039@fastwebnet.it> <20160922141041.ytyils2x3ehzoqhb@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Giuliano Colla <giuliano.colla@fastwebnet.it>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33254 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752090AbcKRKZ1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Nov 2016 05:25:27 -0500
Received: by mail-yw0-f193.google.com with SMTP id s68so19596159ywg.0
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Nov 2016 02:25:27 -0800 (PST)
In-Reply-To: <20160922141041.ytyils2x3ehzoqhb@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I have written recently a patch that solve the FIQ issue with RT
Preempt on the 4-core Raspberry Pi board.
Please see this article for full description on the solution.
https://www.osadl.org/Single-View.111+M5c03315dc57.0.html

Regards,
Oussama

On Thu, Sep 22, 2016 at 3:10 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2016-09-18 12:03:42 [+0200], Giuliano Colla wrote:
>> I have managed to achieve both good performance and good stability, but I
>> have been obliged to overcome some difficulties which IMHO could have been
>> avoided if the Raspberry platform peculiarities had been given more
>> attention. Being a very popular platform, particularly suited also for
>> real-time applications, I believe it deserves it.
>
> who should give Raspberry more attention?
>
>> The main items are:
>>
>> 1) The RT patches are not in sync with mainline Raspbian kernel versions. At
>> the time of writing, the stock 4.x kernel supported is 4.4.21, while the
>> last available patch is 4.4.19-rt27. Even going backwards it's impossible to
>> find a perfect match: 4.4.14 against 4.4.12-rt20 or 4.4.15-rt23, and so on.
>
> we do have v4.4.21-rt30 as of the time of writing. I hope that you do
> not ask to align the -RT development & stable updates on the Raspberry
> tree.
>
>> I'm currently using a 4.4.13 kernel with a 4.4.12-rt19 patch, which was the
>> best match I could find, and which required some minor manual adjustments.
>>
>> Is there a way to provide a better sync?
>
> You can always take the latest -RT patch from the v4.4 branch and
> manually apply it on top of your BSP. And then fixup what broke.
>
>> 2) The RT_PREEMPT patch is not compatible with FIQ (or maybe FIQ is not
>> compatible with RT_PREEMPT). Leaving FIQ enabled generates intolerably
>> frequent freezes. It appears to work properly only on the basic Raspberry pi
>> (single core) but not on the multicore Pi2 and Pi3. Currently the only way
>> to make a real-time kernel run on Raspberry PI 2 or 3 is to disable FIQ on
>> the command line.
>
> I wouldn't say that this is PREEMPT-RT's fault. FIQ is a non-maskable
> interrupt which we do have on x86 and we call it NMI. As long as you
> don't do anything illegal like taking locks which may lead to a dead
> lock then no harm will happen to you. Therefore I assume that PREEMPT-RT
> triggers the bugs that are already there more reliably.
>
>> If the RT_PREEMPT patch could somehow support this incompatibility (either
>> by fully disabling FIQ or fixing the code) this would be a great help, thus
>> avoiding populating forums with "my raspberry pi2/3 freezes with rt patch"
>
> We could disable FIQ on rpi3 if PREEMPT_RT is enabled but this would
> require that the rpi3 is supported upstream. There is no way I suck the
> rpi3 bsp into the RT queue.
>
>> Can something be done to solve those issues?
>
> You could talk to the rpi3 people to put a link next to their bsp which
> describes the common pitfalls with -RT.
>
>> Thanks,
>>
>> Giuliano
>
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
