From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH RT 7/6] include linux/interrupt.h in mm/bounce.c
Date: Sun,  9 Aug 2009 11:36:38 +0200
Message-ID: <1249810600-21946-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090807203939.GA19374@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Jens Axboe <jens.axboe@oracle.com>,
	Ingo Molnar <mingo@elte.hu>, Li Zefan <lizf@cn.fujitsu.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
	linux-arm-kernel@lists.arm.linux.org.uk
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753611AbZHIJhI@vger.kernel.org>
In-Reply-To: <20090807203939.GA19374@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This fixes a a build failure for 2.6.31-rc4-rt1 (ARCH=3Darm,
mv78xx0_defconfig and others):

mm/bounce.c: In function 'bounce_copy_vec':
mm/bounce.c:52: error: implicit declaration of function 'local_irq_save=
_nort'
mm/bounce.c:56: error: implicit declaration of function 'local_irq_rest=
ore_nort'

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Jens Axboe <jens.axboe@oracle.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Li Zefan <lizf@cn.fujitsu.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk
---
 mm/bounce.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/mm/bounce.c b/mm/bounce.c
index 2fd099c..4a91eed 100644
--- a/mm/bounce.c
+++ b/mm/bounce.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/hash.h>
 #include <linux/highmem.h>
+#include <linux/interrupt.h>
 #include <asm/tlbflush.h>
=20
 #include <trace/events/block.h>
--=20
1.6.3.3
