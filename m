From: Sven-Thorsten Dietrich <sdietrich@novell.com>
Subject: [PATCH][RT] 2.6.24-rc2-rt1 drivers/dma/ioat_dma.c compile fix
Date: Fri, 16 Nov 2007 03:57:25 -0800
Message-ID: <1195214245.3241.37.camel@sx.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LKML <Linux-kernel@vger.kernel.org>
To: RT Users List <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:44312 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbXKPL5d (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Nov 2007 06:57:33 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Compile fix for new code in -rc2.

I'm not positive about the insertion point...

Subject: compile error fix (needs review)

RT changes __list_splice to require prev and next pointers. 

This changes the use in the new code to list_splice_tail, 
but the optimal insertion point needs to be analyzed.

Signed-off-by: Sven-Thorsten Dietrich <sdietrich@suse.de>

---
 drivers/dma/ioat_dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.23/drivers/dma/ioat_dma.c
===================================================================
--- linux-2.6.23.orig/drivers/dma/ioat_dma.c
+++ linux-2.6.23/drivers/dma/ioat_dma.c
@@ -244,7 +244,7 @@ static dma_cookie_t ioat_tx_submit(struc
 	/* write address into NextDescriptor field of last desc in chain */
 	to_ioat_desc(ioat_chan->used_desc.prev)->hw->next =
 							first->async_tx.phys;
-	__list_splice(&new_chain, ioat_chan->used_desc.prev);
+	list_splice_tail(&new_chain, ioat_chan->used_desc.prev);
 
 	ioat_chan->pending += desc_count;
 	if (ioat_chan->pending >= 4) {
