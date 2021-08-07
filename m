Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2738BC4320A
	for <linux-rt-users@archiver.kernel.org>; Sat,  7 Aug 2021 00:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056EC611CB
	for <linux-rt-users@archiver.kernel.org>; Sat,  7 Aug 2021 00:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhHGA6r (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 20:58:47 -0400
Received: from foss.arm.com ([217.140.110.172]:42730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhHGA6q (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Aug 2021 20:58:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0B236D;
        Fri,  6 Aug 2021 17:58:29 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 077CA3F66F;
        Fri,  6 Aug 2021 17:58:26 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 0/4] rcu, arm64: PREEMPT_RT fixlets
Date:   Sat,  7 Aug 2021 01:58:03 +0100
Message-Id: <20210807005807.1083943-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi folks,

this is v2 of:

  https://lore.kernel.org/lkml/20210721115118.729943-1-valentin.schneider@arm.com/

respun from Frederic and Paul's helpful feedback. Tested atop v5.14-rc4-rt6 with
the v1 patches reverted. There, commit 

  d76e0926d835 ("rcu/nocb: Use the rcuog CPU's ->nocb_timer")

prevents the NOCB offload warning from firing if there are no NOCB CPUs (which
is sensible). Adding a single NOCB CPU brings the warning back, which patch 3
fixes.

Note that patches 2 & 4 are already in v5.14-rc4-rt6, but still apply against
mainline.

Revisions
=========

v1 -> v2
++++++++

o Rebased and tested against v5.14-rc4-rt6
o Picked rcutorture patch from
  https://lore.kernel.org/lkml/20210803225437.3612591-2-valentin.schneider@arm.com/
o Added a local_lock to protect NOCB offload state under PREEMPT_RT (Frederic,
  Paul)

Valentin Schneider (4):
  rcutorture: Don't disable softirqs with preemption disabled when
    PREEMPT_RT
  sched: Introduce is_pcpu_safe()
  rcu/nocb: Protect NOCB state via local_lock() under PREEMPT_RT
  arm64: mm: Make arch_faults_on_old_pte() check for migratability

 arch/arm64/include/asm/pgtable.h |  2 +-
 include/linux/sched.h            | 10 ++++
 kernel/rcu/rcutorture.c          |  2 +
 kernel/rcu/tree.c                |  4 ++
 kernel/rcu/tree.h                |  4 ++
 kernel/rcu/tree_plugin.h         | 82 ++++++++++++++++++++++++++++----
 6 files changed, 94 insertions(+), 10 deletions(-)

--
2.25.1

