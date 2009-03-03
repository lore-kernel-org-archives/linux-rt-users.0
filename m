Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41946 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbZCCAUg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Mar 2009 19:20:36 -0500
From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH ARM] add include to define mb() in bitops.h
Date: Tue,  3 Mar 2009 01:20:34 +0100
Message-Id: <1236039634-11954-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20090303001525.GA16807@pengutronix.de>
References: <20090303001525.GA16807@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.orglinux-rt-users@vger.kernel.org

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

---
 arch/arm/include/asm/bitops.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
index 63a481f..85926ed 100644
--- a/arch/arm/include/asm/bitops.h
+++ b/arch/arm/include/asm/bitops.h
@@ -25,6 +25,7 @@
 
 #include <linux/compiler.h>
 #include <asm/system.h>
+#include <asm/memory.h>
 
 #define smp_mb__before_clear_bit()	mb()
 #define smp_mb__after_clear_bit()	mb()
-- 
tg: (ff0b86d..) t/rt/arch_is_coherent_for_spinlock_h (depends on: rt-base)
