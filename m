Return-Path: <SRS0=38ny=S7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA52EC43219
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Apr 2019 15:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774822064A
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Apr 2019 15:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfD2P5Z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:57:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32896 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728516AbfD2P5Z (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 29 Apr 2019 11:57:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA33A80D;
        Mon, 29 Apr 2019 08:57:24 -0700 (PDT)
Received: from [10.1.196.92] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DE933F5C1;
        Mon, 29 Apr 2019 08:57:22 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] iommu/dma-iommu: Split iommu_dma_map_msi_msg in
 two parts
To:     Julien Grall <julien.grall@arm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, jason@lakedaemon.net,
        tglx@linutronix.de, joro@8bytes.org, robin.murphy@arm.com,
        bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
References: <20190429144428.29254-1-julien.grall@arm.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <646d035d-e160-a19d-8c3a-e1935cf691b5@arm.com>
Date:   Mon, 29 Apr 2019 16:57:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429144428.29254-1-julien.grall@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Julien,

On 29/04/2019 15:44, Julien Grall wrote:
> Hi all,
> 
> On RT, the function iommu_dma_map_msi_msg expects to be called from preemptible
> context. However, this is not always the case resulting a splat with
> !CONFIG_DEBUG_ATOMIC_SLEEP:
> 
> [   48.875777] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
> [   48.875779] in_atomic(): 1, irqs_disabled(): 128, pid: 2103, name: ip
> [   48.875782] INFO: lockdep is turned off.
> [   48.875784] irq event stamp: 10684
> [   48.875786] hardirqs last  enabled at (10683): [<ffff0000110c8d70>] _raw_spin_unlock_irqrestore+0x88/0x90
> [   48.875791] hardirqs last disabled at (10684): [<ffff0000110c8b2c>] _raw_spin_lock_irqsave+0x24/0x68
> [   48.875796] softirqs last  enabled at (0): [<ffff0000100ec590>] copy_process.isra.1.part.2+0x8d8/0x1970
> [   48.875801] softirqs last disabled at (0): [<0000000000000000>]           (null)
> [   48.875805] Preemption disabled at:
> [   48.875805] [<ffff000010189ae8>] __setup_irq+0xd8/0x6c0
> [   48.875811] CPU: 2 PID: 2103 Comm: ip Not tainted 5.0.3-rt1-00007-g42ede9a0fed6 #45
> [   48.875815] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jan 23 2017
> [   48.875817] Call trace:
> [   48.875818]  dump_backtrace+0x0/0x140
> [   48.875821]  show_stack+0x14/0x20
> [   48.875823]  dump_stack+0xa0/0xd4
> [   48.875827]  ___might_sleep+0x16c/0x1f8
> [   48.875831]  rt_spin_lock+0x5c/0x70
> [   48.875835]  iommu_dma_map_msi_msg+0x5c/0x1d8
> [   48.875839]  gicv2m_compose_msi_msg+0x3c/0x48
> [   48.875843]  irq_chip_compose_msi_msg+0x40/0x58
> [   48.875846]  msi_domain_activate+0x38/0x98
> [   48.875849]  __irq_domain_activate_irq+0x58/0xa0
> [   48.875852]  irq_domain_activate_irq+0x34/0x58
> [   48.875855]  irq_activate+0x28/0x30
> [   48.875858]  __setup_irq+0x2b0/0x6c0
> [   48.875861]  request_threaded_irq+0xdc/0x188
> [   48.875865]  sky2_setup_irq+0x44/0xf8
> [   48.875868]  sky2_open+0x1a4/0x240
> [   48.875871]  __dev_open+0xd8/0x188
> [   48.875874]  __dev_change_flags+0x164/0x1f0
> [   48.875877]  dev_change_flags+0x20/0x60
> [   48.875879]  do_setlink+0x2a0/0xd30
> [   48.875882]  __rtnl_newlink+0x5b4/0x6d8
> [   48.875885]  rtnl_newlink+0x50/0x78
> [   48.875888]  rtnetlink_rcv_msg+0x178/0x640
> [   48.875891]  netlink_rcv_skb+0x58/0x118
> [   48.875893]  rtnetlink_rcv+0x14/0x20
> [   48.875896]  netlink_unicast+0x188/0x200
> [   48.875898]  netlink_sendmsg+0x248/0x3d8
> [   48.875900]  sock_sendmsg+0x18/0x40
> [   48.875904]  ___sys_sendmsg+0x294/0x2d0
> [   48.875908]  __sys_sendmsg+0x68/0xb8
> [   48.875911]  __arm64_sys_sendmsg+0x20/0x28
> [   48.875914]  el0_svc_common+0x90/0x118
> [   48.875918]  el0_svc_handler+0x2c/0x80
> [   48.875922]  el0_svc+0x8/0xc
> 
> This series is a first attempt to rework how MSI are mapped and composed
> when an IOMMU is present.
> 
> I was able to test the changes in GICv2m and GICv3 ITS. I don't have
> hardware for the other interrupt controllers.
> 
> Cheers,
> 
> Julien Grall (7):
>   genirq/msi: Add a new field in msi_desc to store an IOMMU cookie
>   iommu/dma-iommu: Split iommu_dma_map_msi_msg() in two parts
>   irqchip/gicv2m: Don't map the MSI page in gicv2m_compose_msi_msg()
>   irqchip/gic-v3-its: Don't map the MSI page in
>     its_irq_compose_msi_msg()
>   irqchip/ls-scfg-msi: Don't map the MSI page in
>     ls_scfg_msi_compose_msg()
>   irqchip/gic-v3-mbi: Don't map the MSI page in mbi_compose_m{b,
>     s}i_msg()
>   iommu/dma-iommu: Remove iommu_dma_map_msi_msg()
> 
>  drivers/iommu/Kconfig             |  1 +
>  drivers/iommu/dma-iommu.c         | 49 +++++++++++++++++++++++----------------
>  drivers/irqchip/irq-gic-v2m.c     |  8 ++++++-
>  drivers/irqchip/irq-gic-v3-its.c  |  5 +++-
>  drivers/irqchip/irq-gic-v3-mbi.c  | 15 ++++++++++--
>  drivers/irqchip/irq-ls-scfg-msi.c |  7 +++++-
>  include/linux/dma-iommu.h         | 22 ++++++++++++++++--
>  include/linux/msi.h               | 26 +++++++++++++++++++++
>  kernel/irq/Kconfig                |  3 +++
>  9 files changed, 109 insertions(+), 27 deletions(-)

Thanks for having reworked this. I'm quite happy with the way this looks
now (modulo the couple of nits Robin and I mentioned, which I'm to
address myself).

Jorg: are you OK with this going via the irq tree?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
