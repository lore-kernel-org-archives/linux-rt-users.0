From: =?ISO-8859-1?Q?Matthias_D=FCbon?= <matthias.duebon@ing-duebon.de>
Subject: =?windows-1252?Q?Re=3A_error=3A_implicit_declaration_of_function_=91do=5Fso?=
	=?windows-1252?Q?ftirq=92?=
Date: Sun, 20 Oct 2013 19:30:19 +0200
Message-ID: <CAMj341PgLa6nFpL1PcApgOYRQ9PV_xWV+n+KazeJ=xGvaF9CTg@mail.gmail.com>
References: <CAMj341OaVOXvcjvw75CoKSF1=YaBcVHa026LQ8VY2KXyUtOBaw@mail.gmail.com>
	<20131017120717.GA22364@austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Henrik Austad <henrik@austad.us>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:38330 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab3JTRaV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 20 Oct 2013 13:30:21 -0400
Received: by mail-lb0-f172.google.com with SMTP id c11so3976509lbj.17
        for <linux-rt-users@vger.kernel.org>; Sun, 20 Oct 2013 10:30:20 -0700 (PDT)
In-Reply-To: <20131017120717.GA22364@austad.us>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Henrik,

thanks for your help, you are completely right. (I should be less
sloppy when patching something I don't understand ;-) )

best regards,

Matthias D=FCbon

On Thu, Oct 17, 2013 at 2:07 PM, Henrik Austad <henrik@austad.us> wrote=
:
> On Tue, Oct 15, 2013 at 06:14:01PM +0200, Matthias D=FCbon wrote:
>> Hello everyone,
>
> Hi,
>
>> I am just experimenting with the RT preempt patch
>> patch-3.10.15-rt11.patch.bz2 and a 3.10.16 kernel for x86 architectu=
re
>> with a "standard" .config file.
>
> Standard as in 'make defconfig' or standard as in 'what my distro use=
s'?
>
>> I configured CONFIG_PREEMPT_RT_FULL=3Dy
>>
>> when building the kernel I got the following error:
>>
>> "kernel/softirq.c: In function =91invoke_softirq=92:
>> kernel/softirq.c:710:3: error: implicit declaration of function
>> =91do_softirq=92 [-Werror=3Dimplicit-function-declaration]"
>>
>> Is this related to my kernel configuration?
>
> Not easy to say without the actual .config.
>
> However, I did note one thing. You are using the preempt-rt patch for
> 3.10.15 and you apply it to 3.10.16 (or was that a typo?)
>
> When I try to do the same thing; lo and behold, I get a reject in
> kernel/softirq.c.
>
> $ cat kernel/softirq.c.rej
> --- kernel/softirq.c
> +++ kernel/softirq.c
> @@ -698,10 +1066,20 @@
>
>  static inline void invoke_softirq(void)
>  {
> +#ifndef CONFIG_PREEMPT_RT_FULL
>         if (!force_irqthreads)
>                 __do_softirq();
>         else
>                 wakeup_softirqd();
> +#else /* PREEMPT_RT_FULL */
> +       unsigned long flags;
> +
> +       local_irq_save(flags);
> +       if (__this_cpu_read(ksoftirqd) &&
> +           __this_cpu_read(ksoftirqd)->softirqs_raised)
> +               wakeup_softirqd();
> +       local_irq_restore(flags);
> +#endif
>  }
>
>  static inline void tick_irq_exit(void)
>
>
> Do you see anything suspicious here? :)
>
> Try to use v3.10.15 and recompile. I think that'll work a bit better.
>
>
> --
> Henrik Austad
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
