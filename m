Return-Path: <SRS0=5zTk=6F=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90834C54FCC
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Apr 2020 14:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A0F0206A1
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Apr 2020 14:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgDUOvv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUOvu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Apr 2020 10:51:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2776C061A10
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Apr 2020 07:51:50 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jQuFX-0005Hs-NT; Tue, 21 Apr 2020 16:51:47 +0200
Date:   Tue, 21 Apr 2020 16:51:47 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Liwei Song <liwei.song@windriver.com>
Cc:     linux-rt <linux-rt-users@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH RT] mm: do not warn for suspend when allocate memory on RT
Message-ID: <20200421145147.lejozjuvjjd4nmyf@linutronix.de>
References: <20200413041817.27514-1-liwei.song@windriver.com>
 <20200416170943.hjoytlggvfzzdqjt@linutronix.de>
 <8cd11f67-dbf8-cce9-548f-ccc544f9486c@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8cd11f67-dbf8-cce9-548f-ccc544f9486c@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-04-17 10:50:35 [+0800], Liwei Song wrote:
> 
> 
> On 4/17/20 01:09, Sebastian Andrzej Siewior wrote:
> > On 2020-04-13 12:18:17 [+0800], Liwei Song wrote:
> >> Interrupts are off during resume from RAM, this will triger a warning
> >> when allocate memory in non-preemptible context on RT since commit
> >> b5d5bc970f209 ("mm: Warn on memory allocation in non-preemptible
> >> context on RT"), exclude suspend from this warning check.
> > 
> > Is this the ACPI backtrace or do you have something else?
> 
> Yes, there are two backtrace here include one ACPI Calltrace, another one
> is from iommu:
> 
> 1).
> [ 88.992342] ? acpi_os_allocate_zeroed+0x28/0x2a
> [ 88.992349] acpi_os_allocate_zeroed+0x28/0x2a
> [ 88.992351] acpi_ns_internalize_name+0x4b/0xa0
> [ 88.992354] ? trace_preempt_on+0x2a/0x120
> [ 88.992360] acpi_ns_get_node_unlocked+0x6f/0xd7
> [ 88.992362] ? _raw_spin_unlock_irqrestore+0x42/0x90
> [ 88.992367] ? down_timeout+0x3c/0x60
> [ 88.992372] ? acpi_os_wait_semaphore+0x4d/0x70
> [ 88.992378] acpi_ns_get_node+0x43/0x5d
> 
> 2).
> [ 88.991560] Call Trace:
> [ 88.991561] ? _raw_spin_unlock_irqrestore+0x42/0x90
> [ 88.991563] ? iommu_suspend+0x4f/0x1c0
> [ 88.991569] iommu_suspend+0x4f/0x1c0
> [ 88.991572] syscore_suspend+0x9b/0x3e0
> [ 88.991575] suspend_devices_and_enter+0x1fb/0xec0
> [ 88.991579] ? rcu_read_lock_sched_held+0x4f/0x80
> [ 88.991580] ? prb_unlock+0x18/0x80
> [ 88.991585] pm_suspend.cold+0x326/0x37b
> 
> During suspend phase the only way to make preemptible() happy is
> enable interrupt before kcalloc/kmalloc/kzalloc, but enable interrupt
> may cause some unknown issue if device access I/O address which already
> suspend, so I think it's better and safe to exclude suspend from this
> warning check.

At this point all CPUs are down so there is no scheduling. No lock
within the buddy allocator should not be acquired by another task. That
looks good. 
But: calling into the buddy allocator goes via allocate_slab() which
enables interrupts.

> Thanks,
> Liwei.

Sebastian
