From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] Fix typo in use of BUG_ON_NONRT macro for RT
Date: Tue, 15 Nov 2011 13:58:07 +0100
Message-ID: <1321361887-544-1-git-send-email-jkacur@redhat.com>
Cc: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

In drivers/md/dm.c BUG_ON_NORT should be BUG_ON_NONRT

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 drivers/md/dm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index e917b7f..b1eff42 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1648,14 +1648,14 @@ static void dm_request_fn(struct request_queue *q)
 		if (map_request(ti, clone, md))
 			goto requeued;
 
-		BUG_ON_NORT(!irqs_disabled());
+		BUG_ON_NONRT(!irqs_disabled());
 		spin_lock(q->queue_lock);
 	}
 
 	goto out;
 
 requeued:
-	BUG_ON_NORT(!irqs_disabled());
+	BUG_ON_NONRT(!irqs_disabled());
 	spin_lock(q->queue_lock);
 
 delay_and_out:
-- 
1.7.2.3
