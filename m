Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2506A205E17
	for <linux-rt-users@vger.kernel.org>; Wed,  5 Mar 2025 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171828; cv=none; b=iDf5jsm/TqyH3zHqyXGuwkNPl2mXHykHrXb7ZQP67uok4y2bu0IvjxnTtaC54Cv2Xwq6IBvj919KyvK/rYwKKe9KbcEzV4j5TjTPpsm6mud2+jJ/RS3+1XPalDMoSH07APDHlA9watX61v4VAOs5Od327XcXds5H0NBSizBCS+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171828; c=relaxed/simple;
	bh=cmsthhp8/NkuQQkP9C3knJn41ySXxSSKRF4QmJN5Az8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c58lkKbglL4CK8/1Rd3C9vONixHv4RpY5DXE7W0IABotrAv/67rWk3iNhb4gxIab1iKwwiUaRYaHMXzDfLkIOTB0K4QBMS9tJxmrbxMHQ2BNif8TpCQPWZM5ZW0F2TKP5EDxGa3gYlZsHy9mB3DOKvOeQ2Yt3y2gf/EppYXXRho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iMEOw1se; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMEOw1se"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741171826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwAi6CpDFg+u1P0N2HGLBY5NxvRDUXxSPSsLQo91qeg=;
	b=iMEOw1seceze+OxI6bXlTnERrReqLdwiHSlipi+csjsFGh6CVw2GKzZ/wqb1nEuvCGGE7Q
	QI1k7VnM9/odGcVFSYsXrpRVebeVnWRJBBiXl6Lr0x45acstlFB1SorIqXGg5aopmRMRKy
	zSy3TIDI6fdLzMxc39jNPdTRX+mszLY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-4h_oXHHUPiatPH2cj0OVUQ-1; Wed,
 05 Mar 2025 05:50:07 -0500
X-MC-Unique: 4h_oXHHUPiatPH2cj0OVUQ-1
X-Mimecast-MFC-AGG-ID: 4h_oXHHUPiatPH2cj0OVUQ_1741171806
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3770118001CE;
	Wed,  5 Mar 2025 10:50:05 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.32.95])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8526B1954B32;
	Wed,  5 Mar 2025 10:49:58 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Mike Galbraith <efault@gmx.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Peter Collingbourne <pcc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr Tesarik <ptesarik@suse.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Phil Auld <pauld@redhat.com>
Subject: [PATCH 1/1] arm64: enable PREEMPT_LAZY
Date: Wed,  5 Mar 2025 11:49:25 +0100
Message-ID: <20250305104925.189198-2-vschneid@redhat.com>
In-Reply-To: <20250305104925.189198-1-vschneid@redhat.com>
References: <20250305104925.189198-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Mark Rutland <mark.rutland@arm.com>

For an architecture to enable CONFIG_ARCH_HAS_RESCHED_LAZY, two things are
required:
1) Adding a TIF_NEED_RESCHED_LAZY flag definition
2) Checking for TIF_NEED_RESCHED_LAZY in the appropriate locations

2) is handled in a generic manner by CONFIG_GENERIC_ENTRY, which isn't
(yet) implemented for arm64. However, outside of core scheduler code,
TIF_NEED_RESCHED_LAZY only needs to be checked on a kernel exit, meaning:
o return/entry to userspace.
o return/entry to guest.

The return/entry to a guest is all handled by xfer_to_guest_mode_handle_work()
which already does the right thing, so it can be left as-is.

arm64 doesn't use common entry's exit_to_user_mode_prepare(), so update its
return to user path to check for TIF_NEED_RESCHED_LAZY and call into
schedule() accordingly.

Link: https://lore.kernel.org/linux-rt-users/20241216190451.1c61977c@mordecai.tesarici.cz/
Link: https://lore.kernel.org/all/xhsmh4j0fl0p3.mognet@vschneid-thinkpadt14sgen2i.remote.csb/
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
[testdrive, _TIF_WORK_MASK fixlet and changelog.]
Signed-off-by: Mike Galbraith <efault@gmx.de>
[Another round of testing; changelog faff]
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/thread_info.h | 16 +++++++++-------
 arch/arm64/kernel/entry-common.c     |  2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fcdd0ed3eca89..7789d7fb6f191 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -41,6 +41,7 @@ config ARM64
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
+	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 1114c1c3300a1..4443ef2789758 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -59,11 +59,12 @@ void arch_setup_new_exec(void);
 
 #define TIF_SIGPENDING		0	/* signal pending */
 #define TIF_NEED_RESCHED	1	/* rescheduling necessary */
-#define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
-#define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
-#define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
-#define TIF_MTE_ASYNC_FAULT	5	/* MTE Asynchronous Tag Check Fault */
-#define TIF_NOTIFY_SIGNAL	6	/* signal notifications exist */
+#define TIF_NEED_RESCHED_LAZY	2	/* Lazy rescheduling needed */
+#define TIF_NOTIFY_RESUME	3	/* callback before returning to user */
+#define TIF_FOREIGN_FPSTATE	4	/* CPU's FP state is not current's */
+#define TIF_UPROBE		5	/* uprobe breakpoint or singlestep */
+#define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
+#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
 #define TIF_SYSCALL_TRACE	8	/* syscall trace active */
 #define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
 #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
@@ -85,6 +86,7 @@ void arch_setup_new_exec(void);
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
@@ -100,10 +102,10 @@ void arch_setup_new_exec(void);
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_TSC_SIGSEGV	(1 << TIF_TSC_SIGSEGV)
 
-#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
+#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
 				 _TIF_UPROBE | _TIF_MTE_ASYNC_FAULT | \
-				 _TIF_NOTIFY_SIGNAL)
+				 _TIF_NOTIFY_SIGNAL | _TIF_SIGPENDING)
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index b260ddc4d3e9a..7993fab0cab4c 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -132,7 +132,7 @@ static void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
 	do {
 		local_irq_enable();
 
-		if (thread_flags & _TIF_NEED_RESCHED)
+		if (thread_flags & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			schedule();
 
 		if (thread_flags & _TIF_UPROBE)
-- 
2.43.0

