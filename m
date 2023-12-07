Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="VRAoZBvs"
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED0019A;
	Thu,  7 Dec 2023 07:14:01 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55DD4E1A5B;
	Thu,  7 Dec 2023 15:58:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1701961102; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=WE9ZyEGuVyo72628JRvkXj4/XgUWNLTkHhkataYllOQ=;
	b=VRAoZBvsthvwrxPtFqnCCI0qI4/ETcx8w++DbEUaLSmA+nPP1SwvbySSWXBm/z3IIsKrsD
	aM1QB9nIJ6FDj5G598nOibnnQxtcwCLWsTYNpLNft+4GQQsV1R+Kp/0lGXs7vpFLK2TTUl
	DXL4helLxHw/nVTV3TJdrb/3biMtKTZVSXvLb1d2BOXFf9BSgawt3D8QfRZesYJez4DSti
	A1sKDCAt8hMW8SWugS8hTINDKXdvK0ub8IDm8ePgFrxu8wMQVndjX393dM7vfAb0CS/fBr
	UYYlaAomPmSM1ZjjX/euVa2gMs8aIP8v5JaH+AObanwe235W2vGGAif3EN1KBQ==
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>,
	 <linux-rt-users@vger.kernel.org>,
	 <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 1/2] Revert "sched/rt: Provide migrate_disable/enable() inlines"
Date: Thu,  7 Dec 2023 15:58:14 +0100
Message-ID: <20231207145815.30461-2-wagi@monom.org>
In-Reply-To: <20231207145815.30461-1-wagi@monom.org>
References: <20231207145815.30461-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

v4.19.299-rt130-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


This reverts commit 56e8949825226341d28dd5156b3d0057684ff669.

The tree contains already the migrate_disable/enable() helpers thus this
stable backport conflicts (b) with the existing definition (compiler
complains with conflicting definition). Thus we don't need this
backported functions and can avoid the conflict by just dropping the
backport.

Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 include/linux/preempt.h | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 29ecd13afdda..9c74a019bf57 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -422,34 +422,4 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 
 #endif
 
-/**
- * migrate_disable - Prevent migration of the current task
- *
- * Maps to preempt_disable() which also disables preemption. Use
- * migrate_disable() to annotate that the intent is to prevent migration,
- * but not necessarily preemption.
- *
- * Can be invoked nested like preempt_disable() and needs the corresponding
- * number of migrate_enable() invocations.
- */
-static __always_inline void migrate_disable(void)
-{
-	preempt_disable();
-}
-
-/**
- * migrate_enable - Allow migration of the current task
- *
- * Counterpart to migrate_disable().
- *
- * As migrate_disable() can be invoked nested, only the outermost invocation
- * reenables migration.
- *
- * Currently mapped to preempt_enable().
- */
-static __always_inline void migrate_enable(void)
-{
-	preempt_enable();
-}
-
 #endif /* __LINUX_PREEMPT_H */
-- 
2.42.0

