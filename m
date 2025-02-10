Received: from mo-csw-fb.securemx.jp (mo-csw-fb1120.securemx.jp [210.130.202.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68F62F2E;
	Mon, 10 Feb 2025 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739175392; cv=none; b=sf1dN4mNSH3YCVamo5L3oHf65MjI1gnItiAMZD9+dGuEyKaNzZ1vck++uuhl1yQJNN9fxSKR7k6Gm5xzpK0K4g0DfU10Zlz1LGAmY6hVie23T86pJkPxBS7R1Oz/aszGXSzTiYV0k1lxzlLtyHHyRroooEflgrzr/fYx4XuyXYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739175392; c=relaxed/simple;
	bh=oeSTV1dI+T8GrwEAkCPvGHesDTdealGcRC8KdexYD5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=as6Y5LJx1BpBaG6JHYe6yS2oGXsafSY1b9BqobQMtw5fYMagKT2+7B20n5xe97eaYHr8EDxmNvRYipd6/i+XGAUw5+1WT5eem1xEP3MrXrIDvZfRR1o0zpZ3vWPY25zc0ltD+zRjtBNP+FQV+AGU7LMnyAZPJhBfK/qkFwhIllA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b=AnC3Hm5Y; arc=none smtp.client-ip=210.130.202.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b="AnC3Hm5Y"
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1120) id 51A6uotC216575; Mon, 10 Feb 2025 15:56:50 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170575;x=1740380175;bh=oeSTV
	1dI+T8GrwEAkCPvGHesDTdealGcRC8KdexYD5I=;b=AnC3Hm5Y9xk8JXuJN1dIXHrxvS428YIDA5X
	HWM0a1+I4rouWYEJpr/xRVuiBjunane+Ja9ZOy+ytmw7+TxD4zJkVN/Z50cTkjbRJPDaBd29ysmyn
	CRRZLzuO1drzVvDKlRsM5AhX/RS/3S22xaF+wL90RfFL0IqCe9JQ4xPpvxB5coy/XFgOQmacv1qeg
	zVL2WA4GCXdc2h2n8aBT1/w0K9mOXhJK6BL1lTShMAzJAznbf+3y8/+psQaN7+icFG1x7KAD54RST
	DGrmdPrK0oyqKPp8/Y28QrtnJURMyRQPCYOQkfeCDfqJs3lQanb+Jx7qh0rjRtStkXCdS1wQm7bA=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 51A6uFb13832482; Mon, 10 Feb 2025 15:56:15 +0900
X-Iguazu-Qid: 2rWhSHZE3yt6r0xIbx
X-Iguazu-QSIG: v=2; s=0; t=1739170569; q=2rWhSHZE3yt6r0xIbx; m=Y0hJNGDdcj4uKOoeojwG12+1jPvQ2I44K5L5a9Bg+kc=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 51A6u6tX182804
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:07 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 03/17] arm64: Adjust system_state check
Date: Mon, 10 Feb 2025 15:55:31 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-4-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

commit ef284f5ca5f102bf855e599305c0c16d6e844635 upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state check in smp_send_stop() to handle the extra states.

Conflicts: arch/arm64/kernel/smp.c
82611c14 moves per-CPU stop message from ipi_cpu_stop() to smp_send_stop(),
but no change in checking system_state condition.
Apply the change to ipi_cpu_stop() instead.

Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/20170516184735.112589728@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 arch/arm64/kernel/smp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 36182dafd63c..9b21b6ccc3f1 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -685,8 +685,7 @@ static DEFINE_RAW_SPINLOCK(stop_lock);
  */
 static void ipi_cpu_stop(unsigned int cpu)
 {
-	if (system_state == SYSTEM_BOOTING ||
-	    system_state == SYSTEM_RUNNING) {
+	if (system_state <= SYSTEM_RUNNING) {
 		raw_spin_lock(&stop_lock);
 		pr_crit("CPU%u: stopping\n", cpu);
 		dump_stack();
-- 
2.30.2


