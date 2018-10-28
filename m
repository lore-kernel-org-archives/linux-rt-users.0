Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42862 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeJ2ENZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 29 Oct 2018 00:13:25 -0400
Received: by mail-lf1-f68.google.com with SMTP id q6-v6so4422614lfh.9
        for <linux-rt-users@vger.kernel.org>; Sun, 28 Oct 2018 12:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <d71c523a8a0af5628da59a44223a357102c2a193.1540627754.git.lukas@wunner.de>
In-Reply-To: <d71c523a8a0af5628da59a44223a357102c2a193.1540627754.git.lukas@wunner.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 28 Oct 2018 20:27:35 +0100
Message-ID: <CACRpkdZfciHUrx9YTFsYyKEEi6RMDeWxYqe7JPnJJipWOyUJ6A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: bcm2835: Use raw spinlock for RT compatibility
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Lukas Wunner <lukas@wunner.de>, Julia Cartwright <julia@ni.com>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Mathias Duckeck <m.duckeck@kunbus.de>, tiejun.china@gmail.com, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, linux-rt-users@vger.kernel.org

On Sat, Oct 27, 2018 at 10:15 AM Lukas Wunner <lukas@wunner.de> wrote:

> The BCM2835 pinctrl driver acquires a spinlock in its ->irq_enable,
> ->irq_disable and ->irq_set_type callbacks.  Spinlocks become sleeping
> locks with CONFIG_PREEMPT_RT_FULL=y, therefore invocation of one of the
> callbacks in atomic context may cause a hard lockup if at least two GPIO
> pins in the same bank are used as interrupts.  The issue doesn't occur
> with just a single interrupt pin per bank because the lock is never
> contended.  I'm experiencing such lockups with GPIO 8 and 28 used as
> level-triggered interrupts, i.e. with ->irq_disable being invoked on
> reception of every IRQ.
>
> The critical section protected by the spinlock is very small (one bitop
> and one RMW of an MMIO register), hence converting to a raw spinlock
> seems a better trade-off than converting the driver to threaded IRQ
> handling (which would increase latency to handle an interrupt).
>
> Cc: Mathias Duckeck <m.duckeck@kunbus.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Looks good to me but adding Julia Cartwright and Grygorii
Strashko to this thread because they usually know this
stuff way better than me.

Yours,
Linus Walleij
