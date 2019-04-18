Return-Path: <SRS0=4qQz=SU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0921EC10F0E
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 17:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B47214DA
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 17:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389779AbfDRR0V (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:26:21 -0400
Received: from foss.arm.com ([217.140.101.70]:38024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388347AbfDRR0V (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Apr 2019 13:26:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2317980D;
        Thu, 18 Apr 2019 10:26:21 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDC223F557;
        Thu, 18 Apr 2019 10:26:18 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org,
        robin.murphy@arm.com, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org, Julien Grall <julien.grall@arm.com>
Subject: [PATCH 0/7] iommu/dma-iommu: Split iommu_dma_map_msi_msg in two parts
Date:   Thu, 18 Apr 2019 18:26:04 +0100
Message-Id: <20190418172611.21561-1-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi all,

On RT, the function iommu_dma_map_msi_msg expects to be called from preemptible
context. However, this is not always the case resulting a splat with
!CONFIG_DEBUG_ATOMIC_SLEEP:

[   48.875777] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
[   48.875779] in_atomic(): 1, irqs_disabled(): 128, pid: 2103, name: ip
[   48.875782] INFO: lockdep is turned off.
[   48.875784] irq event stamp: 10684
[   48.875786] hardirqs last  enabled at (10683): [<ffff0000110c8d70>] _raw_spin_unlock_irqrestore+0x88/0x90
[   48.875791] hardirqs last disabled at (10684): [<ffff0000110c8b2c>] _raw_spin_lock_irqsave+0x24/0x68
[   48.875796] softirqs last  enabled at (0): [<ffff0000100ec590>] copy_process.isra.1.part.2+0x8d8/0x1970
[   48.875801] softirqs last disabled at (0): [<0000000000000000>]           (null)
[   48.875805] Preemption disabled at:
[   48.875805] [<ffff000010189ae8>] __setup_irq+0xd8/0x6c0
[   48.875811] CPU: 2 PID: 2103 Comm: ip Not tainted 5.0.3-rt1-00007-g42ede9a0fed6 #45
[   48.875815] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jan 23 2017
[   48.875817] Call trace:
[   48.875818]  dump_backtrace+0x0/0x140
[   48.875821]  show_stack+0x14/0x20
[   48.875823]  dump_stack+0xa0/0xd4
[   48.875827]  ___might_sleep+0x16c/0x1f8
[   48.875831]  rt_spin_lock+0x5c/0x70
[   48.875835]  iommu_dma_map_msi_msg+0x5c/0x1d8
[   48.875839]  gicv2m_compose_msi_msg+0x3c/0x48
[   48.875843]  irq_chip_compose_msi_msg+0x40/0x58
[   48.875846]  msi_domain_activate+0x38/0x98
[   48.875849]  __irq_domain_activate_irq+0x58/0xa0
[   48.875852]  irq_domain_activate_irq+0x34/0x58
[   48.875855]  irq_activate+0x28/0x30
[   48.875858]  __setup_irq+0x2b0/0x6c0
[   48.875861]  request_threaded_irq+0xdc/0x188
[   48.875865]  sky2_setup_irq+0x44/0xf8
[   48.875868]  sky2_open+0x1a4/0x240
[   48.875871]  __dev_open+0xd8/0x188
[   48.875874]  __dev_change_flags+0x164/0x1f0
[   48.875877]  dev_change_flags+0x20/0x60
[   48.875879]  do_setlink+0x2a0/0xd30
[   48.875882]  __rtnl_newlink+0x5b4/0x6d8
[   48.875885]  rtnl_newlink+0x50/0x78
[   48.875888]  rtnetlink_rcv_msg+0x178/0x640
[   48.875891]  netlink_rcv_skb+0x58/0x118
[   48.875893]  rtnetlink_rcv+0x14/0x20
[   48.875896]  netlink_unicast+0x188/0x200
[   48.875898]  netlink_sendmsg+0x248/0x3d8
[   48.875900]  sock_sendmsg+0x18/0x40
[   48.875904]  ___sys_sendmsg+0x294/0x2d0
[   48.875908]  __sys_sendmsg+0x68/0xb8
[   48.875911]  __arm64_sys_sendmsg+0x20/0x28
[   48.875914]  el0_svc_common+0x90/0x118
[   48.875918]  el0_svc_handler+0x2c/0x80
[   48.875922]  el0_svc+0x8/0xc

This series is a first attempt to rework how MSI are mapped and composed
when an IOMMU is present.

I was able to test the changes in GICv2m and GICv3 ITS. I don't have
hardware for the other interrupt controllers.

Cheers,

Julien Grall (7):
  genirq/msi: Add a new field in msi_desc to store an IOMMU cookie
  iommu/dma-iommu: Split iommu_dma_map_msi_msg in two parts
  irqchip/gicv2m: Don't map the MSI page in gicv2m_compose_msi_msg
  irqchip/gic-v3-its: Don't map the MSI page in its_irq_compose_msi_msg
  irqchip/ls-scfg-msi: Don't map the MSI page in ls_scfg_msi_compose_msg
  irqchip/gic-v3-mbi: Don't map the MSI page in mbi_compose_m{b, s}i_msg
  iommu/dma-iommu: Remove iommu_dma_map_msi_msg()

 drivers/iommu/dma-iommu.c         | 45 ++++++++++++++++++++-------------------
 drivers/irqchip/irq-gic-v2m.c     |  8 ++++++-
 drivers/irqchip/irq-gic-v3-its.c  |  5 ++++-
 drivers/irqchip/irq-gic-v3-mbi.c  | 15 +++++++++++--
 drivers/irqchip/irq-ls-scfg-msi.c |  7 +++++-
 include/linux/dma-iommu.h         | 20 +++++++++++++++--
 include/linux/msi.h               |  3 +++
 7 files changed, 74 insertions(+), 29 deletions(-)

-- 
2.11.0

