From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] serial: sh-sci: Use spin_{try}lock_irqsave instead of
 open coding version
Date: Mon, 7 May 2018 09:14:38 +0200
Message-ID: <CAMuHMdUsWRbYxoV_it-EWtLWcT04h0AsHpZJCgJ2hDm5z+KCOA@mail.gmail.com>
References: <20180504163041.28726-1-wagi@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Wagner <daniel.wagner@siemens.com>
To: Daniel Wagner <wagi@monom.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180504163041.28726-1-wagi@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Daniel,

On Fri, May 4, 2018 at 6:30 PM, Daniel Wagner <wagi@monom.org> wrote:
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

> ---
>
> changes since v1:
>  - Ported to current mainline (initial version was against v4.4.y)
>  - Left local_irq_save() in place when spinlocks are not used as suggested
>    by Geert.

Thanks for the update!

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2890,16 +2890,16 @@ static void serial_console_write(struct console *co, const char *s,
>         unsigned long flags;
>         int locked = 1;
>
> -       local_irq_save(flags);
>  #if defined(SUPPORT_SYSRQ)
> -       if (port->sysrq)
> +       if (port->sysrq) {
>                 locked = 0;
> -       else
> +               local_irq_save(flags);
> +       } else
>  #endif
>         if (oops_in_progress)
> -               locked = spin_trylock(&port->lock);
> +               locked = spin_trylock_irqsave(&port->lock, flags);

If the spinlock could not be taken, interrupts are re-enabled:

    include/linux/spinlock.h:
    #define raw_spin_trylock_irqsave(lock, flags) \
    ({ \
            local_irq_save(flags); \
            raw_spin_trylock(lock) ? \
            1 : ({ local_irq_restore(flags); 0; }); \
    })

hence I think you need to check for this and disable interrupts again:

    if (!locked)
            local_irq_save(flags);

>         else
> -               spin_lock(&port->lock);
> +               spin_lock_irqsave(&port->lock, flags);
>
>         /* first save SCSCR then disable interrupts, keep clock source */
>         ctrl = serial_port_in(port, SCSCR);
> @@ -2919,8 +2919,9 @@ static void serial_console_write(struct console *co, const char *s,
>         serial_port_out(port, SCSCR, ctrl);
>
>         if (locked)
> -               spin_unlock(&port->lock);
> -       local_irq_restore(flags);
> +               spin_unlock_irqrestore(&port->lock, flags);
> +       else
> +               local_irq_restore(flags);
>  }
>
>  static int serial_console_setup(struct console *co, char *options)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
