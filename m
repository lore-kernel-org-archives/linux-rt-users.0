From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RT and tty communication
Date: Tue, 13 Jun 2017 14:32:50 +0200
Message-ID: <20170613123250.o7quedoaweyxvvfj@linutronix.de>
References: <CAD2hpBW1YNbS+C1osQ0zMF=f_w+fpmpZvsv=x6u-1BQrSvz3Dw@mail.gmail.com>
 <trinity-b2b63e8f-2aaf-417a-a388-9d39738ef158-1497289143726@3capp-webde-bap27>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Niels Kolthoff <nkolthoff@gmail.com>,
        linux-rt-users@vger.kernel.org
To: rolf.freitag@email.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:38367 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752083AbdFMMcw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Jun 2017 08:32:52 -0400
Content-Disposition: inline
In-Reply-To: <trinity-b2b63e8f-2aaf-417a-a388-9d39738ef158-1497289143726@3capp-webde-bap27>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-06-12 19:39:03 [+0200], rolf.freitag@email.de wrote:
> When you use interrupt driven input, you have to wait for the interrupt and that depends on parameters like at how many bytes in the FIFO an interrupt is triggered.
> But you can use polling instead of waiting for IRQ, e. g. check every 40 microseconds for new bytes.

No, I think it is better to configure things properly and wait for the
interrupt to occur instead of busy-polling for things to happen.

> Regards,
> 
> Rolf

Sebastian
