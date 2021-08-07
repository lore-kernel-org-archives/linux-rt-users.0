Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AB4C4320A
	for <linux-rt-users@archiver.kernel.org>; Sat,  7 Aug 2021 00:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0194611CB
	for <linux-rt-users@archiver.kernel.org>; Sat,  7 Aug 2021 00:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhHGA67 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 20:58:59 -0400
Received: from foss.arm.com ([217.140.110.172]:42830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhHGA67 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Aug 2021 20:58:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CCE013D5;
        Fri,  6 Aug 2021 17:58:42 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5FF8D3F66F;
        Fri,  6 Aug 2021 17:58:39 -0700 (PDT)
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
Subject: [PATCH v2 4/4] arm64: mm: Make arch_faults_on_old_pte() check for migratability
Date:   Sat,  7 Aug 2021 01:58:07 +0100
Message-Id: <20210807005807.1083943-5-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210807005807.1083943-1-valentin.schneider@arm.com>
References: <20210807005807.1083943-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Running v5.13-rt1 on my arm64 Juno board triggers:

[   30.430643] WARNING: CPU: 4 PID: 1 at arch/arm64/include/asm/pgtable.h:985 do_set_pte (./arch/arm64/include/asm/pgtable.h:985 ./arch/arm64/include/asm/pgtable.h:997 mm/memory.c:3830)
[   30.430669] Modules linked in:
[   30.430679] CPU: 4 PID: 1 Comm: init Tainted: G        W         5.13.0-rt1-00002-gcb994ad7c570 #35
[   30.430690] Hardware name: ARM Juno development board (r0) (DT)
[   30.430695] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
[   30.430874] Call trace:
[   30.430878] do_set_pte (./arch/arm64/include/asm/pgtable.h:985 ./arch/arm64/include/asm/pgtable.h:997 mm/memory.c:3830)
[   30.430886] filemap_map_pages (mm/filemap.c:3222)
[   30.430895] __handle_mm_fault (mm/memory.c:4006 mm/memory.c:4020 mm/memory.c:4153 mm/memory.c:4412 mm/memory.c:4547)
[   30.430904] handle_mm_fault (mm/memory.c:4645)
[   30.430912] do_page_fault (arch/arm64/mm/fault.c:507 arch/arm64/mm/fault.c:607)
[   30.430925] do_translation_fault (arch/arm64/mm/fault.c:692)
[   30.430936] do_mem_abort (arch/arm64/mm/fault.c:821)
[   30.430946] el0_ia (arch/arm64/kernel/entry-common.c:324)
[   30.430959] el0_sync_handler (arch/arm64/kernel/entry-common.c:431)
[   30.430967] el0_sync (arch/arm64/kernel/entry.S:744)
[   30.430977] irq event stamp: 1228384
[   30.430981] hardirqs last enabled at (1228383): lock_page_memcg (mm/memcontrol.c:2005 (discriminator 1))
[   30.430993] hardirqs last disabled at (1228384): el1_dbg (arch/arm64/kernel/entry-common.c:144 arch/arm64/kernel/entry-common.c:234)
[   30.431007] softirqs last enabled at (1228260): __local_bh_enable_ip (./arch/arm64/include/asm/irqflags.h:85 kernel/softirq.c:262)
[   30.431022] softirqs last disabled at (1228232): fpsimd_restore_current_state (./include/linux/bottom_half.h:19 arch/arm64/kernel/fpsimd.c:183 arch/arm64/kernel/fpsimd.c:1182)

CONFIG_PREEMPT_RT turns the PTE lock into a sleepable spinlock. Since
acquiring such a lock also disables migration, any per-CPU access done
under the lock remains safe even if preemptible.

This affects:

  filemap_map_pages()
  `\
    do_set_pte()
    `\
      arch_wants_old_prefaulted_pte()

which checks preemptible() to figure out if the output of
cpu_has_hw_af() (IOW the underlying CPU) will remain stable for the
subsequent operations. Make it use is_pcpu_safe() instead.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index f09bf5c02891..767a064bedde 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -995,7 +995,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
  */
 static inline bool arch_faults_on_old_pte(void)
 {
-	WARN_ON(preemptible());
+	WARN_ON(!is_pcpu_safe());
 
 	return !cpu_has_hw_af();
 }
-- 
2.25.1

