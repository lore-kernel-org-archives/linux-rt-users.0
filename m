From: Sankara Muthukrishnan <sankara.m@gmail.com>
Subject: Re: timerfd functions hang on both x86 and ARM with RT patch and RT
 scheduling policies
Date: Wed, 25 Jan 2012 18:22:57 -0600
Message-ID: <CAFQPvXcGJ4oad3domH48NT3i=PhCwG7W4Zn=7NWmARhQoonRMA@mail.gmail.com>
References: <CAFQPvXdTb-=oo8OC6MAa++X6u4ZoWM2XXmKog-WK6DPookJyvg@mail.gmail.com>
	<CAFQPvXd13=B+mJGtoGLGuw4PXhBUgWVsxd7sS9PAN2oz+3HUcQ@mail.gmail.com>
	<1327478618.6973.2.camel@marge.simson.net>
	<alpine.LFD.2.02.1201251110190.2716@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Galbraith <efault@gmx.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61161 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab2AZAW5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jan 2012 19:22:57 -0500
Received: by dadi2 with SMTP id i2so17835dad.19
        for <linux-rt-users@vger.kernel.org>; Wed, 25 Jan 2012 16:22:57 -0800 (PST)
In-Reply-To: <alpine.LFD.2.02.1201251110190.2716@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I tested it on ARM Cortex-A9 dual core with different priorities and
with and without CPU affinities and it works like a charm. Thanks a
bunch, Thomas and Mike.
I wonder why my test worked for priority 1 alone before (without this
fix) and I did not see any other threads using RT scheduler in the
system with priority 1 or 2.

On Wed, Jan 25, 2012 at 4:11 AM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
> On Wed, 25 Jan 2012, Mike Galbraith wrote:
>> On Tue, 2012-01-24 at 10:04 -0600, Sankara Muthukrishnan wrote:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&ctx->wqh.lock);
>> +#ifndef CONFIG_PREEMPT_RT_BASE
>
> Bah.
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> +#else
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Current may be an RT task with priori=
ty high enough
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* to prevent the thread currently _want=
ing_ to execute
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* the timer callback function from rece=
iving the CPU.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(1, 10);
>
> Even more bah.
>
>> +#endif
>> =A0 =A0 =A0 }
>
> Index: linux-3.2/fs/timerfd.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-3.2.orig/fs/timerfd.c
> +++ linux-3.2/fs/timerfd.c
> @@ -313,7 +313,7 @@ SYSCALL_DEFINE4(timerfd_settime, int, uf
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (hrtimer_try_to_cancel(&ctx->tmr) >=
=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irq(&ctx->wqh.lock);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_wait_for_timer(&ctx->tmr);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/*
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
