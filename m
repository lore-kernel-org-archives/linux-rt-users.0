Received: from mo-csw-fb.securemx.jp (mo-csw-fb1802.securemx.jp [210.130.202.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6927F13B284;
	Tue,  4 Feb 2025 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738636994; cv=none; b=QcDEIIaA9IFthaacpKifW+hBCez3aZyPoj7QyrP+x4vRznulCxq1gQkOvAJkEoM3ZL6iK8c3hzS46zM48EhAJ7iTTG0cBSbw7oAtbCYeeP3O9JsTGYAOeS4T3HiWPqeAlgwONgzjkjOJklmYPIMS9nr5LPrFA9Z7Pah1in9Vn3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738636994; c=relaxed/simple;
	bh=wN3B3cisTTe0Rmh9blYsF56rFSabR9viP+mQPQYdbgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qlAMqeOuDPycFNNvmcWlvazHMwNBTK9lCiPJPPnK39DfYNQuwTq50aHC8SeVrr/isFUK4NGhTiW7wG2SlJ+4asu7ZlYiPsNPgLLfULC7HuKxT7hB9gGmR2E1IaOAkf+NCvkHe4uKGa8pxxFvwRtiEtzcehCb+y4FDICw4ngklao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b=m6D1Gfwt; arc=none smtp.client-ip=210.130.202.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b="m6D1Gfwt"
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1802) id 5140mQed1757446; Tue, 4 Feb 2025 09:48:26 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1738630062;x=1739839662;bh=wN3B3
	cisTTe0Rmh9blYsF56rFSabR9viP+mQPQYdbgQ=;b=m6D1GfwtUnf+jcviTvifv6pEfQgD0PdwaMg
	o4EoY7bNT99VxLIGwj2eex2/VuZbhDlOnNztFJtTQBfDz6O4JOKFRhbhzcX2r1VeckWOEVYetc8e+
	liOUNPtPUUKFUPOAxdCjnwfElyA12MmDZ9ZfovbTO9flUxJNW/pM6cDXZ0/UfcTxEIj1dVoGFrOEu
	xssmIVe6ZVcfIUi14VWcS0oyYRZJqVfz8EgLWFcJ+1GuPTx5CFQziweclv7uyEKm2NtiaOTrlmvLV
	0KC6gtzSifW5F8zNX/dIJ+r1G7VYvT5dAODW30N+Nk53f2m7nmRt94xa2huQkRHVyHOdDUoucO3g=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5140lguQ194807; Tue, 4 Feb 2025 09:47:42 +0900
X-Iguazu-Qid: 2yAbj3N9XV4ATWB8l1
X-Iguazu-QSIG: v=2; s=0; t=1738630061; q=2yAbj3N9XV4ATWB8l1; m=zNsaNfsbzVYrSLDaBNYWD/cI34/bLiaHWFfhTeqNJ8M=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 5140lean1095764
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 09:47:40 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 4.9 v1 2/2] mm: slub: allocate_slab() enables IRQ right after scheduler starts
Date: Tue,  4 Feb 2025 09:46:04 +0900
X-TSB-HOP2: ON
Message-Id: <1738629964-11977-3-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1738629964-11977-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1738629964-11977-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

This patch resolves problem in 4.4 & 4.9 PREEMPT_RT kernels that
the following WARNING happens repeatedly due to broken context
caused by running slab allocation with IRQ disabled by mistake.

WARNING: CPU: * PID: ** at */kernel/cpu.c:197 unpin_current_cpu+0x60/0x70()

The system is almost unresponsive and the boot stalls once it occurs.
This repeated WARNING only happens while kernel is booting
(before reaches the userland) with a quite low reproducibility:
Only one time in around 1,000 ~ 10,000 reboots.

[Problem details]

On PREEMPT_RT kernels < v4.14-rt, after __slab_alloc() disables
IRQ with local_irq_save(), allocate_slab() is responsible for
re-enabling IRQ only under the specific conditions:

(1) gfpflags_allow_blocking(flags) OR
(2) system_state == SYSTEM_RUNNING

The problem happens when (1) is false AND system_state == SYSTEM_BOOTING,
caused by the following scenario:

1. Some kernel codes invokes the allocator without __GFP_DIRECT_RECLAIM
   bit (i.e. blocking not allowed) while SYSTEM_BOOTING
2. allocate_slab() calls the following functions with IRQ disabled
3. buffered_rmqueue() invokes local_[spin_]lock_irqsave(pa_lock) which
   might call schedule() and enable IRQ, if it failed to get pa_lock
4. The migrate_disable counter, which is not intended to be updated with
   IRQs disabled, is accidentally updated after schedule() then
   migrate_enable() raises WARN_ON_ONCE(p->migrate_disable <= 0)
5. The unpin_current_cpu() WARNING is raised eventually because the
   refcount counter is linked to the migrate_disable counter

The behavior 2-5 above has been obsereved[1] using ftrace.
The condition (2) above intends to make the memory allocator fully
preemptible on PREEMPT_RT kernels[2], so the lock function in the
step 3 above should work if SYSTEM_RUNNING but not if SYSTEM_BOOTING.

[How this is resolved in newer RT kernels]

A patch series in the mainline (v4.13) introduces SYSTEM_SCHEDULING[3].
On top of this, v4.14-rt (6cec8467) changes the condition (2) above:

-	if (system_state == SYSTEM_RUNNING)
+	if (system_state > SYSTEM_BOOTING)

This avoids the problem by enabling IRQ after SYSTEM_SCHEULDING.
Thus, the conditions that allocate_slab() enables IRQ are like:

(2)system_state   v4.9-rt or before  v4.14-rt or later
SYSTEM_BOOTING        (1)==true          (1)==true
                          :                  :
                          :                  v
SYSTEM_SCHEDULING         : < Problem      Always
                          v < occurs here    |
SYSTEM_RUNNING          Always               |
                          |                  |
                          v                  v

[How this patch works]

An simple option would be to backport the series[3], which is possible
and has been verified[4]. However, that series pulls functional
changes like SYSTEM_SCHEDULING and adjustments for it,
early might_sleep() and smp_processor_id() supports, etc.
Therefore, this patch uses an extra (but not mainline) flag
"system_scheduling" provided by the prior patch instead of
introducing SYSTEM_SCHEDULING, then uses the same condition as
newer RT kernels in allocate_slab().

This patch also applies the fix in v5.4-rt (7adf5bc5) to care
SYSTEM_SUSPEND in the condition check.

[1] https://lore.kernel.org/all/TYCPR01MB11385E3CDF05544B63F7EF9C1E1622@TYCPR01MB11385.jpnprd01.prod.outlook.com/
[2] https://docs.kernel.org/locking/locktypes.html#raw-spinlock-t-on-rt
[3] https://lore.kernel.org/all/20170516184231.564888231@linutronix.de/T/
[4] https://lore.kernel.org/all/TYCPR01MB1138579CA7612B568BB880652E1272@TYCPR01MB11385.jpnprd01.prod.outlook.com/

Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Reviewed-by: Pavel Machek <pavel@denx.de>
---
 mm/slub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index fd23ff951395..6186a2586289 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1412,7 +1412,8 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if (gfpflags_allow_blocking(flags))
 		enableirqs = true;
 #ifdef CONFIG_PREEMPT_RT_FULL
-	if (system_state == SYSTEM_RUNNING)
+	/* SYSTEM_SCHEDULING <= system_state < SYSTEM_SUSPEND in the mainline */
+	if (system_scheduling && system_state < SYSTEM_SUSPEND)
 		enableirqs = true;
 #endif
 	if (enableirqs)
-- 
2.30.2


