From: Luis Henriques <henrix@sapo.pt>
Subject: [PATCH -rt] Trivial changes to mm/page_alloc.c in -rt git tree
Date: Sun, 1 Feb 2009 19:47:19 +0000
Message-ID: <20090201194719.GA5383@hades.domain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755501AbZBATso@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Some trivial changes in function drain_zone_pages, in -rt tree.

Invocations to functions get_cpu_lock_cpu_irqsave/restore in function
drain_zone_pages missing the ';' character.

---
 mm/page_alloc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 238e192..3b18a12 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -889,14 +889,14 @@ void drain_zone_pages(int cpu, struct zone *zone, struct per_cpu_pages *pcp)
 	unsigned long flags;
 	int to_drain;
 
-	get_cpu_lock_cpu_irqsave(zone, cpu, flags)
+	get_cpu_lock_cpu_irqsave(zone, cpu, flags);
 	if (pcp->count >= pcp->batch)
 		to_drain = pcp->batch;
 	else
 		to_drain = pcp->count;
 	free_pages_bulk(zone, to_drain, &pcp->list, 0);
 	pcp->count -= to_drain;
-	put_cpu_lock_irqrestore(zone, cpu, flags)
+	put_cpu_lock_irqrestore(zone, cpu, flags);
 }
 #endif
 
-- 
1.5.6.5
