Received: from mo-csw.securemx.jp (mo-csw1800.securemx.jp [210.130.202.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED321AC892;
	Mon, 10 Feb 2025 06:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170611; cv=none; b=Xzy1yrQFv2qsR6UVMHYdWqOvcRW9Jpn5vjaG3z6HuwZhiTOgsz469/eZ5FbNcdP81tB3ghmjnatrmPBRgw0+kgeBgLE4GMBN2/MhxOmsWmljq3WR58S3AaRuPPc85A9gj16YVmo0K8rkAJ4+Ee/a6TBYDi3RYepuTIpJpbji844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170611; c=relaxed/simple;
	bh=a5LTK8akCWYsmrwGmeEhr9jCA+rMnEe62GET8zmDZUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QDMcrlYFlUiDKwdZ+Ht/sQzU0tbGKf8dQyRF6q+x5yOb7IiRbC4cWEguOCmc2M5nLNn4FAj2gBE7GcjPHaX2D7xpq0wITHLFS1PYTUr/cSKOBRmbon+NQd/AjjzB/IXHUmt5qttwz3kGz/g2Pyxg/2c9ZJppA80dlDT1uFMBb38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b=T6wWCG0e; arc=none smtp.client-ip=210.130.202.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b="T6wWCG0e"
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170571;x=1740380171;bh=a5LTK
	8akCWYsmrwGmeEhr9jCA+rMnEe62GET8zmDZUQ=;b=T6wWCG0ey9/a9lM5PjPb+yZ4PCB5xM6FDk1
	pjOT/hNL852pjiNIuXe4P9cbYobZQ3Qngm4e+IOQnLuVPr6vUDIyuQVP0mz77/kBanR15/WdFOX+X
	loZ1Db0vWu193OqDNGszLpk4Csl5FeB+Ui4NX4q/HKZF4TKR4k3cz6LVcGnna6Ib/iRLXt2CuMLXB
	N7iUkVZbELVymTS0OJR0Rs3iT/hitTvEZCOiH9eayfylGFDx2xlLVjO5hHmsPxCb0JvkOyaY9XkdN
	i0XLGzyAcVOhx7eNFvSEvgl5itBwvqhEyR1qaojakC3nIbQZgYmv6aVGhBggKmVpa8PtwqKjpA6w=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 51A6uAe0789452; Mon, 10 Feb 2025 15:56:11 +0900
X-Iguazu-Qid: 2yAb5TJlesrnxmI0Tl
X-Iguazu-QSIG: v=2; s=0; t=1739170568; q=2yAb5TJlesrnxmI0Tl; m=g4tZugCPP0TUusDejRGAYeM/h6LsbKB+8TWBGMjBPFA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 51A6u7Cg1015852
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:07 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 08/17] mm: Adjust system_state check
Date: Mon, 10 Feb 2025 15:55:36 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-9-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

commit 8cdde385c7a33afbe13fd71351da0968540fa566 upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

get_nid_for_pfn() checks for system_state == BOOTING to decide whether to
use early_pfn_to_nid() when CONFIG_DEFERRED_STRUCT_PAGE_INIT=y.

That check is dubious, because the switch to state RUNNING happes way after
page_alloc_init_late() has been invoked.

Change the check to less than RUNNING state so it covers the new
intermediate states as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20170516184735.528279534@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 drivers/base/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 560751bad294..79d22c6aa401 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -366,7 +366,7 @@ static int __init_refok get_nid_for_pfn(unsigned long pfn)
 	if (!pfn_valid_within(pfn))
 		return -1;
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-	if (system_state == SYSTEM_BOOTING)
+	if (system_state < SYSTEM_RUNNING)
 		return early_pfn_to_nid(pfn);
 #endif
 	page = pfn_to_page(pfn);
-- 
2.30.2


