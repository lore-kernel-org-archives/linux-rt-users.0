From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] serial: sh-sci: Use spin_{try}lock_irqsave instead of
 open coding version
Date: Tue, 8 May 2018 09:29:04 +0200
Message-ID: <CAMuHMdUWrM9LsN7CoHzPruCA1k8WB+VHvHddARCmtmZGFVW05g@mail.gmail.com>
References: <20180430080918.16763-1-wagi@monom.org> <CAMuHMdUjsy95zNtoZnp17dmgRcrkzfSCxTe5G=ho5nphqX0HEg@mail.gmail.com>
 <20180507124704.s4qlrcc3leoky4r7@linutronix.de> <66cd1363-9f62-e2f5-2271-1fa78509f2cd@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
To: Daniel Wagner <wagi@monom.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <66cd1363-9f62-e2f5-2271-1fa78509f2cd@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Daniel,

On Tue, May 8, 2018 at 9:23 AM, Daniel Wagner <wagi@monom.org> wrote:
> On 05/07/2018 02:47 PM, Sebastian Andrzej Siewior wrote:
>> On 2018-05-03 09:43:33 [+0200], Geert Uytterhoeven wrote:
>>>> --- a/drivers/tty/serial/sh-sci.c
>>>> +++ b/drivers/tty/serial/sh-sci.c
>>>> @@ -2516,13 +2516,12 @@ static void serial_console_write(struct console
>>>> *co, const char *s,
>>>>          unsigned long flags;
>>>>          int locked = 1;
>>>>
>>>> -       local_irq_save(flags);
>>>
>>>
>>> Hence the below now runs with local interrupts enabled.
>>>
>>> For checking port->sysrq or oops_in_progress that probably isn't an
>>> issue.
>>> If oops_in_progress is set, you have other problems, and the race
>>> condition
>>> between checking the flag and calling spin_lock{,_irqsave}() existed
>>> before,
>>> and is hard to avoid.
>>
>> while oops_in_progress is an issue of its own, the port->sysrq isn't
>> avoided by by local_irq_save(). On SMP systems you can still receive a
>> `break' signal on the UART and have a `printk()' issued on another CPU.
>>
>>> For actual console printing, I think you want to keep interrupts
>>> disabled.
>>
>> why? They should be disabled as part of getting the lock and not for any
>> other reason.
>>
>>>>          if (port->sysrq)
>>>>                  locked = 0;
>>>>          else if (oops_in_progress)
>>>> -               locked = spin_trylock(&port->lock);
>>>> +               locked = spin_trylock_irqsave(&port->lock, flags);
>>>>          else
>>>> -               spin_lock(&port->lock);
>>>> +               spin_lock_irqsave(&port->lock, flags);
>>>
>>>
>>> Add
>>>
>>>          if (!locked
>>>                  local_irq_save(flags)
>>>
>>> here?
>>
>>
>> So for oops_in_progress you get here with interrupts disabled. And if
>> not, I don't see the point in disabling the interrupts without any kind
>> of locking.
>
>
> So I understand, the initial version of this patch was correct.
>
> @Geert if you don't object I'll send a v3 (v1 ported to mainline).

Please go ahead, thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
