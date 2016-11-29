From: Oussama Ghorbel <ghorbel@gmail.com>
Subject: Re: RT_PREEMPT on Raspberry PI 3
Date: Tue, 29 Nov 2016 16:24:08 +0100
Message-ID: <CAChrKvR5L7q1kQ3mQKKmm6x+UZ_7Sd9O_0CewW_icw6FUKNOrQ@mail.gmail.com>
References: <2c0e540f-c501-f65b-1292-782e12f71039@fastwebnet.it>
 <20160922141041.ytyils2x3ehzoqhb@linutronix.de> <CABfLueFUNmudobECEZ_jt4Q6ixqOSeTajKW2SpdLJW=Qi0zQyg@mail.gmail.com>
 <20161128155900.qq23r2z4jndzvqcg@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Giuliano Colla <giuliano.colla@fastwebnet.it>,
        linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36907 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757483AbcK2PZP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Nov 2016 10:25:15 -0500
Received: by mail-wm0-f53.google.com with SMTP id t79so190963042wmt.0
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Nov 2016 07:24:29 -0800 (PST)
In-Reply-To: <20161128155900.qq23r2z4jndzvqcg@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>> I have written recently a patch that solve the FIQ issue with RT
>> Preempt on the 4-core Raspberry Pi board.
>> Please see this article for full description on the solution.
>> https://www.osadl.org/Single-View.111+M5c03315dc57.0.html
>
> So you have ~13ms max latency without the patch but with disabled FIQ
> and 170us with the Patch? Something does not look right.
You're right.  The 13 ms is not normal and that's because the primary
system in rack #b, slot #3 was temporarily set back to a non-RT kernel
for testing purposes (this is the one with FIQ disabled), but the
shadow system always was running the RT kernel and always had the
expected low latency.

> Anyway. If you don't mind I added this information to the RT-wiki [0].
> So lets hope google will point RPI users there.
Thanks for that.

> Could please cross check if the information is correct and add other RPI
> informations? I named it "Raspberry PI 3". I am not sure if the problem
> is also relevant on "Raspberry PI" and "Raspberry PI 2".
The problem is in fact relevant to the 4-core version of RPi, and this
include the RPi2 and RPi 3. The original RPi was UP system and doesn't
suffer from this issue.
The patch however works on both of them (2 and 3) as can be seen in
the RPi 3 in the shadow system of of rack #7, slot #3.
You may modify the title from "Raspberry PI 3" to "Raspberry PI 2/3",
otherwise the information you've written is correct.

> One thing: The patch is against dwc_otg. Since v3.14 we have the dwc2
> driver mainline. Is it possible to use that one instead the dwc_otg? It
> provides host and device functionality and it should be the same USB
> core.
According to dwc2 linux documentation, this driver is compatible with
brcm,bcm2835-usb, so I think it's probably possible to do it.
However dwc2 driver doesn't use FIQ at all, and therefore you don't
need the patch for it.

By the way I have written two patches that enable to see a counter for the FIQ.
https://www.osadl.org/monitoring/patches/r7s3s/0001-arm-add-stat-support-to-fiq.patch
https://www.osadl.org/monitoring/patches/r7s3s/0002-usb-dwc_otg-enable-fiq-stat.patch
You may see the output of /proc/interrupts on OSADL QA Farm on the
shadow system of r7s3 and rbs3.

> [0] https://wiki.linuxfoundation.org/realtime/documentation/known_limitations

Oussama
