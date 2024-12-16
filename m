Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC352F5B
	for <linux-rt-users@vger.kernel.org>; Mon, 16 Dec 2024 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734375893; cv=none; b=ehJEvf5KBXlBjf1R2fh9guaAy8bigxFex89zmXwKk6naZVqHcZThrKpU5Zs1RJ1s1CNSCG6iE+Fz9LGO/V/A5E3Y5QbRgQCz4JlGufP3WYI2VnvyXiZOxnFnPnXs5EJndm2JpAjtIDnXUtPQKHuxr3KGPA0C7ObLfs+nnqDGcuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734375893; c=relaxed/simple;
	bh=pryFWyOFOEDHk615hWgPzFh8BmqBeR4WY5a979bgRnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYmesMEKhnKZS9dfRLUkJfi3SPwKG/+79Rder/LErUTL7rBlPVg6khvGskGg3SlHzubIQCXmtG3AxqcB+KFOqLvE5gXuMoS7mQtcNeLNcTyrXQYuiroVYXbOhxk7PIy4QR6ZANM3zq4xEwqvh/2TUGqWXMSpvXdHjCxt9AG06Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A06D11FB;
	Mon, 16 Dec 2024 11:05:17 -0800 (PST)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7663B3F58B;
	Mon, 16 Dec 2024 11:04:48 -0800 (PST)
Date: Mon, 16 Dec 2024 19:04:43 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Petr Tesarik <ptesarik@suse.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: Lazy preemption on arm64
Message-ID: <Z2B5y3HiLuRHPfdv@J2N7QTR9R3.cambridge.arm.com>
References: <20241216190451.1c61977c@mordecai.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216190451.1c61977c@mordecai.tesarici.cz>

On Mon, Dec 16, 2024 at 07:04:51PM +0100, Petr Tesarik wrote:
> Hi all,
> 
> what is the plan for implementing PREEMPT_LAZY on arm64?
> 
> There used to be RT patch series which enabled lazy preemption on
> arm64, but this architecture was "sacrificed" in v6.6-rc6-rt10, as
> collateral damage of switching to PREEMPT_AUTO.
> 
> IIUC lazy preemption is currently implemented only for architectures
> with CONFIG_GENERIC_ENTRY, but there is no inherent dependency on it.
> So, is the plan to convert arm64 to GENERIC_ENTRY (and then get
> PREEMPT_LAZY for free), or is somebody working on CONFIG_PREEMPT_LAZY
> for arm64 without that conversion?

I don't think there's an agreed upon plan either way.

Jinjie Ruan has been looking to move arm64 over to GENERIC_ENTRY:

  https://lore.kernel.org/all/20241206101744.4161990-1-ruanjinjie@huawei.com/

AFAICT, the only bits that we get "for free" from GENERIC_ENTRY would be
the logic in raw_irqentry_exit_cond_resched() and
exit_to_user_mode_loop(), and all we'd need to enable this on arm64
as-is would be as below.

... so how important is this?

Mark.

---->8----
From 16ae3c84d8e1691fe670dbfb4c643cab4fa2065f Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Mon, 16 Dec 2024 18:32:44 +0000
Subject: [PATCH] HACK: arm64: enable PREEMPT_LAZY

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/thread_info.h | 12 +++++++-----
 arch/arm64/kernel/entry-common.c     |  2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 100570a048c5e..7926bc78a1c46 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -39,6 +39,7 @@ config ARM64
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
+	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 1114c1c3300a1..a2125407901ed 100644
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
2.30.2

