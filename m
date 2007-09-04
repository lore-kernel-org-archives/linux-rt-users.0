From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 4/5] [POWERPC] flags as passed to spin_*_irqsave() should be unsigned long.
Date: Tue, 04 Sep 2007 17:09:02 +1000
Message-ID: <20070904070902.847F832CA0D@thor>
References: <1188889742.376.642108109551.qpush@thor>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pythia.bakeyournoodle.com ([203.82.209.197]:35381 "EHLO
	pythia.bakeyournoodle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbXIDHV3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Sep 2007 03:21:29 -0400
Received: from thor (localhost [127.0.0.1])
	by pythia.bakeyournoodle.com (Postfix) with ESMTP id D4BEB13C32
	for <linux-rt-users@vger.kernel.org>; Tue,  4 Sep 2007 15:09:02 +0800 (WST)
In-Reply-To: <1188889742.376.642108109551.qpush@thor>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

---

 drivers/net/pasemi_mac.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: working/drivers/net/pasemi_mac.c
===================================================================
--- working.orig/drivers/net/pasemi_mac.c	2007-09-04 16:46:40.000000000 +1000
+++ working/drivers/net/pasemi_mac.c	2007-09-04 16:47:01.000000000 +1000
@@ -524,7 +524,7 @@ static int pasemi_mac_clean_tx(struct pa
 	struct pasemi_mac_buffer *info;
 	struct pas_dma_xct_descr *dp;
 	int start, count;
-	int flags;
+	unsigned long flags;
 
 	spin_lock_irqsave(&mac->tx->lock, flags);
 
@@ -950,7 +950,7 @@ static int pasemi_mac_start_tx(struct sk
 	struct pas_dma_xct_descr *dp;
 	u64 dflags;
 	dma_addr_t map;
-	int flags;
+	unsigned long flags;
 
 	dflags = XCT_MACTX_O | XCT_MACTX_ST | XCT_MACTX_SS | XCT_MACTX_CRC_PAD;
 
