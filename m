Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2E2C433FE
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Oct 2021 10:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57CB61059
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Oct 2021 10:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhJVKfo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Oct 2021 06:35:44 -0400
Received: from foss.arm.com ([217.140.110.172]:52546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232573AbhJVKfo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Oct 2021 06:35:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C51D1063;
        Fri, 22 Oct 2021 03:33:26 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B607C3F70D;
        Fri, 22 Oct 2021 03:33:24 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 0/3] irqchip/gic-v3-its: Fix LPI pending table handling vs PREEMPT_RT
Date:   Fri, 22 Oct 2021 11:33:04 +0100
Message-Id: <20211022103307.1711619-1-valentin.schneider@arm.com>
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
5.15-rc6. On the other hand, I can only issue one kexec from 5.15-rc6-rt12 - if
I then issue another one on the new kernel, I get tasks hanging. That is true
even without my patches and without CONFIG_PREEMPT_RT.

[1]: http://lore.kernel.org/r/20210810134127.1394269-3-valentin.schneider@arm.com

Cheers,
Valentin

Valentin Schneider (3):
  irqchip/gic-v3-its: Give the percpu rdist struct its own flags field
  irqchip/gic-v3-its: Postpone LPI pending table freeing and memreserve
  irqchip/gic-v3-its: Limit memreserve cpuhp state lifetime

 drivers/irqchip/irq-gic-v3-its.c   | 108 ++++++++++++++++++++++++-----
 include/linux/irqchip/arm-gic-v3.h |   3 +-
 2 files changed, 94 insertions(+), 17 deletions(-)

--
2.25.1

