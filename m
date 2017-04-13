From: Pankaj Gupta <pagupta@redhat.com>
Subject: [PATCH] dma-debug: Make locking to work for RT
Date: Thu, 13 Apr 2017 12:11:06 +0530
Message-ID: <1492065666-3816-1-git-send-email-pagupta@redhat.com>
Cc: akpm@linux-foundation.org, mingo@kernel.org,
        niklas.soderlund+renesas@ragnatech.se, vinod.koul@intel.com,
        luto@kernel.org, ville.syrjala@linux.intel.com,
        miles.chen@mediatek.com, mtosatti@redhat.com
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750811AbdDMGlQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Apr 2017 02:41:16 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Interrupt enable/disabled with spinlock is not a valid
implementation for RT as it can make executing task to 
sleep from a non-sleepable context. So, converting it 
to spin_lock_irq[save, restore].

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 lib/dma-debug.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index b157b46..fe4d50c 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -942,21 +942,17 @@ static int device_dma_allocations(struct device *dev, struct dma_debug_entry **o
 	unsigned long flags;
 	int count = 0, i;
 
-	local_irq_save(flags);
-
 	for (i = 0; i < HASH_SIZE; ++i) {
-		spin_lock(&dma_entry_hash[i].lock);
+		spin_lock_irqsave(&dma_entry_hash[i].lock, flags);
 		list_for_each_entry(entry, &dma_entry_hash[i].list, list) {
 			if (entry->dev == dev) {
 				count += 1;
 				*out_entry = entry;
 			}
 		}
-		spin_unlock(&dma_entry_hash[i].lock);
+		spin_unlock_irqrestore(&dma_entry_hash[i].lock, flags);
 	}
 
-	local_irq_restore(flags);
-
 	return count;
 }
 
-- 
2.7.4

