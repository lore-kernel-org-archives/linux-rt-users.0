From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] pinctrl: qcom: Use raw spinlock variants
Date: Thu, 26 Jan 2017 11:08:50 +0100
Message-ID: <CACRpkdbdZ8KnrYvgMJ2BoLkccSB0YPwmWm5jgeggUB8FRGjNZw@mail.gmail.com>
References: <CAEYdEeQ63HZzi8yJk4eAAa=XeEeOFR_wqnL_PW3d6Nt5N955pQ@mail.gmail.com>
 <20170117201906.GB1335@jcartwri.amer.corp.natinst.com> <CACRpkdbxZw6QLKA0A8b=VuHmtkSHFywDT19pFZ3ioQ0kA=3VNg@mail.gmail.com>
 <CAEYdEeQ00axyXD0noFJDsPxHeMb0qhC6jTG4Lee7En+cOqHkXw@mail.gmail.com>
 <CAEYdEeR1Z0RWkGJ1PUyMujZf3kHqxZE-B6yHpXcNkcXVJg75Mg@mail.gmail.com> <20170120161347.GI1335@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brian Wrenn <dcbrianw@gmail.com>,
        linux-rt-users@vger.kernel.org,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:36782 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753629AbdAZKJH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Jan 2017 05:09:07 -0500
Received: by mail-io0-f173.google.com with SMTP id j13so34532513iod.3
        for <linux-rt-users@vger.kernel.org>; Thu, 26 Jan 2017 02:09:07 -0800 (PST)
In-Reply-To: <20170120161347.GI1335@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jan 20, 2017 at 5:13 PM, Julia Cartwright <julia@ni.com> wrote:

> The MSM pinctrl driver currently implements an irq_chip for handling
> GPIO interrupts; due to how irq_chip handling is done, it's necessary
> for the irq_chip methods to be invoked from hardirq context, even on a
> a real-time kernel.  Because the spinlock_t type becomes a "sleeping"
> spinlock w/ RT kernels, it is not suitable to be used with irq_chips.
>
> A quick audit of the operations under the lock reveal that they do only
> minimal, bounded work, and are therefore safe to do under a raw
> spinlock.
>
> On real-time kernels, this fixes an OOPs which looks like the following,
> as reported by Brian Wrenn:
>
>     kernel BUG at kernel/locking/rtmutex.c:1014!
>     Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>     Modules linked in: spidev_irq(O) smsc75xx wcn36xx [last unloaded: spi=
dev]
>     CPU: 0 PID: 1163 Comm: irq/144-mmc0 Tainted: G        W  O    4.4.9-l=
inaro-lt-qcom #1
>     PC is at rt_spin_lock_slowlock+0x80/0x2d8
>     LR is at rt_spin_lock_slowlock+0x68/0x2d8
>     [..]
>   Call trace:
>     rt_spin_lock_slowlock
>     rt_spin_lock
>     msm_gpio_irq_ack
>     handle_edge_irq
>     generic_handle_irq
>     msm_gpio_irq_handler
>     generic_handle_irq
>     __handle_domain_irq
>     gic_handle_irq
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reported-by: Brian Wrenn <dcbrianw@gmail.com>
> Tested-by: Brian Wrenn <dcbrianw@gmail.com>
> Signed-off-by: Julia Cartwright <julia@ni.com>

Patch applied with Bj=C3=B6rn's ACK.
Thanks for a very nice patch!

> Linus-  on quick glance, this is but one of many drivers which suffer
> the same class of problem :(.  I'm wondering if we can do some
> coccinelle magic to check specifically drivers which implement irq_chip
> callbacks and use spin_locks...

That would be awesome. I'm aware of the problem, but irqchips
are kind of fragile, so patches definately need to be tested on
hardware. If we get some patches and good example into the
kernel, hopefully we can get the situation a bit better.

Yours,
Linus Walleij
