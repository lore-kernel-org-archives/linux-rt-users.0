From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/6] ucb1x00: include linux/semaphore.h
Date: Fri,  7 Aug 2009 22:42:36 +0200
Message-ID: <1249677761-19470-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090807203939.GA19374@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Kay Sievers <kay.sievers@vrfy.org>,
	Greg Kroah-Hartman <gregkh@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933923AbZHGUm4@vger.kernel.org>
In-Reply-To: <20090807203939.GA19374@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This fixes the following error:

	  CC      drivers/mfd/ucb1x00-core.o
	drivers/mfd/ucb1x00-core.c: In function 'ucb1x00_adc_enable':
	drivers/mfd/ucb1x00-core.c:138: error: implicit declaration of functio=
n 'down'
	drivers/mfd/ucb1x00-core.c: In function 'ucb1x00_adc_disable':
	drivers/mfd/ucb1x00-core.c:196: error: implicit declaration of functio=
n 'up'
	drivers/mfd/ucb1x00-core.c: In function 'ucb1x00_probe':
	drivers/mfd/ucb1x00-core.c:500: error: implicit declaration of functio=
n 'sema_init'

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
---
Hello,

should this better be converted to mutex_lock/mutex_unlock?

Best regards
Uwe
---
 drivers/mfd/ucb1x00-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index fea9085..3c59c26 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
+#include <linux/semaphore.h>
=20
 #include <mach/dma.h>
 #include <mach/hardware.h>
--=20
1.6.3.3
