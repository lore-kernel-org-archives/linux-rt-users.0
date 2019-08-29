Return-Path: <SRS0=tsCc=WZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72B9C3A59F
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Aug 2019 20:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815B423403
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Aug 2019 20:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJyeAJJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfH2Uzl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:55:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40881 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfH2Uzl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Aug 2019 16:55:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id h8so5541586edv.7
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Aug 2019 13:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Z/p2WiwmIABa8jaexIEM4WYKphipKMnN1P5g0bH8bnc=;
        b=aJyeAJJ8pLbOas6zQk+BiJZwCvdwrehlNQoKADrv6LggycO71AuNMG8MOvd6GaKsaS
         MxZVHA2BKWo3WskPGhh/OYfJGCUSKBRNMKhzagJzTSpP6E5sHPG8n1apq0QT6Xy+sSLQ
         RyvmASgdEAf3wv8dL2YkQ8GrOHm34Km9NBq6f3dzzHjdxcTvRMVh3rMkJYlwcqbhWL3w
         f5NL+HQQhzMEFLgPhJXNLEj0LDhA8Cukx3zJK4mTq1X0RJuT2sT4k0NfaFujiCDMlq3b
         2y7Ff94T9lOxll+8AhAJwt10K9XwNOuzWOb7T7/ARXRtNYoOLAdFRGYZj4fTkUaMgKlo
         Et/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Z/p2WiwmIABa8jaexIEM4WYKphipKMnN1P5g0bH8bnc=;
        b=k9gvF2ieAvvEH9AgAmPG77J/jpx678V1RB2wyqzVBfrrZHOTSWKMhIf0mLsaSBhurW
         0PqKSLaYd8ct9Elu/g9SUPcxd6Zx8vrLE1MfSmYXmc9K9/z9AnxqteH+Z6aAWA1zuIQW
         kRjf3DzXZniqUvPvz4bR0a3mODe9/xW+d/Mt0VEzSiDTDYE4UsXSDhZ1O8aFxhbpd1yz
         1pIot/aOfzVBlCp2+FK/B+sBv0Ir0Fvf7er1Xl+FeCZqxrCpBqaR1UxoAfbfbqxFgvle
         Aa4f4RpIYQc40wzRaB+S41VkmLLKG6N2TjUv29rcLu6Ufjapt6CNyuUAvk541lIgnjx6
         kXKw==
X-Gm-Message-State: APjAAAWzRbreFImEOdYTIIFyA2iZw+UN75baJtxAqOC/J4n4CKj/mCnS
        ov1bwMem3/t7Mz3wCkyxCgjpoD2KAvlWDjTRdRsSL2ND
X-Google-Smtp-Source: APXvYqxrNIb7kRrjlOctl8wZ+NebxuH/OQSm4lHv5KfFbzyBzLaCsSR7BiiuTUoP4f3SflCb7Z2/ou98ZYBemnbSmOM=
X-Received: by 2002:a17:906:4d88:: with SMTP id s8mr10138769eju.13.1567112138587;
 Thu, 29 Aug 2019 13:55:38 -0700 (PDT)
MIME-Version: 1.0
From:   Austin Schuh <austin.linux@gmail.com>
Date:   Thu, 29 Aug 2019 13:55:27 -0700
Message-ID: <CABsbf=Egk6wqEFPTvf9_UtVze80=b38nPzVOdZk-t=QOcUXCWw@mail.gmail.com>
Subject: Extra context switches with signalfd on CONFIG_PREEMPT_RT
To:     linux-rt-users@vger.kernel.org
Cc:     Brian Silverman <bsilver16384@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I'm trying to use signalfd and epoll to make 1 process wake up another
running an epoll loop.  This will be to signal the process to check
shared memory for new data to implement a broadcast pubsub system.
(I'm open to other options.  signalfd seemed like it had the least
amount of kernel in the middle.  Futexes don't allow me to wake up an
event loop.)

The basic flow is:
thread 1 (FIFO, priority 53, pinned to core 7) registers a signalfd
with epoll and goes to sleep waiting for the next event.
thread 2 (FIFO, priority 52, pinned to core 7) waits a random amount
of time, then sends a Real-Time signal to process 1.
thread 1 wakes up, reads the signal, and goes back to sleep
thread 2 repeats.

Based on the priorities above, I expect there to be 2 context
switches.  thread 2 will get interrupted after it sends the signal,
but before it can get back to sleep.  In reality, I see 6 context
switches on a RT kernel.

On mainline linux (4.19 kernel, Debian), the event trace looks like:

          <idle>-0     [007] d...   182.226422: sched_switch:
prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==>
next_comm=signal_stress next_pid=1659 next_prio=47
          <idle>-0     [007] d...   182.226425: tlb_flush: pages:0
reason:flush on task switch (0)
          <idle>-0     [007] d...   182.226428: write_msr: c0000100,
value 7f6a1a2c7700
          <idle>-0     [007] d...   182.226429:
x86_fpu_regs_activated: x86/fpu: 00000000edbd5f68 initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
   signal_stress-1659  [007] ....   182.226432: sys_exit: NR 230 = 0
   signal_stress-1659  [007] ....   182.226433: sys_clock_nanosleep -> 0x0
   signal_stress-1659  [007] ....   182.226441: sys_enter: NR 39
(7f6a1a2c5750, 23, 672c19ba, 7207dbacda930, 0, 7f6a1a5e6e80)
   signal_stress-1659  [007] ....   182.226442: sys_getpid()
   signal_stress-1659  [007] ....   182.226443: sys_exit: NR 39 = 1658
   signal_stress-1659  [007] ....   182.226444: sys_getpid -> 0x67a
   signal_stress-1659  [007] ....   182.226445: sys_enter: NR 102
(7f6a1a2c5750, 23, 672c19ba, 7207dbacda930, 0, 7f6a1a5e6e80)
   signal_stress-1659  [007] ....   182.226446: sys_getuid()
   signal_stress-1659  [007] ....   182.226447: sys_exit: NR 102 = 0
   signal_stress-1659  [007] ....   182.226447: sys_getuid -> 0x0
   signal_stress-1659  [007] ....   182.226448: sys_enter: NR 129
(67a, 23, 7f6a1a2c56d0, 7207dbacda930, 0, 7f6a1a5e6e80)
   signal_stress-1659  [007] ....   182.226449:
sys_rt_sigqueueinfo(pid: 67a, sig: 23, uinfo: 7f6a1a2c56d0)
   signal_stress-1659  [007] d...   182.226456: kmem_cache_alloc:
call_site=ffffffffb968a23e ptr=00000000fbd1b34b bytes_req=160
bytes_alloc=160 gfp_flags=GFP_ATOMIC
   signal_stress-1659  [007] d...   182.226459: sched_waking:
comm=signal_stress pid=1658 prio=46 target_cpu=007
   signal_stress-1659  [007] dN..   182.226460: sched_wakeup:
comm=signal_stress pid=1658 prio=46 target_cpu=007
   signal_stress-1659  [007] dN..   182.226462: signal_generate:
sig=35 errno=0 code=-1 comm=signal_stress pid=1658 grp=1 res=0
   signal_stress-1659  [007] .N..   182.226463: sys_exit: NR 129 = 0
   signal_stress-1659  [007] .N..   182.226463: sys_rt_sigqueueinfo -> 0x0
   signal_stress-1659  [007] dN..   182.226464: rcu_utilization: Start
context switch
   signal_stress-1659  [007] dN..   182.226464: rcu_utilization: End
context switch
   signal_stress-1659  [007] d...   182.226467: sched_switch:
prev_comm=signal_stress prev_pid=1659 prev_prio=47 prev_state=R ==>
next_comm=signal_stress next_pid=1658 next_prio=46
   signal_stress-1659  [007] d...   182.226469:
x86_fpu_regs_deactivated: x86/fpu: 00000000edbd5f68 initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
   signal_stress-1659  [007] d...   182.226469: write_msr: c0000100,
value 7f6a1a2caac0
   signal_stress-1659  [007] d...   182.226470:
x86_fpu_regs_activated: x86/fpu: 00000000f92b92a7 initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
   signal_stress-1658  [007] ....   182.226475: sys_exit: NR 232 = 1
   signal_stress-1658  [007] ....   182.226475: sys_epoll_wait -> 0x1
   signal_stress-1658  [007] ....   182.226478: sys_enter: NR 0 (4,
7ffd9c1e4368, 80, 7211594e9a230, 0, 7f6a1a2c7700)
   signal_stress-1658  [007] ....   182.226479: sys_read(fd: 4, buf:
7ffd9c1e4368, count: 80)
   signal_stress-1658  [007] d...   182.226485: kmem_cache_free:
call_site=ffffffffb968b1c7 ptr=00000000fbd1b34b
   signal_stress-1658  [007] ....   182.226486: sys_exit: NR 0 = 128
   signal_stress-1658  [007] ....   182.226487: sys_read -> 0x80
   signal_stress-1658  [007] ....   182.226489: sys_enter: NR 232 (5,
7ffd9c1e4420, 1, ffffffff, 0, 7f6a1a2c7700)
   signal_stress-1658  [007] ....   182.226490: sys_epoll_wait(epfd:
5, events: 7ffd9c1e4420, maxevents: 1, timeout: ffffffff)
   signal_stress-1658  [007] d...   182.226491: rcu_utilization: Start
context switch
   signal_stress-1658  [007] d...   182.226492: rcu_utilization: End
context switch
   signal_stress-1658  [007] d...   182.226494: sched_switch:
prev_comm=signal_stress prev_pid=1658 prev_prio=46 prev_state=S ==>
next_comm=signal_stress next_pid=1659 next_prio=47
   signal_stress-1658  [007] d...   182.226495:
x86_fpu_regs_deactivated: x86/fpu: 00000000f92b92a7 initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
   signal_stress-1658  [007] d...   182.226495: write_msr: c0000100,
value 7f6a1a2c7700
   signal_stress-1658  [007] d...   182.226496:
x86_fpu_regs_activated: x86/fpu: 00000000edbd5f68 initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
   signal_stress-1659  [007] ....   182.226498: sys_enter: NR 230 (1,
1, 7f6a1a2c5768, 0, 0, 7f6a1a5e6e80)
   signal_stress-1659  [007] ....   182.226499:
sys_clock_nanosleep(which_clock: 1, flags: 1, rqtp: 7f6a1a2c5768,
rmtp: 0)
   signal_stress-1659  [007] ....   182.226501: hrtimer_init:
hrtimer=00000000726eb8bb clockid=CLOCK_MONOTONIC mode=ABS
   signal_stress-1659  [007] d...   182.226502: hrtimer_start:
hrtimer=00000000726eb8bb function=hrtimer_wakeup expires=182126246984
softexpires=182126246984 mode=ABS
   signal_stress-1659  [007] d...   182.226503: rcu_utilization: Start
context switch
   signal_stress-1659  [007] d...   182.226503: rcu_utilization: End
context switch
   signal_stress-1659  [007] d...   182.226518: sched_switch:
prev_comm=signal_stress prev_pid=1659 prev_prio=47 prev_state=S ==>
next_comm=swapper/7 next_pid=0 next_prio=120
   signal_stress-1659  [007] d...   182.226520: tlb_flush: pages:0
reason:flush on task switch (0)
   signal_stress-1659  [007] d...   182.226521:
x86_fpu_regs_deactivated: x86/fpu: 00000000edbd5f68 initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
          <idle>-0     [007] d...   182.226530: cpu_idle: state=6 cpu_id=7
          <idle>-0     [007] d...   182.229346: cpu_idle:
state=4294967295 cpu_id=7

On both a National Instrument 4.9 RT kernel (Likely
https://github.com/ni/linux/tree/nilrt/18.1/4.9, but can confirm if it
matters), and a stock debian 4.19 RT kernel, I see an extra context
switch:

          <idle>-0     [007] dN..2..   356.375804: hrtimer_start:
hrtimer=000000005ea1a0f1 function=tick_sched_timer
expires=356267881251 softexpires=356267881251 mode=ABS|PINNED
          <idle>-0     [007] dN..1..   356.375807: rcu_utilization:
Start context switch
          <idle>-0     [007] dN..1..   356.375808: rcu_utilization:
End context switch
          <idle>-0     [007] d...2..   356.375812: sched_switch:
prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==>
next_comm=signal_stress next_pid=12775 next_prio=47
          <idle>-0     [007] d...2..   356.375814: tlb_flush: pages:0
reason:flush on task switch (0)
          <idle>-0     [007] d...2..   356.375817: write_msr:
c0000100, value 7fa4606be700
          <idle>-0     [007] d...2..   356.375818:
x86_fpu_regs_activated: x86/fpu: 000000008acd9e7a initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
   signal_stress-12775 [007] .......   356.375822: sys_exit: NR 230 = 0
   signal_stress-12775 [007] ....1..   356.375823: sys_clock_nanosleep -> 0x0
   signal_stress-12775 [007] .......   356.375830: sys_enter: NR 39
(7fa4606bc750, 23, f302278d, fc13f8daf66f4, 0, 7fa4609dde80)
   signal_stress-12775 [007] ....1..   356.375831: sys_getpid()
   signal_stress-12775 [007] .......   356.375833: sys_exit: NR 39 = 12774
   signal_stress-12775 [007] ....1..   356.375834: sys_getpid -> 0x31e6
   signal_stress-12775 [007] .......   356.375835: sys_enter: NR 102
(7fa4606bc750, 23, f302278d, fc13f8daf66f4, 0, 7fa4609dde80)
   signal_stress-12775 [007] ....1..   356.375835: sys_getuid()
   signal_stress-12775 [007] .......   356.375837: sys_exit: NR 102 = 0
   signal_stress-12775 [007] ....1..   356.375837: sys_getuid -> 0x0
   signal_stress-12775 [007] .......   356.375839: sys_enter: NR 129
(31e6, 23, 7fa4606bc6d0, fc13f8daf66f4, 0, 7fa4609dde80)
   signal_stress-12775 [007] ....1..   356.375839:
sys_rt_sigqueueinfo(pid: 31e6, sig: 23, uinfo: 7fa4606bc6d0)
   signal_stress-12775 [007] d...113   356.375850: sched_waking:
comm=signal_stress pid=12774 prio=46 target_cpu=007
   signal_stress-12775 [007] dN..213   356.375852: sched_wakeup:
comm=signal_stress pid=12774 prio=46 target_cpu=007
   signal_stress-12775 [007] dN..113   356.375853: rcu_utilization:
Start context switch
   signal_stress-12775 [007] dN..113   356.375854: rcu_utilization:
End context switch
   signal_stress-12775 [007] d...213   356.375858: sched_switch:
prev_comm=signal_stress prev_pid=12775 prev_prio=47 prev_state=R+ ==>
next_comm=signal_stress next_pid=12774 next_prio=46
   signal_stress-12775 [007] d...213   356.375859:
x86_fpu_regs_deactivated: x86/fpu: 000000008acd9e7a initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
   signal_stress-12775 [007] d...213   356.375860: write_msr:
c0000100, value 7fa4606c1ac0
   signal_stress-12775 [007] d...213   356.375861:
x86_fpu_regs_activated: x86/fpu: 00000000e4164be7 initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
   signal_stress-12774 [007] d...311   356.375865: sched_pi_setprio:
comm=signal_stress pid=12775 oldprio=47 newprio=46
   signal_stress-12774 [007] d...111   356.375868: rcu_utilization:
Start context switch
   signal_stress-12774 [007] d...111   356.375868: rcu_utilization:
End context switch
   signal_stress-12774 [007] d...211   356.375870: sched_switch:
prev_comm=signal_stress prev_pid=12774 prev_prio=46 prev_state=D ==>
next_comm=signal_stress next_pid=12775 next_prio=46
   signal_stress-12774 [007] d...211   356.375871:
x86_fpu_regs_deactivated: x86/fpu: 00000000e4164be7 initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
   signal_stress-12774 [007] d...211   356.375872: write_msr:
c0000100, value 7fa4606be700
   signal_stress-12774 [007] d...211   356.375872:
x86_fpu_regs_activated: x86/fpu: 000000008acd9e7a initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
   signal_stress-12775 [007] d...313   356.375874: sched_pi_setprio:
comm=signal_stress pid=12775 oldprio=46 newprio=47
   signal_stress-12775 [007] d...213   356.375877: sched_waking:
comm=signal_stress pid=12774 prio=46 target_cpu=007
   signal_stress-12775 [007] dN..313   356.375878: sched_wakeup:
comm=signal_stress pid=12774 prio=46 target_cpu=007
   signal_stress-12775 [007] dN..113   356.375879: rcu_utilization:
Start context switch
   signal_stress-12775 [007] dN..113   356.375879: rcu_utilization:
End context switch
   signal_stress-12775 [007] d...213   356.375881: sched_switch:
prev_comm=signal_stress prev_pid=12775 prev_prio=47 prev_state=R+ ==>
next_comm=signal_stress next_pid=12774 next_prio=46
   signal_stress-12775 [007] d...213   356.375882:
x86_fpu_regs_deactivated: x86/fpu: 000000008acd9e7a initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
   signal_stress-12775 [007] d...213   356.375882: write_msr:
c0000100, value 7fa4606c1ac0
   signal_stress-12775 [007] d...213   356.375883:
x86_fpu_regs_activated: x86/fpu: 00000000e4164be7 initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
   signal_stress-12774 [007] d...311   356.375888: sched_pi_setprio:
comm=signal_stress pid=12775 oldprio=47 newprio=46
   signal_stress-12774 [007] d...111   356.375889: rcu_utilization:
Start context switch
   signal_stress-12774 [007] d...111   356.375890: rcu_utilization:
End context switch
   signal_stress-12774 [007] d...211   356.375891: sched_switch:
prev_comm=signal_stress prev_pid=12774 prev_prio=46 prev_state=D ==>
next_comm=signal_stress next_pid=12775 next_prio=46
   signal_stress-12774 [007] d...211   356.375892:
x86_fpu_regs_deactivated: x86/fpu: 00000000e4164be7 initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
   signal_stress-12774 [007] d...211   356.375893: write_msr:
c0000100, value 7fa4606be700
   signal_stress-12774 [007] d...211   356.375893:
x86_fpu_regs_activated: x86/fpu: 000000008acd9e7a initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
   signal_stress-12775 [007] .....11   356.375895: signal_generate:
sig=35 errno=0 code=-1 comm=signal_stress pid=12774 grp=1 res=0
   signal_stress-12775 [007] d...311   356.375896: sched_pi_setprio:
comm=signal_stress pid=12775 oldprio=46 newprio=47
   signal_stress-12775 [007] d...211   356.375898: sched_waking:
comm=signal_stress pid=12774 prio=46 target_cpu=007
   signal_stress-12775 [007] dN..311   356.375899: sched_wakeup:
comm=signal_stress pid=12774 prio=46 target_cpu=007
   signal_stress-12775 [007] dN..111   356.375899: rcu_utilization:
Start context switch
   signal_stress-12775 [007] dN..111   356.375900: rcu_utilization:
End context switch
   signal_stress-12775 [007] d...211   356.375901: sched_switch:
prev_comm=signal_stress prev_pid=12775 prev_prio=47 prev_state=R+ ==>
next_comm=signal_stress next_pid=12774 next_prio=46
   signal_stress-12775 [007] d...211   356.375902:
x86_fpu_regs_deactivated: x86/fpu: 000000008acd9e7a initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
   signal_stress-12775 [007] d...211   356.375902: write_msr:
c0000100, value 7fa4606c1ac0
   signal_stress-12775 [007] d...211   356.375903:
x86_fpu_regs_activated: x86/fpu: 00000000e4164be7 initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
   signal_stress-12774 [007] .......   356.375907: sys_exit: NR 232 = 1
   signal_stress-12774 [007] ....1..   356.375907: sys_epoll_wait -> 0x1
   signal_stress-12774 [007] .......   356.375911: sys_enter: NR 0 (4,
7ffe4baa0458, 80, fc27d4794af1c, 0, 7fa4606be700)
   signal_stress-12774 [007] ....1..   356.375911: sys_read(fd: 4,
buf: 7ffe4baa0458, count: 80)
   signal_stress-12774 [007] .......   356.375918: sys_exit: NR 0 = 128
   signal_stress-12774 [007] ....1..   356.375918: sys_read -> 0x80
   signal_stress-12774 [007] .......   356.375920: sys_enter: NR 232
(5, 7ffe4baa0510, 1, ffffffff, 0, 7fa4606be700)
   signal_stress-12774 [007] ....1..   356.375921:
sys_epoll_wait(epfd: 5, events: 7ffe4baa0510, maxevents: 1, timeout:
ffffffff)
   signal_stress-12774 [007] d...1..   356.375926: rcu_utilization:
Start context switch
   signal_stress-12774 [007] d...1..   356.375927: rcu_utilization:
End context switch
   signal_stress-12774 [007] d...2..   356.375929: sched_switch:
prev_comm=signal_stress prev_pid=12774 prev_prio=46 prev_state=S ==>
next_comm=signal_stress next_pid=12775 next_prio=47
   signal_stress-12774 [007] d...2..   356.375930:
x86_fpu_regs_deactivated: x86/fpu: 00000000e4164be7 initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
   signal_stress-12774 [007] d...2..   356.375931: write_msr:
c0000100, value 7fa4606be700
   signal_stress-12774 [007] d...2..   356.375931:
x86_fpu_regs_activated: x86/fpu: 000000008acd9e7a initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
   signal_stress-12775 [007] .......   356.375933: sys_exit: NR 129 = 0
   signal_stress-12775 [007] ....1..   356.375934: sys_rt_sigqueueinfo -> 0x0
   signal_stress-12775 [007] .......   356.375936: sys_enter: NR 230
(1, 1, 7fa4606bc768, 0, 0, 7fa4609dde80)
   signal_stress-12775 [007] ....1..   356.375937:
sys_clock_nanosleep(which_clock: 1, flags: 1, rqtp: 7fa4606bc768,
rmtp: 0)
   signal_stress-12775 [007] .......   356.375938: hrtimer_init:
hrtimer=0000000083bbbc77 clockid=CLOCK_MONOTONIC mode=ABS
   signal_stress-12775 [007] d...1..   356.375940: hrtimer_start:
hrtimer=0000000083bbbc77 function=hrtimer_wakeup expires=356278389008
softexpires=356278389008 mode=ABS
   signal_stress-12775 [007] d...1..   356.375941: rcu_utilization:
Start context switch
   signal_stress-12775 [007] d...1..   356.375941: rcu_utilization:
End context switch
   signal_stress-12775 [007] d...2..   356.375957: sched_switch:
prev_comm=signal_stress prev_pid=12775 prev_prio=47 prev_state=S ==>
next_comm=swapper/7 next_pid=0 next_prio=120
   signal_stress-12775 [007] d...2..   356.375959: tlb_flush: pages:0
reason:flush on task switch (0)
   signal_stress-12775 [007] d...2..   356.375961:
x86_fpu_regs_deactivated: x86/fpu: 000000008acd9e7a initialized: 1
xfeatures: 3 xcomp_bv: 800000000000001f
          <idle>-0     [007] d...1..   356.375972: tick_stop:
success=1 dependency=NONE

I see something similar with named pipes.

This is still RT, but is pretty inefficient.  Any suggestions on what
might be going wrong before I start digging in?

Thanks,
  Austin
