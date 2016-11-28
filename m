From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RT_PREEMPT on Raspberry PI 3
Date: Mon, 28 Nov 2016 16:59:00 +0100
Message-ID: <20161128155900.qq23r2z4jndzvqcg@linutronix.de>
References: <2c0e540f-c501-f65b-1292-782e12f71039@fastwebnet.it>
 <20160922141041.ytyils2x3ehzoqhb@linutronix.de>
 <CABfLueFUNmudobECEZ_jt4Q6ixqOSeTajKW2SpdLJW=Qi0zQyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Giuliano Colla <giuliano.colla@fastwebnet.it>,
        linux-rt-users@vger.kernel.org
To: Oussama Ghorbel <ghorbel@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:46274 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932373AbcK1P7E (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Nov 2016 10:59:04 -0500
Content-Disposition: inline
In-Reply-To: <CABfLueFUNmudobECEZ_jt4Q6ixqOSeTajKW2SpdLJW=Qi0zQyg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-11-18 11:25:26 [+0100], Oussama Ghorbel wrote:
> Hi,
Hi,

> I have written recently a patch that solve the FIQ issue with RT
> Preempt on the 4-core Raspberry Pi board.
> Please see this article for full description on the solution.
> https://www.osadl.org/Single-View.111+M5c03315dc57.0.html

So you have ~13ms max latency without the patch but with disabled FIQ
and 170us with the Patch? Something does not look right.

Anyway. If you don't mind I added this information to the RT-wiki [0].
So lets hope google will point RPI users there.
Could please cross check if the information is correct and add other RPI
informations? I named it "Raspberry PI 3". I am not sure if the problem
is also relevant on "Raspberry PI" and "Raspberry PI 2".

One thing: The patch is against dwc_otg. Since v3.14 we have the dwc2
driver mainline. Is it possible to use that one instead the dwc_otg? It
provides host and device functionality and it should be the same USB
core.

[0] https://wiki.linuxfoundation.org/realtime/documentation/known_limitations

> Regards,
> Oussama

Sebastian
