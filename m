From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 5/5] [POWERPC] flush_tlb_pending() is no more, use __flush_tlb_pending() instead.
Date: Tue, 04 Sep 2007 17:09:02 +1000
Message-ID: <20070904070902.92AD732CA0E@thor>
References: <1188889742.376.642108109551.qpush@thor>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pythia.bakeyournoodle.com ([203.82.209.197]:35382 "EHLO
	pythia.bakeyournoodle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbXIDHV3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Sep 2007 03:21:29 -0400
Received: from thor (localhost [127.0.0.1])
	by pythia.bakeyournoodle.com (Postfix) with ESMTP id D917513C33
	for <linux-rt-users@vger.kernel.org>; Tue,  4 Sep 2007 15:09:02 +0800 (WST)
In-Reply-To: <1188889742.376.642108109551.qpush@thor>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

---

 arch/powerpc/mm/tlb_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: working/arch/powerpc/mm/tlb_64.c
===================================================================
--- working.orig/arch/powerpc/mm/tlb_64.c	2007-09-04 16:46:40.000000000 +1000
+++ working/arch/powerpc/mm/tlb_64.c	2007-09-04 16:47:08.000000000 +1000
@@ -211,7 +211,7 @@ void hpte_need_flush(struct mm_struct *m
 	 * always flush it on RT to reduce scheduling latency.
 	 */
 	if (machine_is(celleb)) {
-		flush_tlb_pending();
+		__flush_tlb_pending(batch);
 		return;
 	}
 #endif /* CONFIG_PREEMPT_RT */
