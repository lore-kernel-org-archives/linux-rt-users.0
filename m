Received: from mo-csw.securemx.jp (mo-csw1120.securemx.jp [210.130.202.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1681ACEAC;
	Mon, 10 Feb 2025 06:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170612; cv=none; b=QNjjY9IXgcsinr3mSeSqjKHI4xDJ3U5yYgKUwb2F4g4HuFBpKlytAdVen4z+HVTQyVhzNE7eOESec/QiGWMEx6zcKKqRDG09VPi5mucu/aossTcVMhwgkENhqUhPTC8k2rHE5wwcLihCdqda51bcIq5BIayEQbDckdtcaBPlVeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170612; c=relaxed/simple;
	bh=tzD5UnyZwjInSLknlehUgMLUsGKRRIAWVDJzXwhh1Dc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UPdLtvGoQNwNW9CbT4F92+IqAYMOCsC4zf9gB+5DktD256fk+7HB+JMLgMW5xgUZ9IaiAkTu+UcKmErPM9A91L6UEpxTAWvUZbtrlRwkd4Kgl/uAVBmeNMBxKkvcsRnrz+IGzw01DgP6/6wvfd/SIdXoaB2P1JPGmBGRR3Qb0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b=aCX/vASB; arc=none smtp.client-ip=210.130.202.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b="aCX/vASB"
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170576;x=1740380176;bh=tzD5U
	nyZwjInSLknlehUgMLUsGKRRIAWVDJzXwhh1Dc=;b=aCX/vASBJa9J7XHQjiqmCgQEmBa1/Mt3afV
	FetRNRM0/CdH6cNoiF9NHl6IGAFW73LaeReYLptonu6qfMQwBGcoLqJw8xd3AnAY+/2FW7nugcryo
	/AHnsR4p7IrwVv96rmGvtAx9ook1UeMMi2WfyjM1M0DCoepeNbyKf1oq3kKZi3+A/pJmuF/zzrpg/
	72ALg5QdbS5ake6ktMD638UENnUZfINf64PSc2JZrkvQp/F6I4M4gUJ1Q+4t/SkDhnEttr2+EbeMo
	RApCuQ6ZDsEx2VyxtFT1+Vnik4n7UH8uUVzoqJCVhGeCuj8c5EaMQ6rNDNjbBBduFdd9Ns824T5w=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 51A6uGw33587747; Mon, 10 Feb 2025 15:56:16 +0900
X-Iguazu-Qid: 2rWhWAeBjX3UYC8AJ6
X-Iguazu-QSIG: v=2; s=0; t=1739170569; q=2rWhWAeBjX3UYC8AJ6; m=YXkk/oYQcG59h4NUfNxnbqOT6lCvTE7NmT2B5wixTK0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 51A6u7He859155
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:07 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 05/17] metag: Adjust system_state check
Date: Mon, 10 Feb 2025 15:55:33 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-6-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

commit dcd2e4734b428709984e2fa35ebbd6cccc246d47 upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state check in stop_this_cpu() to handle the extra states.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20170516184735.283420315@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 arch/metag/kernel/smp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/metag/kernel/smp.c b/arch/metag/kernel/smp.c
index c3c6f0864881..0bc03c257fe6 100644
--- a/arch/metag/kernel/smp.c
+++ b/arch/metag/kernel/smp.c
@@ -565,8 +565,7 @@ static void stop_this_cpu(void *data)
 {
 	unsigned int cpu = smp_processor_id();
 
-	if (system_state == SYSTEM_BOOTING ||
-	    system_state == SYSTEM_RUNNING) {
+	if (system_state <= SYSTEM_RUNNING) {
 		spin_lock(&stop_lock);
 		pr_crit("CPU%u: stopping\n", cpu);
 		dump_stack();
-- 
2.30.2


