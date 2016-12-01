From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RT_PREEMPT on Raspberry PI 3
Date: Thu, 1 Dec 2016 16:16:44 +0100
Message-ID: <20161201151644.sm3wby7fujzptejs@linutronix.de>
References: <2c0e540f-c501-f65b-1292-782e12f71039@fastwebnet.it>
 <20160922141041.ytyils2x3ehzoqhb@linutronix.de>
 <CABfLueFUNmudobECEZ_jt4Q6ixqOSeTajKW2SpdLJW=Qi0zQyg@mail.gmail.com>
 <20161128155900.qq23r2z4jndzvqcg@linutronix.de>
 <CAChrKvR5L7q1kQ3mQKKmm6x+UZ_7Sd9O_0CewW_icw6FUKNOrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Giuliano Colla <giuliano.colla@fastwebnet.it>,
        linux-rt-users@vger.kernel.org
To: Oussama Ghorbel <ghorbel@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:57605 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbcLAPRy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Dec 2016 10:17:54 -0500
Content-Disposition: inline
In-Reply-To: <CAChrKvR5L7q1kQ3mQKKmm6x+UZ_7Sd9O_0CewW_icw6FUKNOrQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-11-29 16:24:08 [+0100], Oussama Ghorbel wrote:
> > Could please cross check if the information is correct and add other RPI
> > informations? I named it "Raspberry PI 3". I am not sure if the problem
> > is also relevant on "Raspberry PI" and "Raspberry PI 2".
> The problem is in fact relevant to the 4-core version of RPi, and this
> include the RPi2 and RPi 3. The original RPi was UP system and doesn't
> suffer from this issue.
> The patch however works on both of them (2 and 3) as can be seen in
> the RPi 3 in the shadow system of of rack #7, slot #3.
> You may modify the title from "Raspberry PI 3" to "Raspberry PI 2/3",
> otherwise the information you've written is correct.

Updated. What is the benefit of using the FIQ? From maintenance point of
view I would say it is easier to tell modprobe to disable FIQ instead to
carry that patch.

> > One thing: The patch is against dwc_otg. Since v3.14 we have the dwc2
> > driver mainline. Is it possible to use that one instead the dwc_otg? It
> > provides host and device functionality and it should be the same USB
> > core.
> According to dwc2 linux documentation, this driver is compatible with
> brcm,bcm2835-usb, so I think it's probably possible to do it.
> However dwc2 driver doesn't use FIQ at all, and therefore you don't
> need the patch for it.

Well, yes :) If it could be confirmed that this (in-tree) driver is
working then I would add a pointer to the wiki to stay with the in-tree
driver for USB instead using the OOT code.
The v4.8 tree has a dts for RPI2 so that one could work without an OOT
patch. For RPI3 it seems, that there is no in-tree support available.

> Oussama

Sebastian
