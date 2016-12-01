From: Oussama Ghorbel <ghorbel@gmail.com>
Subject: Re: RT_PREEMPT on Raspberry PI 3
Date: Thu, 1 Dec 2016 17:24:53 +0100
Message-ID: <CAChrKvTGU4nMJuJ59FcjWW8tS-WWtevynx74WfrxQaWEnU3UJA@mail.gmail.com>
References: <2c0e540f-c501-f65b-1292-782e12f71039@fastwebnet.it>
 <20160922141041.ytyils2x3ehzoqhb@linutronix.de> <CABfLueFUNmudobECEZ_jt4Q6ixqOSeTajKW2SpdLJW=Qi0zQyg@mail.gmail.com>
 <20161128155900.qq23r2z4jndzvqcg@linutronix.de> <CAChrKvR5L7q1kQ3mQKKmm6x+UZ_7Sd9O_0CewW_icw6FUKNOrQ@mail.gmail.com>
 <20161201151644.sm3wby7fujzptejs@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Giuliano Colla <giuliano.colla@fastwebnet.it>,
        linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35971 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757510AbcLAQZQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Dec 2016 11:25:16 -0500
Received: by mail-wm0-f68.google.com with SMTP id m203so34941777wma.3
        for <linux-rt-users@vger.kernel.org>; Thu, 01 Dec 2016 08:25:16 -0800 (PST)
In-Reply-To: <20161201151644.sm3wby7fujzptejs@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>> > Could please cross check if the information is correct and add other RPI
>> > informations? I named it "Raspberry PI 3". I am not sure if the problem
>> > is also relevant on "Raspberry PI" and "Raspberry PI 2".
>> The problem is in fact relevant to the 4-core version of RPi, and this
>> include the RPi2 and RPi 3. The original RPi was UP system and doesn't
>> suffer from this issue.
>> The patch however works on both of them (2 and 3) as can be seen in
>> the RPi 3 in the shadow system of of rack #7, slot #3.
>> You may modify the title from "Raspberry PI 3" to "Raspberry PI 2/3",
>> otherwise the information you've written is correct.
>
> Updated. What is the benefit of using the FIQ? From maintenance point of
> view I would say it is easier to tell modprobe to disable FIQ instead to
> carry that patch.
The FIQ will give us better determinism, better latency as It can be
seen on OSADL QA Farm.
>From today's test we have 242us (FIQ disabled) vs 172us (with patch)
Moreover you will loose some features when disable FIQ. As FIQ is used
as finite sate machine
for very low level function like usb split transaction which is useful when plug
low/full speed device to high speed usb hub.

>> > One thing: The patch is against dwc_otg. Since v3.14 we have the dwc2
>> > driver mainline. Is it possible to use that one instead the dwc_otg? It
>> > provides host and device functionality and it should be the same USB
>> > core.
>> According to dwc2 linux documentation, this driver is compatible with
>> brcm,bcm2835-usb, so I think it's probably possible to do it.
>> However dwc2 driver doesn't use FIQ at all, and therefore you don't
>> need the patch for it.
>
> Well, yes :) If it could be confirmed that this (in-tree) driver is
> working then I would add a pointer to the wiki to stay with the in-tree
> driver for USB instead using the OOT code.
> The v4.8 tree has a dts for RPI2 so that one could work without an OOT
> patch. For RPI3 it seems, that there is no in-tree support available.
I made a quick check to use dwc2 driver, unfortunately the usb was not
initialized properly.

Oussama
