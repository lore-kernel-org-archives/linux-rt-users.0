Return-Path: <SRS0=m88/=7S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA57C433E1
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Jun 2020 01:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F128B2074B
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Jun 2020 01:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKGl/DRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgFEBr4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Jun 2020 21:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgFEBrz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Jun 2020 21:47:55 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1378DC08C5C0;
        Thu,  4 Jun 2020 18:47:55 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l27so8299028ejc.1;
        Thu, 04 Jun 2020 18:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=DCUSoifCy5YqNaE3/6nffH5CWdKiz1I6Xm0VF4456Qo=;
        b=fKGl/DRJadZzwhhXxlx8MGp8EXzprcm5bbdwAuAJ0dmbpKkGUfKMDesidQPBsXTcve
         tftn+pTsOX9rvW2SCdaGznHQ9WjGKvLBxCr3UrCe/1Zh7SkCbi2XFX0JZcdwYHoouCZJ
         oYNtOC/DxLWKFPLverBRGbTb/HfMhZ9pqr/BYyQn5Mm8KzRw/9n14+KFWOWpSI8R44ZD
         pcbJiX4v1DFGBVUu8WEbATnbWPk0Ytzr+NknjfMrqnYxljCQOoum6k7gKykPe/u34IbD
         rvoXKE3JJ6FrikVDzywGzICvxIYHIScdxIv/CAMK9ZTULKVRD0SjsA7qHOgyek/eCl+b
         MaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=DCUSoifCy5YqNaE3/6nffH5CWdKiz1I6Xm0VF4456Qo=;
        b=BnWR3JZbjGBslhdkQ01PDl2euOwEm2f4ihBYhRR1VPyUYNxorJPptnM9Dr1M0iHR9g
         eJKGJasE68qFiRIFknR+dPnHShLfm1JgHZIg0h8feS//3RgCt6mYXTzZuVhYmnuRGgR7
         zF65qmXd/lFdn7FnLGiFbJLkcew3Vv+lJORD8mnLspfdG5b7dna9X2vY7mF5Hsi0bKbf
         ojv3ODVXuVePLeWz3PQndulhNPav0CNomo38sej3+IKHbM9c6dZzGrJj0g+Bd2bhedjs
         QXp5nc+7KEKmDxL3r49gCjx7ii/4h8Fb3m2bDcGLsfExMJfPa2QDDh2cQ9dq3Zv2uDRf
         Zv9w==
X-Gm-Message-State: AOAM532R7WWgPSrWiO4KIzhsTAMoGid6UkkkXrOxcOkIghL2QgxMeEFd
        1QTBCN0qw9YBHIQqkgvSh4s=
X-Google-Smtp-Source: ABdhPJxXo2rg+j6XSJOs5YQ16bN3TtJnhiHCaoCdHswhuV7/LLvN9d+Ig4ajv1htt3PWbKCRPwHSZw==
X-Received: by 2002:a17:907:685:: with SMTP id wn5mr6779811ejb.283.1591321673494;
        Thu, 04 Jun 2020 18:47:53 -0700 (PDT)
Received: from [192.168.1.2] ([188.25.147.193])
        by smtp.gmail.com with ESMTPSA id n4sm3284234ejl.92.2020.06.04.18.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 18:47:53 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
Subject: stress-ng --hrtimers hangs system
To:     linux-rt-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Cc:     Colin King <colin.king@canonical.com>
Message-ID: <4781d250-9a29-cef3-268d-7d83c98bf16a@gmail.com>
Date:   Fri, 5 Jun 2020 04:47:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I was testing stress-ng on an ARM64 box and I found that it can be killed instantaneously with a --hrtimers 1 test:
https://github.com/ColinIanKing/stress-ng/blob/master/stress-hrtimers.c
The console shell locks up immediately after starting the process, and I get this rcu_preempt splat after 21 seconds,
letting me know that the grace-periods kernel thread could not run:

# stress-ng --hrtimers 1
stress-ng: info:  [320] defaulting to a 86400 second (1 day, 0.00 secs) run per stressor
stress-ng: info:  [320] dispatching hogs: 1 hrtimers
stress-ng: info:  [320] cache allocate: using defaults, can't determine cache details from sysfs
[   85.827528] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   85.833656]  (detected by 1, t=6502 jiffies, g=1789, q=12)
[   85.839163] rcu: All QSes seen, last rcu_preempt kthread activity 6502 (4294913720-4294907218), jiffies_till_next_fqs=1, root ->qsmask 0x0
[   85.851647] rcu: rcu_preempt kthread starved for 6502 jiffies! g1789 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
[   85.861859] rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[   85.871025] rcu: RCU grace-period kthread stack dump:
[   85.876094] rcu_preempt     R  running task        0    10      2 0x00000028
[   85.883173] Call trace:
[   85.885636]  __switch_to+0xf8/0x148
[   85.889137]  __schedule+0x2d8/0x808
[   85.892636]  schedule+0x48/0x100
[   85.895875]  schedule_timeout+0x1c8/0x420
[   85.899900]  rcu_gp_kthread+0x738/0x1b78
[   85.903836]  kthread+0x158/0x168
[   85.907075]  ret_from_fork+0x10/0x18
[   93.283548] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 33s!
[   93.291569] BUG: workqueue lockup - pool cpus=0-1 flags=0x4 nice=0 stuck for 33s!
[   93.299105] Showing busy workqueues and worker pools:
[   93.304189] workqueue events: flags=0x0
[   93.308116]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[   93.315031]     pending: vmstat_shepherd
[   93.318990] workqueue events_unbound: flags=0x2
[   93.323577]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=1/512 refcnt=3
[   93.330309]     pending: flush_to_ldisc
[   93.334161]
[   93.334164] ======================================================
[   93.334165] WARNING: possible circular locking dependency detected
[   93.334167] 5.7.0-08604-g7dcedf8c04c0 #118 Not tainted
[   93.334168] ------------------------------------------------------
[   93.334169] stress-ng-hrtim/326 is trying to acquire lock:
[   93.334171] ffffb236f6aee1a0 (console_owner){-.-.}-{0:0}, at: console_unlock+0x21c/0x678
[   93.334176]
[   93.334177] but task is already holding lock:
[   93.334178] ffff00207ac0d018 (&pool->lock/1){-.-.}-{2:2}, at: show_workqueue_state+0x288/0x3a8
[   93.334184]
[   93.334186] which lock already depends on the new lock.
[   93.334187]
[   93.334188]
[   93.334189] the existing dependency chain (in reverse order) is:
[   93.334190]
[   93.334191] -> #2 (&pool->lock/1){-.-.}-{2:2}:
[   93.334197]        _raw_spin_lock+0x5c/0x78
[   93.334198]        __queue_work+0x124/0x7c8
[   93.334199]        queue_work_on+0xd0/0xf0
[   93.334200]        tty_flip_buffer_push+0x3c/0x48
[   93.334202]        serial8250_rx_chars+0x74/0x88
[   93.334203]        fsl8250_handle_irq+0x15c/0x1a0
[   93.334204]        serial8250_interrupt+0x70/0xb8
[   93.334206]        __handle_irq_event_percpu+0xe0/0x478
[   93.334207]        handle_irq_event_percpu+0x40/0x98
[   93.334208]        handle_irq_event+0x4c/0xd0
[   93.334209]        handle_fasteoi_irq+0xb4/0x158
[   93.334211]        generic_handle_irq+0x3c/0x58
[   93.334212]        __handle_domain_irq+0x68/0xc0
[   93.334213]        gic_handle_irq+0x6c/0x160
[   93.334214]        el1_irq+0xbc/0x180
[   93.334216]        cpuidle_enter_state+0xb4/0x4f8
[   93.334217]        cpuidle_enter+0x3c/0x50
[   93.334218]        call_cpuidle+0x44/0x78
[   93.334219]        do_idle+0x228/0x2c8
[   93.334220]        cpu_startup_entry+0x2c/0x48
[   93.334222]        rest_init+0x1ac/0x280
[   93.334223]        arch_call_rest_init+0x14/0x1c
[   93.334224]        start_kernel+0x4ec/0x524
[   93.334225]
[   93.334226] -> #1 (&port->lock#2){-.-.}-{2:2}:
[   93.334232]        _raw_spin_lock_irqsave+0x78/0xa0
[   93.334233]        serial8250_console_write+0x1f4/0x348
[   93.334234]        univ8250_console_write+0x44/0x58
[   93.334235]        console_unlock+0x480/0x678
[   93.334237]        vprintk_emit+0x188/0x370
[   93.334238]        vprintk_default+0x48/0x58
[   93.334239]        vprintk_func+0xf0/0x238
[   93.334240]        printk+0x74/0x94
[   93.334241]        register_console+0x1a0/0x300
[   93.334243]        uart_add_one_port+0x4a0/0x4e0
[   93.334244]        serial8250_register_8250_port+0x2d0/0x4b0
[   93.334245]        of_platform_serial_probe+0x318/0x650
[   93.334246]        platform_drv_probe+0x58/0xa8
[   93.334248]        really_probe+0x10c/0x358
[   93.334249]        driver_probe_device+0x5c/0x100
[   93.334250]        device_driver_attach+0x74/0x98
[   93.334252]        __driver_attach+0x98/0xe0
[   93.334253]        bus_for_each_dev+0x84/0xd8
[   93.334254]        driver_attach+0x30/0x40  [   93.334255]        bus_add_driver+0x160/0x208
[   93.334256]        driver_register+0x64/0x110
[   93.334258]        __platform_driver_register+0x58/0x68
[   93.334259]        of_platform_serial_driver_init+0x20/0x28
[   93.334260]        do_one_initcall+0x94/0x438
[   93.334261]        kernel_init_freeable+0x2cc/0x338
[   93.334263]        kernel_init+0x18/0x110  [   93.334264]        ret_from_fork+0x10/0x18  [   93.334265]
[   93.334266] -> #0 (console_owner){-.-.}-{0:0}:
[   93.334271]        __lock_acquire+0x1170/0x1510
[   93.334272]        lock_acquire+0xf8/0x458  [   93.334273]        console_unlock+0x274/0x678
[   93.334274]        vprintk_emit+0x188/0x370
[   93.334275]        vprintk_default+0x48/0x58
[   93.334277]        vprintk_func+0xf0/0x238  [   93.334278]        printk+0x74/0x94
[   93.334279]        show_pwq+0x80/0x2c0
[   93.334280]        show_workqueue_state+0x2ac/0x3a8
[   93.334281]        wq_watchdog_timer_fn+0x194/0x2d8
[   93.334283]        call_timer_fn+0xcc/0x400
[   93.334284]        run_timer_softirq+0x250/0x6e0
[   93.334285]        __do_softirq+0x12c/0x5b4
[   93.334286]        irq_exit+0x13c/0x148
[   93.334287]        __handle_domain_irq+0x6c/0xc0
[   93.334289]        gic_handle_irq+0x6c/0x160
[   93.334290]        el1_irq+0xbc/0x180
[   93.334291]        lock_acquire+0x110/0x458
[   93.334292]        __might_fault+0x84/0xa8  [   93.334293]        __arm64_sys_rt_sigreturn+0x154/0x980
[   93.334295]        el0_svc_common.constprop.2+0x7c/0x178
[   93.334296]        do_el0_svc+0x34/0xa0
[   93.334297]        el0_sync_handler+0x160/0x1f0
[   93.334298]        el0_sync+0x140/0x180
[   93.334299]
[   93.334301] other info that might help us debug this:
[   93.334301]
[   93.334303] Chain exists of:
[   93.334303]   console_owner --> &port->lock#2 --> &pool->lock/1
[   93.334311]
[   93.334313]  Possible unsafe locking scenario:
[   93.334314]
[   93.334315]        CPU0                    CPU1
[   93.334316]        ----                    ----
[   93.334317]   lock(&pool->lock/1);
[   93.334321]                                lock(&port->lock#2);
[   93.334325]                                lock(&pool->lock/1);
[   93.334328]   lock(console_owner);
[   93.334331]
[   93.334332]  *** DEADLOCK ***
[   93.334333]
[   93.334334] 5 locks held by stress-ng-hrtim/326:
[   93.334335]  #0: ffff002077cf9a18 (&mm->mmap_sem){++++}-{3:3}, at: __might_fault+0x60/0xa8
[   93.334341]  #1: ffff800010003de0 ((&wq_watchdog_timer)){+.-.}-{0:0}, at: call_timer_fn+0x0/0x400
[   93.334347]  #2: ffffb236f6aefd60 (rcu_read_lock){....}-{1:2}, at: show_workqueue_state+0x0/0x3a8
[   93.334353]  #3: ffff00207ac0d018 (&pool->lock/1){-.-.}-{2:2}, at: show_workqueue_state+0x288/0x3a8
[   93.334360]  #4: ffffb236f6aee080 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x180/0x370
[   93.334366]
[   93.334367] stack backtrace:
[   93.334369] CPU: 0 PID: 326 Comm: stress-ng-hrtim Not tainted 5.7.0-08604-g7dcedf8c04c0 #118
[   93.334370] Hardware name: LS1028A RDB Board (DT)
[   93.334371] Call trace:
[   93.334372]  dump_backtrace+0x0/0x1a8
[   93.334373]  show_stack+0x24/0x30
[   93.334374]  dump_stack+0xe8/0x150
[   93.334376]  print_circular_bug.isra.41+0x228/0x280
[   93.334377]  check_noncircular+0x14c/0x1b0
[   93.334378]  __lock_acquire+0x1170/0x1510  [   93.334379]  lock_acquire+0xf8/0x458
[   93.334381]  console_unlock+0x274/0x678
[   93.334382]  vprintk_emit+0x188/0x370
[   93.334383]  vprintk_default+0x48/0x58
[   93.334384]  vprintk_func+0xf0/0x238
[   93.334385]  printk+0x74/0x94
[   93.334386]  show_pwq+0x80/0x2c0
[   93.334387]  show_workqueue_state+0x2ac/0x3a8
[   93.334389]  wq_watchdog_timer_fn+0x194/0x2d8
[   93.334390]  call_timer_fn+0xcc/0x400
[   93.334391]  run_timer_softirq+0x250/0x6e0
[   93.334392]  __do_softirq+0x12c/0x5b4
[   93.334393]  irq_exit+0x13c/0x148
[   93.334394]  __handle_domain_irq+0x6c/0xc0
[   93.334396]  gic_handle_irq+0x6c/0x160
[   93.334397]  el1_irq+0xbc/0x180
[   93.334398]  lock_acquire+0x110/0x458
[   93.334399]  __might_fault+0x84/0xa8
[   93.334400]  __arm64_sys_rt_sigreturn+0x154/0x980
[   93.334402]  el0_svc_common.constprop.2+0x7c/0x178
[   93.334403]  do_el0_svc+0x34/0xa0
[   93.334404]  el0_sync_handler+0x160/0x1f0  [   93.334405]  el0_sync+0x140/0x180
[   93.984979] workqueue events_freezable: flags=0x4
[   93.989705]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[   93.996522]     pending: mmc_rescan
[   94.000032] workqueue events_power_efficient: flags=0x82
[   94.005369]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/256 refcnt=6
[   94.011748]     pending: phy_state_machine, phy_state_machine, neigh_periodic_work, do_cache_clean
[   94.020761] workqueue pm: flags=0x4
[   94.024266]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[   94.031081]     pending: pm_runtime_work
[   94.035025]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[   94.041840]     pending: pm_runtime_work
[   94.045782] workqueue writeback: flags=0x4a
[   94.049984]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=1/256 refcnt=3
[   94.056362]     pending: wb_workfn
[   94.059784] workqueue kblockd: flags=0x18  [   94.063812]   pwq 3: cpus=1 node=0 flags=0x0 nice=-20 active=1/256 refcnt=2
[   94.070802]     pending: blk_mq_timeout_work

Looks like there's another issue in fsl8250_handle_irq, but I think that's unrelated so I'll ignore it.
So it looks like CPU 1 detects that the rcu_preempt kthread isn't scheduled, despite the fact that all
quiescent states were seen. So it looks like there is no RCU usage bug in here, but a legitimate CPU
starvation issue as far as I can see.

I have some noob questions:

- Is my system (hardware, drivers, kernel config) misconfigured? This can be reproduced at least on the
  NXP LS1028A running today's master branch with just the arm64 defconfig. On other hardware however
  (NXP T1040 PowerPC), RT throttling kicks in faster and the system doesn't hang (more below).

- What is the expected behavior of a system to this hrtimer test? Intuitively I would say the kenel
  shouldn't hang, but I don't exactly know what are the mechanisms to avoid that. Below are 2 things I tried.

- I tried to enable CONFIG_RCU_BOOST and had limited success. I could get rid of the RCU stall messages
  but the system would still hang after a longer while. When it hanged, it didn't even respond to ping
  from the outside, no shell, only magic sysrq could restart the kernel.

- I read a little bit of the "Limiting the CPU usage of real-time and deadline processes" chapter from
  man 7 sched. Is this what I should be doing? My /proc/sys/kernel/sched_rt_period_us and
  /proc/sys/kernel/sched_rt_runtime_us are set to their default values (RT period 1 second, RT runtime
  .95 seconds), why isn't that enough? If I reduce the RT runtime to .8 seconds while keeping the period
  at 1 second, RT throttling (finally!) kicks in and the system does not die.
  The RCU stall warning does keep, however, getting printed continuously.

[  385.732074] sched: RT throttling activated
[  385.883960] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  385.890077]  (detected by 1, t=6503 jiffies, g=1801, q=68)
[  385.895582] rcu: All QSes seen, last rcu_preempt kthread activity 6504 (4294988738-4294982234), jiffies_till_next_fqs=1, root ->qsmask 0x0
[  385.908062] rcu: rcu_preempt kthread starved for 6508 jiffies! g1801 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
[  385.918273] rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[  385.927437] rcu: RCU grace-period kthread stack dump:
[  385.932503] rcu_preempt     R  running task        0    11      2 0x00000028
[  385.939579] Call trace:
[  385.942040]  __switch_to+0xf8/0x148
[  385.945539]  __schedule+0x2d8/0x808
[  385.949036]  schedule+0x48/0x100
[  385.952273]  schedule_timeout+0x1c8/0x420
[  385.956295]  rcu_gp_kthread+0x704/0x1870
[  385.960228]  kthread+0x158/0x168
[  385.963464]  ret_from_fork+0x10/0x18
(...)
[  463.903959] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  463.910077]  (detected by 1, t=26008 jiffies, g=1801, q=148)
[  463.915756] rcu: All QSes seen, last rcu_preempt kthread activity 26009 (4295008243-4294982234), jiffies_till_next_fqs=1, root ->qsmask 0x0
[  463.928324] rcu: rcu_preempt kthread starved for 26013 jiffies! g1801 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
[  463.938622] rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[  463.947786] rcu: RCU grace-period kthread stack dump:
[  463.952852] rcu_preempt     R  running task        0    11      2 0x00000028
[  463.959928] Call trace:
[  463.962389]  __switch_to+0xf8/0x148
[  463.965888]  __schedule+0x2d8/0x808
[  463.969385]  schedule+0x48/0x100
[  463.972622]  schedule_timeout+0x1c8/0x420
[  463.976644]  rcu_gp_kthread+0x704/0x1870
[  463.980578]  kthread+0x158/0x168
[  463.983814]  ret_from_fork+0x10/0x18
(...)
[  541.923959] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  541.930076]  (detected by 1, t=45513 jiffies, g=1801, q=230)
[  541.935754] rcu: All QSes seen, last rcu_preempt kthread activity 45514 (4295027748-4294982234), jiffies_till_next_fqs=1, root ->qsmask 0x0
[  541.948322] rcu: rcu_preempt kthread starved for 45518 jiffies! g1801 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
[  541.958620] rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[  541.967784] rcu: RCU grace-period kthread stack dump:
[  541.972850] rcu_preempt     R  running task        0    11      2 0x00000028
[  541.979926] Call trace:
[  541.982387]  __switch_to+0xf8/0x148
[  541.985887]  __schedule+0x2d8/0x808
[  541.989384]  schedule+0x48/0x100
[  541.992621]  schedule_timeout+0x1c8/0x420
[  541.996643]  rcu_gp_kthread+0x704/0x1870
[  542.000576]  kthread+0x158/0x168
[  542.003813]  ret_from_fork+0x10/0x18

I would really appreciate some pointers.

Thanks,
-Vladimir
