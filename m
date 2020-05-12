Return-Path: <SRS0=+khU=62=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E024C54E4A
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 May 2020 10:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605DB20731
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 May 2020 10:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYbWnGSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgELK4Y (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 May 2020 06:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgELK4X (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 May 2020 06:56:23 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D700C061A0C
        for <linux-rt-users@vger.kernel.org>; Tue, 12 May 2020 03:56:23 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 72so10149568otu.1
        for <linux-rt-users@vger.kernel.org>; Tue, 12 May 2020 03:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=zV1rvzBrEWnkphVmZQHVDn0xFWQE92axMolzPRt+Bao=;
        b=hYbWnGSPO0WOBQz2axo9cILnoiRuxJH3bNYp6Qpt5xS2FG/0DNvHxooAEknY48dT47
         LdlRBdcmCVsYcS13A7mwMdsVNlEJpebnfHCAD1Lg4OEpnwjzk4AqL7BXo7Ome6DlQn8j
         I5fYmIq1B7fOyRYMtoxo9Sv9AqN2Q/siBRJ+oCGGIOxGVBUs90VmvFHCup08aaDYgjw7
         pBOZCYKBxja24T4SMy8ch/u0LRmQj50s8rbO+Q7eVKO1mZ6pjDxuR9TYAFEQA1XsaQ6Z
         cP0/z+O1TMDgywjLK2dInSaV5yU8p3MFaPLneje6AZvx2vRl6jmt8FTQrmKHUSfFk5TZ
         CMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=zV1rvzBrEWnkphVmZQHVDn0xFWQE92axMolzPRt+Bao=;
        b=tKHs9G04CDfMyAjRkIySYf1cH3Bhv8RXhn4XVl5e3PNUnZ0NZJ4fINhw+BIcbsIFZK
         1TkpSASjOeLa1ygzEk+rIHf1yzfTRkzfecBa7OljZMhZZJkkE7JgdJRVcGK4N4SOlsx7
         FyLxNrSQ08V6R8fLbll1JoR4deJ6YddGAgc1FJnV8AJ9dRbxRvkAV+yTlTkZK4+yQQWp
         8YZX2CF9K51Tdu4fm7C/eGRPZvfdLeP9eUQXn/UKmW8aExJ7qUYaVY/yaoWR7NFPPbjx
         gZhJbvyIijfCYuEXd9FYqo+Rp4rwbcTYOT6YZgDeEffjrfxTNXSEwXxBt1Nw7FSmb5F1
         QVpQ==
X-Gm-Message-State: AGi0Pubhfkx3LEeSfSrsC5ZLDPWO0URPd1ARRr09lbGv3JWEfUenJ1Ca
        Lnr5qpmDO9R8ibNpGH8zGFD6OBUYrcy+dz7CVCCWYeF326Y=
X-Google-Smtp-Source: APiQypIr/kTc/f/adbQjnnwKUPF51lF/phQNLCJ3K614LpUQY6cbe/FRKojTTp1nqcN16UunriuF4vEO3MwrC2IpyRI=
X-Received: by 2002:a05:6830:13d4:: with SMTP id e20mr16319233otq.66.1589280982385;
 Tue, 12 May 2020 03:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <CANAMpFTrYiiYoXSGVbVsNYqn-7W1v3qn8awUe=0Yv2SPepvTPg@mail.gmail.com>
In-Reply-To: <CANAMpFTrYiiYoXSGVbVsNYqn-7W1v3qn8awUe=0Yv2SPepvTPg@mail.gmail.com>
From:   chen song <lhcs2008@gmail.com>
Date:   Tue, 12 May 2020 18:56:10 +0800
Message-ID: <CANAMpFTwp-8RJHzd5ab=3pDJPMxjvh3dArxNrw_kN0L5MOB8jA@mail.gmail.com>
Subject: Re: High latency when running cyclictest
To:     linux-rt-users@vger.kernel.org, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear Rostedt,

This is chensong who was asking question in #linux-rt channel. I
upgrated my rt-tests to the lastest version (cyclictest V 1.80) and
trace-cmd as well(trace-cmd version 2.9.dev).

I ran commands like these:
trace-cmd start -e irq -e sched -e timer -p function -l '*spin*';
cyclictest -p 90 -m -c 0 -i 100 -h 100 -q -l 1000000 -b 80 --tracemark
trace-cmd extract
trace-cmd report

The log of last cycle before cyclictest reached the threshold and quit
is like that:


<idle>-0     [000]   130.330659: irq_handler_entry:    irq=4 name=arch_timer
<idle>-0     [000]   130.330665: function:
_raw_spin_lock_irqsave
<idle>-0     [000]   130.330666: hrtimer_cancel:
hrtimer=0xffffff801234bdc8
<idle>-0     [000]   130.330667: function:
_raw_spin_unlock_irqrestore
<idle>-0     [000]   130.330668: hrtimer_expire_entry:
hrtimer=0xffffff801234bdc8 now=130207149982 function=hrtimer_wakeup/0x0
<idle>-0     [000]   130.330669: function:
_raw_spin_lock_irqsave
<idle>-0     [000]   130.330682: sched_waking:         comm=cyclictest
pid=1720 prio=9 target_cpu=000
<idle>-0     [000]   130.330695: function:             _raw_spin_lock
<idle>-0     [000]   130.330697: function:             _raw_spin_lock
<idle>-0     [000]   130.330699: sched_wakeup:         cyclictest:1720
[9] success=1 CPU:000
<idle>-0     [000]   130.330699: function:
_raw_spin_unlock_irqrestore
<idle>-0     [000]   130.330700: hrtimer_expire_exit:
hrtimer=0xffffff801234bdc8
<idle>-0     [000]   130.330701: function:             _raw_spin_lock_irq
<idle>-0     [000]   130.330702: function:
_raw_spin_unlock_irqrestore
<idle>-0     [000]   130.330703: irq_handler_exit:     irq=4 ret=handled

It took 44us from irq_handler_entry to irq_handler_exit, compare to
normal case which generally took only around 15us, it produced around
30us extra latency. I also found something wrong like
"_raw_spin_lock_irqsave from 130.330669 to 130.330682" and "sched_waking
from 130.330682 to 130.330695".

PS: cyclictest was running on CPU0 and a firefox was running on CPU1
meanwhile.

I tried to dig deeper, is there any way to find more information, please
let me know, many thanks.

Here is more log for reference:

<idle>-0     [000]   130.330659: irq_handler_entry:    irq=4 name=arch_timer
           <idle>-0     [000]   130.330665: function:
_raw_spin_lock_irqsave
           <idle>-0     [000]   130.330666: hrtimer_cancel:
hrtimer=0xffffff801234bdc8
           <idle>-0     [000]   130.330667: function:
_raw_spin_unlock_irqrestore
           <idle>-0     [000]   130.330668: hrtimer_expire_entry:
hrtimer=0xffffff801234bdc8 now=130207149982 function=hrtimer_wakeup/0x0
           <idle>-0     [000]   130.330669: function:
_raw_spin_lock_irqsave
           <idle>-0     [000]   130.330682: sched_waking:
comm=cyclictest pid=1720 prio=9 target_cpu=000
           <idle>-0     [000]   130.330695: function:
_raw_spin_lock
           <idle>-0     [000]   130.330697: function:
_raw_spin_lock
           <idle>-0     [000]   130.330699: sched_wakeup:
cyclictest:1720 [9] success=1 CPU:000


           <idle>-0     [000]   130.330699: function:
_raw_spin_unlock_irqrestore
           <idle>-0     [000]   130.330700: hrtimer_expire_exit:
hrtimer=0xffffff801234bdc8
           <idle>-0     [000]   130.330701: function:
_raw_spin_lock_irq
           <idle>-0     [000]   130.330702: function:
_raw_spin_unlock_irqrestore
           <idle>-0     [000]   130.330703: irq_handler_exit:     irq=4
ret=handled

          firefox-1722  [001]   130.330705: function:
_raw_spin_lock_irqsave
           <idle>-0     [000]   130.330706: function:
_raw_spin_lock_irqsave
           <idle>-0     [000]   130.330706: hrtimer_cancel:
hrtimer=0xffffffc07ffbe960
          firefox-1722  [001]   130.330706: function:
_raw_spin_lock
          firefox-1722  [001]   130.330707: function:
_raw_spin_unlock_irqrestore
           <idle>-0     [000]   130.330708: function:
_raw_spin_unlock_irqrestore
          firefox-1722  [001]   130.330708: function:
rt_spin_lock
           <idle>-0     [000]   130.330709: function:
_raw_spin_lock_irqsave
           <idle>-0     [000]   130.330709: hrtimer_start:
hrtimer=0xffffffc07ffbe960 function=tick_sched_timer/0x0
expires=130210000000 softexpires=130210000000
           <idle>-0     [000]   130.330711: function:
_raw_spin_unlock_irqrestore
          firefox-1722  [001]   130.330711: function:
rt_spin_unlock
          firefox-1722  [001]   130.330712: function:
_raw_spin_lock_irqsave
           <idle>-0     [000]   130.330712: function:
_raw_spin_lock
          firefox-1722  [001]   130.330712: function:
_raw_spin_lock
          firefox-1722  [001]   130.330713: function:
_raw_spin_unlock_irqrestore
           <idle>-0     [000]   130.330713: sched_switch:
swapper/0:0 [120] R ==> cyclictest:1720 [9]
          firefox-1722  [001]   130.330714: function:
_raw_spin_lock_irqsave

       cyclictest-1720  [000]   130.330715: function:
_raw_spin_unlock_irq
          firefox-1722  [001]   130.330715: function:
_raw_spin_lock
          firefox-1722  [001]   130.330716: function:
_raw_spin_unlock_irqrestore
          firefox-1722  [001]   130.330718: function:
_raw_spin_lock_irqsave
          firefox-1722  [001]   130.330719: function:
_raw_spin_lock
          firefox-1722  [001]   130.330719: function:
_raw_spin_unlock_irqrestore
          firefox-1722  [001]   130.330722: function:
rt_spin_lock
          firefox-1722  [001]   130.330722: function:
_raw_spin_lock_irqsave
          firefox-1722  [001]   130.330723: function:
_raw_spin_lock
          firefox-1722  [001]   130.330724: function:
_raw_spin_unlock_irqrestore
          firefox-1722  [001]   130.330726: function:
rt_spin_lock
          firefox-1722  [001]   130.330727: function:
rt_spin_unlock
          firefox-1722  [001]   130.330728: function:
rt_spin_lock
          firefox-1722  [001]   130.330729: function:
rt_spin_unlock
          firefox-1722  [001]   130.330730: function:
rt_spin_unlock
          firefox-1722  [001]   130.330731: function:
_raw_spin_lock_irqsave
          firefox-1722  [001]   130.330732: function:
_raw_spin_lock
          firefox-1722  [001]   130.330733: function:
_raw_spin_unlock_irqrestore
       cyclictest-1720  [000]   130.330749: print:
tracing_mark_write: hit latency threshold (84 > 80)

BR

/Song

On Thu, May 7, 2020 at 4:56 PM chen song <lhcs2008@gmail.com> wrote:
>
> Dear experts,
>
> I had a 4.14.4 kernel with its rtpatch running on a dual-core arm64
> device, the desktop is ubuntu.
>
> In general, the max latency of cyclictest is around 50us in empty load
> which is acceptable. However, if i open a firefox duing cyclictest is
> running, the max latency becomes higher up to 200us.
>
> I tried to use ftrace to debug this issue,"cyclictest -p 90 -m -c 0 -i
> 10 -n -h 100 -q -l 10000000 -b 80", "-b 80" means enable ftrace event
> and terminate cyclictest when latency is higher than 80us.
>
> Here is a piece of log:
>
> 6034916919us+: cpu_idle: state=1 cpu_id=1
> 6034916981us+: hrtimer_cancel: hrtimer=ffffff8012663dc8
> 6034916994us+: sched_waking: comm=cyclictest pid=2321 prio=9 target_cpu=001
> 6034917032us+: cpu_idle: state=4294967295 cpu_id=1
> 6034917044us+: hrtimer_start: hrtimer=ffffffc07ffd5960
> function=tick_sched_timer expires=6034920000000
> softexpires=6034920000000 mode=ABS|PINNED
> 6034917066us+: sys_clock_nanosleep -> 0x0
>
> In this case, I can only see it's stalled in some points but i could'n
> find what happens, in other words, the root cause of the latency.
>
> Is there any better way to debug this issue? I guess some of you might
> meet the same issue, how did you approach to the root cause? I would
> appreciate it so much if you could give me some advice, many thanks.
>
> Best regards,
>
> /Song
>
>
> ============================================================
> Here is the log for reference:
>    <idle>-0       1d..h1.. 6034916878us : irq_handler_entry: irq=3
> name=arch_timer    -- this is a normal routine
>    <idle>-0       1d..h2.. 6034916879us : hrtimer_cancel:
> hrtimer=ffffff8012663dc8
>    <idle>-0       1d..h1.. 6034916879us : hrtimer_expire_entry:
> hrtimer=ffffff8012663dc8 function=hrtimer_wakeup now=6034916525493
>    <idle>-0       1d..h2.. 6034916880us : sched_waking: comm=cyclictest
> pid=2321 prio=9 target_cpu=001
>    <idle>-0       1dn.h3.. 6034916882us : sched_wakeup: comm=cyclictest
> pid=2321 prio=9 target_cpu=001
>    <idle>-0       1dn.h1.. 6034916883us : hrtimer_expire_exit:
> hrtimer=ffffff8012663dc8
>    <idle>-0       1dn.h1.. 6034916884us : irq_handler_exit: irq=3
> ret=handled
>    <idle>-0       1.n..1.. 6034916886us : cpu_idle: state=4294967295
> cpu_id=1
>    <idle>-0       1dn..2.. 6034916888us : hrtimer_cancel:
> hrtimer=ffffffc07ffd5960
>    <idle>-0       1dn..2.. 6034916890us : hrtimer_start:
> hrtimer=ffffffc07ffd5960 function=tick_sched_timer expires=6034920000000
> softexpires=6034920000000 mode=ABS|PINNED
>    <idle>-0       1dn..1.. 6034916891us : rcu_utilization: Start context
> switch
>    <idle>-0       1dn..1.. 6034916892us : rcu_utilization: End context
> switch
>    <idle>-0       1d...2.. 6034916894us : sched_switch:
> prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==>
> next_comm=cyclictest next_pid=2321 next_prio=9
> cyclicte-2321    1....... 6034916897us : kfree:
> call_site=ffffff80081501f0 ptr=          (null)
> cyclicte-2321    1....... 6034916898us : sys_exit: NR 115 = 0
> cyclicte-2321    1....1.. 6034916898us : sys_clock_nanosleep -> 0x0
> cyclicte-2321    1....... 6034916902us : sys_enter: NR 115 (1, 1,
> 7fbd20b448, 0, 0, 7fbd20be00)
> cyclicte-2321    1....1.. 6034916903us :
> sys_clock_nanosleep(which_clock: 1, flags: 1, rqtp: 7fbd20b448, rmtp: 0)
> cyclicte-2321    1....... 6034916904us : hrtimer_init:
> hrtimer=ffffff8012663dc8 clockid=CLOCK_MONOTONIC mode=ABS
> cyclicte-2321    1d...1.. 6034916906us : hrtimer_start:
> hrtimer=ffffff8012663dc8 function=hrtimer_wakeup expires=6034916622448
> softexpires=6034916622448 mode=ABS
> cyclicte-2321    1d...1.. 6034916907us : rcu_utilization: Start context
> switch
> cyclicte-2321    1d...1.. 6034916908us : rcu_utilization: End context switch
> cyclicte-2321    1d...2.. 6034916911us : sched_switch:
> prev_comm=cyclictest prev_pid=2321 prev_prio=9 prev_state=S ==>
> next_comm=swapper/1 next_pid=0 next_prio=120
>    <idle>-0       1d...1.. 6034916915us : tick_stop: success=1
> dependency=NONE
>    <idle>-0       1d...2.. 6034916916us : hrtimer_cancel:
> hrtimer=ffffffc07ffd5960
>    <idle>-0       1d...2.. 6034916917us : hrtimer_start:
> hrtimer=ffffffc07ffd5960 function=tick_sched_timer expires=6035010000000
> softexpires=6035010000000 mode=ABS|PINNED
>    <idle>-0       1d...1.. 6034916919us+: cpu_idle: state=1 cpu_id=1
>                                      --(1)
>    <idle>-0       1d..h1.. 6034916977us : irq_handler_entry: irq=3
> name=arch_timer
>    <idle>-0       1d..h2.. 6034916981us+: hrtimer_cancel:
> hrtimer=ffffff8012663dc8                          --(2)
>    <idle>-0       1d..h1.. 6034916993us : hrtimer_expire_entry:
> hrtimer=ffffff8012663dc8 function=hrtimer_wakeup now=6034916628193
>    <idle>-0       1d..h2.. 6034916994us+: sched_waking: comm=cyclictest
> pid=2321 prio=9 target_cpu=001      --(3)
>    <idle>-0       1dn.h3.. 6034917016us : sched_wakeup: comm=cyclictest
> pid=2321 prio=9 target_cpu=001
>    <idle>-0       1dn.h1.. 6034917016us : hrtimer_expire_exit:
> hrtimer=ffffff8012663dc8
>    <idle>-0       1dn.h1.. 6034917026us : irq_handler_exit: irq=3
> ret=handled
>    <idle>-0       1.n..1.. 6034917032us+: cpu_idle: state=4294967295
> cpu_id=1                               --(4)
>    <idle>-0       1dn..2.. 6034917043us : hrtimer_cancel:
> hrtimer=ffffffc07ffd5960
>    <idle>-0       1dn..2.. 6034917044us+: hrtimer_start:
> hrtimer=ffffffc07ffd5960 function=tick_sched_timer expires=6034920000000
> softexpires=6034920000000 mode=ABS|PINNED  --(5)
>    <idle>-0       1dn..1.. 6034917056us : rcu_utilization: Start context
> switch
>    <idle>-0       1dn..1.. 6034917057us : rcu_utilization: End context
> switch
>    <idle>-0       1d...2.. 6034917062us : sched_switch:
> prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==>
> next_comm=cyclictest next_pid=2321 next_prio=9
> cyclicte-2321    1....... 6034917065us : kfree:
> call_site=ffffff80081501f0 ptr=          (null)
> cyclicte-2321    1....... 6034917066us : sys_exit: NR 115 = 0
> cyclicte-2321    1....1.. 6034917066us+: sys_clock_nanosleep -> 0x0
>                                                      --(5)
> cyclicte-2321    1....... 6034917142us : sys_enter: NR 64 (5,
> 7fbd20c500, 1f, 7fbd20bf08, 2, 7fbd20be00)
> cyclicte-2321    1....1.. 6034917143us : sys_write(fd: 5, buf:
> 7fbd20c500, count: 1f)
> cyclicte-2321    1....... 6034917151us : tracing_mark_write: hit latency
> threshold (91 > 80)
> cyclicte-2321    1....... 6034917155us : kfree:
> call_site=ffffff80081501f0 ptr=          (null)
> cyclicte-2321    1....... 6034917156us : sys_exit: NR 64 = 31
> cyclicte-2321    1....1.. 6034917157us : sys_write -> 0x1f
> cyclicte-2321    1....... 6034917159us : sys_enter: NR 64 (4, 408650, 1,
> 7fbd20bf08, 2, 7fbd20be00)
> cyclicte-2321    1....1.. 6034917160us : sys_write(fd: 4, buf: 408650,
> count: 1)
