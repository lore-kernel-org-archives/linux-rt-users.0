From: rolf.freitag@email.de
Subject: Aw: RT and tty communication
Date: Mon, 12 Jun 2017 19:39:03 +0200
Message-ID: <trinity-b2b63e8f-2aaf-417a-a388-9d39738ef158-1497289143726@3capp-webde-bap27>
References: <CAD2hpBW1YNbS+C1osQ0zMF=f_w+fpmpZvsv=x6u-1BQrSvz3Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: "Niels Kolthoff" <nkolthoff@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:65184 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751331AbdFLRjG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Jun 2017 13:39:06 -0400
In-Reply-To: <CAD2hpBW1YNbS+C1osQ0zMF=f_w+fpmpZvsv=x6u-1BQrSvz3Dw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>Gesendet: Montag, 12. Juni 2017 um 15:48 Uhr
>Von: "Niels Kolthoff" <nkolthoff@gmail.com>
>An: linux-rt-users@vger.kernel.org
>Betreff: RT and tty communication
>Hi,
>
>I'm currently testing a RT application that communicates with sensor
>hardware using a tty serial port. The application polls the tty port
>(non-blocking) in a user space thread (priority 80) for incoming data.
>On a raspberry PI3 (ttyAMA0), with kernel 4.4.9-rt17, response times <
>650usec are achieved, which is fine.
>
>Any version equal or above 4.4.12-rt20 will increase response peaks to
>(about 0.1%) > 2msec, with some peaks > 5msec.

When you use interrupt driven input, you have to wait for the interrupt and that depends on parameters like at how many bytes in the FIFO an interrupt is triggered.
But you can use polling instead of waiting for IRQ, e. g. check every 40 microseconds for new bytes.
And you should use hardware with low latency, e. g. an PCIe card and NOT an USB-RS-232/422/485 adapter.

Regards,

Rolf
