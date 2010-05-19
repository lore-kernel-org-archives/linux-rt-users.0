From: Alessio Igor Bogani <abogani@texware.it>
Subject: [PATCH] Comedi: usbdux: Fix a syntax error
Date: Wed, 19 May 2010 16:48:32 +0200
Message-ID: <1274280512-28478-1-git-send-email-abogani@texware.it>
Cc: Linux RT users <linux-rt-users@vger.kernel.org>,
	Alessio Igor Bogani <abogani@texware.it>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37626 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab0ESOsl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 May 2010 10:48:41 -0400
Received: by fxm10 with SMTP id 10so2429509fxm.19
        for <linux-rt-users@vger.kernel.org>; Wed, 19 May 2010 07:48:40 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Alessio Igor Bogani <abogani@texware.it>
---
 drivers/staging/comedi/drivers/usbdux.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/comedi/drivers/usbdux.c b/drivers/staging/comedi/drivers/usbdux.c
index d611bd7..b98e91c 100644
--- a/drivers/staging/comedi/drivers/usbdux.c
+++ b/drivers/staging/comedi/drivers/usbdux.c
@@ -2370,7 +2370,7 @@ static int usbduxsub_probe(struct usb_interface *uinterf,
 	dev_dbg(dev, "comedi_: usbdux: "
 		"usbduxsub[%d] is ready to connect to comedi.\n", index);
 
-	sema_init(&(usbduxsub[index].sem)), 1;
+	sema_init(&(usbduxsub[index].sem), 1);
 	/* save a pointer to the usb device */
 	usbduxsub[index].usbdev = udev;
 
-- 
1.7.0.4

