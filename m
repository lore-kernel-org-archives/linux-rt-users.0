Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F82C4338F
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Aug 2021 10:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED62B60F56
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Aug 2021 10:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbhHKKxG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 11 Aug 2021 06:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhHKKxF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Aug 2021 06:53:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E501C061765;
        Wed, 11 Aug 2021 03:52:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a20so2191561plm.0;
        Wed, 11 Aug 2021 03:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J48IpV6NARGZAYIwtYoO7o/C7gUcxL+hkRXNL1fCBzo=;
        b=UTb0EsrCp0s39E5mhtvm/1c3CMXGcoXOqGJ3FTNbsSmcP1OYqy1EjMxcEYK+mH4c1s
         1UonoEu+OdEmVOI7shr32I95UOO+vun1OvjoE9yZq6SJo1DgGsG/I1gIRHgKJ1+k6W+/
         alz5b9wwfaVqgbC7oupKYjgF76nIuqvzgmmQJ2Q1oSroVzoPWB2ac/O5rjQwsltKmq2I
         MBzj1IsZfDQQq1HQQRUGCx+Ez5Q7m+rlqNs0X1jVbqVnfTrYwbeSZAUF1a5xAibBBEP4
         38Y3ZMjUbEuSRJsqfA13M574iv9TOryMgkonhu7hmOA11vT9POOsnvq9OWDUwGdLdklp
         w0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J48IpV6NARGZAYIwtYoO7o/C7gUcxL+hkRXNL1fCBzo=;
        b=J+HO8VOZPL546khzIbuAg8zFwMnrpzhZ2QmYEw1bvb9DugFMc0UoLXekX1fHPoNOJn
         TyiJLIN3m/Nh+eokq4eyMMk2RkAF4rMUWulbrBqHPJt1lsGQqiizUQZDaFdZ6ywe9pOg
         2Hx8IXn5ecLvSbSpjaj39thew4sA6Q45xhbpwkc5DJvc4fbdmBtM/hV4AkKkz67EUbjJ
         zsMVLzlAZFWm9Ov+zZbzzWEbEXvcMRmSf/xu9XVYhJlMxfx9Clyb2hsI+VrFnAK4vaZO
         jPGckmKggoyNHyQPOKPme/8KOVx3495sZUPILNZm37jBdEA3KChU4n9IEFWqM/CxWIN3
         xWyw==
X-Gm-Message-State: AOAM532d1D0l+tqDszxQASN5+WXnxlN+WCEzncgnu/Ve6lva6vvogKQn
        /RSG/dv8qTP6PUf5DZJh3OBtX5WP7wYi37IO/M4=
X-Google-Smtp-Source: ABdhPJxjj0jpG3kbNTeFzXiS8qzG2XOZNLAk8Kp0DrrqBbmEKT4QsgODsVV9K02KwCdVD9INOp0uDrKzRotcqBKETi0=
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id
 j11-20020aa7800b0000b0290330455f57a8mr33412554pfi.7.1628679161674; Wed, 11
 Aug 2021 03:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210810134127.1394269-1-valentin.schneider@arm.com> <20210810134127.1394269-4-valentin.schneider@arm.com>
In-Reply-To: <20210810134127.1394269-4-valentin.schneider@arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Aug 2021 13:52:02 +0300
Message-ID: <CAHp75Vf+Do1Zd+4euyoNa5qFmK0Faoh4Q5MS0e2ziazyTRVLBQ@mail.gmail.com>
Subject: Re: [SPLAT 3/3] gpio: dwapb: Sleeping spinlocks down IRQ mapping
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

+Cc: Serge, maintainer of the driver

On Tue, Aug 10, 2021 at 7:34 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> [   11.549741] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
> [   11.549745] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 553, name: systemd-udevd
> [   11.549747] 4 locks held by systemd-udevd/553:
> [   11.549749] #0: ffff00080338b168 (&dev->mutex){....}-{0:0}, at: __device_driver_lock (drivers/base/dd.c:1029)
> [   11.549760] #1: ffff800011df0780 (irq_domain_mutex){+.+.}-{3:3}, at: irq_domain_associate (kernel/irq/irqdomain.c:576)
> [   11.549769] #2: ffff0008112a6900 (lock_class){....}-{2:2}, at: __irq_get_desc_lock (kernel/irq/irqdesc.c:857)
> [   11.549775] #3: ffff0008112a59c8 (&gc->bgpio_lock){+.+.}-{0:0}, at: dwapb_irq_ack (drivers/gpio/gpio-dwapb.c:151 drivers/gpio/gpio-dwapb.c:233) gpio_dwapb
> [   11.549783] irq event stamp: 157476
> [   11.549785] hardirqs last enabled at (157475): _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:194)
> [   11.549790] hardirqs last disabled at (157476): _raw_spin_lock_irqsave (./include/linux/spinlock_api_smp.h:108 kernel/locking/spinlock.c:162)
> [   11.549793] softirqs last enabled at (0): copy_process (./include/linux/lockdep.h:195 ./include/linux/lockdep.h:202 ./include/linux/lockdep.h:208 ./include/linux/seqlock.h:78 kernel/fork.c:2084)
> [   11.549797] softirqs last disabled at (0): 0x0
> [   11.549801] Preemption disabled at:
> [   11.549802] __irq_get_desc_lock (kernel/irq/irqdesc.c:857)
> [   11.549806] CPU: 22 PID: 553 Comm: systemd-udevd Tainted: G        W         5.14.0-rc4-rt6-torture+ #56
> [   11.549808] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.0 06/28/2019
> [   11.549810] Call trace:
> [   11.549811] dump_backtrace (arch/arm64/kernel/stacktrace.c:151)
> [   11.549814] show_stack (arch/arm64/kernel/stacktrace.c:217)
> [   11.549815] dump_stack_lvl (lib/dump_stack.c:106)
> [   11.549819] dump_stack (lib/dump_stack.c:113)
> [   11.549821] ___might_sleep (kernel/sched/core.c:9306)
> [   11.549824] rt_spin_lock (kernel/locking/rtmutex.c:1641 (discriminator 4) kernel/locking/spinlock_rt.c:30 (discriminator 4) kernel/locking/spinlock_rt.c:36 (discriminator 4) kernel/locking/spinlock_rt.c:44 (discriminator 4))
> [   11.549827] dwapb_irq_ack (drivers/gpio/gpio-dwapb.c:151 drivers/gpio/gpio-dwapb.c:233) gpio_dwapb
> [   11.549831] __irq_do_set_handler (kernel/irq/chip.c:414 kernel/irq/chip.c:406 kernel/irq/chip.c:1009)
> [   11.549833] __irq_set_handler (kernel/irq/internals.h:178 kernel/irq/chip.c:1053)
> [   11.549836] irq_set_chip_and_handler_name (kernel/irq/chip.c:1080)
> [   11.549838] gpiochip_irq_map (drivers/gpio/gpiolib.c:1262)
> [   11.549842] irq_domain_associate (kernel/irq/irqdomain.c:579)
> [   11.549845] irq_create_mapping_affinity (kernel/irq/irqdomain.c:716)
> [   11.549848] gpiochip_to_irq (drivers/gpio/gpiolib.c:1365)
> [   11.549851] gpiod_to_irq (drivers/gpio/gpiolib.c:3082)
> [   11.549853] acpi_gpiochip_alloc_event (drivers/gpio/gpiolib-acpi.c:422)
> [   11.549856] acpi_walk_resource_buffer (drivers/acpi/acpica/rsxface.c:548)
> [   11.549859] acpi_walk_resources (drivers/acpi/acpica/rsxface.c:623 drivers/acpi/acpica/rsxface.c:594)
> [   11.549862] acpi_gpiochip_request_interrupts (drivers/gpio/gpiolib-acpi.c:505)
> [   11.549864] gpiochip_add_data_with_key (drivers/gpio/gpiolib.c:748)
> [   11.549867] devm_gpiochip_add_data_with_key (drivers/gpio/gpiolib-devres.c:510)
> [   11.549869] dwapb_gpio_probe (drivers/gpio/gpio-dwapb.c:517 drivers/gpio/gpio-dwapb.c:712) gpio_dwapb
> [   11.549873] platform_probe (drivers/base/platform.c:1428)
> [   11.549876] really_probe (drivers/base/dd.c:517 drivers/base/dd.c:595 drivers/base/dd.c:541)
> [   11.549877] __driver_probe_device (drivers/base/dd.c:747)
> [   11.549879] driver_probe_device (drivers/base/dd.c:777)
> [   11.549881] __driver_attach (drivers/base/dd.c:1137)
> [   11.549883] bus_for_each_dev (drivers/base/bus.c:301)
> [   11.549885] driver_attach (drivers/base/dd.c:1154)
> [   11.549887] bus_add_driver (drivers/base/bus.c:619)
> [   11.549888] driver_register (drivers/base/driver.c:171)
> [   11.549890] __platform_driver_register (drivers/base/platform.c:875)
> [   11.549893] dwapb_gpio_driver_init (drivers/gpio/gpio-dwapb.c:343) gpio_dwapb
> [   11.549897] do_one_initcall (init/main.c:1282)
> [   11.549900] do_init_module (kernel/module.c:3690)
> [   11.549904] load_module (kernel/module.c:4091)
> [   11.549906] __do_sys_finit_module (kernel/module.c:4182)
> [   11.549909] __arm64_sys_finit_module (kernel/module.c:4159)
> [   11.549911] invoke_syscall (./arch/arm64/include/asm/current.h:19 ./arch/arm64/include/asm/compat.h:183 arch/arm64/kernel/syscall.c:57)
> [   11.549914] el0_svc_common (./arch/arm64/include/asm/daifflags.h:28 arch/arm64/kernel/syscall.c:153)
> [   11.549917] do_el0_svc (arch/arm64/kernel/syscall.c:185)
> [   11.549919] el0_svc (arch/arm64/kernel/entry-common.c:512)
> [   11.549922] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:528)
> [   11.549924] el0t_64_sync (arch/arm64/kernel/entry.S:574)

As Thomas said already the usual fix for GPIO drivers is to switch to
the raw version of spin locks. See other drivers for the example of
such conversion (yet, the IRQ handler cases might be needing the
additional care).

-- 
With Best Regards,
Andy Shevchenko
