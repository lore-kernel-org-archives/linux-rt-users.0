Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mta02.hs-regensburg.de ([194.95.104.12]:61686 "EHLO
        mta02.hs-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeH2Sdg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Aug 2018 14:33:36 -0400
From: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Subject: stable-rt: broken vmbus_drv.c
Message-ID: <60422715-88ee-2206-a038-f140780fdff6@oth-regensburg.de>
Date: Wed, 29 Aug 2018 16:28:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>

Hi,

latest stable 4.14.63-rt40 fails with CONFIG_HYPERV:

drivers/hv/vmbus_drv.c: In function ‘vmbus_isr’:
drivers/hv/vmbus_drv.c:969:25: error: implicit declaration of function
‘get_irq_regs’; did you mean ‘get_mm_rss’?
[-Werror=implicit-function-declaration]
  struct pt_regs *regs = get_irq_regs();
                         ^~~~~~~~~~~~
                         get_mm_rss
drivers/hv/vmbus_drv.c:969:25: warning: initialization of ‘struct
pt_regs *’ from ‘int’ makes pointer from integer without a cast
[-Wint-conversion]


Thomas' 5bef95248a270f68a1e448337b1d4c927cf8b0b2 in stable-rt ("random:
Make it work on rt") seems to break it. 4.14.59-rt37 compiles fine, so I
guess the include chain somehow changed upstream.

Simple fix below, include irq_regs.h.

  Ralf


diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index cedf225d4182..185647915077 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -38,6 +38,7 @@

 #include <asm/hyperv.h>
 #include <asm/hypervisor.h>
+#include <asm/irq_regs.h>
 #include <asm/mshyperv.h>
 #include <linux/notifier.h>
 #include <linux/ptrace.h>
