From: Jeff Epler <jepler@unpythonic.net>
Subject: [PATCH 3/4] spidev: actually use synchronous transfers
Date: Mon,  1 Sep 2014 09:30:34 -0500
Message-ID: <1409581835-70814-4-git-send-email-jepler@unpythonic.net>
References: <1409581835-70814-1-git-send-email-jepler@unpythonic.net>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rrcs-76-79-27-186.west.biz.rr.com ([76.79.27.186]:16817 "EHLO
	rrcs-76-79-27-186.west.biz.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754491AbaIAPA2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Sep 2014 11:00:28 -0400
In-Reply-To: <1409581835-70814-1-git-send-email-jepler@unpythonic.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

this reduces a source of latency
---
 drivers/spi/spidev.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index dda7632..6e37c59 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -120,15 +120,9 @@ spidev_sync(struct spidev_data *spidev, struct spi_message *message)
 	if (spidev->spi == NULL)
 		status = -ESHUTDOWN;
 	else
-		status = spi_async(spidev->spi, message);
+		status = spi_sync(spidev->spi, message);
 	spin_unlock_irq(&spidev->spi_lock);
 
-	if (status == 0) {
-		wait_for_completion(&done);
-		status = message->status;
-		if (status == 0)
-			status = message->actual_length;
-	}
 	return status;
 }
 
-- 
2.0.1

