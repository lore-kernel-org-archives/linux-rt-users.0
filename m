From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RT and tty communication
Date: Tue, 13 Jun 2017 14:29:19 +0200
Message-ID: <20170613122919.5qn2tojop67ye7wv@linutronix.de>
References: <CAD2hpBW1YNbS+C1osQ0zMF=f_w+fpmpZvsv=x6u-1BQrSvz3Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Niels Kolthoff <nkolthoff@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:38348 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752083AbdFMM3V (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Jun 2017 08:29:21 -0400
Content-Disposition: inline
In-Reply-To: <CAD2hpBW1YNbS+C1osQ0zMF=f_w+fpmpZvsv=x6u-1BQrSvz3Dw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-06-12 15:48:49 [+0200], Niels Kolthoff wrote:
> Hi,
> 
> I'm currently testing a RT application that communicates with sensor
> hardware using a tty serial port. The application polls the tty port
> (non-blocking) in a user space thread (priority 80) for incoming data.
> On a raspberry PI3 (ttyAMA0), with kernel 4.4.9-rt17, response times <
> 650usec are achieved, which is fine.
> 
> Any version equal or above 4.4.12-rt20 will increase response peaks to
> (about 0.1%) > 2msec, with some peaks > 5msec.
> 
> cyclictest doesn't reproduce this, so I suspected a change in the tty
> driver, or related to raspberry pi.
> 
> I found that, by reverting the attached patch, response times return
> to < 650usec. I suspect it has something to do with a change in the
> read poll.
> 
> I'd like to help solving this issue, can anyone give me some pointers
> on how to continue?

My guess is that the newly introduced tty_buffer_flush_work() waits
until all in-kernel data is processed before returning -EAGAIN (if the
buffer is empty) for the non-blocking case which unbreaks ssh. So this
wait could blocking you for longer than required.
If that is really it, then this is what could be optimized :)

> Regards,
> Niels Kolthoff

Sebastian
