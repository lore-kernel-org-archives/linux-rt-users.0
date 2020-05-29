Return-Path: <SRS0=xga9=7L=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2834AC433DF
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 May 2020 08:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E306B207BC
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 May 2020 08:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pR97UXMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgE2IIR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 May 2020 04:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgE2IIO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 May 2020 04:08:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA0CC03E969
        for <linux-rt-users@vger.kernel.org>; Fri, 29 May 2020 01:08:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h4so2162261wmb.4
        for <linux-rt-users@vger.kernel.org>; Fri, 29 May 2020 01:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BYoKb1ZwXWdA+/acuUHerHojHOVMSLm9UoOs8rK8P7o=;
        b=pR97UXMokn5/7AKmtWLhqI2zPd3m5nxtQrLP0K+peMwlVkfDXQel32fLQDAgxRe4KQ
         /Zf9hAYPmggR4mxL5DuTeZ/IR07dHhrigVJr+Kzw3vNenxlJkvte16gqRkIPgcjlIOqq
         ba8zerCOMXMriHCJ9lQIIxZRVbrq8pRMXPugw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BYoKb1ZwXWdA+/acuUHerHojHOVMSLm9UoOs8rK8P7o=;
        b=DDOABPkeuf4aIqqiyeYOE42d55zvo9G0ybBeORehaM4aY9UAq/3C0ddHaiim3liE0I
         FhI9O3X2moc3bGKJfQqRp03c/VR4EsScaQAGpzwfa/15u77J5E3NgbqLQ8IzD88a5zQF
         fTI3CRF6ahe6wUQWIiNsL7ERzZ3D9LKSyyXUvWqDTLbm110D7xPrVtBOwb7DL4xwhArY
         BY2yv3RwYUNPrJxvxQHiiXj8WU3fP3nYv5lc37ws27p5Cf6s57x4H4jiNJ1JkM3RAaF/
         6qZ2QvUTmmRJWk7zT6JfAfmCtlU4aJXZghOh2lKdwFGsogqzNMvZsYGO6KGR1zIPp2EQ
         RSug==
X-Gm-Message-State: AOAM533uGyCMEDTuc2kajJ3+5PT9hpnEV+GBB6jU0vg7MgV8xuOijXqr
        eEJlzIkYkAnKv5ItLZViODkoV6TuDiF935yvU0uu1d3Bhag=
X-Google-Smtp-Source: ABdhPJwTPvAwBYG4lusQc7e0OVF2pROXLDZsf1ei5tYHbTcyWgXI9TQ0RjasPhT2ECi/Jl+mmSI1Daj0Fr9sp9DnMaE=
X-Received: by 2002:a1c:5411:: with SMTP id i17mr7675147wmb.137.1590739692897;
 Fri, 29 May 2020 01:08:12 -0700 (PDT)
MIME-Version: 1.0
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Fri, 29 May 2020 10:08:01 +0200
Message-ID: <CAOf5uw=DU4KdLXt=VEU+Uv3+W3jUMXE393FO3_v2smScR6Xf-Q@mail.gmail.com>
Subject: linux-rt stall on imx6dl on patch-5.4.22-rt13.patch
To:     LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi all

I get this stack trace
echo 3 > /proc/sys/vm/drop_caches chrt -f 99 sysbench --test=cpu --num-threads=2

First of all, I need to know that if it is a valid use case because
was raised by the testing team and
how can I start and where to take a look at it

Best Regards
Michael

[  161.709260] 001: sh (480): drop_caches: 3
[  180.234358] 001: sched: RT throttling activated
[  180.283363] 001: fec 2188000.ethernet eth0: MDIO read timeout
[  180.283406] 001: ------------[ cut here ]------------
[  180.283416] 001: WARNING: CPU: 1 PID: 133 at
drivers/net/phy/phy.c:716 phy_er

                                               ror+0x24/0x64
[  180.283460] 001: Modules linked in:
[  180.283473] 001: CPU: 1 PID: 133 Comm: kworker/1:2 Tainted: G
 W

                          5.4.23-rt13 #1
[  180.283494] 001: Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  180.283531] 001: Workqueue: events_power_efficient phy_state_machine
[  180.283550] 001: [<c0113880>] (unwind_backtrace) from [<c010d498>]
(show_stac

                         k+0x10/0x14)
[  180.283591] 001: [<c010d498>] (show_stack) from [<c0c95ee4>]
(dump_stack+0xd4

                               /0x108)
[  180.283624] 001: [<c0c95ee4>] (dump_stack) from [<c0129588>]
(__warn+0xc0/0x1

                               0c)
[  180.283657] 001: [<c0129588>] (__warn) from [<c0129998>]
(warn_slowpath_fmt+0

                                   x5c/0xc0)
[  180.283680] 001: [<c0129998>] (warn_slowpath_fmt) from [<c07b3fcc>]
(phy_erro

                        r+0x24/0x64)
[  180.283706] 001: [<c07b3fcc>] (phy_error) from [<c07b5198>]
(phy_state_machin

                                e+0x68/0x148)
[  180.283727] 001: [<c07b5198>] (phy_state_machine) from [<c014b25c>]
(process_

                        one_work+0x2c8/0x884)
[  180.283760] 001: [<c014b25c>] (process_one_work) from [<c014b844>]
(worker_th

                         read+0x2c/0x580)
[  180.283785] 001: [<c014b844>] (worker_thread) from [<c0153790>]
(kthread+0x13

                            4/0x148)
[  180.283815] 001: [<c0153790>] (kthread) from [<c01010bc>]
(ret_from_fork+0x14

                                  /0x38)
[  180.283836] 001: Exception stack(0xd8873fb0 to 0xd8873ff8)
[  180.283854] 001: 3fa0:                                     00000000
00000000

                        00000000 00000000
[  180.283874] 001: 3fc0: 00000000 00000000 00000000 00000000 00000000
00000000

                        00000000 00000000
[  180.283890] 001: 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  181.243070] 001: irq event stamp: 52613
[  181.243094] 001: hardirqs last  enabled at (52615): [<c0c9d23c>]
prb_unlock+0

                           x84/0x94
[  181.243134] 001: hardirqs last disabled at (52616): [<c0c9d138>]
prb_lock+0xb

                           4/0x134
[  181.243151] 001: softirqs last  enabled at (42468): [<c0ab1f80>]
addrconf_ver

                           ify_rtnl+0x20c/0x620
[  181.243180] 001: softirqs last disabled at (42461): [<c0ab1d88>]
addrconf_ver

                           ify_rtnl+0x14/0x620
[  181.243196] 001: ---[ end trace 0000000000000005 ]---
[  181.244845] 001: fec 2188000.ethernet eth0: Link is Down
[  182.243188] 001: fec 2188000.ethernet eth0: MDIO read timeout
[  205.253023] 001: rcu: INFO: rcu_preempt self-detected stall on CPU
[  205.253041] 001: rcu:        1-...!: (2599 ticks this GP)
idle=50a/0/0x1 softirq=0/0 fqs=0
[  205.253060] 001:     (t=2600 jiffies g=7097 q=301)
[  205.253061] 001: rcu: rcu_preempt kthread starved for 2600 jiffies!
g7097 f0x0 RCU_GP_WAIT_FQS(5) ->st

                        ate=0x0 ->cpu=0
[  205.253071] 001: rcu: RCU grace-period kthread stack dump:
[  205.253078] 001: rcu_preempt     R  running task        0    10
 2 0x00000000
[  205.253096] 001: [<c0cb23b4>] (__schedule) from [<c0cb2900>]
(schedule+0x50/0xf8)
[  205.253121] 001: [<c0cb2900>] (schedule) from [<c0cb5fe0>]
(schedule_timeout+0x1bc/0x39c)
[  205.253137] 001: [<c0cb5fe0>] (schedule_timeout) from [<c01ad90c>]
(rcu_gp_kthread+0x764/0x246c)
[  205.253160] 001: [<c01ad90c>] (rcu_gp_kthread) from [<c0153790>]
(kthread+0x134/0x148)
[  205.253176] 001: [<c0153790>] (kthread) from [<c01010bc>]
(ret_from_fork+0x14/0x38)
[  205.253190] 001: Exception stack(0xd80e7fb0 to 0xd80e7ff8)
[  205.253198] 001: 7fa0:                                     00000000
00000000 00000000 00000000
[  205.253208] 001: 7fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  205.253217] 001: 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  205.253231] 001: NMI backtrace for cpu 1
[  205.253238] 001: CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
       5.4.23-rt13 #1
[  205.253246] 001: Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  205.253253] 001: [<c0113880>] (unwind_backtrace) from [<c010d498>]
(show_stack+0x10/0x14)
[  205.253271] 001: [<c010d498>] (show_stack) from [<c0c95ee4>]
(dump_stack+0xd4/0x108)
[  205.253288] 001: [<c0c95ee4>] (dump_stack) from [<c0c9cc44>]
(nmi_cpu_backtrace+0x74/0xac)
[  205.253303] 001: [<c0c9cc44>] (nmi_cpu_backtrace) from [<c0c9cdc0>]
(nmi_trigger_cpumask_backtrace+0x1

                        44/0x1ac)
[  205.253315] 001: [<c0c9cdc0>] (nmi_trigger_cpumask_backtrace) from
[<c01b4678>] (rcu_dump_cpu_stacks+0

                         x98/0xd0)
[  205.253329] 001: [<c01b4678>] (rcu_dump_cpu_stacks) from
[<c01b35d4>] (rcu_sched_clock_irq+0x824/0xb48

                                   )
[  205.253344] 001: [<c01b35d4>] (rcu_sched_clock_irq) from
[<c01bc950>] (update_process_times+0x2c/0x60)
[  205.253361] 001: [<c01bc950>] (update_process_times) from
[<c01d31e0>] (tick_sched_timer+0x64/0xcc)
[  205.253376] 001: [<c01d31e0>] (tick_sched_timer) from [<c01bd9c8>]
(__hrtimer_run_queues+0x170/0x788)
[  205.253388] 001: [<c01bd9c8>] (__hrtimer_run_queues) from
[<c01bf378>] (hrtimer_interrupt+0x130/0x2d8)
[  205.253400] 001: [<c01bf378>] (hrtimer_interrupt) from [<c01128b4>]
(twd_handler+0x2c/0x38)
[  205.253413] 001: [<c01128b4>] (twd_handler) from [<c019ab28>]
(handle_percpu_devid_irq+0xf0/0x4dc)
[  205.253429] 001: [<c019ab28>] (handle_percpu_devid_irq) from
[<c01941d4>] (generic_handle_irq+0x20/0x3

                               4)
[  205.253446] 001: [<c01941d4>] (generic_handle_irq) from
[<c0194818>] (__handle_domain_irq+0x8c/0x128)
[  205.253457] 001: [<c0194818>] (__handle_domain_irq) from
[<c0550d6c>] (gic_handle_irq+0x4c/0xa8)
[  205.253473] 001: [<c0550d6c>] (gic_handle_irq) from [<c0101ab0>]
(__irq_svc+0x70/0xc4)
[  205.253483] 001: Exception stack(0xd80f9f10 to 0xd80f9f58)
[  205.253491] 001: 9f00:                                     00000001
00000006 00000000 d80ec600
[  205.253501] 001: 9f20: 00000000 c1318854 c1401768 ca083cee c9ae857c
0000002f dbbb2ab8 00000000
[  205.253510] 001: 9f40: 00000000 d80f9f60 c0187400 c08c60bc 200d0113 ffffffff
[  205.253516] 001: [<c0101ab0>] (__irq_svc) from [<c08c60bc>]
(cpuidle_enter_state+0x168/0x6c0)
[  205.253530] 001: [<c08c60bc>] (cpuidle_enter_state) from
[<c08c6650>] (cpuidle_enter+0x28/0x38)
[  205.253540] 001: [<c08c6650>] (cpuidle_enter) from [<c0164b00>]
(do_idle+0x258/0x2e4)
[  205.253553] 001: [<c0164b00>] (do_idle) from [<c0164ed8>]
(cpu_startup_entry+0x18/0x20)
[  205.253563] 001: [<c0164ed8>] (cpu_startup_entry) from [<1010296c>]
(0x1010296c)
[  227.234448] 000: mmc1: Timeout waiting for hardware interrupt.
[  227.234472] 000: mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[  227.234486] 000: mmc1: sdhci: Sys addr:  0x18e7d800 | Version:  0x00000002
[  227.234502] 000: mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000000
[  227.234515] 000: mmc1: sdhci: Argument:  0x000570bc | Trn mode: 0x0000003b
[  227.234527] 000: mmc1: sdhci: Present:   0x01fd8008 | Host ctl: 0x00000013
[  227.234539] 000: mmc1: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
[  227.234550] 000: mmc1: sdhci: Wake-up:   0x00000008 | Clock:    0x0000001f
[  227.234560] 000: mmc1: sdhci: Timeout:   0x0000008f | Int stat: 0x00000003
[  227.234570] 000: mmc1: sdhci: Int enab:  0x117f100b | Sig enab: 0x117f100b
[  227.234582] 000: mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000103
[  227.234593] 000: mmc1: sdhci: Caps:      0x07eb0000 | Caps_1:   0x0000a000
[  227.234606] 000: mmc1: sdhci: Cmd:       0x0000123a | Max curr: 0x00ffffff
[  227.234617] 000: mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
[  227.234629] 000: mmc1: sdhci: Resp[2]:   0x320f5903 | Resp[3]:  0x00000900
[  227.234640] 000: mmc1: sdhci: Host ctl2: 0x00000000
[  227.234650] 000: mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x2c047208
[  227.234661] 000: mmc1: sdhci: ============================================
[  283.293246] 001: rcu: INFO: rcu_preempt self-detected stall on CPU
[  283.293276] 001: rcu:        1-...!: (10403 ticks this GP)
idle=77a/1/0x40000002 softirq=0/0 fqs=0
[  283.293313] 001:     (t=10404 jiffies g=7097 q=827)
[  283.293316] 001: rcu: rcu_preempt kthread starved for 10404
jiffies! g7097 f0x0 RCU_GP_WAIT_FQS(5) ->s

                                tate=0x0 ->cpu=0
[  283.293336] 001: rcu: RCU grace-period kthread stack dump:
[  283.293350] 001: rcu_preempt     R  running task        0    10
 2 0x00000000
[  283.293381] 001: [<c0cb23b4>] (__schedule) from [<c0cb2900>]
(schedule+0x50/0xf8)
[  283.293430] 001: [<c0cb2900>] (schedule) from [<c0cb5fe0>]
(schedule_timeout+0x1bc/0x39c)
[  283.293460] 001: [<c0cb5fe0>] (schedule_timeout) from [<c01ad90c>]
(rcu_gp_kthread+0x764/0x246c)
[  283.293500] 001: [<c01ad90c>] (rcu_gp_kthread) from [<c0153790>]
(kthread+0x134/0x148)
[  283.293533] 001: [<c0153790>] (kthread) from [<c01010bc>]
(ret_from_fork+0x14/0x38)
[  283.293556] 001: Exception stack(0xd80e7fb0 to 0xd80e7ff8)
[  283.293574] 001: 7fa0:                                     00000000
00000000 00000000 00000000
[  283.293593] 001: 7fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  283.293610] 001: 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  283.293634] 001: NMI backtrace for cpu 1
[  283.293647] 001: CPU: 1 PID: 484 Comm: sysbench Tainted: G        W
        5.4.23-rt13 #1
[  283.293662] 001: Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  283.293676] 001: [<c0113880>] (unwind_backtrace) from [<c010d498>]
(show_stack+0x10/0x14)
[  283.293713] 001: [<c010d498>] (show_stack) from [<c0c95ee4>]
(dump_stack+0xd4/0x108)
[  283.293743] 001: [<c0c95ee4>] (dump_stack) from [<c0c9cc44>]
(nmi_cpu_backtrace+0x74/0xac)
[  283.293772] 001: [<c0c9cc44>] (nmi_cpu_backtrace) from [<c0c9cdc0>]
(nmi_trigger_cpumask_backtrace+0x1

                        44/0x1ac)
[  283.293795] 001: [<c0c9cdc0>] (nmi_trigger_cpumask_backtrace) from
[<c01b4678>] (rcu_dump_cpu_stacks+0

                         x98/0xd0)
[  283.293829] 001: [<c01b4678>] (rcu_dump_cpu_stacks) from
[<c01b35d4>] (rcu_sched_clock_irq+0x824/0xb48

                                   )
[  283.293852] 001: [<c01b35d4>] (rcu_sched_clock_irq) from
[<c01bc950>] (update_process_times+0x2c/0x60)
[  283.293887] 001: [<c01bc950>] (update_process_times) from
[<c01d31e0>] (tick_sched_timer+0x64/0xcc)
[  283.293914] 001: [<c01d31e0>] (tick_sched_timer) from [<c01bd9c8>]
(__hrtimer_run_queues+0x170/0x788)
[  283.293939] 001: [<c01bd9c8>] (__hrtimer_run_queues) from
[<c01bf378>] (hrtimer_interrupt+0x130/0x2d8)
[  283.293962] 001: [<c01bf378>] (hrtimer_interrupt) from [<c01128b4>]
(twd_handler+0x2c/0x38)
[  283.293988] 001: [<c01128b4>] (twd_handler) from [<c019ab28>]
(handle_percpu_devid_irq+0xf0/0x4dc)
[  283.294016] 001: [<c019ab28>] (handle_percpu_devid_irq) from
[<c01941d4>] (generic_handle_irq+0x20/0x3

                               4)
[  283.294045] 001: [<c01941d4>] (generic_handle_irq) from
[<c0194818>] (__handle_domain_irq+0x8c/0x128)
[  283.294069] 001: [<c0194818>] (__handle_domain_irq) from
[<c0550d6c>] (gic_handle_irq+0x4c/0xa8)
[  283.294096] 001: [<c0550d6c>] (gic_handle_irq) from [<c0101ef4>]
(__irq_usr+0x54/0x80)
[  283.294116] 001: Exception stack(0xd8da7fb0 to 0xd8da7ff8)
[  283.294134] 001: 7fa0:                                     00000332
00000000 000010c0 00000004
[  283.294154] 001: 7fc0: 00000860 00000000 00000006 b6f42d68 00000199
00000000 00002710 00000666
[  283.294174] 001: 7fe0: 00000000 b6f42d44 004547bd 004548f0 800d0030 ffffffff
[  361.323392] 001: rcu: INFO: rcu_preempt self-detected stall on CPU
[  361.323420] 001: rcu:        1-...!: (18206 ticks this GP)
idle=a96/1/0x40000002 softirq=0/0 fqs=0
[  361.323456] 001:     (t=18207 jiffies g=7097 q=1165)
[  361.323459] 001: rcu: rcu_preempt kthread starved for 18207
jiffies! g7097 f0x0 RCU_GP_WAIT_FQS(5) ->s

                                tate=0x0 ->cpu=0
[  361.323479] 001: rcu: RCU grace-period kthread stack dump:
[  361.323491] 001: rcu_preempt     R  running task        0    10
 2 0x00000000
[  361.323523] 001: [<c0cb23b4>] (__schedule) from [<c0cb2900>]
(schedule+0x50/0xf8)
[  361.323571] 001: [<c0cb2900>] (schedule) from [<c0cb5fe0>]
(schedule_timeout+0x1bc/0x39c)
[  361.323600] 001: [<c0cb5fe0>] (schedule_timeout) from [<c01ad90c>]
(rcu_gp_kthread+0x764/0x246c)
[  361.323639] 001: [<c01ad90c>] (rcu_gp_kthread) from [<c0153790>]
(kthread+0x134/0x148)
[  361.323671] 001: [<c0153790>] (kthread) from [<c01010bc>]
(ret_from_fork+0x14/0x38)
[  361.323692] 001: Exception stack(0xd80e7fb0 to 0xd80e7ff8)
[  361.323711] 001: 7fa0:                                     00000000
00000000 00000000 00000000
[  361.323730] 001: 7fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[  361.323747] 001: 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  361.323770] 001: NMI backtrace for cpu 1
[  361.323783] 001: CPU: 1 PID: 484 Comm: sysbench Tainted: G        W
        5.4.23-rt13 #1
[  361.323798] 001: Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  361.323812] 001: [<c0113880>] (unwind_backtrace) from [<c010d498>]
(show_stack+0x10/0x14)
[  361.323850] 001: [<c010d498>] (show_stack) from [<c0c95ee4>]
(dump_stack+0xd4/0x108)
[  361.323879] 001: [<c0c95ee4>] (dump_stack) from [<c0c9cc44>]
(nmi_cpu_backtrace+0x74/0xac)
[  361.323906] 001: [<c0c9cc44>] (nmi_cpu_backtrace) from [<c0c9cdc0>]
(nmi_trigger_cpumask_backtrace+0x1

                        44/0x1ac)
[  361.323929] 001: [<c0c9cdc0>] (nmi_trigger_cpumask_backtrace) from
[<c01b4678>] (rcu_dump_cpu_stacks+0

                         x98/0xd0)
[  361.323960] 001: [<c01b4678>] (rcu_dump_cpu_stacks) from
[<c01b35d4>] (rcu_sched_clock_irq+0x824/0xb48

                                   )
[  361.323985] 001: [<c01b35d4>] (rcu_sched_clock_irq) from
[<c01bc950>] (update_process_times+0x2c/0x60)
[  361.324018] 001: [<c01bc950>] (update_process_times) from
[<c01d31e0>] (tick_sched_timer+0x64/0xcc)
[  361.324047] 001: [<c01d31e0>] (tick_sched_timer) from [<c01bd9c8>]
(__hrtimer_run_queues+0x170/0x788)
[  361.324070] 001: [<c01bd9c8>] (__hrtimer_run_queues) from
[<c01bf378>] (hrtimer_interrupt+0x130/0x2d8)
[  361.324094] 001: [<c01bf378>] (hrtimer_interrupt) from [<c01128b4>]
(twd_handler+0x2c/0x38)
[  361.324119] 001: [<c01128b4>] (twd_handler) from [<c019ab28>]
(handle_percpu_devid_irq+0xf0/0x4dc)
[  361.324146] 001: [<c019ab28>] (handle_percpu_devid_irq) from
[<c01941d4>] (generic_handle_irq+0x20/0x3

                               4)
[  361.324175] 001: [<c01941d4>] (generic_handle_irq) from
[<c0194818>] (__handle_domain_irq+0x8c/0x128)
[  361.324200] 001: [<c0194818>] (__handle_domain_irq) from
[<c0550d6c>] (gic_handle_irq+0x4c/0xa8)
[  361.324227] 001: [<c0550d6c>] (gic_handle_irq) from [<c0101ef4>]
(__irq_usr+0x54/0x80)
[  361.324249] 001: Exception stack(0xd8da7fb0 to 0xd8da7ff8)
[  361.324264] 001: 7fa0:                                     00000e76
00000000 00000000 00000000
[  361.324283] 001: 7fc0: 00000800 00000000 0000000a b6f42d68 0000073b
00000000 00002710 00000003
[  361.324301] 001: 7fe0: 00000000 b6f42d44 004547bd 00454918 600d0030 ffffffff
