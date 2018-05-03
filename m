From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] serial: sh-sci: Use spin_{try}lock_irqsave instead of
 open coding version
Date: Thu, 3 May 2018 09:43:33 +0200
Message-ID: <CAMuHMdUjsy95zNtoZnp17dmgRcrkzfSCxTe5G=ho5nphqX0HEg@mail.gmail.com>
References: <20180430080918.16763-1-wagi@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
To: Daniel Wagner <wagi@monom.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180430080918.16763-1-wagi@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Daniel,

On Mon, Apr 30, 2018 at 10:09 AM, Daniel Wagner <wagi@monom.org> wrote:
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

> Cc: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>

Thanks for your patch!

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2516,13 +2516,12 @@ static void serial_console_write(struct console *co, const char *s,
>         unsigned long flags;
>         int locked = 1;
>
> -       local_irq_save(flags);

Hence the below now runs with local interrupts enabled.

For checking port->sysrq or oops_in_progress that probably isn't an issue.
If oops_in_progress is set, you have other problems, and the race condition
between checking the flag and calling spin_lock{,_irqsave}() existed before,
and is hard to avoid.

For actual console printing, I think you want to keep interrupts disabled.

>         if (port->sysrq)
>                 locked = 0;
>         else if (oops_in_progress)
> -               locked = spin_trylock(&port->lock);
> +               locked = spin_trylock_irqsave(&port->lock, flags);
>         else
> -               spin_lock(&port->lock);
> +               spin_lock_irqsave(&port->lock, flags);

Add

        if (!locked
                local_irq_save(flags)

here?

>         /* first save the SCSCR then disable the interrupts */
>         ctrl = serial_port_in(port, SCSCR);
> @@ -2539,8 +2538,7 @@ static void serial_console_write(struct console *co, const char *s,
>         serial_port_out(port, SCSCR, ctrl);
>
>         if (locked)
> -               spin_unlock(&port->lock);
> -       local_irq_restore(flags);
> +               spin_unlock_irqrestore(&port->lock, flags);

        else
                local_irq_restore(flags);

>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
