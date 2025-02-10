Received: from mo-csw.securemx.jp (mo-csw1801.securemx.jp [210.130.202.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848D11ADC68;
	Mon, 10 Feb 2025 06:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170611; cv=none; b=naEZMM8U5vRGq/+Scbda/76M2YmjugrOiOktYS9Crsy5t1spJ4PN/pOaJOhy9GhGkNY2JA33SLUYugOiC0Xqub28vwyFVUbH8BikFGpWsM4ATNwHO9SqZEepLrKltnvYzbkl9JihkAy4JVG2I9fpE38gN/Msyi3Qz4qZ+19z/xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170611; c=relaxed/simple;
	bh=7ik5tU+aigkCH+DjxsodxVPjPp2fSYh7lpQZcnFBhMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IVb5dcYHGCGZtWSmMSWGu6TwtufwBdV5ogkM8vhcMahnv5R/Mn3dlsdTloD2ck4MzWJfuEhyNQN+tw90eou6jMj+dtdvqCwNoAX0oGOtGyo2gX7+NJDDUjmLyVGW/PKT7sCO0EdD2dhTgJsEzgn1HZF9DvRYrZy6ELk6SJtwL+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b=d3d2EDfY; arc=none smtp.client-ip=210.130.202.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b="d3d2EDfY"
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170573;x=1740380173;bh=7ik5t
	U+aigkCH+DjxsodxVPjPp2fSYh7lpQZcnFBhMU=;b=d3d2EDfYsSuwE5qp9yxTdvbvKzIo3gp1Vvl
	X5vuJ54hVyogvK0mZOho/e4byR+tG67kmFazsnec9xhuo4DH/aJN6a32fpScULSAHJRyvgXTgNUjq
	kpL7jZ45W4YMyNnOjjp7lc4Zqp7wZKsNstLTOHnZd21HEJ8z4IdYTCj8xuTFapv8h/FTGh5Yjz/qQ
	/vhypP+lwWJAEbKcQccG1g8fjkA9OgtN7531DwRQC4bD8RlRtl17CRR42ur6Zoqq0KNwyiFDYqNAt
	H+FtnwrjFzq4i0OabTmcjt70/L4ApgK/at85cDmS65rfPhzFM5yX+EBMN+jBf1qFg8pmLg43y4VQ=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 51A6uDYW3258916; Mon, 10 Feb 2025 15:56:13 +0900
X-Iguazu-Qid: 2yAbAvUQLMDymhsI12
X-Iguazu-QSIG: v=2; s=0; t=1739170568; q=2yAbAvUQLMDymhsI12; m=z6ixCw7oMkuV8hIiY7pyEwGC8S/FFfZk875O/LRTkb0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 51A6u6A24036125
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:07 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 04/17] x86/smp: Adjust system_state check
Date: Mon, 10 Feb 2025 15:55:32 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-5-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

commit 719b3680d1f789c1e3054e3fcb26bfff07c3c623 upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state check in announce_cpu() to handle the extra states.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20170516184735.191715856@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 arch/x86/kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0512af683871..2a9ada6fa7d0 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -721,7 +721,7 @@ static void announce_cpu(int cpu, int apicid)
 	if (cpu == 1)
 		printk(KERN_INFO "x86: Booting SMP configuration:\n");
 
-	if (system_state == SYSTEM_BOOTING) {
+	if (system_state < SYSTEM_RUNNING) {
 		if (node != current_node) {
 			if (current_node > (-1))
 				pr_cont("\n");
-- 
2.30.2


