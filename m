Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21802C636C9
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Jul 2021 12:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE10D611CE
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Jul 2021 12:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbhGULVW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Jul 2021 07:21:22 -0400
Received: from foss.arm.com ([217.140.110.172]:52800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236618AbhGULK6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Jul 2021 07:10:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ABE5D6E;
        Wed, 21 Jul 2021 04:51:34 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 145223F694;
        Wed, 21 Jul 2021 04:51:31 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/3] rcu/nocb: Check for migratability rather than pure preemptability
Date:   Wed, 21 Jul 2021 12:51:17 +0100
Message-Id: <20210721115118.729943-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721115118.729943-1-valentin.schneider@arm.com>
References: <20210721115118.729943-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Running v5.13-rt1 on my arm64 Juno board triggers:

[    0.156302] =============================
[    0.160416] WARNING: suspicious RCU usage
[    0.164529] 5.13.0-rt1 #20 Not tainted
[    0.168300] -----------------------------
[    0.172409] kernel/rcu/tree_plugin.h:69 Unsafe read of RCU_NOCB offloaded state!
[    0.179920]
[    0.179920] other info that might help us debug this:
[    0.179920]
[    0.188037]
[    0.188037] rcu_scheduler_active = 1, debug_locks = 1
[    0.194677] 3 locks held by rcuc/0/11:
[    0.198448] #0: ffff00097ef10cf8 ((softirq_ctrl.lock).lock){+.+.}-{2:2}, at: __local_bh_disable_ip (./include/linux/rcupdate.h:662 kernel/softirq.c:171)
[    0.208709] #1: ffff80001205e5f0 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (kernel/locking/spinlock_rt.c:43 (discriminator 4))
[    0.217134] #2: ffff80001205e5f0 (rcu_read_lock){....}-{1:2}, at: __local_bh_disable_ip (kernel/softirq.c:169)
[    0.226428]
[    0.226428] stack backtrace:
[    0.230889] CPU: 0 PID: 11 Comm: rcuc/0 Not tainted 5.13.0-rt1 #20
[    0.237100] Hardware name: ARM Juno development board (r0) (DT)
[    0.243041] Call trace:
[    0.245497] dump_backtrace (arch/arm64/kernel/stacktrace.c:163)
[    0.249185] show_stack (arch/arm64/kernel/stacktrace.c:219)
[    0.252522] dump_stack (lib/dump_stack.c:122)
[    0.255947] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6439)
[    0.260328] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:69 kernel/rcu/tree_plugin.h:58)
[    0.264537] rcu_core (kernel/rcu/tree.c:2332 kernel/rcu/tree.c:2398 kernel/rcu/tree.c:2777)
[    0.267786] rcu_cpu_kthread (./include/linux/bottom_half.h:32 kernel/rcu/tree.c:2876)
[    0.271644] smpboot_thread_fn (kernel/smpboot.c:165 (discriminator 3))
[    0.275767] kthread (kernel/kthread.c:321)
[    0.279013] ret_from_fork (arch/arm64/kernel/entry.S:1005)

In this case, this is the RCU core kthread accessing the local CPU's
rdp. Before that, rcu_cpu_kthread() invokes local_bh_disable().

Under !CONFIG_PREEMPT_RT (and rcutree.use_softirq=0), this ends up
incrementing the preempt_count, which satisfies the "local non-preemptible
read" of rcu_rdp_is_offloaded().

Under CONFIG_PREEMPT_RT however, this becomes

  local_lock(&softirq_ctrl.lock)

which, under the same config, is migrate_disable() + rt_spin_lock().
This *does* prevent the task from migrating away, but not in a way
rcu_rdp_is_offloaded() can notice. Note that the invoking task is an
smpboot thread, and thus cannot be migrated away in the first place.

Check is_pcpu_safe() here rather than preemptible().

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/rcu/tree_plugin.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ad0156b86937..6c3c4100da83 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -70,8 +70,7 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
 		!(lockdep_is_held(&rcu_state.barrier_mutex) ||
 		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
 		  rcu_lockdep_is_held_nocb(rdp) ||
-		  (rdp == this_cpu_ptr(&rcu_data) &&
-		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
+		  (rdp == this_cpu_ptr(&rcu_data) && is_pcpu_safe()) ||
 		  rcu_current_is_nocb_kthread(rdp) ||
 		  rcu_running_nocb_timer(rdp)),
 		"Unsafe read of RCU_NOCB offloaded state"
-- 
2.25.1

