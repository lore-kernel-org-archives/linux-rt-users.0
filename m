From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH RT 8/6] [ARM, WATCHDOG] davinci: include mach/timex.h in davinci_wdt.c
Date: Sun,  9 Aug 2009 11:36:39 +0200
Message-ID: <1249810600-21946-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090807203939.GA19374@pengutronix.de>
 <1249810600-21946-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Kevin Hilman <khilman@deeprootsystems.com>,
	linux-arm-kernel@lists.arm.linux.org.uk
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753544AbZHIJhA@vger.kernel.org>
In-Reply-To: <1249810600-21946-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This fixes a a build failure for 2.6.31-rc4-rt1 (ARCH=3Darm,
davinci_all_defconfig):

	drivers/watchdog/davinci_wdt.c: In function 'wdt_enable':
	drivers/watchdog/davinci_wdt.c:102: error: 'CLOCK_TICK_RATE' undeclare=
d (first use in this function)
	drivers/watchdog/davinci_wdt.c:102: error: (Each undeclared identifier=
 is reported only once
	drivers/watchdog/davinci_wdt.c:102: error: for each function it appear=
s in.)

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk
---
 drivers/watchdog/davinci_wdt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_=
wdt.c
index 83e22e7..4a136d7 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -26,6 +26,8 @@
 #include <linux/io.h>
 #include <linux/device.h>
=20
+#include <mach/timex.h>
+
 #define MODULE_NAME "DAVINCI-WDT: "
=20
 #define DEFAULT_HEARTBEAT 60
--=20
1.6.3.3
