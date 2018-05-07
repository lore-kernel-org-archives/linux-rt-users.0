From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] serial: sh-sci: Use spin_{try}lock_irqsave instead of
 open coding version
Date: Mon, 7 May 2018 14:47:04 +0200
Message-ID: <20180507124704.s4qlrcc3leoky4r7@linutronix.de>
References: <20180430080918.16763-1-wagi@monom.org>
 <CAMuHMdUjsy95zNtoZnp17dmgRcrkzfSCxTe5G=ho5nphqX0HEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Wagner <wagi@monom.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUjsy95zNtoZnp17dmgRcrkzfSCxTe5G=ho5nphqX0HEg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-05-03 09:43:33 [+0200], Geert Uytterhoeven wrote:
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
> > @@ -2516,13 +2516,12 @@ static void serial_console_write(struct console *co, const char *s,
> >         unsigned long flags;
> >         int locked = 1;
> >
> > -       local_irq_save(flags);
> 
> Hence the below now runs with local interrupts enabled.
> 
> For checking port->sysrq or oops_in_progress that probably isn't an issue.
> If oops_in_progress is set, you have other problems, and the race condition
> between checking the flag and calling spin_lock{,_irqsave}() existed before,
> and is hard to avoid.

while oops_in_progress is an issue of its own, the port->sysrq isn't
avoided by by local_irq_save(). On SMP systems you can still receive a
`break' signal on the UART and have a `printk()' issued on another CPU.

> For actual console printing, I think you want to keep interrupts disabled.

why? They should be disabled as part of getting the lock and not for any
other reason.

> >         if (port->sysrq)
> >                 locked = 0;
> >         else if (oops_in_progress)
> > -               locked = spin_trylock(&port->lock);
> > +               locked = spin_trylock_irqsave(&port->lock, flags);
> >         else
> > -               spin_lock(&port->lock);
> > +               spin_lock_irqsave(&port->lock, flags);
> 
> Add
> 
>         if (!locked
>                 local_irq_save(flags)
> 
> here?

So for oops_in_progress you get here with interrupts disabled. And if
not, I don't see the point in disabling the interrupts without any kind
of locking.

> Gr{oetje,eeting}s,
> 
>                         Geert
> 

Sebastian
