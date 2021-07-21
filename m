Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7833C6377B
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Jul 2021 12:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8663611CE
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Jul 2021 12:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbhGULVN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Jul 2021 07:21:13 -0400
Received: from foss.arm.com ([217.140.110.172]:52776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237668AbhGULKz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Jul 2021 07:10:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D38A631B;
        Wed, 21 Jul 2021 04:51:31 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6C71C3F694;
        Wed, 21 Jul 2021 04:51:29 -0700 (PDT)
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
Subject: [PATCH 1/3] sched: Introduce is_pcpu_safe()
Date:   Wed, 21 Jul 2021 12:51:16 +0100
Message-Id: <20210721115118.729943-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721115118.729943-1-valentin.schneider@arm.com>
References: <20210721115118.729943-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Some areas use preempt_disable() + preempt_enable() to safely access
per-CPU data. The PREEMPT_RT folks have shown this can also be done by
keeping preemption enabled and instead disabling migration (and acquiring a
sleepable lock, if relevant).

Introduce a helper which checks whether the current task can safely access
per-CPU data, IOW if the task's context guarantees the accesses will target
a single CPU. This accounts for preemption, CPU affinity, and migrate
disable - note that the CPU affinity check also mandates the presence of
PF_NO_SETAFFINITY, as otherwise userspace could concurrently render the
upcoming per-CPU access(es) unsafe.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index efdbdf654876..7ce2d5c1ad55 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1707,6 +1707,16 @@ static inline bool is_percpu_thread(void)
 #endif
 }
 
+/* Is the current task guaranteed not to be migrated elsewhere? */
+static inline bool is_pcpu_safe(void)
+{
+#ifdef CONFIG_SMP
+	return !preemptible() || is_percpu_thread() || current->migration_disabled;
+#else
+	return true;
+#endif
+}
+
 /* Per-process atomic flags. */
 #define PFA_NO_NEW_PRIVS		0	/* May not gain new privileges. */
 #define PFA_SPREAD_PAGE			1	/* Spread page cache over cpuset */
-- 
2.25.1

