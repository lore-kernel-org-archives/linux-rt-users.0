Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F6AC6377D
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Jul 2021 17:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C29DF61410
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Jul 2021 17:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhGVRM2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Jul 2021 13:12:28 -0400
Received: from foss.arm.com ([217.140.110.172]:57946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229955AbhGVRM1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Jul 2021 13:12:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 687D5106F;
        Thu, 22 Jul 2021 10:53:02 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 46A613F73D;
        Thu, 22 Jul 2021 10:53:00 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, x86@kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 0/3] sched, x86, arm64: PREEMPT_RT, FPU and preemption
Date:   Thu, 22 Jul 2021 18:51:54 +0100
Message-Id: <20210722175157.1367122-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi folks,

This stems from some more v5.13-rt1 breakage on arm64. This time per-CPU access
safety isn't sufficient, we really need to keep preemption disabled.

In a happy accident I stumbled on

  cba08c5dc6dc ("x86/fpu: Make kernel FPU protection RT friendly")

so I packaged what was done there into some common helpers and plastered them
over the problematic areas.

Cheers,
Valentin

Valentin Schneider (3):
  sched/preempt: Introduce preempt_{enable, disable}_bh()
  x86/fpu: Make FPU protection reuse common helper
  arm64/fpsimd: Fix FPSIMD context handling vs PREEMPT_RT

 arch/arm64/kernel/fpsimd.c     |  6 ++++--
 arch/x86/include/asm/fpu/api.h | 19 ++-----------------
 include/linux/bottom_half.h    | 26 ++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 19 deletions(-)

--
2.25.1

