From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 4/6] [ARM] ixp2000: fix type of ixp2000_timer_interrupt
Date: Fri,  7 Aug 2009 22:42:39 +0200
Message-ID: <1249677761-19470-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090807203939.GA19374@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Dmitry Baryshkov <dbaryshkov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933950AbZHGUnB@vger.kernel.org>
In-Reply-To: <20090807203939.GA19374@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This fixes a build warning for 2.6.31-rc5 (ARCH=3Darm, ixp2000_defconfi=
g):

	  CC      arch/arm/mach-ixp2000/core.o
	arch/arm/mach-ixp2000/core.c:217: warning: initialization from incompa=
tible pointer type

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 arch/arm/mach-ixp2000/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ixp2000/core.c b/arch/arm/mach-ixp2000/core.=
c
index babb225..e24e3d0 100644
--- a/arch/arm/mach-ixp2000/core.c
+++ b/arch/arm/mach-ixp2000/core.c
@@ -197,7 +197,7 @@ unsigned long ixp2000_gettimeoffset (void)
 	return offset / ticks_per_usec;
 }
=20
-static int ixp2000_timer_interrupt(int irq, void *dev_id)
+static irqreturn_t ixp2000_timer_interrupt(int irq, void *dev_id)
 {
 	/* clear timer 1 */
 	ixp2000_reg_wrb(IXP2000_T1_CLR, 1);
--=20
1.6.3.3
