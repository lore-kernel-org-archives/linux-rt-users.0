From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: high resolution timers
Date: Tue, 5 Sep 2017 17:18:02 +0200
Message-ID: <20170905151801.ao5t4k6ktk4kgien@linutronix.de>
References: <CAJ2oMhJp8gnJ92OPL25-GSXgYxTBWYXv4AKRLoZGPZsO1CHbNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ran Shalit <ranshalit@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:46093 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdIEPSD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Sep 2017 11:18:03 -0400
Content-Disposition: inline
In-Reply-To: <CAJ2oMhJp8gnJ92OPL25-GSXgYxTBWYXv4AKRLoZGPZsO1CHbNg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-09-05 16:11:38 [+0300], Ran Shalit wrote:
> Hello,
Hi,

> In case we need high resolution timers in userspace, is it by using
> timer_xxx APIs:
> timer_create
> timer_settime/timergettime
> ?

You are using a "POSIX timer" that way. See
  https://wiki.linuxfoundation.org/realtime/documentation/technical_details/hr_timers

In the "Regression on rt kernel while using POSIX timers" thread you
were unhappy with the signal delivery.

> Best Regards,
> Ran

Sebastian
