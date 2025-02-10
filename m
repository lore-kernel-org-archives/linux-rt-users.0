Received: from mo-csw.securemx.jp (mo-csw1120.securemx.jp [210.130.202.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD101ADC86;
	Mon, 10 Feb 2025 06:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170613; cv=none; b=q9gOd0arfkrLub6BtSQQVMoHtz2S+YjKOP3vAH1KnWuRUp+xZToaJkRpagqxC1685IHfpjVDZaUEVYkshBPwPnVoj2eqaL45EaH3pcNTQU7aMsCUAmAhc0YDHGWYnbeGb7WnNpBPAIq79pPh6gWJM3xwNXvPHM3YaJslsL3qckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170613; c=relaxed/simple;
	bh=b8rrfMXIzh/6gB/7BIug22meGebSbUh7PWeoHodsWAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bacOQvYcM6srFrVBfFfpNcZKEBk0cEwpciwcBFb0cHw4SSv7VoUDhVEesowXvJS8YrjN+qXFrSnLcLFg6uqCvtJuMDoGuJtMjop6s19lPR1/liVTPC+NbDhv8MKWnLHL8qn2lnpOAT1ITfEEkjF9jLSC28/3XesOYAo0rRPr4g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b=br51Xz3i; arc=none smtp.client-ip=210.130.202.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b="br51Xz3i"
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170571;x=1740380171;bh=b8rrf
	MXIzh/6gB/7BIug22meGebSbUh7PWeoHodsWAI=;b=br51Xz3iZcURVQ7VFWDs/bRTbCF1f4cUVE5
	gsxGtHiMrCFJ8ilSMmaUebb8+CmTyfo9gYdy3r58IB7by14ziMdByvmKE4qudPK8CeLBL3mUGXNaQ
	+OMfwCl90oK8kxOfcMjoTe5rGRUAB2OZj4wyaD5wpXRW0lT8S3HpOhsWXGae/2i/XgB1TjguY66o0
	V22egeAr/zn1A36UFg24VVw9EwQvd/ul5I5KNbAOEiDKqwAmw5DsW0y/+0w2i+eeGL5fxXU1HigG5
	hTkHwtv21XSJJzRA0E+AICusXOh7vccmGWyp3/rlDjcg/vQC2QjT02N1RKTy9jnOz0geTrf+U9fw=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 51A6uANx3587290; Mon, 10 Feb 2025 15:56:10 +0900
X-Iguazu-Qid: 2rWhqikycnTS8B6ZlK
X-Iguazu-QSIG: v=2; s=0; t=1739170569; q=2rWhqikycnTS8B6ZlK; m=QJxngnsd5z1jHW2IqHw3hANCAKlwKNbBxxbFR6RYx9I=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 51A6u7Eb182827
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:07 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 06/17] powerpc: Adjust system_state check
Date: Mon, 10 Feb 2025 15:55:34 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-7-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

commit a8fcfc1917681ba1ccc23a429543a67aad8bfd00 upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state check in smp_generic_cpu_bootable() to handle the
extra states.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20170516184735.359536998@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 arch/powerpc/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 19ba60ab1807..5dff1a750e49 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -94,7 +94,7 @@ int smp_generic_cpu_bootable(unsigned int nr)
 	/* Special case - we inhibit secondary thread startup
 	 * during boot if the user requests it.
 	 */
-	if (system_state == SYSTEM_BOOTING && cpu_has_feature(CPU_FTR_SMT)) {
+	if (system_state < SYSTEM_RUNNING && cpu_has_feature(CPU_FTR_SMT)) {
 		if (!smt_enabled_at_boot && cpu_thread_in_core(nr) != 0)
 			return 0;
 		if (smt_enabled_at_boot
-- 
2.30.2


