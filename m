Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA808C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Oct 2021 15:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF21604E9
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Oct 2021 15:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242702AbhJ0PRi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 Oct 2021 11:17:38 -0400
Received: from foss.arm.com ([217.140.110.172]:44402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233978AbhJ0PRi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Oct 2021 11:17:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70E81ED1;
        Wed, 27 Oct 2021 08:15:12 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1F8CD3F70D;
        Wed, 27 Oct 2021 08:15:11 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 0/3] irqchip/gic-v3-its: Fix LPI pending table handling vs PREEMPT_RT
Date:   Wed, 27 Oct 2021 16:15:03 +0100
Message-Id: <20211027151506.2085066-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi folks,

This is my take at fixing [1]. Reading about the LPI tables situation was
entertaining.

Tested against kexec on an Ampere eMAG. Seems to be working fine atop
5.15-rc6. On the other hand, I can only issue one kexec from
5.15-rc6-rt12 - if I then issue another one on the new kernel, I get tasks
hanging. That is true even without my patches and without
CONFIG_PREEMPT_RT.

[1]: http://lore.kernel.org/r/20210810134127.1394269-3-valentin.schneider@arm.com

Revisions
=========

v1 -> v2
++++++++

o Ditched RDIST_FLAGS renaming; moved to "RD_LOCAL" prefix for new flags
  (Marc) 
o Simplified cpuhp callback logic: body now runs at most once per CPU
o Changed cpuhp callback installation to happen *after* the BP has invoked
  its_cpu_init(); the BP cpuhp state is immediately set to CPUHP_ONLINE, so
  cpuhp state alone doesn't guarantee its_cpu_init() has been run.
  
Cheers,
Valentin

Valentin Schneider (3):
  irqchip/gic-v3-its: Give the percpu rdist struct its own flags field
  irqchip/gic-v3-its: Postpone LPI pending table freeing and memreserve
  irqchip/gic-v3-its: Limit memreserve cpuhp state lifetime

 drivers/irqchip/irq-gic-v3-its.c   | 82 +++++++++++++++++++++++++++---
 drivers/irqchip/irq-gic-v3.c       |  1 +
 include/linux/irqchip/arm-gic-v3.h |  4 +-
 3 files changed, 79 insertions(+), 8 deletions(-)

--
2.25.1

