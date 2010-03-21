From: Erik Sandbraaten <erik.sandbraaten@gmail.com>
Subject: [PATCH] 2.6.33.1-rt11 : Fix missing include in at91_mci.c
Date: Sun, 21 Mar 2010 23:09:02 +0100
Message-ID: <7dfa3d3b1003211509nef10515rb27b1a31b1eda80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: nicolas.ferre@atmel.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f211.google.com ([209.85.218.211]:42774 "EHLO
	mail-bw0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616Ab0CUWJF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 21 Mar 2010 18:09:05 -0400
Received: by bwz3 with SMTP id 3so4841406bwz.29
        for <linux-rt-users@vger.kernel.org>; Sun, 21 Mar 2010 15:09:02 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi.

When attempting to build the most recent kernel for my arm at91sam9G20
system, the build failed due to
missing function declarations concerning kmap_atomic() and friends.

The following patch fixed the build:

<PATCH START>
diff -uNr linux-2.6.33.1-vanilla/drivers/mmc/host/at91_mci.c
linux-2.6.33.1-new/drivers/mmc/host/at91_mci.c
--- linux-2.6.33.1-vanilla/drivers/mmc/host/at91_mci.c    2010-03-15
17:09:39.000000000 +0100
+++ linux-2.6.33.1-new/drivers/mmc/host/at91_mci.c    2010-03-21
22:24:06.889257314 +0100
@@ -65,6 +65,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/clk.h>
 #include <linux/atmel_pdc.h>
+#include <linux/highmem.h>

 #include <linux/mmc/host.h>
<PATCH END>


Best Regards.
