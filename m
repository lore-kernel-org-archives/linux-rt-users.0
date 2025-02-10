Received: from mo-csw.securemx.jp (mo-csw1800.securemx.jp [210.130.202.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDD01A8F8A;
	Mon, 10 Feb 2025 06:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170611; cv=none; b=lqxNkt81t+979nUOrq6UE4au6A4hilBDBFvPzOz1Vio+CjUlTnGdzPc9undYXaKFo9DekinID3y3ns4GYcIoBpslHI5IclEhSyb6xa1zt0stS3QU6vmBR6UhjFyjDtHhgXEF05HYjTmpugDwNey7nASXrhFx/2ZFAPI0VVHcKG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170611; c=relaxed/simple;
	bh=LacjTpN6fdSgOV/NnhQm9cOx14rxFw1BSnWAXKHY99I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gpC6gBNds22P3/L4uq/74xMYYUvxDj/IJK4Dme/TmY+dLzC8Lxz1gs2cVP67dhM35tnogzm5JvICowrVLoEHFqNmCbSUdcCHBCz0cziRDm5T1QR83w0jWA4Qjk1cCaQB0iIJ7Ppqotk7O8C/tQtNkx3kkPiUZLT1Rc6q6upqg8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b=PCDxFuqW; arc=none smtp.client-ip=210.130.202.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b="PCDxFuqW"
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170571;x=1740380171;bh=LacjT
	pN6fdSgOV/NnhQm9cOx14rxFw1BSnWAXKHY99I=;b=PCDxFuqWCez+GJb9W3bm1Ld9MckiRtHX/n1
	fa6oq339F+WSzPFy5sDQDE41zPod8eIh2LfYuTlqQxMu+GHqZxDmBkrVEoRxCcQMcv61DxZWR9ZL5
	/IqWgcMF+JeZHWQ4+477b8/Y9f/ZIBQphYeZ68KCVPAhzxb5y47gPueGEWe6SLOWB4CNZ87a5ctO6
	vSRAwSr0/SqdbhBg8sHD7UuhytHZrV9+L0T2PHewsyD/de0t+GtGoOPhokdGlIDvQ4VsO1aicGzXX
	og5SB8vlK0n+d2VVHZvo+QZqXIfAK1dVIw8PRD6Yk6NDjx9CjXDpxjwIJEbydacJan2DdhJS/n6w=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 51A6uA5C789405; Mon, 10 Feb 2025 15:56:10 +0900
X-Iguazu-Qid: 2yAbpfLvFIKSbpKASb
X-Iguazu-QSIG: v=2; s=0; t=1739170568; q=2yAbpfLvFIKSbpKASb; m=Reug4TbvHHwhrFEIwyFoQhcztFgDCGfAzKkgoFM+1PQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 51A6u6OO977772
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:06 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 02/17] arm: Adjust system_state check
Date: Mon, 10 Feb 2025 15:55:30 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-3-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

commit 5976a66913a8bf42465d96776fd37fb5631edc19 upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state check in ipi_cpu_stop() to handle the extra states.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20170516184735.020718977@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 arch/arm/kernel/smp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index ffa533a4ef57..7b32330185bc 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -587,8 +587,7 @@ static DEFINE_RAW_SPINLOCK(stop_lock);
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


