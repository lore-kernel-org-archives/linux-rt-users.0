Return-Path: <SRS0=nNG0=7A=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35399C433DF
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 May 2020 02:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F418E20657
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 May 2020 02:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTuNXTqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgERCqV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 17 May 2020 22:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgERCqU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 17 May 2020 22:46:20 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F54C061A0C
        for <linux-rt-users@vger.kernel.org>; Sun, 17 May 2020 19:46:20 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id y85so3011266oie.11
        for <linux-rt-users@vger.kernel.org>; Sun, 17 May 2020 19:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYgp+0islXutrcg3Qb8Mhd3j1esIJgjKo/gYGxLiVcw=;
        b=nTuNXTqYE2xsn03eJ0CkzGPlcUm6gf0HviJJb64QDVKMgY0O9ckBL4O5IwNqX+UDtm
         PEazSM+gr/J7nSuWkOnsg2q4fVubbCxs0tEPjn9R487B7My5EBvgdV+UBUuvKx4haNCO
         lwpP+6/oHUY4XpbIBjYt3hjC6vWC8JtgwF9u0lS0HKIX+16wU4VBYR3Gl/X2sIV85y6F
         qW0liThsiHfm+YGhyzKRJ1+tB1pG/64P+nb1rhtHc7elHzUrpPxVZQIWycxxeBIhYkEL
         1W5jOC7WSm4CAPaFoppLpShB1kP3vYXvTMsH8+sKQk3SPpahNti0NvTC4zXcdo11uWsg
         md2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYgp+0islXutrcg3Qb8Mhd3j1esIJgjKo/gYGxLiVcw=;
        b=AFZiACo2ma4usoyHIWv0Y0+1HTkYEelMlA/Tpf6gZ0cVF2u25o9Xe94pGw9rywdasC
         GDUF1QQYmOO5B/+Aa1o9C7DxBNswaVFtN60difjofuRZ84+UFCtXNaOWQKUd3fEUgxz9
         d7Y+vvDq4z6wcNunbKKWSURyrg0U/GtjvtZ76p1EbVpJL2RIqyybDx9khZU3vKMlKlSo
         D3fq8H7Bl0Us+idZCFJPIbfisOaftBKSFCoL3ePcOrcBbjqejd5uHhKazg9PIcpKgn95
         V+zex2QZpQsmNpT3Ob/Xb1xHn94mfyZcSGdiXRKsSFjYTF4FtYKPSIJNK+VO1HxYteFy
         qOeA==
X-Gm-Message-State: AOAM532pdSfI+Cfn1+OqSCZOPxWJHnNIB9BL02FgpGYLhrW9r9N4adav
        3Mwf4tYNtbv9ksnqBrtmuuJOgjA3IDQMHSq/Hhjp0OpL
X-Google-Smtp-Source: ABdhPJwr675J3oAQ9XTaT4Tr05+ty9/uzy1amykRWs3mdeA66jwOMY2Cdcgh9++9Uz8hwWfKlbOFbI4gNHe2Y4Wzm8g=
X-Received: by 2002:a05:6808:b07:: with SMTP id s7mr9252325oij.42.1589769979861;
 Sun, 17 May 2020 19:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <CANAMpFTrYiiYoXSGVbVsNYqn-7W1v3qn8awUe=0Yv2SPepvTPg@mail.gmail.com>
 <CANAMpFTwp-8RJHzd5ab=3pDJPMxjvh3dArxNrw_kN0L5MOB8jA@mail.gmail.com>
 <20200512091423.56ed5dea@gandalf.local.home> <CANAMpFSy14e0WCd5Kz_FQkJv-XGYYx8Zp3WRv1TrUNSMBd=NSQ@mail.gmail.com>
In-Reply-To: <CANAMpFSy14e0WCd5Kz_FQkJv-XGYYx8Zp3WRv1TrUNSMBd=NSQ@mail.gmail.com>
From:   chen song <lhcs2008@gmail.com>
Date:   Mon, 18 May 2020 10:46:08 +0800
Message-ID: <CANAMpFSSCOEyd9wZ=FnO7KXAgh9w4fwXCs1_fWX=w_M9OLBf5w@mail.gmail.com>
Subject: Re: High latency when running cyclictest
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Mr. Rostedt,

I sent you trace.data last week and i looked into it in kernelshark meanwhile.I
found it took more than 20us in _raw_spin_unlock_irq.

I looked into the code, the call stack is like that:

hrtimer_try_to_cancel -->
unlock_hrtimer_base -->
raw_spin_unlock_irqrestore -->
do_raw_spin_unlock -->
arch_spin_unlock

or

finish_task_switch -->
finish_lock_switch -->
raw_spin_unlock_irq -->
do_raw_spin_unlock -->
arch_spin_unlock

Normally, it's working fine, however it will be reproduced when a app is
being opened like firefox.

Have you ever had the same problem like latency from a spinlock?Could
you please share me some of
your experience in this case? many thanks.

PS:arch_spin_unlock in arch/arm64/include/asm/spinlock.h

#define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)

static inline void arch_spin_lock(arch_spinlock_t *lock)
{
        unsigned int tmp;
        arch_spinlock_t lockval, newval;

        asm volatile(
        /* Atomically increment the next ticket. */
        ARM64_LSE_ATOMIC_INSN(
        /* LL/SC */
"       prfm    pstl1strm, %3\n"
"1:     ldaxr   %w0, %3\n"
"       add     %w1, %w0, %w5\n"
"       stxr    %w2, %w1, %3\n"
"       cbnz    %w2, 1b\n",
        /* LSE atomics */
"       mov     %w2, %w5\n"
"       ldadda  %w2, %w0, %3\n"
        __nops(3)
        )

        /* Did we get the lock? */
"       eor     %w1, %w0, %w0, ror #16\n"
"       cbz     %w1, 3f\n"
        /*
         * No: spin on the owner. Send a local event to avoid missing an
         * unlock before the exclusive load.
         */
"       sevl\n"
"2:     wfe\n"
"       ldaxrh  %w2, %4\n"
"       eor     %w1, %w2, %w0, lsr #16\n"
"       cbnz    %w1, 2b\n"
        /* We got the lock. Critical section starts here. */
"3:"
        : "=&r" (lockval), "=&r" (newval), "=&r" (tmp), "+Q" (*lock)
        : "Q" (lock->owner), "I" (1 << TICKET_SHIFT)
        : "memory");
}

static inline int arch_spin_trylock(arch_spinlock_t *lock)
{
        unsigned int tmp;
        arch_spinlock_t lockval;

        asm volatile(ARM64_LSE_ATOMIC_INSN(
        /* LL/SC */
        "       prfm    pstl1strm, %2\n"
        "1:     ldaxr   %w0, %2\n"
        "       eor     %w1, %w0, %w0, ror #16\n"
        "       cbnz    %w1, 2f\n"
        "       add     %w0, %w0, %3\n"
        "       stxr    %w1, %w0, %2\n"
        "       cbnz    %w1, 1b\n"
        "2:",
        /* LSE atomics */
        "       ldr     %w0, %2\n"
        "       eor     %w1, %w0, %w0, ror #16\n"
        "       cbnz    %w1, 1f\n"
        "       add     %w1, %w0, %3\n"
        "       casa    %w0, %w1, %2\n"
        "       and     %w1, %w1, #0xffff\n"
        "       eor     %w1, %w1, %w0, lsr #16\n"
        "1:")
        : "=&r" (lockval), "=&r" (tmp), "+Q" (*lock)
        : "I" (1 << TICKET_SHIFT)
        : "memory");

        return !tmp;
}

static inline void arch_spin_unlock(arch_spinlock_t *lock)
{
        unsigned long tmp;

        asm volatile(ARM64_LSE_ATOMIC_INSN(
        /* LL/SC */
        "       ldrh    %w1, %0\n"
        "       add     %w1, %w1, #1\n"
        "       stlrh   %w1, %0",
        /* LSE atomics */
        "       mov     %w1, #1\n"
        "       staddlh %w1, %0\n"
        __nops(1))
        : "=Q" (lock->owner), "=&r" (tmp)
        :
        : "memory");
}

BR

chensong

On Wed, May 13, 2020 at 9:27 AM chen song <lhcs2008@gmail.com> wrote:
>
> Mr. Rostedt,
>
> The compressed trace.dat is in the attachment with trace-cmd report
> followed with "-l". Thanks again for helping me with this. Please let
> me know if there is anything i can do for further investigation.
>
> BR
>
> /Song
>
> On Tue, May 12, 2020 at 9:14 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Tue, 12 May 2020 18:56:10 +0800
> > chen song <lhcs2008@gmail.com> wrote:
> >
> > > Dear Rostedt,
> > >
> > > This is chensong who was asking question in #linux-rt channel. I
> > > upgrated my rt-tests to the lastest version (cyclictest V 1.80) and
> > > trace-cmd as well(trace-cmd version 2.9.dev).
> > >
> > > I ran commands like these:
> > > trace-cmd start -e irq -e sched -e timer -p function -l '*spin*';
> > > cyclictest -p 90 -m -c 0 -i 100 -h 100 -q -l 1000000 -b 80 --tracemark
> > > trace-cmd extract
> > > trace-cmd report
> > >
> >
> > BTW, trace-cmd report -l, will show the preemption numbers.
> >
> > > The log of last cycle before cyclictest reached the threshold and quit
> > > is like that:
> >
> > Your email client line wrapped everything, and it's unreadable.
> >
> > Can you send my the trace.dat file. Compress it first.
> >
> > Thanks,
> >
> > -- Steve
> >
> > >
> > >
> > > <idle>-0     [000]   130.330659: irq_handler_entry:    irq=4 name=arch_timer
> > > <idle>-0     [000]   130.330665: function:
> > > _raw_spin_lock_irqsave
> > > <idle>-0     [000]   130.330666: hrtimer_cancel:
> > > hrtimer=0xffffff801234bdc8
> > > <idle>-0     [000]   130.330667: function:
> > > _raw_spin_unlock_irqrestore
> > > <idle>-0     [000]   130.330668: hrtimer_expire_entry:
> > > hrtimer=0xffffff801234bdc8 now=130207149982 function=hrtimer_wakeup/0x0
> > > <idle>-0     [000]   130.330669: function:
> > > _raw_spin_lock_irqsave
> > > <idle>-0     [000]   130.330682: sched_waking:         comm=cyclictest
> > > pid=1720 prio=9 target_cpu=000
> > > <idle>-0     [000]   130.330695: function:             _raw_spin_lock
> > > <idle>-0     [000]   130.330697: function:             _raw_spin_lock
> > > <idle>-0     [000]   130.330699: sched_wakeup:         cyclictest:1720
> > > [9] success=1 CPU:000
> > > <idle>-0     [000]   130.330699: function:
> > > _raw_spin_unlock_irqrestore
> > > <idle>-0     [000]   130.330700: hrtimer_expire_exit:
> > > hrtimer=0xffffff801234bdc8
> > > <idle>-0     [000]   130.330701: function:             _raw_spin_lock_irq
> > > <idle>-0     [000]   130.330702: function:
> > > _raw_spin_unlock_irqrestore
> > > <idle>-0     [000]   130.330703: irq_handler_exit:     irq=4 ret=handled
> > >
> > > It took 44us from irq_handler_entry to irq_handler_exit, compare to
> > > normal case which generally took only around 15us, it produced around
> > > 30us extra latency. I also found something wrong like
> > > "_raw_spin_lock_irqsave from 130.330669 to 130.330682" and "sched_waking
> > > from 130.330682 to 130.330695".
> > >
> > > PS: cyclictest was running on CPU0 and a firefox was running on CPU1
> > > meanwhile.
> > >
> > > I tried to dig deeper, is there any way to find more information, please
> > > let me know, many thanks.
> > >
> > > Here is more log for reference:
> > >
> > > <idle>-0     [000]   130.330659: irq_handler_entry:    irq=4 name=arch_timer
> > >            <idle>-0     [000]   130.330665: function:
> > > _raw_spin_lock_irqsave
> > >            <idle>-0     [000]   130.330666: hrtimer_cancel:
> > > hrtimer=0xffffff801234bdc8
> > >            <idle>-0     [000]   130.330667: function:
> > > _raw_spin_unlock_irqrestore
> > >            <idle>-0     [000]   130.330668: hrtimer_expire_entry:
> > > hrtimer=0xffffff801234bdc8 now=130207149982 function=hrtimer_wakeup/0x0
> > >            <idle>-0     [000]   130.330669: function:
> > > _raw_spin_lock_irqsave
> > >            <idle>-0     [000]   130.330682: sched_waking:
> > > comm=cyclictest pid=1720 prio=9 target_cpu=000
> > >            <idle>-0     [000]   130.330695: function:
> > > _raw_spin_lock
> > >            <idle>-0     [000]   130.330697: function:
> > > _raw_spin_lock
> > >            <idle>-0     [000]   130.330699: sched_wakeup:
> > > cyclictest:1720 [9] success=1 CPU:000
> > >
> > >
> > >            <idle>-0     [000]   130.330699: function:
> > > _raw_spin_unlock_irqrestore
> > >            <idle>-0     [000]   130.330700: hrtimer_expire_exit:
> > > hrtimer=0xffffff801234bdc8
> > >            <idle>-0     [000]   130.330701: function:
> > > _raw_spin_lock_irq
> > >            <idle>-0     [000]   130.330702: function:
> > > _raw_spin_unlock_irqrestore
> > >            <idle>-0     [000]   130.330703: irq_handler_exit:     irq=4
> > > ret=handled
> > >
> > >           firefox-1722  [001]   130.330705: function:
> > > _raw_spin_lock_irqsave
> > >            <idle>-0     [000]   130.330706: function:
> > > _raw_spin_lock_irqsave
> > >            <idle>-0     [000]   130.330706: hrtimer_cancel:
> > > hrtimer=0xffffffc07ffbe960
> > >           firefox-1722  [001]   130.330706: function:
> > > _raw_spin_lock
> > >           firefox-1722  [001]   130.330707: function:
> > > _raw_spin_unlock_irqrestore
> > >            <idle>-0     [000]   130.330708: function:
> > > _raw_spin_unlock_irqrestore
> > >           firefox-1722  [001]   130.330708: function:
> > > rt_spin_lock
> > >            <idle>-0     [000]   130.330709: function:
> > > _raw_spin_lock_irqsave
> > >            <idle>-0     [000]   130.330709: hrtimer_start:
> > > hrtimer=0xffffffc07ffbe960 function=tick_sched_timer/0x0
> > > expires=130210000000 softexpires=130210000000
> > >            <idle>-0     [000]   130.330711: function:
> > > _raw_spin_unlock_irqrestore
> > >           firefox-1722  [001]   130.330711: function:
> > > rt_spin_unlock
> > >           firefox-1722  [001]   130.330712: function:
> > > _raw_spin_lock_irqsave
> > >            <idle>-0     [000]   130.330712: function:
> > > _raw_spin_lock
> > >           firefox-1722  [001]   130.330712: function:
> > > _raw_spin_lock
> > >           firefox-1722  [001]   130.330713: function:
> > > _raw_spin_unlock_irqrestore
> > >            <idle>-0     [000]   130.330713: sched_switch:
> > > swapper/0:0 [120] R ==> cyclictest:1720 [9]
> > >           firefox-1722  [001]   130.330714: function:
> > > _raw_spin_lock_irqsave
> > >
> > >        cyclictest-1720  [000]   130.330715: function:
> > > _raw_spin_unlock_irq
> > >           firefox-1722  [001]   130.330715: function:
> > > _raw_spin_lock
> > >           firefox-1722  [001]   130.330716: function:
> > > _raw_spin_unlock_irqrestore
> > >           firefox-1722  [001]   130.330718: function:
> > > _raw_spin_lock_irqsave
> > >           firefox-1722  [001]   130.330719: function:
> > > _raw_spin_lock
> > >           firefox-1722  [001]   130.330719: function:
> > > _raw_spin_unlock_irqrestore
> > >           firefox-1722  [001]   130.330722: function:
> > > rt_spin_lock
> > >           firefox-1722  [001]   130.330722: function:
> > > _raw_spin_lock_irqsave
> > >           firefox-1722  [001]   130.330723: function:
> > > _raw_spin_lock
> > >           firefox-1722  [001]   130.330724: function:
> > > _raw_spin_unlock_irqrestore
> > >           firefox-1722  [001]   130.330726: function:
> > > rt_spin_lock
> > >           firefox-1722  [001]   130.330727: function:
> > > rt_spin_unlock
> > >           firefox-1722  [001]   130.330728: function:
> > > rt_spin_lock
> > >           firefox-1722  [001]   130.330729: function:
> > > rt_spin_unlock
> > >           firefox-1722  [001]   130.330730: function:
> > > rt_spin_unlock
> > >           firefox-1722  [001]   130.330731: function:
> > > _raw_spin_lock_irqsave
> > >           firefox-1722  [001]   130.330732: function:
> > > _raw_spin_lock
> > >           firefox-1722  [001]   130.330733: function:
> > > _raw_spin_unlock_irqrestore
> > >        cyclictest-1720  [000]   130.330749: print:
> > > tracing_mark_write: hit latency threshold (84 > 80)
> > >
> > > BR
> > >
> > > /Song
> > >
> > > On Thu, May 7, 2020 at 4:56 PM chen song <lhcs2008@gmail.com> wrote:
> > > >
> > > > Dear experts,
> > > >
> > > > I had a 4.14.4 kernel with its rtpatch running on a dual-core arm64
> > > > device, the desktop is ubuntu.
> > > >
> > > > In general, the max latency of cyclictest is around 50us in empty load
> > > > which is acceptable. However, if i open a firefox duing cyclictest is
> > > > running, the max latency becomes higher up to 200us.
> > > >
> > > > I tried to use ftrace to debug this issue,"cyclictest -p 90 -m -c 0 -i
> > > > 10 -n -h 100 -q -l 10000000 -b 80", "-b 80" means enable ftrace event
> > > > and terminate cyclictest when latency is higher than 80us.
> > > >
> > > > Here is a piece of log:
> > > >
> > > > 6034916919us+: cpu_idle: state=1 cpu_id=1
> > > > 6034916981us+: hrtimer_cancel: hrtimer=ffffff8012663dc8
> > > > 6034916994us+: sched_waking: comm=cyclictest pid=2321 prio=9 target_cpu=001
> > > > 6034917032us+: cpu_idle: state=4294967295 cpu_id=1
> > > > 6034917044us+: hrtimer_start: hrtimer=ffffffc07ffd5960
> > > > function=tick_sched_timer expires=6034920000000
> > > > softexpires=6034920000000 mode=ABS|PINNED
> > > > 6034917066us+: sys_clock_nanosleep -> 0x0
> > > >
> > > > In this case, I can only see it's stalled in some points but i could'n
> > > > find what happens, in other words, the root cause of the latency.
> > > >
> > > > Is there any better way to debug this issue? I guess some of you might
> > > > meet the same issue, how did you approach to the root cause? I would
> > > > appreciate it so much if you could give me some advice, many thanks.
> > > >
> > > > Best regards,
> > > >
> > > > /Song
> > > >
> > > >
> > > > ============================================================
> > > > Here is the log for reference:
> > > >    <idle>-0       1d..h1.. 6034916878us : irq_handler_entry: irq=3
> > > > name=arch_timer    -- this is a normal routine
> > > >    <idle>-0       1d..h2.. 6034916879us : hrtimer_cancel:
> > > > hrtimer=ffffff8012663dc8
> > > >    <idle>-0       1d..h1.. 6034916879us : hrtimer_expire_entry:
> > > > hrtimer=ffffff8012663dc8 function=hrtimer_wakeup now=6034916525493
> > > >    <idle>-0       1d..h2.. 6034916880us : sched_waking: comm=cyclictest
> > > > pid=2321 prio=9 target_cpu=001
> > > >    <idle>-0       1dn.h3.. 6034916882us : sched_wakeup: comm=cyclictest
> > > > pid=2321 prio=9 target_cpu=001
> > > >    <idle>-0       1dn.h1.. 6034916883us : hrtimer_expire_exit:
> > > > hrtimer=ffffff8012663dc8
> > > >    <idle>-0       1dn.h1.. 6034916884us : irq_handler_exit: irq=3
> > > > ret=handled
> > > >    <idle>-0       1.n..1.. 6034916886us : cpu_idle: state=4294967295
> > > > cpu_id=1
> > > >    <idle>-0       1dn..2.. 6034916888us : hrtimer_cancel:
> > > > hrtimer=ffffffc07ffd5960
> > > >    <idle>-0       1dn..2.. 6034916890us : hrtimer_start:
> > > > hrtimer=ffffffc07ffd5960 function=tick_sched_timer expires=6034920000000
> > > > softexpires=6034920000000 mode=ABS|PINNED
> > > >    <idle>-0       1dn..1.. 6034916891us : rcu_utilization: Start context
> > > > switch
> > > >    <idle>-0       1dn..1.. 6034916892us : rcu_utilization: End context
> > > > switch
> > > >    <idle>-0       1d...2.. 6034916894us : sched_switch:
> > > > prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==>
> > > > next_comm=cyclictest next_pid=2321 next_prio=9
> > > > cyclicte-2321    1....... 6034916897us : kfree:
> > > > call_site=ffffff80081501f0 ptr=          (null)
> > > > cyclicte-2321    1....... 6034916898us : sys_exit: NR 115 = 0
> > > > cyclicte-2321    1....1.. 6034916898us : sys_clock_nanosleep -> 0x0
> > > > cyclicte-2321    1....... 6034916902us : sys_enter: NR 115 (1, 1,
> > > > 7fbd20b448, 0, 0, 7fbd20be00)
> > > > cyclicte-2321    1....1.. 6034916903us :
> > > > sys_clock_nanosleep(which_clock: 1, flags: 1, rqtp: 7fbd20b448, rmtp: 0)
> > > > cyclicte-2321    1....... 6034916904us : hrtimer_init:
> > > > hrtimer=ffffff8012663dc8 clockid=CLOCK_MONOTONIC mode=ABS
> > > > cyclicte-2321    1d...1.. 6034916906us : hrtimer_start:
> > > > hrtimer=ffffff8012663dc8 function=hrtimer_wakeup expires=6034916622448
> > > > softexpires=6034916622448 mode=ABS
> > > > cyclicte-2321    1d...1.. 6034916907us : rcu_utilization: Start context
> > > > switch
> > > > cyclicte-2321    1d...1.. 6034916908us : rcu_utilization: End context switch
> > > > cyclicte-2321    1d...2.. 6034916911us : sched_switch:
> > > > prev_comm=cyclictest prev_pid=2321 prev_prio=9 prev_state=S ==>
> > > > next_comm=swapper/1 next_pid=0 next_prio=120
> > > >    <idle>-0       1d...1.. 6034916915us : tick_stop: success=1
> > > > dependency=NONE
> > > >    <idle>-0       1d...2.. 6034916916us : hrtimer_cancel:
> > > > hrtimer=ffffffc07ffd5960
> > > >    <idle>-0       1d...2.. 6034916917us : hrtimer_start:
> > > > hrtimer=ffffffc07ffd5960 function=tick_sched_timer expires=6035010000000
> > > > softexpires=6035010000000 mode=ABS|PINNED
> > > >    <idle>-0       1d...1.. 6034916919us+: cpu_idle: state=1 cpu_id=1
> > > >                                      --(1)
> > > >    <idle>-0       1d..h1.. 6034916977us : irq_handler_entry: irq=3
> > > > name=arch_timer
> > > >    <idle>-0       1d..h2.. 6034916981us+: hrtimer_cancel:
> > > > hrtimer=ffffff8012663dc8                          --(2)
> > > >    <idle>-0       1d..h1.. 6034916993us : hrtimer_expire_entry:
> > > > hrtimer=ffffff8012663dc8 function=hrtimer_wakeup now=6034916628193
> > > >    <idle>-0       1d..h2.. 6034916994us+: sched_waking: comm=cyclictest
> > > > pid=2321 prio=9 target_cpu=001      --(3)
> > > >    <idle>-0       1dn.h3.. 6034917016us : sched_wakeup: comm=cyclictest
> > > > pid=2321 prio=9 target_cpu=001
> > > >    <idle>-0       1dn.h1.. 6034917016us : hrtimer_expire_exit:
> > > > hrtimer=ffffff8012663dc8
> > > >    <idle>-0       1dn.h1.. 6034917026us : irq_handler_exit: irq=3
> > > > ret=handled
> > > >    <idle>-0       1.n..1.. 6034917032us+: cpu_idle: state=4294967295
> > > > cpu_id=1                               --(4)
> > > >    <idle>-0       1dn..2.. 6034917043us : hrtimer_cancel:
> > > > hrtimer=ffffffc07ffd5960
> > > >    <idle>-0       1dn..2.. 6034917044us+: hrtimer_start:
> > > > hrtimer=ffffffc07ffd5960 function=tick_sched_timer expires=6034920000000
> > > > softexpires=6034920000000 mode=ABS|PINNED  --(5)
> > > >    <idle>-0       1dn..1.. 6034917056us : rcu_utilization: Start context
> > > > switch
> > > >    <idle>-0       1dn..1.. 6034917057us : rcu_utilization: End context
> > > > switch
> > > >    <idle>-0       1d...2.. 6034917062us : sched_switch:
> > > > prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==>
> > > > next_comm=cyclictest next_pid=2321 next_prio=9
> > > > cyclicte-2321    1....... 6034917065us : kfree:
> > > > call_site=ffffff80081501f0 ptr=          (null)
> > > > cyclicte-2321    1....... 6034917066us : sys_exit: NR 115 = 0
> > > > cyclicte-2321    1....1.. 6034917066us+: sys_clock_nanosleep -> 0x0
> > > >                                                      --(5)
> > > > cyclicte-2321    1....... 6034917142us : sys_enter: NR 64 (5,
> > > > 7fbd20c500, 1f, 7fbd20bf08, 2, 7fbd20be00)
> > > > cyclicte-2321    1....1.. 6034917143us : sys_write(fd: 5, buf:
> > > > 7fbd20c500, count: 1f)
> > > > cyclicte-2321    1....... 6034917151us : tracing_mark_write: hit latency
> > > > threshold (91 > 80)
> > > > cyclicte-2321    1....... 6034917155us : kfree:
> > > > call_site=ffffff80081501f0 ptr=          (null)
> > > > cyclicte-2321    1....... 6034917156us : sys_exit: NR 64 = 31
> > > > cyclicte-2321    1....1.. 6034917157us : sys_write -> 0x1f
> > > > cyclicte-2321    1....... 6034917159us : sys_enter: NR 64 (4, 408650, 1,
> > > > 7fbd20bf08, 2, 7fbd20be00)
> > > > cyclicte-2321    1....1.. 6034917160us : sys_write(fd: 4, buf: 408650,
> > > > count: 1)
> >
