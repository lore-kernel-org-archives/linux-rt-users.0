From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3] serial: sh-sci: Use spin_{try}lock_irqsave instead of
 open coding version
Date: Tue, 8 May 2018 11:52:53 +0200
Message-ID: <CAMuHMdV4D4uMWNxFH-RzuUV_ssEMYWZ-dbhfa=cgB57oNHiyuA@mail.gmail.com>
References: <20180508085509.31384-1-wagi@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Wagner <wagi@monom.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180508085509.31384-1-wagi@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, May 8, 2018 at 10:55 AM, Daniel Wagner <wagi@monom.org> wrote:
> From: Daniel Wagner <daniel.wagner@siemens.com>
>
> Commit 40f70c03e33a ("serial: sh-sci: add locking to console write
> function to avoid SMP lockup") copied the strategy to avoid locking
> problems in conjuncture with the console from the UART8250
> driver. Instead using directly spin_{try}lock_irqsave(),
> local_irq_save() followed by spin_{try}lock() was used. While this is
> correct on mainline, for -rt it is a problem. spin_{try}lock() will
> check if it is running in a valid context. Since the local_irq_save()
> has already been executed, the context has changed and
> spin_{try}lock() will complain. The reason why spin_{try}lock()
> complains is that on -rt the spin locks are turned into mutexes and
> therefore can sleep. Sleeping with interrupts disabled is not valid.

[...]

> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>
> ---
> changes since v2:
>  - dropped the local_irq_save() it's wrong as Sebastian pointed out
>
> changes since v1:
>  - Ported to current mainline (initial version was against v4.4.y)
>  - Left local_irq_save() in place when spinlocks are not used as suggested
>    by Geert.

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
