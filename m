Return-Path: <SRS0=ggjn=6V=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A26CC38A24
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 May 2020 08:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B2120747
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 May 2020 08:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKkx3La5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgEGI4m (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 May 2020 04:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEGI4m (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 May 2020 04:56:42 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3022EC061A10
        for <linux-rt-users@vger.kernel.org>; Thu,  7 May 2020 01:56:42 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id j4so3847667otr.11
        for <linux-rt-users@vger.kernel.org>; Thu, 07 May 2020 01:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4ItZSX4Lo5tP/75IYSdQzX4hlvvY6QNX3KC6oW8lTmE=;
        b=UKkx3La50whsInS9TyDE35ybaU2Ndw79Uyocx/a3NAJCZ67/jn1fEhpeGbLbp50xWv
         j9CfAR2DJj/QLVM3AturWl9hRE57lcFDF2VMC7TwlzHK+YEMLoFRFHCM82dHGG8jSU6N
         L2J5rC1nu6kW/RiZhByU+bQwZSXocyFAqq/k+eiqSQEyJBIWJzTXTfNbv+CpvB3USA4g
         qv9sc7arj01xylHhEwWeuww/LeQC6DddLzJE41eA3ngevwH/w+v/cjT/q4GPaKgZE4wS
         1E4FdIH8qgnYnsHb81nD9XGwrKOYloiEfNVc5P7NZ2dNskasFxuT4SpxwLmPzYRVkHw/
         eECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4ItZSX4Lo5tP/75IYSdQzX4hlvvY6QNX3KC6oW8lTmE=;
        b=O1Bh+QIX9ADbjdM1YwwFDc/VXG3ONBPMgn+FbYNH6ucxE8Bp2OtVqpuqdvY7jzSJZu
         x+6/39tW/7pykJirVA3+7NMPzbUGhZEVi2M77UQ9qrBxGTKfSFEKS87awsFb0Cwwe/n5
         WHfwd2pDegAzsVKQevfxi6ADZs5zZb2NHX4aLyLM6zyZ5w45+/Du4FmU1gpYZKdaj+q9
         KhWXwtW/4xCWQkTOgG8BCneeR17a+PD3zz9PGVlPTNHSzWjC1xelkSTm8CG5JqB4vTeV
         LZUvMtk1Y4y0FTGT88sjlCSuTRbifPEOvtgo0ABykKlmLyO7ZADZU31UTW0GKWB93QFf
         BJ9w==
X-Gm-Message-State: AGi0PuZfE0LGoDidzjFXf3Qyo6Xp0Iw6zl/tuQ8UVTaFz+e7N+fOy3CT
        ntR6lFdur4RSJIsoRKui0irs2pd1SRq6BoOh7V456LT4IQw=
X-Google-Smtp-Source: APiQypIwBIC2iQIuKe0gS+w3uxic/62ZMVCZt3WwKE4tjnnAYOuVqXOB3FKyH/kEHl+tfm0mPd29NKyPzoKpSKLfJSE=
X-Received: by 2002:a05:6830:1446:: with SMTP id w6mr1516451otp.99.1588841800522;
 Thu, 07 May 2020 01:56:40 -0700 (PDT)
MIME-Version: 1.0
From:   chen song <lhcs2008@gmail.com>
Date:   Thu, 7 May 2020 16:56:29 +0800
Message-ID: <CANAMpFTrYiiYoXSGVbVsNYqn-7W1v3qn8awUe=0Yv2SPepvTPg@mail.gmail.com>
Subject: High latency when running cyclictest
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear experts,

I had a 4.14.4 kernel with its rtpatch running on a dual-core arm64
device, the desktop is ubuntu.

In general, the max latency of cyclictest is around 50us in empty load
which is acceptable. However, if i open a firefox duing cyclictest is
running, the max latency becomes higher up to 200us.

I tried to use ftrace to debug this issue,"cyclictest -p 90 -m -c 0 -i
10 -n -h 100 -q -l 10000000 -b 80", "-b 80" means enable ftrace event
and terminate cyclictest when latency is higher than 80us.

Here is a piece of log:

6034916919us+: cpu_idle: state=1 cpu_id=1
6034916981us+: hrtimer_cancel: hrtimer=ffffff8012663dc8
6034916994us+: sched_waking: comm=cyclictest pid=2321 prio=9 target_cpu=001
6034917032us+: cpu_idle: state=4294967295 cpu_id=1
6034917044us+: hrtimer_start: hrtimer=ffffffc07ffd5960
function=tick_sched_timer expires=6034920000000
softexpires=6034920000000 mode=ABS|PINNED
6034917066us+: sys_clock_nanosleep -> 0x0

In this case, I can only see it's stalled in some points but i could'n
find what happens, in other words, the root cause of the latency.

Is there any better way to debug this issue? I guess some of you might
meet the same issue, how did you approach to the root cause? I would
appreciate it so much if you could give me some advice, many thanks.

Best regards,

/Song


============================================================
Here is the log for reference:
   <idle>-0       1d..h1.. 6034916878us : irq_handler_entry: irq=3
name=arch_timer    -- this is a normal routine
   <idle>-0       1d..h2.. 6034916879us : hrtimer_cancel:
hrtimer=ffffff8012663dc8
   <idle>-0       1d..h1.. 6034916879us : hrtimer_expire_entry:
hrtimer=ffffff8012663dc8 function=hrtimer_wakeup now=6034916525493
   <idle>-0       1d..h2.. 6034916880us : sched_waking: comm=cyclictest
pid=2321 prio=9 target_cpu=001
   <idle>-0       1dn.h3.. 6034916882us : sched_wakeup: comm=cyclictest
pid=2321 prio=9 target_cpu=001
   <idle>-0       1dn.h1.. 6034916883us : hrtimer_expire_exit:
hrtimer=ffffff8012663dc8
   <idle>-0       1dn.h1.. 6034916884us : irq_handler_exit: irq=3
ret=handled
   <idle>-0       1.n..1.. 6034916886us : cpu_idle: state=4294967295
cpu_id=1
   <idle>-0       1dn..2.. 6034916888us : hrtimer_cancel:
hrtimer=ffffffc07ffd5960
   <idle>-0       1dn..2.. 6034916890us : hrtimer_start:
hrtimer=ffffffc07ffd5960 function=tick_sched_timer expires=6034920000000
softexpires=6034920000000 mode=ABS|PINNED
   <idle>-0       1dn..1.. 6034916891us : rcu_utilization: Start context
switch
   <idle>-0       1dn..1.. 6034916892us : rcu_utilization: End context
switch
   <idle>-0       1d...2.. 6034916894us : sched_switch:
prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==>
next_comm=cyclictest next_pid=2321 next_prio=9
cyclicte-2321    1....... 6034916897us : kfree:
call_site=ffffff80081501f0 ptr=          (null)
cyclicte-2321    1....... 6034916898us : sys_exit: NR 115 = 0
cyclicte-2321    1....1.. 6034916898us : sys_clock_nanosleep -> 0x0
cyclicte-2321    1....... 6034916902us : sys_enter: NR 115 (1, 1,
7fbd20b448, 0, 0, 7fbd20be00)
cyclicte-2321    1....1.. 6034916903us :
sys_clock_nanosleep(which_clock: 1, flags: 1, rqtp: 7fbd20b448, rmtp: 0)
cyclicte-2321    1....... 6034916904us : hrtimer_init:
hrtimer=ffffff8012663dc8 clockid=CLOCK_MONOTONIC mode=ABS
cyclicte-2321    1d...1.. 6034916906us : hrtimer_start:
hrtimer=ffffff8012663dc8 function=hrtimer_wakeup expires=6034916622448
softexpires=6034916622448 mode=ABS
cyclicte-2321    1d...1.. 6034916907us : rcu_utilization: Start context
switch
cyclicte-2321    1d...1.. 6034916908us : rcu_utilization: End context switch
cyclicte-2321    1d...2.. 6034916911us : sched_switch:
prev_comm=cyclictest prev_pid=2321 prev_prio=9 prev_state=S ==>
next_comm=swapper/1 next_pid=0 next_prio=120
   <idle>-0       1d...1.. 6034916915us : tick_stop: success=1
dependency=NONE
   <idle>-0       1d...2.. 6034916916us : hrtimer_cancel:
hrtimer=ffffffc07ffd5960
   <idle>-0       1d...2.. 6034916917us : hrtimer_start:
hrtimer=ffffffc07ffd5960 function=tick_sched_timer expires=6035010000000
softexpires=6035010000000 mode=ABS|PINNED
   <idle>-0       1d...1.. 6034916919us+: cpu_idle: state=1 cpu_id=1
                                     --(1)
   <idle>-0       1d..h1.. 6034916977us : irq_handler_entry: irq=3
name=arch_timer
   <idle>-0       1d..h2.. 6034916981us+: hrtimer_cancel:
hrtimer=ffffff8012663dc8                          --(2)
   <idle>-0       1d..h1.. 6034916993us : hrtimer_expire_entry:
hrtimer=ffffff8012663dc8 function=hrtimer_wakeup now=6034916628193
   <idle>-0       1d..h2.. 6034916994us+: sched_waking: comm=cyclictest
pid=2321 prio=9 target_cpu=001      --(3)
   <idle>-0       1dn.h3.. 6034917016us : sched_wakeup: comm=cyclictest
pid=2321 prio=9 target_cpu=001
   <idle>-0       1dn.h1.. 6034917016us : hrtimer_expire_exit:
hrtimer=ffffff8012663dc8
   <idle>-0       1dn.h1.. 6034917026us : irq_handler_exit: irq=3
ret=handled
   <idle>-0       1.n..1.. 6034917032us+: cpu_idle: state=4294967295
cpu_id=1                               --(4)
   <idle>-0       1dn..2.. 6034917043us : hrtimer_cancel:
hrtimer=ffffffc07ffd5960
   <idle>-0       1dn..2.. 6034917044us+: hrtimer_start:
hrtimer=ffffffc07ffd5960 function=tick_sched_timer expires=6034920000000
softexpires=6034920000000 mode=ABS|PINNED  --(5)
   <idle>-0       1dn..1.. 6034917056us : rcu_utilization: Start context
switch
   <idle>-0       1dn..1.. 6034917057us : rcu_utilization: End context
switch
   <idle>-0       1d...2.. 6034917062us : sched_switch:
prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==>
next_comm=cyclictest next_pid=2321 next_prio=9
cyclicte-2321    1....... 6034917065us : kfree:
call_site=ffffff80081501f0 ptr=          (null)
cyclicte-2321    1....... 6034917066us : sys_exit: NR 115 = 0
cyclicte-2321    1....1.. 6034917066us+: sys_clock_nanosleep -> 0x0
                                                     --(5)
cyclicte-2321    1....... 6034917142us : sys_enter: NR 64 (5,
7fbd20c500, 1f, 7fbd20bf08, 2, 7fbd20be00)
cyclicte-2321    1....1.. 6034917143us : sys_write(fd: 5, buf:
7fbd20c500, count: 1f)
cyclicte-2321    1....... 6034917151us : tracing_mark_write: hit latency
threshold (91 > 80)
cyclicte-2321    1....... 6034917155us : kfree:
call_site=ffffff80081501f0 ptr=          (null)
cyclicte-2321    1....... 6034917156us : sys_exit: NR 64 = 31
cyclicte-2321    1....1.. 6034917157us : sys_write -> 0x1f
cyclicte-2321    1....... 6034917159us : sys_enter: NR 64 (4, 408650, 1,
7fbd20bf08, 2, 7fbd20be00)
cyclicte-2321    1....1.. 6034917160us : sys_write(fd: 4, buf: 408650,
count: 1)
