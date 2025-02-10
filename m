Received: from mo-csw.securemx.jp (mo-csw1800.securemx.jp [210.130.202.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305E2130E58;
	Mon, 10 Feb 2025 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170611; cv=none; b=XLrgyvN8+AgaRPuGWt/vUDOJEYBVwzkpWFJg0UFxO+2vKXmUYlK6Dg4Yt27aldgCwR0Q/zb7qOlzuhyd78K5C4+c/ZvuRR41xUolSrTPE5POznt1I0LTfq2Xzlr60gq6TkQoF/u+bdoVkOhNhlSGzatfpG+38C9/gAGNPitQPYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170611; c=relaxed/simple;
	bh=acPjB02nKz+0L18N0R0yI4XNLgXwOw2WtMq2MiY7VZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IqilnWXwpGB2MqWJC71hAtKrpZQR567FvjVhMreyjc4xBzikvsp1XV9q3VnhtOmWslfXoksRfhX/83uq2Lg0ZdPuX2HhvKxLOG/AR/V8zeEcGJ0qbg1WjjhC3+tZmoLKixOEFq/txCUeXdcTUOYF8Ghh8ymkyrd5q6pmCtsIkis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b=oCh85SuA; arc=none smtp.client-ip=210.130.202.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b="oCh85SuA"
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170573;x=1740380173;bh=acPjB
	02nKz+0L18N0R0yI4XNLgXwOw2WtMq2MiY7VZo=;b=oCh85SuAg7YVFGfhwBDQyajbrpY9Z052Zbz
	nC8RRvcCoEC8HPQTRbJGylco1CGX39SovF12k2wPQuHqlnHiTIcPt8EWA8oJ/DiKsATa+D8ls2ssz
	DU5d4yQtJAiPZ8TrPQnjtzssFmONlfjhPpXnI2OgXoK8rcghYTEwX8zCK0ic2OagRuXz4f76c5ieZ
	/FQ0GyGw11rhDkSRorOndM1rkbhMdH20sfItoMehwfv3gwWIVn8EATmSvwuS3BwHPvB0CIe38Y/Le
	eSr0D+F7f/9AqCuxe1wgTE7RhXwRGGZTs6w5OqljHfS+IpmLMGypaMmy9MjG3iB2oUU9D4ng+YNw=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 51A6uDV7789623; Mon, 10 Feb 2025 15:56:13 +0900
X-Iguazu-Qid: 2yAbAvUQLMDyrOXXCz
X-Iguazu-QSIG: v=2; s=0; t=1739170569; q=2yAbAvUQLMDyrOXXCz; m=hT5YGyOoxk8Q0nj+TSNNp3ULzx5+5kOpNb8kwhatOo4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 51A6u8lC482935
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:08 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 17/17] mm: slub: allocate_slab() enables IRQ right after scheduler starts
Date: Mon, 10 Feb 2025 15:55:45 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-18-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

This patch resolves problem in 4.4 (& 4.9) PREEMPT_RT kernels that
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

The series[3] that introduces SYSTEM_SCHEULDING is already backported
by the prior patches. Using the state, this patch applies the same
fix as v4.14-rt (6cec8467) to system_state check in allocate_slab().
With those changes, the unpin_current_cpu() WARNING has not occured
in more than 20,000 reboots on multiple environments[4].

As a side effect, all other codes which does not know SYSTEM_SCHEULDING
yet needs to be adjusted like commits in the series[3].

[1] https://lore.kernel.org/all/TYCPR01MB11385E3CDF05544B63F7EF9C1E1622@TYCPR01MB11385.jpnprd01.prod.outlook.com/
[2] https://docs.kernel.org/locking/locktypes.html#raw-spinlock-t-on-rt
[3] https://lore.kernel.org/all/20170516184231.564888231@linutronix.de/T/
[4] https://lore.kernel.org/all/TYCPR01MB1138579CA7612B568BB880652E1272@TYCPR01MB11385.jpnprd01.prod.outlook.com/

Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index fd23ff951395..3db76fd92861 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1412,7 +1412,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if (gfpflags_allow_blocking(flags))
 		enableirqs = true;
 #ifdef CONFIG_PREEMPT_RT_FULL
-	if (system_state == SYSTEM_RUNNING)
+	if (system_state > SYSTEM_BOOTING)
 		enableirqs = true;
 #endif
 	if (enableirqs)
-- 
2.30.2


