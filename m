Received: from mo-csw.securemx.jp (mo-csw1802.securemx.jp [210.130.202.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585C3199FBA;
	Mon, 10 Feb 2025 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170610; cv=none; b=oWT83BAd+bXd4sydJtrfsN2WC7srtLt+b4D3g3Rg1Ez+clQbJ0kGtRvbXobhfwZA8gUD+yWYhNqZaXmYz1yRrjre31jtVWB+eLqEhTWn2S9eyxncSRkJB8XgB4fRuOrBVAy+8Jzx3p2XLj6C5HhbP9QFdPyBcAf6KEGsm9VADwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170610; c=relaxed/simple;
	bh=r2bGSQuW3OUidgcECmo0HgSV1D5FG/L2Ld2WCzZKiPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cei6V2HFAzMH+8dxTaWqqKEq+sBK21Yr9+SDp3wy6hcQhUcYu1nFHmmT7jwOFM04oxywU2pHjitdT1qpRA4Tlz7OLnVMQ1+Y5S8+jX4FnKBRSIoB3DB51G2BN3dc2drzQufMAg2O4FWb8W5zdf8i9kXF2yfVcrP5PpVk2P/uf+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b=knnD/rSR; arc=none smtp.client-ip=210.130.202.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b="knnD/rSR"
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170573;x=1740380173;bh=r2bGS
	QuW3OUidgcECmo0HgSV1D5FG/L2Ld2WCzZKiPg=;b=knnD/rSRtEjokv4nwpdZLTt24aAMsPdzs30
	OcZ6S48JJdY/JH8RrWYc+VapW96fUUfmO9pwBuSwy6Z81o9Bo7JuS7ovppPkUG+gTH/mlRg3+dBnl
	GDZM03E3lWJDfnU/rBAG6SmfvNQbrJIfDkF8+PUgC6r4RdQVl1fkmoe2OyAaAxohC1jU+GVinBcTU
	ilZt8iMKavIFJkjofP0PrO92gSlN0bILFlVMnOcMIt1XqmDAJCruup0n5Y3Sm5OTi74UG+73/mZcg
	uHlD7VTjpywQ0fFNnvcyGH4yr6wleFw74zKQGqQEMjUoxK/qaiXOSkwJ/5TP1Rhk7Ocg4HNahWww=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 51A6uDGN3387803; Mon, 10 Feb 2025 15:56:13 +0900
X-Iguazu-Qid: 2yAbAvUQLMDymhsI13
X-Iguazu-QSIG: v=2; s=0; t=1739170568; q=2yAbAvUQLMDymhsI13; m=cJHL28zEPBgbgE/lC5o0LDRLsvlwWkSeNef5Mf90hzM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 51A6u8Qw4036156
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:08 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 13/17] printk: Adjust system_state checks
Date: Mon, 10 Feb 2025 15:55:41 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-14-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

commit ff48cd26fc4889b9deb5f9333d3c61746e450b7f upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state check in boot_delay_msec() to handle the extra
states.

Conflicts: kernel/printk/printk.c
cf775444 replace the third condition that boot_delay_msec() returns
immediately with suppress_message_printing(). This does not affect
system_state check.

Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20170516184736.027534895@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d8e0790f56cb..8d1e081bf9fc 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1077,7 +1077,7 @@ static void boot_delay_msec(int level)
 	unsigned long long k;
 	unsigned long timeout;
 
-	if ((boot_delay == 0 || system_state != SYSTEM_BOOTING)
+	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
 		|| (level >= console_loglevel && !ignore_loglevel)) {
 		return;
 	}
-- 
2.30.2


