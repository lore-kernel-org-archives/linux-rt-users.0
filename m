From: Jeff Epler <jepler@unpythonic.net>
Subject: [PATCH 4/4] spidev-s3c64xx: allocate dma channel at startup
Date: Mon,  1 Sep 2014 09:30:35 -0500
Message-ID: <1409581835-70814-5-git-send-email-jepler@unpythonic.net>
References: <1409581835-70814-1-git-send-email-jepler@unpythonic.net>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rrcs-76-79-27-186.west.biz.rr.com ([76.79.27.186]:48319 "EHLO
	rrcs-76-79-27-186.west.biz.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754516AbaIAPAd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Sep 2014 11:00:33 -0400
In-Reply-To: <1409581835-70814-1-git-send-email-jepler@unpythonic.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

it appears that acquire_dma introduces intolerable delays; the system
is fine with the dma channnels allocated all the time.
---
 drivers/spi/spi-s3c64xx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 92de1b5..e6a46c9 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -797,10 +797,6 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
 
-	/* Acquire DMA channels */
-	while (!acquire_dma(sdd))
-		msleep(10);
-
 	pm_runtime_get_sync(&sdd->pdev->dev);
 
 	return 0;
@@ -810,10 +806,6 @@ static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
 
-	/* Free DMA channels */
-	sdd->ops->release(sdd->rx_dma.ch, &s3c64xx_spi_dma_client);
-	sdd->ops->release(sdd->tx_dma.ch, &s3c64xx_spi_dma_client);
-
 	pm_runtime_put(&sdd->pdev->dev);
 
 	return 0;
@@ -1344,6 +1336,9 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 		goto err7;
 	}
 
+        // cannot fail(?)
+	acquire_dma(sdd);
+
 	writel(S3C64XX_SPI_INT_RX_OVERRUN_EN | S3C64XX_SPI_INT_RX_UNDERRUN_EN |
 	       S3C64XX_SPI_INT_TX_OVERRUN_EN | S3C64XX_SPI_INT_TX_UNDERRUN_EN,
 	       sdd->regs + S3C64XX_SPI_INT_EN);
@@ -1396,6 +1391,10 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 
 	spi_unregister_master(master);
 
+	/* Free DMA channels */
+	sdd->ops->release(sdd->rx_dma.ch, &s3c64xx_spi_dma_client);
+	sdd->ops->release(sdd->tx_dma.ch, &s3c64xx_spi_dma_client);
+
 	writel(0, sdd->regs + S3C64XX_SPI_INT_EN);
 
 	free_irq(platform_get_irq(pdev, 0), sdd);
-- 
2.0.1

